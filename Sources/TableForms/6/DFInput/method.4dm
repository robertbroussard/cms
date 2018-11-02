  //This method is a Form Method attached to the Docket File form DFInput
  //
If (Before:C29)
	RELATE MANY:C262([Details:18])
	If (Records in selection:C76([Details:18])>0)
		vDetails2:="Exist"
	Else 
		vDetails2:="Do not exist"
	End if 
	vSaveDocRec:=False:C215
End if 
If (Before:C29)
	If ([DocketFile:6]DFCaseNo:4[[9]]="M")  //PUT  MODERATOR-ADMIN FIRST
		RELATE MANY:C262([DocketFile:6]DocKey:6)
		FIRST RECORD:C50([MedActFile:10])
		If ([MedActFile:10]Role_Activity:4#"Moderator-Admin")
			ORDER BY:C49([MedActFile:10];[MedActFile:10]Role_Activity:4;<)
		End if 
	End if 
End if 
