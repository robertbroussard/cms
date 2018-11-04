//%attributes = {"publishedWeb":true}
  //G-Proc: StatusCheck
C_LONGINT:C283($i)
ALL RECORDS:C47([IntakeFile:1])
For ($i;1;Records in selection:C76([IntakeFile:1]))
	Case of 
		: ([IntakeFile:1]CaseStatus:25="")
			[IntakeFile:1]CaseStatus:25:="Hold"
			SAVE RECORD:C53([IntakeFile:1])
	End case 
	NEXT RECORD:C51([IntakeFile:1])
End for 