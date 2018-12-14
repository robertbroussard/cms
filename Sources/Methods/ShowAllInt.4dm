//%attributes = {"publishedWeb":true}

  // ----------------------------------------------------
  // User name (OS): robert
  // Date and time: 11/19/18, 17:04:23
  // ----------------------------------------------------
  // Method: ShowAllInt
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

If (True:C214)
	ALL RECORDS:C47([IntakeFile:1])
	  //$WinRef:=Open form window("Intake_Listing";Plain form window;Horizontally centered;Vertically centered)
	$WinRef:=Open form window:C675([IntakeFile:1];"Intake_Input";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
	SET WINDOW TITLE:C213("CMS: Intakes")
	DIALOG:C40([IntakeFile:1];"Intake_Listing")
	CLOSE WINDOW:C154
Else 
	
	SET WINDOW TITLE:C213("DRC Case Management System")
	vNewIntake:=False:C215
	vNewIntake2:=False:C215
	vSwitch:=0
	FORM SET INPUT:C55([IntakeFile:1];"TestIntake")
	FORM SET OUTPUT:C54([IntakeFile:1];"DisplaySel2")
	  //SET ENTERABLE([IntakeFile]CaseNo;False)
	ALL RECORDS:C47([IntakeFile:1])
	MODIFY SELECTION:C204([IntakeFile:1];*)
	  //UNLOAD RECORD([IntakeFile])
	  //FIRST RECORD([IntakeFile]) disabled RJB 11/2/18
	
End if 