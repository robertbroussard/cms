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
		OBJECT SET ENABLED:C1123(vSetHold;False:C215)
		OBJECT SET ENABLED:C1123(vDirAssist;False:C215)
		OBJECT SET ENABLED:C1123(vSchCase;False:C215)
	: ([IntakeFile:1]CaseStatus:25="Direct Assistance")
		vDirAssist:=1
		vSetHold:=0
		vSetRefer:=0
		vSchCase:=0
		OBJECT SET ENABLED:C1123(vSetHold;False:C215)
		OBJECT SET ENABLED:C1123(vSetRefer;False:C215)
		OBJECT SET ENABLED:C1123(vSchCase;False:C215)
	: ([IntakeFile:1]CaseStatus:25="Scheduled")
		vSchCase:=1
		vSetHold:=0
		vSetRefer:=0
		vDirAssist:=0
		OBJECT SET ENABLED:C1123(vSetHold;False:C215)
		OBJECT SET ENABLED:C1123(vSetRefer;False:C215)
		OBJECT SET ENABLED:C1123(vDirAssist;False:C215)
		OBJECT SET TITLE:C194(vSchCase;"Hearing Scheduled")
End case 