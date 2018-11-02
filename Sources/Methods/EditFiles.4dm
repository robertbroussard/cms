//%attributes = {"publishedWeb":true}
  // 
  // Menu item to edit and list CrtAddrFile
  //
FORM SET INPUT:C55([CrtAddrFile:19];"CCInput")
FORM SET OUTPUT:C54([CrtAddrFile:19];"CtEditFile")
ALL RECORDS:C47([CrtAddrFile:19])
MODIFY SELECTION:C204([CrtAddrFile:19])
If (OK=1)
	SAVE RECORD:C53([CrtAddrFile:19])
End if 
UNLOAD RECORD:C212([CrtAddrFile:19])