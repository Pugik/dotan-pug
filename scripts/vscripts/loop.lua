-- in gamemode.lua 
function barebones:InitGameMode()
{
    GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 1 )
}

-- in addon_game_mode.lua

function barebones:OnThink()
    print('baj baj')
end