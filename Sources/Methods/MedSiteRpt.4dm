//%attributes = {"publishedWeb":true}
  //G-Proc: MedSiteRpt;
  //
_O_C_INTEGER:C282($TIntakes;$Dialog;$RptLoop1)
SET WINDOW TITLE:C213("DRC: Mediation Site Report")
CREATE EMPTY SET:C140([IntakeFile:1];"OKSet")
vRptName:=""
vBegDate:=!00-00-00!
vEndDate:=!00-00-00!
vSite:=""
vTimeFrame:=""
vPrintDate:=""
$RptLoop1:=0
$Dialog:=1
vISName:=""
vIDNum:=""
ALL RECORDS:C47([SiteConstraints:7])
SELECTION TO ARRAY:C260([SiteConstraints:7]Site:1;aSDisplay)
SORT ARRAY:C229(aSDisplay;>)
While ($Dialog=1)
	DIALOG:C40([IntakeFile:1];"RptSelect4")
	If (OK=1)
		Case of 
			: (vBegDate=!00-00-00!)
				ALERT:C41("You must enter the Beginning Date or choose Cancel.")
			: (vEndDate=!00-00-00!)
				ALERT:C41("You must enter the Ending Date of choose Cancel.")
			: (vSite="")
				ALERT:C41("Docket Site was not specified. Select a name or choose Cancel.")
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
	ALL RECORDS:C47([DocketFile:6])
	QUERY:C277([DocketFile:6];[DocketFile:6]DocketDate:2>=vBegDate;*)
	QUERY:C277([DocketFile:6]; & ;[DocketFile:6]DocketDate:2<=vEndDate;*)
	QUERY:C277([DocketFile:6]; & ;[DocketFile:6]DocketSite:1=vSite)
	If (Records in selection:C76([DocketFile:6])>0)
		BuildHResults 
		$TIntakes:=Records in set:C195("OKSet")
		USE SET:C118("OKSet")
		BuildRefBy 
		BuildDisputes 
		BuildPrograms 
		$RptName:="Mediation Site Report For: "+vSite
		PrintHeader ($RptName)
		vSubDetail:=""
		Print form:C5([IntakeFile:1];"SubHead1")  // Print blank line
		vSubDetail:="Site Settlement Rate: "+vStlRate
		Print form:C5([IntakeFile:1];"SubHead1")  // Print the Settlement Rate
		vSubDetail:="Mediations held: "+vHeld
		Print form:C5([IntakeFile:1];"SubHead1")  // Print mediations held
		vSubDetail:="Mediations scheduled: "+vSch
		Print form:C5([IntakeFile:1];"SubHead1")  // Print mediations scheduled
		PrintHResults ($TIntakes)
		PrintReferral 
		PrintDispute 
		PrintPrograms 
		PAGE BREAK:C6
	Else 
		ALERT:C41("There are no records matching your description")
	End if 
End while 
SET WINDOW TITLE:C213("DRC Case Management System")