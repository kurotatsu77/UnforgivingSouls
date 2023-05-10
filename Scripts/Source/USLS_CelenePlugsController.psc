Scriptname USLS_CelenePlugsController extends activemagiceffect

zadlibs_UDPatch Property UDLibs Auto 
zadLibs Property libs Auto
zadBQ00 Property zadQuest Auto
zadDeviousMagic Property zadMagic Auto
Actor Property PlayerRef Auto
GlobalVariable Property USLS_Enemalevel auto
USLS_UD_CelenePlug_RenderScript Property Plug Auto Hidden
int Property kSlotMask57 = 0x08000000 AutoReadOnly
Event OnEffectStart(Actor akTarget, Actor akCaster)
    Armor plugObject = akTarget.GetWornForm(kSlotMask57) as Armor
    Plug = UDLibs.UDCDMain.getNPCSlot(akTarget).getDeviceByRender(plugObject) as USLS_UD_CelenePlug_RenderScript
    ;Plug = UDLibs.UDCDMain.getNPCSlot(akTarget).getslotForm(27);UDLibs.UDCDMain.getDeviceScriptByRender(akTarget, plugObject) as USLS_UD_CelenePlug_RenderScript
    if plug 
        debug.notification("Script found")
    endif
    If USLS_Enemalevel.GetValue()   == 0
        ;debug.notification("Vibrate")
        ;libs.VibrateEffect(PlayerRef, 1, 100, true, false)
        Plug.ForceStrength(10)
        Plug.forceDuration(100)
        Plug.forceEdgingMode(1)
        Plug.Vibrate()
        ;Plug.UD_EdgingMode = 
    ElseIf USLS_Enemalevel.GetValue()   == 1
        ;debug.notification("Vibrate")
        ;libs.VibrateEffect(PlayerRef, 2, 100, true, false)
        Plug.ForceStrength(25)
        Plug.forceDuration(100)
        Plug.forceEdgingMode(1)
        Plug.Vibrate()
    ElseIf USLS_Enemalevel.GetValue()   == 2
        Plug.ForceStrength(40)
        Plug.forceDuration(100)
        Plug.forceEdgingMode(1)
        Plug.Vibrate()
	  ;debug.notification("Vibrate")
        ;libs.VibrateEffect(PlayerRef, 3, 100, true, false)
    ElseIf USLS_Enemalevel.GetValue()   == 3
         Plug.ForceStrength(65)
        Plug.forceDuration(100)
        Plug.forceEdgingMode(1)
        Plug.Vibrate()
	  ;debug.notification("Vibrate")
        ;libs.VibrateEffect(PlayerRef, 4, 100, true, false)
    ElseIf USLS_Enemalevel.GetValue()   > 3
        Plug.ForceStrength(85)
        Plug.forceDuration(1000)
        Plug.forceEdgingMode(0)
        Plug.Vibrate()
	  ;debug.notification("Vibrate") 
        ;libs.VibrateEffect(PlayerRef, 5, 100, false, false)
	EndIF
    miscutil.printconsole("Enema: "+USLS_Enemalevel.GetValue()+"  Vibrate: ")
EndEvent