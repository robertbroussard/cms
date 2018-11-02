//%attributes = {"publishedWeb":true}
  //G-Proc: BuildDisputes
_O_C_INTEGER:C282($i;$Find;$Insert;$RIS)
_O_C_STRING:C293(40;$Dispute)
_O_ARRAY STRING:C218(40;aDispute;0)
ARRAY REAL:C219(aDTotals;0;2)
$RIS:=Records in selection:C76([IntakeFile:1])
FIRST RECORD:C50([IntakeFile:1])
For ($i;1;Records in selection:C76([IntakeFile:1]))
	RELATE ONE:C42([IntakeFile:1]DisputeCode:22)
	$Dispute:=[DisputeFile:4]DisName:2
	$Find:=Find in array:C230(aDispute;$Dispute)
	If ($Find=-1)
		$Insert:=Size of array:C274(aDispute)+1
		INSERT IN ARRAY:C227(aDispute;$Insert)
		INSERT IN ARRAY:C227(aDTotals;$Insert)
		aDispute{$Insert}:=$Dispute
		aDTotals{$Insert}{1}:=aDTotals{$Insert}{1}+1
	Else 
		aDTotals{$Find}{1}:=aDTotals{$Find}{1}+1
	End if 
	NEXT RECORD:C51([IntakeFile:1])
End for 
For ($i;1;Size of array:C274(aDTotals))
	aDTotals{$i}{2}:=Trunc:C95((aDTotals{$i}{1}/$RIS)*100;2)
End for 