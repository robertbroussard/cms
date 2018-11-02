  //Script: vCancel; Located on 'DocketDisplay'
If (vSchOK=1)
	CONFIRM:C162("Case No. "+vCaseNo+" has been Scheduled. Do you want to reverse this action?")
	If (OK=1)
		POP RECORD:C177([DocketFile:6])
		ONE RECORD SELECT:C189([DocketFile:6])
		If (Not:C34(Locked:C147([DocketFile:6])))
			DELETE RECORD:C58([DocketFile:6])
		Else 
			ALERT:C41("Record is locked and cannot be deleted")
		End if 
		QUERY:C277([IntakeFile:1];[IntakeFile:1]CaseNo:1=vCaseNo)
		If (Records in selection:C76([IntakeFile:1])=1)
			If (vTempStatus#"Scheduled")
				[IntakeFile:1]CaseStatus:25:=vTempStatus
				SAVE RECORD:C53([IntakeFile:1])
			End if 
			vSchOK:=0
			ACCEPT:C269
		End if 
	Else 
		ALERT:C41("Case No. "+vCaseNo+" has not been scheduled.")
		ACCEPT:C269
	End if 
End if 