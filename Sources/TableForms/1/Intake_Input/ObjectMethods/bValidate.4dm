  //Script: bOK; located on layout "TestIntake" page 1.
SAVE RECORD:C53([IntakeFile:1])
ACCEPT:C269
SET WINDOW TITLE:C213("DRC Case Management System")
SAVE RECORD:C53([FamilyFile:20])
UNLOAD RECORD:C212([DisputeFile:4])
UNLOAD RECORD:C212([DocketFile:6])
UNLOAD RECORD:C212([MedActFile:10])
UNLOAD RECORD:C212([MediatorFile:9])
UNLOAD RECORD:C212([CrtAddrFile:19])