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
function testgamemode:OnNPCSpawned(keys)
	local entity = EntIndexToHScript(keys.entindex)
	
	if entity:IsRealHero() and entity.bFirstSpawned == nil then
		entity.bFirstSpawned = true
	end
	
	if entity:GetUnitName() == "npc_dota_courier" and entity.bFirstSpawned == nil then		-- Если юнит - курьер, то заходим.
		entity.bFirstSpawned = true
		print("Выдаем модификатор.")
		local ab1 = entity:AddAbility("courier_untouchable") -- Даем юниту эту способности, чтобы ему нельзя было давать команды. (scripts/vscripts/lua_abilities/npc/courier/courier_untouchable.lua).
		ab1:SetHidden(true) -- Делает скилл невидимым в худе игрока.
	end
end

function testgamemode:OnEntityKilled(keys) -- один из примеров как можно сделать выпадение предметов из курьера.
	local ent_victim = EntIndexToHScript(keys.entindex_killed)
	local ent_attacker = EntIndexToHScript(keys.entindex_attacker)
	
	if ent_attacker:IsRealHero() and ent_victim:GetName() == "npc_dota_courier" then 
		local attacker_gold = ent_attacker:GetGold()
		local fine_courier = 600
		if attacker_gold >= fine_courier then -- смотрим сколько золота у убивца
			ent_attacker:SpendGold(fine_courier, DOTA_ModifyGold_PurchaseItem) -- забираем золото
			for i=0,8 do -- счет от нуля
				local item = ent_victim:GetItemInSlot(i)
				if item ~= nil then
					if item:GetName() ~= "item_ward_observer" and item:GetName() ~= "item_ward_sentry" and item:GetName() ~= "item_ward_dispenser" then -- убираем из выпадение варды, потому что они багаются ))
						print(item:GetName())
						local charges = item:GetCurrentCharges() -- получаем количество предмета.
						local cooldown = item:GetCooldown(1) -- получаем задержку активной способности предмета.
						
						local newItem = CreateItem( item:GetName(), nil, nil )		-- создаем префаб предмета
						newItem:SetPurchaseTime( 0 ) 	-- покупаем за БЕСПЛАТНО
						
						if charges and charges > 1 then -- проверка, если у предмета есть количество, добавляем на новый предмет.
							newItem:SetCurrentCharges(charges)
						end
						
						if cooldown and cooldown > 1 then -- проверка, если у предмета есть задержка активной способности, добавляем на новый предмет.
							newItem:StartCooldown(cooldown)
						end
						
						local drop = CreateItemOnPositionSync( ent_victim:GetAbsOrigin(), newItem ) 	-- создаем новый предмет в нулевой позиции игрока.
						local dropTarget = ent_victim:GetAbsOrigin() + RandomVector( RandomFloat( 50, 75 ) ) 	-- место, куда полетит предмет.
						newItem:LaunchLoot( false, 300, 0.75, dropTarget, nil ) -- запускаем предмет в небо.
						
						ent_victim:RemoveItem(item) -- удаляем предмет из инвентаря курьера.
					end
				end
			end
		end
	end
end

function testgamemode:InventoryItemAdded(keys)
	local hero = PlayerResource:GetSelectedHeroEntity(keys.inventory_player_id) -- Получаем героя из айди игрока.
	local item = EntIndexToHScript(keys.item_entindex) -- Получаем предмет.
	
	if item and hero then
		local owner = item:GetPurchaser() -- Получаем покупателя предмета.
		if owner and owner ~= hero and owner:GetTeamNumber() == hero:GetTeamNumber() then -- Проверки.
			item:SetPurchaser(hero) -- Задаем нового покупателя.
			item:SetOwner(hero) -- Задаем нового владельца
		end
	end
end
