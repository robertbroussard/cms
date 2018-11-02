  // vFamilyHdr entry in Family Disposition Layout FamDispo_Out
  // Enable all checkboxes so grayed out Disabled Buttons won't show as 
  // blotted out areas on the letter.
  //
_O_ENABLE BUTTON:C192(cRsn1)
_O_ENABLE BUTTON:C192(cRsn2)
_O_ENABLE BUTTON:C192(cRsn3)
_O_ENABLE BUTTON:C192(cRsn4)
_O_ENABLE BUTTON:C192(cRsn5)
_O_ENABLE BUTTON:C192(cRsn6)
_O_ENABLE BUTTON:C192(cRsn7)
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