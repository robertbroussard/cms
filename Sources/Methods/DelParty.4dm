//%attributes = {"publishedWeb":true}
  //G-Procedure:DelParty; This procedure is called from the Delete Party button
  //in the IntInput Layout or the delete button in the CInputAP1 layout. It will 
  //confirm that the  user wants to delete the "persons name"  that has been
  //selected and then delete the selected record and update the AddPartyFlag.
  //
_O_C_STRING:C293(60;$String1;$String2)
If (_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21)#0)
	If ([IntakeFile]AddPartyFile'LastName#"")
		CONFIRM:C162("Are you sure you want to delete "+[IntakeFile]AddPartyFile'FirstName+" "+[IntakeFile]AddPartyFile'LastName+" from this case?")
		If (OK=1)
			_O_DELETE SUBRECORD:C96([IntakeFile:1]AddPartyFile:21)
			SAVE RECORD:C53([IntakeFile:1])
			_O_ALL SUBRECORDS:C109([IntakeFile:1]AddPartyFile:21)
			If (_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21)=0)
				[IntakeFile:1]AddPartyFlag:20:=False:C215
			End if 
		End if 
	Else 
		$String1:="You must click on the additional party you want to delete, "
		$String2:="and then click the 'Del' button to delete the party."
		ALERT:C41($String1+$String2)
	End if 
Else 
	_O_ALL SUBRECORDS:C109([IntakeFile:1]AddPartyFile:21)
	If (_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21)=0)
		ALERT:C41("There are no additional parties to delete.")
	End if 
End if 