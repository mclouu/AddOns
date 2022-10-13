local mod	= DBM:NewMod(2491, "DBM-VaultoftheIncarnates", nil, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220908015041")
mod:SetCreatureID(184986)
mod:SetEncounterID(2605)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 390548 373678 382563 373487 373329 376326 374022 372456 375450 374691 374215 376669 374427 374430 374623 374624 374622 391019 391055 390796 390920 392125 392192 392152 391268",
	"SPELL_CAST_SUCCESS 374861",
	"SPELL_SUMMON 374935 374931 374939 374943",
	"SPELL_AURA_APPLIED 371971 374881 374916 374917 374918 372158 373487 374023 372458 372514 372517 374945 374380 374427 374573 391056 390921",
	"SPELL_AURA_APPLIED_DOSE 374881 374916 374917 374918 372158",
	"SPELL_AURA_REMOVED 371971 374881 374916 374917 374918 373487 373494 374023 372458 372514 374945 374380 374427 374573 390921",
	"SPELL_PERIODIC_DAMAGE 374554",
	"SPELL_PERIODIC_MISSED 374554",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify/fix staging
--TODO, does he summon all 4 elementals at 66 and 33, or an elemental based on current altar?
--TODO, does alter swapping reset base ability sunder strike?
--TODO, number of lighting crash icons verified on all difficulties (spell data says 3-default)
--TODO, also add a stack too high warning on https://www.wowhead.com/beta/spell=373535/lightning-crash when strategies and tuning are established
--TODO, See how things play out with WA/BW on handling some of this bosses mechanics, right now drycode is steering clear of computational/solving for things and sticking to just showing them
--TODO, is https://www.wowhead.com/beta/npc=190807/seismic-rupture tangible or invisible script bunny?
--TODO, is https://www.wowhead.com/beta/npc=190586/seismic-pillar tangible/in need of killing or no?
--TODO, GTFO https://www.wowhead.com/beta/spell=374705/seismic-rupture ?
--TODO, https://www.wowhead.com/beta/npc=190537/thunder-strike is probably another script bunny
--TODO, revisit thunder strike automation. May want to combine warnings to generalized warning instead of saying soak/avoid
--TODO, can https://www.wowhead.com/beta/spell=376063/flame-bolt be interrupted?
--TODO, target scan https://www.wowhead.com/beta/spell=374622/storm-front ?
--TODO, announce https://www.wowhead.com/beta/spell=391555/raging-inferno spawns on mythic? They spawn from Searing
--TODO, smart change checker for https://www.wowhead.com/beta/spell=391272/icy-tempest on mythic
--TODO, detect Granite Doppelboulder spawns on mythic Earth Alter
--TODO, is Sundering smash (391268) dodgable by tank? is it even aimed at tank?
--TODO, Blazing Fiend uses searing carnage on mythic?
--General
local warnPhase1								= mod:NewPhaseAnnounce(1, 2)

local specWarnGTFO								= mod:NewSpecialWarningGTFO(374554, nil, nil, nil, 1, 8)

--local berserkTimer							= mod:NewBerserkTimer(600)

--Stage One: Elemental Mastery
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25036))
local warnElementalShift						= mod:NewSpellAnnounce(374861, 3)
local warnSplinteredBones						= mod:NewStackAnnounce(372158, 2, nil, "Tank|Healer")

local specWarnSunderStrike						= mod:NewSpecialWarningDefensive(390548, nil, nil, nil, 1, 2)
local specWarnSplinteredBones					= mod:NewSpecialWarningTaunt(372158, nil, nil, nil, 1, 2)

local timerSunderStrikeCD						= mod:NewAITimer(35, 390548, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--mod:AddInfoFrameOption(361651, true)
mod:AddSetIconOption("SetIconOnLightningCrash", 373487, true, false, {1, 2, 3})
mod:AddNamePlateOption("NPAuraOnSurge", 371971, true)

mod:GroupSpells(390548, 372158)--Tank cast with tank debuff
--Fire Altar An altar of primal fire
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25040))
local warnBlisteringDominance					= mod:NewStackAnnounce(374881, 2)
local warnSearingCarnage						= mod:NewTargetNoFilterAnnounce(374022, 3)

