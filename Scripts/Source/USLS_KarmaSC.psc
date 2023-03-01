Scriptname USLS_KarmaSC extends Quest  

ReferenceAlias Property qAlias01 Auto
Scene Property fgScene Auto
int Property fgCooldown Auto
Package Property fgPackage auto
Sound Property KarmaSuckingSM auto
Sound Property KarmaGoodbyeSM auto
Topic[] Property SexComments auto
Topic Property KarmaGoodbye auto

bool canTrigger = true
bool canStartSex = true
int CurrentStage = 0
Actor Man
SexLabFramework SexLab

bool Function IsCanTrigger()
    return canTrigger && canStartSex
EndFunction

bool Function startScene(Actor other)
    If(canTrigger == false)
        return false
    EndIf
    canTrigger = false
    SexLab = SexLabUtil.GetAPI()
    RegisterForSingleUpdateGameTime(fgCooldown)
    qAlias01.ForceRefTo(other)
    Man = other
    ;fgScene.Start()
    ActorUtil.AddPackageOverride(other,fgPackage,99)
    other.EvaluatePackage()
    return true
EndFunction

bool Function startSex(Actor akActor)
    If(canStartSex == false)
        return false
    EndIf
    canStartSex = false
    ;UnRegisterForModEvent("HookOrgasmEnd_USLSKarma")
    UnRegisterForModEvent("HookStageStart_USLSKarma")
    UnRegisterForModEvent("HookAnimationEnd_USLSKarma")
    Utility.Wait(0.5)
    ;RegisterForModEvent("HookOrgasmEnd_USLSKarma","USLSKarma_HookOrgasmEnd")
    RegisterForModEvent("HookStageStart_USLSKarma","USLSKarma_HookStageStart")
    RegisterForModEvent("HookAnimationEnd_USLSKarma","USLSKarma_HookOrgasmEnd")
    Utility.Wait(0.5)
    CurrentStage = 0
    SexLabUtil.QuickStart(Game.GetPlayer(), akActor, animationTags = "Blowjob", hook = "USLSKarma")
    return true
EndFunction

Event OnUpdateGameTime()
    Cleanup()
EndEvent

Event USLSKarma_HookOrgasmEnd(int tid, bool HasPlayer)
    sslThreadController Thread = SexLab.GetController(tid)
    Actor[] Positions = Thread.Positions
    ;Positions[1].Say(KarmaGoodbye)
    KarmaGoodbyeSM.Play(Game.GetPlayer())
    Cleanup()
EndEvent

Event USLSKarma_HookStageStart(int tid, bool HasPlayer)
    sslThreadController Thread = SexLab.GetController(tid)
    Actor[] Positions = Thread.Positions
    CurrentStage += 1
    int loc_i
    loc_i = Utility.RandomInt(1,SexComments.length)
    ;Positions[1].Say(SexComments[loc_i - 1])
    KarmaSuckingSM.Play(Game.GetPlayer())
EndEvent

Function Cleanup()
    if !canTrigger
        ;UnRegisterForModEvent("HookOrgasmEnd_USLSKarma")
        UnRegisterForModEvent("HookStageStart_USLSKarma")
        UnRegisterForModEvent("HookAnimationEnd_USLSKarma")
        ActorUtil.ClearPackageOverride(qAlias01.GetActorRef())
        qAlias01.GetActorRef().EvaluatePackage()
        qAlias01.TryToReset()
        canTrigger = true
    endif
    if !canStartSex
        canStartSex = true
    endif
EndFunction
