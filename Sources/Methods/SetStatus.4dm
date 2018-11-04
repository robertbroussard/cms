//%attributes = {"publishedWeb":true}
  //G-Proc: SetStatus; This procedure is called from any of the  Case Status/Action
  //buttons on TestIntake. The procedure sets CaseStatus  based on the check box
  //that was clicked and which variable was set in that button's script.
  //
C_TEXT:C284($Dis1)
C_TEXT:C284($Dis2)
Case of 
	: ([IntakeFile:1]CaseStatus:25="") & (vSetHold=1)
		[IntakeFile:1]CaseStatus:25:="Hold"
	: (([IntakeFile:1]CaseStatus:25="") | ([IntakeFile:1]CaseStatus:25="Hold")) & (vSetRefer=1)
		$Dis1:="Changing status to referred is permanent."
		$Dis2:=" Continue?"
		CONFIRM:C162($Dis1+$Dis2)
		If (OK=1)
			[IntakeFile:1]CaseStatus:25:="Referred"
		End if 
	: (([IntakeFile:1]CaseStatus:25="") | ([IntakeFile:1]CaseStatus:25="Hold")) & (vDirAssist=1)
		$Dis1:="Changing status to direct assistance is permanent."
		$Dis2:=" Continue?"
		CONFIRM:C162($Dis1+$Dis2)
		If (OK=1)
			[IntakeFile:1]CaseStatus:25:="Direct Assistance"
		End if 
	: (([IntakeFile:1]CaseStatus:25="") | ([IntakeFile:1]CaseStatus:25="Hold")) & (vSchCase=1)
		CREATE SET:C116([IntakeFile:1];"PrevSet")
		SchCase 
		If (vSchOK=1)
			If (Records in set:C195("PrevSet")>1)
				USE SET:C118("PrevSet")
				CLEAR SET:C117("PrevSet")
			End if 
		Else 
			If (vSchOK#1)
				USE SET:C118("PrevSet")
				CLEAR SET:C117("PrevSet")
			End if 
		End if 
	Else 
		Case of 
			: ([IntakeFile:1]CaseStatus:25="Referred")
				ALERT:C41("Case status is already set to 'Referred'.")
			: ([IntakeFile:1]CaseStatus:25="Scheduled")
				$Dis1:="This case is scheduled. To reschedule, choose "
				$Dis2:="Reschedule from Main Menu."
				ALERT:C41($Dis1+$Dis2)
			: ([IntakeFile:1]CaseStatus:25="Direct Assistance")
				ALERT:C41("Case status is already set to 'Direct Assistance'.")
		End case 
End case 
SetButtons 