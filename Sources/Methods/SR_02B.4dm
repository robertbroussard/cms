//%attributes = {}
  //SR_02B

  //$1-> Case Type
  //$2-> True=Filed AND False=NotFiled

C_DATE:C307($BOM;$EOM)

$CaseType:=$1
$Filed:=$2
$YearMonth:=$3


If ($CaseType="T")
	$0:=vSR_02_Total
Else 
	$BOM:=Date:C102(Substring:C12($YearMonth;5;2)+"/1/"+Substring:C12($YearMonth;1;4))-1
	$EOM:=Add to date:C393($BOM;0;1;0)
	
	C_LONGINT:C283($recs;$0)
	
	
	QUERY:C277([IntakeFile:1];[IntakeFile:1]IntakeDate:4>$BOM;*)
	QUERY:C277([IntakeFile:1]; & ;[IntakeFile:1]IntakeDate:4<$EOM)
	
	CREATE SET:C116([IntakeFile:1];"Pending")
	
	INTERSECTION:C121("Pending";"UnFiledCases";"Final")
	
	SR_SelectCaseType ($CaseType;$Filed)  //Must supply "Final" Set.
	SR_RecDumpLog ("Write";0;$YearMonth;$Filed;$CaseType;"2")
	
	$recs:=Records in set:C195("Final")
	vSR_02_Total:=vSR_02_Total+$recs
	$0:=$recs
End if 