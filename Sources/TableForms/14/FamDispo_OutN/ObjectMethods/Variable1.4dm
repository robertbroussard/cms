  // vFamilyHdr entry in Family Disposition Layout FamDispo_Out
  // Enable all checkboxes so grayed out Disabled Buttons won't show as 
  // blotted out areas on the letter.
  //
C_TEXT:C284($vIVDCourt)
  //
If (False:C215)
	  //OBJECT SET ENABLED(cRsn1;True)
	  //OBJECT SET ENABLED(cRsn2;True)
	  //OBJECT SET ENABLED(cRsn3;True)
	  //OBJECT SET ENABLED(cRsn4;True)
	  //OBJECT SET ENABLED(cRsn5;True)
	  //OBJECT SET ENABLED(cRsn6;True)
	  //OBJECT SET ENABLED(cRsn7;True)
	  //OBJECT SET ENABLED(cRsn8;True)
End if 