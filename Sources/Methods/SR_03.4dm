//%attributes = {}
  //SR_03

  //$1-> Case Type
  //$2-> True=Filed AND False=NotFiled

$CaseType:=$1
$Filed:=$2
$YearMonth:=$3

C_LONGINT:C283($recs;$0)

  //SR_GetPending ($YearMonth)
  //CREATE SET([IntakeFile];"Pending")  `Selection contains "Pending"


If ($CaseType="T")
	$0:=vSR_03_Total
Else 
	  //----------------------------
	LIST TO ARRAY:C288("County Civil";$aCCiv)
	QUERY WITH ARRAY:C644([IntakeFile:1]RefBy:16;$aCCiv)
	CREATE SET:C116([IntakeFile:1];"CCiv")
	INTERSECTION:C121("Pending";"CCiv";"R1")
	
	LIST TO ARRAY:C288("County Criminal";$aCCrim)
	QUERY WITH ARRAY:C644([IntakeFile:1]RefBy:16;$aCCrim)
	CREATE SET:C116([IntakeFile:1];"CCrim")
	INTERSECTION:C121("Pending";"CCrim";"R2")
	
	UNION:C120("R1";"R2";"Final")  //Must end with "Final" Set!
	  //----------------------------
	
	SR_SelectCaseType ($CaseType;$Filed)
	SR_RecDumpLog ("Write";0;$YearMonth;$Filed;$CaseType;"3")
	
	$recs:=Records in set:C195("Final")
	vSR_03_Total:=vSR_03_Total+$recs
	$0:=$recs
End if 