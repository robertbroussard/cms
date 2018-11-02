//%attributes = {"publishedWeb":true}
  //G-Proc: PrintSites
_O_C_INTEGER:C282($i)
vSubDetail:=""
Print form:C5([IntakeFile:1];"SubHead1")
vText1:="Intake Site"
vText2:="Num"
vText3:="Per"
Print form:C5([IntakeFile:1];"SubHead2")
For ($i;1;Size of array:C274(aSite))
	v1:=aSite{$i}
	v2:=aSTotals{$i}{1}
	v3:=aSTotals{$i}{2}
	Print form:C5([IntakeFile:1];"RptNumDetail")
End for 
CLEAR VARIABLE:C89(aSite)
CLEAR VARIABLE:C89(aSTotals)