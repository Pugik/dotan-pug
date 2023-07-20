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

function modifier_streak_count:OnStackCountChanged()
    if not IsServer() then return end

    local hero = self:GetParent()
    
    if self:GetStackCount() == 1 and self.particle1 == nil then
        self.particle1 = ParticleManager:CreateParticle("particles/econ/events/fall_2022/agh/agh_aura_fall2022_ash.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
        ParticleManager:SetParticleControl(self.particle1, 0, hero:GetAbsOrigin())
    end

    if self:GetStackCount() == 2 and self.particle2 == nil then
        self.particle2 = ParticleManager:CreateParticle("particles/econ/events/fall_2022/agh/agh_aura_fall2022_border.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
        ParticleManager:SetParticleControl(self.particle2, 0, hero:GetAbsOrigin())
    end

    if self:GetStackCount() == 3 and self.particle3 == nil then
        self.particle3 = ParticleManager:CreateParticle("particles/econ/events/fall_2022/agh/agh_aura_fall2022_smoke.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
        ParticleManager:SetParticleControl(self.particle3, 0, hero:GetAbsOrigin())
    end

    if self:GetStackCount() == 4 and self.particle4 == nil then
        self.particle4 = ParticleManager:CreateParticle("particles/econ/events/fall_2022/agh/agh_aura_fall2022_flek.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
        ParticleManager:SetParticleControl(self.particle4, 0, hero:GetAbsOrigin())
    end

    if self:GetStackCount() == 5 and self.particle5 == nil then
        self.particle5 = ParticleManager:CreateParticle("particles/econ/events/fall_2022/agh/agh_aura_fall2022_parent.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
        ParticleManager:SetParticleControl(self.particle5, 0, hero:GetAbsOrigin())
    end

    if self:GetStackCount() == 6 and self.particle6 == nil then
        self.particle6 = ParticleManager:CreateParticle("particles/econ/events/fall_2022/agh/agh_aura_fall2022_crystal.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
        ParticleManager:SetParticleControl(self.particle6, 0, hero:GetAbsOrigin())
    end

    if self:GetStackCount() == 0 then
        if self.particle1 ~= nil then 
            ParticleManager:DestroyParticle(self.particle1, true)
            ParticleManager:ReleaseParticleIndex(self.particle1)
        end

        if self.particle2 ~= nil then 
            ParticleManager:DestroyParticle(self.particle2, true)
            ParticleManager:ReleaseParticleIndex(self.particle2)
        end

        if self.particle3 ~= nil then 
            ParticleManager:DestroyParticle(self.particle3, true)
            ParticleManager:ReleaseParticleIndex(self.particle3)
        end

        if self.particle4 ~= nil then 
            ParticleManager:DestroyParticle(self.particle4, true)
            ParticleManager:ReleaseParticleIndex(self.particle4)
        end

        if self.particle5 ~= nil then 
            ParticleManager:DestroyParticle(self.particle5, true)
            ParticleManager:ReleaseParticleIndex(self.particle5)
        end

        if self.particle6 ~= nil then 
            ParticleManager:DestroyParticle(self.particle6, true)
            ParticleManager:ReleaseParticleIndex(self.particle6)
        end
    end
end