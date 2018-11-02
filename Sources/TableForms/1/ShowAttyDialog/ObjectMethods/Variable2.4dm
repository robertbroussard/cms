  // Script: aACaseNo in layout [IntakeFile];"ShowAttyDialog";
  // Captures case nbr clicked on by user to call Intake Layout
  // vSort is set to 2 to sort by Case No if bSort Button is clicked in Dialog.
  //
If (aACaseNo{aACaseNo}#"")
	vCaseNo:=aACaseNo{aACaseNo}
	vElement:=aACaseNo
Else 
	ALERT:C41("Please don't select a blank line!")
End if 
vSort:=2  // SET SWITCH TO SORT ON  CASENO