local specWarnMagmaBurst						= mod:NewSpecialWarningDodge(382563, nil, nil, nil, 2, 2)
local specWarnMoltenRupture						= mod:NewSpecialWarningDodge(373329, nil, nil, nil, 2, 2)
local specWarnSearingCarnage					= mod:NewSpecialWarningYouPos(374022, nil, nil, nil, 1, 2)
local yellSearingCarnage						= mod:NewShortPosYell(374022)
local yellSearingCarnageFades					= mod:NewIconFadesYell(374022)

local timerMagmaBurstCD							= mod:NewAITimer(35, 382563, nil, nil, nil, 3)
local timerMoltenRuptureCD						= mod:NewAITimer(35, 373329, nil, nil, nil, 3)
local timerSearingCarnageCD						= mod:NewAITimer(35, 374022, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnSearing", 374022, true, false, {4, 5, 6})
--Frost Altar An altar of primal frost.
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25061))
local warnChillingDominance						= mod:NewStackAnnounce(374916, 2)
local warnBitingChill							= mod:NewCountAnnounce(373678, 2)
local warnBelowZero								= mod:NewTargetNoFilterAnnounce(372456, 3)
local warnFrostBite								= mod:NewFadesAnnounce(372514, 1)
local warnFrozenSolid							= mod:NewTargetNoFilterAnnounce(372517, 4, nil, false)--RL kinda thing

local specWarnFrigidOrbs						= mod:NewSpecialWarningDodge(391019, nil, nil, nil, 2, 2)
local specWarnBelowZero							= mod:NewSpecialWarningYouPos(372456, nil, nil, nil, 1, 2)
local yellBelowZero								= mod:NewShortPosYell(372456)
local yellBelowZeroFades						= mod:NewIconFadesYell(372456)

local timerFrigidOrbsCD							= mod:NewAITimer(35, 391019, nil, nil, nil, 3)
local timerBitingChillCD						= mod:NewAITimer(35, 373678, nil, nil, nil, 2)
local timerBelowZeroCD							= mod:NewAITimer(35, 372456, nil, nil, nil, 3)
local timerFrostBite							= mod:NewBuffFadesTimer(30, 372514, nil, false, nil, 5)

mod:AddSetIconOption("SetIconOnBelowZero", 372456, true, false, {4, 5})

mod:GroupSpells(372456, 372514, 372517)--Group all Below Zero mechanics together
--Earth Altar An altar of primal earth.
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25064))
local warnShatteringDominance					= mod:NewStackAnnounce(374917, 2)
local warnEnvelopingEarth						= mod:NewTargetNoFilterAnnounce(391055, 4, nil, "Healer")

local specWarnEnvelopingEarth					= mod:NewSpecialWarningYou(391055, nil, nil, nil, 1, 2)
local specWarnEruptingBedrock					= mod:NewSpecialWarningRun(390796, "Melee", nil, nil, 2, 2)
local specWarnSeismicRupture					= mod:NewSpecialWarningDodge(374691, nil, nil, nil, 2, 2)
local specWarnSunderingSmash					= mod:NewSpecialWarningSpell(391268, nil, nil, nil, 1, 2)--Granite Doppelboulder

local timerEnvelopingEarthCD					= mod:NewAITimer(35, 391055, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
local timerEruptingBedrockCD					= mod:NewAITimer(35, 390796, nil, nil, nil, 2)
local timerSeismicRuptureCD						= mod:NewAITimer(35, 374691, nil, nil, nil, 3)
local timerSunderingSmashCD						= mod:NewAITimer(35, 391268, nil, nil, nil, 3)--Granite Doppelboulder
--Storm Altar An altar of primal storm
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25068))
local warnThunderingDominance					= mod:NewStackAnnounce(374918, 2)
local warnLightningCrash						= mod:NewTargetNoFilterAnnounce(373487, 4)
local warnShockingBurst							= mod:NewTargetNoFilterAnnounce(390920, 3)

