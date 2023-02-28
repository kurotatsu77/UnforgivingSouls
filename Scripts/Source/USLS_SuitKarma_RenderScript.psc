Scriptname USLS_SuitKarma_RenderScript extends USLS_CustomSuit_RenderScript  

Function SuitAction()
    parent.SuitAction()
    UDmain.Print("Karma searches for the next cock to suck!")
    if getWearer().wornhaskeyword(libs.zad_deviousGag) && !getWearer().wornhaskeyword(libs.zad_PermitOral)
        Armor loc_gag
        loc_gag = libs.getWornDevice(getWearer(),libs.zad_DeviousGag) 
        if libs.UnlockDevice(getWearer(), deviceInventory = loc_gag, zad_DeviousDevice = libs.zad_DeviousGag, destroydevice = true, genericonly = true) ; we still respect quest items, can't break quests
            UDmain.Print("Karma chews the nasty gag away. Nothing can stand in way of getting her fix!")
        endif
    endif
EndFunction

