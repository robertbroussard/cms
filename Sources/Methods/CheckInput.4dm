//%attributes = {"publishedWeb":true}
  //G-Procedure: CheckInput
  //
Case of 
	: ([IntakeFile:1]CaseNo:1="")
		ALERT:C41("You must enter the Case number.")
		GOTO OBJECT:C206([IntakeFile:1]CaseNo:1)
		$0:=False:C215
	: ([IntakeFile:1]LocCode:2="") | ([IntakeFile:1]IdCode:3="")
		ALERT:C41("You must enter the Loc/Id Code.")
		GOTO OBJECT:C206([IntakeFile:1]LocCode:2)
		$0:=False:C215
	: ([IntakeFile:1]IntakeDate:4=!00-00-00!)
		ALERT:C41("You must enter the Intake Date.")
		GOTO OBJECT:C206([IntakeFile:1]IntakeDate:4)
		$0:=False:C215
	: ([IntakeFile:1]CLName:6="")
		ALERT:C41("You must enter the Complainant's last name.")
		GOTO OBJECT:C206([IntakeFile:1]CLName:6)
		$0:=False:C215
	: ([IntakeFile:1]CLang:10="")
		ALERT:C41("You must enter the Complainants language.")
		GOTO OBJECT:C206([IntakeFile:1]CLang:10)
		$0:=False:C215
	: ([IntakeFile:1]RefBy:16="")
		ALERT:C41("You must enter somthing in the 'Referred by' field.")
		GOTO OBJECT:C206([IntakeFile:1]RefBy:16)
		$0:=False:C215
	: ([IntakeFile:1]RLName:11="")
		ALERT:C41("You must enter the Respondent's last name.")
		GOTO OBJECT:C206([IntakeFile:1]RLName:11)
		$0:=False:C215
	: ([IntakeFile:1]RLang:15="")
		ALERT:C41("You must enter the Respondent's language.")
		GOTO OBJECT:C206([IntakeFile:1]RLang:15)
		$0:=False:C215
	: ([IntakeFile:1]ifRelCode:17="")
		ALERT:C41("You must enter the relationship.")
		GOTO OBJECT:C206([IntakeFile:1]ifRelCode:17)
		$0:=False:C215
	: ([IntakeFile:1]HowLong:18="")
		ALERT:C41("You must enter the length of relationship .")
		GOTO OBJECT:C206([IntakeFile:1]HowLong:18)
		$0:=False:C215
	: ([IntakeFile:1]TPeriod:19="")
		ALERT:C41("You must enter a period of time in the field labeled 'How Long'. ")
		GOTO OBJECT:C206([IntakeFile:1]TPeriod:19)
		$0:=False:C215
	: ([IntakeFile:1]DisputeCode:22="")
		ALERT:C41("You must enter a dispute code in section labeled 'Dispute Information'.")
		GOTO OBJECT:C206([IntakeFile:1]DisputeCode:22)
		$0:=False:C215
	Else 
		$0:=True:C214
End case 