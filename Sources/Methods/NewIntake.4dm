//%attributes = {"publishedWeb":true}
  //G-Procedure: NewIntake; This procedure performs a new intake by prompting the
  //user for the type of case, assigning a new case number, and sending them to
  //the proper input screen.  It tests for the Short Intake abbreviated screen and 
  // fills in data and dummy info where needed.

_O_C_INTEGER:C282($CurrentYear)
  // 
SET WINDOW TITLE:C213("DRC Case Management System")
DEFAULT TABLE:C46([IntakeFile:1])
vSwitch:=0
$Suffix:=""
$PreFix:=""
NewIntInitilize 
$Loop:=1
While ($Loop=1)
	If (vShortIntak#1)  // SKIP WINDOW ON SHORT INTAKES
		Open window:C153(75;65;395;315;1)  //Open window(75;65;450;350;1)
		DIALOG:C40("IntakeSelection")
		CLOSE WINDOW:C154
	Else 
		vSelectMade:=1
		OK:=1
	End if 
	If (vSelectMade=1) & (OK=1)
		$Loop:=0
		Case of 
			: (vShortIntak=1)  // SHORT INTAKES ARE ALWAYS 'C'
				$Suffix:="C"
			: (vCBMP=1)
				$Suffix:="C"
			: (vFamily=1)
				$Suffix:="F"
			: (vJUMP=1)
				$Suffix:="J"
			: (vLit=1)
				$Suffix:="L"
			: (vTruant=1)
				$Suffix:="T"  //            TRUANT    -  11-03
			: (vSpecialEd=1)
				$Suffix:="S"
			: (vProbation=1)
				$Suffix:="P"
			: (vCPS=1)  // 8/99 - CHILD PROTECT. SVC.        
				$Suffix:="W"
			: (vCFK=1)  // 1/01 - COOPERATE FOR KIDS
				$Suffix:="K"
			: (vArb=1)
				$Suffix:="A"
			: (vMSC=1)
				$Suffix:="M"
			: (vVO=1)
				$Suffix:="V"
			: (vLongTermCare=1)
				$Suffix:="N"
		End case 
		$CurrentYear:=Year of:C25(Current date:C33(*))  //Mod_12/13/05
		$PreFix:=Substring:C12(String:C10($CurrentYear);1;4)  // DATE WAS (;3;2) - Y2K, 4 DIGIT YR
		If ($CurrentYear=2005)
			vCaseNo:=String:C10(GetNumber (1))
		Else 
			vCaseNo:=String:C10(GetNumber ($CurrentYear))
		End if 
		vCaseNo:=$Prefix+SetLength (vCaseNo)+$Suffix
		CREATE RECORD:C68([IntakeFile:1])
		SetIntDefault (vCaseNo;$Suffix)
		SAVE RECORD:C53([IntakeFile:1])
		SetInputLayout 
		MODIFY RECORD:C57([IntakeFile:1];*)
		If (OK#1)
			DELETE RECORD:C58([IntakeFile:1])
		End if 
	Else 
		If (OK=1)
			ALERT:C41("You must choose intake type or click cancel!")
		Else 
			$Loop:=0
		End if 
	End if 
End while 
UNLOAD RECORD:C212([IntakeFile:1])
UNLOAD RECORD:C212([DocketFile:6])
UNLOAD RECORD:C212([FamilyFile:20])