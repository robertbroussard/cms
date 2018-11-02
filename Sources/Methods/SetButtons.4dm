//%attributes = {"publishedWeb":true}
  //G-Procedure:SetButtons; This procedure is use to set the buttons 
  //of the IntakeFile Layout 'TestIntake'.  Called by Layout Proc TestIntake &
  //CourtBasedInput.
  //
OBJECT SET TITLE:C194(vSchCase;"Schedule Hearing")
Case of 
	: ([IntakeFile:1]CaseStatus:25="Hold")
		vSetHold:=1
		vSetRefer:=0
		vDirAssist:=0
		vSchCase:=0
	: ([IntakeFile:1]CaseStatus:25="Referred")
		vSetRefer:=1
		vSetHold:=0
		vDirAssist:=0
		vSchCase:=0
		_O_DISABLE BUTTON:C193(vSetHold)
		_O_DISABLE BUTTON:C193(vDirAssist)
		_O_DISABLE BUTTON:C193(vSchCase)
	: ([IntakeFile:1]CaseStatus:25="Direct Assistance")
		vDirAssist:=1
		vSetHold:=0
		vSetRefer:=0
		vSchCase:=0
		_O_DISABLE BUTTON:C193(vSetHold)
		_O_DISABLE BUTTON:C193(vSetRefer)
		_O_DISABLE BUTTON:C193(vSchCase)
	: ([IntakeFile:1]CaseStatus:25="Scheduled")
		vSchCase:=1
		vSetHold:=0
		vSetRefer:=0
		vDirAssist:=0
		_O_DISABLE BUTTON:C193(vSetHold)
		_O_DISABLE BUTTON:C193(vSetRefer)
		_O_DISABLE BUTTON:C193(vDirAssist)
		OBJECT SET TITLE:C194(vSchCase;"Hearing Scheduled")
End case 