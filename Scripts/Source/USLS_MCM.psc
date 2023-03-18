Scriptname USLS_MCM extends SKI_ConfigBase

int Property version auto
float Property VibeMultiply auto
bool Property PiercingRegistered auto
LeveledItem Property zad_DeviousPiercingsVaginal auto
Armor Property VirginalPiercing auto
float Property KindredSoulsChance = 0.50 auto

int VibeMultiplyMenu_S
int KindredSoulsChance_S
int PiercingRegistered_T
String _lastPage

Event OnGameReload()
	parent.OnGameReload()
	Return
EndEvent

Event OnVersionUpdate(Int ver)
	OnConfigInit()
	Return
EndEvent

Int Function GetVersion()
	OnConfigInit()
	Return (version) as int
EndFunction

Event OnConfigClose()
	;
endEvent

Event OnConfigInit()
	ModName = "Unforgiving Souls"

	Pages = new String[1]
	Pages[0] = "General"

	;Return
EndEvent

Event OnPageReset(string page)
	OnConfigInit()
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)	
	_lastPage = page
	if (page == "")
		LoadCustomContent("UnforgivingSouls/MCM2.dds", 176, 23)
		return
	else
		UnloadCustomContent()
	endIf

	if (page == "General" || page == "")
		SetTitleText("General")
				
		AddHeaderOption("Virginal Piercing Tweaks")		
		VibeMultiplyMenu_S = AddSliderOption("Vibration power multiplier:", VibeMultiply, "{1} x")
		KindredSoulsChance_S = AddSliderOption("Kindred Soul chance:", Round(KindredSoulsChance*100), "{0} %")

		AddHeaderOption("Piercing LL control")		
		If PiercingRegistered
			PiercingRegistered_T = AddTextOption("Register virginal piercing", "Registered", OPTION_FLAG_DISABLED)
		Else
			PiercingRegistered_T = AddTextOption("Register virginal piercing", "REGISTER")
		EndIf
	endIf
EndEvent

Event OnOptionSelect(Int Menu)
	if Menu == PiercingRegistered_T
		if  PiercingRegistered == true
	;		PiercingRegistered = false
		else			
			PiercingRegistered = true
			;register here
			If !LeveledItemContains(zad_DeviousPiercingsVaginal, VirginalPiercing)
				zad_DeviousPiercingsVaginal.AddForm(VirginalPiercing, 1, 1)
			EndIf
		endIf
		;SetTextOptionValue("Registering virginal piercing", "Registered", OPTION_FLAG_DISABLED)
		ForcePageReset()
	;	return
	endIf	
endEvent

event OnOptionMenuOpen(int Menu)
;	if (Menu == deviceColorIndex)
;		SetMenuDialogStartIndex(DTConfig.deviceColorIndex as int)
;		SetMenuDialogDefaultIndex(0)
;		SetMenuDialogOptions(deviceType)
;	endIf
endEvent

event OnOptionMenuAccept(int Menu, int a_index)
;	if (Menu == deviceColorIndex)
;		DTConfig.deviceColorIndex = a_index as int
;		SetMenuOptionValue(Menu, deviceType[DTConfig.deviceColorIndex as int])
;	endIf
EndEvent

event OnOptionSliderOpen(int Menu)
	if Menu == VibeMultiplyMenu_S
		SetSliderDialogStartValue(VibeMultiply)
        SetSliderDialogDefaultValue(1.0)
        SetSliderDialogRange(0.1, 10.0)
        SetSliderDialogInterval(0.1)    
		;ForcePageReset()
		;return
	elseif Menu == KindredSoulsChance_S
		SetSliderDialogStartValue(Round(KindredSoulsChance*100))
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1)    
		;ForcePageReset()
		;return
	endIf	
endEvent

event OnOptionSliderAccept(int Menu, float value)
    if (Menu == VibeMultiplyMenu_S)
        VibeMultiply = value
        SetSliderOptionValue(VibeMultiplyMenu_S, VibeMultiply, "{1}")
	elseif (Menu == KindredSoulsChance_S)
		KindredSoulsChance = value / 100
		SetSliderOptionValue(KindredSoulsChance_S, Round(KindredSoulsChance*100), "{0}")
	endif
endEvent

Event OnOptionHighlight(int option)
    if (_lastPage == "General")
        if(option == VibeMultiplyMenu_S)
			SetInfoText("Sets multiplier for vibration effectiveness of the Virginal Piercing. Affects edge game difficulty, default is 1, proven best with SL Aroused Redux.")
		elseif(option == KindredSoulsChance_S)
			SetInfoText("Sets chance of suit's kindred soul to take over in the event of the suit's trial completion.")
		elseif(option == PiercingRegistered_T)
			SetInfoText("Injects Virginal Peircing into Leveled Lists to be added randomly by any mods that use LL.")
		endif
    endif
EndEvent

Bool Function LeveledItemContains(LeveledItem list, Form target)
	Int size = list.GetNumForms()
	Int i = 0
	While i < size
	  If list.GetNthForm(i) == target
		Return True
	  EndIf
	  i += 1
	EndWhile
	Return False
EndFunction

int Function Round(float value) global
    return Math.floor(value + 0.5)
EndFunction
