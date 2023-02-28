Scriptname USLS_CustomSuit_RenderScript extends UD_CustomDevice_RenderScript  

import UnforgivingDevicesMain

Armor[] Property ListParts auto
Keyword[] Property ListKeywords auto
int Willpower = 0
int Property WillpowerIncrease = 10 auto
string Property SuitName = "SoulSuit" auto
float Property ActivationPeriod = 0.25 auto ; activation period in game days, 0.25 equals to 6 hours
float ActivationTimePassed = 0.0 ; how much game days passed since last activation
float Property TrialPeriod = 0.05 auto ; trial duration in days 0.04 roughly equals to 1 hour
Message[] Property ActivationMSG auto
bool TrialRunning
Sound[] Property CumForMe auto
int CumSoundInstance

EffectShader[] Property USLSShader auto
EffectShader ChosenShader
Sound ChosenSound

String[] Property TrialMessage auto
GlobalVariable Property SuitVariable auto
bool Property ConstantEffect = false auto

Function InitPost()
    UD_DeviceType = "Suit"
    TrialRunning = false
    AddParts()
    SuitVariable.SetValue(1)
    ;RegisterForModEvent("USLS_TrialEnd","OnTrialEnd")
EndFunction

;Event OnTrialEnd(string eventName, string strArg, float numArg, Form sender)
;    if strArg == "Success"
;        UDmain.Print("As you finish the trial " + getDeviceName() + " releases you from it's grip.")
;        UnlockParts()
;        unlockRestrain()
;    elseif strArg == "Fail"
;        UDmain.Print("As you fail the trial " + getDeviceName() + " drinks up on your willpower!")
;        Willpower = 0
;    endif
;EndEvent

Function AddParts()
    int loc_i
    int loc_inum
    loc_i = 0
    loc_inum = ListParts.Length
    if loc_inum < ListKeywords.Length
        loc_inum = ListKeywords.Length
    endif
    while loc_i < loc_inum
        if !GetWearer().wornhaskeyword(ListKeywords[loc_i])
            libs.LockDevice(GetWearer(),ListParts[loc_i])
        endif
        loc_i += 1
    endwhile
EndFunction

Function UnlockParts()
    int loc_i
    int loc_inum
    loc_i = 0
    loc_inum = ListParts.Length
    if loc_inum < ListKeywords.Length
        loc_inum = ListKeywords.Length
    endif
    while loc_i < loc_inum
        if GetWearer().wornhaskeyword(ListKeywords[loc_i])
            libs.UnLockDevice(GetWearer(),ListParts[loc_i], zad_DeviousDevice = ListKeywords[loc_i])
        endif
        loc_i += 1
    endwhile
EndFunction

float Function getAccesibility()
    float loc_res = parent.getAccesibility()
    
    if loc_res
        if getWearer().wornhaskeyword(libs.zad_DeviousArmCuffs)
            loc_res *= 0.75
        endif
        if getWearer().wornhaskeyword(libs.zad_DeviousLegCuffs)
            loc_res *= 0.75
        endif
        if getWearer().wornhaskeyword(libs.zad_DeviousCollar)
            loc_res *= 0.75
        endif
        if getWearer().wornhaskeyword(libs.zad_deviousharness)  && !deviceRendered.haskeyword(libs.zad_deviousharness)
            loc_res *= 0.25
        elseif getWearer().wornhaskeyword(libs.zad_deviousbelt) && !deviceRendered.haskeyword(libs.zad_deviousbelt)
            loc_res *= 0.5
        endif
    endif
    
    return ValidateAccessibility(loc_res)
EndFunction

Int Function GetAiPriority()
    return 30
EndFunction

Function OnUpdatePost(float timePassed) ;called on update. Is only called if wearer is registered
    parent.OnUpdatePost(timePassed)
    ActivationTimePassed = ActivationTimePassed + timePassed
    if !TrialRunning
        float loc_ActivationChance
        loc_ActivationChance = ActivationTimePassed / ActivationPeriod
        if Utility.randomFloat(0,1) < loc_ActivationChance
            ActivationTimePassed = 0.0
            SuitActivate()
        endif
    else
        if ActivationTimePassed >= TrialPeriod
            Sound.StopInstance(CumSoundInstance)
            ChosenShader.Stop(getWearer())
            if getWearer() == Game.GetPlayer()
                UDmain.Print("As you finish the edging trial " + getDeviceName() + " releases you from it's grip.")
            else 
                UDmain.Print("As " + getWearer().GetName() + " finishes the edging trial " + getDeviceName() + " releases it's grip.")
            endif
            SuitVariable.SetValue(0)
            UnlockParts()
            unlockRestrain()
        endif
    endif
