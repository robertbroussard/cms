//%attributes = {"publishedWeb":true}
  //G-Procedure: ModIntake - This procedure uses Search By Layout with the layout
  //"IntSearch" to search for the case to be modified and then the procedure either
  //finds the case and displays it or provides the user with an error message.
  //
SET WINDOW TITLE:C213("DRC Case Management System")
DEFAULT TABLE:C46([IntakeFile:1])
C_TEXT:C284($CR)
vSwitch:=0
vShortIntak:=0
$Display:=""
vNewIntake:=False:C215
vNewIntake2:=False:C215
$Loop:=1
OBJECT SET ENTERABLE:C238([IntakeFile:1]CaseNo:1;False:C215)

$WinRef:=Open form window:C675([IntakeFile:1];"IntSearchLit";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
  //DIALOG("Intake_Listing")

While ($Loop=1)
	FORM SET INPUT:C55([IntakeFile:1];"IntSearchLit")
	QUERY BY EXAMPLE:C292([IntakeFile:1])
	Case of 
		: (OK=1) & (Records in selection:C76([IntakeFile:1])=1)
			vCaseNo:=[IntakeFile:1]CaseNo:1
			SetInputLayout 
			MODIFY RECORD:C57([IntakeFile:1];*)
			$Loop:=0
		: (OK=1) & (Records in selection:C76([IntakeFile:1])>1)
			$DisString:=String:C10(Records in selection:C76([IntakeFile:1]))
			SetInputLayout 
			FORM SET OUTPUT:C54([IntakeFile:1];"DisplaySel2")
			CONFIRM:C162($DisString+" cases found! Press OK to view all cases; press Cancel to search again.")
			If (OK=1)
				MODIFY SELECTION:C204([IntakeFile:1];*)
				$Loop:=0
			Else 
				$Loop:=1
			End if 
		: (Records in selection:C76([IntakeFile:1])=0) & (OK=1)
			$CR:=Char:C90(13)
			CONFIRM:C162("Case not found!"+$CR+"Do you want to try again?")
			If (OK=1)
				$Loop:=1
			Else 
				$Loop:=0
			End if 
		Else   //Else of case-to kill loop
			$Loop:=0
	End case 
End while 
CLOSE WINDOW:C154

UNLOAD RECORD:C212([IntakeFile:1])
UNLOAD RECORD:C212([DocketFile:6])
UNLOAD RECORD:C212([FamilyFile:20])
UNLOAD RECORD:C212([CrtAddrFile:19])