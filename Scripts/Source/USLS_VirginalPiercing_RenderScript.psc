Scriptname USLS_VirginalPiercing_RenderScript extends UD_CustomVibratorBase_RenderScript  

import UnforgivingDevicesMain
USLS_MCM Property USLSMCM auto

Armor[] Property USLS_Suits Auto

int TrialRunning = 0 ; 0 - not running, 1 - piercing trial, 2 - suit trial
int Property TrialsTotal = 3 auto
int TrialsLeft

Sound[] Property CumForMe auto
int CumSoundInstance

EffectShader[] Property USLSShader auto
EffectShader ChosenShader
Sound ChosenSound

Keyword Property CeleneSuit auto

;TextureSet Property USLSPiercingNormalTXST auto
;TextureSet Property USLSPiercingGlowTXST auto

;Armor _PiercingGlow
;Armor Property USLS_PiercingGlow
;    Armor Function Get()
;        if !_PiercingGlow
;            _PiercingGlow = GetMeMyForm(0x000D87, "Unforgiving Souls.esp") as Armor
;        endif
;        return _PiercingGlow
;    EndFunction
;    Function Set(Armor akArmor)
;        _PiercingGlow = akArmor
;    EndFunction
;EndProperty

;ArmorAddon _PiercingGlowAA
;ArmorAddon Property PiercingGlowAA
;    ArmorAddon Function Get()
;        if !_PiercingGlowAA
;            _PiercingGlowAA = GetMeMyForm(0x000D7F, "Unforgiving Souls.esp") as ArmorAddon
;        endif
;        return _PiercingGlowAA
;    EndFunction
;    Function Set(ArmorAddon akArmorAA)
;        _PiercingGlowAA = akArmorAA
;    EndFunction
;EndProperty

;ArmorAddon Property PiercingAA auto
;ArmorAddon Property PiercingGlowAA auto

;string Property NormalAAModelPath auto
;string Property GlowAAModelPath auto

Function InitPost()
    parent.InitPost()
    UD_DeviceType = "Piercing"
    TrialsLeft = TrialsTotal
    ;RegisterForModEvent("USLS_TrialStart","OnTrialStart")
    ;PiercingAA = USLS_Piercing.GetNthArmorAddon(0)
    ;PiercingGlowAA = USLS_PiercingGlow.GetNthArmorAddon(0)
    ;NormalAAModelPath = PiercingAA.GetModelPath(false, true)
    ;GlowAAModelPath = PiercingGlowAA.GetModelPath(false, true)
EndFunction

;Event OnTrialStart(string eventName, string strArg, float numArg, Form sender)
;    Sound loc_sound
;    int loc_i
;    if strArg == "Karma" && TrialRunning == 0
;        TrialRunning = 2
;        if getWearer() == Game.GetPlayer()
;            UDmain.Print(getDeviceName() + " starts your edging trial for Karma suit!")
;        else 
;            UDmain.Print(getDeviceName() + " starts " + getWearer().GetName() + "'s edging trial for Karma suit!")
;        endif
;        loc_i = Utility.RandomInt(1,CumForMe.length) ; change these to suit specific ones if needed
;        loc_sound = CumForMe[loc_i - 1]
;        CumSoundInstance = loc_sound.Play(getWearer())
;        loc_i = Utility.RandomInt(1,USLSShader.length)
;        ChosenShader = USLSShader[loc_i - 1]
;        ChosenShader.Play(getWearer())
;        VibrateStart()
;    elseif strArg == "Celene" && TrialRunning == 0
;        TrialRunning = 2
;        if getWearer() == Game.GetPlayer()
;            UDmain.Print(getDeviceName() + " starts your edging trial for Celene suit!")
;        else 
;            UDmain.Print(getDeviceName() + " starts " + getWearer().GetName() + "'s edging trial for Celene suit!")
;        endif
;        loc_i = Utility.RandomInt(1,CumForMe.length) ; change these to suit specific ones if needed
;        loc_sound = CumForMe[loc_i - 1]
;        CumSoundInstance = loc_sound.Play(getWearer())
;        loc_i = Utility.RandomInt(1,USLSShader.length)
;        ChosenShader = USLSShader[loc_i - 1]
;        ChosenShader.Play(getWearer())
;        VibrateStart()
;    endif
;EndEvent

Function patchDevice()
    ;UDCDmain.UDPatcher.patchPiercing(self)
EndFunction

int Function getArousalRate()
    if UD_DeviceKeyword == libs.zad_deviousPiercingsNipple
        return parent.getArousalRate() + 2
    else
        return parent.getArousalRate() + 4
    endif
EndFunction

Function onDeviceMenuInitPost(Bool[] aControlFilter)
    parent.onDeviceMenuInitPost(aControlFilter)
    if (isPiercing(True,False) && wearerHaveBra()) || (isPiercing(False,True) && wearerHaveBelt())
        UDCDMain.disableStruggleCondVar(true)
    endif
