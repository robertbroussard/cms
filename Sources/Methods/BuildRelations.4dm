//%attributes = {"publishedWeb":true}
  //G-Proc: BuildRelations
  //
C_TEXT:C284($Relation)
C_LONGINT:C283($i;$Find;$Insert;$RIS)
ARRAY TEXT:C222(aRelation;0)
ARRAY REAL:C219(aRTotals;0;2)
$RIS:=Records in selection:C76([IntakeFile:1])
FIRST RECORD:C50([IntakeFile:1])
For ($i;1;Records in selection:C76([IntakeFile:1]))
	RELATE ONE:C42([IntakeFile:1]ifRelCode:17)
	$Relation:=[RelCodeFile:5]RelName:2
	$Find:=Find in array:C230(aRelation;$Relation)
	If ($Find=-1)
		$Insert:=Size of array:C274(aRelation)+1
		INSERT IN ARRAY:C227(aRelation;$Insert)
		INSERT IN ARRAY:C227(aRTotals;$Insert)
		aRelation{$Insert}:=$Relation
		aRTotals{$Insert}{1}:=aRTotals{$Insert}{1}+1
	Else 
		aRTotals{$Find}{1}:=aRTotals{$Find}{1}+1
	End if 
	NEXT RECORD:C51([IntakeFile:1])
End for 
For ($i;1;Size of array:C274(aRTotals))
	aRTotals{$i}{2}:=Trunc:C95((aRTotals{$i}{1}/$RIS)*100;2)
End for 