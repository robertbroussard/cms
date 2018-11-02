//%attributes = {"publishedWeb":true}
  //
  //  G-Proc: CourtForms - from DefaultLtrs - for Litigation Dept
  //
_O_C_INTEGER:C282($i;$CtrProSe;$CtrMed;vWScol;vWSLine;$Pcol;$Dcol)
_O_C_STRING:C293(80;vwork)
_O_C_STRING:C293(3;vWSType)
_O_C_STRING:C293(12;vZip)
C_TEXT:C284(vCtStyle)
C_DATE:C307(vCtDktDate)
  //If (vBlank=1)
vWSType:=""
$CtrProSe:=0
$CtrAtty:=0
$CtrMed:=0
$Pcol:=0
$Dcol:=0
$MPrt:=0
  //  
  //  SAVE DATA USED IN FORMS
  //
Case of 
	: ([IntakeFile:1]Program:32="L")
		FORM SET INPUT:C55([CrtAddrFile:19];"CtWorksheetMed")
	: ([IntakeFile:1]Program:32)="A"
		FORM SET INPUT:C55([CrtAddrFile:19];"CtWorkSheetArb")
	: ([IntakeFile:1]Program:32)="M"
		FORM SET INPUT:C55([CrtAddrFile:19];"CtWorksheetMSC")
End case 
vCtStyle:=[IntakeFile:1]CaseStyle:23
CtDivideLine (->vCtStyle;->vTemp1;->vTemp2;80)
vCtStyle1:=vTemp1
vCtStyle2:=vTemp2
vCtCauseNo:=[IntakeFile:1]Ct_PdNo:5
vCtPlaint:=[IntakeFile:1]CFName:7+" "+[IntakeFile:1]CLName:6
vCtDefend:=[IntakeFile:1]RFName:12+" "+[IntakeFile:1]RLName:11
vCtLocFirm:=[IntakeFile:1]MedLocFrm:49
vCtLocAddr:=[IntakeFile:1]MedLocAdr:50
vMailWksht:=[IntakeFile:1]DateMail:51
vTrialDate:=[IntakeFile:1]DateTrial:54
RELATE ONE:C42([IntakeFile:1]DisputeCode:22;[DisputeFile:4]DisCode:1)
vCtTypeCase:=[DisputeFile:4]DisName:2
RELATE MANY:C262([IntakeFile:1]CaseNo:1)
If (Records in selection:C76([DocketFile:6])>1)  //GET MOST RECENT DATE IF RESCHEDULED
	ORDER BY:C49([DocketFile:6];[DocketFile:6]DocketDate:2)
	LAST RECORD:C200([DocketFile:6])
End if 
vCtDktDate:=[DocketFile:6]DocketDate:2
vCtTime:=[DocketFile:6]TimeSlot:3

If (vCtTime="")
	  //BEEP
	  //ALERT("NO TIME VALUE"
	  //TRACE
End if 

RELATE ONE:C42([IntakeFile:1]RefBy:16;[CrtAddrFile:19]CCRefBy:1)
If (Records in selection:C76([CrtAddrFile:19])<1)
	ALERT:C41("There is no Court Address record for this referral")
	vCtCCRefBy:=""
	vCtCCName:=""
	vCtCourtNam:=""
	vCtCrtName1:=[IntakeFile:1]RefBy:16  //reactivated RJB 6/9/10
	  //vCtCrtName1:=""
	vCtCause:=""
	vCtCCAddr1:=""
	vCtCCAddr2:=""
	vCtCCPhone:=""
	vCtTitle1:=""
	vCtTitle2:=""
	vCtTitle3:=""
	vCtTitle4:=""
