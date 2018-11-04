//%attributes = {"publishedWeb":true}
  //G-Procedure:BuildRefBy

  //

C_TEXT:C284($TempRef)
C_LONGINT:C283($i;$Find;$Insert;$RIS)
ARRAY TEXT:C222(aRefBy;0)
ARRAY INTEGER:C220(aRefByNum;0)
FIRST RECORD:C50([IntakeFile:1])
$RIS:=Records in selection:C76([IntakeFile:1])
For ($i;1;Records in selection:C76([IntakeFile:1]))
	If (Size of array:C274(aRefBy)>0)
		$TempRef:=[IntakeFile:1]RefBy:16
		$Find:=Find in array:C230(aRefBy;$TempRef)
		If ($Find=-1)
			$Insert:=Size of array:C274(aRefBy)+1
			INSERT IN ARRAY:C227(aRefBy;$Insert)
			INSERT IN ARRAY:C227(aRefByNum;$Insert)
			aRefBy{$Insert}:=[IntakeFile:1]RefBy:16
			aRefByNum{$Insert}:=aRefByNum{$Insert}+1
		Else 
			aRefByNum{$Find}:=aRefByNum{$Find}+1
		End if 
	Else 
		INSERT IN ARRAY:C227(aRefBy;$i)
		INSERT IN ARRAY:C227(aRefByNum;$i)
		aRefBy{$i}:=[IntakeFile:1]RefBy:16
		aRefByNum{$i}:=aRefByNum{$i}+1
		
	End if 
	NEXT RECORD:C51([IntakeFile:1])
End for 
ARRAY REAL:C219(aRefByPer;Size of array:C274(aRefBy))
For ($i;1;Size of array:C274(aRefBy))
	aRefByPer{$i}:=Trunc:C95((aRefByNum{$i}/$RIS)*100;2)
End for 
SORT ARRAY:C229(aRefby;aRefByNum;aRefByPer;>)