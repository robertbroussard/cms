//%attributes = {"publishedWeb":true}
  //G-Proc: BuildRelations
C_TEXT:C284($OutRef)
C_LONGINT:C283($i;$j;$Find;$Insert;$RIS)
ARRAY TEXT:C222(aOutRef;0)
ARRAY REAL:C219(aORTotals;0;2)
$RIS:=Records in selection:C76([IntakeFile:1])
FIRST RECORD:C50([IntakeFile:1])
For ($i;1;Records in selection:C76([IntakeFile:1]))
	_O_FIRST SUBRECORD:C61([IntakeFile:1]Referrals:26)
	For ($j;1;_O_Records in subselection:C7([IntakeFile:1]Referrals:26))
		If (Size of array:C274(aOutRef)>0)
			$OutRef:=[IntakeFile]Referrals'Referral
			$Find:=Find in array:C230(aOutRef;$OutRef)
			If ($Find=-1)
				$Insert:=Size of array:C274(aOutRef)+1
				INSERT IN ARRAY:C227(aOutRef;$Insert)
				INSERT IN ARRAY:C227(aORTotals;$Insert)
				aOutRef{$Insert}:=$OutRef
				aORTotals{$Insert}{1}:=aORTotals{$Insert}{1}+1
			Else 
				aORTotals{$Find}{1}:=aORTotals{$Find}{1}+1
			End if 
		Else 
			$Insert:=Size of array:C274(aOutRef)+1
			INSERT IN ARRAY:C227(aOutRef;$Insert)
			INSERT IN ARRAY:C227(aORTotals;$Insert)
			aOutRef{$Insert}:=[IntakeFile]Referrals'Referral
			aORTotals{$Insert}{1}:=aORTotals{$Insert}{1}+1
		End if 
		_O_NEXT SUBRECORD:C62([IntakeFile:1]Referrals:26)
	End for 
	NEXT RECORD:C51([IntakeFile:1])
End for 
For ($i;1;Size of array:C274(aORTotals))
	aORTotals{$i}{2}:=Trunc:C95((aORTotals{$i}{1}/$RIS)*100;2)
End for 