  //Script: vDone; Located on DocketDisplay
If (vSchOK#1)
	ALERT:C41("Scheduling not  complete. Click Cancel if you want to Stop.")
Else 
	POP RECORD:C177([DocketFile:6])
	UNLOAD RECORD:C212([DocketFile:6])
	ACCEPT:C269
End if 