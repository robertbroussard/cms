//%attributes = {"publishedWeb":true}
  //G-Proc: BuildStatus; Called from ISReport.
C_LONGINT:C283($RIS;$Insert;$i;$Find)
C_TEXT:C284($TempStatus)
$RIS:=Records in selection:C76([IntakeFile:1])
ARRAY TEXT:C222(aStatus;0)
ARRAY REAL:C219(aBSTotals;0;2)
FIRST RECORD:C50([IntakeFile:1])
For ($i;1;Records in selection:C76([IntakeFile:1]))
	If (Size of array:C274(aStatus)>0)
		$TempStatus:=[IntakeFile:1]CaseStatus:25
		$Find:=Find in array:C230(aStatus;$TempStatus)
		If ($Find=-1)
			$Insert:=Size of array:C274(aStatus)+1
			INSERT IN ARRAY:C227(aStatus;$Insert)
			INSERT IN ARRAY:C227(aBSTotals;$Insert)
			aStatus{$Insert}:=$TempStatus
			aBSTotals{$Insert}{1}:=aBSTotals{$Insert}{1}+1
		Else 
			aBSTotals{$Find}{1}:=aBSTotals{$Find}{1}+1
		End if 
	Else 
		$Insert:=Size of array:C274(aStatus)+1
		INSERT IN ARRAY:C227(aStatus;$Insert)
		INSERT IN ARRAY:C227(aBSTotals;$Insert)
		aStatus{$Insert}:=[IntakeFile:1]CaseStatus:25
		aBSTotals{$Insert}{1}:=aBSTotals{$Insert}{1}+1
	End if 
	NEXT RECORD:C51([IntakeFile:1])
End for 
For ($i;1;Size of array:C274(aBSTotals))
	aBSTotals{$i}{2}:=Trunc:C95((aBSTotals{$i}{1}/$RIS)*100;2)
End for 