//%attributes = {"publishedWeb":true}
  //Procedure: PrintDocket;
_O_C_INTEGER:C282($LineCount;$MedCount;$i;$j;$h;$PgNo;$TheRest;$Page)
vSite:=""
vDate:=!00-00-00!
vPrintDate:=""
vSchCases:=0
vpdDCL:=0
vpdCON:=0
vpdNS:=0
vpdVEN:=0
vTMED:=0
vpdSTL:=0
vpdIMP:=0
vpdCONT:=0
vpdRS:=0
$PgNo:=0
$TheRest:=0
vDPgNo:=""
CPrintName:=""
RPrintName:=""
$LineCount:=0
$MedCount:=0
$i:=0
$j:=0
$h:=0
FORM SET INPUT:C55([DocketFile:6];"DocSearch")
QUERY BY EXAMPLE:C292([DocketFile:6])
If ((Records in selection:C76([DocketFile:6])>0) & (OK=1))
	PAGE SETUP:C299([DocketFile:6];"PDHeader")
	ORDER BY:C49([DocketFile:6];[DocketFile:6]TimeSlot:3;>;[DocketFile:6]DFCaseNo:4;>)
	vSchCases:=Records in selection:C76([DocketFile:6])
	vSite:=[DocketFile:6]DocketSite:1+" Docket Sheet"
	vPrintDate:=String:C10(Current date:C33;7)+" @ "+String:C10(Current time:C178;5)
	vDate:=[DocketFile:6]DocketDate:2
	$LineCount:=0
	If (Records in selection:C76([DocketFile:6])>22)
		$Page:=22
		$TheRest:=(Records in selection:C76([DocketFile:6])-$Page)
	Else 
		$Page:=(22-Records in selection:C76([DocketFile:6]))
		$TheRest:=0
	End if 
	Print form:C5([DocketFile:6];"PDHeader")
	For ($h;1;Records in selection:C76([DocketFile:6]))
		RELATE MANY:C262([DocketFile:6]DFCaseNo:4)
		RELATE ONE:C42([DocketFile:6]DFCaseNo:4;[IntakeFile:1]CaseNo:1)
		RELATE MANY:C262([DocketFile:6]DocKey:6)
		Case of 
			: ([DocketFile:6]HResults:11="DCL")
				vpdDCL:=vpdDCL+1
			: ([DocketFile:6]HResults:11="CON")
				vpdCON:=vpdCON+1
			: ([DocketFile:6]HResults:11="NS")
				vpdNS:=vpdNS+1
			: ([DocketFile:6]HResults:11="VEN")
				vpdVEN:=vpdVEN+1
			: ([DocketFile:6]HResults:11="STL")
				vTMED:=vTMED+1
				vpdSTL:=vpdSTL+1
			: ([DocketFile:6]HResults:11="IMP")
				vTMED:=vTMED+1
				vpdIMP:=vpdIMP+1
			: ([DocketFile:6]HResults:11="CONT")
				vTMED:=vTMED+1
				vpdCONT:=vpdCONT+1
			: ([DocketFile:6]HResults:11="R/S")
				vpdRS:=vpdRS+1
		End case 
		CPrintName:=[IntakeFile:1]CLName:6+", "+[IntakeFile:1]CFName:7
		RPrintName:=[IntakeFile:1]RLName:11+", "+[IntakeFile:1]RFName:12
		If (Records in selection:C76([MedActFile:10])>1)
			Print form:C5([DocketFile:6];"DocPrint")
			$Page:=$Page-1
			$LineCount:=$LineCount+1
			$MedCount:=(Records in selection:C76([MedActFile:10])-1)
			NEXT RECORD:C51([MedActFile:10])
			For ($i;1;$MedCount)
				vpdMed:=[MedActFile:10]mafKey:1
				Print form:C5([DocketFile:6];"DocMedPrint")
				$Page:=$Page-1
				$LineCount:=$LineCount+1
				NEXT RECORD:C51([MedActFile:10])
			End for 
		Else 
			Print form:C5([DocketFile:6];"DocPrint")
			$Page:=$Page-1
			$LineCount:=$LineCount+1
		End if 
		If ($TheRest>1)
			If ($Page=0)
				PAGE BREAK:C6
				$PgNo:=$PgNo+1
				vDPgNo:="Page: "+String:C10($PgNo)
				Print form:C5([DocketFile:6];"PDHeader")
				If ($TheRest>22)
					$TheRest:=($TheRest-22)
					$Page:=22
					$LineCount:=0
				Else 
					$Page:=$TheRest
					$TheRest:=0
					$LineCount:=0
				End if 
			End if 
			NEXT RECORD:C51([DocketFile:6])
		Else 
			NEXT RECORD:C51([DocketFile:6])
		End if 
	End for 
	For ($j;1;22-$LineCount)
		Print form:C5([DocketFile:6];"PDSpace")
	End for 
	Print form:C5([DocketFile:6];"PDFooter")
	PAGE BREAK:C6
Else 
	If (OK=1)
		ALERT:C41("No Docket found for that date!")
	End if 
End if 
UNLOAD RECORD:C212([DocketFile:6])
UNLOAD RECORD:C212([IntakeFile:1])
UNLOAD RECORD:C212([MedActFile:10])