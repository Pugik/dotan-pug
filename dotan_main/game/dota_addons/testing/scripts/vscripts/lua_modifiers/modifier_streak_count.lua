modifier_streak_count = {}

function modifier_streak_count:IsHidden()
	if self:GetStackCount() == 0 then
		return true
	end
	return false
end

function modifier_streak_count:IsDebuff() return true end
function modifier_streak_count:IsPurgable() return false end
function modifier_streak_count:IsPurgeException() return false end
function modifier_streak_count:RemoveOnDeath() return false end

function modifier_streak_count:GetTexture()
    return "modifier_streak_count"
end

function modifier_streak_count:OnCreated()
	if not IsServer() then return end

	self:SetStackCount(0)
end

function modifier_streak_count:OnRefresh()
	self:OnCreated()
end

function modifier_streak_count:OnStackCountChanged(oldstacks)
    if not IsServer() then return end

    local hero = self:GetParent()
    
    if self:GetStackCount() == 5 then
        self.particle = ParticleManager:CreateParticle("particles/econ/events/fall_2022/agh/agh_aura_fall2022_flek.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
        ParticleManager:SetParticleControl(self.particle, 0, hero:GetAbsOrigin())
    end

    if self:GetStackCount() == 10 then
        self:ClearEffects()
        self.particle = ParticleManager:CreateParticle("particles/econ/events/fall_2022/agh/agh_aura_fall2022_lvl1.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
        ParticleManager:SetParticleControl(self.particle, 0, hero:GetAbsOrigin())
    end

    if self:GetStackCount() >= 15 then
        self:ClearEffects()
        self.particle = ParticleManager:CreateParticle("particles/econ/events/fall_2022/agh/agh_aura_fall2022_lvl2.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
        ParticleManager:SetParticleControl(self.particle, 0, hero:GetAbsOrigin())
    end

    if oldstacks >= 5 and self:GetStackCount() == 0 then
        self:ClearEffects()
    end
end

function modifier_streak_count:ClearEffects()
    ParticleManager:DestroyParticle(self.particle, true)
    ParticleManager:ReleaseParticleIndex(self.particle)
end