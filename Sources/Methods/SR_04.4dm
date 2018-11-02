//%attributes = {}
  //SR_04

  //$1-> Case Type
  //$2-> True=Filed AND False=NotFiled

$CaseType:=$1
$Filed:=$2
$YearMonth:=$3

C_LONGINT:C283($recs;$0)

  //SR_GetPending ($YearMonth)
  //CREATE SET([IntakeFile];"Pending")  `Selection contains "Pending"


If ($CaseType="T")
	$0:=vSR_04_Total
Else 
	  //----------------------------
	LIST TO ARRAY:C288("Municipal, Houston";$aMuni)
	QUERY WITH ARRAY:C644([IntakeFile:1]RefBy:16;$aMuni)
	CREATE SET:C116([IntakeFile:1];"Muni")
	INTERSECTION:C121("Pending";"Muni";"R1")
	
	QUERY:C277([IntakeFile:1];[IntakeFile:1]RefBy:16="Muni, Pasadena")
	CREATE SET:C116([IntakeFile:1];"MuniP")
	INTERSECTION:C121("Pending";"MuniP";"R2")
	
	UNION:C120("R1";"R2";"Final")  //Must end with "Final" Set!
	  //----------------------------
	
	SR_SelectCaseType ($CaseType;$Filed)
	SR_RecDumpLog ("Write";0;$YearMonth;$Filed;$CaseType;"4")
	
	$recs:=Records in set:C195("Final")
	vSR_04_Total:=vSR_04_Total+$recs
	$0:=$recs
End if 