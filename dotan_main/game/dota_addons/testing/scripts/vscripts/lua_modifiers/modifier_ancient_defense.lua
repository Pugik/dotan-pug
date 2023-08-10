modifier_ancient_defense = class({})
LinkLuaModifier( "modifier_ancient_defense_effect", "lua_modifiers/modifier_ancient_defense", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_defense_effect_hero", "lua_modifiers/modifier_ancient_defense", LUA_MODIFIER_MOTION_NONE )

function modifier_ancient_defense:IsHidden() return true end

function modifier_ancient_defense:OnCreated(keys)
	if not IsServer() then return end
	
	self.ancient_defense_started = false
	self.ancient_hp_regen = self:GetParent():GetBaseHealthRegen()
end

function modifier_ancient_defense:OnIntervalThink()	
	if self.ancient_defense_started == false then return -1 end
	
	local friends = FindUnitsInRadius( 
		self:GetParent():GetTeam(), 
		self:GetParent():GetAbsOrigin(), 
		nil,
		999999, 
		DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
		DOTA_UNIT_TARGET_HERO, 
		DOTA_UNIT_TARGET_FLAG_NONE, 
		0, 
		false 
	)

	local defense_started = false

	for _,friend in pairs(friends) do
		if friend ~= nil and friend:FindModifierByName("modifier_ancient_defense_effect_hero") then	
			if defense_started == false then
				defense_started = true
			end
		end
	end
	
	if defense_started == true then
		if not self:GetParent():HasModifier("modifier_ancient_defense_effect") then
			self:GetParent():AddNewModifier(self:GetParent(), self, "modifier_ancient_defense_effect", nil)
		end
	end

	if defense_started == false then
		if self:GetParent():HasModifier("modifier_ancient_defense_effect") then
			self:GetParent():RemoveModifierByName("modifier_ancient_defense_effect")
		end
		self:GetParent():SetBaseHealthRegen(self.ancient_hp_regen)
		self.ancient_defense_started = false
	end
end

function modifier_ancient_defense:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED,
    }
    return funcs
end

function modifier_ancient_defense:OnAttackLanded(keys)
	local attacker = keys.attacker
	local target = keys.target
	local damage = keys.damage

	if target ~= self:GetParent() then return end

	if self:GetParent():GetHealth() < damage then
		local friends = FindUnitsInRadius( 
			self:GetParent():GetTeam(), 
			self:GetParent():GetAbsOrigin(), 
			nil,
			1000, 
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
			DOTA_UNIT_TARGET_HERO, 
			DOTA_UNIT_TARGET_FLAG_NONE, 
			0, 
			false 
		)

		if #friends > 0 then  
			self:GetParent():ModifyHealth(self:GetParent():GetHealth() + damage, self, false, 0)
			
			self:GetParent():SetBaseHealthRegen(0)
			
			if not self:GetParent():HasModifier("modifier_ancient_defense_effect") then
				self:GetParent():AddNewModifier(self:GetParent(), self, "modifier_ancient_defense_effect", nil)
			end

			self.ancient_defense_started = true
			self:StartIntervalThink(0.01)
		end
	end
end

function modifier_ancient_defense:IsAura() return true end
function modifier_ancient_defense:IsAuraActiveOnDeath() return false end
function modifier_ancient_defense:GetAuraRadius() return 1000 end
function modifier_ancient_defense:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_ancient_defense:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_ancient_defense:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end
function modifier_ancient_defense:GetModifierAura()	return "modifier_ancient_defense_effect_hero" end

-------------------------------------------------------------------------------------

modifier_ancient_defense_effect = class({})

function modifier_ancient_defense_effect:IsHidden() return false end
function modifier_ancient_defense_effect:IsPurgable() return false end
function modifier_ancient_defense_effect:IsDebuff() return false end
function modifier_ancient_defense_effect:GetTexture() return "modifier_ancient_defense" end

function modifier_ancient_defense_effect:CheckState()
    return {
        [MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true
    }
end

function modifier_ancient_defense_effect:OnCreated()
	local defense_effect_path = "particles/dotan/ancient_aura_sphere_good.vpcf"
	local defense_effect_ring_path = "particles/dotan/ancient_aura_ring_good.vpcf"

	if self:GetParent():GetTeamNumber() == 2 then
		defense_effect_path = "particles/dotan/ancient_aura_sphere_good.vpcf"
		defense_effect_ring_path = "particles/dotan/ancient_aura_ring_good.vpcf"
	end

	if self:GetParent():GetTeamNumber() == 3 then
		defense_effect_path = "particles/dotan/ancient_aura_sphere_bad.vpcf"
		defense_effect_ring_path = "particles/dotan/ancient_aura_ring_bad.vpcf"
	end

	self.defence_effect = ParticleManager:CreateParticle(defense_effect_path, PATTACH_ABSORIGIN, self:GetParent())
	ParticleManager:SetParticleControl(self.defence_effect, 1, Vector(1000, 0, 0))

	self.defence_effect_ring = ParticleManager:CreateParticle(defense_effect_ring_path, PATTACH_CENTER_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(self.defence_effect_ring, 1, Vector(1000, 0, 0))
end

function modifier_ancient_defense_effect:OnDestroy()
	ParticleManager:DestroyParticle(self.defence_effect, false)
	ParticleManager:ReleaseParticleIndex(self.defence_effect)
	ParticleManager:DestroyParticle(self.defence_effect_ring, false)
	ParticleManager:ReleaseParticleIndex(self.defence_effect_ring)
end

-------------------------------------------------------------------------------------

modifier_ancient_defense_effect_hero = class({})

function modifier_ancient_defense_effect_hero:IsHidden() return false end
function modifier_ancient_defense_effect_hero:IsPurgable() return false end
function modifier_ancient_defense_effect_hero:IsDebuff() return false end
function modifier_ancient_defense_effect_hero:GetTexture() return "modifier_ancient_defense" end