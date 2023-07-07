item_plboost = class({})

function item_plboost:OnSpellStart()
	if self:GetParent():IsRealHero() and self:GetParent():HasModifier("modifier_boost_stack") then
		self:GetParent():SetModifierStackCount("modifier_boost_stack", self:GetParent(), (self:GetParent():GetModifierStackCount("modifier_boost_stack", self:GetParent()) + 1))
	end

	self.sound_cast = "Item.WraithTotem.Pulse"
	self:GetParent():EmitSound(self.sound_cast)

	self:Kill()
end