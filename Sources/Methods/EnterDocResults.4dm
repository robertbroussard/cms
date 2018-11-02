//%attributes = {"publishedWeb":true}
  //Procedure: EnterDocResults.
  //
SET WINDOW TITLE:C213("DRC Case Management System")
vSite:=""
vDate:=!00-00-00!
FORM SET INPUT:C55([DocketFile:6];"DocSearch")
QUERY BY EXAMPLE:C292([DocketFile:6])
If (OK=1)
	If (Records in selection:C76([DocketFile:6])>0)
		ORDER BY:C49([DocketFile:6];[DocketFile:6]TimeSlot:3;>;[DocketFile:6]DFCaseNo:4;>)
		vSite:=[DocketFile:6]DocketSite:1+" Docket Sheet"
		vDate:=[DocketFile:6]DocketDate:2
		FORM SET INPUT:C55([DocketFile:6];"DFInput")
		FORM SET OUTPUT:C54([DocketFile:6];"DocResults")
		MODIFY SELECTION:C204([DocketFile:6];*)
		REDRAW:C174([MedActFile:10])
	Else 
		ALERT:C41("No Docket found for that date!")
	End if 
End if 
UNLOAD RECORD:C212([DocketFile:6])
UNLOAD RECORD:C212([IntakeFile:1])
UNLOAD RECORD:C212([Details:18])
UNLOAD RECORD:C212([MediatorFile:9])
UNLOAD RECORD:C212([MedActFile:10])  // 2/19/96