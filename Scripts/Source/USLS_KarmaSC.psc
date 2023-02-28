Scriptname USLS_KarmaSC extends Quest  
ReferenceAlias Property qAlias01 Auto
Scene Property fgScene Auto

int Property fgCooldown Auto
bool canTrigger = true

bool Function startScene(Actor other)
  If(canTrigger == false)
    return false
  EndIf
  canTrigger = false
  RegisterForSingleUpdateGameTime(fgCooldown)
  qAlias01.ForceRefTo(other)
  fgScene.Start()
  return true
EndFunction

Event OnUpdateGameTime()
  canTrigger = true
EndEvent
