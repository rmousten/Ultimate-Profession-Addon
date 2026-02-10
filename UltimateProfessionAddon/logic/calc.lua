local ADDON, UPA = ...

local P = { orange = 1.0, yellow = 0.5, green = 0.2, gray = 0.0 }
UPA.calc = UPA.calc or {}
UPA.calc.ExpectedSkillup = P

local function colorAt(skill, r)
    if not r then return "gray" end
    if skill < (r.yellow or math.huge) then return "orange"
    elseif skill < (r.green or math.huge) then return "yellow"
    elseif skill < (r.gray or math.huge) then return "green"
    else return "gray" end
end

local function levelsUntilNextColor(skill, r)
    if not r then return 0 end
    local c = colorAt(skill, r)
    if c == "orange" then return math.max(0, (r.yellow or skill) - skill)
    elseif c == "yellow" then return math.max(0, (r.green or skill) - skill)
    elseif c == "green" then return math.max(0, (r.gray or skill) - skill) end
    return 0
end

local function matUnitPrice(recipe, provider)
    local total, missing = 0, false
    for name, qty in pairs(recipe.materials or {}) do
        local unit = nil
        if provider and provider.GetMatPrice then
            pcall(function() unit = provider:GetMatPrice(name) end)
        end
        if not unit or unit == 0 then missing = true end
        total = total + ((unit or 0) * qty)
    end
    return total, missing
end

local function learnCostCopper(recipe, provider)
    if recipe.source == "Train" then
        return UPA.util.MoneyStringToCopper(recipe.trainingCost or "0c")
    elseif recipe.source == "Buy recipe" then
        local recipePrice = nil
        if provider then
            -- Prefer itemId if present, fallback to name
            if recipe.itemId and provider.GetMatPriceById then
                local ok, res = pcall(provider.GetMatPriceById, provider, recipe.itemId)
                if ok and type(res) == "number" and res > 0 then recipePrice = res end
            end
            if (not recipePrice or recipePrice == 0) and provider.GetMatPrice then
                local ok, res = pcall(provider.GetMatPrice, provider, recipe.name)
                if ok and type(res) == "number" and res > 0 then recipePrice = res end
            end
            if (not recipePrice or recipePrice == 0) and provider.GetRecipePrice then
                local ok, res = pcall(provider.GetRecipePrice, provider, recipe.name)
                if ok and type(res) == "number" and res > 0 then recipePrice = res end
            end
        end
        return recipePrice or 0
    end
    return 0
end

local function vendorValueCopper(recipe)
    return UPA.util.MoneyStringToCopper(recipe.vendorValue or "0c")
end

-- Safe price lookup for manuals/recipes.
local function SafeLookupPrice(provider, itemName, itemId)
    if not provider then return nil end

    if itemId and provider.GetMatPriceById then
        local ok, res = pcall(provider.GetMatPriceById, provider, itemId)
        if ok and type(res) == "number" and res > 0 then return res end
    end
    if itemName and provider.GetMatPrice then
        local ok, res = pcall(provider.GetMatPrice, provider, itemName)
        if ok and type(res) == "number" and res > 0 then return res end
    end
    if itemName and provider.GetRecipePrice then
        local ok, res = pcall(provider.GetRecipePrice, provider, itemName)
        if ok and type(res) == "number" and res > 0 then return res end
    end
    -- Try generic names if your provider exposes them
    if itemId and provider.GetPriceByItemID then
        local ok, res = pcall(provider.GetPriceByItemID, provider, itemId)
        if ok and type(res) == "number" and res > 0 then return res end
    end
    if itemName and provider.GetPriceByName then
        local ok, res = pcall(provider.GetPriceByName, provider, itemName)
        if ok and type(res) == "number" and res > 0 then return res end
    end

    return nil
end

local function AddFixedItemsToShopping(data)
    if not data then return end
    data.shopping = data.shopping or {}

    local provider = (UPA and UPA.GetPriceProvider) and UPA:GetPriceProvider()

    -- Classic IDs for manuals
    local fixed = {
        { name = "Expert First Aid - Under Wraps", qty = 1, id = 16112 },
        { name = "Manual: Heavy Silk Bandage",     qty = 1, id = 16113 },
        { name = "Manual: Mageweave Bandage",      qty = 1, id = 16084 },
    }

    for _, item in ipairs(fixed) do
        local unitPrice = SafeLookupPrice(provider, item.name, item.id) or 0
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

