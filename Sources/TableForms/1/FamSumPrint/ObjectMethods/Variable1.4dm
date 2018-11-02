  //Script: vC1Code;
If ([IntakeFile:1]CSex:43=True:C214)
	vC1Code:=[IntakeFile:1]CRace:44+"F"+String:C10([IntakeFile:1]CAge:45)+[IntakeFile:1]CLang:10
Else 
	vC1Code:=[IntakeFile:1]CRace:44+"M"+String:C10([IntakeFile:1]CAge:45)+[IntakeFile:1]CLang:10
End if 