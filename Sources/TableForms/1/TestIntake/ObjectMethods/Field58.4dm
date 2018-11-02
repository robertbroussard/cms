If (Modified:C32([IntakeFile:1]CaseStatus:25))
	_O_ENABLE BUTTON:C192(vSetRefer)
	_O_ENABLE BUTTON:C192(vSetHold)
	_O_ENABLE BUTTON:C192(vDirAssist)
	_O_ENABLE BUTTON:C192(vSchCase)
	SetButtons 
	OBJECT SET ENTERABLE:C238([IntakeFile:1]CaseStatus:25;False:C215)
	_O_ENABLE BUTTON:C192(bStatus)
End if 