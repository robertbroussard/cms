//%attributes = {"publishedWeb":true}
  //G-Proc: SiteReport
_O_C_INTEGER:C282($RptLoop1;$Dialog)
_O_C_STRING:C293(15;$Site)
SET WINDOW TITLE:C213("DRC: Intake Site Report")
vRptName:=""
vBegDate:=!00-00-00!
vEndDate:=!00-00-00!
vIntSite:=""
vTimeFrame:=""
vPrintDate:=""
$RptLoop1:=0
$Dialog:=1
While ($Dialog=1)
	DIALOG:C40([IntakeFile:1];"RptSelect2")
	If (OK=1)
		Case of 
			: (vBegDate=!00-00-00!)
				ALERT:C41("You must enter the Beginning Date or choose Cancel.")
			: (vEndDate=!00-00-00!)
				ALERT:C41("You must enter the Ending Date of choose Cancel.")
			: (vIntSite="")
				ALERT:C41("Intake site was not specified. Select a Site or choose Cancel.")
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
	$Site:=GetSite (vIntSite)
	QUERY:C277([IntakeFile:1];[IntakeFile:1]IntakeDate:4>=vBegDate;*)
	QUERY:C277([IntakeFile:1]; & ;[IntakeFile:1]IntakeDate:4<=vEndDate;*)
	QUERY:C277([IntakeFile:1]; & ;[IntakeFile:1]LocCode:2=$Site)
	$TIntakes:=String:C10(Records in selection:C76([IntakeFile:1]))
	If (Records in selection:C76([IntakeFile:1])>0)
		BuildStatus 
		BuildRefBy 
		BuildDisputes 
		BuildRelations 
		BuildOutRef 
		$RptName:="Intake Site Report For: "+vIntSite
		PrintHeader ($RptName)
		vSubDetail:=$TIntakes+" intakes during report period."
		Print form:C5([IntakeFile:1];"SubHead1")
		vSubDetail:="Status of Intakes from: "+vIntSite
		Print form:C5([IntakeFile:1];"SubHead1")
		G_PrintStatus 
		PrintReferral 
		PrintDispute 
		PrintRelation 
		PrintOutRef 
		PAGE BREAK:C6
	Else 
		ALERT:C41("There are no records matching your discription")
	End if 
End while 
SET WINDOW TITLE:C213("DRC Case Management System")
