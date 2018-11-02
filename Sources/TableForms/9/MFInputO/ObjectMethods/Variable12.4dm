  //Script: bKevin
_O_C_STRING:C293(2;$KTemp)
$KTemp:=Request:C163("Enter Password:")
If ($KTemp="me")
	OBJECT SET ENTERABLE:C238([MediatorFile:9]MKey:14;True:C214)
	OBJECT SET ENTERABLE:C238([MediatorFile:9]DateEntered:11;True:C214)
End if 