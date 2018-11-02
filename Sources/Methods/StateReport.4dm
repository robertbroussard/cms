//%attributes = {"publishedWeb":true}
  //G-Procedure: StateReport; This proc is called from the main menu.
_O_C_INTEGER:C282($i;$Code;$RptLoop1;$RptLoop2;$Dialog;$RB)
SET WINDOW TITLE:C213("CMS State Report")
vBegDate:=!00-00-00!
vEndDate:=!00-00-00!
$RptLoop1:=0
$RptLoop2:=0
vTimeFrame:=""
vHBA:=True:C214  //This set the un-needed script for the dialog.
CLEAR VARIABLE:C89(aState)
CLEAR VARIABLE:C89(aStateA)
CLEAR VARIABLE:C89(aStateM)
ARRAY INTEGER:C220(aState;6;38)
ARRAY INTEGER:C220(aStateA;8;15)
ARRAY INTEGER:C220(aStateM;8;10)
  //********************************
$Dialog:=1
While ($Dialog=1)
	DIALOG:C40([IntakeFile:1];"RptSelections")
	If (OK=1)
		Case of 
			: (vBegDate=!00-00-00!)
				ALERT:C41("You must enter the Beginning Date or choose Cancel!")
			: (vEndDate=!00-00-00!)
				ALERT:C41("You must enter the Ending Date or choose Cancel!")
			Else 
				$Dialog:=0
				$RptLoop1:=1
		End case 
	Else 
		$Dialog:=0
	End if 
End while 
While ($RptLoop1=1)
	$RptLoop1:=0
	QUERY:C277([IntakeFile:1];[IntakeFile:1]IntakeDate:4<=vEndDate)
	ORDER BY:C49([IntakeFile:1];[IntakeFile:1]IntakeDate:4;>)
	For ($i;1;Records in selection:C76([IntakeFile:1]))
		RELATE ONE:C42([IntakeFile:1]DisputeCode:22)
		$Code:=[DisputeFile:4]StateCode:4
		If (([IntakeFile:1]Program:32#"a") & ([IntakeFile:1]Program:32#"m"))  // ADDED 01/95
			Case of 
				: ([IntakeFile:1]IntakeDate:4<vBegDate)
					Case of 
						: ([IntakeFile:1]CaseStatus:25="Hold")
							aState{$Code}{1}:=aState{$Code}{1}+1
							aState{$Code}{38}:=aState{$Code}{38}
						: ([IntakeFile:1]CaseStatus:25="Scheduled")
							SR_Prior_Sch ($Code)
						: ([IntakeFile:1]CaseStatus:25="")
							[IntakeFile:1]CaseStatus:25:="Hold"
							SAVE RECORD:C53([IntakeFile:1])
							aState{$Code}{1}:=aState{$Code}{1}+1
							aState{$Code}{38}:=aState{$Code}{38}
					End case 
				: ([IntakeFile:1]IntakeDate:4<=vEndDate)
					$RB:=GetRefByLine 
					Case of 
						: (([IntakeFile:1]CaseStatus:25="Referred") | ([IntakeFile:1]CaseStatus:25="Direct Assistance"))
							aState{$Code}{$RB}:=aState{$Code}{$RB}+1
							aState{$Code}{22}:=aState{$Code}{22}+1
						: ([IntakeFile:1]CaseStatus:25="Hold")
							aState{$Code}{$RB}:=aState{$Code}{$RB}+1
							aState{$Code}{38}:=aState{$Code}{38}
						: ([IntakeFile:1]CaseStatus:25="Scheduled")
							aState{$Code}{$RB}:=aState{$Code}{$RB}+1
							SR_Scheduled ($Code)
						: ([IntakeFile:1]CaseStatus:25="")
							[IntakeFile:1]CaseStatus:25:="Hold"
							SAVE RECORD:C53([IntakeFile:1])
							aState{$Code}{$RB}:=aState{$Code}{$RB}+1
							aState{$Code}{38}:=aState{$Code}{38}
					End case 
			End case 
		Else 
			If ([IntakeFile:1]Program:32="M")
				SR_Build_M ($Code)  //PROGRAM TYPE IS A - DIFF REPORT, 01/95
			Else 
				SR_Build_A ($Code)  //PROGRAM TYPE IS M - DIFF REPORT
			End if 
		End if 
		NEXT RECORD:C51([IntakeFile:1])
	End for 
	SR_Totals 
	BuildLineArray 
	PRINT SETTINGS:C106
	vRptName:="State Report - Part A"
	vTimeFrame:="From: "+String:C10(vBegDate;7)+" To: "+String:C10(vEndDate;7)
	vPrintDate:="Date Printed: "+String:C10(Current date:C33;7)
	Print form:C5([IntakeFile:1];"RptHeader")
	vSubDetail:=""
	Print form:C5([IntakeFile:1];"SubHead1")
	For ($i;1;38)
		v1:=aLineName{$i}
		v2:=aState{1}{$i}
		v3:=aState{2}{$i}
		v4:=aState{3}{$i}
		v5:=aState{4}{$i}
		v6:=aState{5}{$i}
		v7:=aState{6}{$i}
		Print form:C5([IntakeFile:1];"StateDetail")
	End for 
	PAGE BREAK:C6
	SR_Print_M   // ADDED 01/95
	SR_Print_A 
End while 
CLEAR VARIABLE:C89(aState)
CLEAR VARIABLE:C89(vHBA)
CLEAR VARIABLE:C89(aLineName)
SET WINDOW TITLE:C213("DRC Case Management System")
UNLOAD RECORD:C212([IntakeFile:1])