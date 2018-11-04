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
	[IntakeFile:1]LocCode:2:="01"
	[IntakeFile:1]IdCode:3:="10"
	[IntakeFile:1]RLName:11:="N/A"
	[IntakeFile:1]RLang:15:="E"
	[IntakeFile:1]HowLong:18:="1"
	[IntakeFile:1]TPeriod:19:="Day(s)"
	[IntakeFile:1]DateClosed:24:=[IntakeFile:1]IntakeDate:4
	[IntakeFile:1]CaseStatus:25:="Referred"
End if 