//%attributes = {"publishedWeb":true}
  //G-Proc: PrintStatus
C_LONGINT:C283($i)
vSubDetail:=""
Print form:C5([IntakeFile:1];"SubHead1")
vText1:="Status"
vText2:="Num"
vText3:="Per"
Print form:C5([IntakeFile:1];"SubHead2")
For ($i;1;Size of array:C274(aStatus))
	v1:=aStatus{$i}
	v2:=aBSTotals{$i}{1}
	v3:=aBSTotals{$i}{2}
	Print form:C5([IntakeFile:1];"RptNumDetail")
End for 
CLEAR VARIABLE:C89(aStatus)
CLEAR VARIABLE:C89(aBSTotals)