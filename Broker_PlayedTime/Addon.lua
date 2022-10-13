--[[--------------------------------------------------------------------
	Broker_PlayedTime
	DataBroker plugin to track played time across all your characters.
	Copyright (c) 2010-2016 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info16711-BrokerPlayedTime.html
	https://mods.curse.com/addons/wow/broker-playedtime
	https://github.com/Phanx/Broker_PlayedTime
----------------------------------------------------------------------]]

local ADDON, L = ...

local floor, format, gsub, ipairs, pairs, sort, tinsert, type, wipe = floor, format, gsub, ipairs, pairs, sort, tinsert, type, wipe

local db, myDB
local timePlayed, timeUpdated = 0, 0
local sortedFactions, sortedPlayers, sortedRealms = { "Horde", "Alliance" }, {}, {}

local currentFaction = UnitFactionGroup("player")
local currentPlayer = UnitName("player")
local currentRealm = GetRealmName()

local factionIcons = {
	Alliance = [[|TInterface\BattlefieldFrame\Battleground-Alliance:16:16:0:0:32:32:4:26:4:27|t ]],
	Horde = [[|TInterface\BattlefieldFrame\Battleground-Horde:16:16:0:0:32:32:5:25:5:26|t ]],
}

local classIcons = {}
for class, t in pairs(CLASS_ICON_TCOORDS) do
	local offset, left, right, bottom, top = 0.025, unpack(t)
	classIcons[class] = format([[|TInterface\Glues\CharacterCreate\UI-CharacterCreate-Classes:14:14:0:0:256:256:%s:%s:%s:%s|t ]], (left + offset) * 256, (right - offset) * 256, (bottom + offset) * 256, (top - offset) * 256)
end

local CLASS_COLORS = { UNKNOWN = "|cffcccccc" }
for k, v in pairs(RAID_CLASS_COLORS) do
	CLASS_COLORS[k] = format("|cff%02x%02x%02x", v.r * 255, v.g * 255, v.b * 255)
end

------------------------------------------------------------------------

local FormatTime
do
	local DAY_ABBR, HOUR_ABBR, MIN_ABBR = gsub(DAY_ONELETTER_ABBR, "%%d%s*", ""), gsub(HOUR_ONELETTER_ABBR, "%%d%s*", ""), gsub(MINUTE_ONELETTER_ABBR, "%%d%s*", "")
	local DHM = format("|cffffffff%s|r|cffffcc00%s|r |cffffffff%s|r|cffffcc00%s|r |cffffffff%s|r|cffffcc00%s|r", "%d", DAY_ABBR, "%02d", HOUR_ABBR, "%02d", MIN_ABBR)
	local  DH = format("|cffffffff%s|r|cffffcc00%s|r |cffffffff%s|r|cffffcc00%s|r", "%d", DAY_ABBR, "%02d", HOUR_ABBR)
	local  HM = format("|cffffffff%s|r|cffffcc00%s|r |cffffffff%s|r|cffffcc00%s|r", "%d", HOUR_ABBR, "%02d", MIN_ABBR)
	local   H = format("|cffffffff%s|r|cffffcc00%s|r", "%d", HOUR_ABBR)
	local   M = format("|cffffffff%s|r|cffffcc00%s|r", "%d", MIN_ABBR)

	function FormatTime(t, noMinutes)
		if not t then return end

		local d, h, m = floor(t / 86400), floor((t % 86400) / 3600), floor((t % 3600) / 60)
		if d > 0 then
			return noMinutes and format(DH, d, h) or format(DHM, d, h, m)
		elseif h > 0 then
			return noMinutes and format(H, h) or format(HM, h, m)
		else
			return format(M, m)
		end
	end
end

------------------------------------------------------------------------

local BuildSortedLists
do
	local function SortPlayers(a, b)
		if a == currentPlayer then
			return true
		elseif b == currentPlayer then
			return false
		end
		return a < b
	end

	local function SortRealms(a, b)
		if a == currentRealm then
			return true
		elseif b == currentRealm then
			return false
		end
		return a < b
	end

	function BuildSortedLists()
		wipe(sortedRealms)
		for realm in pairs(db) do
			if type(db[realm]) == "table" and (realm == currentRealm or not db.onlyCurrentRealm) then
				tinsert(sortedRealms, realm)
				sortedPlayers[realm] = wipe(sortedPlayers[realm] or {})
				for faction in pairs(db[realm]) do
					sortedPlayers[realm][faction] = wipe(sortedPlayers[realm][faction] or {})
					for name in pairs(db[realm][faction]) do
						tinsert(sortedPlayers[realm][faction], name)
					end
					if realm == currentRealm and faction == currentFaction then
						sort(sortedPlayers[realm][faction], SortPlayers)
					else
						sort(sortedPlayers[realm][faction])
					end
				end
			end
		end
		sort(sortedRealms, SortRealms)
	end
