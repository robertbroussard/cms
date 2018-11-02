//%attributes = {}
  //11/15/06

  //$1-> Case Type
  //$2-> True=Filed AND False=NotFiled

$CaseType:=$1
$Filed:=$2
$YearMonth:=$3

C_LONGINT:C283($recs;$0)

  //SR_GetPending ($YearMonth)
  //CREATE SET([IntakeFile];"Pending")  `Selection contains "Pending"

If ($CaseType="T")
	$0:=vSR_02_Total
Else 
	  //----------------------------
	LIST TO ARRAY:C288("Criminal District";$aCrimDC)
	QUERY WITH ARRAY:C644([IntakeFile:1]RefBy:16;$aCrimDC)
	CREATE SET:C116([IntakeFile:1];"DC")
	INTERSECTION:C121("Pending";"DC";"R1")
	
	LIST TO ARRAY:C288("Civil District";$aCivilDC)
	QUERY WITH ARRAY:C644([IntakeFile:1]RefBy:16;$aCivilDC)
	CREATE SET:C116([IntakeFile:1];"DC")
	INTERSECTION:C121("Pending";"DC";"R2")
	
	UNION:C120("R1";"R2";"Final")  //Must end with "Final" Set!
	  //----------------------------
	SR_SelectCaseType ($CaseType;$Filed)
	
	SR_RecDumpLog ("Write";0;$YearMonth;$Filed;$CaseType;"2")
	
	$recs:=Records in set:C195("Final")
	vSR_02_Total:=vSR_02_Total+$recs
	$0:=$recs
End if 