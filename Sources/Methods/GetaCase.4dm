//%attributes = {"publishedWeb":true}
  //G-Procedure;GetaCase: This procedure is called from any of the scripts on the 
  //layout "DisplaySel2" and it allows the user to modify a case when selected.
  //If ($1#-1)
  // SEARCH([IntakeFile];[IntakeFile]CaseNo=aIFCaseNo{$1})
  // INPUT LAYOUT([IntakeFile];"IntInput")
  // MODIFY RECORD([IntakeFile];)
  //End if 
ALERT:C41("This procedure should not be called?")