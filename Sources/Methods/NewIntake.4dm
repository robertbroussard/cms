//%attributes = {"publishedWeb":true}
  //G-Procedure: NewIntake; This procedure performs a new intake by prompting the
  //user for the type of case, assigning a new case number, and sending them to
  //the proper input screen.  It tests for the Short Intake abbreviated screen and 
  // fills in data and dummy info where needed.

Comp_DeclaredVars 
C_LONGINT:C283($CurrentYear)
  // 
  //SET WINDOW TITLE("DRC Case Management System")
  //DEFAULT TABLE([IntakeFile])
vSwitch:=0
$Suffix:=""
$PreFix:=""
NewIntInitilize 

$WinRef:=Open form window:C675([IntakeFile:1];"IntakeSelection")
DIALOG:C40([IntakeFile:1];"IntakeSelection")
CLOSE WINDOW:C154

If (vSelectMade=1) & (OK=1)
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
	  //SetInputLayout 
	  //$Ref:=Open form window([IntakeFile];"Intake_Input";Plain form window;Horizontally centered;Vertically centered)
	MODIFY RECORD:C57([IntakeFile:1];*)
	  //ADD RECORD(Current form table->)
Else 
	  //CANCEL
	  //CLOSE WINDOW
End if 
  //End while 
  //UNLOAD RECORD([IntakeFile])
  //UNLOAD RECORD([DocketFile])
  //UNLOAD RECORD([FamilyFile])