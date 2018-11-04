//%attributes = {"publishedWeb":true}
  // (P) FamilyDispo - Called by DefaultLtrs to print Family Disposition
  //Modified 1/22/14 to accomodate ALL Dispositions

C_TEXT:C284(vFamHdr3;vResult;vJudDist;vMed1;vMed2;vIVDCourt)
C_BOOLEAN:C305(vDRO_SW;vMedSw;vIsGalveston)
C_TEXT:C284(vStyle)
vDRO_SW:=False:C215
vMedSw:=False:C215
vIsGalveston:=False:C215
vAND:=""
If ([IntakeFile:1]Program:32)="F"  // MUST BE A FAMILY CASE
	SET WINDOW TITLE:C213("Family Disposition Edit and Print")
	FORM SET OUTPUT:C54([DailyLtrFile:14];"FamDispo_OutN")
	vCaseNo:=[IntakeFile:1]CaseNo:1
	vDCtPd:=[IntakeFile:1]Ct_PdNo:5
	vFullNameC:=[IntakeFile:1]CFName:7+" "+[IntakeFile:1]CLName:6
	vFullNameR:=[IntakeFile:1]RFName:12+" "+[IntakeFile:1]RLName:11
	vPrintDate:=String:C10(Current date:C33;5)
	vJudDist:=[IntakeFile:1]RefBy:16
	vCourt:="IN THE DISTRICT COURT OF"
	vCounty:="HARRIS COUNTY, TEXAS"
	vSquiggly1:="§"
	vSquiggly2:="§"
	If (Position:C15("IV-D";vJudDist)>0)
		vIVDCourt:=Uppercase:C13(Substring:C12(vJudDist;12))
		vSquiggly:="§"
	Else 
		vIVDCourt:=""  // LABEL IV-D COURTS ON LAST LINE OF HEADER
		vSquiggly:=""
	End if 
	FamDROCourt 
	If (vNoCourt=0)
		vComments:=""
		vMed1:=""
		vMed2:=""
		vResult:=""
		FamMediate 
		_O_ALL SUBRECORDS:C109([IntakeFile:1]AddPartyFile:21)
		FamGetParties 
		If ((vStyle>"") & (vJudDist[[1]]#"J"))
			vAND:="AND "
		End if 
		  //
		If (vIsGalveston=True:C214)
			vJudDist:="Galveston"
		End if 
		$While:=1
		While ($while=1)
			$While:=0
			DIALOG:C40([DailyLtrFile:14];"FamDispo_In")
			
			  //savecheckboxes_4d bug 7/22/10
			SCB_cRsn1:=cRsn1
			SCB_cRsn2:=cRsn2
			SCB_cRsn3:=cRsn3
			SCB_cRsn4:=cRsn4
			SCB_cRsn5:=cRsn5
			SCB_cRsn6:=cRsn6
			SCB_cRsn7:=cRsn7
			SCB_cRsn8:=cRsn8
			
			If (OK=1)
				If (bMedSwN=1)  // IF OK BUTTON HIT AND NO MEDIATION THEN MUST SELECT REASON
					vMedSw:=False:C215
					If ((cRsn1+cRsn2+cRsn3+cRsn4+cRsn5+cRsn6+cRsn7+cRsn8)=0)  // BUTTON = 1 IF SELECTED
						$While:=1
						ALERT:C41("Please enter a reason for the cancelled mediation from the list of check boxes")
					End if 
				End if 
			End if 
		End while 
		  // BUILD AND PRINT DISPOS
		If (OK=1)
			If (vDRO_Sw=True:C214)  // DRO DISPO IS SLIGHTLY DIFFERENT
				vFamHdr1:="Disposition to Referring Agency"
				vFamHdr2:="To:  Friend of the Court:"
				vFDCC1:="c:  "+vJudDist+" District Court"
				vFDCC2:="c:  file"
			Else 
				vFamHdr1:="Disposition to Referring Court"  // STANDARD DISPO
				vFamHdr2:="To:  Court Coordinator:"
				vFDCC1:="c:  file"
				vFDCC2:=""
			End if 
			If (vMedSw=True:C214)  // MEDIATION WAS HELD
				vFamHdr3:="The above numbered and styled case was mediated by "+vMed1
				If (vMed2>"")
					vFamHdr3:=vFamHdr3+" and "+vMed2
				End if 
				vFamHdr3:=vFamHdr3+" through the DRC Family Mediation Program on "+vOtherDate
				vFamHdr3:=vFamHdr3+" and resulted in:  "
			Else   // MEDIATION WAS NOT HELD
				vFamHdr3:="The above numbered and styled case was not mediated"
				vFamHdr3:=vFamHdr3+" and is being referred back to you because: "
			End if 
			vFamHdr3:=Replace string:C233(vFamHdr3;"  ";" ")  // REMOVE DOUBLE SPACES      
			  //PRINT SETTINGS
			If (vJudDist="JP@")  // TEST FOR JP COURT FORMAT
				If (vMedSw=True:C214)
					Print form:C5([DailyLtrFile:14];"FamDispo_JPY")  // COPY FOR COURT - MEDIATION  HELD
					Print form:C5([DailyLtrFile:14];"FamDispo_JPY")  // COPY FOR DRC
				Else 
					Print form:C5([DailyLtrFile:14];"FamDispo_JPN")  // COPY FOR COURT - MEDIATION  NOT HELD
					Print form:C5([DailyLtrFile:14];"FamDispo_JPN")  // COPY FOR DRC
				End if 
			Else 
				If (vIsGalveston=True:C214)
					vCourt:="IN THE COUNTY COURT AT LAW 2"
					vCounty:="GALVESTON COUNTY, TEXAS"
					vJudDist:=""
					vSquiggly:=""
					vSquiggly1:=""
					vSquiggly2:=""
				End if 
				If (Substring:C12(vJudDist;1;3)="300")
					vCounty:="BRAZORIA COUNTY, TEXAS"
				End if 
				If (Substring:C12(vJudDist;1;3)="328")
					vCounty:="FORT BEND COUNTY, TEXAS"
				End if 
				If (Substring:C12(vJudDist;1;3)="214")
					vCounty:="NUECES COUNTY, TEXAS"
				End if 
				If ([IntakeFile:1]RefBy:16="Fourteenth Crt Appls")
					vCourt:="IN THE COURT OF APPEALS"
					vCounty:="STATE OF TEXAS"
					vJudDist:="14TH SUPREME JUDICIAL DISTRICT"
				End if 
				If ([IntakeFile:1]RefBy:16="CCL Wash Cty")
					vCourt:="IN THE COUNTY COURT AT LAW "
					vCounty:="WASHINGTON COUNTY, TEXAS"
					vJudDist:=""
					vSquiggly1:=""
					vSquiggly2:=""
				End if 
				If (vMedSw=True:C214)
					Print form:C5([DailyLtrFile:14];"FamDispo_OutY")
					Print form:C5([DailyLtrFile:14];"FamDispo_OutY")
					If (rDROSwY=1)
						Print form:C5([DailyLtrFile:14];"FamDispo_OutY")  //  COPY FOR REFERRING AGENCY
					End if 
				Else 
					
					Print form:C5([DailyLtrFile:14];"FamDispo_OutN")
					Print form:C5([DailyLtrFile:14];"FamDispo_OutN")
					If (rDROSwY=1)
						Print form:C5([DailyLtrFile:14];"FamDispo_OutN")  //  COPY FOR REFERRING AGENCY
					End if 
				End if 
			End if 
			PAGE BREAK:C6
			[IntakeFile:1]InterimCon:30:=[IntakeFile:1]InterimCon:30+"  Family Disposition printed for: "
			[IntakeFile:1]InterimCon:30:=[IntakeFile:1]InterimCon:30+vFullNameR+String:C10(Current date:C33;4)+"."
		End if   // OK=0    DON'T PRINT
	End if 
Else 
	ALERT:C41("This is not a FAMILY case;  you cannot use this option.")
End if 
SET WINDOW TITLE:C213("DRC Case Management System")
CLEAR SET:C117("Dispo_Set")