end

------------------------------------------------------------------------

-- https://de.wowhead.com/guides/shadowlands-leveling-changes-level-squish
local squishTable = {
	 1, --   1

	 2, --   2
	 2, --   3
	 2, --   4

	 3, --   5
	 3, --   6
	 3, --   7

	 4, --   8
	 4, --   9

	 5, --  10
	 5, --  11

	 6, --  12
	 6, --  13

	 7, --  14
	 7, --  15

	 8, --  16
	 8, --  17

	 9, --  18
	 9, --  19

	10, --  20
	10, --  21
	10, --  22

	11, --  23
	11, --  24
	11, --  25

	12, --  26
	12, --  27
	12, --  28

	13, --  29
	13, --  30
	13, --  31

	14, --  32
	14, --  33
	14, --  34

	15, --  35
	15, --  36

	16, --  37
	16, --  38

	17, --  39
	17, --  40

	18, --  41
	18, --  42

	19, --  43
	19, --  44

	20, --  45
	20, --  46
	20, --  47

	21, --  48
	21, --  49
	21, --  50

	22, --  51
	22, --  52
	22, --  53

	23, --  54
	23, --  55
	23, --  56

	24, --  57
	24, --  58
	24, --  59

	25, --  60
	25, --  61
	25, --  62
	25, --  63

	26, --  64
	26, --  65
	26, --  66
	26, --  67

	27, --  68
	27, --  69
	27, --  70
	27, --  71

	28, --  72
	28, --  73
	28, --  74
	28, --  75

	29, --  76
	29, --  77
	29, --  78
	29, --  79

	30, --  80
	30, --  81

	31, --  82
	31, --  83

	32, --  84
	32, --  85

	33, --  86
	33, --  87

	34, --  88
	34, --  89

	35, --  90
	35, --  91

	36, --  92
	36, --  93

	37, --  94
	37, --  95

	38, --  96
	38, --  97

	39, --  98
	39, --  99

	40, -- 100
	40, -- 101

	41, -- 102
	41, -- 103

	42, -- 104
	42, -- 105

	43, -- 106
	43, -- 107

	44, -- 108
	44, -- 109

	45, -- 110
	45, -- 111

	46, -- 112
	46, -- 113

	47, -- 114
	47, -- 115

	48, -- 116
	48, -- 117

	49, -- 118
	49, -- 119

	50, -- 120
}



local function PerformLevelSquish()

	-- Only once for game clients after Shadowlands.
	if db.performedLevelSquish or select(4, GetBuildInfo()) < 90000 then return end

	for realm in pairs(db) do
		if type(db[realm]) == "table" then
			for faction in pairs(db[realm]) do
				for name in pairs(db[realm][faction]) do
					db[realm][faction][name].level = squishTable[db[realm][faction][name].level]
				end
			end
		end
	end

	db.performedLevelSquish = true

end
------------------------------------------------------------------------

local BrokerPlayedTime = CreateFrame("Frame")
BrokerPlayedTime:SetScript("OnEvent", function(self, event, ...) return self[event] and self[event](self, ...) or self:SaveTimePlayed() end)
BrokerPlayedTime:RegisterEvent("PLAYER_LOGIN")

function BrokerPlayedTime:PLAYER_LOGIN()
	local function copyTable(src, dst)
		if type(src) ~= "table" then return {} end
		if type(dst) ~= "table" then dst = {} end
		for k, v in pairs(src) do
			if type(v) == "table" then
				dst[k] = copyTable(v, dst[k])
			elseif type(v) ~= type(dst[k]) then
				dst[k] = v
			end
		end
		return dst
	end

	local defaults = {
		classIcons = false,
		factionIcons = false,
		levels = false,
		onlyCurrentRealm = false,
		[currentRealm] = {
			[currentFaction] = {
				[currentPlayer] = {
					class = (select(2, UnitClass("player"))),
					level = UnitLevel("player"),
					timePlayed = 0,
					timeUpdated = 0,
				},
			}
		}
	}

	BrokerPlayedTimeDB = BrokerPlayedTimeDB or {}
	db = copyTable(defaults, BrokerPlayedTimeDB)

	myDB = db[currentRealm][currentFaction][currentPlayer]


	PerformLevelSquish()


	BuildSortedLists()

	if CUSTOM_CLASS_COLORS then
		local function UpdateClassColors()
			for k, v in pairs(CUSTOM_CLASS_COLORS) do
				CLASS_COLORS[k] = format("|cff%02x%02x%02x", v.r * 255, v.g * 255, v.b * 255)
			end
		end
		UpdateClassColors()
		CUSTOM_CLASS_COLORS:RegisterCallback(UpdateClassColors)
	end

	self:UnregisterEvent("PLAYER_LOGIN")

	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterEvent("PLAYER_LOGOUT")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_UPDATE_RESTING")
	self:RegisterEvent("TIME_PLAYED_MSG")

	-- Needed for level boost (no PLAYER_LEVEL_UP event).
	myDB.level = UnitLevel("player")

	self:UpdateTimePlayed()
