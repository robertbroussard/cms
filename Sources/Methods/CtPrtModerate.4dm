//%attributes = {"publishedWeb":true}
  //

  // CtPrtModerate - called by CourtForms

  //

  //     $1 = $CtrAtty,  $2 = $CtrProSe, $3 = $CtrMed

  //

_O_C_INTEGER:C282($i;$1;$2;$3;$4;$5;$Ctr)
_O_C_INTEGER:C282(ptrLine)
_O_C_STRING:C293(80;vTemp1;vTemp2)
C_TEXT:C284(vLine)
FORM SET INPUT:C55([CrtAddrFile:19];"CtWorksheetMSC")
MODIFY RECORD:C57([CrtAddrFile:19])  //DISPLAY WORKSHEET FORM

If (OK=1)
	[IntakeFile:1]DateMail:51:=vMailWksht  //UPDATE DATE-WORKSHEET-MAILED FROM INPUT

	[IntakeFile:1]DateTrial:54:=vTrialDate
	SAVE RECORD:C53([IntakeFile:1])
End if 
PAGE SETUP:C299([CrtAddrFile:19];"CtStdReptMed")
CONFIRM:C162("Do you want to print the Worksheet?")
If (OK=1)
	$Ctr:=$1+$2+$3+2  //EXTRA 2, 1 FOR FILE & 1 FOR COURT

	CONFIRM:C162("Press  OK  to print all Worksheets,      CANCEL to print just 1")
	If (OK#1)
		PrintCaseSum 
		$Ctr:=1
	End if 
	For ($i;1;$Ctr)
		Print form:C5([CrtAddrFile:19];"CtWorksheetMSC")
	End for 
	PAGE BREAK:C6
End if 
  //

CONFIRM:C162("Do you want to print the other forms?")
If (OK=1)
	Print form:C5([CrtAddrFile:19];"CtGuideMSC")  //ADM MODERATOR GUIDE

	$Ctr:=$1+1
	For ($i;1;2)
		Print form:C5([CrtAddrFile:19];"CtEvalMSC")  //ATTY + ADM-MSC

	End for 
	$Ctr:=$1
	For ($i;1;$Ctr)
		Print form:C5([CrtAddrFile:19];"CtInfoMSC")  //PAGE 1 INFO FOR ATTY

	End for 
	For ($i;1;$Ctr)
		Print form:C5([CrtAddrFile:19];"CtInfo2MSC")  //PAGE 2 INFO FOR ATTY

	End for 
	PAGE BREAK:C6  //FORCE PRINT OF LAST PAGE  

End if 
  //

CONFIRM:C162("Do you want to print Envelopes?"+Char:C90(13)+Char:C90(13)+"Set to MANUAL in Print Settings Dialogue Box")
If (OK=1)
	PAGE SETUP:C299([DailyLtrFile:14];"Envelopes3")
	PRINT SETTINGS:C106
	FORM SET OUTPUT:C54([DailyLtrFile:14];"Envelopes3")
	vn2:=0
	For ($i;1;9)
		vn2:=vn2+1
		If (aEnvelope{1}{vn2}>" ")
			vText1:=aEnvelope{1}{vn2}
			vText2:=aEnvelope{2}{vn2}
			vText3:=aEnvelope{3}{vn2}
			vText4:=aEnvelope{4}{vn2}
			vText5:=aEnvelope{5}{vn2}
			If (vPrinter360="Y")  // SET IN STARTUP PROC IF USING LASERWRITER 360 - CENTER ENVELOPE ALIGN.

				Print form:C5([DailyLtrFile:14];"EnvelopeCenter3")
			Else 
				Print form:C5([DailyLtrFile:14];"Envelopes3")
			End if 
		End if 
	End for 
	If (vCtCCName>" ")
		vText1:=vCtCCName
		vText2:=vCtCourtNam
		vText3:=vCtCCAddr1
		vText4:=vCtCCAddr2
		If (vPrinter360="Y")  // SET IN STARTUP PROC IF USING LASERWRITER 360 - CENTER ENVELOPE ALIGN.

			Print form:C5([DailyLtrFile:14];"EnvelopeCenter2")
		Else 
			Print form:C5([DailyLtrFile:14];"Envelopes2")
		End if 
	End if 
	PAGE BREAK:C6
	PAGE SETUP:C299([CrtAddrFile:19];"CtStdReptMed")
End if 