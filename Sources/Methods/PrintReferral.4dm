//%attributes = {"publishedWeb":true}
  //G-Proc: PrintReferral
C_LONGINT:C283($i)
vSubDetail:=""
Print form:C5([IntakeFile:1];"SubHead1")
vText1:="Referral Source"
vText2:="Num"
vText3:="Per"
Print form:C5([IntakeFile:1];"SubHead2")
For ($i;1;Size of array:C274(aRefBy))
	v1:=aRefBy{$i}
	v2:=aRefByNum{$i}
	v3:=aRefByPer{$i}
	Print form:C5([IntakeFile:1];"RptNumDetail")
End for 
CLEAR VARIABLE:C89(aRefBy)
CLEAR VARIABLE:C89(aRefByNum)
CLEAR VARIABLE:C89(aRefByPer)
