  // vFamilyHdr entry in Family Disposition Layout FamDispo_Out
  // Enable all checkboxes so grayed out Disabled Buttons won't show as 
  // blotted out areas on the letter.
  //
OBJECT SET ENABLED:C1123(cRsn1;True:C214)
OBJECT SET ENABLED:C1123(cRsn2;True:C214)
OBJECT SET ENABLED:C1123(cRsn3;True:C214)
OBJECT SET ENABLED:C1123(cRsn4;True:C214)
OBJECT SET ENABLED:C1123(cRsn5;True:C214)
OBJECT SET ENABLED:C1123(cRsn6;True:C214)
OBJECT SET ENABLED:C1123(cRsn7;True:C214)
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