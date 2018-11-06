  //Script bmafOK; Located on MAFInput. This Script will check all the input
  //and set the fields in the MedActFile to their proper values.
If ([MediatorFile:9]MKey:14#"")
	If ([MedActFile:10]Role_Activity:4#"")
		SAVE RECORD:C53([MedActFile:10])
		ACCEPT:C269
	Else 
		ALERT:C41("You must enter the Role of the Mediator.")
	End if 
Else 
	ALERT:C41("You must enter a Mediator or choose Cancel.")
End if 