//%attributes = {"publishedWeb":true}

  // ----------------------------------------------------
  // User name (OS): robert
  // Date and time: 12/14/18, 15:10:19
  // ----------------------------------------------------
  // Method: EnterDocResults

  //ALERT Not In Use. Double clicking the Docket record from the subform listing on the INtake detail form 
  //allows editing....  not sure if more meeds to be done.


  //SET WINDOW TITLE("DRC Case Management System")
vSite:=""
vDate:=!00-00-00!
  //FORM SET INPUT([DocketFile];"DocSearch")
  //QUERY BY EXAMPLE([DocketFile])
QUERY:C277([DocketFile:6];[DocketFile:6]DFCaseNo:4=[IntakeFile:1]CaseNo:1)
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
  //UNLOAD RECORD([IntakeFile])
UNLOAD RECORD:C212([Details:18])
UNLOAD RECORD:C212([MediatorFile:9])
UNLOAD RECORD:C212([MedActFile:10])  // 2/19/96

  //  //Procedure: EnterDocResults.
  //  //
  //SET WINDOW TITLE("DRC Case Management System")
  //vSite:="DRC Day"
  //vDate:=!2012-01-18!
  //FORM SET INPUT([DocketFile];"DocSearch")
  //QUERY BY EXAMPLE([DocketFile])
  //If (OK=1)
  //If (Records in selection([DocketFile])>0)
  //ORDER BY([DocketFile];[DocketFile]TimeSlot;>;[DocketFile]DFCaseNo;>)
  //vSite:=[DocketFile]DocketSite+" Docket Sheet"
  //vDate:=[DocketFile]DocketDate
  //FORM SET INPUT([DocketFile];"DFInput")
  //FORM SET OUTPUT([DocketFile];"DocResults")
  //MODIFY SELECTION([DocketFile];*)
  //REDRAW([MedActFile])
  //Else 
  //ALERT("No Docket found for that date!")
  //End if 
  //End if 
  //UNLOAD RECORD([DocketFile])
  //UNLOAD RECORD([IntakeFile])
  //UNLOAD RECORD([Details])
  //UNLOAD RECORD([MediatorFile])
  //UNLOAD RECORD([MedActFile]