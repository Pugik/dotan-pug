-- by APpLePeN

LinkLuaModifier("modifier_useless_item", "lua_items/item_useless/item_useless.lua", LUA_MODIFIER_MOTION_NONE)

local AllActiveItems = {
    tar = {
        -- Target
        "item_shadow_amulet",
        "item_medallion_of_courage",
        "item_solar_crest",
        "item_glimmer_cape",
        "item_cyclone",
        "item_wind_waker",
        "item_force_staff",
        "item_hurricane_pike",
        "item_rod_of_atos",
        "item_dagon",
        "item_dagon_2",
        "item_dagon_3",
        "item_dagon_4",
        "item_dagon_5",
        "item_orchid",
        "item_bloodthorn",
        "item_abyssal_blade",
        "item_sheepstick",
        "item_ethereal_blade",
        "item_nullifier",
        "item_revenants_brooch",
        "item_diffusal_blade",
        "item_disperser",
        "item_harpoon",
        "item_heavens_halberd",
        
        -- position
        "item_gungir",
        "item_meteor_hammer",
    },
    
    nonTar = {
        -- Non-target
        "item_arcane_boots",
        "item_mekansm",
        "item_guardian_greaves",
        "item_hood_of_defiance",
        "item_pipe",
        "item_soul_ring",
        "item_blade_mail",
        "item_refresher",
        "item_crimson_guard",
        "item_manta",
        "item_shivas_guard",
        "item_invis_sword",
        "item_silver_edge",
    }
}

item_useless = class({})
function item_useless:OnSpellStart()
	if not IsServer() then return end
	local owner = self:GetCaster()
	local target = self:GetCursorTarget()
	local targetTeam = target:GetTeamNumber()
	
	local cursorName = nil
	local NothingTriggerChance = self:GetSpecialValueFor("nothing_chance")		-- Шанс на применение не таргетных предметов
	if RandomInt(1, 100) <= NothingTriggerChance then
		target = nil
	end
	
	if target == nil then
		cursorName = "nonTar"
		owner:SetCursorTargetingNothing(true)
	else
		cursorName = "tar"
		owner:SetCursorCastTarget(self:GetCursorTarget())
	end
	
	local itemsTable = AllActiveItems[cursorName]
	local RandomName = RandomInt(1, #itemsTable)
	local reflected_spell = owner:AddAbility(itemsTable[RandomName])

	local reflected_spell_mana_cost = reflected_spell:GetManaCost(-1)
    owner:SpendMana(reflected_spell_mana_cost, reflected_spell)
	
    reflected_spell:SetHidden(true)
	reflected_spell:SetRefCountsModifiers(true)
	
	reflected_spell:SetLevel(1)
	if (RandomName == "item_gungir" or RandomName == "item_meteor_hammer") and targetTeam ~= owner:GetTeamNumber() then
		owner:SetCursorPosition(target:GetAbsOrigin())
	end
	reflected_spell:OnSpellStart()
	
	if reflected_spell.OnChannelFinish then
		reflected_spell:OnChannelFinish(false)
	end
	
	if reflected_spell:GetIntrinsicModifierName() ~= nil then
		local modifier_intrinsic = owner:FindModifierByName(reflected_spell:GetIntrinsicModifierName())
		
        if modifier_intrinsic then
			owner:RemoveModifierByName(modifier_intrinsic:GetName())
		end
	end
	
	Timers:CreateTimer(10, function()
		if reflected_spell then
			reflected_spell:RemoveSelf()
		end
	end)
    
    self:SpendCharge()
end