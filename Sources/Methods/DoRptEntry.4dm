//%attributes = {"publishedWeb":true}
  //G-Proc: DoRptEntry
  //
C_TEXT:C284($1)
C_TEXT:C284($2)  //rt error 5/21/08... rjb.
CREATE RECORD:C68([LtrRptFile:16])
[LtrRptFile:16]LtrCaseNo:1:=[DailyLtrFile:14]DLFCaseNo:1
[LtrRptFile:16]ReqInitials:4:=[DailyLtrFile:14]Initials:6
[LtrRptFile:16]PrintStatus:6:=True:C214
[LtrRptFile:16]DatePrinted:8:=Current date:C33
[LtrRptFile:16]TimePrinted:9:=Current time:C178
Case of 
	: ($1="B")
		[LtrRptFile:16]Batch_Or_Other:10:=True:C214
	: ($1="O")
		[LtrRptFile:16]Batch_Or_Other:10:=False:C215
End case 
[LtrRptFile:16]PrintInitials:11:=$2
[LtrRptFile:16]PartyType:2:=[DailyLtrFile:14]PartyType:5
[LtrRptFile:16]PartyName:3:=[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3
[LtrRptFile:16]LtrName:5:=[DailyLtrFile:14]LtrType:2
[LtrRptFile:16]Reason:7:=""
[LtrRptFile:16]PartyType:2:=[DailyLtrFile:14]PartyType:5
[LtrRptFile:16]Envelope:12:=[DailyLtrFile:14]PrintEnv:21
SAVE RECORD:C53([LtrRptFile:16])
UNLOAD RECORD:C212([LtrRptFile:16])