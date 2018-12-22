//%attributes = {"publishedWeb":true}
  //G-Proc: SetIntDefault;
C_TEXT:C284($1)
C_TEXT:C284($2)
[IntakeFile:1]CaseNo:1:=$1
[IntakeFile:1]Program:32:=$2
[IntakeFile:1]IntakeDate:4:=Current date:C33
[IntakeFile:1]CCity:35:="Houston"
[IntakeFile:1]CState:36:="TX"
[IntakeFile:1]RCity:40:="Houston"
[IntakeFile:1]RState:41:="TX"
  //
If (vShortIntak=1)  // DEFAULT VALUES TO GET BY EDITS ON SHORT INTAKE
	  //[IntakeFile]LocCode:="01"
	  //[IntakeFile]IdCode:="10"
	  //[IntakeFile]RLName:="N/A"
	  //[IntakeFile]RLang:="E"
	  //[IntakeFile]HowLong:="1"
	  //[IntakeFile]TPeriod:="Day(s)"
	  //[IntakeFile]DateClosed:=[IntakeFile]IntakeDate
	  //[IntakeFile]CaseStatus:="Referred"
End if 

  //populate test data 11/8/18
If (Is new record:C668([IntakeFile:1]) & Shift down:C543)
	CONFIRM:C162("Populate test data for this new Intake?";"Yes";"No")
	If (OK=1)
		  //[IntakeFile]LocCode:="01"
		  //[IntakeFile]IdCode:="94"
		[IntakeFile:1]CLName:6:="CLastName-"+String:C10(Random:C100)
		[IntakeFile:1]CFName:7:="CFirstName-"+String:C10(Random:C100)
		[IntakeFile:1]CLang:10:="E"
		[IntakeFile:1]RLang:15:="E"
		[IntakeFile:1]RefBy:16:="DRC Web"
		[IntakeFile:1]RLName:11:="RespLastName-"+String:C10(Random:C100)
		[IntakeFile:1]ifRelCode:17:="202"
		[IntakeFile:1]HowLong:18:="01"
		[IntakeFile:1]TPeriod:19:="Years"
		[IntakeFile:1]DisputeCode:22:="142"
		  //[IntakeFile]CaseStatus:="Test"
	End if 
End if 