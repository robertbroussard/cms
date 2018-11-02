//%attributes = {}
  //SR_13


  //$1-> Case Type

  //$2-> True=Filed AND False=NotFiled


C_DATE:C307($BOM;$EOM)
C_LONGINT:C283($Hrs;$i;$rec)

$CaseType:=$1
$Filed:=$2
$YearMonth:=$3



$BOM:=Date:C102(Substring:C12($YearMonth;5;2)+"/1/"+Substring:C12($YearMonth;1;4))-1
$EOM:=Add to date:C393($BOM;0;1;0)

C_LONGINT:C283($recs;$0)


QUERY:C277([DocketFile:6];[DocketFile:6]DocketDate:2>$BOM;*)
QUERY:C277([DocketFile:6]; & ;[DocketFile:6]DocketDate:2<$EOM)
QUERY SELECTION:C341([DocketFile:6];[DocketFile:6]HResults:11="STL";*)
QUERY SELECTION:C341([DocketFile:6]; | ;[DocketFile:6]HResults:11="IMP")
RELATE ONE SELECTION:C349([DocketFile:6];[IntakeFile:1])

CREATE SET:C116([IntakeFile:1];"CaseHrs")  //restrict to FILED cases???

INTERSECTION:C121("FiledCases";"CaseHrs";"Final")
USE SET:C118("Final")

$rec:=Records in selection:C76([IntakeFile:1])
FIRST RECORD:C50([IntakeFile:1])
$Hrs:=0
For ($i;1;$rec)
	$CaseLtr:=Substring:C12([IntakeFile:1]CaseNo:1;9;1)
	Case of 
		: ($CaseLtr="A")
			$Hrs:=$Hrs+8
		: ($CaseLtr="C")
			$Hrs:=$Hrs+3
		: ($CaseLtr="F")
			$Hrs:=$Hrs+6
		: ($CaseLtr="J")
			$Hrs:=$Hrs+4
		: ($CaseLtr="K")
			$Hrs:=$Hrs+3
		: ($CaseLtr="M")
			$Hrs:=$Hrs+8
		: ($CaseLtr="P")
			$Hrs:=$Hrs+3
		: ($CaseLtr="T")
			$Hrs:=$Hrs+2
		: ($CaseLtr="V")
			$Hrs:=$Hrs+3
		: ($CaseLtr="L")
			$Hrs:=$Hrs+7
		: ($CaseLtr="S")
			$Hrs:=$Hrs+4
		: ($CaseLtr="N")
			$Hrs:=$Hrs+4
		Else 
			BEEP:C151
			ALERT:C41("Unexpected Case Suffix--"+$CaseLtr+".")
	End case 
	
	NEXT RECORD:C51([IntakeFile:1])
End for 

SR_RecDumpLog ("Write";0;$YearMonth;$Filed;$CaseType;"13")

$0:=$Hrs
