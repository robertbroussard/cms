//%attributes = {"publishedWeb":true}
  //G-Proc: BuildResults
C_TEXT:C284($TempProg)
C_LONGINT:C283($i;$Find;$Insert)
ARRAY TEXT:C222(aProgram;0)
ARRAY INTEGER:C220(aTotals;0;14)
FIRST RECORD:C50([IntakeFile:1])
For ($i;1;Records in selection:C76([IntakeFile:1]))
	If (Size of array:C274(aProgram)>0)
		$TempProg:=[IntakeFile:1]Program:32
		$Find:=Find in array:C230(aProgram;$TempProg)
		If ($Find=-1)
			$Insert:=Size of array:C274(aProgram)+1
			INSERT IN ARRAY:C227(aProgram;$Insert)
			INSERT IN ARRAY:C227(aTotals;$Insert)
			aProgram{$Insert}:=$TempProg
			AddTotals ($Insert)
		Else 
			AddTotals ($Find)
		End if 
	Else 
		$Insert:=Size of array:C274(aProgram)+1
		INSERT IN ARRAY:C227(aProgram;$Insert)
		INSERT IN ARRAY:C227(aTotals;$Insert)
		aProgram{$Insert}:=[IntakeFile:1]Program:32
		AddTotals ($Insert)
	End if 
	NEXT RECORD:C51([IntakeFile:1])
End for 