EndFunction

Function onDeviceMenuInitPostWH(Bool[] aControlFilter)
    parent.onDeviceMenuInitPostWH(aControlFilter)
    
    if (isPiercing(True,False) && wearerHaveBra()) || (isPiercing(False,True) && wearerHaveBelt())
        UDCDMain.disableStruggleCondVar(true)
    endif
EndFunction

float Function getAccesibility()
    float loc_res = 1.0
    
    if (isPiercing(True,False) && wearerHaveBra()) || (isPiercing(False,True) && wearerHaveBelt())
        loc_res = 0.0
    else
        if getWearer().wornhaskeyword(libs.zad_DeviousHeavyBondage)
            loc_res *= 0.25
        elseif getWearer().wornhaskeyword(libs.zad_DeviousBondageMittens)
            loc_res *= 0.5
        endif
        
        if getWearer().wornhaskeyword(libs.zad_DeviousSuit)
            loc_res *= 0.75
        endif
    endif
    return ValidateAccessibility(loc_res)
EndFunction

Function OnVibrationStart()
    UD_ArousalMult = USLSMCM.VibeMultiply
    if !getWearer().wornhaskeyword(libs.zad_deviousSuit) && TrialRunning == 0
        TrialRunning = 1
        if getWearer() == Game.GetPlayer()
            UDmain.Print(getDeviceName() + " starts your edging trial!")
        else 
            UDmain.Print(getDeviceName() + " starts " + getWearer().GetName() + "'s edging trial!")
        endif
        ;PiercingAA.SetModelPath(GlowAAModelPath, false, true)
        ;getWearer().addItem(USLS_PiercingGlow,1)
        ;getWearer().EquipItem(USLS_PiercingGlow,true,true)
        Sound loc_sound
        int loc_i
        loc_i = Utility.RandomInt(1,CumForMe.length)
        loc_sound = CumForMe[loc_i - 1]
        CumSoundInstance = loc_sound.Play(getWearer())
        Sound.SetInstanceVolume(CumSoundInstance, USLSMCM.SoundsVolume)
        loc_i = Utility.RandomInt(1,USLSShader.length)
        ChosenShader = USLSShader[loc_i - 1]
        ChosenShader.Play(getWearer())
        ;PO3_SKSEfunctions.ReplaceArmorTextureSet(getWearer(), DeviceInventory, USLSPiercingNormalTXST, USLSPiercingGlowTXST)
    endif
EndFunction

Function OnVibrationEnd()
    if TrialRunning == 1
        TrialsLeft -= 1
        TrialRunning = 0
        if getWearer() == Game.GetPlayer()
            if TrialsLeft < 1
                UDmain.Print("As you finish the last trial " + getDeviceName() + " releases your clitoris from it's grip.")
                libs.unlockdevice(getWearer(), DeviceInventory, DeviceRendered, zad_DeviousDevice = libs.zad_DeviousPiercingsVaginal)
            else
                UDmain.Print(getDeviceName() + " finishes edging trial. " + TrialsLeft + " left.")                
            endif
        else 
            if TrialsLeft < 1
                UDmain.Print("As " + getWearer().GetName() + "finishes the last trial " + getDeviceName() + " releases her clitoris from it's grip.")
                libs.unlockdevice(getWearer(), DeviceInventory, DeviceRendered, zad_DeviousDevice = libs.zad_DeviousPiercingsVaginal)
            else
                UDmain.Print(getDeviceName() + " finishes " + getWearer().GetName() + "'s edging trial.")
            endif
        endif
        ;PiercingAA.SetModelPath(NormalAAModelPath, false, true)
        ;getWearer().UnEquipItem(USLS_PiercingGlow,true,true)
        Sound.StopInstance(CumSoundInstance)
        ChosenShader.Stop(getWearer())
        ;PO3_SKSEfunctions.ResetActor3D(getWearer())
    ;elseif TrialRunning == 2
    ;    SendModEvent("USLS_TrialEnd","Success",1)
    ;    TrialRunning = 0
    ;    Sound.StopInstance(CumSoundInstance)
    ;    ChosenShader.Stop(getWearer())
    endif
EndFunction

Function OnOrgasmPost(bool sexlab = false) ;called on wearer orgasm. Is only called if OnOrgasmPre returns true. Is only called if wearer is registered
    ;parent.OnOrgasmPost(sexlab)
    if TrialRunning
        Sound.StopInstance(CumSoundInstance)
        ChosenShader.Stop(getWearer())
        TrialRunning = 0
        TrialsLeft = TrialsTotal
        if !getWearer().wornhaskeyword(libs.zad_deviousSuit)
            EquipUSLSSuit()
            if getWearer() == Game.GetPlayer()
                UDmain.Print(getDeviceName() + " punishes you for failing edging trial!")
            else 
                UDmain.Print(getDeviceName() + " punishes " + getWearer().GetName() + " for failing edging trial!")
            endif
        endif
    ;elseif TrialRunning == 2
    ;    SendModEvent("USLS_TrialEnd","Fail",1)
    ;    TrialRunning = 0
    ;    Sound.StopInstance(CumSoundInstance)
    ;    ChosenShader.Stop(getWearer())
    endif
