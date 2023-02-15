Scriptname aud_SndEffectSuitSoundIdle extends ActiveMagicEffect
;;attached to an enchantment which uses the IsMoving condition. when the weareris in motion it will make squeaky noises.

Sound Property CeleneIdleSM Auto

;; Original Script and Idea: Milk Slave Experience Mod by darkconsole @ LoversLab
;; Butchered by ElDuderino to make a rubber suit squeaky instead of the original cowbell ring
;; Additional ideas and help from darkconsole -- thank you very much!
;; Script used with kind permission from the original author.

Event OnEffectStart(Actor who, Actor caster)
	self.OnUpdate()
	Return
EndEvent

Event OnUpdate()

	If(self == None)
		;; not sure of the edge cages that cause this. maybe has something
		;; to do with crossing load boundaries. also can be caused by
		;; removing the collar before the next ding.
		Return
	EndIf

	Actor who = self.GetTargetActor()

	if(who == None)
		;; i don't think this was a factor but i added it anyway. im pretty
		;; sure it is only the self causing issues.
		Return
	EndIf

	;; default idle sound pace.
	Float min = 2.0
	Float max = 10.5

	; Kimy: Added offset variable so adjusting the intervals for different length sound samples is a bit easier.
	Float Offset = 0
	min += Offset
	max += Offset

	;; you're standing still, but suit occasionally squeaks from your idle movements
	CeleneIdleSM.Play(who)
	self.RegisterForSingleUpdate(Utility.RandomFloat(min,max))
	Return

EndEvent

