//%attributes = {"publishedWeb":true}
  // Save Intake File data from TestIntake screen menu
  //
SAVE RECORD:C53([IntakeFile:1])
If (Modified record:C314([FamilyFile:20]))
	SAVE RECORD:C53([FamilyFile:20])
End if 