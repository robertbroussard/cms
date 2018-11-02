//%attributes = {"publishedWeb":true}
  //Intake Search
SET WINDOW TITLE:C213("DRC Case Management System")
vNewIntake:=False:C215
vSwitch:=0
FORM SET INPUT:C55([DocketFile:6];"DFInput")
FORM SET OUTPUT:C54([DocketFile:6];"DocResults")
QUERY:C277([DocketFile:6])
If (Records in selection:C76([DocketFile:6])>1)
	MODIFY SELECTION:C204([DocketFile:6];*)
Else 
	If (Records in selection:C76([DocketFile:6])=1)
		MODIFY RECORD:C57([DocketFile:6];*)
	End if 
End if 