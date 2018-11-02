//%attributes = {}
  //SR_06

  //$1-> Case Type
  //$2-> True=Filed AND False=NotFiled

$CaseType:=$1
$Filed:=$2
$YearMonth:=$3
C_LONGINT:C283($recs;$0)

  //SR_GetPending ($YearMonth)
  //CREATE SET([IntakeFile];"Pending")  `Selection contains "Pending"


If ($CaseType="T")
	$0:=vSR_06_Total
Else 
	  //----------------------------
	LIST TO ARRAY:C288("Apellate State";$aAppST)
	QUERY WITH ARRAY:C644([IntakeFile:1]RefBy:16;$aAppST)
	CREATE SET:C116([IntakeFile:1];"AS")
	INTERSECTION:C121("Pending";"AS";"R1")
	
	LIST TO ARRAY:C288("Appellate Federal";$aAppFed)
	QUERY WITH ARRAY:C644([IntakeFile:1]RefBy:16;$aAppFed)
	CREATE SET:C116([IntakeFile:1];"AF")
	INTERSECTION:C121("Pending";"AF";"R2")
	
	UNION:C120("R1";"R2";"Final")  //Must end with "Final" Set!
	  //----------------------------
	
	SR_SelectCaseType ($CaseType;$Filed)
	SR_RecDumpLog ("Write";0;$YearMonth;$Filed;$CaseType;"6")
	
	$recs:=Records in set:C195("Final")
	vSR_06_Total:=vSR_06_Total+$recs
	$0:=$recs
End if 