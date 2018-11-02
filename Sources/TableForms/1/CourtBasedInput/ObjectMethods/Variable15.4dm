  //Script: vSchCase
$Loop:=0
If (CheckInput =True:C214)
	SAVE RECORD:C53([IntakeFile:1])
	$Loop:=1
Else 
	vSchCase:=0
End if 
While ($Loop=1)
	$Loop:=0
	vSchCase:=1
	vSetHold:=0
	vSetRefer:=0
	vDirAssist:=0
	SetStatus 
End while 