//%attributes = {"publishedWeb":true}
  //G-Procedure: HBA_Rpt; This proc is called from the main menu.
SET WINDOW TITLE:C213("CMS HBA Monthly Report")
Init_HBA_Rpt 
_O_C_INTEGER:C282($Insert;$Dialog;$RptLoop1;$RptLoop2;$MainCount)
_O_C_STRING:C293(70;$Message)
_O_C_STRING:C293(1;$Suffix)
vBegDate:=!00-00-00!
vEndDate:=!00-00-00!
$RptLoop1:=0
$RptLoop2:=0
vHBA:=True:C214
_O_ARRAY STRING:C218(20;aBadResults;0)
_O_ARRAY STRING:C218(20;aBadStatus;0)
_O_ARRAY STRING:C218(20;aBIMResults;0)
_O_ARRAY STRING:C218(20;aBadDate;0)
_O_ARRAY STRING:C218(20;aBadSuffix;0)
_O_ARRAY STRING:C218(20;aUnKnowProb;0)
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
	  //QUERY([IntakeFile];[IntakeFile]IntakeDate>=vBegDate;*)
	QUERY:C277([IntakeFile:1];[IntakeFile:1]IntakeDate:4<=vEndDate)
	ORDER BY:C49([IntakeFile:1];[IntakeFile:1]IntakeDate:4;>)
	
	For ($MainCount;1;Records in selection:C76([IntakeFile:1]))
		$Suffix:=[IntakeFile:1]Program:32
		Case of 
			: ([IntakeFile:1]IntakeDate:4<vBegDate)
				Case of 
					: ([IntakeFile:1]CaseStatus:25="Hold")
						Pen_Prior ($Suffix)
						Pen_Next ($Suffix)
					: ([IntakeFile:1]CaseStatus:25="Scheduled")
						Prior_Sch ($Suffix)
					: ([IntakeFile:1]CaseStatus:25="")
						$Insert:=Size of array:C274(aBadStatus)+1
						INSERT IN ARRAY:C227(aBadStatus;$Insert)
						aBadStatus{$Insert}:=[IntakeFile:1]CaseNo:1+":"+String:C10([IntakeFile:1]IntakeDate:4;7)
						Pen_Prior ($Suffix)
						Pen_Next ($Suffix)
				End case 
			: ([IntakeFile:1]IntakeDate:4<=vEndDate)
				Case of 
					: (([IntakeFile:1]CaseStatus:25="Referred") | ([IntakeFile:1]CaseStatus:25="Direct Assistance"))
						RM_RefNClosed ($Suffix)
					: ([IntakeFile:1]CaseStatus:25="Hold")
						RM_Hold ($Suffix)
					: ([IntakeFile:1]CaseStatus:25="Scheduled")
						RM_Sch ($Suffix)
						G_Scheduled ($Suffix)
					: ([IntakeFile:1]CaseStatus:25="")
						$Insert:=Size of array:C274(aBadStatus)+1
						INSERT IN ARRAY:C227(aBadStatus;$Insert)
						aBadStatus{$Insert}:=[IntakeFile:1]CaseNo:1+":"+String:C10([IntakeFile:1]IntakeDate:4;7)
						Pen_Next ($Suffix)
				End case 
		End case 
		NEXT RECORD:C51([IntakeFile:1])
	End for 
	  //This section prints the Problem cases out using arrays that have
	  //been updated during the report procedure.
	PRINT SETTINGS:C106
	vPage:=1
	vNumLines:=0
	vPrintDate:="Printed: "+String:C10(Current date:C33;7)
	vPrintHead:=True:C214
	Print form:C5([IntakeFile:1];"HBA_Print")
	PAGE BREAK:C6
	vPrintDate:="Printed: "+String:C10(Current date:C33;7)+"; Page: "+String:C10(vPage)
	  //This call will print a list of the cases with bad hearing results.
	$Message:="The following cases have a problem with the hearing results. "
	SORT ARRAY:C229(aBadResults)
	ArrPtr:=->aBadResults
	PrintProb ($Message)
	  //This call will print a list of the cases with a bad case status.
	$Message:="The following cases have a problem with the case status. "
	SORT ARRAY:C229(aBadStatus)
	ArrPtr:=->aBadStatus
	PrintProb ($Message)
	  //This call will print a list of the cases with bad 'in month' results.
	$Message:="The following cases should be closed for reporting month. "
	SORT ARRAY:C229(aBIMResults)
	ArrPtr:=->aBIMResults
	PrintProb ($Message)
	  //This call will print a list of the cases with a bad docket date.
	$Message:="The following cases have a problem with the docket date. "
	SORT ARRAY:C229(aBadDate)
	ArrPtr:=->aBadDate
	PrintProb ($Message)
	  //This call will print a list of the cases with a bad suffix.
	$Message:="The following cases have a bad case suffix. "
	SORT ARRAY:C229(aBadSuffix)
	ArrPtr:=->aBadSuffix
	PrintProb ($Message)
	  //This call will print a list of the cases with an unknown problem.
	$Message:="The following cases have an unknown problem."
	SORT ARRAY:C229(aUnKnowProb)
	ArrPtr:=->aUnKnowProb
	PrintProb ($Message)
	PAGE BREAK:C6
End while 
CLEAR VARIABLE:C89(aBadResults)
CLEAR VARIABLE:C89(aBadStatus)
CLEAR VARIABLE:C89(aBIMResults)
CLEAR VARIABLE:C89(aBadDate)
CLEAR VARIABLE:C89(aBadSuffix)
CLEAR VARIABLE:C89(aUnKnowProb)
CLEAR VARIABLE:C89(vHBA)
SET WINDOW TITLE:C213("DRC Case Management System")