modifier_ancient_defense = class({})
LinkLuaModifier( "modifier_ancient_defense_bonus", "lua_modifiers/modifier_ancient_defense", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_defense_effect", "lua_modifiers/modifier_ancient_defense", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_defense_effect_hero", "lua_modifiers/modifier_ancient_defense", LUA_MODIFIER_MOTION_NONE )

function modifier_ancient_defense:IsHidden() 
	return true 
end

function modifier_ancient_defense:OnCreated(keys)
	if not IsServer() then return end

	self:StartIntervalThink(0.1)
end

function modifier_ancient_defense:OnIntervalThink()	
	local friends = nil

	friends = self:FindFriends(2250)
	if friends ~= nil then
		friend = self:WorkFriends(friends)

		if friend ~= nil then	
			if friend:IsAlive() and self:GetParent():GetHealth() == 1 then
				if not friend:FindModifierByName("modifier_fountain_invulnerability") then
					self:PlayEffects( friend )
				end
			end
		end
	end

	if friends == nil then 
		if self:GetParent():FindModifierByName("modifier_ancient_defense_effect") then
			self:GetParent():RemoveModifierByName("modifier_ancient_defense_effect")
		end
	end

	friends = self:FindFriends(9999)
	if friends ~= nil then
		friend = self:WorkFriends(friends)
		
		if friend ~= nil then	
			if self:GetParent():GetHealth() > 1 or not friend:IsAlive() or friend:FindModifierByName("modifier_fountain_invulnerability") then
				self:StopEffects( friend )
			end

			if not friend:FindModifierByName("modifier_ancient_defense_effect_hero") or not self:GetParent():FindModifierByName("modifier_ancient_defense_effect") then
				self:StopEffects( friend )
			end
		end
	end
end -- oh yeeee if if ifi fifi eneneenednendne end

function modifier_ancient_defense:FindFriends(radius)
	local friends = FindUnitsInRadius( 
		self:GetParent():GetTeam(), 
		self:GetParent():GetOrigin(), 
		target,
		radius, 
		DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
		DOTA_UNIT_TARGET_HERO, 
		DOTA_UNIT_TARGET_FLAG_NONE + DOTA_UNIT_TARGET_FLAG_DEAD, 
		0, 
		false 
	)
	
	if #friends > 0 then
		return friends
	end
	return nil
end

function modifier_ancient_defense:WorkFriends(friends)
	for _,friend in pairs(friends) do
		if friend ~= nil then	
			return friend
		end
	end
	return nil
end

function modifier_ancient_defense:PlayEffects(friend)
	if friend.effect_cast_enabled then return end

	local particle_cast = "particles/units/heroes/hero_pugna/pugna_shard_life_drain.vpcf"

	if friend:GetTeamNumber() == 2 then
		particle_cast = "particles/econ/items/pugna/pugna_ti10_immortal/pugna_ti10_immortal_life_drain_gold.vpcf"
	end

	if friend:GetTeamNumber() == 3 then
		particle_cast = "particles/econ/items/pugna/pugna_ti10_immortal/pugna_ti10_immortal_life_drain.vpcf"
	end

	local entity = self:GetParent()
	
	friend.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, entity )

	ParticleManager:SetParticleControlEnt(
		friend.effect_cast,
		0,
		entity,
		PATTACH_POINT,
		"attach_fx",
		Vector(0,0,250), 
		true 
	)

	ParticleManager:SetParticleControlEnt(
		friend.effect_cast,
		1,
		friend,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), 
		true 
	)

	friend.effect_cast_enabled = true
end

function modifier_ancient_defense:StopEffects( friend )
	if friend.effect_cast_enabled == true then
		ParticleManager:DestroyParticle(friend.effect_cast, false)
		ParticleManager:ReleaseParticleIndex(friend.effect_cast)
		friend.effect_cast_enabled = false
	end
end

function modifier_ancient_defense:IsAura() 					
	return true 
end
function modifier_ancient_defense:IsAuraActiveOnDeath()		
	return false 
end
function modifier_ancient_defense:GetAuraRadius()			
	return 2250 
end
function modifier_ancient_defense:GetAuraSearchFlags()		
	return DOTA_UNIT_TARGET_FLAG_NONE 
end
function modifier_ancient_defense:GetAuraSearchTeam()		
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY 
end
function modifier_ancient_defense:GetAuraSearchType()		
	return DOTA_UNIT_TARGET_HERO
end
function modifier_ancient_defense:GetModifierAura()			
	return "modifier_ancient_defense_effect_hero" 
end

-------------------------------------------------------------------------------------

modifier_ancient_defense_effect_hero = class({})

function modifier_ancient_defense_effect_hero:IsHidden()
	return false
end

function modifier_ancient_defense_effect_hero:IsPurgable() 
	return false 
end

function modifier_ancient_defense_effect_hero:IsDebuff() 
	return false 
end

function modifier_ancient_defense_effect_hero:GetTexture()
    return "modifier_ancient_defense"
end

-------------------------------------------------------------------------------------

modifier_ancient_defense_effect = class({})

function modifier_ancient_defense_effect:IsHidden()
	return false
end

function modifier_ancient_defense_effect:IsPurgable() 
	return false 
end

function modifier_ancient_defense_effect:IsDebuff() 
	return false 
end

function modifier_ancient_defense_effect:GetTexture()
    return "modifier_ancient_defense"
end

function modifier_ancient_defense_effect:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true
	}
end

function modifier_ancient_defense_effect:OnDestroy() 
	if not IsServer() then return end

	self:GetParent():SetBaseHealthRegen(12.0)
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
   return "modifier_ancient_defense_bonus"
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