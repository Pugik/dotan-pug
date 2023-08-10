// By APpLePeN (09.08.23)
var newUI = $.GetContextPanel().GetParent().GetParent().FindChildTraverse("HUDElements");

function BackpackUpdate()
{
	if (Entities.GetUnitName(Players.GetLocalPlayerPortraitUnit()) == "npc_dota_courier") {
		newUI.FindChildTraverse("inventory_backpack_list").style.visibility = "visible";
	} 
	else 
	{
		newUI.FindChildTraverse("inventory_backpack_list").style.visibility = "collapse";
	}
	
	$.Schedule(1/60, BackpackUpdate);
}

(function () {
	BackpackUpdate();
})();