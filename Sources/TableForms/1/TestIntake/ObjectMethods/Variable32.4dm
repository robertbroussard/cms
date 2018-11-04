  //Script: bStatus;
OBJECT SET ENABLED:C1123(bStatus;False:C215)
CONFIRM:C162("Changing case status can be dangerous! Are you sure you know what you are doing?")
If (OK=1)
	OBJECT SET ENTERABLE:C238([IntakeFile:1]CaseStatus:25;True:C214)
Else 
	OBJECT SET ENABLED:C1123(bStatus;True:C214)
End if 