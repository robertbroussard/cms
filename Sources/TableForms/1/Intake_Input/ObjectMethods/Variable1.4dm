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