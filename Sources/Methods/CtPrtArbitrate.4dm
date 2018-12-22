//%attributes = {"publishedWeb":true}
  //

  //    CtPrtArbitrate - called by CourtForms

  //    Duplicate any changes made in Procs CtPrtLitigate, CtPrtModerate

  //

  //     $1 = $CtrAtty,  $2 = $CtrProSe, $3 = $CtrMed

  //

C_LONGINT:C283($i;$1;$2;$3;$4;$5;$Ctr)
C_LONGINT:C283(ptrLine)
C_TEXT:C284(vTemp1;vTemp2)
C_TEXT:C284(vLine)
  //FORM SET INPUT([CrtAddrFile];"CtWorksheetArb") //off rjb 12/21/18.
  //MODIFY RECORD([CrtAddrFile])
If (OK=1)
	[IntakeFile:1]DateMail:51:=vMailWksht  //UPDATE DATE WORKSHEET MAILED FROM INPUT
	
	[IntakeFile:1]DateTrial:54:=vTrialDate
	SAVE RECORD:C53([IntakeFile:1])
End if 
PRINT SETTINGS:C106
  //PAGE SETUP([CrtAddrFile];"CtAwardArb")   //off rjb 12/21/18.
CONFIRM:C162("Do you want to print the Worksheet?")
If (OK=1)
	$Ctr:=$1+$2+$3+2  //EXTRA 2, 1 FOR FILE & 1 FOR COURT
	
	CONFIRM:C162("Press  OK  to print all Worksheets,      CANCEL to print just 1")
	If (OK#1)
		PrintCaseSum 
		PrintCaseSum   //2 copies - only get this when just print 1 WorkSheet
		
		$Ctr:=1
	End if 
	For ($i;1;$Ctr)
		Print form:C5([CrtAddrFile:19];"CtWorkSheetArb")
	End for 
	PAGE BREAK:C6
End if 
  //

CONFIRM:C162("Do you want to print the other forms?")
If (OK=1)
	If (vCtCCRefBy="Pre-Lit")
		Print form:C5([CrtAddrFile:19];"CtAwardPreArb")  //PRE-LIT AWARD
		
		Print form:C5([CrtAddrFile:19];"CtEvalPreArb")  //PRE-LIT EVALUATION
		
		Print form:C5([CrtAddrFile:19];"CtEvalPreArb")  //PRE-LIT EVALUATION - ONE FOR EACH 
		
		Print form:C5([CrtAddrFile:19];"CtBindPreArb")  //PRE-LIT BINDING
		
	Else 
		Print form:C5([CrtAddrFile:19];"CtAwardArb")  //STD AWARD
		
		Print form:C5([CrtAddrFile:19];"CtEvalArb")  //STD EVALUATION
		
		Print form:C5([CrtAddrFile:19];"CtBindArb")  //STD BINDING
		
		Print form:C5([CrtAddrFile:19];"CtCoordNotArb")  //TRIAL COORDINATOR NOTICE
		
	End if 
	$Ctr:=$1+$2+1
	For ($i;1;$Ctr)
		Print form:C5([CrtAddrFile:19];"CtGuideMed")  //USE MEDIATOR GUIDE
		
	End for 
	For ($i;1;$Ctr)
		Print form:C5([CrtAddrFile:19];"CtInfoArb")
	End for 
	For ($i;1;$Ctr)
		Print form:C5([CrtAddrFile:19];"CtRulesArb")
	End for 
	
	If ($2>0)  //            TEST FOR PRO SE
		
		$Ctr:=$2+$3+1
		For ($i;1;$Ctr)
			Print form:C5([CrtAddrFile:19];"CtProSeMX")  //       NEW FORM FOR MED AND ARB TOO,   8/2002
			
		End for 
	End if 
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