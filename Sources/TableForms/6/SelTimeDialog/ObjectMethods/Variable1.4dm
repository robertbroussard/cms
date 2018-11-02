  //Script:aSelTime;
If (aSelTime{aSelTime}#"")
	vSchTime:=aSelTime{aSelTime}
	vSlotOK:=1
Else 
	ALERT:C41("Please don't select a blank time slot!")
End if 