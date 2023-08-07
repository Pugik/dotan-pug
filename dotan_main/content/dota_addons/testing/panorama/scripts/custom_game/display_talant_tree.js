GameEvents.Subscribe("display_talant_tree", function(keys) {
    var newUI = $.GetContextPanel().GetParent().GetParent().FindChildTraverse("HUDElements");    

    var display_state = "collapse"

    if (keys.bool == true)
    {
        display_state = "visible"
    }
    else
    {
        display_state = "collapse"
    }
    
    newUI.FindChildTraverse("StatBranchOuter").style.visibility = display_state;
    newUI.FindChildTraverse("StatBranch").style.visibility = display_state;
});