EndFunction

Function SuitActivate()
    int loc_i
    int loc_ResistChance
    int loc_choice
    int loc_message
    if Utility.RandomInt(0,100) < Willpower
        loc_message = Utility.RandomInt(1,ActivationMSG.length) - 1
        loc_choice = ActivationMSG[loc_message].Show()
    else 
        loc_choice = 0 
    endif
    if loc_choice == 0 
        Willpower = Willpower + WillpowerIncrease
        if Willpower > 100
            Willpower = 100
        endif
        SuitAction()
    else
        ;SendModEvent("USLS_TrialStart",SuitName,1)
        SuitVariable.SetValue(0)
        TrialRunning = true
        Sound loc_sound
        String loc_TrialMessage
        loc_i = Utility.RandomInt(1,TrialMessage.length)
        loc_TrialMessage = TrialMessage[loc_i - 1]
        debug.messagebox(loc_TrialMessage)
        loc_i = Utility.RandomInt(1,CumForMe.length)
        loc_sound = CumForMe[loc_i - 1]
        CumSoundInstance = loc_sound.Play(getWearer())
        loc_i = Utility.RandomInt(1,USLSShader.length)
        ChosenShader = USLSShader[loc_i - 1]
        ChosenShader.Play(getWearer())
        ;fire off vibrations call goes here
        libs.VibrateEffect(GetWearer(), 99, 60, false)
        ;startVibEffect(GetWearer(), 99, 60, false)
        ;SexLabUtil.QuickStart(Game.GetPlayer(), getWearer(), animationTags = "Blowjob")
    endif
EndFunction

Function SuitAction()
    ;debug.messagebox(SuitName + " soul makes wearer do naughty things!")
    SuitVariable.SetValue(1)
EndFunction

Function OnOrgasmPost(bool sexlab = false) ;called on wearer orgasm. Is only called if OnOrgasmPre returns true. Is only called if wearer is registered
    ;parent.OnOrgasmPost(sexlab)
    if TrialRunning
        Sound.StopInstance(CumSoundInstance)
        ChosenShader.Stop(getWearer())
        if getWearer() == Game.GetPlayer()
            debug.messagebox(getDeviceName() + " absorbs your strength to resist it's influence!")
        else 
            UDmain.Print(getDeviceName() + " absorbs " + getWearer().GetName() + "'s strength to resist it's influence!")
        endif
        TrialRunning = false
        Willpower = 0
        SuitVariable.SetValue(1)
    elseif !TrialRunning && !ConstantEffect
        SuitVariable.SetValue(0)
    endif
EndFunction

;============================================================================================================================
;unused override function, theese are from base script. Extending different script means you also have to add their overrride functions                                                
;theese function should be on every object instance, as not having them may cause multiple function calls to default class
;more about reason here https://www.creationkit.com/index.php?title=Function_Reference, and Notes on using Parent section
;============================================================================================================================
Function safeCheck() ;called on init. Should be used to check if some properties are not filled, and fill them
    parent.safeCheck()
EndFunction
Function patchDevice() ;called on init. Should call patcher. Can also be dirrectly modified but should still use Patcher MCM variables
    parent.patchDevice()
EndFunction
Function activateDevice() ;Device custom activate effect. You need to create it yourself. Don't forget to remove parent.activateDevice() if you don't want parent effect
    parent.activateDevice()
EndFunction
bool Function canBeActivated() ;Switch. Used to determinate if device can be currently activated
    return parent.canBeActivated()
EndFunction
bool Function OnMendPre(float mult) ;called on device mend (regain durability)
    return parent.OnMendPre(mult)
EndFunction
Function OnMendPost(float mult) ;called on device mend (regain durability). Only called if OnMendPre returns true
    parent.OnMendPost(mult)
EndFunction
bool Function OnCritDevicePre() ;called on minigame crit
    return parent.OnCritDevicePre()
EndFunction
Function OnCritDevicePost() ;called on minigame crit. Is only called if OnCritDevicePre returns true 
    parent.OnCritDevicePost()
EndFunction
bool Function OnOrgasmPre(bool sexlab = false) ;called on wearer orgasm. Is only called if wearer is registered
    return parent.OnOrgasmPre(sexlab)
EndFunction
Function OnMinigameOrgasm(bool sexlab = false) ;called on wearer orgasm while in minigame. Is only called if wearer is registered
    parent.OnMinigameOrgasm(sexlab)
