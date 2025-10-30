---@diagnostic disable: undefined-global
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
        b:SetSize(120, 26)
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
    f:SetSize(720, 640)
    f:SetPoint("CENTER")
    f:Hide()

    -- Make the frame movable and always on top
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetClampedToScreen(true)
    f:SetUserPlaced(true)
    f:SetToplevel(true)
    f:SetFrameStrata("FULLSCREEN_DIALOG")
    f:SetFrameLevel(200)

    -- Add a draggable header region (drag from the top like a normal window)
    local drag = CreateFrame("Frame", nil, f)
    drag:SetPoint("TOPLEFT", f, "TOPLEFT", 6, -6)
    drag:SetPoint("TOPRIGHT", f, "TOPRIGHT", -28, -6)
    drag:SetHeight(28)
    drag:EnableMouse(true)
    drag:RegisterForDrag("LeftButton")
    drag:SetScript("OnDragStart", function() f:StartMoving() end)
    drag:SetScript("OnDragStop", function() f:StopMovingOrSizing() end)

    local TitleFont  = "GameFontHighlightLarge"
    local HeaderFont = "GameFontHighlightLarge"
    local BodyFont   = "GameFontNormalLarge"

    f.title = f:CreateFontString(nil, "OVERLAY", TitleFont)
    f.title:SetPoint("TOP", 0, -8)
    f.title:SetText("Ultimate Profession Addon - First Aid Path")

    f.prof = f:CreateFontString(nil, "OVERLAY", HeaderFont)
    f.prof:SetPoint("TOPLEFT", 12, -36)
    f.prof:SetText("Profession: First Aid")

    f.skillLbl = f:CreateFontString(nil, "OVERLAY", HeaderFont)
    f.skillLbl:SetPoint("LEFT", f.prof, "RIGHT", 24, 0)
    f.skillLbl:SetText("Skill:")

    f.skillBox = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
    f.skillBox:SetSize(70, 26)
    f.skillBox:SetPoint("LEFT", f.skillLbl, "RIGHT", 8, 0)
    f.skillBox:SetAutoFocus(false)
    f.skillBox:SetNumeric(true)
    f.skillBox:SetNumber(1)

    f.targetLbl = f:CreateFontString(nil, "OVERLAY", HeaderFont)
    f.targetLbl:SetPoint("LEFT", f.skillBox, "RIGHT", 16, 0)
    f.targetLbl:SetText("Target:")

    f.targetBox = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
    f.targetBox:SetSize(70, 26)
    f.targetBox:SetPoint("LEFT", f.targetLbl, "RIGHT", 8, 0)
    f.targetBox:SetAutoFocus(false)
    f.targetBox:SetNumeric(true)
    f.targetBox:SetNumber(300)

    f.runBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    f.runBtn:SetSize(140, 26)
    f.runBtn:SetPoint("LEFT", f.targetBox, "RIGHT", 14, 0)
    f.runBtn:SetText("Calculate")

    f.pageLabel = f:CreateFontString(nil, "OVERLAY", HeaderFont)
    f.pageLabel:SetPoint("TOPRIGHT", -180, -72)
    f.prevBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    f.prevBtn:SetSize(100, 24); f.prevBtn:SetText("Previous")
    f.prevBtn:SetPoint("RIGHT", f.pageLabel, "LEFT", -8, 0)
    f.nextBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    f.nextBtn:SetSize(100, 24); f.nextBtn:SetText("Next")
    f.nextBtn:SetPoint("LEFT", f.pageLabel, "RIGHT", 8, 0)

    f.stepsPerPage = 5
    f.currentPage = 1

    local content = CreateFrame("Frame", nil, f)
    content:SetPoint("TOPLEFT", 12, -104)
    content:SetSize(690, 300)
    f.content = content

    local shopScroll = CreateFrame("ScrollFrame", "UPA_ShopScroll", f, "UIPanelScrollFrameTemplate")
    shopScroll:SetPoint("TOPLEFT", 12, -420)
    shopScroll:SetPoint("BOTTOMRIGHT", -28, 56)
    local shopContent = CreateFrame("Frame", nil, shopScroll)
    shopContent:SetSize(680, 160)
    shopScroll:SetScrollChild(shopContent)
    f.shopContent = shopContent

    f.stepLines = {}
    f.shopLines = {}

    f.totals = f:CreateFontString(nil, "OVERLAY", HeaderFont)
    f.totals:SetPoint("BOTTOMLEFT", 12, 20)

    f.missing = f:CreateFontString(nil, "OVERLAY", BodyFont)
    f.missing:SetPoint("BOTTOMRIGHT", -16, 20)

    f.runBtn:SetScript("OnClick", function()
        local skill = tonumber(f.skillBox:GetText()) or 1
        local target = tonumber(f.targetBox:GetText()) or 300
        UPA.ui:RenderPath(f, skill, target)
    end)

    f.prevBtn:SetScript("OnClick", function()
        if not f.data then return end
        if f.currentPage > 1 then f.currentPage = f.currentPage - 1 end
        UPA.ui:RenderStepsPage(f, f.currentPage)
    end)

    f.nextBtn:SetScript("OnClick", function()
        if not f.data then return end
        local pages = math.max(1, math.ceil(#(f.data.steps or {}) / f.stepsPerPage))
        if f.currentPage < pages then f.currentPage = f.currentPage + 1 end
        UPA.ui:RenderStepsPage(f, f.currentPage)
    end)

    self.results = f
end

local function WipeFontList(list)
    for i = 1, #list do
        local fs = list[i]
        if fs and fs.Hide then fs:Hide() end
        list[i] = nil
    end
end

local function NewLine(frame, list, font)
    local fs = frame:CreateFontString(nil, "OVERLAY", font or "GameFontNormalLarge")
    fs:SetJustifyH("LEFT")
    fs:SetWidth(660)
    fs:SetWordWrap(true)
    fs:SetNonSpaceWrap(true)
    table.insert(list, fs)
    return fs
end

local function Money(copper)
    return UPA.util.CopperToString(math.floor(copper or 0))
end

function UPA.ui:RenderStepsPage(f, page)
    local data = f.data; if not data then return end
    local steps = data.steps or {}

    WipeFontList(f.stepLines)

    local y = -4
    local lineH = 26

    local function addStep(text, font, r, g, b)
        local fs = NewLine(f.content, f.stepLines, font)
        fs:SetPoint("TOPLEFT", 4, y)
        if r then fs:SetTextColor(r, g, b) end
        fs:SetText(text)
        fs:Show()
        y = y - lineH
    end

    local totalSteps = #steps
    local pages = math.max(1, math.ceil(totalSteps / f.stepsPerPage))
    f.currentPage = math.max(1, math.min(page or 1, pages))
    f.pageLabel:SetText(string.format("From %d to %d | Page %d/%d", f.startSkill or 1, data.target, f.currentPage, pages))
    if f.currentPage <= 1 then f.prevBtn:Disable() else f.prevBtn:Enable() end
    if f.currentPage >= pages then f.nextBtn:Disable() else f.nextBtn:Enable() end

    local startIndex = (f.currentPage - 1) * f.stepsPerPage + 1
    local endIndex = math.min(totalSteps, startIndex + f.stepsPerPage - 1)

    -- ensure reminder tracking exists (kept for potential future use)
    f._remindersShown = f._remindersShown or {}

    -- thresholds to show reminders when a step crosses them
    local thresholds = {
        {level = 75,  text = "Reminder: Upgrade your First Aid profession to Journeyman (75)."},
        {level = 150, text = "Reminder: Upgrade your First Aid profession to Expert (150)."},
        {level = 225, text = "Reminder: Upgrade your First Aid profession to Artisan (225)."},
    }

    for i = startIndex, endIndex do
        local step = steps[i]
        if step then
            -- show any reminder that belongs to this step (crosses threshold)
            for _, thr in ipairs(thresholds) do
                local lvl = thr.level
                if (f.startSkill or 0) < lvl
                   and (data.target or 0) >= lvl
                   and (step.from or 0) < lvl
                   and (step.to or 0) >= lvl
                then
                    addStep(thr.text, "GameFontNormalLarge", 0.4, 0.8, 1)
                    f._remindersShown[lvl] = true
                end
            end

            if step.isReminder then
                addStep(step.name, "GameFontNormalLarge", 1, 0.82, 0)
            else
                addStep(string.format("%s x%d [%d to %d] (gain about %.1f)",
                    step.name, step.crafts, step.from, step.to, step.expectedGain))
                addStep(string.format(" Mats: %s Learn: %s Vendor: %s | Per-skill: %s",
                    Money(step.matCost), Money(step.learnCost), Money(step.vendorValue), Money(step.perSkill)),
                    "GameFontNormalLarge", 0.85, 0.85, 0.85)
                if step.anyMissingPrice then
                    addStep(" Missing price data for one or more materials. Open the Auction House to populate prices.",
                        "GameFontNormalLarge", 1, 0.4, 0.4)
                end
            end
        end
    end
end

function UPA.ui:RenderPath(f, skill, target)
    local data = UPA.calc:BuildPath("First Aid", skill, target)
    f.data = data
    f.startSkill = skill

    -- reset reminders when a new path is built
    f._remindersShown = {}

    if not data or not data.steps or #data.steps == 0 then
        WipeFontList(f.stepLines); f.pageLabel:SetText("")
        f.totals:SetText("Totals: —")
        f.missing:SetText("")
        WipeFontList(f.shopLines)
        return
    end

    f.currentPage = 1
    self:RenderStepsPage(f, 1)

    f.totals:SetText(string.format("Totals  Mats: %s  Learn: %s  Vendor: %s  |  Net: %s",
        Money(data.totals.mat), Money(data.totals.learn), Money(data.totals.vendor),
        Money(data.totals.mat + data.totals.learn - data.totals.vendor)))

    if data.missingPrices then
        f.missing:SetText("Missing price data detected. Open the Auction House to refresh Auctionator prices.")
    else
        f.missing:SetText("")
    end

    -- SHOPPING LIST UI
    WipeFontList(f.shopLines)
    local sy = -4
    local lineH2 = 24
    local function addShop(text, font, r, g, b)
        local fs = NewLine(f.shopContent, f.shopLines, font)
        fs:SetPoint("TOPLEFT", 4, sy)
        if r then fs:SetTextColor(r, g, b) end
        fs:SetText(text)
        fs:Show()
        sy = sy - lineH2
    end

    addShop("Shopping List (all materials):", "GameFontHighlightLarge", 1, 0.82, 0)

    -- Helper: try to get a per-unit price from Auctionator (defensive; adapt if your Auctionator version differs)
    local function GetAuctionPrice(itemName)
        if not itemName then return 0 end
        local price = nil

        -- Try common Auctionator entry points
        if Auctionator and Auctionator.API and type(Auctionator.API.GetPrice) == "function" then
            price = Auctionator.API.GetPrice(itemName)
        elseif Auctionator and Auctionator.API and type(Auctionator.API.GetAuctionPrice) == "function" then
            price = Auctionator.API.GetAuctionPrice(itemName)
        elseif Auctionator and Auctionator.Utilities and type(Auctionator.Utilities.GetPrice) == "function" then
            price = Auctionator.Utilities.GetPrice(itemName)
        elseif Auctionator and type(Auctionator.GetPrice) == "function" then
            price = Auctionator.GetPrice(itemName)
        end

        if type(price) == "table" then
            price = price.price or price.unitPrice or price.minPrice or price[1]
        end

        return tonumber(price) or 0
    end

    -- Build items list and try to populate missing unit/total from Auctionator
    local items = {}
    for name, info in pairs(data.shopping or {}) do
        info = info or {}
        info.qty = info.qty or 0
        info.unit = info.unit or 0
        info.total = info.total or ((info.qty or 0) * (info.unit or 0))

        if (info.unit or 0) == 0 then
            local unitPrice = GetAuctionPrice(name)
            if unitPrice and unitPrice > 0 then
                info.unit = unitPrice
                info.total = (info.qty or 0) * unitPrice
            end
        end

        table.insert(items, {name = name, info = info})
    end
    table.sort(items, function(a,b) return a.name < b.name end)

    local totalShop = 0
    for _, it in ipairs(items) do
        local name, info = it.name, it.info
        addShop(string.format("- %s x%d | Unit: %s Total: %s",
            name, info.qty, Money(info.unit), Money(info.total)))
        totalShop = totalShop + (info.total or 0)
        if (info.unit or 0) == 0 then
            addShop(" Missing price for this item. Open the Auction House to populate prices.", "GameFontNormalLarge", 1, 0.4, 0.4)
        end
    end

    addShop("")
    addShop(string.format("Shopping Total: %s", Money(totalShop)), "GameFontHighlightLarge", 0.9, 0.9, 0.9)
end

function UPA.ui:OpenResults()
    EnsureResultsFrame(self)
    local skill = 1
    if GetTradeSkillLine then
        local name, cur = GetTradeSkillLine()
        if name == "First Aid" and type(cur) == "number" then skill = cur end
    end
    self.results.skillBox:SetNumber(skill)

    -- ensure the frame is on top when shown
    self.results:SetToplevel(true)
    self.results:SetFrameStrata("FULLSCREEN_DIALOG")
    self.results:SetFrameLevel(200)

    self.results:Show()
end

function UPA.ui:ToggleResults()
    EnsureResultsFrame(self)
    if self.results:IsShown() then
        self.results:Hide()
    else
        -- raise before showing
        self.results:SetToplevel(true)
        self.results:SetFrameStrata("FULLSCREEN_DIALOG")
        self.results:SetFrameLevel(200)
        self.results:Show()
    end
end

function UPA.ui:Init() end