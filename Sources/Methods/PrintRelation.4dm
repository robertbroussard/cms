//%attributes = {"publishedWeb":true}
  //G-Proc: PrintRelation
_O_C_INTEGER:C282($i)
vSubDetail:=""
Print form:C5([IntakeFile:1];"SubHead1")
vText1:="Relationship Type"
vText2:="Num"
vText3:="Per"
Print form:C5([IntakeFile:1];"SubHead2")
For ($i;1;Size of array:C274(aRelation))
	v1:=aRelation{$i}
	v2:=aRTotals{$i}{1}
	v3:=aRTotals{$i}{2}
	Print form:C5([IntakeFile:1];"RptNumDetail")
End for 
CLEAR VARIABLE:C89(aRelation)
CLEAR VARIABLE:C89(aRTotals)