if brawl == nil then
	brawl = class({})
	_G.brawl = brawl
end

-- input all libs and other lua files to here
require( "lib/timers" )
require( "addon_game_config" )

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
	ALIVE_HEROES = 0
	
	GAME_ROUND = 1 -- номер текущего раунда
	MAX_ROUNDS = 999 -- номер конечного раунда
end

function Activate()
	GameRules.AddonTemplate = brawl() 	-- do name
	GameRules.AddonTemplate:InitGameMode() 	-- just init
end


function brawl:OnNPCSpawned(keys)   
	local entity = EntIndexToHScript(keys.entindex) 	-- init entity

	if entity:IsRealHero() then
		entity:AddNewModifier(entity, entity, "modifier_boost_stack", nil) 	-- add modifier
		entity:AddNewModifier(entity, entity, "modifier_wisp_info", nil)
		local ab1 = entity:AddAbility("boost_stack")
		local ab2 = entity:AddAbility("wisp_info")-- add that ability
		ab1:SetHidden(true) 	-- do invis
		ab2:SetHidden(true)

		ALIVE_HEROES = ALIVE_HEROES + 1

		print(ALIVE_HEROES)
    end

	if entity:IsRealHero() and entity.bFirstSpawned == nil then
		entity.bFirstSpawned = true 	-- ye is first spawn
		self:OnHeroInGame(entity) 	-- do function onheroingame
	end
end

function brawl:OnEntityKilled(keys)
	local entity = EntIndexToHScript(keys.entindex_killed) 	-- dead entity
	local attacker = EntIndexToHScript(keys.entindex_attacker) 	-- attacker
	
	if entity:GetUnitName() == "npc_dota_boost_crate" then		-- if death name is boost crate do
		--[[if attacker:IsRealHero() and attacker:HasModifier("modifier_boost_stack") then
			attacker:SetModifierStackCount("modifier_boost_stack", attacker, (attacker:GetModifierStackCount("modifier_boost_stack", attacker) + 1))
		end]]
		local newItem = CreateItem( "item_plboost", nil, nil )		-- create item prefab 
		newItem:SetPurchaseTime( 0 ) 	-- by it for free
		local drop = CreateItemOnPositionSync( entity:GetAbsOrigin(), newItem ) 	-- create in entity null position
		local dropTarget = entity:GetAbsOrigin() + RandomVector( RandomFloat( 100, 350 ) ) 	-- drop prefab from null position item in random vector 
		newItem:LaunchLoot( true, 300, 0.75, dropTarget ) 	-- do drop
	end

	if entity:IsHero() and entity:HasModifier("modifier_boost_stack") and attacker ~= nil then 	-- check if it hero and has custom modifier
		local max_drops = entity:GetModifierStackCount("modifier_boost_stack", entity) 	-- get stack count from modifier
		for i=1,max_drops do 	-- do loop momentos for drop count of item from max_drops
			local newItem = CreateItem( "item_plboost", nil, nil )	
			newItem:SetPurchaseTime( 0 )
			local drop = CreateItemOnPositionSync( entity:GetAbsOrigin(), newItem ) 
			local dropTarget = entity:GetAbsOrigin() + RandomVector( RandomFloat( 100, 350 ) ) 
			newItem:LaunchLoot( true, 300, 0.75, dropTarget )
		end
	end

	if entity:IsHero() then 	-- is hero? 
		entity:SetTimeUntilRespawn(99999) 	-- inf spawn on death
		entity:AddNewModifier(entity, entity, "modifier_death_info", nil)
		
		ALIVE_HEROES = ALIVE_HEROES - 1
		print(ALIVE_HEROES)
		
		if ALIVE_HEROES == 1 then
			self:EndBrawl()
		end
	end
end
	
function brawl:InitGameMode() -- just init
	self:LoadGameConfig() -- Do default config setuping


	if IsInToolsMode() then -- Test Dummy
		Tutorial:AddBot("npc_dota_hero_antimage", "", "", false)
	end

	if GetMapName() == "brawl_spring_solo" then 	-- Spawn Unit on Special Map
		local count_box = 75 -- is count
		for i=1,count_box do -- loop
			CreateUnitByName("npc_dota_boost_crate", RandomVector( RandomFloat( 500, 5000 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS) -- creating
		end
	end

	print( "Init Loaded" )	-- just console output
end

function brawl:OnHeroInGame(entity)
	entity:SetBaseMoveSpeed(entity:GetBaseMoveSpeed() * 1.25)
end

function brawl:StartBrawl()
	print("Round Started", GAME_ROUND)
end

function brawl:PrepareBrawl()
	print("Round Prepared")
	
	Timers:CreateTimer(10, function()
		self:StartBrawl()	
		local heroes = Entities:FindAllByClassname('npc_dota_fort')
		for k, v in pairs(heroes) do
			if v:IsHero() and v:HasModifier("modifier_death_info") then
				v:RemoveModifierByName("modifier_death_info")
				v:SetTimeUntilRespawn(0)
			end
		end
	end)
end

function brawl:EndBrawl()
	print("Round Ended")

	if MAX_ROUNDS == GAME_ROUND then
		print("Game Ended")
		return false
	end

	GAME_ROUND = GAME_ROUND + 1
	
	if MAX_ROUNDS ~= GAME_ROUND then
			
		ALIVE_HEROES = 0
			
		Timers:CreateTimer(5, function()
		self:PrepareBrawl()
				
		end)
	end
end