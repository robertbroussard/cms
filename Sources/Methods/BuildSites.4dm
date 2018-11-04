//%attributes = {"publishedWeb":true}
  //G-Proc: BuildSites
ARRAY TEXT:C222(aSite;0)
ARRAY REAL:C219(aSTotals;0;2)
C_TEXT:C284($Site)
C_LONGINT:C283($i;$Find;$Insert;$RIS)
$RIS:=Records in selection:C76([IntakeFile:1])
FIRST RECORD:C50([IntakeFile:1])
For ($i;1;Records in selection:C76([IntakeFile:1]))
	If (Size of array:C274(aSite)>0)
		RELATE ONE:C42([IntakeFile:1]LocCode:2)
		$Site:=[LocationFile:2]LTLocName:2
		$Find:=Find in array:C230(aSite;$Site)
		If ($Find=-1)
			$Insert:=Size of array:C274(aSite)+1
			INSERT IN ARRAY:C227(aSite;$Insert)
			INSERT IN ARRAY:C227(aSTotals;$Insert)
			aSite{$Insert}:=$Site
			aSTotals{$Insert}{1}:=aSTotals{$Insert}{1}+1
		Else 
			aSTotals{$Find}{1}:=aSTotals{$Find}{1}+1
		End if 
	Else 
		$Insert:=Size of array:C274(aSite)+1
		INSERT IN ARRAY:C227(aSite;$Insert)
		INSERT IN ARRAY:C227(aSTotals;$Insert)
		aSite{$Insert}:=[LocationFile:2]LTLocName:2
		aSTotals{$Insert}{1}:=aSTotals{$Insert}{1}+1
	End if 
	NEXT RECORD:C51([IntakeFile:1])
End for 
For ($i;1;Size of array:C274(aSTotals))
	aSTotals{$i}{2}:=Trunc:C95((aSTotals{$i}{1}/$RIS)*100;2)
End for 