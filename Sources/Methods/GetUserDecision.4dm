//%attributes = {"publishedWeb":true}
  //G-Procedure:GetUserDecision
Open window:C153(78;40;433;350;1)
DIALOG:C40([DocketFile:6];"GRDDialog")
CLOSE WINDOW:C154
Case of 
	: (bStartOver=1)
		$0:=!00-00-00!
		vSCLoop1:=1
		vDayOK:=True:C214
		vAdvanced:=False:C215
	: (bEnterDate=1)
		$0:=Date:C102(Request:C163("Enter Date";String:C10((Current date:C33+1);7)))
	: (bAdvance=1)
		$0:=$1+1
	: (bQuit=1)
		$0:=!00-00-00!
		vDayOK:=True:C214
		vAdvanced:=False:C215
End case 