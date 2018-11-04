//%attributes = {"publishedWeb":true}
  //G-Procedure: BatchDocKey
C_LONGINT:C283($i)
ALL RECORDS:C47([DocketFile:6])
For ($i;1;Records in selection:C76([DocketFile:6]))
	[DocketFile:6]DocKey:6:=[DocketFile:6]DocketSite:1+String:C10([DocketFile:6]DocketDate:2)+[DocketFile:6]DFCaseNo:4
	SAVE RECORD:C53([DocketFile:6])
	NEXT RECORD:C51([DocketFile:6])
End for 