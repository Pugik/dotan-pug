boost_stack = class({
	GetIntrinsicModifierName = function() return "modifier_boost_stack" end
})
LinkLuaModifier( "modifier_boost_stack", "skills/boost/boost_stack", LUA_MODIFIER_MOTION_NONE )

modifier_boost_stack = {}

function modifier_boost_stack:IsHidden()
	if self:GetStackCount() == 0 then
		return true
	end
	return false
end

function modifier_boost_stack:OnCreated()
	if not IsServer() then return end

	if IsServer() then
		self:SetStackCount(0)
	end
end

function modifier_boost_stack:OnRefresh()
	self:OnCreated()
end

function modifier_boost_stack:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_UNIQUE
	}
end

function modifier_boost_stack:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount() * 8
end

function modifier_boost_stack:GetModifierSpellAmplify_PercentageUnique()
	return self:GetStackCount() * 4
end