local specWarnLightningCrash					= mod:NewSpecialWarningYouPos(373487, nil, nil, nil, 1, 2)
local yellLightningCrash						= mod:NewShortPosYell(373487)
local yellLightningCrashFades					= mod:NewIconFadesYell(373487)
--local specWarnLightningCrashStacks			= mod:NewSpecialWarningStack(373535, nil, 8, nil, nil, 1, 6)
local specWarnShockingBurst						= mod:NewSpecialWarningMoveAway(390920, nil, nil, nil, 1, 2)
local yellShockingBurst							= mod:NewShortYell(390920)
local yellShockingBurstFades					= mod:NewShortFadesYell(390920)
local specWarnThunderStrike						= mod:NewSpecialWarningSoak(374215, nil, nil, nil, 2, 2)--No Debuff
local specWarnThunderStrikeBad					= mod:NewSpecialWarningDodge(374215, nil, nil, nil, 2, 2)--Debuff

local timerLightningCrashCD						= mod:NewAITimer(35, 373487, nil, nil, nil, 3)
local timerShockingBurstCD						= mod:NewAITimer(35, 390920, nil, nil, nil, 3)
local timerThunderStrikeCD						= mod:NewAITimer(35, 374215, nil, nil, nil, 5)

--mod:GroupSpells(373487, 373535)--Group Lighting crash source debuff with dest (nearest player) debuff
--Stage Two: Summoning Incarnates
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25071))
local warnPhase2								= mod:NewPhaseAnnounce(2, 2)

mod:AddNamePlateOption("NPAuraOnElementalBond", 374380, true)
----Tectonic Crusher
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25073))
local warnGroundShatter							= mod:NewTargetAnnounce(374427, 3)

local specWarnGroundShatter						= mod:NewSpecialWarningMoveAway(374427, nil, nil, nil, 1, 2)
local yellGroundShatter							= mod:NewShortYell(374427)
local yellGroundShatterFades					= mod:NewShortFadesYell(374427)
local specWarnViolentUpheavel					= mod:NewSpecialWarningDodge(374430, nil, nil, nil, 2, 2)

local timerGroundShatterCD						= mod:NewAITimer(35, 374427, nil, nil, nil, 3)
local timerViolentUpheavelCD					= mod:NewAITimer(35, 374430, nil, nil, nil, 3)

----Frozen Destroyer
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25076))
local specWarnFrostBinds						= mod:NewSpecialWarningInterrupt(374623, "HasInterrupt", nil, nil, 1, 2)

local specWarnFreezingTempest					= mod:NewSpecialWarningMoveTo(374624, nil, nil, nil, 3, 2)

local timerFreezingTempestCD					= mod:NewAITimer(35, 374624, nil, nil, nil, 2)

----Blazing Fiend
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25079))
local warnReingnite								= mod:NewTargetNoFilterAnnounce(374573, 3)

local timerReingnit								= mod:NewTargetTimer(20, 374573, nil, false, nil, 5)

mod:AddNamePlateOption("NPAuraOnReignite", 374573, true)
----Thundering Destroyer
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25083))
local warnStormFront							= mod:NewSpellAnnounce(374622, 3)

local timerStormFrontCD							= mod:NewAITimer(35, 374622, nil, nil, nil, 2)

mod:AddRangeFrameOption(10, 374620)

