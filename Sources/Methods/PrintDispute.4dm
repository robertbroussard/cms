//%attributes = {"publishedWeb":true}
  //G-Proc: PrintDispute 
C_LONGINT:C283($i)
vSubDetail:=""
Print form:C5([IntakeFile:1];"SubHead1")
vText1:="Dispute Type"
vText2:="Num"
vText3:="Per"
Print form:C5([IntakeFile:1];"SubHead2")
For ($i;1;Size of array:C274(aDispute))
	v1:=aDispute{$i}
	v2:=aDTotals{$i}{1}
	v3:=aDTotals{$i}{2}
	Print form:C5([IntakeFile:1];"RptNumDetail")
End for 
CLEAR VARIABLE:C89(aDispute)
CLEAR VARIABLE:C89(aDTotals)