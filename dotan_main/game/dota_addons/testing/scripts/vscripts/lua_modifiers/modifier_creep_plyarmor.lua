modifier_creep_plyarmor = class({})
LinkLuaModifier( "modifier_creep_plyarmor_aura", "lua_modifiers/modifier_creep_plyarmor", LUA_MODIFIER_MOTION_NONE )

function modifier_creep_plyarmor:IsHidden() 
	return false 
end
function modifier_creep_plyarmor:IsPurgable() 
	return false 
end

function modifier_creep_plyarmor:GetTexture()
    return "modifier_creep_plyarmor"
 end

function modifier_creep_plyarmor:OnCreated()
    if not IsServer() then return end
	self.aura_radius = _G.modifier_creep_plyarmor_radius
end

function modifier_creep_plyarmor:OnRefresh()
	self:OnCreated()
end

function modifier_creep_plyarmor:IsAura() 					
	return true 
end
function modifier_creep_plyarmor:IsAuraActiveOnDeath()		
	return false 
end
function modifier_creep_plyarmor:GetAuraRadius()			
	return self.aura_radius 
end
function modifier_creep_plyarmor:GetAuraSearchFlags()		
	return DOTA_UNIT_TARGET_FLAG_NONE 
end
function modifier_creep_plyarmor:GetAuraSearchTeam()		
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY 
end
function modifier_creep_plyarmor:GetAuraSearchType()		
	return DOTA_UNIT_TARGET_HERO
end
function modifier_creep_plyarmor:GetModifierAura()			
	return "modifier_creep_plyarmor_aura" 
end

----------------------------------------------------------------------

modifier_creep_plyarmor_aura = class({})

function modifier_creep_plyarmor_aura:IsHidden()
	return false
end

function modifier_creep_plyarmor_aura:IsDebuff() 
	return false 
end

function modifier_creep_plyarmor_aura:GetTexture()
   return "modifier_creep_plyarmor"
end

function modifier_creep_plyarmor_aura:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}

	return funcs
end

function modifier_creep_plyarmor_aura:GetModifierPhysicalArmorBonusUnique()
	return 20
end

function modifier_creep_plyarmor_aura:GetModifierMagicalResistanceBonus() -- unique type isnt work? ddx
	return 20
end