
local ADDON, UPA = ...

UPA.price.providers = UPA.price.providers or {}

-- Fallback provider if Auctionator isn't present (all nil/0)
UPA.price.providers["Fallback"] = {
    Name = "Fallback",
    GetMatPriceById = function(_) return nil end,
    GetMatPrice     = function(_) return nil end,
    GetRecipePrice  = function(_) return nil end,
}
