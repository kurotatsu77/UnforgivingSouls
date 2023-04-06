Scriptname USLS_Cum extends activemagiceffect  

GlobalVariable Property USLS_Enemalevel auto

Potion Property Skooma  Auto 

imageSpaceModifier property dunSleepingTreeCampISMD auto

Function SendFHUInflationEvent(form inflater, Bool Inflation, int poolmask, float amount, int time, string callback)
        Int handle = ModEvent.Create("SR_InflateEvent")
        ModEvent.PushForm(handle, inflater)
        ModEvent.PushBool(handle, Inflation)
        ModEvent.PushInt(handle, poolmask)
        ModEvent.PushFloat(handle, amount)
        ModEvent.PushInt(handle, time)
        ModEvent.PushString(handle, callback)
        ModEvent.Send(handle)
    EndFunction

Event OnEffectStart(Actor akTarget,Actor akCaster)



SendFHUInflationEvent(Game.GetPlayer(),true,2,1,1,"")

akTarget.AddItem(Skooma,1,True)
akTarget.EquipItem(Skooma,1,True)

if akTarget == game.GetPlayer()
		dunSleepingTreeCampISMD.apply(1.0)
	endif

Utility.Wait(1)

USLS_Enemalevel.SetValue(USLS_Enemalevel.GetValue() + 1)

If USLS_Enemalevel.GetValue ()   == 1  
Debug.MessageBox("You feel the anal plug start to twitch then suddenly it shoots something deep inside you. It feels warm and sticky, then just like your pussy your arse starts to burn and your head feels like its split in two")
   ElseIf USLS_Enemalevel.GetValue ()   == 2  
Debug.MessageBox("Still full from the last time the plug squirts another load of the hot subtance up your arse")
  ElseIf USLS_Enemalevel.GetValue ()  == 3
Debug.MessageBox("The plug is determined to give you an enema, you feel your belly starting to swell with all the glutinous inside you") 
else
Debug.MessageBox("Your poor swollen insides are further expanded by yet another load of sticky syrup. Plugged as you are there is no way to release it, you feel like you are full to bursting. Is there no end to this torment?")
EndIf
EndEvent