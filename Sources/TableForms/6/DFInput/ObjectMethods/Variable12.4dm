  //Script: bEditMed
If ((Records in selection:C76([MedActFile:10])>=1) & ([MedActFile:10]mafKey:1=""))
	ALERT:C41("First select the mediator to be edited and then click the 'Edit Med' button.")
Else 
	If ((Records in selection:C76([MedActFile:10])>=1) & ([MedActFile:10]mafKey:1#""))
		FORM SET INPUT:C55([MedActFile:10];"MAFDocInput")
		MODIFY RECORD:C57([MedActFile:10];*)
	Else 
		If (Records in selection:C76([MedActFile:10])=0)
			ALERT:C41("There are no mediators to edit.")
		End if 
	End if 
End if 
REDRAW:C174([MediatorFile:9])