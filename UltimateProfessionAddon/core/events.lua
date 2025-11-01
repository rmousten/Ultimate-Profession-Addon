---@diagnostic disable: undefined-global

local ADDON_NAME, UPA = ...

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("TRADE_SKILL_SHOW")
f:RegisterEvent("TRADE_SKILL_CLOSE")

local function IsFirstAidTrade()
    if not TradeSkillFrame or not TradeSkillFrame:IsShown() then return false end
    if GetTradeSkillLine then
        local name = (select(1, GetTradeSkillLine()))
        return name == "First Aid"
    end
    return false
end

f:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        -- init-time hooks if needed
    elseif event == "PLAYER_LOGIN" then
        if UPA.ui and UPA.ui.Init then UPA.ui:Init() end
        SLASH_UPA1 = "/upa"
        SlashCmdList["UPA"] = function()
            if UPA.ui and UPA.ui.ToggleResults then UPA.ui:ToggleResults() end
        end
    elseif event == "TRADE_SKILL_SHOW" then
        if UPA.ui and UPA.ui.EnsureProfButton then
            UPA.ui:EnsureProfButton(IsFirstAidTrade())
        end
    elseif event == "TRADE_SKILL_CLOSE" then
        if UPA.ui and UPA.ui.HideProfButton then UPA.ui:HideProfButton() end
    end
end)
