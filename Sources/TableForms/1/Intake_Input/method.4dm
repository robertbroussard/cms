Case of 
	: (Form event:C388=On Load:K2:1)
		  //added to set selection of Additional parties for new listbox object.
		QUERY:C277([IntakeFile_AddPartyFile:23];[IntakeFile_AddPartyFile:23]id_added_by_converter:19=Get subrecord key:C1137([IntakeFile:1]AddPartyFile:21))
	: (Form event:C388=On Page Change:K2:54)
		If (FORM Get current page:C276=3)
			CreateFamilyRecord 
		End if 
End case 
