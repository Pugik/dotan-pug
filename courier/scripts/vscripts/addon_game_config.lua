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
FREE_COURIER_ENABLED = true
HERO_SELECTION_TIME = 30             
HERO_STRATEGY_TIME = 30					
HERO_SHOWCASE_TIME = 15					
PRE_GAME_TIME = 30.0                    
POST_GAME_TIME = 120.0                   
RECOMMENDED_BUILDS_DISABLED = true     
DOTARUNE_LOGIC = true
PAUSE_ALLOW = false
TIME_OF_DAY = 0.5
	
function testgamemode:LoadGameConfig()
	ListenToGameEvent( "npc_spawned", Dynamic_Wrap( testgamemode, "OnNPCSpawned" ), self )

	self._GameMode = GameRules:GetGameModeEntity()
	
	GameRules:GetGameModeEntity():SetCustomGameForceHero(FORCE_HERO)
	GameRules:GetGameModeEntity():SetFreeCourierModeEnabled( FREE_COURIER_ENABLED )
	GameRules:GetGameModeEntity():SetRecommendedItemsDisabled( RECOMMENDED_BUILDS_DISABLED )
	GameRules:GetGameModeEntity():SetUseDefaultDOTARuneSpawnLogic( DOTARUNE_LOGIC )
	GameRules:GetGameModeEntity():SetPauseEnabled(PAUSE_ALLOW)

	GameRules:SetTimeOfDay(TIME_OF_DAY)
	GameRules:SetCustomGameSetupAutoLaunchDelay( GAMESETUP_TIME )
	GameRules:SetHeroRespawnEnabled( ENABLE_HERO_RESPAWN )
	GameRules:SetSameHeroSelectionEnabled( ALLOW_SAME_HERO_SELECTION )
	GameRules:SetHeroSelectionTime( HERO_SELECTION_TIME )
	GameRules:SetStrategyTime( HERO_STRATEGY_TIME )	
	GameRules:SetShowcaseTime( HERO_SHOWCASE_TIME )	
	GameRules:SetPreGameTime( PRE_GAME_TIME )
	GameRules:SetPostGameTime( POST_GAME_TIME )
end