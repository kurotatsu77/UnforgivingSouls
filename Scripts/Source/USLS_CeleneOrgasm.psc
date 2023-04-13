Scriptname USLS_CeleneOrgasm extends activemagiceffect
Actor Property PlayerRef Auto
zadLibs Property libs Auto
Faction Property SLArousedFaction Auto
Potion Property Skooma  Auto  
Potion Property Skooma2  Auto  
GlobalVariable Property USLS_Enemalevel auto

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

Event OnEffectStart(Actor akTarget, Actor akCaster)
RegisterForSingleUpdate(10.0)	
EndEvent

Event OnUpdate() ; This event occurs every five seconds
   If  USLS_Enemalevel.GetValue ()  < 5
		Debug.MessageBox ("The plugs Finally decide to release you from their torment, as you feel your orgasm approach they have one last suprise in store for you")
		SendFHUInflationEvent(Game.GetPlayer(),true,2,1,1,"")
		PlayerRef.AddItem(Skooma,1,True)
		PlayerRef.EquipItem(Skooma,1,True)
		libs.Notify("The Anal Plug Squirts another dose.")
		USLS_Enemalevel.SetValue(USLS_Enemalevel.GetValue() + 1)
		RegisterForSingleUpdate(20.0)
	ElseIf USLS_Enemalevel.GetValue () < 10
        	Game.DisablePlayerControls()
        	SendFHUInflationEvent(Game.GetPlayer(),true,2,1,1,"")
		PlayerRef.AddItem(Skooma,1,True)
		PlayerRef.EquipItem(Skooma,1,True)
		libs.Notify("The Anal Plug Squirts another dose.")
		Utility.Wait(10)
		SendFHUInflationEvent(Game.GetPlayer(),true,1,1,1,"")
		PlayerRef.AddItem(Skooma2,1,True)
		PlayerRef.EquipItem(Skooma2,1,True)
		libs.Notify("The Vaginal Plug Squirts another dose.")
		USLS_Enemalevel.SetValue(USLS_Enemalevel.GetValue() + 1)
		RegisterForSingleUpdate(20.0) ;do every 5 seconds until stopped vibrating and animating
	else
      		Armor loc_Hood = libs.getWornDevice(PlayerRef,libs.zad_DeviousHood)
		libs.UnlockDevice(PlayerRef, deviceInventory = loc_Hood, zad_DeviousDevice = libs.zad_DeviousHood, destroydevice = true, genericonly = true)
		Armor loc_Gloves = libs.getWornDevice(PlayerRef,libs.zad_DeviousGloves)
		libs.UnlockDevice(PlayerRef, deviceInventory = loc_Gloves, zad_DeviousDevice = libs.zad_DeviousGloves, destroydevice = true, genericonly = true)
   		Armor loc_Boots = libs.getWornDevice(PlayerRef,libs.zad_DeviousBoots)
		libs.UnlockDevice(PlayerRef, deviceInventory = loc_Boots, zad_DeviousDevice = libs.zad_DeviousBoots, destroydevice = true, genericonly = true)
		Armor loc_Corset = libs.getWornDevice(PlayerRef,libs.zad_DeviousCorset)
		libs.UnlockDevice(PlayerRef, deviceInventory = loc_Corset, zad_DeviousDevice = libs.zad_DeviousCorset, destroydevice = true, genericonly = true)
   		Armor loc_suit = libs.getWornDevice(PlayerRef,libs.zad_DeviousSuit)
		libs.UnlockDevice(PlayerRef, deviceInventory = loc_suit, zad_DeviousDevice = libs.zad_DeviousSuit, destroydevice = true, genericonly = true)
   		Debug.MessageBox ("Finally the torment is over. You look down at your poor abused swollen body, Your vision still blured by all the drugs inside you. But at least Celene has gone")
		Utility.Wait(5)
		Armor loc_Yoke = libs.getWornDevice(PlayerRef,libs. zad_DeviousHeavyBondage)
		libs.UnlockDevice(PlayerRef, deviceInventory = loc_Yoke, zad_DeviousDevice = libs. zad_DeviousHeavyBondage, destroydevice = true, genericonly = true)
		Armor loc_PlugV = libs.getWornDevice(PlayerRef,libs.zad_DeviousPlugVaginal)
		libs.UnlockDevice(PlayerRef, deviceInventory = loc_PlugV, zad_DeviousDevice = libs.zad_DeviousPlugVaginal, destroydevice = true, genericonly = true)
		Armor loc_PlugA = libs.getWornDevice(PlayerRef,libs.zad_DeviousPlugAnal)
		libs.UnlockDevice(PlayerRef, deviceInventory = loc_PlugA, zad_DeviousDevice = libs.zad_DeviousPlugAnal, destroydevice = true, genericonly = true)
		Debug.MessageBox ("Untill the next time!")
	EndIf
EndEvent







