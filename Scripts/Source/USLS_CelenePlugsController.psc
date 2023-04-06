Scriptname USLS_CelenePlugsController extends activemagiceffect  

zadLibs Property libs Auto
zadBQ00 Property zadQuest Auto
zadDeviousMagic Property zadMagic Auto

Actor Property PlayerRef Auto

GlobalVariable Property USLS_Enemalevel auto

Faction Property SLArousedFaction Auto



Event OnEffectStart(Actor akTarget, Actor akCaster)
	

	
	If USLS_Enemalevel.GetValue ()   == 0  
	libs.VibrateEffect(PlayerRef, 1, 1, true, false)

	ElseIf USLS_Enemalevel.GetValue ()   == 1  
	libs.VibrateEffect(PlayerRef, 2, 1, true, false)

	ElseIf USLS_Enemalevel.GetValue ()   == 2  
	libs.VibrateEffect(PlayerRef, 3, 1, true, false)

	ElseIf USLS_Enemalevel.GetValue ()   == 3  
	libs.VibrateEffect(PlayerRef, 4, 1, true, false)

	ElseIf USLS_Enemalevel.GetValue ()   > 3 
	libs.VibrateEffect(PlayerRef, 5, 5, false, false)


	
	endif
	
	EndEvent
	


Event OnEffectFinish(Actor akTarget, Actor akCaster)
If USLS_Enemalevel.GetValue ()   > 3  

PlayerRef.SetFactionRank(SLArousedFaction, 100) 

endif

if libs.IsVibrating(playerref) == true
		libs.StopVibrating(playerref)
	endif
	
		
EndEvent