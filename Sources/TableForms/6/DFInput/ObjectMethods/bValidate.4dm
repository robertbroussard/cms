  //Script: bDFIOK; This button checks the HResults against the roles for the 
  //entries for the mediator roles, by calling CheckRoles, to insure that all 
  //the information is correct.
C_TEXT:C284($Dis1;$Dis2)
vRolesOK:=False:C215
vLastError:=True:C214
If ([DocketFile:6]HResults:11#"")
	If ((([DocketFile:6]HResults:11="STL") | ([DocketFile:6]HResults:11="IMP")) | (([DocketFile:6]HResults:11="VEN") | ([DocketFile:6]HResults:11="CONT")))
		vRolesOK:=CheckRoles 
		If ([DocketFile:6]HLenght:12=0)
			Repeat 
				[DocketFile:6]HLenght:12:=Num:C11(Request:C163("Hearing length not allowed,  reenter:"))
				If ([DocketFile:6]HLenght:12#0)
					If ([DocketFile:6]HLenght:12>=0) | ([DocketFile:6]HLenght:12<=0)  //Added to prevent possible NANs...
						  //Then the number is valid....
					Else 
						[DocketFile:6]HLenght:12:=0
					End if 
				End if 
			Until ([DocketFile:6]HLenght:12#0)
		End if 
	Else 
		If (Records in selection:C76([MedActFile:10])=0)
			vRolesOK:=True:C214
			If ([DocketFile:6]HLenght:12#0)
				ALERT:C41("This case should have a hearing length of 0. This will be done for you.")
				[DocketFile:6]HLenght:12:=0
			End if 
		End if 
	End if 
	  //               LITIGATION DKT NEEDS T0 UPDATE MEDACT RECD WHEN RESULTS ADDED  
	$pgm:=[DocketFile:6]DFCaseNo:4[[9]]
	If (($pgm="A") | ($pgm="L") | ($pgm="M"))  //ADDED 2/1/96
		RELATE MANY:C262([DocketFile:6]DocKey:6)
		If (Records in selection:C76([MedActFile:10])=0)
			ALERT:C41("There is no Mediator Activity record for this Docket")
		Else 
			FIRST RECORD:C50([MedActFile:10])
			For ($i;1;Records in selection:C76([MedActFile:10]))
				If ([MedActFile:10]ActResults:8="")
					[MedActFile:10]ActResults:8:=[DocketFile:6]HResults:11
					[MedActFile:10]AmtOfTime:6:=[DocketFile:6]HLenght:12
					SAVE RECORD:C53([MedActFile:10])
				End if 
				NEXT RECORD:C51([MedActFile:10])
			End for 
		End if 
	End if 
	  //  
Else 
	$pgm:=[DocketFile:6]DFCaseNo:4[[9]]
	If (($pgm="A") | ($pgm="L") | ($pgm="M"))
		vRolesOK:=True:C214
	Else 
		ALERT:C41("You must enter the Hearing Results or choose Cancel.")
	End if 
End if 
  // This is the final data input check
If (vRolesOK=True:C214)
	SAVE RECORD:C53([DocketFile:6])
	UNLOAD RECORD:C212([DocketFile:6])
	UNLOAD RECORD:C212([IntakeFile:1])
	UNLOAD RECORD:C212([Details:18])
	UNLOAD RECORD:C212([MedActFile:10])
	ACCEPT:C269
Else 
	If (vLastError=True:C214)
		$Dis1:="Error in mediator(s) and assigned role(s)."
		$Dis2:=" This must be fixed before exiting."
		ALERT:C41($Dis1+$Dis2)
	End if 
End if 