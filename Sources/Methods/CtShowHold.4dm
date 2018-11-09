//%attributes = {"publishedWeb":true}
  //  //     Called from main menu Intake - Lists Court Based cases on Hold by date
  //  //

  //SET WINDOW TITLE("DRC Case Management System")
  //ALL RECORDS([IntakeFile])
  //FORM SET INPUT([IntakeFile];"CourtBasedInput")
  //FORM SET OUTPUT([IntakeFile];"CtDisplaySel")
  //QUERY([IntakeFile];[IntakeFile]Program="A";*)
  //QUERY([IntakeFile]; | ;[IntakeFile]Program="L";*)
  //QUERY([IntakeFile]; | ;[IntakeFile]Program="M";*)
  //QUERY([IntakeFile]; & ;[IntakeFile]CaseStatus="Hold")
  //If (Records in selection([IntakeFile])>0)
  //ORDER BY([IntakeFile]DisputeCode;>)
  //RELATE MANY([IntakeFile]CaseNo)
  //MODIFY SELECTION([IntakeFile];*)
  //Else 
  //ALERT("No records found!")
  //End if 
  //UNLOAD RECORD([IntakeFile])
  //FORM SET INPUT([IntakeFile];"TestIntake")
  //FORM SET OUTPUT([IntakeFile];"DisplaySel2")