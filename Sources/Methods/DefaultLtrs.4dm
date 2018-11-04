//%attributes = {"publishedWeb":true}
  //G-Procedure: Default;
  //
C_TEXT:C284($TempvText2)
C_LONGINT:C283(b1;b2;b3;b4;b5;b6;b7;b8)
C_LONGINT:C283($Open)
C_TEXT:C284(vTitle)  //     ON BOTTOM OF CPS NOTICE
$TempvText2:=vText2
DIALOG:C40([LetterFile:15];"LtrBasicDialog")
$Check:=True:C214
If (OK=1)
	If (b2#1)
		If ((b5#1) & (b6=0) & (b7#1) & (b8#1))
			If ((b1=1) | (b3=1) | (b2=1))  //ADD b3/b2 SO FAMILY CONT GETS NAME
				$Check:=GetIntORSig (2)
			Else 
				$Check:=GetIntORSig (1)
			End if 
		Else 
			If ((b6=0) & (b7#1))
				$Check:=GetIntORSig (2)
			End if 
		End if 
	End if 
	If ($Check=True:C214)
		vCOParty:=[IntakeFile:1]RFName:12+" "+[IntakeFile:1]RLName:11
		vROParty:=[IntakeFile:1]CFName:7+" "+[IntakeFile:1]CLName:6
		vDispute:=[DisputeFile:4]DisName:2
		vDisputeS:=[DisputeFile:4]SDisName:3
		vType:=""  //Used in 'HearingNotice'
		vTempResult:=""
		vDate:=!00-00-00!
		vBlank:=0
		If ([IntakeFile:1]CaseStatus:25="Scheduled")
			RELATE MANY:C262([IntakeFile:1]CaseNo:1)  //gets all many relations including "Docket File" recs...
			vBlank:=0
			For ($Open;1;Records in selection:C76([DocketFile:6]))
				vTempResult:=[DocketFile:6]HResults:11
				If ([DocketFile:6]HResults:11="") | ((vTempResult="STL") & (b4=1))
					vBlank:=vBlank+1  //   OK TO PRINT LETTERS - NO RESULTS YET EXCEPT b4
					RELATE ONE:C42([DocketFile:6]DocketSite:1;[SiteConstraints:7]Site:1)
					vSiteAdd:=[SiteConstraints:7]DocAddress:15
					vSiteAddS:=[SiteConstraints:7]SDocAddress:16
					vTimeSlot:=[DocketFile:6]TimeSlot:3
					vDate:=[DocketFile:6]DocketDate:2
					vSDate:=SpanishDates ([DocketFile:6]DocketDate:2)
				End if 
				NEXT RECORD:C51([DocketFile:6])
			End for 
		End if 
		Case of 
			: (b1=1)
				HearingNotice 
			: (b2=1)
				Print_Dispo_Master 
			: (b3=1)
				ContNotice 
			: (b4=1)
				BALetter 
			: (b5=1)
				DoDispo 
			: (b6=1)
				PrintEnvelope 
			: (b7=1)
				CourtForms 
			: (b8=1)
				DoDispo_Other 
		End case 
		ClearLtrArrays 
		  //need to clear all the global variables here also.
	End if 
End if 
UNLOAD RECORD:C212([DailyLtrFile:14])
UNLOAD RECORD:C212([LetterFile:15])
UNLOAD RECORD:C212([SiteConstraints:7])
UNLOAD RECORD:C212([CrtAddrFile:19])
vText2:=$TempvText2