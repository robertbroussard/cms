//%attributes = {"publishedWeb":true}
  // Intake Search
  // 
SET WINDOW TITLE:C213("DRC Case Management System")
vNewIntake:=False:C215
vNewIntake2:=False:C215
vSwitch:=0
FORM SET INPUT:C55([IntakeFile:1];"TestIntake")
FORM SET OUTPUT:C54([IntakeFile:1];"DisplaySel2")
QUERY:C277([IntakeFile:1])
MODIFY SELECTION:C204([IntakeFile:1];*)
CONFIRM:C162("Do you want to print this selection?";"Yes, I do";"No, I don't")
If (OK=1)
	PRINT SELECTION:C60([IntakeFile:1])
End if 
UNLOAD RECORD:C212([IntakeFile:1])