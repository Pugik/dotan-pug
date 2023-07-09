item_courier = class({})
LinkLuaModifier( "modifier_item_courier", "lua_items/item_courier/item_courier", LUA_MODIFIER_MOTION_NONE )

function item_courier:OnSpellStart()
	if not IsServer() then return end
	
	local caster = self:GetCaster()
	local player = caster:GetPlayerOwner()
	
	if caster:FindModifierByName("modifier_item_courier") then 
		return 
	end
	
	if caster ~= nil then
		local courier = CreateUnitByName("npc_dota_courier", caster:GetAbsOrigin(), true, player, player, caster:GetTeamNumber())
		courier:SetControllableByPlayer(player:GetPlayerID(), true)
		caster:AddNewModifier(caster, self, "modifier_item_courier", nil)
		self:Destroy()
	end
end

modifier_item_courier = class({})
--------------------------------------------------------------------------------

function modifier_item_courier:IsHidden()
	return false
end