end

local requesting

local o = ChatFrame_DisplayTimePlayed
ChatFrame_DisplayTimePlayed = function(...)
	if requesting then
		requesting = false
		return
	end
	return o(...)
end

function BrokerPlayedTime:UpdateTimePlayed()
	requesting = true
	RequestTimePlayed()
end

function BrokerPlayedTime:SaveTimePlayed()
	local now = time()
	myDB.timePlayed = timePlayed + now - timeUpdated
	myDB.timeUpdated = now

	self:UpdateText()
	self:SetUpdateInterval(timePlayed < 3600)
end

function BrokerPlayedTime:PLAYER_LEVEL_UP(level)
	myDB.level = level or UnitLevel("player")
	self:SaveTimePlayed()
end

function BrokerPlayedTime:TIME_PLAYED_MSG(t)
	timePlayed = t
	timeUpdated = time()
	self:SaveTimePlayed()
end

------------------------------------------------------------------------

local BrokerPlayedTimeMenu = CreateFrame("Frame", "BrokerPlayedTimeMenu", nil, "UIDropDownMenuTemplate")
BrokerPlayedTimeMenu.displayMode = "MENU"
BrokerPlayedTimeMenu.info = {}

BrokerPlayedTimeMenu.GetClassIcons = function() return db.classIcons end
BrokerPlayedTimeMenu.SetClassIcons = function() db.classIcons = not db.classIcons end

BrokerPlayedTimeMenu.GetFactionIcons = function() return db.factionIcons end
BrokerPlayedTimeMenu.SetFactionIcons = function() db.factionIcons = not db.factionIcons end

BrokerPlayedTimeMenu.GetLevels = function() return db.levels end
BrokerPlayedTimeMenu.SetLevels = function() db.levels = not db.levels end

BrokerPlayedTimeMenu.GetHideOtherRealms = function() return db.onlyCurrentRealm end
BrokerPlayedTimeMenu.SetHideOtherRealms = function()
	db.onlyCurrentRealm = not db.onlyCurrentRealm
	BuildSortedLists()
end

BrokerPlayedTimeMenu.CloseDropDownMenus = function() CloseDropDownMenus() end

BrokerPlayedTimeMenu.RemoveCharacter = function(button)
	local value = button and button.value or UIDROPDOWNMENU_MENU_VALUE
	local realm, faction, name = string.split("#", value)
	if realm and faction and name and db[realm] and db[realm][faction] and db[realm][faction][name] then
		db[realm][faction][name] = nil

		local nf = 0
		for k in pairs(db[realm][faction]) do
			nf = nf + 1
		end
		if nf == 0 then
			db[realm][faction] = nil
		end

		local nr = 0
		for k in pairs(db[realm]) do
			nr = nr + 1
		end
		if nr == 0 then
			db[realm] = nil
			sortedRealms[realm] = nil
		end

		BuildSortedLists()
		CloseDropDownMenus()
	end
end

