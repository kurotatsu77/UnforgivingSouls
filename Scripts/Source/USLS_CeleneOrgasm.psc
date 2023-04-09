Scriptname USLS_CeleneOrgasm extends activemagiceffect

GlobalVariable Property USLS_Orgasmlevel auto

Actor Property PlayerRef Auto

zadLibs Property libs Auto

Faction Property SLArousedFaction Auto

actor Target

Event OnEffectStart(Actor akTarget, Actor akCaster)
    debug.notification("OnEffectStart ran")
    Target = akTarget
    if Target == PlayerRef
        RegisterForModEvent("DeviceActorOrgasm", "yourCatch")
        debug.notification("yourCatch event registered")
    endif
endevent

Event yourCatch(string eventName, string argString, float argNum, form sender)
    int orgasmlevel = USLS_Orgasmlevel.GetValueint()

    debug.notification("yourCatch event triggered")
    debug.notification("USLS_Orgasmlevel value: " + orgasmlevel)

    USLS_Orgasmlevel.SetValue(orgasmlevel + 1)
    If orgasmlevel == 1
        Debug.MessageBox("The plugs finally allow you a glorious orgasm in exchange for all the torment, just as you start to come down you feel another squirt from the plugs. Your arousal instantly spikes and one orgasm flows into another as ther are forced from your abused swollen body")
        utility.wait(0.1)
        PlayerRef.SetFactionRank(SLArousedFaction, 100) 
    EndIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    If USLS_Orgasmlevel.GetValue () == 4 && Target == PlayerRef
        Armor loc_suit = libs.getWornDevice(akTarget,libs.zad_DeviousSuit)
        libs.UnlockDevice(akTarget, deviceInventory = loc_suit, zad_DeviousDevice = libs.zad_DeviousSuit, destroydevice = true, genericonly = true)
    EndIf

    UnregisterForModEvent("DeviceActorOrgasm")
    UnregisterForUpdateGameTime()
    debug.notification("OnEffectFinish ran")
EndEvent


Event OnLoad()
    if Target == PlayerRef
        RegisterForModEvent("DeviceActorOrgasm", "yourCatch")
    Endif
EndEvent