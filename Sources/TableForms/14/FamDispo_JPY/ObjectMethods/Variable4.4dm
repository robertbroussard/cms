  // Script in Checkbox of (L) DLF; FamDispo_JPY to turn on flag for proper result.
  //
If (vResult="Settl@")
	mRsn1:=1
End if 
If (vResult="Narrow@")
	mRsn2:=1
End if 
If (vResult="Impasse")
	mRsn3:=1
End if 