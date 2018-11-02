//%attributes = {}
  //SR_11

  //$1-> Case Type
  //$2-> True=Filed AND False=NotFiled

C_DATE:C307($BOM;$EOM)

$CaseType:=$1
$Filed:=$2
$YearMonth:=$3

If ($CaseType="T")
	$0:=vSR_11_Total
Else 
	$BOM:=Date:C102(Substring:C12($YearMonth;5;2)+"/1/"+Substring:C12($YearMonth;1;4))-1
	$EOM:=Add to date:C393($BOM;0;1;0)
	
	C_LONGINT:C283($recs;$0)
	
	
	QUERY:C277([DocketFile:6];[DocketFile:6]DocketDate:2>$BOM;*)
	QUERY:C277([DocketFile:6]; & ;[DocketFile:6]DocketDate:2<$EOM)
	QUERY SELECTION:C341([DocketFile:6];[DocketFile:6]HResults:11="STL";*)
	QUERY SELECTION:C341([DocketFile:6]; | ;[DocketFile:6]HResults:11="DCL";*)
	QUERY SELECTION:C341([DocketFile:6]; | ;[DocketFile:6]HResults:11="VEN")
	RELATE ONE SELECTION:C349([DocketFile:6];[IntakeFile:1])
	
	CREATE SET:C116([IntakeFile:1];"Pending")
	
	INTERSECTION:C121("Pending";"FiledCases";"Final")
	
	SR_SelectCaseType ($CaseType;$Filed)  //Must supply "Final" Set.
	SR_RecDumpLog ("Write";0;$YearMonth;$Filed;$CaseType;"11")
	
	$recs:=Records in set:C195("Final")
	vSR_11_Total:=vSR_11_Total+$recs
	$0:=$recs
End if 