EndFunction

Function EquipUSLSSuit()
    int loc_randomsuit
    loc_randomsuit = Utility.RandomInt(1,USLS_Suits.Length) - 1
    libs.lockdevice(getWearer(), USLS_Suits[loc_randomsuit])
EndFunction

Int Function GetAiPriority()
    return 1
EndFunction

Function OnMinigameStart() ;called when minigame start
    parent.OnMinigameStart()
    PunishWearer()
EndFunction

Function OnDeviceLockpicked() ;called when device is lockpicked
    parent.OnDeviceLockpicked()
    ;PunishWearer()
EndFunction

Function OnLockJammed() ;called when device lock is jammed
    parent.OnLockJammed()
    ;PunishWearer()
EndFunction

Function OnLockReached() ;called when device lock is reached
    parent.OnLockReached()
    ;PunishWearer()
EndFunction

Function PunishWearer()
    if getWearer() == Game.GetPlayer()
        UDmain.Print(getDeviceName() + " punishes you for trying to escape!")
    else 
        UDmain.Print(getDeviceName() + " punishes " + getWearer().GetName() + " for trying to escape!")
    endif
    Utility.Wait(1)
    StopMinigame()
    Utility.Wait(1)
    ManifestBondage(getWearer())
EndFunction

Function ManifestBondage (Actor akActor)
    int _randomDevice
    ; heavy bondage or straitjackets first
    if (!akActor.WornhasKeyword(libs.zad_DeviousHeavyBondage))
        if (!akActor.WornhasKeyword(libs.zad_DeviousSuit))
            _randomDevice = Utility.randomInt(0,400) ; 101-400 is for straitjackets, they have bigger weight to be seen more because catsuits block them
        else
            _randomDevice = Utility.randomInt(0,100)
        endif
        if _randomDevice < 20
            libs.LockDevice(akActor,UDlibs.AbadonElbowbinderEbonite)
        elseif _randomDevice < 40
            libs.LockDevice(akActor,UDlibs.AbadonArmbinderEbonite)
        elseif _randomDevice < 60
            libs.LockDevice(akActor,UDlibs.AbadonArmbinder)
        elseif _randomDevice < 80
            libs.LockDevice(akActor,UDlibs.RogueBinder)
        elseif _randomDevice < 90
            libs.LockDevice(akActor,UDlibs.PunisherArmbinder)
        elseif _randomDevice < 101
            libs.LockDevice(akActor,UDlibs.AbadonBlueArmbinder)
        ;straitjackets section
        elseif _randomDevice < 200
            libs.LockDevice(akActor,UDlibs.AbadonStraitjacketEbonite)
        elseif _randomDevice < 300
            libs.LockDevice(akActor,UDlibs.AbadonStraitjacketEboniteOpen)
        elseif _randomDevice < 350
            libs.LockDevice(akActor,UDlibs.AbadonStraitjacket)
        elseif _randomDevice < 380
            libs.LockDevice(akActor,UDlibs.MageBinder)
        else
            libs.LockDevice(akActor,UDlibs.AbadonCursedStraitjacket)    
        endif
    endif
EndFunction

Function activateDevice() ;Device custom activate effect. You need to create it yourself. Don't forget to remove parent.activateDevice() if you don't want parent effect
    if !getWearer().wornhaskeyword(CeleneSuit)
        parent.activateDevice()
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
Function OnDeviceUnlockedWithKey() ;called when device is unlocked with key
    parent.OnDeviceUnlockedWithKey()
EndFunction
Function OnUpdatePre(float timePassed) ;called on update. Is only called if wearer is registered
    parent.OnUpdatePre(timePassed)
EndFunction
Function OnUpdatePost(float timePassed) ;called on update. Is only called if wearer is registered
    parent.OnUpdatePost(timePassed)
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
bool Function proccesSpecialMenu(int msgChoice)
    return parent.proccesSpecialMenu(msgChoice)
EndFunction
bool Function proccesSpecialMenuWH(Actor akSource,int msgChoice)
    return parent.proccesSpecialMenuWH(akSource,msgChoice)
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
float Function getStruggleOrgasmRate()
    return parent.getStruggleOrgasmRate()
EndFunction
Float[] Function GetCurrentMinigameExpression()
	return parent.GetCurrentMinigameExpression()
EndFunction