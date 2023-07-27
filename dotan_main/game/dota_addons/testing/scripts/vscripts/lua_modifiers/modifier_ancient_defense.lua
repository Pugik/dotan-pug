modifier_ancient_defense = class({})
LinkLuaModifier( "modifier_ancient_defense_bonus", "lua_modifiers/modifier_ancient_defense", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_defense_effect", "lua_modifiers/modifier_ancient_defense", LUA_MODIFIER_MOTION_NONE )

function modifier_ancient_defense:IsHidden() 
	return false 
end

function modifier_ancient_defense:IsPurgable() 
	return false 
end

function modifier_ancient_defense:IsDebuff() 
	return false 
end

function modifier_ancient_defense:GetTexture()
    return "modifier_ancient_defense"
end

function modifier_ancient_defense:OnCreated(keys)
	if not IsServer() then return end

	self:StartIntervalThink(0.1)
end

function modifier_ancient_defense:OnIntervalThink()
	local friends = FindUnitsInRadius( 
		self:GetParent():GetTeam(), 
		self:GetParent():GetOrigin(), 
		target,
		2250, 
		DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
		DOTA_UNIT_TARGET_HERO, 
		DOTA_UNIT_TARGET_FLAG_NO_INVIS, 
		0, 
		false 
	)

	if #friends > 0 then
		for _,friend in pairs(friends) do
			if friend ~= nil and not friend:FindModifierByName("modifier_fountain_aura_buff") then
				if self:GetParent():GetHealth() <= 500 then
					self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_ancient_defense_effect", nil)
				end
			end
		end
	end

	if self:GetParent():GetHealth() > 500 then
		if self:GetParent():FindModifierByName("modifier_ancient_defense_effect") then
			self:GetParent():RemoveModifierByName("modifier_ancient_defense_effect")
		end
	end
end -- oh yeeee if if ifi fifi eneneenednendne end

function modifier_ancient_defense:OnAttackLanded(keys)
	local attacker = keys.attacker
	local target = keys.target
	local damage = keys.damage

	if self:GetParent():GetHealth() > 500 then return end
	if self:GetParent():GetHealth() > damage then return end

	local friends = FindUnitsInRadius( 
		self:GetParent():GetTeam(), 
		self:GetParent():GetOrigin(), 
		target,
		2250, 
		DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
		DOTA_UNIT_TARGET_HERO, 
		DOTA_UNIT_TARGET_FLAG_NO_INVIS, 
		0, 
		false 
	)

	if #friends > 0 then
		for _,friend in pairs(friends) do
			if friend ~= nil and not friend:FindModifierByName("modifier_fountain_aura_buff") then
				local ancient_hp = self:GetParent():GetHealth()
				local addinghp = ancient_hp + damage
				self:GetParent():ModifyHealth(addinghp, self, false, 0)

				self:PlayEffects( friend )

				friend:AddNewModifier(friend, nil, "modifier_ancient_defense_bonus", {duration = 5})
			end
		end
	end

end

function modifier_ancient_defense:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}

	return funcs
end

function modifier_ancient_defense:PlayEffects( friend )
	local particle_cast = "particles/units/heroes/hero_tiny/tiny_tree_channel_tree_arc.vpcf"
	
	local entity = self:GetParent()
	local direction = (entity:GetOrigin() - friend:GetOrigin()):Normalized()
	
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, entity )
	local attach = "attach_attack1"
	if entity:ScriptLookupAttachment( "attach_attack2" ) ~= 0 then attach = "attach_attack2" end
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		entity,
		PATTACH_POINT_FOLLOW,
		attach,
		Vector(0,0,0), 
		true 
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		friend,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), 
		true 
	)
	ParticleManager:SetParticleControl( effect_cast, 2, friend:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 3, friend:GetOrigin() + direction )
	ParticleManager:SetParticleControlForward( effect_cast, 3, -direction )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-------------------------------------------------------------------------------------

modifier_ancient_defense_effect = class({})

function modifier_ancient_defense_effect:IsHidden()
	return true
end

function modifier_ancient_defense_effect:GetEffectName()
    return "particles/dev/library/base_overhead_follow.vpcf"
end

function modifier_ancient_defense_effect:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

-------------------------------------------------------------------------------------

modifier_ancient_defense_bonus = class({})

function modifier_ancient_defense_bonus:IsHidden()
	return false
end

function modifier_ancient_defense_bonus:IsDebuff() 
	return false 
end

function modifier_ancient_defense_bonus:GetTexture()
   return "modifier_ancient_defense"
end

function modifier_ancient_defense_bonus:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT
	}

	return funcs
end

function modifier_ancient_defense_bonus:GetModifierMoveSpeedBonus_Special_Boots()
	return 75
end

function modifier_ancient_defense_bonus:GetModifierIgnoreMovespeedLimit()
	return 1
end