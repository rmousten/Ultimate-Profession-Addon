
local ADDON, UPA = ...

-- Expected skill-up per craft (tunable)
local P = { orange = 1.0, yellow = 0.5, green = 0.2, gray = 0.0 }
UPA.calc = UPA.calc or {}
UPA.calc.ExpectedSkillup = P

-- ---------- Helpers ----------
local function colorAt(skill, r)
    -- Color bands: [orange, yellow), [yellow, green), [green, gray), [gray, inf)
    if skill < r.yellow then
        return "orange"
    elseif skill < r.green then
        return "yellow"
    elseif skill < r.gray then
        return "green"
    else
        return "gray"
    end
end

local function levelsUntilNextColor(skill, r)
    local c = colorAt(skill, r)
    if c == "orange" then
        return math.max(0, r.yellow - skill)
    elseif c == "yellow" then
        return math.max(0, r.green - skill)
    elseif c == "green" then
        return math.max(0, r.gray - skill)
    end
    return 0
end

local function matUnitPrice(recipe, provider)
    -- returns total unit price across all mats per one craft and a flag if any price missing
    local total, missing = 0, false
    for name, qty in pairs(recipe.materials or {}) do
        local id = recipe.materialIds and recipe.materialIds[name] or nil
        local unit
        if id and provider.GetMatPriceById then unit = provider.GetMatPriceById(id) end
        if not unit and provider.GetMatPrice then unit = provider.GetMatPrice(name) end
        if not unit then missing = true; unit = 0 end
        total = total + (unit * qty)
    end
    return total, missing
end

local function learnCostCopper(recipe)
    if recipe.source == "Train" then
        return UPA.util.MoneyStringToCopper(recipe.trainingCost)
    end
    return 0
end

local function vendorValueCopper(recipe)
    return UPA.util.MoneyStringToCopper(recipe.vendorValue or "00g 00s 00c")
end

-- ---------- Scoring (expected COST per SKILL POINT) ----------
function UPA.calc:ScoreRecipe(recipe, currentSkill, provider)
    local range = recipe.skillRange
    if not range then return end

    -- Only consider a recipe once you've reached its orange threshold
    if currentSkill < (range.orange or 0) then return end

    local clr = colorAt(currentSkill, range)
    local p = P[clr] or 0
    if p <= 0 then return end -- gray or no progress → ignore

    local skillAvail = levelsUntilNextColor(currentSkill, range)
    if skillAvail <= 0 then skillAvail = 1 end -- avoid div by zero

    local mat, missing = matUnitPrice(recipe, provider)
    local vendor = vendorValueCopper(recipe)
    local learn = learnCostCopper(recipe)

    local effectiveMatCost = math.max(0, mat - vendor)
    local perSkillFromMats = effectiveMatCost / p
    local perSkillFromLearn = learn / skillAvail
    local perSkillTotal = perSkillFromMats + perSkillFromLearn

    return {
        name = recipe.name,
        color = clr,
        p = p,
        skillAvail = skillAvail,
        matCost = mat,
        vendorVal = vendor,
        learnCost = learn,
        perSkill = perSkillTotal,
        anyMissingPrice = missing,
        recipe = recipe,
    }
end

-- ---------- Path Builder + Shopping List ----------
function UPA.calc:BuildPath(profName, currentSkill, targetSkill)
    local prof = UPA.professions[profName]
    if not prof then return nil, "Unknown profession" end

    targetSkill = targetSkill or 300
    local provider = UPA:GetPriceProvider()
    local path, totals = {}, { mat = 0, learn = 0, vendor = 0, score = 0 }
    local learnedOnce = {}
    local missingAny = false
    local shopping = {}  -- aggregate mats { [itemName] = {qty=..., id=..., unit=..., total=...} }

    local safety = 0
    while (currentSkill < targetSkill) and (safety < 500) do
        safety = safety + 1

        -- Pick best recipe at current skill (only those with orange threshold reached)
        local best, bestRecipe
        for _, r in ipairs(prof.recipes) do
            local rng = r.skillRange
            if rng and currentSkill >= (rng.orange or 0) then
                local row = self:ScoreRecipe(r, currentSkill, provider)
                if row then
                    if (not best) or (row.perSkill < best.perSkill) then
                        best, bestRecipe = row, r
                    end
                end
            end
        end

        if not bestRecipe then break end

        local r = bestRecipe
        local clr = best.color
        local p = best.p

        local deltaToNextColor = levelsUntilNextColor(currentSkill, r.skillRange)
        local remaining = targetSkill - currentSkill
        local goalDelta = (deltaToNextColor > 0) and math.min(deltaToNextColor, remaining) or remaining
        if goalDelta <= 0 then goalDelta = remaining end
        local crafts = math.max(1, math.ceil(goalDelta / p))

        local matUnit, missUnit = matUnitPrice(r, provider)
        local vendorUnit = vendorValueCopper(r)
        local learn = 0
        if not learnedOnce[r.name] then learnedOnce[r.name] = true; learn = learnCostCopper(r) end

        local matCostTotal = matUnit * crafts
        local vendorTotal  = vendorUnit * crafts
        local expectedGain = p * crafts
        local nextSkill = math.min(targetSkill, currentSkill + expectedGain)

        if missUnit then missingAny = true end

        -- Shopping list accumulation
        for name, qty in pairs(r.materials or {}) do
            local id = r.materialIds and r.materialIds[name] or nil
            local entry = shopping[name]
            if not entry then entry = { qty = 0, id = id }; shopping[name] = entry end
            entry.qty = entry.qty + (qty * crafts)
        end

        table.insert(path, {
            name = r.name,
            color = clr,
            crafts = crafts,
            expectedGain = expectedGain,
            from = currentSkill,
            to = nextSkill,
            matCost = matCostTotal,
            learnCost = learn,
            vendorValue = vendorTotal,
            perSkill = best.perSkill,
            anyMissingPrice = missUnit,
            breakdown = { matUnit = matUnit, vendorUnit = vendorUnit, p = p },
        })

        totals.mat    = totals.mat    + matCostTotal
        totals.learn  = totals.learn  + learn
        totals.vendor = totals.vendor + vendorTotal
        totals.score  = totals.score  + (matCostTotal - vendorTotal + learn)

        currentSkill = nextSkill
    end

    -- Attach unit prices to shopping list (for convenience)
    local provider = UPA:GetPriceProvider()
    for name, info in pairs(shopping) do
        local unit
        if info.id and provider.GetMatPriceById then unit = provider.GetMatPriceById(info.id) end
        if not unit and provider.GetMatPrice then unit = provider.GetMatPrice(name) end
        info.unit = unit or 0
        info.total = (unit or 0) * info.qty
        if (unit or 0) == 0 then missingAny = true end
    end

    return {
        steps = path,
        totals = totals,
        finalSkill = currentSkill,
        target = targetSkill,
        missingPrices = missingAny,
        shopping = shopping,
    }
end
