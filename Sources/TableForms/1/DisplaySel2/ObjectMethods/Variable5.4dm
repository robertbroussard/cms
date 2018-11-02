  //Script: bTestButton
C_LONGINT:C283(vSwitch)
If (vSwitch=0)
	FORM SET INPUT:C55([IntakeFile:1];"CourtBasedInput")
	OBJECT SET TITLE:C194(bSwitch;"Court-Based")
	vSwitch:=1
Else 
	FORM SET INPUT:C55([IntakeFile:1];"TestIntake")
	OBJECT SET TITLE:C194(bSwitch;"Community-Based")
	vSwitch:=0
End if 