if testgamemode == nil then
	testgamemode = class({})
	_G.testgamemode = testgamemode
end

-- input all libs and other lua files to here
require( "addon_game_config" )

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
	GameRules.AddonTemplate = testgamemode()
	GameRules.AddonTemplate:InitGameMode()
end

function testgamemode:InitGameMode()
	self:LoadGameConfig()

	print( "Init Loaded" )
end

-- Важная часть для выдачи курьеру новой способности, которая запрещает управлять и выбирать юнит.
-- Можешь адаптировать под свой код.
function testgamemode:OnNPCSpawned(keys)  -- Вызов функции из ивента игры в addon_game_config.lua (25 строка)
	local entity = EntIndexToHScript(keys.entindex) 	-- init entity
	
	if entity:GetUnitName() == "npc_dota_courier" and entity.bFirstSpawned == nil then		-- Если юнит - курьер, то заходим.
		entity.bFirstSpawned = true
		print("Выдаем модификатор.")
		entity:AddNewModifier(entity, entity, "modifier_courier_unmoveable", nil) -- Даем юниту модификатор, с кастомным скриптом из (scripts/vscripts/lua_abilities/npc/courier/courier_unmoveable.lua).
		local ab1 = entity:AddAbility("courier_unmoveable") -- Даем юниту эту способности для корректной работы. (scripts/vscripts/lua_abilities/npc/courier/courier_unmoveable.lua).
		ab1:SetHidden(true) -- Делает скилл невидимым в худе игрока.
	end
end