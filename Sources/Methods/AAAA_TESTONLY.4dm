//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): robert
  // Date and time: 11/14/18, 23:22:26
  // ----------------------------------------------------
  // Method: AAAA_TESTONLY
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

  //CHANGE CURRENT USER


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

If (False:C215)
	ALL RECORDS:C47([IntakeFile:1])
	  //$WinRef:=Open form window("Intake_Listing";Plain form window;Horizontally centered;Vertically centered)
	$WinRef:=Open form window:C675([IntakeFile:1];"Intake_Input";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
	SET WINDOW TITLE:C213("CMS: Intakes (All)")
	DIALOG:C40([IntakeFile:1];"TEST_Intake_Listing")  //test
	CLOSE WINDOW:C154
Else 
	
	SET WINDOW TITLE:C213("DRC Case Management System")
	vNewIntake:=False:C215
	vNewIntake2:=False:C215
	vSwitch:=0
	FORM SET INPUT:C55([IntakeFile:1];"Intake_Input")
	FORM SET OUTPUT:C54([IntakeFile:1];"TEST_Intake_Listing")
	  //SET ENTERABLE([IntakeFile]CaseNo;False)
	ALL RECORDS:C47([IntakeFile:1])
	MODIFY SELECTION:C204([IntakeFile:1];*)
	  //UNLOAD RECORD([IntakeFile])
	  //FIRST RECORD([IntakeFile]) disabled RJB 11/2/18
	
End if 