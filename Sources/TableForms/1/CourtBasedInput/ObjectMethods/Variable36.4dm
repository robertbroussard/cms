  //Script: bLetter; Page 3 of [IntakeFile]CourtBasedInput-page 3
SET WINDOW TITLE:C213("CMS: Letters")
If (CheckInput =True:C214)
	SAVE RECORD:C53([IntakeFile:1])
	DefaultLtrs 
End if 
SET WINDOW TITLE:C213("CMS: Intake Input")
