Scriptname USLS_CelenePlugsStop extends activemagiceffect  

zadLibs Property libs Auto
zadBQ00 Property zadQuest Auto
zadDeviousMagic Property zadMagic Auto
Actor Property PlayerRef Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if libs.IsVibrating(playerref) == true
		libs.StopVibrating(playerref)
	endif
EndEvent
	