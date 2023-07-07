winner_info = class({
	GetIntrinsicModifierName = function() return "modifier_winner_info" end
})
LinkLuaModifier( "modifier_winner_info", "skills/round/winner_info", LUA_MODIFIER_MOTION_NONE )

modifier_winner_info = {}

function wisp_info:IsPurgable() 
	return false
end

function wisp_info:IsPurgeException()
	return false
end

function modifier_winner_info:IsHidden()
	return false
end

function wisp_info:RemoveOnDeath() 
	return false
end

function modifier_winner_info:OnCreated()
	if not IsServer() then return end
end

function modifier_winner_info:OnRefresh()
	self:OnCreated()
end