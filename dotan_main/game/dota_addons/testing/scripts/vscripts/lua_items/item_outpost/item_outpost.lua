item_outpost = class({})

LinkLuaModifier("modifier_outpost", "lua_items/item_outpost/item_outpost", LUA_MODIFIER_MOTION_NONE)

function item_outpost:OnSpellStart()
    if not IsServer() then return end

    local caster = self:GetCaster()
    local cursor_pos = self:GetCursorPosition()
    
    local ent_outpost = CreateUnitByName("npc_dotan_outpost", cursor_pos, true, caster, caster, caster:GetTeamNumber())
    ent_outpost:AddNewModifier(caster, self, "modifier_outpost", {})
    ent_outpost:SetForwardVector(RandomVector(1))
    
    ent_outpost:StartGesture(ACT_DOTA_IDLE)

    local caster_team = caster:GetTeamNumber()

    if caster_team == 2 then
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
    return {
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true
    }
end

function modifier_outpost:DeclareFunctions() 
    return {
        MODIFIER_PROPERTY_HEALTHBAR_PIPS,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
    }
end

function modifier_outpost:GetModifierHealthBarPips() 
    return 10 
end

function modifier_outpost:GetModifierIncomingDamageConstant(keys)
    local damage = keys.damage

    if keys.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then return -damage end

    local damageintotal = damage - 10

    if damageintotal < 10 then
        damageintotal = damage
    end
    return -damageintotal
end