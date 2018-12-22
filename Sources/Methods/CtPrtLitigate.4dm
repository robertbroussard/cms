//%attributes = {"publishedWeb":true}
  //    CtPrtLitigate - called by CourtForms
  //
  //     $1 = $CtrAtty,  $2 = $CtrProSe, $3 = $CtrMed
  //
C_LONGINT:C283($i;$1;$2;$3;$4;$5;$Ctr)
C_LONGINT:C283(ptrLine)
C_TEXT:C284(vTemp1;vTemp2)
C_TEXT:C284(vLine;vCtInfoMsg)
  //FORM SET INPUT([CrtAddrFile];"CtWorksheetMed")
  //MODIFY RECORD([CrtAddrFile])  //DISPLAY WORKSHEET FORM
  //UNLOAD RECORD([CrtAddrFile])
If (OK=1)
	[IntakeFile:1]DateMail:51:=vMailWksht  //UPDATE DATE-WORKSHEET-MAILED FROM INPUT
	[IntakeFile:1]DateTrial:54:=vTrialDate
	SAVE RECORD:C53([IntakeFile:1])
End if 
PRINT SETTINGS:C106
  //PAGE SETUP([CrtAddrFile];"CtStdReptMed")
CONFIRM:C162("Do you want to print the Worksheet?")
If (OK=1)
	$Ctr:=$1+$2+$3+2  //EXTRA 2, 1 FOR FILE & 1 FOR COURT
	CONFIRM:C162("Press  OK  to print all Worksheets,      CANCEL to print just 1")
	If (OK#1)
		PrintCaseSum 
		PrintCaseSum   //     2nd copy - get this form if print just 1 worksheet
		$Ctr:=1
	End if 
	For ($i;1;$Ctr)
		Print form:C5([CrtAddrFile:19];"CtWorksheetMed")
	End for 
	PAGE BREAK:C6
End if 
  //
CONFIRM:C162("Do you want to print the other forms?")
If (OK=1)
	$Ctr:=$1+$2
	For ($i;1;$Ctr)
		Print form:C5([CrtAddrFile:19];"CtEvalMed")
	End for 
	$Ctr:=$1+$2+$3+1
	For ($i;1;$Ctr)
		Print form:C5([CrtAddrFile:19];"CtGuideMed")
	End for 
	vCtInfoMsg1:="Please return this form to <vLineM11> at his/her address which is listed on the "
	vCtInfoMsg1:=vCtInfoMsg1+"Litigation Worksheet at least three (3) days prior to your scheduled "
	vCtInfoMsg1:=vCtInfoMsg1+"mediation. The mediator shall forward this form with his/her Mediator's report."
	$Ctr:=$1+$2+$3
	For ($i;1;$Ctr)
		Print form:C5([CrtAddrFile:19];"CtInfoMed")
	End for 
	$Ctr:=$1+$2+$3
	For ($i;1;$Ctr)
		Print form:C5([CrtAddrFile:19];"CtReschedMed")
	End for 
	$Ctr:=$1+$2+$3
	For ($i;1;$Ctr)
		Print form:C5([CrtAddrFile:19];"CtRulesMed")
	End for 
	  //                            `$2:=1            Removed  
	If ($2>0)  //TEST FOR PRO SE
		$Ctr:=$2+$3+1
		For ($i;1;$Ctr)
			Print form:C5([CrtAddrFile:19];"CtProSeMX")
		End for 
	End if 
	Case of 
		: (vCtCCRefBy="US Bnkrp")
			For ($i;1;$3)
				Print form:C5([CrtAddrFile:19];"CtBnkReptMed")
			End for 
			For ($i;1;$3)
				Print form:C5([CrtAddrFile:19];"CtStdSTLMed")
			End for 
		: (vCtCCRefBy="Pre-Lit")
			For ($i;1;$3)
				Print form:C5([CrtAddrFile:19];"CtPreReptMed")
			End for 
			For ($i;1;$3)
				Print form:C5([CrtAddrFile:19];"CtPreSTLMed")
			End for 
		Else 
			For ($i;1;$3)
				Print form:C5([CrtAddrFile:19];"CtStdReptMed")
			End for 
			For ($i;1;$3)
				Print form:C5([CrtAddrFile:19];"CtStdSTLMed")
			End for 
	End case 
	PAGE BREAK:C6  //FORCE PRINT OF LAST PAGE
End if 
  //
CONFIRM:C162("Do you want to print Envelopes?"+Char:C90(13)+Char:C90(13)+"Set to MANUAL in Print Settings Dialogue Box")
If (OK=1)
	PAGE SETUP:C299([DailyLtrFile:14];"Envelopes3")
	PRINT SETTINGS:C106(0)  //rjb update 7/6/2010
	FORM SET OUTPUT:C54([DailyLtrFile:14];"Envelopes3")
	vn2:=0
	For ($i;1;9)  //was 9 temp
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