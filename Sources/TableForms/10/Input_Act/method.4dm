  // This Method is a Form Method attached to the MedActFile form
  // Input_Act
  //
If (Before:C29)
	$DisOnly:=False:C215
	Case of 
		: ([MedActFile:10]Role_Activity:4="Co-mediator")
			$DisOnly:=True:C214
		: ([MedActFile:10]Role_Activity:4="Mediator")
			$DisOnly:=True:C214
		: ([MedActFile:10]Role_Activity:4="Observer")
			$DisOnly:=True:C214
		: ([MedActFile:10]Role_Activity:4="Ventilation")
			$DisOnly:=True:C214
	End case 
	If ($DisOnly=False:C215)
		OBJECT SET ENTERABLE:C238([MedActFile:10]mafKey:1;True:C214)
		OBJECT SET ENTERABLE:C238([MedActFile:10]Role_Activity:4;True:C214)
		OBJECT SET ENTERABLE:C238([MedActFile:10]ActDate:5;True:C214)
		OBJECT SET ENTERABLE:C238([MedActFile:10]AmtOfTime:6;True:C214)
	End if 
End if 