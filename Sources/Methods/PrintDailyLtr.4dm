//%attributes = {"publishedWeb":true}
  //G-Procedure: PrintDailyLtr
_O_C_INTEGER:C282($i;$Temp;$Print;$PrintLoop;$OK1;$OK2)
_O_C_STRING:C293(35;$Dis1;$Dis2)
_O_C_STRING:C293(1;$CR)
$OK1:=1
$OK2:=1
$PrintLoop:=0
$Temp:=0
$Print:=0
ALL RECORDS:C47([DailyLtrFile:14])
If (Records in selection:C76([DailyLtrFile:14])>0)
	vPInitials:=""
	While (vPInitials="")
		vPInitials:=Uppercase:C13(Request:C163("Enter Initials(2 only): "))
		If (OK#1)
			CONFIRM:C162("Stop Printing?")
			If (OK=1)
				vPInitials:="XX"
				$PrintLoop:=0
			End if 
		Else 
			$PrintLoop:=1
		End if 
	End while 
	While ($PrintLoop=1)
		$PrintLoop:=0
		CREATE SET:C116([DailyLtrFile:14];"DLFSet")
		CREATE EMPTY SET:C140([DailyLtrFile:14];"PrintSet")
		CREATE EMPTY SET:C140([DailyLtrFile:14];"ErrorSet")
		CREATE EMPTY SET:C140([DailyLtrFile:14];"EnvelopeSet")
		CREATE EMPTY SET:C140([DailyLtrFile:14];"LSOSet")
		FIRST RECORD:C50([DailyLtrFile:14])
		For ($i;1;Records in selection:C76([DailyLtrFile:14]))
			If (CheckRecord =True:C214)
				ADD TO SET:C119([DailyLtrFile:14];"PrintSet")
				If ([DailyLtrFile:14]PrintEnv:21=True:C214)
					ADD TO SET:C119([DailyLtrFile:14];"EnvelopeSet")
				End if 
				If ([DailyLtrFile:14]LtrType:2="JUMP LSO@")
					ADD TO SET:C119([DailyLtrFile:14];"LSOSet")
				End if 
			Else 
				DoError (4;[DailyLtrFile:14]Initials:6;vPInitials)
				ADD TO SET:C119([DailyLtrFile:14];"ErrorSet")
			End if 
			NEXT RECORD:C51([DailyLtrFile:14])
		End for 
		DIFFERENCE:C122("PrintSet";"LSOSet";"PrintSet")
		$Print:=Records in set:C195("PrintSet")+Records in set:C195("LSOSet")
		If ($Print>0)
			$Print:=Records in set:C195("PrintSet")+Records in set:C195("LSOSet")
			ALERT:C41("Preparing to print "+String:C10($Print)+" letters.")
			If (Records in set:C195("LSOSet")>0)
				USE SET:C118("LSOSet")
				ORDER BY:C49([DailyLtrFile:14];[DailyLtrFile:14]DLFCaseNo:1;>)
				ACCUMULATE:C303($Temp)
				BREAK LEVEL:C302(1;0)
				FORM SET OUTPUT:C54([DailyLtrFile:14];"LSO Letters")
				PAGE SETUP:C299([DailyLtrFile:14];"LSO Letters")
				PRINT SELECTION:C60([DailyLtrFile:14];*)
				If (OK#1)
					$OK2:=0
				End if 
			End if 
			USE SET:C118("PrintSet")
			ORDER BY:C49([DailyLtrFile:14];[DailyLtrFile:14]DLFCaseNo:1;>)
			ACCUMULATE:C303($Temp)
			BREAK LEVEL:C302(1;0)
			FORM SET OUTPUT:C54([DailyLtrFile:14];"DFLTestLtr")
			PAGE SETUP:C299([DailyLtrFile:14];"DFLTestLtr")
			PRINT SELECTION:C60([DailyLtrFile:14];*)
			If (OK#1)
				$OK1:=0
			End if 
			USE SET:C118("EnvelopeSet")
			ORDER BY:C49([DailyLtrFile:14];[DailyLtrFile:14]DLFCaseNo:1;>)
			$CR:=Char:C90(13)
			$Dis1:=("Preparing to print "+String:C10(Records in set:C195("EnvelopeSet"))+" envelopes.")
			$Dis2:=$CR+"Place envelopes into the printer."
			ALERT:C41($Dis1+$Dis2)
			PAGE SETUP:C299([DailyLtrFile:14];"Envelopes")
			If (vPrinter360="Y")  // SET IN STARTUP PROC IF USING LASERWRITER 360 - CENTER ENVELOPE ALIGN.
				FORM SET OUTPUT:C54([DailyLtrFile:14];"EnvelopeCenter")
				PRINT SELECTION:C60([DailyLtrFile:14])
			Else 
				FORM SET OUTPUT:C54([DailyLtrFile:14];"Envelopes")
				PRINT SELECTION:C60([DailyLtrFile:14])
			End if 
			UNION:C120("PrintSet";"LSOSet";"PrintSet")
			USE SET:C118("PrintSet")
		Else 
			$OK1:=0
		End if 
		If ((OK=1) & ($OK1=1)) & ($OK2=1)
			For ($i;1;Records in selection:C76([DailyLtrFile:14]))
				DoRptEntry ("B";vPInitials)
				NEXT RECORD:C51([DailyLtrFile:14])
			End for 
			PDLNotes (vPInitials)
			ALERT:C41("Please check that all the letters and envelopes printed properly.")
			CONFIRM:C162("Are you prepared to delete all of the records in the daily letter file?")
			If (OK=1)
				UNION:C120("PrintSet";"ErrorSet";"PrintSet")
				USE SET:C118("PrintSet")
				DELETE SELECTION:C66([DailyLtrFile:14])
			End if 
		Else 
			For ($i;1;Records in selection:C76([DailyLtrFile:14]))
				DoError (6;vPInitials;vPInitials)
				NEXT RECORD:C51([DailyLtrFile:14])
			End for 
			ALERT:C41("There was a problem printing, check the correspondence report for reason.")
		End if 
		DCR_Totals 
		FORM SET OUTPUT:C54([LtrRptFile:16];"LRFDailyRpt")
		PAGE SETUP:C299([LtrRptFile:16];"LRFDailyRpt")
		ORDER BY:C49([LtrRptFile:16]TimePrinted:9;[LtrRptFile:16]LtrCaseNo:1;>)
		ACCUMULATE:C303(x)
		BREAK LEVEL:C302(0)
		PRINT SELECTION:C60([LtrRptFile:16];*)
		DELETE SELECTION:C66([LtrRptFile:16])
	End while 
Else 
	ALERT:C41("There are no letters to print.")
End if 
CLEAR SET:C117("PrintSet")
CLEAR SET:C117("ErrorSet")
CLEAR SET:C117("Envelopes")
CLEAR SET:C117("LSOSet")
UNLOAD RECORD:C212([IntakeFile:1])