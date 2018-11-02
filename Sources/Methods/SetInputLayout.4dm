//%attributes = {"publishedWeb":true}
  // G-Proc: SetInputLayout.
FORM SET INPUT:C55([IntakeFile:1];"TestIntake")
Case of 
	: ([IntakeFile:1]Program:32="A")
		FORM SET INPUT:C55([IntakeFile:1];"CourtBasedInput")
	: ([IntakeFile:1]Program:32="L")
		FORM SET INPUT:C55([IntakeFile:1];"CourtBasedInput")
	: ([IntakeFile:1]Program:32="M")
		FORM SET INPUT:C55([IntakeFile:1];"CourtBasedInput")
	: (vShortIntak=1)
		FORM SET INPUT:C55([IntakeFile:1];"ShortIntakeScrn")
End case 