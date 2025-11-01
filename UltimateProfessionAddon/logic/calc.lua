local ADDON, UPA = ...

local P = { orange = 1.0, yellow = 0.5, green = 0.2, gray = 0.0 }
UPA.calc = UPA.calc or {}
UPA.calc.ExpectedSkillup = P

local function colorAt(skill, r)
    if skill < r.yellow then return "orange"
    elseif skill < r.green then return "yellow"
    elseif skill < r.gray then return "green"
    else return "gray" end
end

local function levelsUntilNextColor(skill, r)
    local c = colorAt(skill, r)
    if c == "orange" then return math.max(0, r.yellow - skill)
    elseif c == "yellow" then return math.max(0, r.green - skill)
    elseif c == "green" then return math.max(0, r.gray - skill) end
    return 0
end

local function matUnitPrice(recipe, provider)
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

function UPA.calc:ScoreRecipe(recipe, currentSkill, provider)
    local range = recipe.skillRange; if not range then return end
    if currentSkill < (range.orange or 0) then return end

    local clr = colorAt(currentSkill, range)
    local p = P[clr] or 0; if p <= 0 then return end

    local skillAvail = levelsUntilNextColor(currentSkill, range)
    if skillAvail <= 0 then skillAvail = 1 end

    local mat, missing = matUnitPrice(recipe, provider)
    local vendor = vendorValueCopper(recipe)
    local learn = learnCostCopper(recipe)

    -- Expected cost per skill (copper)
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
        perSkill = perSkillTotal,           -- float copper
        perSkillCopper = math.floor(perSkillTotal + 0.5), -- integer copper for UI
        anyMissingPrice = missing,
        recipe = recipe,
    }
end

function UPA.calc:BuildPath(profName, currentSkill, targetSkill)
    local prof = UPA.professions[profName]; if not prof then return nil, "Unknown profession" end
    targetSkill = targetSkill or 300
    local provider = UPA:GetPriceProvider()

    local path, totals = {}, { mat = 0, learn = 0, vendor = 0, score = 0 }
    local learnedOnce, missingAny, shopping = {}, false, {}

    local safety = 0
    while (currentSkill < targetSkill) and (safety < 500) do
        safety = safety + 1
        local best, bestRecipe
        for _, r in ipairs(prof.recipes) do
            local rng = r.skillRange
            if rng and currentSkill >= (rng.orange or 0) then
                local row = self:ScoreRecipe(r, currentSkill, provider)
                if row and ((not best) or (row.perSkill < best.perSkill)) then
                    best, bestRecipe = row, r
                end
            end
        end
        if not bestRecipe then break end

        local r = bestRecipe
        local p = best.p
        local deltaToNext = levelsUntilNextColor(currentSkill, r.skillRange)
        local remaining = targetSkill - currentSkill
        local goalDelta = (deltaToNext > 0) and math.min(deltaToNext, remaining) or remaining
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

        for name, qty in pairs(r.materials or {}) do
            local id = r.materialIds and r.materialIds[name] or nil
            local entry = shopping[name]
            if not entry then entry = { qty = 0, id = id }; shopping[name] = entry end
            entry.qty = entry.qty + (qty * crafts)
        end

        table.insert(path, {
            name = r.name,
            color = best.color,
            crafts = crafts,
            expectedGain = expectedGain,
            from = currentSkill,
            to = nextSkill,
            matCost = matCostTotal,
            learnCost = learn,
            vendorValue = vendorTotal,
            perSkill = best.perSkill,
            perSkillCopper = best.perSkillCopper,
            anyMissingPrice = missUnit,
            breakdown = { matUnit = matUnit, vendorUnit = vendorUnit, p = p },
        })

        totals.mat = totals.mat + matCostTotal
        totals.learn = totals.learn + learn
        totals.vendor = totals.vendor + vendorTotal
        totals.score = totals.score + (matCostTotal - vendorTotal + learn)

        currentSkill = nextSkill
    end

    -- attach unit prices to shopping
    local provider2 = UPA:GetPriceProvider()
    for name, info in pairs(shopping) do
        local unit
        if info.id and provider2.GetMatPriceById then unit = provider2.GetMatPriceById(info.id) end
        if not unit and provider2.GetMatPrice then unit = provider2.GetMatPrice(name) end
        info.unit = unit or 0
        info.total = (unit or 0) * info.qty
        if (unit or 0) == 0 then missingAny = true end
    end

    -- Safe price lookup that won't throw if provider API differs or is nil.
    local function SafeLookupPrice(provider, key)
        if not provider then return nil end
        -- common provider function names to try (both method and function styles)
        local tryNames = {"GetMatPrice", "GetRecipePrice", "GetMatPriceById", "GetPrice"}
        for _, fname in ipairs(tryNames) do
            local f = provider[fname]
            if type(f) == "function" then
                -- try as method (provider:Func(key))
                local ok, res = pcall(f, provider, key)
                if ok and type(res) == "number" and res > 0 then return res end
                -- try as plain function (Func(key))
                ok, res = pcall(f, key)
                if ok and type(res) == "number" and res > 0 then return res end
            end
        end
        return nil
    end

    local function AddFixedItemsToShopping(data)
        if not data then return end
        data.shopping = data.shopping or {}

        local provider = (UPA and UPA.GetPriceProvider) and UPA:GetPriceProvider()

        local fixed = {
            { name = "Expert First Aid - Under Wraps", qty = 1 },
            { name = "Manual: Heavy Silk Bandage",        qty = 1 },
            { name = "Manual: Mageweave Bandage",        qty = 1 },
        }

        for _, item in ipairs(fixed) do
            local unitPrice = SafeLookupPrice(provider, item.name) or 0

            local entry = data.shopping[item.name]
            if not entry then
                data.shopping[item.name] = {
                    qty = item.qty,
                    unit = unitPrice,
                    total = unitPrice * item.qty,
                }
            else
                entry.qty = (entry.qty or 0) + item.qty
                entry.unit = entry.unit or unitPrice
                entry.total = (entry.unit or 0) * entry.qty
            end
        end
    end

    AddFixedItemsToShopping(data)

    return { steps = path, totals = totals, finalSkill = currentSkill, target = targetSkill, missingPrices = missingAny, shopping = shopping }
end
