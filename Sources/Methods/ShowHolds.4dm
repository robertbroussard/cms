//%attributes = {"publishedWeb":true}
  //G-Procedure: GetHolds;

If (True:C214)
	QUERY:C277([IntakeFile:1];[IntakeFile:1]CaseStatus:25="Hold")
	$Ref:=Open form window:C675("Intake_Listing";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
	SET WINDOW TITLE:C213("CMS: Intakes (Holds)")
	DIALOG:C40("Intake_Listing")
	CLOSE WINDOW:C154
Else 
	
	
	
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
	
End if 