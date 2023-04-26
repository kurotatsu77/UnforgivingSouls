Scriptname USLS_SuitEpona_RenderScript extends USLS_CustomSuit_RenderScript  

USLS_EponaQuest_Script Property EponaQuest auto
int Property TreatCount = 10 Auto

Function InitPost()
    parent.InitPost()
    UD_DeviceType = "StraitJacket"
    EponaQuest.Stop()
    EponaQuest.Reset()
    EponaQuest.Start()
    EponaQuest.TreatCount = TreatCount
    UDmain.Print("Epona whinnies, demanding " + TreatCount + " treats to be received from people.")
EndFunction

Function SuitActivate()
EndFunction

Function SuitAction()
    ;parent.SuitAction()
EndFunction

Function OnUpdatePost(float timePassed) ;called on update. Is only called if wearer is registered
    ;parent.OnUpdatePost(timePassed)
    if EponaQuest.TreatCount < 1
        UDmain.Print("Epona whinnies happily as she gets her fill of treats and releases you!")
        EponaQuest.Stop()
        UnlockParts()
        Utility.Wait(1)
        if KindredSouls.Length > 0
            KindredSoulsChance = USLSMCM.KindredSoulsChance
            int loc_i
            float loc_rnd
            loc_rnd = Utility.RandomFloat(0,1)
            if loc_rnd < KindredSoulsChance
                loc_i = Utility.RandomInt(1,KindredSouls.Length)
                if getWearer() == Game.GetPlayer()
                    UDmain.Print("But suddenly another soul grabs your body!")
                else 
                    UDmain.Print("But suddenly another soul grabs " + getWearer().GetName() + "'s body!")
                endif    
                libs.SwapDevices(getWearer(),KindredSouls[loc_i - 1], libs.zad_DeviousSuit, true)
            else
                unlockRestrain()
            endif
        else
            unlockRestrain()
        endif
    endif
ENdFunction