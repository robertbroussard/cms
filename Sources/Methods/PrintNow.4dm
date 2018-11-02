//%attributes = {"publishedWeb":true}
  //G-Proc: PrintNow
_O_C_INTEGER:C282($i;$Print;$Temp;$OK1;$OK2;v2ndLtr;vFamFlag)
_O_C_STRING:C293(35;$Dis1;$Dis2)
_O_C_STRING:C293(1;$CR)
C_TEXT:C284(vFamStyle)
RELATE MANY:C262([IntakeFile:1]CaseNo:1)
vPInitials:=$1
$OK1:=1
$OK2:=1
vFamStyle:=""
v2ndLtr:=0
vFamFlag:=0
CREATE EMPTY SET:C140([DailyLtrFile:14];"PrintSet")
FIRST RECORD:C50([DailyLtrFile:14])
For ($i;1;Records in selection:C76([DailyLtrFile:14]))
	If (CheckRecord =True:C214)
		ADD TO SET:C119([DailyLtrFile:14];"PrintSet")
	Else 
		DoError (4;[DailyLtrFile:14]Initials:6;vPInitials)
		DELETE RECORD:C58([DailyLtrFile:14])
	End if 
	NEXT RECORD:C51([DailyLtrFile:14])
End for 
USE SET:C118("PrintSet")
CREATE EMPTY SET:C140([DailyLtrFile:14];"EnvelopeSet")
CREATE EMPTY SET:C140([DailyLtrFile:14];"LSOSet")
For ($i;1;Records in selection:C76([DailyLtrFile:14]))
	If ([DailyLtrFile:14]PrintEnv:21=True:C214)
		ADD TO SET:C119([DailyLtrFile:14];"EnvelopeSet")
	End if 
	If ([DailyLtrFile:14]LtrType:2="JUMP LSO@")
		ADD TO SET:C119([DailyLtrFile:14];"LSOSet")
	End if 
	NEXT RECORD:C51([DailyLtrFile:14])
