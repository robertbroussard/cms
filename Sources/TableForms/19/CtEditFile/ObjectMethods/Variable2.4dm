  // add button on CtEditFile Layout 
  //
C_BOOLEAN:C305($loopit)
$loopit:=True:C214
While ($loopit=True:C214)
	$loopit:=False:C215
	ADD RECORD:C56([CrtAddrFile:19])
	If (ok=1)
		SAVE RECORD:C53([CrtAddrFile:19])
		CONFIRM:C162("Do you want to add another record?")
		If (ok=1)
			$loopit:=True:C214
		End if 
	End if 
End while 