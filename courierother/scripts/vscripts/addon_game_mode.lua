function testgamemode:OnNPCSpawned(keys)
	local entity = EntIndexToHScript(keys.entindex)
	
	if entity:GetUnitName() == "npc_dota_courier" and entity.bFirstSpawned == nil then		-- Если юнит - курьер, то заходим.
		entity.bFirstSpawned = true
		entity:AddNewModifier(entity, nil, "modifier_courier_untouchable", nil)
		print("Выдаем модификатор.")
	end
end
