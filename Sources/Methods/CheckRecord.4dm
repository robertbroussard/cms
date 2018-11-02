//%attributes = {"publishedWeb":true}
  //G-Procedure:CheckRecord
$0:=True:C214
Case of 
	: ([DailyLtrFile:14]DLFCaseNo:1="")
		$0:=False:C215
	: ([DailyLtrFile:14]PStAddress:14="")
		$0:=False:C215
	: ([DailyLtrFile:14]PCity:15="")
		$0:=False:C215
	: ([DailyLtrFile:14]PState:16="")
		$0:=False:C215
	: ([DailyLtrFile:14]PZip:17="")
		$0:=False:C215
End case 