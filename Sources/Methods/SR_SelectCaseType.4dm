//%attributes = {}
  //SR_SelectCaseType
  //11/15/06
  //Assume that there is a current selection for [IntakeFile] and that we need to reduce the selection
  //to include only the given CaseType.
  //$1-> Case Type

C_BOOLEAN:C305($StdAction)
$StdAction:=True:C214

$CaseType:=$1
$Filed:=$2

ARRAY TEXT:C222($aDisputeCode;0)

If (Length:C16($CaseType)#0)
	
	Case of 
		: ($CaseType="A")
			ARRAY TEXT:C222($aDisputeCode;3)
			$aDisputeCode{1}:="130"
			$aDisputeCode{2}:="155"
			$aDisputeCode{3}:="156"
			
		: ($CaseType="B")
			ARRAY TEXT:C222($aDisputeCode;5)
			$aDisputeCode{1}:="101"
			$aDisputeCode{2}:="129"
			$aDisputeCode{3}:="137"
			$aDisputeCode{4}:="147"
			$aDisputeCode{5}:="148"
			
		: ($CaseType="C")
			ARRAY TEXT:C222($aDisputeCode;1)
			$aDisputeCode{1}:="157"
			
		: ($CaseType="D")
			ARRAY TEXT:C222($aDisputeCode;1)
			$aDisputeCode{1}:="144"
			
		: ($CaseType="E")  //Forced to Zero -- no such cases.
			$StdAction:=False:C215
			REDUCE SELECTION:C351([IntakeFile:1];0)
			
		: ($CaseType="F")
			ARRAY TEXT:C222($aDisputeCode;11)
			$aDisputeCode{1}:="103"
			$aDisputeCode{2}:="105"
			$aDisputeCode{3}:="107"
			$aDisputeCode{4}:="117"
			$aDisputeCode{5}:="120"
			$aDisputeCode{6}:="133"
			$aDisputeCode{7}:="134"
			$aDisputeCode{8}:="136"
			$aDisputeCode{9}:="140"
			$aDisputeCode{10}:="142"
			$aDisputeCode{11}:="153"
			
		: ($CaseType="G")  //Reciprocal Cases--Those whose RefByvalues do not match list values.
			$StdAction:=False:C215
			LIST TO ARRAY:C288("Referrals";$aRefBy)
			QUERY WITH ARRAY:C644([IntakeFile:1]RefBy:16;$aRefBy)
			CREATE SET:C116([IntakeFile:1];"RefBy")
			ALL RECORDS:C47([IntakeFile:1])
			CREATE SET:C116([IntakeFile:1];"AllRecs")
			DIFFERENCE:C122("AllRecs";"RefBy";"RecipCases")
			USE SET:C118("RecipCases")
		: ($CaseType="H")
			ARRAY TEXT:C222($aDisputeCode;3)
			$aDisputeCode{1}:="108"
			$aDisputeCode{2}:="149"
			$aDisputeCode{3}:="150"
			
		: ($CaseType="I")
			ARRAY TEXT:C222($aDisputeCode;2)
			$aDisputeCode{1}:="151"
			$aDisputeCode{2}:="154"
			  //PLUS Case Numbers that end in "K" the 9th Character.
			
		: ($CaseType="J")
			$StdAction:=False:C215
			REDUCE SELECTION:C351([IntakeFile:1];0)
		: ($CaseType="K")
			$StdAction:=False:C215
			QUERY:C277([IntakeFile:1];[IntakeFile:1]CaseNo:1="@J")
		: ($CaseType="L")
			$StdAction:=False:C215
			ARRAY TEXT:C222($aProb;0)
			ARRAY TEXT:C222($aProb;6)
			$aProb{1}:=" Prob 1"
			$aProb{2}:="Prob 1138"
			$aProb{3}:="Prob 2"
			$aProb{4}:="Prob 3"
			$aProb{5}:="Prob 4"
			$aProb{6}:="Probate"
			QUERY WITH ARRAY:C644([IntakeFile:1]RefBy:16;$aProb)
		: ($CaseType="M")
			$StdAction:=False:C215
			QUERY:C277([IntakeFile:1];[IntakeFile:1]CaseNo:1="@V")
		: ($CaseType="T")
			
	End case 
	
	$size:=Size of array:C274($aDisputeCode)
	If ($size>0)
		If ($StdAction)
			QUERY WITH ARRAY:C644([IntakeFile:1]DisputeCode:22;$aDisputeCode)
		End if 
	End if 
Else 
	BEEP:C151
	ALERT:C41("Invalid CaseType passed to 'SR_SelectCaseType'.")
End if 

CREATE SET:C116([IntakeFile:1];"CaseType")
INTERSECTION:C121("Final";"CaseType";"Final")
