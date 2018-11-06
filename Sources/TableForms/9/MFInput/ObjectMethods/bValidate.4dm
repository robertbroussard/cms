  //Script: bMFOK;
C_BOOLEAN:C305(vCheckKey)
If (vCheckKey=True:C214)
	vCheckKey:=False:C215
	If (CheckMKey =True:C214)
		SAVE RECORD:C53([MediatorFile:9])
	Else 
		ALERT:C41("Changes will not be saved!")
	End if 
Else 
	SAVE RECORD:C53([MediatorFile:9])
End if 
ACCEPT:C269