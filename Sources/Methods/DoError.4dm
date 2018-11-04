//%attributes = {"publishedWeb":true}
  //G-Proc: DoError;
C_LONGINT:C283($1)
C_TEXT:C284($2;$3)
CREATE RECORD:C68([LtrRptFile:16])
[LtrRptFile:16]ReqInitials:4:=$2
[LtrRptFile:16]PrintInitials:11:=$3
[LtrRptFile:16]PrintStatus:6:=False:C215
[LtrRptFile:16]DatePrinted:8:=Current date:C33
[LtrRptFile:16]TimePrinted:9:=Current time:C178
Case of 
	: ($1=1)  //Called from the "If" under "bDefault" in DefaultLtrs.
		[LtrRptFile:16]LtrCaseNo:1:=[IntakeFile:1]CaseNo:1
		[LtrRptFile:16]PartyType:2:="All"
		[LtrRptFile:16]PartyName:3:="All Parties"
		[LtrRptFile:16]LtrName:5:="Unknown"
		[LtrRptFile:16]Reason:7:="Improper Results"
		[LtrRptFile:16]Envelope:12:=False:C215
		[LtrRptFile:16]Batch_Or_Other:10:=False:C215
	: ($1=2)  //Called from the "If" under "bBALtr" in DefaultLtrs.
		[LtrRptFile:16]LtrCaseNo:1:=[IntakeFile:1]CaseNo:1
		[LtrRptFile:16]PartyType:2:="???"
		[LtrRptFile:16]PartyName:3:="Unknown"
		[LtrRptFile:16]LtrName:5:="BA Letter"
		[LtrRptFile:16]Reason:7:="Not Settled"
		[LtrRptFile:16]Envelope:12:=False:C215
		[LtrRptFile:16]Batch_Or_Other:10:=False:C215
	: ($1=3)  //Called from "PrintNow" in check record section.
		[LtrRptFile:16]LtrCaseNo:1:=[DailyLtrFile:14]DLFCaseNo:1
		[LtrRptFile:16]PartyType:2:=[DailyLtrFile:14]PartyType:5
		[LtrRptFile:16]PartyName:3:=[DailyLtrFile:14]FName:4+[DailyLtrFile:14]LName:3
		[LtrRptFile:16]LtrName:5:=[DailyLtrFile:14]LtrType:2
		[LtrRptFile:16]Reason:7:="Improper Address"
		[LtrRptFile:16]Envelope:12:=False:C215
		[LtrRptFile:16]Batch_Or_Other:10:=False:C215
	: ($1=4)  //Called from "PrintDailyLtr" in check record section.
		[LtrRptFile:16]LtrCaseNo:1:=[DailyLtrFile:14]DLFCaseNo:1
		[LtrRptFile:16]PartyType:2:=[DailyLtrFile:14]PartyType:5
		[LtrRptFile:16]PartyName:3:=[DailyLtrFile:14]FName:4+[DailyLtrFile:14]LName:3
		[LtrRptFile:16]LtrName:5:=[DailyLtrFile:14]LtrType:2
		[LtrRptFile:16]Reason:7:="Improper Address"
		[LtrRptFile:16]Envelope:12:=False:C215
		[LtrRptFile:16]Batch_Or_Other:10:=True:C214
	: ($1=5)  //Called from "PrintNow" last check section.
		[LtrRptFile:16]LtrCaseNo:1:=[DailyLtrFile:14]DLFCaseNo:1
		[LtrRptFile:16]PartyType:2:=[DailyLtrFile:14]PartyType:5
		[LtrRptFile:16]PartyName:3:=[DailyLtrFile:14]FName:4+[DailyLtrFile:14]LName:3
		[LtrRptFile:16]LtrName:5:=[DailyLtrFile:14]LtrType:2
		[LtrRptFile:16]Reason:7:="Printing Canceled"
		[LtrRptFile:16]Envelope:12:=False:C215
		[LtrRptFile:16]Batch_Or_Other:10:=False:C215
	: ($1=6)  //Called from "PrintDailyLtr" last check section.
		[LtrRptFile:16]LtrCaseNo:1:=[DailyLtrFile:14]DLFCaseNo:1
		[LtrRptFile:16]PartyType:2:=[DailyLtrFile:14]PartyType:5
		[LtrRptFile:16]PartyName:3:=[DailyLtrFile:14]FName:4+[DailyLtrFile:14]LName:3
		[LtrRptFile:16]LtrName:5:=[DailyLtrFile:14]LtrType:2
		[LtrRptFile:16]Reason:7:="Printing Canceled"
		[LtrRptFile:16]Envelope:12:=False:C215
		[LtrRptFile:16]Batch_Or_Other:10:=True:C214
		[LtrRptFile:16]ReqInitials:4:=[DailyLtrFile:14]Initials:6
End case 
SAVE RECORD:C53([LtrRptFile:16])
UNLOAD RECORD:C212([LtrRptFile:16])