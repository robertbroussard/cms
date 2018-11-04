//%attributes = {"publishedWeb":true}
  //G-Method: PrintCFK: Print an envelope for all parties and a letter for all

  // parties except attorneys. {;=)


  //Modified by Robert J. Broussard <robert@usersoft.com>

  //UserSoft Technology <www.usersoft.com>

  //Modified: 9/3/02, 12/17/04


C_LONGINT:C283($i;$Temp)  //Mod RJB 9/3/02

C_TEXT:C284($Msg1;$Msg2;$Msg3)  //Mod RJB 9/3/02

C_TEXT:C284($Style1;$Style2;$Style3)
C_TEXT:C284(vCFKStyle;vDLFText)
  //

RELATE MANY:C262([IntakeFile:1]CaseNo:1)
vPInitials:=$1
CREATE SET:C116([DailyLtrFile:14];"OldDLFSet")
CREATE EMPTY SET:C140([DailyLtrFile:14];"PrintSet1")
CREATE EMPTY SET:C140([DailyLtrFile:14];"PrintSet2")
CREATE EMPTY SET:C140([DailyLtrFile:14];"AttorneySet1")
CREATE EMPTY SET:C140([DailyLtrFile:14];"AttorneySet2")
CREATE EMPTY SET:C140([DailyLtrFile:14];"EnvelopeSet")
FIRST RECORD:C50([DailyLtrFile:14])
  //

  //LOCATE KID'S NAME IN ADDN'L PARTIES, TYPE 'RK1', 'RK2', ETC

  //

_O_ALL SUBRECORDS:C109([IntakeFile:1]AddPartyFile:21)
_O_QUERY SUBRECORDS:C108([IntakeFile:1]AddPartyFile:21;[IntakeFile]AddPartyFile'APType="RK@")
If (_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21)>0)
	$Style2:=[IntakeFile]AddPartyFile'FirstName+" "+[IntakeFile]AddPartyFile'LastName
Else 
	ALERT:C41("There is no Additional Party for the child")
End if 
$style1:="Style:  "+[IntakeFile:1]Ct_PdNo:5+";  In the Interest of "
$Style3:=";  in the 314th District Court of Harris County, Texas "  //mod 12/17/04 rjb

vCFKStyle:=$Style1+$Style2+$Style3
  //

