//%attributes = {"publishedWeb":true}
  //G-Proc:PrintHResults    
  //
C_LONGINT:C283($i)
vSubDetail:=""
Print form:C5([IntakeFile:1];"SubHead1")
vText1:="Hearing Results for: "+vSite
Print form:C5([IntakeFile:1];"SubHead2")
  // * Calculate the percent.
For ($i;1;9)
	aHRTotals{$i}{2}:=Trunc:C95((aHRTotals{$i}{1}/$1)*100;2)
End for 
  //Print each line.
For ($i;1;9)
	vText1:=""
	vText2:=""
	Case of 
		: ($i=1)
			vText1:="Conciliated"
		: ($i=2)
			vText1:="Mediations Held"
		: ($i=3)
			vText1:="Settled"
		: ($i=4)
			vText1:="Impasse"
		: ($i=5)
			vText1:="Continued"
		: ($i=6)
			vText1:="Ventilated"
		: ($i=7)
			vText1:="Declined"
		: ($i=8)
			vText1:="No Show"
		: ($i=9)
			vText1:="Rescheduled"
	End case 
	vText2:=String:C10(aHRTotals{$i}{1})
	vText3:=String:C10(aHRTotals{$i}{2})
	Print form:C5([IntakeFile:1];"RptTextDetail")
End for 
CLEAR VARIABLE:C89(aHRTotals)