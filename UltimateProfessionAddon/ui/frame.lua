
local ADDON, UPA = ...

UPA.ui = UPA.ui or {}

local function IsFirstAid()
    if not TradeSkillFrame or not TradeSkillFrame:IsShown() then return false end
    local name = GetTradeSkillLine and (select(1, GetTradeSkillLine())) or nil
    return name == "First Aid"
end

function UPA.ui:EnsureProfButton(enable)
    if not TradeSkillFrame then return end
    if not self.calcBtn then
        local b = CreateFrame("Button", "UPA_CalcButton", TradeSkillFrame, "UIPanelButtonTemplate")
        b:SetSize(100, 22)
        b:SetText("Calculate")
        b:SetPoint("BOTTOMRIGHT", TradeSkillFrame, "BOTTOMRIGHT", -14, 14)
        b:SetScript("OnClick", function() UPA.ui:OpenResults() end)
        self.calcBtn = b
    end
    if enable and IsFirstAid() then self.calcBtn:Show() else self.calcBtn:Hide() end
end

function UPA.ui:HideProfButton()
    if self.calcBtn then self.calcBtn:Hide() end
end

local function EnsureResultsFrame(self)
    if self.results then return end
    local f = CreateFrame("Frame", "UPA_ResultsFrame", UIParent, "BasicFrameTemplateWithInset")
    f:SetSize(480, 480)
    f:SetPoint("CENTER")
    f:Hide()

    f.title = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    f.title:SetPoint("TOP", 0, -8)
    f.title:SetText("Ultimate Profession Addon - First Aid Path")

    f.prof = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.prof:SetPoint("TOPLEFT", 12, -36)
    f.prof:SetText("Profession: First Aid")

    f.skillLbl = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.skillLbl:SetPoint("LEFT", f.prof, "RIGHT", 18, 0)
    f.skillLbl:SetText("Skill:")

    f.skillBox = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
    f.skillBox:SetSize(50, 22)
    f.skillBox:SetPoint("LEFT", f.skillLbl, "RIGHT", 6, 0)
    f.skillBox:SetAutoFocus(false); f.skillBox:SetNumeric(true); f.skillBox:SetNumber(1)

    f.targetLbl = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.targetLbl:SetPoint("LEFT", f.skillBox, "RIGHT", 10, 0)
    f.targetLbl:SetText("Target:")

    f.targetBox = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
    f.targetBox:SetSize(50, 22)
    f.targetBox:SetPoint("LEFT", f.targetLbl, "RIGHT", 6, 0)
    f.targetBox:SetAutoFocus(false); f.targetBox:SetNumeric(true); f.targetBox:SetNumber(300)

    f.runBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    f.runBtn:SetSize(100, 22)
    f.runBtn:SetPoint("LEFT", f.targetBox, "RIGHT", 12, 0)
    f.runBtn:SetText("Calculate")

    local scroll = CreateFrame("ScrollFrame", "UPA_Scroll", f, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 12, -68)
    scroll:SetPoint("BOTTOMRIGHT", -28, 48)
    local content = CreateFrame("Frame", nil, scroll)
    content:SetSize(420, 360)
    scroll:SetScrollChild(content)
    f.content = content

    f.totals = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    f.totals:SetPoint("BOTTOMLEFT", 12, 16)

    f.missing = f:CreateFontString(nil, "OVERLAY", "GameFontRed")
    f.missing:SetPoint("BOTTOMRIGHT", -16, 16)

    f.runBtn:SetScript("OnClick", function()
        local skill = tonumber(f.skillBox:GetText()) or 1
        local target = tonumber(f.targetBox:GetText()) or 300
        UPA.ui:RenderPath(f, skill, target)
    end)

    self.results = f
end

local function ClearChildren(frame)
    for _, child in ipairs({frame:GetChildren()}) do
        child:Hide(); child:SetParent(nil)
    end
end

function UPA.ui:RenderPath(f, skill, target)
    local data = UPA.calc:BuildPath("First Aid", skill, target)
    local c = f.content
    ClearChildren(c)
    local y = -4
    local lineHeight = 18

    local function money(copper) return UPA.util.CopperToString(math.floor(copper or 0)) end

    local function addText(txt, r,g,b)
        local fs = c:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        fs:SetPoint("TOPLEFT", 4, y)
        if r then fs:SetTextColor(r,g,b) end
        fs:SetText(txt)
        y = y - lineHeight
    end

    if not data or not data.steps or #data.steps == 0 then
        addText("No path found.", 1, 0.25, 0.25)
        f.totals:SetText("Totals: —")
        f.missing:SetText("")
        return
    end

    addText(string.format("From %d to %d (final about %d)", skill, data.target, data.finalSkill), 1, 0.82, 0)
    addText("")

    for _, step in ipairs(data.steps) do
        addText(string.format("%s x%d  [%d to %d]  (gain about %.1f)", step.name, step.crafts, step.from, step.to, step.expectedGain))
        addText(string.format("  Mats: %s  Learn: %s  Vendor: %s  |  Per-skill: %s",
            money(step.matCost), money(step.learnCost), money(step.vendorValue), money(step.perSkill)), 0.8,0.8,0.8)
        if step.anyMissingPrice then
            addText("  Missing price data for one or more materials. Open the Auction House to populate prices.", 1, 0.4, 0.4)
        end
    end

    addText("")
    f.totals:SetText(string.format("Totals  Mats: %s  Learn: %s  Vendor: %s  |  Net: %s",
        money(data.totals.mat), money(data.totals.learn), money(data.totals.vendor),
        money(data.totals.mat + data.totals.learn - data.totals.vendor)))

    if data.missingPrices then
        f.missing:SetText("Missing price data detected. Open the Auction House to refresh Auctionator prices.")
    else
        f.missing:SetText("")
    end
end

function UPA.ui:OpenResults()
    EnsureResultsFrame(self)
    local skill = 1
    if GetTradeSkillLine then
        local name, cur = GetTradeSkillLine()
        if name == "First Aid" and type(cur) == "number" then skill = cur end
    end
    self.results.skillBox:SetNumber(skill)
    self.results:Show()
end

function UPA.ui:ToggleResults()
    EnsureResultsFrame(self)
    if self.results:IsShown() then self.results:Hide() else self.results:Show() end
end

function UPA.ui:Init() end
