var newUI = $.GetContextPanel().GetParent().GetParent().FindChildTraverse("HUDElements");

function ShopUpdate()
{
	//
	// Changing the icon borders. (Quickbuy Items)
	//

	for (var ff of newUI.FindChildTraverse("QuickBuyRows").FindChildTraverse("Row0").FindChildrenWithClassTraverse("QuickBuySlot")) 
	{
		for (var ff of ff.FindChildrenWithClassTraverse("SecretShopItem"))
		{
			ff.FindChildTraverse("CanPurchaseOverlay").style["background-image"] = "url('https://github.com/Pugik/dotan-pug/blob/main/dotan_icons/shopborder_custom_secret.png?raw=true')"
		}

		for (var ff of ff.FindChildrenWithClassTraverse("CanPurchase"))
		{
			ff.FindChildTraverse("CanPurchaseOverlay").style["background-image"] = "url('s2r://panorama/images/hud/shopborder_canpurchase_psd.vtex')"
		}
	}

	for (var ff of newUI.FindChildTraverse("QuickBuyRows").FindChildTraverse("Row1").FindChildrenWithClassTraverse("QuickBuySlot")) 
	{
		for (var ff of ff.FindChildrenWithClassTraverse("SecretShopItem"))
		{
			ff.FindChildTraverse("CanPurchaseOverlay").style["background-image"] = "url('https://github.com/Pugik/dotan-pug/blob/main/dotan_icons/shopborder_custom_secret.png?raw=true')"
		}

		for (var ff of ff.FindChildrenWithClassTraverse("CanPurchase"))
		{
			ff.FindChildTraverse("CanPurchaseOverlay").style["background-image"] = "url('s2r://panorama/images/hud/shopborder_canpurchase_psd.vtex')"
		}
	}

	//
	// I think it'll save you a lot of fps. 
	//

	if ( !newUI.FindChildTraverse("shop").BHasClass("ShopOpen") ) 
	{
		//$.Msg("New Loop");
		$.Schedule(1/10, ShopUpdate);
		return false
	}

	//$.Msg("Continue");
	
	//
	// Fix column grid in shop.
	//

	if ( !newUI.FindChildTraverse("shop").BHasClass("ShopLarge") )
	{
		newUI.FindChildTraverse("shop").AddClass("ShopLarge")
	}

	//
	// Removing the secret shop icon. (First Tab / First Line of Items)
	//
	for (var ff of newUI.FindChildTraverse("GridBasicItemsCategory").FindChildTraverse("ShopItemsContainer").FindChildrenWithClassTraverse("SecretShopItem")) 
	{
		ff.FindChildTraverse("SecretShop").style.visibility = "collapse";
	}

	//
	// Removing the secret shop icon. (Second Tab / First Line of Items)
	//

	for (var ff of newUI.FindChildTraverse("GridUpgradesCategory").FindChildTraverse("ShopItemsContainer").FindChildrenWithClassTraverse("SecretShopItem")) 
	{
		ff.FindChildTraverse("SecretShop").style.visibility = "collapse";
	}

	//
	// Changing the icon borders. (First Tab / First Line of Items)
	//

	if (newUI.FindChildTraverse("GridBasicItemsCategory").FindChildTraverse("ShopItemsContainer"))
	{
		for (var ff of newUI.FindChildTraverse("GridBasicItemsCategory").FindChildTraverse("ShopItemsContainer").FindChildrenWithClassTraverse("SecretShopItem"))
		{
			ff.FindChildTraverse("CanPurchaseOverlay").style["background-image"] = "url('https://github.com/Pugik/dotan-pug/blob/main/dotan_icons/shopborder_custom_secret.png?raw=true')"
		}

		for (var ff of newUI.FindChildTraverse("GridBasicItemsCategory").FindChildTraverse("ShopItemsContainer").FindChildrenWithClassTraverse("CanPurchase"))
		{
			ff.FindChildTraverse("CanPurchaseOverlay").style["background-image"] = "url('s2r://panorama/images/hud/shopborder_canpurchase_psd.vtex')"
		}
	}

	//
	// Changing the icon borders. (Second Tab / First Line of Items)
	//

	if (newUI.FindChildTraverse("GridUpgradesCategory").FindChildTraverse("ShopItemsContainer"))
	{
		for (var ff of newUI.FindChildTraverse("GridUpgradesCategory").FindChildTraverse("ShopItemsContainer").FindChildrenWithClassTraverse("SecretShopItem"))
		{
			ff.FindChildTraverse("CanPurchaseOverlay").style["background-image"] = "url('https://github.com/Pugik/dotan-pug/blob/main/dotan_icons/shopborder_custom_secret.png?raw=true')"
		}

		for (var ff of newUI.FindChildTraverse("GridUpgradesCategory").FindChildTraverse("ShopItemsContainer").FindChildrenWithClassTraverse("CanPurchase"))
		{
			ff.FindChildTraverse("CanPurchaseOverlay").style["background-image"] = "url('s2r://panorama/images/hud/shopborder_canpurchase_psd.vtex')"
		}
	}

	//
	// Changing the icon borders. (Anchored Items)
	//

	if (newUI.FindChildTraverse("ItemCombinesAndBasicItemsContainer").FindChildTraverse("ItemList")) 
	{
		for (var ff of newUI.FindChildTraverse("ItemCombinesAndBasicItemsContainer").FindChildTraverse("ItemList").FindChildrenWithClassTraverse("SecretShopItem"))
		{
			ff.FindChildTraverse("CanPurchaseOverlay").style["background-image"] = "url('https://github.com/Pugik/dotan-pug/blob/main/dotan_icons/shopborder_custom_secret.png?raw=true')"
		}

		for (var ff of newUI.FindChildTraverse("ItemCombinesAndBasicItemsContainer").FindChildTraverse("ItemList").FindChildrenWithClassTraverse("CanPurchase"))
		{
			ff.FindChildTraverse("CanPurchaseOverlay").style["background-image"] = "url('s2r://panorama/images/hud/shopborder_canpurchase_psd.vtex')"
		}
	}

	//
	// Changing the icon borders. (Reciped Items)
	//

	if (newUI.FindChildTraverse("ItemCombinesAndBasicItemsContainer").FindChildTraverse("ItemsContainer")) 
	{
		for (var ff of newUI.FindChildTraverse("ItemCombinesAndBasicItemsContainer").FindChildTraverse("ItemsContainer").FindChildrenWithClassTraverse("SecretShopItem"))
		{
			ff.FindChildTraverse("CanPurchaseOverlay").style["background-image"] = "url('https://github.com/Pugik/dotan-pug/blob/main/dotan_icons/shopborder_custom_secret.png?raw=true')"
		}

		for (var ff of newUI.FindChildTraverse("ItemCombinesAndBasicItemsContainer").FindChildTraverse("ItemsContainer").FindChildrenWithClassTraverse("CanPurchase"))
		{
			ff.FindChildTraverse("CanPurchaseOverlay").style["background-image"] = "url('s2r://panorama/images/hud/shopborder_canpurchase_psd.vtex')"
		}
	}

	//
	// Removing the secret shop icon and changing the icon borders. (Guide Items)
	//

	for (var ff of newUI.FindChildTraverse("ItemBuild").FindChildTraverse("Categories").FindChildrenWithClassTraverse("SecretShopItem")) 
	{
		ff.FindChildTraverse("CanPurchaseOverlay").style["background-image"] = "url('https://github.com/Pugik/dotan-pug/blob/main/dotan_icons/shopborder_custom_secret.png?raw=true')"
	
		ff.FindChildTraverse("SecretShop").style.visibility = "collapse";
	}

	for (var ff of newUI.FindChildTraverse("ItemBuild").FindChildTraverse("Categories").FindChildrenWithClassTraverse("CanPurchase")) 
	{
		ff.FindChildTraverse("CanPurchaseOverlay").style["background-image"] = "url('s2r://panorama/images/hud/shopborder_canpurchase_psd.vtex')"
	
		ff.FindChildTraverse("SecretShop").style.visibility = "collapse";
	}
	
	$.Schedule(1/10, ShopUpdate);
}

(function () {
	ShopUpdate();
})();