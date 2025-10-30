
local ADDON_NAME, UPA = ...

-- Namespace
UPA.addon = ADDON_NAME
UPA.professions = UPA.professions or {}
UPA.price = UPA.price or { providers = {} }
UPA.calc  = UPA.calc or {}
UPA.ui    = UPA.ui or {}
UPA.util  = UPA.util or {}

-- Saved variables
UPA_Saved = UPA_Saved or {
    priceSource = "Auctionator",  -- Auctionator only
    lastScan = 0,
}

-- Registration for profession datasets
function UPA:RegisterProfession(data)
    if type(data) == "table" and data.profession and data.recipes then
        UPA.professions[data.profession] = data
    end
end

-- Money helpers
function UPA.util.MoneyStringToCopper(s)
    if type(s) ~= "string" then return 0 end
    local g = tonumber(s:match("(%d+)g")) or 0
    local ss = tonumber(s:match("(%d+)s")) or 0
    local c = tonumber(s:match("(%d+)c")) or 0
    return g*10000 + ss*100 + c
end

function UPA.util.CopperToString(c)
    local g = math.floor(c / 10000); c = c % 10000
    local s = math.floor(c / 100);   c = c % 100
    return string.format("%02dg %02ds %02dc", g, s, c)
end

-- Price provider accessor
function UPA:GetPriceProvider()
    return UPA.price.providers[UPA_Saved.priceSource] or UPA.price.providers["Fallback"]
end
