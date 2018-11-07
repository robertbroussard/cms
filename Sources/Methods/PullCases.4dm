//%attributes = {"publishedWeb":true}
  //G-Procedure: PullCases;
C_LONGINT:C283($i)
vNewIntake:=False:C215
vNewIntake2:=False:C215
  //vSite:=""
  //vDate:=!00-00-00!
DIALOG:C40([DocketFile:6];"PullCaseSearch")
If (OK=1)
	QUERY:C277([DocketFile:6];[DocketFile:6]DocketSite:1=vSite;*)
	QUERY:C277([DocketFile:6];[DocketFile:6]DocketDate:2=vDate)
	If (Records in selection:C76([DocketFile:6])>0)
		RELATE ONE SELECTION:C349([DocketFile:6];[IntakeFile:1])
		vText2:="Intake File: "+String:C10(Records in selection:C76([IntakeFile:1]))+" of "+String:C10(Records in table:C83([IntakeFile:1]))
		NEXT RECORD:C51([DocketFile:6])
		ORDER BY:C49([IntakeFile:1];[IntakeFile:1]CaseNo:1;>)
		FORM SET OUTPUT:C54([IntakeFile:1];"PCDisplay")
		FORM SET INPUT:C55([IntakeFile:1];"TestIntake")
		MODIFY SELECTION:C204([IntakeFile:1];*)
	Else 
		ALERT:C41("No cases found for that docket.")
	End if 
End if 
UNLOAD RECORD:C212([IntakeFile:1])



  //  //G-Procedure: PullCases;
  //C_LONGINT($i)
  //vNewIntake:=False
  //vNewIntake2:=False
  //vSite:=""
  //vDate:=!00-00-00!
  //DIALOG([DocketFile];"PullCaseSearch")
  //If (OK=1)
  //QUERY([DocketFile];[DocketFile]DocketSite=vSite;*)
  //QUERY([DocketFile];[DocketFile]DocketDate=vDate)
  //If (Records in selection([DocketFile])>0)
  //CREATE EMPTY SET([IntakeFile];"PCTempSet")
  //For ($i;1;Records in selection([DocketFile]))
  //RELATE ONE([DocketFile]DFCaseNo)
  //ADD TO SET([IntakeFile];"PCTempSet")
  //NEXT RECORD([DocketFile])
  //End for 
  //USE SET("PCTempSet")
  //ORDER BY([IntakeFile];[IntakeFile]CaseNo;>)
  //FORM SET OUTPUT([IntakeFile];"PCDisplay")
  //FORM SET INPUT([IntakeFile];"TestIntake")
  //MODIFY SELECTION([IntakeFile];*)
  //Else 
  //ALERT("No cases found for that docket.")
  //End if 
  //End if 
  //UNLOAD RECORD([IntakeFile])



