//%attributes = {"publishedWeb":true}
  //   Called from main menu Intake - Lists Court Based cases flagged as Hot
  //
SET WINDOW TITLE:C213("DRC Case Management System")
  //G-Procedure: GetHot;
ALL RECORDS:C47([IntakeFile:1])
FORM SET INPUT:C55([IntakeFile:1];"CourtBasedInput")
FORM SET OUTPUT:C54([IntakeFile:1];"CtDisplaySel")
QUERY:C277([IntakeFile:1];[IntakeFile:1]Program:32="A";*)
QUERY:C277([IntakeFile:1]; | ;[IntakeFile:1]Program:32="L";*)
QUERY:C277([IntakeFile:1]; | ;[IntakeFile:1]Program:32="M";*)
QUERY:C277([IntakeFile:1]; & ;[IntakeFile:1]Hot:31=True:C214)
If (Records in selection:C76([IntakeFile:1])>0)
	ORDER BY:C49([IntakeFile:1]CaseNo:1;>)
	MODIFY SELECTION:C204([IntakeFile:1];*)
Else 
	ALERT:C41("No records found!")
End if 
UNLOAD RECORD:C212([IntakeFile:1])
FORM SET INPUT:C55([IntakeFile:1];"TestIntake")
FORM SET OUTPUT:C54([IntakeFile:1];"DisplaySel2")