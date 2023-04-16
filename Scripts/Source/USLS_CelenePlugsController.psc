Scriptname USLS_CelenePlugsController extends activemagiceffect

zadLibs Property libs Auto
zadBQ00 Property zadQuest Auto
zadDeviousMagic Property zadMagic Auto
Actor Property PlayerRef Auto
GlobalVariable Property USLS_Enemalevel auto
    
Event OnEffectStart(Actor akTarget, Actor akCaster)
    If USLS_Enemalevel.GetValue ()   == 0
        libs.VibrateEffect(PlayerRef, 1, 100, true, false)
    ElseIf USLS_Enemalevel.GetValue ()   == 1
        libs.VibrateEffect(PlayerRef, 2, 100, true, false)
    ElseIf USLS_Enemalevel.GetValue ()   == 2
        libs.VibrateEffect(PlayerRef, 3, 100, true, false)
    ElseIf USLS_Enemalevel.GetValue ()   == 3
        libs.VibrateEffect(PlayerRef, 4, 100, true, false)
    ElseIf USLS_Enemalevel.GetValue ()   > 3 
        libs.VibrateEffect(PlayerRef, 5, 100, false, false)
	EndIF
EndEvent