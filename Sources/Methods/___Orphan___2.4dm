//%attributes = {}
  //Script: bCancel; located on layout "TestIntake"
  //
SET WINDOW TITLE:C213("DRC Case Management System")
UNLOAD RECORD:C212([DisputeFile:4])
UNLOAD RECORD:C212([DocketFile:6])
UNLOAD RECORD:C212([MedActFile:10])
UNLOAD RECORD:C212([MediatorFile:9])