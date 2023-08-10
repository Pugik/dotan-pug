outpost_tp = class({})

LinkLuaModifier("modifier_outpost_tp_cast", "lua_items/item_outpost/outpost_tp.lua", LUA_MODIFIER_MOTION_NONE)

function outpost_tp:GetChannelTime() return 5 end

function outpost_tp:GetAbilityTextureName()
	return "outpost_tp"
end

function outpost_tp:OnSpellStart()
	if not IsServer() then return end

	local hero = self:GetCaster()
	self.tp_point = _G.outpost_position + RandomVector(200)

	hero:EmitSound("Portal.Loop_Appear")

	hero:AddNewModifier(hero, self, "modifier_outpost_tp_cast", {duration = self:GetChannelTime()})	

	self.end_entity = CreateUnitByName("npc_dota_companion", self.tp_point, true, nil, nil, 0)
    self.end_entity:AddNewModifier(self.end_entity, nil, "modifier_phased", nil)
	self.end_entity:AddNewModifier(self.end_entity, nil, "modifier_invulnerable", nil)

	EmitSoundOn("Portal.Loop_Appear", self.end_entity)

	local tp_effect = "particles/econ/events/ti5/teleport_end_lvl2_ti5.vpcf"

	if hero:GetTeamNumber() == 2 then
		tp_effect = "particles/econ/events/ti7/teleport_end_ti7_lvl2.vpcf"
	end
	
	if hero:GetTeamNumber() == 3 then
		tp_effect = "particles/econ/events/ti6/teleport_end_ti6_lvl2.vpcf"
	end

	self.outpostEffect = ParticleManager:CreateParticle(tp_effect, PATTACH_ABSORIGIN_FOLLOW, self.end_entity)
	ParticleManager:SetParticleControl(self.outpostEffect, 0, self.end_entity:GetAbsOrigin())
	
	self.heroEffect = ParticleManager:CreateParticle(tp_effect, PATTACH_ABSORIGIN_FOLLOW, hero)
	ParticleManager:SetParticleControl(self.heroEffect, 0, hero:GetAbsOrigin())
end

function outpost_tp:OnChannelFinish(bInterrupted)
	local hero = self:GetCaster()
	
	hero:RemoveModifierByName("modifier_outpost_tp_cast")

	StopSoundOn("Portal.Loop_Appear", hero)
	StopSoundOn("Portal.Loop_Appear", self.end_entity)
	
	self.end_entity:Destroy()

	ParticleManager:DestroyParticle(self.outpostEffect, false)
	ParticleManager:ReleaseParticleIndex(self.outpostEffect)
	ParticleManager:DestroyParticle(self.heroEffect, false)
	ParticleManager:ReleaseParticleIndex(self.heroEffect)

	if bInterrupted then return end

	hero:EmitSound("Portal.Hero_Disappear")
	
	hero:SetAbsOrigin(self.tp_point)
	FindClearSpaceForUnit(hero, self.tp_point, true)
	
	hero:Stop()
	hero:Interrupt()
end

modifier_outpost_tp_cast = class({})

function modifier_outpost_tp_cast:IsHidden() return true end
function modifier_outpost_tp_cast:IsPurgable() return false end
function modifier_outpost_tp_cast:DeclareFunctions() return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION} end
function modifier_outpost_tp_cast:GetOverrideAnimation() return ACT_DOTA_TELEPORT end