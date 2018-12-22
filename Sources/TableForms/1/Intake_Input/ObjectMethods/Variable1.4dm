  // ----------------------------------------------------

  // User name (OS): robert

  // Date and time: 11/17/04, 23:44:48

  // ----------------------------------------------------

  // Method: Object Method: bPrint

  // Description

  // 

  //

  // Parameters

  // ----------------------------------------------------
  //ALERT("This report us coming soon...")

PRINT SETTINGS:C106  //User defines print parameters
If (OK=1)
	FORM SET OUTPUT:C54([IntakeFile:1];"Intake_print")  //Use the first print form
	PRINT RECORD:C71([IntakeFile:1];>)  //Print using user-defined parameters
	  //FORM SET OUTPUT([IntakeFile];"Intake_Input")  //Use the second print form
	PRINT RECORD:C71([IntakeFile:1];>)  //Print using user-defined parameters
	FORM SET OUTPUT:C54([IntakeFile:1];"Intake_Listing")  //Restore default output form
End if 

If (False:C215)
	PRINT SETTINGS:C106
	If (ok=1)
		FORM SET OUTPUT:C54([IntakeFile:1];"Print_IntakeDetail")
		PRINT RECORD:C71([IntakeFile:1];>)
		
		$sel:=_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21)
		
		If ($sel>0)
			FORM SET OUTPUT:C54([IntakeFile:1];"Print_AddPartyDetail2")
			PRINT RECORD:C71([IntakeFile:1];>)
		End if 
		
		FORM SET OUTPUT:C54([IntakeFile:1];"DisplaySel2")
	End if 
End if 