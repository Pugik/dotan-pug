if IsInToolsMode() then
	START_GAME_AUTOMATICALLY = true	
	FORCE_HERO = "npc_dota_hero_antimage"
	GAMESETUP_TIME = 0
else
	START_GAME_AUTOMATICALLY = false
	GAMESETUP_TIME = 20
	FORCE_HERO = ""
end

ENABLE_HERO_RESPAWN = true              
ALLOW_SAME_HERO_SELECTION = false        
FREE_COURIER_ENABLED = false
HERO_SELECTION_TIME = 30             
HERO_STRATEGY_TIME = 30					
HERO_SHOWCASE_TIME = 15					
PRE_GAME_TIME = 30.0                    
POST_GAME_TIME = 120.0                   
RECOMMENDED_BUILDS_DISABLED = true     
DOTARUNE_LOGIC = false
TREE_REGROW_TIME = 30
SCAN_COOLDOWN = 999999
GLYPH_COOLDOWN = 999999
DAYNIGHT_ALLOW = false
FREETP_ONDEATH = false
PAUSE_ALLOW = false
BUYBACK_ALLOW = false
LOSE_GOLD_ONDEATH = false
ALLOW_NEUTRALITEM_DROPS = false
TPSLOT_ITEM = "item_bottle"
START_GOLD = 0
GOLD_TICKTIME = 999999
GOLD_PERTICK = 0
TIME_OF_DAY = 0.5
FOG_OF_WAR = false
HERO_MAX_LEVEL = 1
	
function brawl:LoadGameConfig()
	ListenToGameEvent( "npc_spawned", Dynamic_Wrap( brawl, "OnNPCSpawned" ), self )
	ListenToGameEvent( "entity_killed", Dynamic_Wrap( brawl, "OnEntityKilled" ), self )

	self._GameMode = GameRules:GetGameModeEntity()
	
	GameRules:GetGameModeEntity():SetCustomGameForceHero(FORCE_HERO)
	GameRules:GetGameModeEntity():SetFreeCourierModeEnabled( FREE_COURIER_ENABLED )
	GameRules:GetGameModeEntity():SetRecommendedItemsDisabled( RECOMMENDED_BUILDS_DISABLED )
	GameRules:GetGameModeEntity():SetUseDefaultDOTARuneSpawnLogic( DOTARUNE_LOGIC )
    GameRules:GetGameModeEntity():SetCustomScanCooldown(SCAN_COOLDOWN)
    GameRules:GetGameModeEntity():SetCustomGlyphCooldown(GLYPH_COOLDOWN)
	GameRules:GetGameModeEntity():SetDaynightCycleDisabled(DAYNIGHT_ALLOW)
	GameRules:GetGameModeEntity():SetGiveFreeTPOnDeath(FREETP_ONDEATH)
	GameRules:GetGameModeEntity():SetPauseEnabled(PAUSE_ALLOW)
	GameRules:GetGameModeEntity():SetBuybackEnabled(BUYBACK_ALLOW)
	GameRules:GetGameModeEntity():SetLoseGoldOnDeath(LOSE_GOLD_ONDEATH)
	GameRules:GetGameModeEntity():SetAllowNeutralItemDrops(ALLOW_NEUTRALITEM_DROPS)
	GameRules:GetGameModeEntity():SetTPScrollSlotItemOverride(TPSLOT_ITEM)
	GameRules:GetGameModeEntity():SetFogOfWarDisabled(FOG_OF_WAR)
	GameRules:GetGameModeEntity():SetCustomHeroMaxLevel(HERO_MAX_LEVEL)

	GameRules:SetTimeOfDay(TIME_OF_DAY)
	GameRules:SetStartingGold(START_GOLD)
	GameRules:SetGoldTickTime(GOLD_TICKTIME)
	GameRules:SetGoldPerTick(GOLD_PERTICK)
	GameRules:SetTreeRegrowTime(TREE_REGROW_TIME)
	GameRules:SetCustomGameSetupAutoLaunchDelay( GAMESETUP_TIME )
	GameRules:SetHeroRespawnEnabled( ENABLE_HERO_RESPAWN )
	GameRules:SetSameHeroSelectionEnabled( ALLOW_SAME_HERO_SELECTION )
	GameRules:SetHeroSelectionTime( HERO_SELECTION_TIME )
	GameRules:SetStrategyTime( HERO_STRATEGY_TIME )	
	GameRules:SetShowcaseTime( HERO_SHOWCASE_TIME )	
	GameRules:SetPreGameTime( PRE_GAME_TIME )
	GameRules:SetPostGameTime( POST_GAME_TIME )
end