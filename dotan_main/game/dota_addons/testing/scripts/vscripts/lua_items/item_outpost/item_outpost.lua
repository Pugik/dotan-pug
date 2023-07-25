item_outpost = class({})

LinkLuaModifier("modifier_outpost", "lua_items/item_outpost/item_outpost", LUA_MODIFIER_MOTION_NONE)

function item_outpost:OnSpellStart()
    if not IsServer() then return end

    self.lifetime = self:GetSpecialValueFor( "lifetime" )

    local caster = self:GetCaster()
    local cursor_pos = self:GetCursorPosition()
    
    local ent_outpost = CreateUnitByName("npc_dotan_outpost", cursor_pos, true, caster, caster, caster:GetTeamNumber())
    ent_outpost:AddNewModifier(caster, self, "modifier_kill", {duration = self.lifetime})
    ent_outpost:AddNewModifier(caster, self, "modifier_outpost", nil)
    ent_outpost:SetForwardVector(RandomVector(1))
    
    ent_outpost:StartGesture(ACT_DOTA_IDLE)

    local caster_team = caster:GetTeamNumber()

    if caster_team == 1 then
        ent_outpost:SetMaterialGroup("1")
    end
    
    if caster_team == 3 then
        ent_outpost:SetMaterialGroup("2")
    end

    ent_outpost:EmitSound("Outpost.Captured")

    self:SpendCharge()
end
 
-----------------------------------------------------------

modifier_outpost = class({})

function modifier_outpost:IsHidden() return true end

function modifier_outpost:CheckState()
    local state = {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    }

    return state
end