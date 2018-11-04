//%attributes = {"publishedWeb":true}
  //G-Proc: BuildPrograms
C_TEXT:C284($TempProg)
C_LONGINT:C283($i;$Find;$Insert;$RIS)
ARRAY TEXT:C222(aProgram;0)
ARRAY REAL:C219(aPTotals;0;2)
$RIS:=Records in selection:C76([IntakeFile:1])
FIRST RECORD:C50([IntakeFile:1])
For ($i;1;Records in selection:C76([IntakeFile:1]))
	If (Size of array:C274(aProgram)>0)
		$TempProg:=[IntakeFile:1]Program:32
		$Find:=Find in array:C230(aProgram;$TempProg)
		If ($Find=-1)
			$Insert:=Size of array:C274(aProgram)+1
			INSERT IN ARRAY:C227(aProgram;$Insert)
			INSERT IN ARRAY:C227(aPTotals;$Insert)
			aProgram{$Insert}:=$TempProg
			aPTotals{$Insert}{1}:=aPTotals{$Insert}{1}+1
		Else 
			aPTotals{$Find}{1}:=aPTotals{$Find}{1}+1
		End if 
	Else 
		$Insert:=Size of array:C274(aProgram)+1
		INSERT IN ARRAY:C227(aProgram;$Insert)
		INSERT IN ARRAY:C227(aPTotals;$Insert)
		aProgram{$Insert}:=[IntakeFile:1]Program:32
		aPTotals{$Insert}{1}:=aPTotals{$Insert}{1}+1
	End if 
	NEXT RECORD:C51([IntakeFile:1])
End for 
For ($i;1;Size of array:C274(aPTotals))
	aPTotals{$i}{2}:=Trunc:C95((aPTotals{$i}{1}/$RIS)*100;2)
End for 