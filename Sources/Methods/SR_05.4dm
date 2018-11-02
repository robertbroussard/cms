//%attributes = {}
  //SR_05

  //$1-> Case Type
  //$2-> True=Filed AND False=NotFiled

$CaseType:=$1
$Filed:=$2
$YearMonth:=$3

C_LONGINT:C283($recs;$0)

  //SR_GetPending ($YearMonth)
  //CREATE SET([IntakeFile];"Pending")  `Selection contains "Pending"


If ($CaseType="T")
	$0:=vSR_05_Total
Else 
	  //----------------------------
	LIST TO ARRAY:C288("Justices of the Peace";$aJP)
	QUERY WITH ARRAY:C644([IntakeFile:1]RefBy:16;$aJP)
	CREATE SET:C116([IntakeFile:1];"JP")
	INTERSECTION:C121("Pending";"JP";"Final")
	
	  //----------------------------
	
	SR_SelectCaseType ($CaseType;$Filed)
	SR_RecDumpLog ("Write";0;$YearMonth;$Filed;$CaseType;"5")
	
	$recs:=Records in set:C195("Final")
	vSR_05_Total:=vSR_05_Total+$recs
	$0:=$recs
End if 