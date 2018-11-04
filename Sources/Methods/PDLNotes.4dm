//%attributes = {"publishedWeb":true}
  //G-Proc: PDLNotes;
C_LONGINT:C283($i;$Find;$Insert)
C_TEXT:C284($TempNo)
C_TEXT:C284($1)
ARRAY TEXT:C222(aCaseNo;0)
ALL RECORDS:C47([DailyLtrFile:14])
FIRST RECORD:C50([DailyLtrFile:14])
For ($i;1;Records in selection:C76([DailyLtrFile:14]))
	If (Size of array:C274(aCaseNo)>0)
		$TempNo:=[DailyLtrFile:14]DLFCaseNo:1
		$Find:=Find in array:C230(aCaseNo;$TempNo)
		If ($Find=-1)
			$Insert:=Size of array:C274(aCaseNo)+1
			INSERT IN ARRAY:C227(aCaseNo;$Insert)
			aCaseNo{$Insert}:=[DailyLtrFile:14]DLFCaseNo:1
		End if 
	Else 
		$Insert:=Size of array:C274(aCaseNo)+1
		INSERT IN ARRAY:C227(aCaseNo;$Insert)
		aCaseNo{$Insert}:=[DailyLtrFile:14]DLFCaseNo:1
	End if 
	NEXT RECORD:C51([DailyLtrFile:14])
End for 
For ($i;1;Size of array:C274(aCaseNo))
	QUERY:C277([IntakeFile:1];[IntakeFile:1]CaseNo:1=aCaseNo{$i})
	If (Records in selection:C76([IntakeFile:1])=1)
		EnterNotesText ("P";$1)
	End if 
End for 
CLEAR VARIABLE:C89(aCaseNo)