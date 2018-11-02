//%attributes = {"publishedWeb":true}
  //G-Proc: PrintPrograms
_O_C_INTEGER:C282($i)
_O_C_STRING:C293(20;$Program)
vSubDetail:=""
Print form:C5([IntakeFile:1];"SubHead1")
vText1:="Programs"
vText2:="Num"
vText3:="Per"
Print form:C5([IntakeFile:1];"SubHead2")
For ($i;1;Size of array:C274(aProgram))
	Case of 
		: (aProgram{$i}="C")
			$Program:="Community-Based"
		: (aProgram{$i}="F")
			$Program:="Family"
		: (aProgram{$i}="J")
			$Program:="JUMP"
		: (aProgram{$i}="L")
			$Program:="Litigation"
		: (aProgram{$i}="S")
			$Program:="Special Ed"
		: (aProgram{$i}="P")
			$Program:="Probation"
		: (aProgram{$i}="W")
			$Program:="CPS"
		: (aProgram{$i}="K")
			$Program:="CFK"
		: (aProgram{$i}="T")  //        Truant - 11/25
			$Program:="Truant"
		Else 
			$Program:="All Programs"
	End case 
	v1:=$Program
	v2:=aPTotals{$i}{1}
	v3:=aPTotals{$i}{2}
	Print form:C5([IntakeFile:1];"RptNumDetail")
End for 
CLEAR VARIABLE:C89(aProgram)
CLEAR VARIABLE:C89(aPTotals)