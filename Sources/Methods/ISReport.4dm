//%attributes = {"publishedWeb":true}
  //G-Proc: ISReport
_O_C_INTEGER:C282($Dialog;$RptLoop1)
_O_C_STRING:C293(10;$TIntakes)
SET WINDOW TITLE:C213("DRC: Intake Specialist Report")
vRptName:=""
vBegDate:=!00-00-00!
vEndDate:=!00-00-00!
vIntSite:=""
vTimeFrame:=""
vPrintDate:=""
$RptLoop1:=0
$Dialog:=1
vISName:=""
vIDNum:=""
ALL RECORDS:C47([ISIDTable:3])
SELECTION TO ARRAY:C260([ISIDTable:3]ISName:2;aISName;[ISIDTable:3]IdNumber:1;aIDNumber)
SORT ARRAY:C229(aISName;aIDNumber;>)
While ($Dialog=1)
	DIALOG:C40([IntakeFile:1];"RptSelect3")
	If (OK=1)
		Case of 
			: (vBegDate=!00-00-00!)
				ALERT:C41("You must enter the Beginning Date or choose Cancel.")
			: (vEndDate=!00-00-00!)
				ALERT:C41("You must enter the Ending Date of choose Cancel.")
			: (vISName="")
				ALERT:C41("Intake Specialist was not specified. Select a name or choose Cancel.")
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
	  //([IntakeFile]IntakeDate±vBegDate;vEndDate;[IntakeFile]IdCode=vIDNum)
	QUERY:C277([IntakeFile:1];[IntakeFile:1]IntakeDate:4>=vBegDate;*)
	QUERY:C277([IntakeFile:1]; & ;[IntakeFile:1]IntakeDate:4>=vEndDate;*)
	QUERY:C277([IntakeFile:1]; & ;[IntakeFile:1]Program:32=vIDNum)
	
	If (Records in selection:C76([IntakeFile:1])>0)
		$TIntakes:=String:C10(Records in selection:C76([IntakeFile:1]))
		If (Records in selection:C76([IntakeFile:1])>0)
			BuildSites 
			BuildStatus 
			BuildDisputes 
			BuildOutRef 
			$RptName:="Intake Specialist Report For: "+vISName
			PrintHeader ($RptName)
			vSubDetail:=$TIntakes+" intakes during report period."
			Print form:C5([IntakeFile:1];"SubHead1")
			PrintSites 
			G_PrintStatus 
			PrintDispute 
			PrintOutRef 
			PAGE BREAK:C6
		Else 
			ALERT:C41("There are no records matching your discription")
		End if 
	Else 
		ALERT:C41("There are no records matching your discription")
	End if 
End while 
SET WINDOW TITLE:C213("DRC Case Management System")