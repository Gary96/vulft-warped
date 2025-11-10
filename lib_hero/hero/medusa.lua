local hero_data = {
	"medusa",
	{2, 3, 2, 1, 2, 1, 2, 1, 1, 3, 4, 3, 3, 4, 7, 6, 4, 10, 12},
	{
		"item_clarity",
		"item_branches",
		"item_branches",
		"item_magic_stick",
		"item_ring_of_basilius",
		"item_null_talisman",
		"item_magic_wand",
		"item_power_treads",
		"item_gloves",
		"item_javelin",
		"item_maelstrom",
		"item_lesser_crit",
		"item_staff_of_wizardry",
		"item_ultimate_scepter",
		"item_diadem",
		"item_manta",
		"item_skadi",
		"item_mjollnir",
		"item_eagle",
		"item_butterfly",
		"item_ultimate_scepter_2",
		"item_greater_crit",
		"item_aghanims_shard",
		"item_black_king_bar",
		"item_moon_shard",
		"item_relic",
		"item_rapier",
		"item_rapier",
		"item_rapier",
		"item_rapier",
		"item_rapier",
		"item_rapier",
	},
	{ {1,1,1,1,3,}, {1,1,1,1,3,}, 0.1 },
	{
		"Split Shot","Mystic Snake","Mana Shield","Stone Gaze","+15% Mystic Snake Turn and Movement Speed Slow","+5% Stone Gaze Bonus Physical Damage","+10% Split Shot Damage Penalty","-3s Mystic Snake Cooldown","+2 Mystic Snake Bounces","+1.5s Stone Gaze Duration","+0.9 Mana Shield Damage per Mana","Split Shot Uses Modifiers",
	}
}
--@EndAutomatedHeroData
if GetGameState() <= GAME_STATE_STRATEGY_TIME then return hero_data end

local abilities = {
    [0] = {"medusa_split_shot", ABILITY_TYPE.PASSIVE}, -- Toggle para farm/pelea
    [1] = {"medusa_mystic_snake", ABILITY_TYPE.NUKE},  -- Harass y robo de mana
    [2] = {"medusa_gorgon_grasp", ABILITY_TYPE.NUKE},  -- ¡NUEVA habilidad activa! Daño físico y control.
    [5] = {"medusa_stone_gaze", ABILITY_TYPE.STUN},    -- Ultimate de control masivo
}

local ZEROED_VECTOR = ZEROED_VECTOR
local playerRadius = Set_GetEnemyHeroesInPlayerRadius
local ENCASED_IN_RECT = Set_GetEnemiesInRectangle
local currentTask = Task_GetCurrentTaskHandle
local GSI_AbilityCanBeCast = GSI_AbilityCanBeCast
local CROWDED_RATING = Set_GetCrowdedRatingToSetTypeAtLocation
local USE_ABILITY = UseAbility_RegisterAbilityUseAndLockToScore
local INCENTIVISE = Task_IncentiviseTask
local VEC_UNIT_DIRECTIONAL = Vector_UnitDirectionalPointToPoint
local VEC_UNIT_FACING_DIRECTIONAL = Vector_UnitDirectionalFacingDirection
local ACTIVITY_TYPE = ACTIVITY_TYPE
local currentActivityType = Blueprint_GetCurrentTaskActivityType
local currentTask = Task_GetCurrentTaskHandle
local HIGH_USE = AbilityLogic_HighUseAllowOffensive
local min = math.min

local fight_harass_handle = FightHarass_GetTaskHandle()
local push_handle = Push_GetTaskHandle()

local t_player_abilities = {}

