modifier_units_scale = {}

function modifier_units_scale:IsHidden() return true end
function modifier_units_scale:IsDebuff() return false end
function modifier_units_scale:IsPurgable() return false end
function modifier_units_scale:IsPurgeException() return false end

function modifier_units_scale:DeclareFunctions()
	return {MODIFIER_PROPERTY_MODEL_SCALE}
end

function modifier_units_scale:GetModifierModelScale()
	return 30
end