//%attributes = {}
  //SR_07

  //$1-> Case Type
  //$2-> True=Filed AND False=NotFiled

$CaseType:=$1
$Filed:=$2
$YearMonth:=$3

C_LONGINT:C283($recs;$0)

  //SR_GetPending ($YearMonth)
  //CREATE SET([IntakeFile];"Final")  `Selection contains "Pending"
  //COPY SET("Pending";"Final")

If ($CaseType="T")
	$0:=vSR_07_Total
Else 
	  //----------------------------
	INTERSECTION:C121("Pending";"FiledCases";"Final")
	
	  //----------------------------
	SR_SelectCaseType ($CaseType;$Filed)
	SR_RecDumpLog ("Write";0;$YearMonth;$Filed;$CaseType;"7")
	
	$recs:=Records in set:C195("Final")
	vSR_07_Total:=vSR_07_Total+$recs
	$0:=$recs
End if 