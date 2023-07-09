item_courier = class({})
LinkLuaModifier( "modifier_item_courier", "lua_items/item_courier/item_courier", LUA_MODIFIER_MOTION_NONE )

function item_courier:OnSpellStart()
	if not IsServer() then return end
	
	local caster = self:GetCaster()
	local player = caster:GetPlayerOwner()
	local caster_lvl = caster:GetLevel()
	
	if caster:FindModifierByName("modifier_item_courier") then 
		return 
	end
	
	if caster ~= nil then
		local courier = player:SpawnCourierAtPosition(caster:GetAbsOrigin() + RandomVector( RandomFloat( 5, 10 )))
		caster:AddNewModifier(caster, nil, "modifier_item_courier", nil)
		caster:EmitSound("DOTA_Item.ClarityPotion.Activate")
		if caster_lvl >= 4 then
			courier:UpgradeCourier(caster_lvl)
		end
		self:Destroy()
	end
end

modifier_item_courier = class({})
--------------------------------------------------------------------------------

function modifier_item_courier:IsHidden() return true end
function modifier_item_courier:RemoveOnDeath() return false end
function modifier_item_courier:IsPurgable() return false end
