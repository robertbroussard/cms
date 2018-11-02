//%attributes = {}
  //SR_12

  //$1-> Case Type
  //$2-> True=Filed AND False=NotFiled

$CaseType:=$1
$Filed:=$2
$YearMonth:=$3
$Seq:=$4

C_LONGINT:C283($recs;$0)

  //SR_GetPending ($YearMonth)
  //CREATE SET([IntakeFile];"Final")  `Selection contains "Pending"

  //COPY SET("Pending";"Final")

  //----------------------------

If ($CaseType="T")
	aBOM{$seq}:=vSR_12_Total
	SR_BOM_Save ($YearMonth;$Filed)
	$0:=vSR_12_Total
Else 
	  //----------------------------
	
	INTERSECTION:C121("Pending";"FiledCases";"Final")
	
	SR_SelectCaseType ($CaseType;$Filed)
	SR_RecDumpLog ("Write";0;$YearMonth;$Filed;$CaseType;"12")
	
	$recs:=Records in set:C195("Final")
	vSR_12_Total:=vSR_12_Total+$recs
	aBOM{$seq}:=$recs
	$0:=$recs
End if 