BrokerPlayedTimeMenu.initialize = function(self, level)
	if not level then return end
	local info = wipe(self.info)
	if level == 1 then
		info.text = L["Played Time"]
		info.isTitle = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
		wipe(self.info)

		info.text = " "
		info.disabled = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
		wipe(self.info)

		info.text = L["Character levels"]
		info.checked = self.GetLevels
		info.func = self.SetLevels
		info.keepShownOnClick = 1
		UIDropDownMenu_AddButton(info, level)
		wipe(self.info)

		info.text = L["Class icons"]
		info.checked = self.GetClassIcons
		info.func = self.SetClassIcons
		info.keepShownOnClick = 1
		UIDropDownMenu_AddButton(info, level)
		wipe(self.info)

		info.text = L["Faction icons"]
		info.keepShownOnClick = 1
		info.checked = self.GetFactionIcons
		info.func = self.SetFactionIcons
		UIDropDownMenu_AddButton(info, level)
		wipe(self.info)

		info.text = " "
		info.disabled = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
		wipe(self.info)

		info.text = L["Current realm only"]
		info.keepShownOnClick = 1
		info.checked = self.GetHideOtherRealms
		info.func = self.SetHideOtherRealms
		UIDropDownMenu_AddButton(info, level)
		wipe(self.info)

		info.text = " "
		info.disabled = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
		wipe(self.info)

		info.text = L["Remove character"]
		info.hasArrow = 1
		info.keepShownOnClick = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
		wipe(self.info)

		info.text = " "
		info.disabled = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
		wipe(self.info)

		info.text = CLOSE
		info.func = self.CloseDropDownMenus
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
	elseif level == 2 then
		for _, realm in ipairs(sortedRealms) do
			info.text = realm
			info.value = realm
			info.hasArrow = 1
			info.keepShownOnClick = 1
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)
		end
	elseif level == 3 then
		local factions = 0
		for i, faction in ipairs(sortedFactions) do
			info.value = nil
			info.colorCode = nil
			info.func = nil
			info.keepShownOnClick = nil

			local realm = UIDROPDOWNMENU_MENU_VALUE
			local rfp = sortedPlayers[realm][faction]

			if rfp then
				factions = factions + 1

				if factions > 1 then
					info.text = " "
					info.disabled = 1
					info.notCheckable = 1
					UIDropDownMenu_AddButton(info, level)
				end

				info.disabled = nil

				info.text = faction
				info.isTitle = 1
				UIDropDownMenu_AddButton(info, level)

				info.isTitle = nil

				for j, name in ipairs(rfp) do
					local cdata = db[realm][faction][name]

					info.text = name
					info.value = format("%s#%s#%s", realm, faction, name)
					info.colorCode = CLASS_COLORS[cdata and cdata.class or "UNKNOWN"]
					info.disabled = (name == currentPlayer and realm == currentRealm)
					info.func = self.RemoveCharacter
					UIDropDownMenu_AddButton(info, level)
				end
			end
		end
	end
end

------------------------------------------------------------------------

local function OnTooltipShow(tooltip)
	local total = 0
	tooltip:AddLine(L["Time Played"])
	for _, realm in ipairs(sortedRealms) do
		tooltip:AddLine(" ")
		if #sortedRealms > 1 then
			tooltip:AddLine(realm)
		end
		for _, faction in ipairs(sortedFactions) do
			local nfr = sortedPlayers[realm][faction]
			if nfr and #nfr > 0 then
				for _, name in ipairs(nfr) do
					local data = db[realm][faction][name]
					if data then
						local t
						if realm == currentRealm and name == currentPlayer then
							t = data.timePlayed + time() - data.timeUpdated
						else
							t = data.timePlayed
						end
						if t > 0 then
							if db.levels then
								tooltip:AddDoubleLine(format("%s%s%s%s (%s)|r", db.factionIcons and factionIcons[faction] or "", db.classIcons and classIcons[data.class] or "", CLASS_COLORS[data.class] or GRAY, name, data.level), FormatTime(t))
							else
								tooltip:AddDoubleLine(format("%s%s%s%s|r", db.factionIcons and factionIcons[faction] or "", db.classIcons and classIcons[data.class] or "", CLASS_COLORS[data.class] or GRAY, name), FormatTime(t))
							end
							total = total + t
						end
					end
				end
			end
		end
	end
	tooltip:AddLine(" ")
	tooltip:AddDoubleLine(L["Total"], FormatTime(total))
end

------------------------------------------------------------------------

BrokerPlayedTime.dataObject = LibStub("LibDataBroker-1.1"):NewDataObject(L["Time Played"], {
	type = "data source",
	icon = [[Interface\Icons\Spell_Nature_TimeStop]],
	text = UNKNOWN,
	OnTooltipShow = OnTooltipShow,
	OnClick = function(self, button)
		if button == "RightButton" then
			ToggleDropDownMenu(1, nil, BrokerPlayedTimeMenu, self, 0, 0, nil, nil, 15)
			if BrokerPlayedTimeMenu ~= UIDROPDOWNMENU_OPEN_MENU then
				self:GetScript("OnEnter")(self)
			end
		end
	end,
})

function BrokerPlayedTime:UpdateText()
	local t = myDB.timePlayed + time() - myDB.timeUpdated
	self.dataObject.text = FormatTime(t, t > 3600)
end

do
	local t
	local function UpdateText()
		BrokerPlayedTime:UpdateText()
		C_Timer.After(t, UpdateText)
	end
	function BrokerPlayedTime:SetUpdateInterval(fast)
		local o = t
		t = fast and 30 or 300
		if not o then
			C_Timer.After(t, UpdateText)
		end
	end
end

------------------------------------------------------------------------
