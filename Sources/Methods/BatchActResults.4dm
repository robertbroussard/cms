//%attributes = {"publishedWeb":true}
  //G-Proc: BatchActResults
C_LONGINT:C283($i;$j)
ALL RECORDS:C47([DocketFile:6])
FIRST RECORD:C50([DocketFile:6])
For ($i;1;Records in selection:C76([DocketFile:6]))
	RELATE MANY:C262([DocketFile:6]DocKey:6)
	If (Records in selection:C76([MedActFile:10])>0)
		FIRST RECORD:C50([MedActFile:10])
		For ($j;1;Records in selection:C76([MedActFile:10]))
			[MedActFile:10]ActResults:8:=[DocketFile:6]HResults:11
			SAVE RECORD:C53([MedActFile:10])
			NEXT RECORD:C51([MedActFile:10])
		End for 
	End if 
	NEXT RECORD:C51([DocketFile:6])
End for 