Else 
	vCtCCRefBy:=[CrtAddrFile:19]CCRefBy:1
	vCtCCName:=[CrtAddrFile:19]CCName:2
	vCtCourtNam:=[CrtAddrFile:19]CCCtName:4
	vCtCause:=[CrtAddrFile:19]CCCtName:4+" / "+[IntakeFile:1]Ct_PdNo:5
	vCtCrtName1:=[CrtAddrFile:19]CCCtName:4
	vCtCCAddr1:=[CrtAddrFile:19]CCAddr1:5
	vCtCCAddr2:=[CrtAddrFile:19]CCAddr2:6
	vCtCCPhone:=[CrtAddrFile:19]CCPhone:7
	vCtTitle1:=Char:C90(164)+"    "+[CrtAddrFile:19]CCTitle1:8
	vCtTitle2:=Char:C90(164)+"    "+[CrtAddrFile:19]CCTitle2:9
	vCtTitle3:=Char:C90(164)+"    "+[CrtAddrFile:19]CCTitle3:10
	vCtTitle4:=Char:C90(164)+"    "+[CrtAddrFile:19]CCTitle4:11
	v1sec:=Char:C90(164)  //LOAD SECTION MARK:  §
	v2sec:=Char:C90(164)
	v3sec:=Char:C90(164)
	If ([CrtAddrFile:19]CCTitle4:11="")
		vCtTitle4:=""
		v3Sec:=""
	End if 
End if 
_O_ALL SUBRECORDS:C109([IntakeFile:1]AddPartyFile:21)
If (_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21)<1)
	ALERT:C41("There are no subrecords (Attorneys)")
