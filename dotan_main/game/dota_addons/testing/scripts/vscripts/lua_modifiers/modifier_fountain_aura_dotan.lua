modifier_fountain_aura_dotan = class({})
LinkLuaModifier( "modifier_fountain_aura_dotan_buff", "lua_modifiers/modifier_fountain_aura_dotan", LUA_MODIFIER_MOTION_NONE )

function modifier_fountain_aura_dotan:IsHidden() return false end

function modifier_fountain_aura_dotan:IsPurgable() return false end

function modifier_fountain_aura_dotan:IsAura() return true end
function modifier_fountain_aura_dotan:IsAuraActiveOnDeath()	return false end
function modifier_fountain_aura_dotan:GetAuraRadius() return 500 end
function modifier_fountain_aura_dotan:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_fountain_aura_dotan:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_fountain_aura_dotan:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end
function modifier_fountain_aura_dotan:GetModifierAura() return "modifier_fountain_aura_dotan_buff" end

----------------------------------------------------------------------

modifier_fountain_aura_dotan_buff = class({})

function modifier_fountain_aura_dotan_buff:IsHidden() return false end

function modifier_fountain_aura_dotan_buff:IsDebuff() return false end

function modifier_fountain_aura_dotan_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
        MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
	}

	return funcs
end

function modifier_fountain_aura_dotan_buff:GetModifierHealthRegenPercentage() return 5 end

function modifier_fountain_aura_dotan_buff:GetModifierTotalPercentageManaRegen() return 6 end