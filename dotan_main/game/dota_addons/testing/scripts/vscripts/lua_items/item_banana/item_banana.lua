item_banana = class({})

LinkLuaModifier( "modifier_item_banana", "lua_items/item_banana/item_banana.lua", LUA_MODIFIER_MOTION_NONE )

function item_banana:OnSpellStart()
    if IsServer() then
		self.peel_duration = self:GetSpecialValueFor( "peel_duration" )
        self.health = self:GetSpecialValueFor( "health" )
	end
	
	local caster = self:GetCaster()
	
    if caster ~= nil then
        caster:SetHealth(caster:GetHealth() + self.health)

        self.banana_peel = CreateUnitByName("npc_dotan_banana_peel", caster:GetAbsOrigin(), true, caster, caster:GetOwner(), caster:GetTeam())
        self.banana_peel:AddNewModifier(nil, nil, "modifier_kill", {duration = self.peel_duration})
        self.banana_peel:SetForwardVector(RandomVector(1))

		caster:EmitSound("DOTA_Item.Cheese.Activate")
	end
	
	self:SpendCharge()
end

----------------------------------------------------------------------------------------------------------------------------------
