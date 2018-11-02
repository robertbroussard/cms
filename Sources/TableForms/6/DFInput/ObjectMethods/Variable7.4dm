  //Script: vDetails (OtherDetails button) in DFIinput Layout in EnterDocResults
  // Form:  [DF] DFInput
  //
_O_C_INTEGER:C282($i)
_O_C_STRING:C293(9;$DFCaseNo)
If (vSaveDocRec=True:C214)
	SAVE RECORD:C53([DocketFile:6])
	vSaveDocRec:=False:C215
End if 
SET WINDOW TITLE:C213("Other Details Screen")
$DFCaseNo:=[DocketFile:6]DFCaseNo:4
CREATE SET:C116([DocketFile:6];"TempSet")
RELATE MANY:C262([IntakeFile:1]CaseNo:1)
FORM SET INPUT:C55([Details:18];"DetailsIn")
If (Records in selection:C76([Details:18])=0)
	CREATE RECORD:C68([Details:18])
	[Details:18]CSR_CaseNo:1:=[IntakeFile:1]CaseNo:1
	SAVE RECORD:C53([Details:18])
	MODIFY RECORD:C57([Details:18])
	If (OK#1)
		DELETE RECORD:C58([Details:18])
		vDetails2:="Do not exist"
	Else 
		vDetails2:="Exist"
	End if 
Else 
	MODIFY RECORD:C57([Details:18])
	If ((OK#1) & (Records in selection:C76([Details:18])=0))
		vDetails2:="Do not exist"
	End if 
End if 
USE SET:C118("TempSet")
CLEAR SET:C117("TempSet")
ORDER BY:C49([DocketFile:6];[DocketFile:6]TimeSlot:3;[DocketFile:6]DFCaseNo:4;>)
FIRST RECORD:C50([DocketFile:6])
For ($i;1;Records in selection:C76([DocketFile:6]))
	If ([DocketFile:6]DFCaseNo:4=$DFCaseNo)
		$i:=Records in selection:C76([DocketFile:6])
	Else 
		NEXT RECORD:C51([DocketFile:6])
	End if 
End for 
SET WINDOW TITLE:C213("DRC Case Management System")