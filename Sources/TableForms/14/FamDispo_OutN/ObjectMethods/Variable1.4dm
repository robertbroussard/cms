  // vFamilyHdr entry in Family Disposition Layout FamDispo_Out
  // Enable all checkboxes so grayed out Disabled Buttons won't show as 
  // blotted out areas on the letter.
  //
_O_C_STRING:C293(255;$vIVDCourt)
  //
If (False:C215)
	_O_ENABLE BUTTON:C192(cRsn1)
	_O_ENABLE BUTTON:C192(cRsn2)
	_O_ENABLE BUTTON:C192(cRsn3)
	_O_ENABLE BUTTON:C192(cRsn4)
	_O_ENABLE BUTTON:C192(cRsn5)
	_O_ENABLE BUTTON:C192(cRsn6)
	_O_ENABLE BUTTON:C192(cRsn7)
	_O_ENABLE BUTTON:C192(cRsn8)
End if 