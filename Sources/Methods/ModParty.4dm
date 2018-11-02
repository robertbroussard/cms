//%attributes = {"publishedWeb":true}
  //G-Procedure: ModParty; This procedure is called from the 'Edit' button
  //in the IntInput layout. The procedure informs the user that they need to
  //click on the subrecord that they want to modify and then they can proceed. 
  //
_O_C_STRING:C293(60;$String1;$String2)
If (_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21)#0)
	If ([IntakeFile]AddPartyFile'FirstName+" "+[IntakeFile]AddPartyFile'LastName#" ")
		If ([IntakeFile:1]Program:32="L") | ([IntakeFile:1]Program:32="M") | ([IntakeFile:1]Program:32="A")
			_O_MODIFY SUBRECORD:C203([IntakeFile:1]AddPartyFile:21;"APInputLit";*)
		Else 
			_O_MODIFY SUBRECORD:C203([IntakeFile:1]AddPartyFile:21;"CInputAP1";*)
		End if 
		If (OK=1)
			SAVE RECORD:C53([IntakeFile:1])
		End if 
	Else 
		$String1:="Click on the additional party that you want to modify. "
		$String2:="Then you edit the record that appears on the screen."
		ALERT:C41($String1+$String2)
	End if 
Else 
	ALERT:C41("There are no Additional Parties to Edit.")
End if 
_O_ALL SUBRECORDS:C109([IntakeFile:1]AddPartyFile:21)
If (_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21)=0)
	[IntakeFile:1]AddPartyFlag:20:=False:C215
End if 