//%attributes = {}
  //
  // ----------------------------------------------------
  // User name (OS): Administrator
  // Date and time: 01/22/14, 13:38:28
  // ----------------------------------------------------
  // Method: Print_Dispo_Master
  // Description: Will print all types of dispositions. Presenting the user with a single unified input form and printing a single inified output form (report).
  // 
  //
  // Parameters
  // ----------------------------------------------------

  // (P) FamilyDispo - Called by DefaultLtrs to print Family Disposition
  //Modified 1/22/14 to accomodate ALL Dispositions

C_TEXT:C284(vFamHdr3;vResult;vJudDist;vMed1;vMed2;vIVDCourt)
C_BOOLEAN:C305(vDRO_SW;vMedSw;vIsGalveston)
C_TEXT:C284(vStyle)
C_DATE:C307(vMediation_Date)

vDRO_SW:=False:C215
vMedSw:=False:C215
vIsGalveston:=False:C215
vAND:=""

SET WINDOW TITLE:C213("Family Disposition Edit and Print")
FORM SET OUTPUT:C54([DailyLtrFile:14];"Disposition_Master")
vCaseNo:=[IntakeFile:1]CaseNo:1
vDCtPd:=[IntakeFile:1]Ct_PdNo:5  //cause number 
vFullNameC:=[IntakeFile:1]CFName:7+" "+[IntakeFile:1]CLName:6
vFullNameR:=[IntakeFile:1]RFName:12+" "+[IntakeFile:1]RLName:11
vPrintDate:=String:C10(Current date:C33;5)
vJudDist:=[IntakeFile:1]RefBy:16
vCourt:="IN THE DISTRICT COURT OF"
vCounty:="HARRIS COUNTY, TEXAS"
vSquiggly1:="§"
vSquiggly2:="§"
  //FamGetParties 
vStyle:=vFullNameC+" and "+vFullNameR
vMediation_Date:=!00-00-00!
vComments:=""
vReasonTXT:=""
vMed1:=""
vMed2:=""

DIALOG:C40([DailyLtrFile:14];"FamDispo_In")

If (ok=1)
	
	  //savecheckboxes_4d bug 7/22/10
	  //SCB_cRsn1:=cRsn1
	  //SCB_cRsn2:=cRsn2
	  //SCB_cRsn3:=cRsn3
	  //SCB_cRsn4:=cRsn4
	  //SCB_cRsn5:=cRsn5
	  //SCB_cRsn6:=cRsn6
	  //SCB_cRsn7:=cRsn7
	  //SCB_cRsn8:=cRsn8
	C_BOOLEAN:C305(SCB_vMediated;vMediated;SCB_vSettled;vSettled;SCB_vPartialSettle;vPartialSettle;SCB_vImpasse;vImpasse;SCB_vMatterExceeds;vMatterExceeds;SCB_vMatterResolved;vMatterResolved;SCB_vNotMediated;vNotMediated;SCB_vRefused;vRefused;SCB_vDeclinedAttend;vDeclinedAttend;SCB_vNoShow;vNoShow;SCB_vNoContact;vNoContact)
	SCB_vMediated:=vMediated
	SCB_vSettled:=vSettled
	SCB_vPartialSettle:=vPartialSettle
	SCB_vImpasse:=vImpasse
	SCB_vMatterExceeds:=vMatterExceeds
	SCB_vMatterResolved:=vMatterResolved
	SCB_vNotMediated:=vNotMediated
	SCB_vRefused:=vRefused
	SCB_vDeclinedAttend:=vDeclinedAttend
	SCB_vNoShow:=vNoShow
	SCB_vNoContact:=vNoContact
	
	Print form:C5([DailyLtrFile:14];"Disposition_Master")
	
	
	PAGE BREAK:C6
	[IntakeFile:1]InterimCon:30:=[IntakeFile:1]InterimCon:30+Char:C90(13)+"  Disposition printed "+String:C10(Current date:C33;4)+"."
End if 

SET WINDOW TITLE:C213("DRC Case Management System")