EndFunction
Function OnMinigameOrgasmPost() ;called on wearer orgasm while in minigame. Is only called after OnMinigameOrgasm. Is only called if wearer is registered
    parent.OnMinigameOrgasmPost()
EndFunction
Function OnMinigameStart() ;called when minigame start
    parent.OnMinigameStart()
EndFunction
Function OnMinigameEnd() ;called when minigame end
    parent.OnMinigameEnd()
EndFunction
Function OnMinigameTick(Float abUpdateTime) ;called every on every tick of minigame. Uses MCM performance setting
    parent.OnMinigameTick(abUpdateTime)
EndFunction
Function OnMinigameTick1() ;called every 1s of minigame
    parent.OnMinigameTick1()
EndFunction
Function OnMinigameTick3() ;called every 3s of minigame
    parent.OnMinigameTick3()
EndFunction
Function OnCritFailure() ;called on crit failure (wrong key pressed)
    parent.OnCritFailure()
EndFunction
Function OnDeviceCutted() ;called when device is cutted
    parent.OnDeviceCutted()
EndFunction
Function OnDeviceLockpicked() ;called when device is lockpicked
    parent.OnDeviceLockpicked()
EndFunction
Function OnLockReached() ;called when device lock is reached
    parent.OnLockReached()
EndFunction
Function OnLockJammed() ;called when device lock is jammed
    parent.OnLockJammed()
EndFunction
Function OnDeviceUnlockedWithKey() ;called when device is unlocked with key
    parent.OnDeviceUnlockedWithKey()
EndFunction
Function OnUpdatePre(float timePassed) ;called on update. Is only called if wearer is registered
    parent.OnUpdatePre(timePassed)
EndFunction
bool Function OnCooldownActivatePre()
    return parent.OnCooldownActivatePre()
EndFunction
Function OnCooldownActivatePost()
    parent.OnCooldownActivatePost()
EndFunction
Function DeviceMenuExt(int msgChoice)
    parent.DeviceMenuExt(msgChoice)
EndFunction
Function DeviceMenuExtWH(int msgChoice)
    parent.DeviceMenuExtWH(msgChoice)
EndFunction
bool Function OnUpdateHourPre()
    return parent.OnUpdateHourPre()
EndFunction
bool Function OnUpdateHourPost()
    return parent.OnUpdateHourPost()
EndFunction
Function onDeviceMenuInitPost(bool[] aControl)
    parent.onDeviceMenuInitPost(aControl)
EndFunction
Function onDeviceMenuInitPostWH(bool[] aControl)
    parent.onDeviceMenuInitPostWH(aControl)
EndFunction
Function InitPostPost()
    parent.InitPostPost()
EndFunction
Function OnRemoveDevicePre(Actor akActor)
    parent.OnRemoveDevicePre(akActor)
EndFunction
Function onRemoveDevicePost(Actor akActor)
    parent.onRemoveDevicePost(akActor)
EndFunction
Function onLockUnlocked(bool lockpick = false)
    parent.onLockUnlocked(lockpick)
EndFunction
Function onSpecialButtonPressed(float fMult)
    parent.onSpecialButtonPressed(fMult)
EndFunction
Function onSpecialButtonReleased(Float fHoldTime)
    parent.onSpecialButtonReleased(fHoldTime)
EndFunction
bool Function onWeaponHitPre(Weapon source)
    return parent.onWeaponHitPre(source)
EndFunction
Function onWeaponHitPost(Weapon source)
    parent.onWeaponHitPost(source)
EndFunction
bool Function onSpellHitPre(Spell source)
    return parent.onSpellHitPre(source)
EndFunction
Function onSpellHitPost(Spell source)
    parent.onSpellHitPost(source)
EndFunction
string Function addInfoString(string str = "")
    return parent.addInfoString(str)
EndFunction
Function updateWidget(bool force = false)
    parent.updateWidget(force)
EndFunction
Function updateWidgetColor()
    parent.updateWidgetColor()
EndFunction
bool Function proccesSpecialMenu(int msgChoice)
    return parent.proccesSpecialMenu(msgChoice)
EndFunction
bool Function proccesSpecialMenuWH(Actor akSource,int msgChoice)
    return parent.proccesSpecialMenuWH(akSource,msgChoice)
EndFunction
int Function getArousalRate()
    return parent.getArousalRate()
EndFunction
float Function getStruggleOrgasmRate()
    return parent.getStruggleOrgasmRate()
EndFunction
Float[] Function GetCurrentMinigameExpression()
	return parent.GetCurrentMinigameExpression()
EndFunction