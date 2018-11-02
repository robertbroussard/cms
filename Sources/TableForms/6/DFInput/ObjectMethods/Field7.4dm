  //Script: [DF]HResults; This script will go to DFReschedule if the
  // results = CONT or R/S       Form:  [DF] DFInput
  //
_O_C_INTEGER:C282($i)
_O_C_STRING:C293(9;$DFCaseNo)
vSchOK:=0
$DFCaseNo:=[DocketFile:6]DFCaseNo:4
Case of 
	: ([DocketFile:6]HResults:11="R/S")
		SAVE RECORD:C53([DocketFile:6])
		CREATE SET:C116([DocketFile:6];"RSSet")
		PUSH RECORD:C176([DocketFile:6])
		DFReschedule ([DocketFile:6]DFCaseNo:4;[DocketFile:6]DocketSite:1;[DocketFile:6]DocketDate:2)
		If (vSchOK=1)
			USE SET:C118("RSSet")
			CLEAR SET:C117("RSSet")
		Else 
			POP RECORD:C177([DocketFile:6])
			ONE RECORD SELECT:C189([DocketFile:6])
			[DocketFile:6]HResults:11:=""
			SAVE RECORD:C53([DocketFile:6])
			USE SET:C118("RSSet")
			CLEAR SET:C117("RSSet")
		End if 
		ORDER BY:C49([DocketFile:6];[DocketFile:6]TimeSlot:3;>;[DocketFile:6]DFCaseNo:4;>)
		vDate:=[DocketFile:6]DocketDate:2
		FIRST RECORD:C50([DocketFile:6])
		For ($i;1;Records in selection:C76([DocketFile:6]))
			If ([DocketFile:6]DFCaseNo:4=$DFCaseNo)
				$i:=Records in selection:C76([DocketFile:6])
			Else 
				NEXT RECORD:C51([DocketFile:6])
			End if 
		End for 
	: ([DocketFile:6]HResults:11="CONT")
		SAVE RECORD:C53([DocketFile:6])
		vSchOK:=0
		CREATE SET:C116([DocketFile:6];"RSSet")
		PUSH RECORD:C176([DocketFile:6])
		DFContinuation ([DocketFile:6]DFCaseNo:4;[DocketFile:6]DocketSite:1;[DocketFile:6]DocketDate:2)
		If (vSchOK=1)
			USE SET:C118("RSSet")
			CLEAR SET:C117("RSSet")
		Else 
			POP RECORD:C177([DocketFile:6])
			ONE RECORD SELECT:C189([DocketFile:6])
			[DocketFile:6]HResults:11:=""
			SAVE RECORD:C53([DocketFile:6])
			USE SET:C118("RSSet")
			CLEAR SET:C117("RSSet")
		End if 
		ORDER BY:C49([DocketFile:6];[DocketFile:6]TimeSlot:3;>;[DocketFile:6]DFCaseNo:4;>)
		vDate:=[DocketFile:6]DocketDate:2
		FIRST RECORD:C50([DocketFile:6])
		For ($i;1;Records in selection:C76([DocketFile:6]))
			If ([DocketFile:6]DFCaseNo:4=$DFCaseNo)
				$i:=Records in selection:C76([DocketFile:6])
			Else 
				NEXT RECORD:C51([DocketFile:6])
			End if 
		End for 
	Else 
		vSaveDocRec:=True:C214
End case 