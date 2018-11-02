//%attributes = {"publishedWeb":true}
RELATE MANY:C262([IntakeFile:1]CaseNo:1)
_O_C_INTEGER:C282($i;$Find;$Insert;$Size)
_O_C_STRING:C293(1;$1)
  //C_STRING(2;$2)
C_TEXT:C284($TempInterim;$TempText)
$TempInterim:=""
$TempText:=""
_O_ARRAY STRING:C218(30;aLtrType;0)
FIRST RECORD:C50([DailyLtrFile:14])
For ($i;1;Records in selection:C76([DailyLtrFile:14]))
	If (Size of array:C274(aLtrType)>0)
		$Find:=Find in array:C230(aLtrType;[DailyLtrFile:14]LtrType:2)
		If ($Find=-1)
			$Insert:=(Size of array:C274(aLtrType)+1)
			INSERT IN ARRAY:C227(aLtrType;$Insert)
			aLtrType{$Insert}:=[DailyLtrFile:14]LtrType:2
		End if 
	Else 
		$Insert:=(Size of array:C274(aLtrType)+1)
		INSERT IN ARRAY:C227(aLtrType;$Insert)
		aLtrType{$Insert}:=[DailyLtrFile:14]LtrType:2
	End if 
	NEXT RECORD:C51([DailyLtrFile:14])
End for 
$Size:=Size of array:C274(aLtrType)
For ($i;1;$Size)
	Case of 
		: ($i=1)
			$TempText:=aLtrType{$i}
		: ($i<=($Size-1))
			$TempText:=$TempText+", "+aLtrType{$i}
		: ($i=$Size)
			$TempText:=$TempText+" and "+aLtrType{$i}
	End case 
End for 
Case of 
	: ($1="R")
		$TempInterim:=[IntakeFile:1]InterimCon:30+" {** "+$TempText+" letters requested on "+String:C10(Current date:C33;7)+" @ "+String:C10(Current time:C178;5)+" "+$2+" **}"
		[IntakeFile:1]InterimCon:30:=$TempInterim
		SAVE RECORD:C53([IntakeFile:1])
	: ($1="P")
		$TempInterim:=[IntakeFile:1]InterimCon:30+" {** "+$TempText+" letters printed on "+String:C10(Current date:C33;7)+" @ "+String:C10(Current time:C178;5)+" "+$2+" **}"
		[IntakeFile:1]InterimCon:30:=$TempInterim
		SAVE RECORD:C53([IntakeFile:1])
End case 
CLEAR VARIABLE:C89(aLtrType)