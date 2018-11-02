//%attributes = {"publishedWeb":true}
  //G-Proc:SpanishAlso;  See also NewRec_DLF
_O_C_INTEGER:C282($1;$OK)
_O_C_STRING:C293(32;$OPName;$OPName2)
_O_C_STRING:C293(30;$2)
$OK:=1
Case of 
	: ((aPartyType{$1}="C@") & ($3#True:C214))
		$OPName:=vCOParty
		$OPName2:=""
	: ((aPartyType{$1}="C@") & ($3=True:C214))
		$OPName:=vROParty
		$OPName2:=vCOParty
	: ((aPartyType{$1}="R@") & ($3#True:C214))
		$OPName:=vROParty
		$OPName2:=""
	: ((aPartyType{$1}="R@") & ($3=True:C214))
		$OPName:=vCOParty
		$OPName2:=vROParty
	: ([IntakeFile:1]Program:32="F")  // PRINT FAMILY ENVELOPES FOR ALL PARTIES
		$OPName:=vCOParty
		$OPName2:=vROParty
	Else 
		If (aPartyType{$1}="A@")
			ALERT:C41(aPFName{$1}+" "+aPLName{$1}+" is an attorney; Attorneys do not get correspondence.")
			$OK:=0
		Else 
			ALERT:C41("Party type is incorrect please correct this.")
			$OK:=0
		End if 
End case 
If ($OK=1)
	CREATE RECORD:C68([DailyLtrFile:14])
	[DailyLtrFile:14]DLFCaseNo:1:=[IntakeFile:1]CaseNo:1
	[DailyLtrFile:14]LName:3:=aPLName{$1}
	[DailyLtrFile:14]FName:4:=aPFName{$1}
	[DailyLtrFile:14]PartyType:5:=aPartyType{$1}
	[DailyLtrFile:14]Style:12:=Replace string:C233([IntakeFile:1]CaseStyle:23;" and ";" y ")
	[DailyLtrFile:14]PFirm:13:=aFirm{$1}
	[DailyLtrFile:14]PStAddress:14:=aStAdd{$1}
	[DailyLtrFile:14]PCity:15:=aCity{$1}
	[DailyLtrFile:14]PState:16:=agpState{$1}
	[DailyLtrFile:14]PZip:17:=aZip{$1}
	[DailyLtrFile:14]PartyLang:20:=aPartyLang{$1}
	[DailyLtrFile:14]PAge:29:=aAge{$1}  //            add Age field, 10/02
	[DailyLtrFile:14]OPName:11:=$OPName
	[DailyLtrFile:14]OPName2:26:=$OPName2
	  //Now fill the common fields from the global variables
	If (b1=1)  //IF HEARING NOTICE, LOAD FULL NAME
		[DailyLtrFile:14]Initials:6:=vITName  //GET NAME/INITIALS IN GetIntORSig
	Else 
		[DailyLtrFile:14]Initials:6:=vInitials
	End if 
	If (vDisputeS="spanish not used")  // LITERAL WAS GOING TO SPANISH  LETTER
		vDisputeS:=""
	End if 
	[DailyLtrFile:14]Dispute:7:=vDisputeS
	[DailyLtrFile:14]Scheduled:8:=vType
	[DailyLtrFile:14]SiteAddress:9:=vSiteAddS
	[DailyLtrFile:14]DocDate:10:=vDate
	[DailyLtrFile:14]TimeSlot:19:=vTimeSlot
	[DailyLtrFile:14]PrintEnv:21:=False:C215
	[DailyLtrFile:14]SDate:22:=vSDate
	[DailyLtrFile:14]PrintDate:23:=Current date:C33  // STARTUP PROC CHECKS TO DELETE OLD RECDS
	[DailyLtrFile:14]RefSource:27:=[IntakeFile:1]RefBy:16
	  //Assign the fields that relate to the letter file  
	  //and the variables passed from the calling procedure
	[DailyLtrFile:14]LtrType:2:=$2
	[DailyLtrFile:14]Copy:25:=$3
	BuildText 
	[DailyLtrFile:14]Spanish:24:=[LetterFile:15]LF_Spanish:4  //This has to be here because of the relation in build text.
	SAVE RECORD:C53([DailyLtrFile:14])
End if 