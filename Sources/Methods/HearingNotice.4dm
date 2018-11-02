//%attributes = {"publishedWeb":true}
  //G-Proc: HearingNotice;  called by DefaultLTRS
  // Standard hearing notices plus special routines for
  // CPS and Child Protection services
  //
_O_C_INTEGER:C282($i;$Dialog)
_O_C_STRING:C293(30;$TempLtr)
If (vBlank=1)  // Set in DefaultLtrs - 1 if OK PRINT LETTERS - NO RESULTS OR "STL" w/ BA ltr req
	$Dialog:=1
	While ($Dialog=1)
		$Dialog:=0
		vType:=Uppercase:C13(Request:C163("Enter S for SCH, R for R/S, or C for CONT:";"S"))
		Case of 
			: (vType="S")
				vType:="scheduled"
			: (vType="R")
				vType:="rescheduled"
			: (vType="C")
				vType:="continued"
			Else 
				CONFIRM:C162("Enter S, R, or C to continue or choose Cancel to stop this operation.")
				If (OK=1)
					$Dialog:=1
				End if 
		End case 
	End while 
	vJuvLtr:=""
	If (OK=1)
		If ([IntakeFile:1]Program:32="D")
			vJuvLtr:=Request:C163("Enter 'Y' to print a Juvenile letter";"N")
		End if 
		GetParties 
		For ($i;1;Size of array:C274(aPLName))
			
			
			If ((aPartyLang{$i}="S "))  //  & ([IntakeFile]Program # "P"))        Probation now has Sp. Letter
				
				$TempLtr:=GetLtrType (aPartyType{$i};aPartyLang{$i};[IntakeFile:1]Program:32;1)
				SpanishRec_DLF ($i;$TempLtr;False:C215)
			End if 
			$TempLtr:=GetLtrType (aPartyType{$i};"E ";[IntakeFile:1]Program:32;1)
			NewRec_DLF ($i;$TempLtr;False:C215)
		End for 
		EnterNotesText ("R";vInitials)
		CONFIRM:C162("Would you like to print letters now?")
		If (OK=1)
			If ([IntakeFile:1]Program:32="W")
				PrintCPS (vInitials)  // PRINT CHILD PROTECT. SVC.  LETTER
			Else 
				If ([IntakeFile:1]Program:32="K")
					PrintCFK (vInitials)  // PRINT COOPERATE FOR KIDS LETTER
				Else 
					PrintNow (vInitials)
				End if 
			End if 
		End if 
	End if 
Else 
	ALERT:C41("This case has a problem with the hearing results. Letters will not be printed.")
	DoError (1;vInitials;vInitials)  // No records generated yet.
End if 