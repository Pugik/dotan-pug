LinkLuaModifier("modifier_item_banana_logic", "lua_items/item_banana/item_banana_logic.lua", LUA_MODIFIER_MOTION_NONE)

item_banana_logic = class({})

function item_banana_logic:GetIntrinsicModifierName() return "modifier_item_banana_logic" end

modifier_item_banana_logic = modifier_item_banana_logic or class({})

function modifier_item_banana_logic:IsHidden() return true end
function modifier_item_banana_logic:IsDebuff() return false end
function modifier_item_banana_logic:IsPurgable() return false end
function modifier_item_banana_logic:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_banana_logic:OnCreated(keys)
	if not IsServer() then return end

	self:StartIntervalThink(0.25)
end

function modifier_item_banana_logic:OnIntervalThink()
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

function modifier_item_banana_logic:OnTrigger(unit, enemy)
    local center = unit:GetAbsOrigin()
    local direction = enemy:GetForwardVector()
    
    local modifierKnockback =
	{
		center_x = enemy:GetAbsOrigin().x + -direction.x * 300,
		center_y = enemy:GetAbsOrigin().y + -direction.y * 300,
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

function modifier_item_banana_logic:CheckState()
    local state = {
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }

    return state
end