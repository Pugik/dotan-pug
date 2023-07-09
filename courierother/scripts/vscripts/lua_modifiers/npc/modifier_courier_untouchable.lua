modifier_courier_untouchable = {} -- Создаем модификатор.

function modifier_courier_untouchable:IsHidden() return false end -- Делает эффект на юните / игроке невидимым.
function modifier_courier_untouchable:IsDebuff() return false end -- Это дебафф?
function modifier_courier_untouchable:RemoveOnDeath() return false end -- Удалять при смерти?

function modifier_courier_untouchable:CheckState() -- Функция добавляет новые стейты для модификатора, которые влияют на ютитов / игроков.
	local state =
	{
		--[MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true, -- При true - запрещает управлять юнитов / игроком, но не запрещает использовать скиллы.
		--[MODIFIER_STATE_IGNORING_STOP_ORDERS] = true, -- При true - игнорирует отмену движения или скилла, то-есть при нажатие S курьер продолжит движение.
		[MODIFIER_STATE_NO_HEALTH_BAR] = true, -- При true - отключает хп бар
		[MODIFIER_STATE_UNSELECTABLE] = true, -- При true - нельзя выделить
		[MODIFIER_STATE_INVULNERABLE] = true,
	}

	return state -- Возвращаем стейт, чтобы он заработал.
end