  //Script: bDelMed
If ((Records in selection:C76([MedActFile:10])>=1) & ([MedActFile:10]mafKey:1=""))
	ALERT:C41("First select the mediator to be deleted and then click the 'Del Med' button.")
Else 
	If ((Records in selection:C76([MedActFile:10])>=1) & ([MedActFile:10]mafKey:1#""))
		CONFIRM:C162("Are you sure you want to delete "+[MedActFile:10]mafKey:1+" from this case?")
		If (OK=1)
			DELETE RECORD:C58([MedActFile:10])
		End if 
	Else 
		If (Records in selection:C76([MedActFile:10])=0)
			ALERT:C41("There are no mediators to delete.")
		End if 
	End if 
End if 
QUERY:C277([MedActFile:10];[MedActFile:10]mafCaseNo:3=[DocketFile:6]DFCaseNo:4;*)
QUERY:C277([MedActFile:10]; & ;[MedActFile:10]ActDate:5=[DocketFile:6]DocketDate:2)