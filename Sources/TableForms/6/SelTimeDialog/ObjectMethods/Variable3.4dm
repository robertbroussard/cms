  //Script:bOK; Located in SelTimeDialog.
If (vSlotOK#1)
	ALERT:C41("You must choose a time slot or click  Cancel!")
Else 
	vSchOK:=1
	ACCEPT:C269
End if 