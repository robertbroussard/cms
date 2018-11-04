//%attributes = {"publishedWeb":true}
  //G-Procedure:Reschedule; This proc will check the entered CaseNo and if that is 
  //OK it will reschedule the case. Reschedule is called from the menu item 
  //Reschedule Case. It in turn calls DoReschedule.
  //
C_LONGINT:C283($MainLoop)
C_TEXT:C284($TempCaseNo)
SET WINDOW TITLE:C213("DRC Case Management System")
$MainLoop:=1
While ($MainLoop=1)
	$MainLoop:=0
	$TempCaseNo:=Request:C163("Enter Case Number to be rescheduled;";"")
	If (($TempCaseNo#"") & (OK=1))
		QUERY:C277([IntakeFile:1];[IntakeFile:1]CaseNo:1=$TempCaseNo)
		Case of 
			: ((Records in selection:C76([IntakeFile:1])=1) & ([IntakeFile:1]CaseStatus:25="Scheduled"))
				DoReschedule ($TempCaseNo)
			: ((Records in selection:C76([IntakeFile:1])=1) & ([IntakeFile:1]CaseStatus:25#"Scheduled"))
				ALERT:C41("This case has not been scheduled yet. Go to Modify Intake to schedule.")
			: (Records in selection:C76([IntakeFile:1])>1)
				ALERT:C41("You must enter the exact case number the Wildcard '@' is not allowed.")
				$MainLoop:=1
			: (Records in selection:C76([IntakeFile:1])=0)
				CONFIRM:C162("Case not found. Try again?")
				If (OK=1)
					$MainLoop:=1
				End if 
		End case 
	End if 
End while 
UNLOAD RECORD:C212([IntakeFile:1])
UNLOAD RECORD:C212([DocketFile:6])