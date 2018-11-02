//%attributes = {"publishedWeb":true}
SET WINDOW TITLE:C213("DRC Case Management System")
vNewIntake:=False:C215
vNewIntake2:=False:C215
vSwitch:=0
FORM SET INPUT:C55([IntakeFile:1];"TestIntake")
FORM SET OUTPUT:C54([IntakeFile:1];"DisplaySel2")
  //SET ENTERABLE([IntakeFile]CaseNo;False)
ALL RECORDS:C47([IntakeFile:1])
MODIFY SELECTION:C204([IntakeFile:1];*)
  //UNLOAD RECORD([IntakeFile])
  //FIRST RECORD([IntakeFile]) disabled RJB 11/2/18