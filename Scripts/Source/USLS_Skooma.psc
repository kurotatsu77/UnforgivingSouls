Scriptname USLS_Skooma extends activemagiceffect  



EffectShader Property USLS_SkoomaES Auto

GlobalVariable Property USLS_Druglevel auto

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

Potion Property Skooma  Auto  


Event OnEffectStart(Actor akTarget,Actor akCaster)



SendFHUInflationEvent(Game.GetPlayer(),true,1,1,1,"")

akTarget.AddItem(Skooma,1,True)
akTarget.EquipItem(Skooma,1,True)

If akTarget == game.GetPlayer()
		USLS_SkoomaES.Play(akTarget,110)

endif

Utility.Wait(1)

USLS_Druglevel.SetValue(USLS_Druglevel.GetValue() + 1)

If USLS_Druglevel.GetValue ()   == 1  
	Debug.MessageBox("The Vaginal Plug Squirts something inside you. Your head starts to spin and vivid colours flash through your mind, slowly they form into images of your desire to touch your teased pussy")
elseIf USLS_Druglevel.GetValue () == 2
	Debug.MessageBox("Just as your head starts to clear the plug pumps more of the gooey liquid into your pussy, the need to touch it is overwellming. You tug at the yoke to free your hands but to no avail")

elseIf USLS_Druglevel.GetValue () == 3
	Debug.MessageBox("'Please no more' you scream into your gag but the plug pumps another load deep into your stretched belly") 

else
Debug.MessageBox("Unable to think anymore and consumed by your desire your pussy clenches round the plug, milking more of the substance out of it")

EndIf

EndEvent
