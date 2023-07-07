if brawl == nil then
	brawl = class({})
	_G.brawl = brawl
end

-- input all libs and other lua files to here
require( "lib/timers" ) -- спиздил логику таймера из бирбона.
require( "addon_game_config" ) -- addon_game_config.lua

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

function Activate()
	GameRules.AddonTemplate = brawl() 	-- do name
	GameRules.AddonTemplate:InitGameMode() 	-- just init
end


function brawl:OnNPCSpawned(keys)   -- Функция срабатывает при спавне энтити (любого) / Прослушка в addon_game_config.lua (39 строка)
	local entity = EntIndexToHScript(keys.entindex) 	-- init entity

	if entity:IsRealHero() then
		-- Что-то происходит с энтити или да.
    end
end

function brawl:OnEntityKilled(keys) -- Функция срабатывает при убийстве любого энтити / Прослушка в addon_game_config.lua (40 строка)
	local entity = EntIndexToHScript(keys.entindex_killed) 	-- dead entity
	local attacker = EntIndexToHScript(keys.entindex_attacker) 	-- attacker
	
	if entity:GetUnitName() == "npc_dota_boost_crate" then		-- если юнит называется как-то... то заходим.
		--да
	end

	if entity:IsHero() and entity:HasModifier("modifier_boost_stack") and attacker ~= nil then 	-- проверка, если у героя есть скилл.
		--да
	end
end
	
function brawl:InitGameMode() -- just init
	self:LoadGameConfig() -- Запускаем функцию в addon_game_config.lua


	if IsInToolsMode() then -- Создаёт бота.
		Tutorial:AddBot("npc_dota_hero_antimage", "", "", false)
	end

	print( "Init Loaded" )
end