local d
d = {
	["ReponseNeeds"] = function()
		return nil, REASPONSE_TYPE_DISPEL, nil, {RESPONSE_TYPE_KNOCKBACK, 4}
	end,
	["Initialize"] = function(gsiPlayer)
		AbilityLogic_CreatePlayerAbilitiesIndex(t_player_abilities, gsiPlayer, abilities)
		AbilityLogic_UpdateHighUseMana(gsiPlayer, t_player_abilities[gsiPlayer.nOnTeam])
		gsiPlayer.InformLevelUpSuccess = d.InformLevelUpSuccess
	end,
	["InformLevelUpSuccess"] = function(gsiPlayer)
		AbilityLogic_UpdateHighUseMana(gsiPlayer, t_player_abilities[gsiPlayer.nOnTeam])
		AbilityLogic_UpdatePlayerAbilitiesIndex(gsiPlayer, gsiPlayer.nOnTeam, abilities)
	end,
	["AbilityThink"] = function(gsiPlayer)
    local thisPlayer = gsiPlayer
    local playerLoc = thisPlayer.lastSeen.location
    local playerHP = thisPlayer.lastSeenHealth / thisPlayer.maxHealth
    local highUse = thisPlayer.highUseManaSimple

    -- Obtener habilidades
    local splitShot = gsiPlayer.hUnit:GetAbilityInSlot(0)
    local mysticSnake = gsiPlayer.hUnit:GetAbilityInSlot(1)
    local manaShield = gsiPlayer.hUnit:GetAbilityInSlot(2)
    local stoneGaze = gsiPlayer.hUnit:GetAbilityInSlot(5)

    -- Lógica para Mystic Snake
    if mysticSnake and not mysticSnake:IsNull() and mysticSnake:GetName() == "medusa_mystic_snake" then
        if AbilityLogic_AbilityCanBeCast(gsiPlayer, mysticSnake) and highUse then
            -- CORRECCIÓN: Usar Set_GetEnemyHeroesInPlayerRadius en lugar de Activity_GetClosestEnemyHeroInRange
            local enemies = Set_GetEnemyHeroesInPlayerRadius(gsiPlayer, mysticSnake:GetCastRange(), 5)
            if enemies and #enemies > 0 then
                -- Encontrar el enemigo con más mana (prioridad para Mystic Snake)
                local bestTarget = nil
                local highestMana = 0
                
                for _, enemy in pairs(enemies) do
                    local enemyMana = enemy.lastSeenMana or 0
                    if enemyMana > highestMana and enemyMana > 100 then
                        highestMana = enemyMana
                        bestTarget = enemy
                    end
                end
                
                if bestTarget then
                    USE_ABILITY(gsiPlayer, mysticSnake, bestTarget, 400, nil)
                    return
                end
            end
        end
    end

    -- Lógica para Stone Gaze (ultimate)
    if stoneGaze and not stoneGaze:IsNull() and stoneGaze:GetName() == "medusa_stone_gaze" then
        if AbilityLogic_AbilityCanBeCast(gsiPlayer, stoneGaze) then
            local enemies = Set_GetEnemyHeroesInPlayerRadius(gsiPlayer, stoneGaze:GetCastRange(), 3)
            if enemies and #enemies >= 2 then  -- Usar ultimate si hay 2+ enemigos cerca
                USE_ABILITY(gsiPlayer, stoneGaze, nil, 500, nil)
                return
            end
        end
    end

	-- Activar Split Shot cuando hay múltiples objetivos
	if splitShot and not splitShot:IsNull() then
		local enemiesNear = #Set_GetEnemyHeroesInPlayerRadius(gsiPlayer, 700, 3)
		local farmTarget = gsiPlayer.hUnit:GetAttackTarget()
		neartarget = gsiPlayer.hUnit:GetNearbyCreeps(900, false)
		for i=1,#neartarget do
			if neartarget == farmTarget and gsiPlayer.hUnit:HasScepter()
			then shouldSplitShotBeOn = true
			end
		end
		local shouldSplitShotBeOn = (enemiesNear >= 2 or currentActivityType(gsiPlayer) == ACTIVITY_TYPE.FARM)

		
		if shouldSplitShotBeOn and not splitShot:GetToggleState() then
			gsiPlayer.hUnit:Action_UseAbility(splitShot)
		elseif not shouldSplitShotBeOn and splitShot:GetToggleState() then
			gsiPlayer.hUnit:Action_UseAbility(splitShot)
		end
	end    
	-- Debug (opcional)
    -- print("SplitShot:", splitShot and splitShot:GetName() or "nil")
    -- print("MysticSnake:", mysticSnake and mysticSnake:GetName() or "nil") 
    -- print("StoneGaze:", stoneGaze and stoneGaze:GetName() or "nil")

    -- Lógica genérica de respaldo
    if AbilityLogic_PlaceholderGenericAbilityUse(gsiPlayer, t_player_abilities) then
        return
    end
end
}

local hero_access = function(key) return d[key] end

do
	HeroData_SetHeroData(hero_data, abilities, hero_access, true)
end