mod.vb.chillCast = 0
mod.vb.litCrashIcon = 1
mod.vb.searingIcon = 4--Change to 1 if it can't happen at same time as Biting Chill
mod.vb.zeroIcon = 4--Change to 1 if it cannot happen at saame time as Biting chill

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.chillCast = 0
	timerSunderStrikeCD:Start(1-delay)
	if self.Options.NPAuraOnSurge or self.Options.NPAuraOnElementalBond or self.Options.NPAuraOnReignite then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPAuraOnSurge or self.Options.NPAuraOnElementalBond or self.Options.NPAuraOnReignite then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 390548 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnSunderStrike:Show()
			specWarnSunderStrike:Play("defensive")
		end
		timerSunderStrikeCD:Start()
	elseif spellId == 373678 then
		self.vb.chillCast = self.vb.chillCast + 1
		warnBitingChill:Show(self.vb.chillCast)
		timerBitingChillCD:Start()
	elseif spellId == 382563 or spellId == 392125 then--Non Mythic, Mythic
		specWarnMagmaBurst:Show()
		specWarnMagmaBurst:Play("watchwave")
		timerMagmaBurstCD:Start()
	elseif spellId == 373487 then
		self.vb.litCrashIcon = 1
		timerLightningCrashCD:Start()
	elseif spellId == 373329 or spellId == 376326 then
		specWarnMoltenRupture:Show()
		specWarnMoltenRupture:Play("watchwave")
		timerMoltenRuptureCD:Start()
	elseif spellId == 374022 or spellId == 392192 or spellId == 392152 then--Normal/Heroic, LFR, Mythic (assumed)
		self.vb.searingIcon = 4
		timerSearingCarnageCD:Start()
	elseif spellId == 372456 or spellId == 375450 then--Hard, easy (assumed)
		self.vb.zeroIcon = 4
	elseif spellId == 374691 then
		specWarnSeismicRupture:Show()
		specWarnSeismicRupture:Play("watchstep")
		timerSeismicRuptureCD:Start()
	elseif spellId == 376669 or spellId == 374215 then--Hard, easy (assumed)
		if DBM:UnitDebuff("player", 373494) then--Vulnerable to nature damage
			specWarnThunderStrikeBad:Show()
			specWarnThunderStrikeBad:Play("watchstep")
		else
			specWarnThunderStrike:Show()
			specWarnThunderStrike:Play("helpsoak")
		end
		timerThunderStrikeCD:Start()
	elseif spellId == 374427 then
		timerGroundShatterCD:Start(nil, args.sourceGUID)
	elseif spellId == 374430 then
		specWarnViolentUpheavel:Show()
		specWarnViolentUpheavel:Play("watchstep")
		timerViolentUpheavelCD:Start(nil, args.sourceGUID)
	elseif spellId == 374623 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnFrostBinds:Show(args.sourceName)
		specWarnFrostBinds:Play("kickcast")
	elseif spellId == 374624 then
		specWarnFreezingTempest:Show(args.sourceName)
		specWarnFreezingTempest:Play("runin")
		timerFreezingTempestCD:Start(nil, args.sourceGUID)
	elseif spellId == 374622 then
		warnStormFront:Show()
		timerStormFrontCD:Start(nil, args.sourceGUID)
	elseif spellId == 391019 then
		specWarnFrigidOrbs:Show()
		specWarnFrigidOrbs:Play("watchorb")
		timerFrigidOrbsCD:Start()
	elseif spellId == 391055 then
		timerEnvelopingEarthCD:Start()
	elseif spellId == 390796 then
		specWarnEruptingBedrock:Show()
		specWarnEruptingBedrock:Play("justrun")
		timerEruptingBedrockCD:Start()
	elseif spellId == 391268 then
		timerSunderingSmashCD:Start(nil, args.sourceGUID)
		if self:IsTanking("player", nil, nil, nil, args.sourceGUID) then
			specWarnSunderingSmash:Show()
			specWarnSunderingSmash:Play("carefly")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 374861 and self:AntiSpam(5, 1) then--5 sec throttle so it doesn't spam as much when triggering an intentional wipe
		warnElementalShift:Show()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if args:IsSpellID(374935, 374931, 374939, 374943) then
		if spellId == 374935 then--Frozen Incarnation
			timerFreezingTempestCD:Start(1, args.destGUID)
		elseif spellId == 374931 then--Blazing Incarnation

		elseif spellId == 374939 then--Tectonic Incarnation
			timerGroundShatterCD:Start(1, args.destGUID)
			timerViolentUpheavelCD:Start(1, args.destGUID)
		elseif spellId == 374943 then--Thundering Incarnation
			timerStormFrontCD:Start(1, args.destGUID)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 371971 then
		if self.Options.NPAuraOnSurge then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 374881 then--BlisteringDominance
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnBlisteringDominance:Show(args.destName, amount)
		end
		--Likely not real phase change event, move me to right place later
		--timerMagmaBurstCD:Start(2)
		--timerMoltenRuptureCD:Start(2)
		--timerSearingCarnageCD:Start(2)
	elseif spellId == 374916 then--ChillingDominance
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnChillingDominance:Show(args.destName, amount)
		end
		--Not correct, temp placement
		--timerBelowZeroCD:Start(2)
		--timerFrigidOrbsCD:Start(2)
		--timerBitingChillCD:Start(2)
	elseif spellId == 374917 then--ShatteringDominance
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnShatteringDominance:Show(args.destName, amount)
		end
		--Not correct, temp placement
		--timerEnvelopingEarthCD:Start(2)
		--timerEruptingBedrockCD:Start(2)
		--timerSeismicRuptureCD:Start(2)
	elseif spellId == 374918 then--Thundering
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnThunderingDominance:Show(args.destName, amount)
		end
		--Not correct, temp placement
		--timerLightningCrashCD:Start(2)
		--timerThunderStrikeCD:Start(2)
	elseif spellId == 372158 and not args:IsPlayer() then
		local amount = args.amount or 1
		local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
		local remaining
		if expireTime then
			remaining = expireTime-GetTime()
		end
		if (not remaining or remaining and remaining < 6.1) and not UnitIsDeadOrGhost("player") then
			specWarnSplinteredBones:Show(args.destName)
			specWarnSplinteredBones:Play("tauntboss")
		else
			warnSplinteredBones:Show(args.destName, amount)
		end
	elseif spellId == 373487 then
		local icon = self.vb.litCrashIcon
		if self.Options.SetIconOnLightningCrash then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnLightningCrash:Show(self:IconNumToTexture(icon))
			specWarnLightningCrash:Play("mm"..icon)
			yellLightningCrash:Yell(icon, icon)
			yellLightningCrashFades:Countdown(spellId, nil, icon)
		end
		warnLightningCrash:CombinedShow(0.5, args.destName)
		self.vb.litCrashIcon = self.vb.litCrashIcon + 1
	elseif spellId == 374023 then
		local icon = self.vb.searingIcon
		if self.Options.SetIconOnSearing then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnSearingCarnage:Show(self:IconNumToTexture(icon))
			specWarnSearingCarnage:Play("mm"..icon)
			yellSearingCarnage:Yell(icon, icon - 3)
			yellSearingCarnageFades:Countdown(spellId, nil, icon)
		end
		warnSearingCarnage:CombinedShow(0.5, args.destName)
		self.vb.searingIcon = self.vb.searingIcon + 1
	elseif spellId == 372458 then
		local icon = self.vb.zeroIcon
		if self.Options.SetIconOnBelowZero then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnBelowZero:Show(self:IconNumToTexture(icon))
			specWarnBelowZero:Play("mm"..icon)
			yellBelowZero:Yell(icon, icon - 3)
			yellBelowZeroFades:Countdown(spellId, nil, icon)
		else
			warnBelowZero:CombinedShow(0.5, args.destName)
		end
		self.vb.zeroIcon = self.vb.zeroIcon + 1
	elseif spellId == 372514 and args:IsPlayer() then
		timerFrostBite:Start()
	elseif spellId == 372517 then
		warnFrozenSolid:CombinedShow(1, args.destName)
	elseif spellId == 374945 then--Primal Gains
		self:SetStage(2)
		warnPhase2:Show()
		--Base
		timerSunderStrikeCD:Stop()
		--Fire
		timerMagmaBurstCD:Stop()
		timerMoltenRuptureCD:Stop()
		timerSearingCarnageCD:Stop()
		--Ice
		timerBelowZeroCD:Stop()
		timerFrigidOrbsCD:Stop()
		timerBitingChillCD:Stop()
		--Earth
		timerEnvelopingEarthCD:Stop()
		timerEruptingBedrockCD:Stop()
		timerSeismicRuptureCD:Stop()
		--Lightning
		timerLightningCrashCD:Stop()
		timerThunderStrikeCD:Stop()
	elseif spellId == 374380 then
		if self.Options.NPAuraOnElementalBond then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 374427 then
		if args:IsPlayer() then
			specWarnGroundShatter:Show()
			specWarnGroundShatter:Play("runout")
			yellGroundShatter:Yell()
			yellGroundShatterFades:Countdown(spellId)
		end
		warnGroundShatter:CombinedShow(0.5, args.destName)
	elseif spellId == 374573 then
		warnReingnite:Show(args.destName)
		timerReingnit:Start(args.destName, args.destGUID)
		if self.Options.NPAuraOnReignite then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 20)
		end
	elseif spellId == 391056 then
		warnEnvelopingEarth:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnEnvelopingEarth:Show()
			specWarnEnvelopingEarth:Play("checkhp")
		end
	elseif spellId == 390921 then
		if args:IsPlayer() then
			specWarnShockingBurst:Show()
			specWarnShockingBurst:Play("runout")
			yellShockingBurst:Yell()
			yellShockingBurstFades:Countdown(spellId)
		end
		warnShockingBurst:CombinedShow(0.5, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 371971 then
		if self.Options.NPAuraOnSurge then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 374881 then--BlisteringDominance
		--Not correct, debuff desn't fall off, just temp placement until real phasing
		timerMagmaBurstCD:Stop()
		timerMoltenRuptureCD:Stop()
		timerSearingCarnageCD:Stop()
	elseif spellId == 374916 then--ChillingDominance
		--Not correct, debuff desn't fall off, just temp placement until real phasing
		timerBelowZeroCD:Stop()
		timerFrigidOrbsCD:Stop()
		timerBitingChillCD:Stop()
	elseif spellId == 374917 then--ShatteringDominance
		--Not correct, debuff desn't fall off, just temp placement until real phasing
		timerEnvelopingEarthCD:Stop()
		timerEruptingBedrockCD:Stop()
		timerSeismicRuptureCD:Stop()
	elseif spellId == 374918 then--Thundering
		--Not correct, debuff desn't fall off, just temp placement until real phasing
		timerLightningCrashCD:Stop()
		timerThunderStrikeCD:Stop()
	elseif spellId == 373487 then
--		if self.Options.SetIconOnLightningCrash then
--			self:SetIcon(args.destName, 0)
--		end
		if args:IsPlayer() then
			yellLightningCrashFades:Cancel()
		end
	elseif spellId == 373494 then--Icon removed off secondary debuff
		if self.Options.SetIconOnLightningCrash then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 374023 then
		if self.Options.SetIconOnSearing then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellSearingCarnageFades:Cancel()
		end
	elseif spellId == 372458 then
		if self.Options.SetIconOnBelowZero then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellBelowZeroFades:Cancel()
		end
	elseif spellId == 372514 and args:IsPlayer() then
		warnFrostBite:Show()
		timerFrostBite:Stop()
	elseif spellId == 374945 then--Primal Gains
		self:SetStage(1)
		warnPhase1:Show()
		--Base
		timerSunderStrikeCD:Start(3)
		--Fire
		--timerMagmaBurstCD:Start()
		--timerMoltenRuptureCD:Start()
		--timerSearingCarnageCD:Start()
		--Ice
		--timerBelowZeroCD:Start()
		--timerFrigidOrbsCD:Start()
		--timerBitingChillCD:Start()
		--Earth
		--timerEnvelopingEarthCD:Start()
		--timerEruptingBedrockCD:Start()
		--timerSeismicRuptureCD:Start()
		--Lightning
		--timerLightningCrashCD:Start()
		--timerThunderStrikeCD:Start()
	elseif spellId == 374380 then
		if self.Options.NPAuraOnElementalBond then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 374427 then
		if args:IsPlayer() then
			yellGroundShatterFades:Cancel()
		end
	elseif spellId == 374573 then
		timerReingnit:Stop(args.destName, args.destGUID)
		if self.Options.NPAuraOnReignite then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 390921 then
		if args:IsPlayer() then
			yellShockingBurstFades:Cancel()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 190688 then--Blazing Incarnation/Blazing Fiend

	elseif cid == 190686 then--Frozen Incarnation/Frozen Destroyer
		timerFreezingTempestCD:Stop(args.destGUID)
	elseif cid == 190588 then--Tectonic Incarnation/Tectonic Crusher
		timerGroundShatterCD:Stop(args.destGUID)
		timerViolentUpheavelCD:Stop(args.destGUID)
	elseif cid == 190690 then--Thundering Incarnation/Thundering tempest
		timerStormFrontCD:Stop(args.destGUID)
--	elseif cid == 190586 then--seismic-pillar

--	elseif cid == Granite Doppelboulder then--Granite Doppelboulder
		--timerSunderingSmashCD:Stop(args.destGUID)
	end
end


function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 374554 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]