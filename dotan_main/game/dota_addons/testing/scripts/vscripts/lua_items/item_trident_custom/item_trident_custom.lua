item_trident_custom = class({})

LinkLuaModifier( "modifier_item_trident_custom", "lua_items/item_trident_custom/item_trident_custom.lua", LUA_MODIFIER_MOTION_NONE )

function item_trident_custom:GetIntrinsicModifierName()
    return "modifier_item_trident_custom"
end

----------------------------------------------------------------------------------------------------------------------------------

modifier_item_trident_custom = class({})

function modifier_item_trident_custom:IsDebuff() return false end
function modifier_item_trident_custom:IsHidden() return true end
function modifier_item_trident_custom:IsPurgable() return false end
function modifier_item_trident_custom:IsPurgeException() return false end
function modifier_item_trident_custom:RemoveOnDeath() return false end
function modifier_item_trident_custom:DestroyOnExpire() return false end

function modifier_item_trident_custom:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_STATUS_RESISTANCE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
    }
end


function modifier_item_trident_custom:GetModifierBonusStats_Strength()
    if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_strength")
end

function modifier_item_trident_custom:GetModifierBonusStats_Agility()
    if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_agility")
end

function modifier_item_trident_custom:GetModifierBonusStats_Intellect()
    if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_intellect")
end

function modifier_item_trident_custom:GetModifierStatusResistance()
    if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("status_resistance")
end

function modifier_item_trident_custom:GetModifierAttackSpeedBonus_Constant()
    if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

function modifier_item_trident_custom:GetModifierMoveSpeedBonus_Percentage()
    if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("movement_speed_percent_bonus")
end

function modifier_item_trident_custom:GetModifierHPRegenAmplify_Percentage()
    if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("hp_regen_amp")
end

function modifier_item_trident_custom:GetModifierMPRegenAmplify_Percentage()
    if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("mana_regen_multiplier")
end

function modifier_item_trident_custom:GetModifierSpellAmplify_Percentage()
    if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("spell_amp")
end

function modifier_item_trident_custom:GetModifierProcAttack_BonusDamage_Magical()
    if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("magic_damage_attack")
end
