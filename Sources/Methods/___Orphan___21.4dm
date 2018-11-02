//%attributes = {}
  //Script: bLetter - Object Method for "Letters" button on page 
  //one and  page three of  [IntakeFile];"TestIntake" which 
  //avoids printing letters for  Program  = "T"
  //
SET WINDOW TITLE:C213("CMS: Letters")
SAVE RECORD:C53([IntakeFile:1])
If ([IntakeFile:1]Program:32)#"T"
	DefaultLtrs 
Else 
	ALERT:C41("Program = T doesn't print letters")
End if 
SET WINDOW TITLE:C213("CMS: Intake Input")