End for 
DIFFERENCE:C122("PrintSet";"LSOSet";"PrintSet")
USE SET:C118("PrintSet")
If ([DailyLtrFile:14]DLFCaseNo:1[[9]]#"F")
	$Print:=Records in set:C195("PrintSet")+Records in set:C195("LSOSet")
	ALERT:C41("Preparing to print "+String:C10($Print)+" letters.")
End if 
If (Records in set:C195("LSOSet")>0)
	USE SET:C118("LSOSet")
	ORDER BY:C49([DailyLtrFile:14]DLFCaseNo:1;>)
	$Temp:=0
	ACCUMULATE:C303($Temp)
	BREAK LEVEL:C302(1;0)
	FORM SET OUTPUT:C54([DailyLtrFile:14];"LSO Letters")
	PAGE SETUP:C299([DailyLtrFile:14];"LSO Letters")
	PRINT SELECTION:C60([DailyLtrFile:14];*)
	If (OK=1)
		$OK2:=1
	Else 
		$OK2:=0
	End if 
End if 
USE SET:C118("PrintSet")
  //   BUILD FAMILY RECORD SET OMITTING ATTORNEY RECORDS FOR LETTERS
  //       WHILE KEEPING ENVELOPES     6/96
If ([DailyLtrFile:14]DLFCaseNo:1[[9]]="F")
	CREATE EMPTY SET:C140([DailyLtrFile:14];"FamilySet")
	vFamStyle:=[DailyLtrFile:14]Style:12  // FAMILY LISTS ALL ADDL PARTIES IN STYLE
	For ($i;1;Records in selection:C76([DailyLtrFile:14]))
		If ([DailyLtrFile:14]PartyType:5[[1]]#"A")
			ADD TO SET:C119([DailyLtrFile:14];"FamilySet")
			If (([DailyLtrFile:14]PartyType:5#"C1") & ([DailyLtrFile:14]PartyType:5#"R1") & ([DailyLtrFile:14]LtrType:2="@(E)"))
				vFamStyle:=vFamStyle+" and "+[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3
			End if 
		End if 
		NEXT RECORD:C51([DailyLtrFile:14])
	End for 
	USE SET:C118("FamilySet")
End if 
  //
vFamFlag:=0
If ([DailyLtrFile:14]DLFCaseNo:1[[9]]="F")
	vFamFlag:=1  // FLAG RECORD AS FAMILY 
	$Print:=Records in set:C195("FamilySet")
	ALERT:C41("Preparing to print "+String:C10($Print)+" letters and "+String:C10($Print)+" copies.")
End if 
ORDER BY:C49([DailyLtrFile:14]DLFCaseNo:1;>)
$Temp:=0
ACCUMULATE:C303($Temp)
BREAK LEVEL:C302(1;0)
If ([DailyLtrFile:14]DLFCaseNo:1[[9]]="F")
	FORM SET OUTPUT:C54([DailyLtrFile:14];"DLFFamilyLtr")  // ALLOWS VARIABLE FRAME PRINT IN FAMILY LETTER
Else 
	FORM SET OUTPUT:C54([DailyLtrFile:14];"DFLTestLtr")
End if 
If (([DailyLtrFile:14]LtrType:2="Notice (E)") & ([DailyLtrFile:14]DLFCaseNo:1[[9]]="C"))
	FORM SET OUTPUT:C54([DailyLtrFile:14];"DLFNoticeC")  // COMMUNITY HEARING NOTICES CHG 6/98
End if 
If (([DailyLtrFile:14]LtrType:2="Prob Notice (E)") & ([DailyLtrFile:14]DLFCaseNo:1[[9]]="P"))
	FORM SET OUTPUT:C54([DailyLtrFile:14];"DLFNoticeC")  // PROBATION HEARING NOTICES CHG 10/98
End if 
If ([DailyLtrFile:14]LtrType:2="Family N@")
	FORM SET OUTPUT:C54([DailyLtrFile:14];"DLFFamNotice")  // REMOVED 2 LINES FROM STD LAYOUT
End if 
PAGE SETUP:C299([DailyLtrFile:14];"DFLTestLtr")
PRINT SELECTION:C60([DailyLtrFile:14];*)
If (OK=1)
	$OK1:=1
Else 
	$OK1:=0
End if 
  //  PRINT 2ND COPY OF FAMILY LETTERS
v2ndLtr:=0
If (vFamFlag=1)
	v2ndLtr:=1  // USE IN CONTROL FLD SCRIPT IN DFLTESTLTR LAYOUT  
	USE SET:C118("FamilySet")
	ORDER BY:C49([DailyLtrFile:14]DLFCaseNo:1;>)
	$Temp:=0
	ACCUMULATE:C303($Temp)
	BREAK LEVEL:C302(1;0)
	If ([DailyLtrFile:14]DLFCaseNo:1[[9]]="F")
		FORM SET OUTPUT:C54([DailyLtrFile:14];"DLFFamilyLtr")
	Else 
		FORM SET OUTPUT:C54([DailyLtrFile:14];"DFLTestLtr")
	End if 
	If ([DailyLtrFile:14]LtrType:2="Family N@")
		FORM SET OUTPUT:C54([DailyLtrFile:14];"DLFFamNotice")  // REMOVED 2 LINES FROM STD LAYOUT
	End if 
	PAGE SETUP:C299([DailyLtrFile:14];"DFLTestLtr")
	PRINT SELECTION:C60([DailyLtrFile:14];*)
End if 
USE SET:C118("EnvelopeSet")
$CR:=Char:C90(13)
$Dis1:=("Preparing to print "+String:C10(Records in set:C195("EnvelopeSet"))+" envelopes.")
$Dis2:=$CR+"Place envelopes into the printer."
ALERT:C41($Dis1+$Dis2)
PAGE SETUP:C299([DailyLtrFile:14];"Envelopes")
If (vPrinter360="Y")  // SET IN STARTUP PROC IF USING LASERWRITER 360 - CENTER ENVELOPE ALIGN.
	PAGE SETUP:C299([DailyLtrFile:14];"EnvelopeCenter")
	FORM SET OUTPUT:C54([DailyLtrFile:14];"EnvelopeCenter")
Else 
	FORM SET OUTPUT:C54([DailyLtrFile:14];"Envelopes")
End if 
PRINT SELECTION:C60([DailyLtrFile:14])
UNION:C120("PrintSet";"LSOSet";"PrintSet")
USE SET:C118("PrintSet")
FIRST RECORD:C50([DailyLtrFile:14])
If ((OK=1) & ($OK1=1)) & ($OK2=1)
	For ($i;1;Records in selection:C76([DailyLtrFile:14]))
		DoRptEntry ("O";vPInitials)  //DISCONTINUED 10/94 - BUILDS LETTER REPORT FILE - REINSTATE 1/14/97
		NEXT RECORD:C51([DailyLtrFile:14])
	End for 
	EnterNotesText ("P";$1)
Else 
	For ($i;1;Records in selection:C76([DailyLtrFile:14]))
		DoError (5;$1;$1)
		NEXT RECORD:C51([DailyLtrFile:14])
	End for 
End if 
PAGE SETUP:C299([DailyLtrFile:14];"DFLTestLtr")
USE SET:C118("PrintSet")
DELETE SELECTION:C66([DailyLtrFile:14])
CLEAR SET:C117("EnvelopeSet")
CLEAR SET:C117("LSOSet")
CLEAR SET:C117("PrintSet")
CLEAR SET:C117("FamilySet")