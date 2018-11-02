//%attributes = {"publishedWeb":true}
  //G-Proc: SchCase; This procedure is called from the procedure SetStatus which

  //is itself called from any 'case status' buttons on layout intinput

  // Also called from Method "DoReschedule"

  //

_O_C_STRING:C293(40;$Display1;$Display2)
vSCLoop1:=1
vSCLoop2:=0
vDate:=!00-00-00!
vSlotOK:=0
vSchOK:=0
vTempStatus:=""
vSite:=""
vCaseNo:=[IntakeFile:1]CaseNo:1
vdate:=!00-00-00!  //add 12/16/04

While (vSCLoop1=1)
	vSCLoop1:=0
	Open window:C153(78;40;433;350;1)
	DIALOG:C40([DocketFile:6];"DocDialog")
	CLOSE WINDOW:C154
	If (OK=1)
		If (vSite#"")
			If (vNextAvail=1)
				vDate:=GetNextAvail (vCaseNo;vSite)
				If (vDate#!00-00-00!)
					vSCLoop2:=1
				End if 
			Else 
				If (vReqDate=1)
					vDate:=GetReqDate (vCaseNo;vSite)
					If (vDate#!00-00-00!)
						vSCLoop2:=1
					End if 
				Else   //User didn't click a scheduling option.

					$Display1:=("You must click a scheduling option!")
					$Display2:=(" Click OK to continue or Cancel to quit.")
					CONFIRM:C162($Display1+$Display2)
					If (OK=1)
						vSCLoop1:=1
					End if   //Drops out if user clicks cancel.

				End if 
			End if 
		Else   // User didn't enter a Site.

			$Display1:=("You must enter a Docket Site.")
			$Display2:=(" Click OK to continue or Cancel to quit.")
			CONFIRM:C162($Display1+$Display2)
			If (OK=1)
				vSCLoop1:=1
			End if   //Loop drops out if the user hits cancel.

		End if 
	End if   //Loop drops out if the user hits cancel.

End while 
While (vSCLoop2=1)
	vSCLoop2:=0
	BuildDocArray 
	If (vskipMon=False:C215)
		DIALOG:C40([DocketFile:6];"DocketDisplay")
	End if 
End while 
CLEAR VARIABLE:C89(aTimeSlot)
CLEAR VARIABLE:C89(aCaseNo)
CLEAR VARIABLE:C89(aCName)
CLEAR VARIABLE:C89(aRName)
CLEAR VARIABLE:C89(aSlotCount)
CLEAR VARIABLE:C89(aSlotName)
UNLOAD RECORD:C212([SiteConstraints:7])
UNLOAD RECORD:C212([InvalidDateFile:8])