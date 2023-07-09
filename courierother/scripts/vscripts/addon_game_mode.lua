function testgamemode:OnNPCSpawned(keys)
	local entity = EntIndexToHScript(keys.entindex)
	
	if entity:GetUnitName() == "npc_dota_courier" and entity.bFirstSpawned == nil then		-- Если юнит - курьер, то заходим.
		entity.bFirstSpawned = true
		print("Выдаем модификатор.")
		local ab1 = entity:AddAbility("courier_untouchable") -- Даем юниту эту способности, чтобы ему нельзя было давать команды. (scripts/vscripts/lua_abilities/npc/courier/courier_untouchable.lua).
		ab1:SetHidden(true) -- Делает скилл невидимым в худе игрока.
	end
end
