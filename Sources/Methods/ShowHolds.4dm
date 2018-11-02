//%attributes = {"publishedWeb":true}
  //G-Procedure: GetHolds;
SET WINDOW TITLE:C213("DRC Case Management System")
vNewIntake:=False:C215
vNewIntake2:=False:C215
vSwitch:=0
ALL RECORDS:C47([IntakeFile:1])
FORM SET INPUT:C55([IntakeFile:1];"TestIntake")
FORM SET OUTPUT:C54([IntakeFile:1];"DisplaySel2")
QUERY:C277([IntakeFile:1];[IntakeFile:1]CaseStatus:25="Hold")
If (Records in selection:C76([IntakeFile:1])>0)
	MODIFY SELECTION:C204([IntakeFile:1];*)
Else 
	ALERT:C41("No records found!")
End if 
UNLOAD RECORD:C212([IntakeFile:1])