death_info = class({
	GetIntrinsicModifierName = function() return "modifier_death_info" end
})
LinkLuaModifier( "modifier_death_info", "skills/round/death_info", LUA_MODIFIER_MOTION_NONE )

modifier_death_info = {}

function wisp_info:IsPurgable() 
	return false
end

function wisp_info:IsPurgeException()
	return false
end

function modifier_death_info:IsHidden()
	return false
end

function wisp_info:RemoveOnDeath() 
	return false
end

function modifier_death_info:OnCreated()
	if not IsServer() then return end
end

function modifier_death_info:OnRefresh()
	self:OnCreated()
end