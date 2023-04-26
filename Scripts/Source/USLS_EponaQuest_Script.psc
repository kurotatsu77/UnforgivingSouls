Scriptname USLS_EponaQuest_Script extends Quest conditional

UnforgivingDevicesMain Property UDmain auto
int Property TreatCount Auto conditional

Function AddTreat()
    if TreatCount > 0
        TreatCount -= 1
    endif
    if TreatCount < 0
        TreatCount = 0
    endif
    if TreatCount > 0
        UDmain.Print("Epona neighs happily at the treat. " + TreatCount + " treat(s) left.")
    endif
EndFunction