function UPA.calc:ScoreRecipe(recipe, currentSkill, provider)
    -- sanity
    if not recipe then return nil end
    local range = recipe.skillRange
    if not range then return nil end
    if currentSkill < (range.orange or 0) then return nil end

    local clr = colorAt(currentSkill, range)
    local p = P[clr] or 0
    if p <= 0 then return nil end

    local skillAvail = levelsUntilNextColor(currentSkill, range)
    if skillAvail <= 0 then skillAvail = 1 end

    local mat, missing = matUnitPrice(recipe, provider)
    local vendor = vendorValueCopper(recipe)
    local learn = learnCostCopper(recipe, provider)

    local effectiveMatCost = math.max(0, mat - vendor)
    local perSkillFromMats = effectiveMatCost / p
    local perSkillFromLearn = learn / skillAvail
    local perSkillTotal = perSkillFromMats + perSkillFromLearn

    return {
        name = recipe.name,
        skillRange = range,
        color = clr,
        probability = p,
        skillsAvailable = skillAvail,
        matCost = mat,
        vendorValue = vendor,
        learnCost = learn,
        perSkill = perSkillTotal,
        anyMissingPrice = missing or (recipe.source == "Buy recipe" and learn == 0)
    }
end

function UPA.calc:BuildPath(profName, currentSkill, targetSkill)
    local prof = UPA.professions and UPA.professions[profName]
    if not prof then
        return { steps = {}, totals = { mat = 0, learn = 0, vendor = 0 }, finalSkill = currentSkill, target = targetSkill or 300, missingPrices = true, shopping = {} }
    end

    targetSkill = targetSkill or 300
    local provider = UPA:GetPriceProvider()

    local path, totals = {}, { mat = 0, learn = 0, vendor = 0, score = 0 }
    local learnedOnce, missingAny, shopping = {}, false, {}

    -- Greedy selection by lowest per-skill cost
    while currentSkill < targetSkill do
        local best, bestScore = nil, math.huge
        for _, r in ipairs(prof.recipes or {}) do
            local s = self:ScoreRecipe(r, currentSkill, provider)
            if s and s.perSkill > 0 and s.perSkill < bestScore then
                bestScore, best = s.perSkill, s
            end
        end

        if not best then break end

        local learn = 0
        if not learnedOnce[best.name] then
            learnedOnce[best.name] = true
            learn = best.learnCost or 0
        end

        local from = currentSkill
        local craftsNeeded = math.ceil(best.skillsAvailable / best.probability)
        craftsNeeded = math.max(craftsNeeded, 1)
        local expectedGain = craftsNeeded * best.probability

        local step = {
            name = best.name,
            from = from,
            to = math.min(from + math.floor(expectedGain), targetSkill),
            crafts = craftsNeeded,
            expectedGain = expectedGain,
            matCost = best.matCost * craftsNeeded,
            vendorValue = best.vendorValue * craftsNeeded,
            learnCost = learn,
            perSkill = best.perSkill,
            anyMissingPrice = best.anyMissingPrice or false
        }

        table.insert(path, step)
        totals.mat = totals.mat + step.matCost
        totals.learn = totals.learn + step.learnCost
        totals.vendor = totals.vendor + step.vendorValue
        totals.score = totals.score + (step.matCost + step.learnCost - step.vendorValue)

        if step.anyMissingPrice then missingAny = true end

        -- add materials for shopping list
        local rec
        for _, r in ipairs(prof.recipes or {}) do
            if r.name == best.name then rec = r; break end
        end
        if rec then
            for mat, qty in pairs(rec.materials or {}) do
                shopping[mat] = shopping[mat] or { qty = 0 }
                shopping[mat].qty = shopping[mat].qty + (qty * craftsNeeded)
            end
        end

        currentSkill = step.to
    end

    -- attach unit prices to shopping
    for name, info in pairs(shopping) do
        local unit = nil
        if provider and provider.GetMatPrice then
            local ok, res = pcall(provider.GetMatPrice, provider, name)
            if ok and type(res) == "number" then unit = res end
        end
        info.unit = unit or 0
        info.total = (info.unit or 0) * (info.qty or 0)
        if (unit or 0) == 0 then missingAny = true end
    end

    -- Always add the manuals so the UI shows useful data even if steps are empty
    AddFixedItemsToShopping({ shopping = shopping })

    return {
        steps = path,
        totals = totals,
        finalSkill = currentSkill,
        target = targetSkill,
        missingPrices = missingAny,
        shopping = shopping
    }
end