For ($i;1;Records in selection:C76([DailyLtrFile:14]))
	If (CheckRecord =True:C214)
		Case of 
			: ([DailyLtrFile:14]PartyType:5="C1")
				ADD TO SET:C119([DailyLtrFile:14];"PrintSet1")  // SAVE LETTER RECDS
				
				  //ADD TO SET([DailyLtrFile];"PrintSet2")  ` FOR EXTRA 2 COPIES
				
				ADD TO SET:C119([DailyLtrFile:14];"AttorneySet1")  // AND 2 ATTORNEY COPIES
				
				ADD TO SET:C119([DailyLtrFile:14];"AttorneySet2")
			: (([DailyLtrFile:14]PartyType:5>"C1") & ([DailyLtrFile:14]PartyType:5<"C9"))
				ADD TO SET:C119([DailyLtrFile:14];"PrintSet1")
				ADD TO SET:C119([DailyLtrFile:14];"AttorneySet1")
			: (([DailyLtrFile:14]PartyType:5>"R0") & ([DailyLtrFile:14]PartyType:5<"R9"))
				ADD TO SET:C119([DailyLtrFile:14];"PrintSet1")
				ADD TO SET:C119([DailyLtrFile:14];"AttorneySet1")
		End case 
		  //    
		
		If ([DailyLtrFile:14]PrintEnv:21=True:C214)
			If ([DailyLtrFile:14]PartyType:5[[2]]#"K")
				ADD TO SET:C119([DailyLtrFile:14];"EnvelopeSet")  // SAVE ENVELOPE RECORDS
				
			End if 
		End if 
	Else 
		DoError (4;[DailyLtrFile:14]Initials:6;vPInitials)
	End if 
	NEXT RECORD:C51([DailyLtrFile:14])
End for 
  //

USE SET:C118("PrintSet1")
$Msg1:=String:C10(Records in set:C195("PrintSet1")+(Records in set:C195("PrintSet2")*2))  //Mod RJB 9/3/02 & 12/17/04

$Msg2:=String:C10(Records in set:C195("AttorneySet1")+Records in set:C195("AttorneySet2"))  //Mod RJB 9/3/02 &12/17/04

$Msg3:=String:C10(Records in set:C195("EnvelopeSet"))
ALERT:C41("Printing "+$Msg1+" letters + "+$Msg2+" Attorney copies & "+$Msg3+" envelopes ")  //Mod RJB 9/3/02

FORM SET OUTPUT:C54([DailyLtrFile:14];"DLFNoticeCFK")  // ALLOWS VARIABLE FRAME PRINT IN CFK  LETTER

vP5:=""
  //

If ([IntakeFile:1]RefBy:16="First Crt Appls")
	$Style3:=" in the First District Court of Appeals"  //     FORCE CRT NAME   1/01  
	
	vCFKStyle:=$Style1+$Style2+$Style3
Else 
	vCourtNbr:=Substring:C12([IntakeFile:1]RefBy:16;1;3)  // GET REFERRING COURT
	
	If ((vCourtNbr>"244") & (vCourtNbr<"316"))  // CHECK REFERRING COURT
		
	Else 
		CONFIRM:C162("Invalid Court Number:  "+vCourtNbr+",  Continue?")
		  //TRACE
		
	End if 
End if 
If (OK=1)
	vDLFText:=[DailyLtrFile:14]DLFText:18
	vCFKStyle:=Replace string:C233(vCFKStyle;"314";vCourtNbr)
	vDLFText:=Replace string:C233(vDLFText;"314";vCourtNbr)
	  //
	
	PAGE SETUP:C299([DailyLtrFile:14];"DFLTestLtr")
	$Temp:=0
	BREAK LEVEL:C302(1;0)
	ACCUMULATE:C303($Temp)
	PRINT SELECTION:C60([DailyLtrFile:14];*)
	  //
	
	USE SET:C118("PrintSet2")
	PRINT SELECTION:C60([DailyLtrFile:14];*)  //  PRINT 2ND COPY FOR TYPE 'C1'
	
	PRINT SELECTION:C60([DailyLtrFile:14];*)  //  PRINT 3RD COPY FOR TYPE 'C1'
	
	  //
	
	vP5:="ATTORNEY COPY"
	USE SET:C118("AttorneySet1")
	PAGE SETUP:C299([DailyLtrFile:14];"DFLTestLtr")
	$Temp:=0
	BREAK LEVEL:C302(1;0)
	ACCUMULATE:C303($Temp)
	PRINT SELECTION:C60([DailyLtrFile:14];*)
	  //
	
	USE SET:C118("AttorneySet2")
	PRINT SELECTION:C60([DailyLtrFile:14];*)  //  PRINT 2ND  ATTY COPY FOR TYPE 'C1'
	
	  //
	
	USE SET:C118("EnvelopeSet")
	PAGE SETUP:C299([DailyLtrFile:14];"Envelopes")
	FORM SET OUTPUT:C54([DailyLtrFile:14];"Envelopes")
	PRINT SELECTION:C60([DailyLtrFile:14];*)
	  //
	
End if   // FROM WRONG-COURT TEST

  //

PAGE SETUP:C299([DailyLtrFile:14];"DFLTestLtr")
USE SET:C118("OldDLFSet")
DELETE SELECTION:C66([DailyLtrFile:14])
CLEAR SET:C117("EnvelopeSet")
CLEAR SET:C117("PrintSet1")
CLEAR SET:C117("PrintSet2")
CLEAR SET:C117("AttorneySet1")
CLEAR SET:C117("AttorneySet2")
CLEAR SET:C117("OldDLFSet")