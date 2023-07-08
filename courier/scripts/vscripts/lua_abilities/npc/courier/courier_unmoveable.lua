-- Создаем способность.
courier_unmoveable = class({
	GetIntrinsicModifierName = function() return "modifier_courier_unmoveable" end -- Добавляем способности модификатор.
})
LinkLuaModifier( "modifier_courier_unmoveable", "lua_abilities/npc/courier/courier_unmoveable", LUA_MODIFIER_MOTION_NONE ) -- Линкуем модификатор.

modifier_courier_unmoveable = {} -- Создаем модификатор.

function modifier_courier_unmoveable:IsHidden() return false end -- Делает эффект на юните / игроке невидимым.
function modifier_courier_unmoveable:IsDebuff() return false end -- Это дебафф?
function modifier_courier_unmoveable:RemoveOnDeath() return false end -- Удалять при смерти?

function modifier_courier_unmoveable:OnCreated() -- Функция срабатывает при создании модификатора.
	if not IsServer() then return end
end

function modifier_courier_unmoveable:OnRefresh() -- Функция срабатывает при перезагрузке модификатора.
	self:OnCreated()
end

function modifier_courier_unmoveable:CheckState() -- Функция добавляет новые стейты для модификатора, которые влияют на юнитов / игроков.
	local state =
	{
		[MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true, -- При true - запрещает управлять юнитов / игроком, но не запрещает использовать скиллы.
	}

	return state -- Возвращаем стейт, чтобы он заработал.
end