Else 
	  //  
	vWSType:="P"  //  INITIALIZE COUNTERS FOR CLEARING WORKSHEET
	$pCol:=1
	vWSLine:=1
	For ($i;1;72)  //  LOOP THRU ALL ADDRESS LINES TO CLEAR THEM
		ptrWS:=Get pointer:C304("vLine"+vWSType+String:C10($pCol)+String:C10(vWSLine))
		ptrWS->:=""
		vWSLine:=vWSLine+1
		If (vWSLine>8)
			vWSLine:=1
			$pCol:=$pCol+1
		End if 
		If ($pCol>3)
			$pCol:=1
			vWSType:="D"  //  2ND ROW OF 3 COLUMNS IS FOR DEFENDANT
			If ($i>47)
				vWSType:="M"  //  3RD ROW OF 3 COLUMNS IS FOR MEDIATOR
			End if 
		End if 
	End for   //  WORKSHEET LINES ARE BLANKED OUT
	vProSeP1:=""  //CLEAR PRO SE LABELS ON WORKSHEET
	vProSeP2:=""
	vProSeP3:=""
	vProSeD1:=""
	vProSeD2:=""
	vProSeD3:=""
	vWSType:=""  //  RESET COUNTERS
	$pCol:=0
	vWSLine:=0
	  //
	_O_FIRST SUBRECORD:C61([IntakeFile:1]AddPartyFile:21)
	vn2:=0
	$CtrProSe:=0
	CLEAR VARIABLE:C89(aEnvelope)
	_O_ARRAY STRING:C218(60;aEnvelope;5;9)  //CREATE ARRAY FOR STORING ENVELOPE DATA
	For ($i;1;_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21))
		If (Length:C16([IntakeFile]AddPartyFile'APType)>2)
			vWSType:=Substring:C12([IntakeFile]AddPartyFile'APType;3;1)
		Else 
			vWSType:=Substring:C12([IntakeFile]AddPartyFile'APType;2;1)  //$Type = "P" or "D"
		End if 
		If (vWSType#"P") & (vWSType#"D")
			ALERT:C41("Additional Party "+[IntakeFile]AddPartyFile'LastName+(Char:C90(13))+" has bad Type: "+[IntakeFile]AddPartyFile'APType)
		Else 
			  //      
			  //MOVE ADD PRTY (ATTY) DATA TO SLOT 1, 2, OR 3 ON MED. WS FOR PL OR DEF
			  //
			CtEditZip (->[IntakeFile]AddPartyFile'APZip)  //REMOVE EDITING CHARACTERS & SPACES
			vWSLine:=0
			If (vWSType="P") & ($Pcol<3)  //ONLY ROOM FOR 3
				$Pcol:=$Pcol+1  //TELLS WHICH COLUMN IS BEING LOADED
				vWSCol:=$Pcol
				$Hokay:=1
			End if 
			If (vWSType="D") & ($Dcol<3)  //ONLY ROOM FOR 3
				$Dcol:=$Dcol+1  //TELLS WHICH COLUMN IS BEING LOADED
				vWSCol:=$Dcol
				$Hokay:=1
			End if 
			If ($Hokay=1)  //IS RECORD VALID FOR PRINTING?
				vn1:=0  //5 FIELDS OR ARRAYS
				vn2:=vn2+1  //9 ENVELOPE RECORDS OR # ARRAY OCCURRENCES
				$Hokay:=0
				vwork:=[IntakeFile]AddPartyFile'FirstName+" "+[IntakeFile]AddPartyFile'LastName
				CtBuildWS (1)
				CtEnvelope 
				vwork:=[IntakeFile]AddPartyFile'APFirm
				CtBuildWS (1)
				CtEnvelope 
				vwork:=[IntakeFile]AddPartyFile'APStAddress
				CtBuildWS (1)
				CtEnvelope 
				vwork:=[IntakeFile]AddPartyFile'APCity+", "+[IntakeFile]AddPartyFile'ApState+" "+vZip
				CtBuildWS (0)
				CtEnvelope 
				vwork:=[IntakeFile]AddPartyFile'WPhone+" Fx: "+[IntakeFile]AddPartyFile'FaxNumber
				If (Length:C16([IntakeFile]AddPartyFile'WPhone)>0) & (Length:C16([IntakeFile]AddPartyFile'WPhone)#10)
					ALERT:C41("Work phone number is not 10 digits for "+[IntakeFile]AddPartyFile'LastName)
				Else 
					If (Length:C16([IntakeFile]AddPartyFile'WPhone)>0)
						vwork:=Insert string:C231(vwork;"/";4)
						vwork:=Insert string:C231(vwork;"-";8)
					End if 
				End if 
				If (Length:C16([IntakeFile]AddPartyFile'FaxNumber)>0) & (Length:C16([IntakeFile]AddPartyFile'FaxNumber)#10)
					ALERT:C41("Fax number is not 10 digits for "+[IntakeFile]AddPartyFile'LastName)
				Else 
					If (Length:C16([IntakeFile]AddPartyFile'FaxNumber)>0)
						vwork:=Insert string:C231(vwork;"/";21)
						vwork:=Insert string:C231(vwork;"-";25)
					Else 
						vwork:=Replace string:C233(vwork;"Fx:";"   ")
					End if 
				End if 
				CtBuildWS (0)
				If ([IntakeFile]AddPartyFile'APProSe=True:C214)
					ptrWS:=Get pointer:C304("vProSe"+vWSType+String:C10(vWSCol))
					ptrWS->:="Pro Se"
					$CtrProSe:=$CtrProSe+1
				Else 
					vAPProSe:=""
					$CtrAtty:=$CtrAtty+1
				End if 
			End if 
		End if 
		_O_NEXT SUBRECORD:C62([IntakeFile:1]AddPartyFile:21)
	End for 
End if   //END PLAINTIFF
  //  
  //  FIND MEDIATOR(S) & MOVE DATA TO MEDIATOR ADDRESS SLOTS 1, 2, & 3 ON WORKSHEET
  // 
RELATE MANY:C262([IntakeFile:1]CaseNo:1)  //SELECT RELATED DOCKET RECDS
If (Records in selection:C76([DocketFile:6])<1)
	ALERT:C41("There is no Docket for this case")
Else 
	LAST RECORD:C200([DocketFile:6])  //  PICK LATEST OF DUPLICATES
	RELATE MANY:C262([DocketFile:6]DocKey:6)  //SELECT RELATED MEDIATOR ACTIVITY RECDS
	RELATE ONE:C42([MedActFile:10]mafKey:1)  //GET TO  MEDIATOR FILE RECD
	If (Records in selection:C76([MedActFile:10])>1)  // PUT ADMIN. MODERATOR ON TOP
		If ([MedActFile:10]mafCaseNo:3[[9]]="M")
			ORDER BY:C49([MedActFile:10];[MedActFile:10]mafDocKey:2;>;[MedActFile:10]Role_Activity:4;<)
		End if 
	End if 
	If (Records in selection:C76([MediatorFile:9])<1)
		ALERT:C41("There are no Mediators for this case")
	Else 
		FIRST RECORD:C50([MedActFile:10])
		vWSCol:=0
		vWSType:="M"
		For ($i;1;Records in selection:C76([MedActFile:10]))
			If ([MedActFile:10]mafCaseNo:3[[9]]="M")
				RELATE ONE:C42([MedActFile:10]mafKey:1)  //GET TO  MEDIATOR FILE RECD   
			End if 
			vWSLine:=0
			If (vWSCol<3)  //Only room for 3 mediators on form
				$CtrMed:=$CtrMed+1
				vn1:=0
				vn2:=vn2+1
				vWSCol:=vWSCol+1
				If (([IntakeFile:1]Program:32="M") & (vWSCol=1))  //LABEL IS IN 1ST SLOT - SKIP
					vWSLine:=vWSLine+1
				End if 
				[MediatorFile:9]State:8:=Uppercase:C13([MediatorFile:9]State:8)
				CtEditZip (->[MediatorFile:9]MedZip:9)
				vwork:=[MediatorFile:9]MFName:2+" "+[MediatorFile:9]MLName:1
				CtBuildWS (1)
				CtEnvelope 
				vwork:=[MediatorFile:9]Firm:4
				CtBuildWS (1)
				CtEnvelope 
				vwork:=[MediatorFile:9]Add1:5
				CtBuildWS (1)
				CtEnvelope 
				vwork:=[MediatorFile:9]Add2:6
				CtBuildWS (0)
				CtEnvelope 
				vwork:=[MediatorFile:9]City:7+", "+[MediatorFile:9]State:8+" "+vZip
				CtBuildWS (0)
				CtEnvelope 
				vwork:=[MediatorFile:9]WkPhone:13+" Fx: "+[MediatorFile:9]FaxNumber:16
				If (Length:C16([MediatorFile:9]WkPhone:13)>0) & (Length:C16([MediatorFile:9]WkPhone:13)#10)
					ALERT:C41("Work phone number is not 10 digits")
				Else 
					If (Length:C16([MediatorFile:9]WkPhone:13)>0)
						vwork:=Insert string:C231(vwork;"/";4)
						vwork:=Insert string:C231(vwork;"-";8)
					End if 
				End if 
				If (Length:C16([MediatorFile:9]FaxNumber:16)>0) & (Length:C16([MediatorFile:9]FaxNumber:16)#10)
					ALERT:C41("Fax number is not 10 digits")
				Else 
					If (Length:C16([MediatorFile:9]FaxNumber:16)>0)
						vwork:=Insert string:C231(vwork;"/";21)
						vwork:=Insert string:C231(vwork;"-";25)
					Else 
						vwork:=Replace string:C233(vwork;"Fx:";"   ")
					End if 
				End if 
				CtBuildWS (0)
				NEXT RECORD:C51([MedActFile:10])
				RELATE ONE:C42([MedActFile:10]mafKey:1;[MediatorFile:9]MKey:14)
			End if 
		End for 
	End if 
End if 

Case of 
	: ([IntakeFile:1]Program:32="L")
		CtPrtLitigate ($CtrAtty;$CtrProSe;$CtrMed)
	: ([IntakeFile:1]Program:32="A")
		CtPrtArbitrate ($CtrAtty;$CtrProSe;$CtrMed)
	: ([IntakeFile:1]Program:32="M")
		CtPrtModerate ($CtrAtty;$CtrProSe;$CtrMed)
End case 
UNLOAD RECORD:C212([CrtAddrFile:19])