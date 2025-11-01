local ADDON, UPA = ...

-- Helpers to generate an Auctionator ItemKey from itemID
local function MakeItemKey(itemID)
    -- Auctionator item key is a table: { itemID, itemLevel, itemSuffix, battlePetSpeciesID }
    -- For mats, itemLevel=0, itemSuffix=0, pet=0 is fine.
    return { itemID = itemID, itemLevel = 0, itemSuffix = 0, battlePetSpeciesID = 0 }
end

local function PriceFromAuctionatorById(itemID)
    if not itemID then return nil end

    -- Preferred modern API (if present)
    if Auctionator and Auctionator.API and Auctionator.API.v1 then
        local API = Auctionator.API.v1
        if API.GetAuctionPriceByItemKey then
            local key = MakeItemKey(itemID)
            local price = API.GetAuctionPriceByItemKey("UltimateProfessionAddon", key)
            if type(price) == "number" and price > 0 then return price end
        end
        if API.GetAuctionPriceByItemLink and C_Item and C_Item.GetItemLinkByID then
            local link = C_Item.GetItemLinkByID(itemID)
            if link then
                local price = API.GetAuctionPriceByItemLink("UltimateProfessionAddon", link)
                if type(price) == "number" and price > 0 then return price end
            end
        end
    end

    -- Older Classic Auctionator fallback (name based)
    if Atr_GetAuctionBuyout then
        local name = GetItemInfo(itemID)
        if name then
            local v = Atr_GetAuctionBuyout(name)
            if type(v) == "number" and v > 0 then return v end
        end
    end

    return nil
end
local function PriceFromAuctionatorByName(itemName)
    if not itemName then return nil end

    -- Modern API can still try via fake link search if needed, but usually not required.
    if Atr_GetAuctionBuyout then
        local v = Atr_GetAuctionBuyout(itemName)
        if type(v) == "number" and v > 0 then return v end
    end
    return nil
end

UPA.price.providers["Auctionator"] = {
    Name = "Auctionator",

    -- Prefer ID-based
    GetMatPriceById = function(itemId)
        return PriceFromAuctionatorById(itemId)
    end,

    -- Fallback for cases where you only have names
    GetMatPrice = function(itemName)
        return PriceFromAuctionatorByName(itemName)
    end,

    -- Reserved for later when you add recipeItemId
    GetRecipePrice = function(recipeItemId)
        if not recipeItemId then return nil end
        return PriceFromAuctionatorById(recipeItemId)
    end,
}