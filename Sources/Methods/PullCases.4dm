//%attributes = {"publishedWeb":true}
  //G-Procedure: PullCases;
C_LONGINT:C283($i)
vNewIntake:=False:C215
vNewIntake2:=False:C215
vSite:=""
vDate:=!00-00-00!
DIALOG:C40([DocketFile:6];"PullCaseSearch")
If (OK=1)
	QUERY:C277([DocketFile:6];[DocketFile:6]DocketSite:1=vSite;*)
	QUERY:C277([DocketFile:6];[DocketFile:6]DocketDate:2=vDate)
	If (Records in selection:C76([DocketFile:6])>0)
		CREATE EMPTY SET:C140([IntakeFile:1];"PCTempSet")
		For ($i;1;Records in selection:C76([DocketFile:6]))
			RELATE ONE:C42([DocketFile:6]DFCaseNo:4)
			ADD TO SET:C119([IntakeFile:1];"PCTempSet")
			NEXT RECORD:C51([DocketFile:6])
		End for 
		USE SET:C118("PCTempSet")
		ORDER BY:C49([IntakeFile:1];[IntakeFile:1]CaseNo:1;>)
		FORM SET OUTPUT:C54([IntakeFile:1];"PCDisplay")
		FORM SET INPUT:C55([IntakeFile:1];"TestIntake")
		MODIFY SELECTION:C204([IntakeFile:1];*)
	Else 
		ALERT:C41("No cases found for that docket.")
	End if 
End if 
UNLOAD RECORD:C212([IntakeFile:1])