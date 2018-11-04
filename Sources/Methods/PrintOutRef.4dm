//%attributes = {"publishedWeb":true}
  //G-Proc: PrintOutRef
C_LONGINT:C283($i)
vSubDetail:=""
Print form:C5([IntakeFile:1];"SubHead1")
vText1:="Outside Referrals"
vText2:="Num"
vText3:="Per"
Print form:C5([IntakeFile:1];"SubHead2")
For ($i;1;Size of array:C274(aOutRef))
	v1:=aOutRef{$i}
	v2:=aORTotals{$i}{1}
	v3:=aORTotals{$i}{2}
	Print form:C5([IntakeFile:1];"RptNumDetail")
End for 
CLEAR VARIABLE:C89(aOutRef)
CLEAR VARIABLE:C89(aORTotals)