  //Script: bENCancel; Located on page 3 of Layout "Courtbased".
_O_DISABLE BUTTON:C193(bStatus)
CONFIRM:C162("Changing case status can be dangerous! Are you sure you know what you are doing?")
If (OK=1)
	OBJECT SET ENTERABLE:C238([IntakeFile:1]CaseStatus:25;True:C214)
Else 
	_O_ENABLE BUTTON:C192(bStatus)
End if 