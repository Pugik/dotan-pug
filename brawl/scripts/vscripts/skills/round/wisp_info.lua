wisp_info = class({
	GetIntrinsicModifierName = function() return "modifier_wisp_info" end
})

LinkLuaModifier("modifier_wisp_info", "skills/round/wisp_info", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("wisp_info_alive", "skills/round/wisp_info", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("wisp_info_protect", "skills/round/wisp_info", LUA_MODIFIER_MOTION_NONE)

modifier_wisp_info = class({})

function modifier_wisp_info:IsPurgable() 
	return false
end

function modifier_wisp_info:IsPurgeException()
	return false
end

function modifier_wisp_info:IsHidden() 
	return false 
end

function modifier_wisp_info:RemoveOnDeath() 
	return false
end

function modifier_wisp_info:OnCreated()
	if not IsServer() then return end
	self.wisp = nil
end

function modifier_wisp_info:DeclareFunctions()
	return 
	{
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_EVENT_ON_RESPAWN
	}
end

function modifier_wisp_info:OnDeath(params)
	if not IsServer() then return end
	if params.unit == self:GetParent() then

		self.wisp = CreateUnitByName("npc_wisp_death", self:GetParent():GetAbsOrigin(), false, self:GetParent(), nil, self:GetParent():GetTeamNumber())
		self.wisp:AddNewModifier(self.wisp, nil, "wisp_info_protect", {})
		self.wisp:AddNewModifier(self.wisp, nil, "wisp_info_alive", {})
		self.wisp:SetOwner(self:GetParent())
		self.wisp:SetControllableByPlayer(self:GetParent():GetPlayerID(), true)

		-- ������ ���������� ��� �������� ����� � ������������� ��� � ����� �����
		self:GetParent().death = true

		local teleport_point=Entities:FindByClassname(nil, "info_player_start_dota")
		if teleport_point then 
			Timers:CreateTimer(0.05, function()
	            
			FindClearSpaceForUnit(self.wisp, teleport_point:GetAbsOrigin(), true)
			self:GetParent():SetCameraTarget(self.wisp)
			self:GetParent():SetUnitName(self.wisp)
				
			PlayerResource:SetOverrideSelectionEntity(self:GetParent():GetPlayerID(), self.wisp)
			end)
		end
	end
end

function modifier_wisp_info:OnRespawn(params)
	if not IsServer() then return end

	-- ��������� �������� ��� ��� ���� ���� ����� ���
	if params.unit ~= self:GetParent() then return end
	if self.wisp == nil then return end
	if not self.wisp:IsAlive() then return end

	-- ����������� �� �����
	GridNav:DestroyTreesAroundPoint(self.wisp:GetAbsOrigin(), 150, true)
	FindClearSpaceForUnit(self:GetParent(), self.wisp:GetAbsOrigin(), true)
	UTIL_Remove(self.wisp)
	self.wisp = nil
	self:GetParent().death = nil
end

-- ������������ �����

wisp_info_alive = class({})

function wisp_info_alive:IsPurgable() 
	return false
end

function wisp_info_alive:OnCreated()
	if not IsServer() then return end
	self.wisp_particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_wisp/wisp_ambient.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent() )
	ParticleManager:SetParticleControlEnt(self.wisp_particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(self.wisp_particle, false, false, -1, false, false)
end

function wisp_info_alive:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true, 
		[MODIFIER_STATE_DISARMED] = true, 
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true, 
		[MODIFIER_STATE_UNTARGETABLE] = true, 
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true, 
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true, 
		[MODIFIER_STATE_UNSELECTABLE] = false, 
		[MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true
	}
end

function wisp_info_alive:DeclareFunctions() 
    return 
    {
    	MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
    } 
end

function wisp_info_alive:GetModifierMoveSpeed_Absolute()
    return 350
end

--[[
function wisp_info_alive:GetTexture()
	return "wisp"
end
]]

wisp_info_protect = class({})

function wisp_info_protect:IsPurgable() 
	return false
end

function wisp_info_protect:IsPurgeException()
	return false
end

function wisp_info_protect:IsHidden() 
	return false 
end

function wisp_info_protect:RemoveOnDeath() 
	return false
end

function wisp_info_protect:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end

function wisp_info_protect:OnIntervalThink()
    if not IsServer() then return end
    self:GetParent():RemoveModifierByName("modifier_item_dustofappearance")
    self:GetParent():RemoveModifierByName("modifier_truesight")
end

function wisp_info_protect:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
    }
end

function wisp_info_protect:GetModifierInvisibilityLevel()
    return 1
end

function wisp_info_protect:CheckState()
    return {
        [MODIFIER_STATE_INVISIBLE] = true,
        [MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

--[[
function wisp_info_protect:GetTexture()
	return "wispinvis"
end
]]