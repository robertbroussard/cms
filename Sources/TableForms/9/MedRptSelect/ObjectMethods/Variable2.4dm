  //Script: Option1;
C_TEXT:C284($Request)
vOption1:=1
vOption2:=0
vOption3:=0
vText1:="Select Mediator:"
ALL RECORDS:C47([MediatorFile:9])
$Request:=Request:C163("Enter Mediators Last Initial: ")
If ($Request#"")
	$Request:=$Request+"@"
	QUERY:C277([MediatorFile:9];[MediatorFile:9]MKey:14=$Request)
	If (Records in selection:C76([MediatorFile:9])>0)
		SELECTION TO ARRAY:C260([MediatorFile:9]MKey:14;aSMed)
		SORT ARRAY:C229(aSMed;>)
		COPY ARRAY:C226(aSMed;aDisplay)
	Else 
		ALERT:C41("No mediators found matching last initial.")
	End if 
Else 
	ALERT:C41("You must enter the last initial, or choose Cancel.")
End if 