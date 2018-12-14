Case of 
	: (Form event:C388=On Load:K2:1)
		
		If ((Is new record:C668(Current form table:C627->)) & ([IntakeFile:1]CaseNo:1=""))
			  //NewIntake 
			  //DELETE RECORD([IntakeFile])
			CANCEL:C270
			
		Else 
			  //added to set selection of Additional parties for new listbox object.
			QUERY:C277([IntakeFile_AddPartyFile:23];[IntakeFile_AddPartyFile:23]id_added_by_converter:19=Get subrecord key:C1137([IntakeFile:1]AddPartyFile:21))
			SetButtons 
			
		End if 
		
		SET WINDOW TITLE:C213("CMS: Intake Input")
		  //If ([IntakeFile]Program)="F"
		  //ENABLE BUTTON(bFamily)
		  //ENABLE BUTTON(bFamily2)
		  //ENABLE BUTTON(bFamily3)
		  //Else 
		  //DISABLE BUTTON(bFamily)
		  //DISABLE BUTTON(bFamily2)
		  //DISABLE BUTTON(bFamily3)
		  //End if 
		
		If (Current user:C182="Administrator") | (Current user:C182="Designer")
			OBJECT SET VISIBLE:C603(bDelete;True:C214)
		Else 
			OBJECT SET VISIBLE:C603(bDelete;False:C215)
		End if 
		
	: (Form event:C388=On Page Change:K2:54)
		If (FORM Get current page:C276=3)
			CreateFamilyRecord 
		End if 
End case 
