//%attributes = {}
  //11/17/06
  //SR_GetPending

C_LONGINT:C283($Days)
C_DATE:C307($BOMDate)

  //deleted 12/8/18
  //[LocationFile]LTLocName

$YearMonth:=$1

$BOMDate:=Date:C102(Substring:C12($YearMonth;5;2)+"/01/"+Substring:C12($YearMonth;1;4))
$Days:=Current date:C33-$BOMDate

If ($Days>38)  //then use legacy logic.
	  //If (False)  `then use legacy logic.
	  //Select pending for a particular date
	  //get DocketFile recs
	
	  //select cases entered before the EOM and older
	  //select those whose settlement date was after EOM.
	  //Look at the latest Docket file date
	
	If (Not:C34(vSR_LegacyPenSelected))  //If the set is already built DO NOT rebuild...  Optimized for multi-legacy file select...
		$EOMDate:=Add to date:C393($BOMDate;0;1;0)  //EOM Plus 1.
		QUERY:C277([IntakeFile:1];[IntakeFile:1]IntakeDate:4<$EOMDate)
		$rec:=Records in selection:C76([IntakeFile:1])
		CREATE EMPTY SET:C140([IntakeFile:1];"Pending")
		FIRST RECORD:C50([IntakeFile:1])
		For ($i;1;$rec)
			MESSAGE:C88("Reconstructing 'Pending' cases for "+$YearMonth+". Processing "+String:C10($i)+" of "+String:C10($rec)+".")
			QUERY:C277([DocketFile:6];[DocketFile:6]DFCaseNo:4=[IntakeFile:1]CaseNo:1)
			ORDER BY:C49([DocketFile:6];[DocketFile:6]DocketDate:2;>)
			LAST RECORD:C200([DocketFile:6])
			If (([DocketFile:6]HResults:11="") & ([DocketFile:6]DocketDate:2#!00-00-00!)) | ([DocketFile:6]DocketDate:2>=$EOMDate)  //either still pending or was resolved after this monthly period.
				ADD TO SET:C119([IntakeFile:1];"Pending")
			End if 
			NEXT RECORD:C51([IntakeFile:1])
		End for 
		USE SET:C118("Pending")
		vSR_LegacyPenSelected:=True:C214
	End if 
Else 
	vSR_LegacyPenSelected:=False:C215
	QUERY:C277([DocketFile:6];[DocketFile:6]HResults:11="";*)
	QUERY:C277([DocketFile:6]; & ;[DocketFile:6]DocketDate:2#!00-00-00!)
	RELATE ONE SELECTION:C349([DocketFile:6];[IntakeFile:1])
	CREATE SET:C116([IntakeFile:1];"Pending")  //Selection contains "Pending"
End if 
  //[IntakeFile];"\tReferrals"[IntakeFile];"\tReferrals"[IntakeFile];"\tReferrals"LTLocID
  //What???  2/25/08

