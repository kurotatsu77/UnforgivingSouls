;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname USLS_SF_KarmaSC_090183DF Extends Scene Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()    
;BEGIN CODE
while libs.IsAnimating(Game.GetPlayer())
    Utility.Wait(1)
endwhile
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
    
zadlibs Property libs auto