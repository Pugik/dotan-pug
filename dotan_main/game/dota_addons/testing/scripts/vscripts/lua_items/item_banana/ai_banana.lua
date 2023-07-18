LinkLuaModifier("modifier_ai_banana", "lua_items/item_banana/ai_banana.lua", LUA_MODIFIER_MOTION_NONE)

ai_banana = class({})

function ai_banana:GetIntrinsicModifierName() return "modifier_ai_banana" end

modifier_ai_banana = class({})

function modifier_ai_banana:IsHidden() return true end
function modifier_ai_banana:IsDebuff() return false end
function modifier_ai_banana:IsPurgable() return false end
function modifier_ai_banana:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_ai_banana:OnCreated(keys)
	if not IsServer() then return end

	self:StartIntervalThink(0.25)
end

function modifier_ai_banana:OnIntervalThink()
    local enemies = FindUnitsInRadius(
        self:GetParent():GetTeamNumber(),
        self:GetParent():GetAbsOrigin(),
        nil,
        100,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false
    )

    for _, enemy in pairs(enemies) do
        self:OnTrigger(self:GetParent(), enemy)
    end
end

function modifier_ai_banana:OnTrigger(unit, enemy)
    local center = unit:GetAbsOrigin()
    local direction = enemy:GetForwardVector()

    local randomVector2D = RandomVector(100)
    local randomVector3D = Vector(randomVector2D.x, randomVector2D.y, 0)
    
    local modifierKnockback =
	{
		center_x = enemy:GetAbsOrigin().x + -randomVector3D.x  * 300,
		center_y = enemy:GetAbsOrigin().y + -randomVector3D.y * 300,
		center_z = enemy:GetAbsOrigin().z + -direction.z * 300,
		duration = 0.5,
		knockback_duration = 0.5,
		knockback_distance = 300,
		knockback_height = 0,
	}

    enemy:AddNewModifier( unit, nil, "modifier_knockback", modifierKnockback );
    unit:EmitSound("Item.PogoStick.Cast")
    unit:RemoveSelf()
end

function modifier_ai_banana:CheckState()
    local state = {
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }

    return state
end