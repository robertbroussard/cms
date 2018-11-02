//%attributes = {"publishedWeb":true}
  //     Called from main menu Intake - Lists Court Based cases on Hold by date
  //
SET WINDOW TITLE:C213("DRC Case Management System")
ALL RECORDS:C47([IntakeFile:1])
FORM SET INPUT:C55([IntakeFile:1];"CourtBasedInput")
FORM SET OUTPUT:C54([IntakeFile:1];"CtDisplaySel")
QUERY:C277([IntakeFile:1];[IntakeFile:1]Program:32="A";*)
QUERY:C277([IntakeFile:1]; | ;[IntakeFile:1]Program:32="L";*)
QUERY:C277([IntakeFile:1]; | ;[IntakeFile:1]Program:32="M";*)
QUERY:C277([IntakeFile:1]; & ;[IntakeFile:1]CaseStatus:25="Hold")
If (Records in selection:C76([IntakeFile:1])>0)
	ORDER BY:C49([IntakeFile:1]DisputeCode:22;>)
	RELATE MANY:C262([IntakeFile:1]CaseNo:1)
	MODIFY SELECTION:C204([IntakeFile:1];*)
Else 
	ALERT:C41("No records found!")
End if 
UNLOAD RECORD:C212([IntakeFile:1])
FORM SET INPUT:C55([IntakeFile:1];"TestIntake")
FORM SET OUTPUT:C54([IntakeFile:1];"DisplaySel2")