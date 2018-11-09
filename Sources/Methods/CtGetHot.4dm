//%attributes = {"publishedWeb":true}
  //  //   Called from main menu Intake - Lists Court Based cases flagged as Hot
  //  //
  //  //deleted menu 11/9/18
  //SET WINDOW TITLE("DRC Case Management System")
  //  //G-Procedure: GetHot;
  //ALL RECORDS([IntakeFile])
  //FORM SET INPUT([IntakeFile];"CourtBasedInput")
  //FORM SET OUTPUT([IntakeFile];"CtDisplaySel")
  //QUERY([IntakeFile];[IntakeFile]Program="A";*)
  //QUERY([IntakeFile]; | ;[IntakeFile]Program="L";*)
  //QUERY([IntakeFile]; | ;[IntakeFile]Program="M";*)
  //QUERY([IntakeFile]; & ;[IntakeFile]Hot=True)
  //If (Records in selection([IntakeFile])>0)
  //ORDER BY([IntakeFile]CaseNo;>)
  //MODIFY SELECTION([IntakeFile];*)
  //Else 
  //ALERT("No records found!")
  //End if 
  //UNLOAD RECORD([IntakeFile])
  //FORM SET INPUT([IntakeFile];"TestIntake")
  //FORM SET OUTPUT([IntakeFile];"DisplaySel2")