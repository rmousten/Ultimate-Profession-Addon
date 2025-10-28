
local ADDON, UPA = ...

local function MakeItemKey(itemID)
    return { itemID = itemID, itemLevel = 0, itemSuffix = 0, battlePetSpeciesID = 0 }
end

local function PriceFromAuctionatorById(itemID)
    if not itemID then return nil end

    if Auctionator and Auctionator.API and Auctionator.API.v1 then
        local API = Auctionator.API.v1
        if API.IsPriceDBReady and not API.IsPriceDBReady() then
            return nil
        end
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
        if API.GetAuctionPriceByItemID then
            local price = API.GetAuctionPriceByItemID("UltimateProfessionAddon", itemID)
            if type(price) == "number" and price > 0 then return price end
        end
    end

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
    if Auctionator and Auctionator.API and Auctionator.API.v1 then
        local API = Auctionator.API.v1
        if API.IsPriceDBReady and not API.IsPriceDBReady() then
            return nil
        end
    end
    if Atr_GetAuctionBuyout then
        local v = Atr_GetAuctionBuyout(itemName)
        if type(v) == "number" and v > 0 then return v end
    end
    return nil
end

UPA.price.providers = UPA.price.providers or {}
UPA.price.providers["Auctionator"] = {
    Name = "Auctionator",
    GetMatPriceById = function(itemId) return PriceFromAuctionatorById(itemId) end,
    GetMatPrice     = function(itemName) return PriceFromAuctionatorByName(itemName) end,
    GetRecipePrice  = function(recipeItemId) return PriceFromAuctionatorById(recipeItemId) end,
}
