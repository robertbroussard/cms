  // Family button on Main Screen - creates FamilyFile record if needed;.
  // loads atty data for display;  loads 1st 3 referrals
  //
vATCNam:=""  // BLANK DISPLAY FIELDS BETWEEN RECORDS
vATCAddr:=""
vATCPhone:=""
vATRNam:=""
vATRAddr:=""
vATRPhone:=""
  //
QUERY:C277([FamilyFile:20];[FamilyFile:20]FCaseNo:1=[IntakeFile:1]CaseNo:1)
If (Records in selection:C76([FamilyFile:20])=0)
	CREATE RECORD:C68([FamilyFile:20])  // CREATE FAMILYFILE RECD FOR FAM INTAKE
	[FamilyFile:20]FCaseNo:1:=[IntakeFile:1]CaseNo:1
	SAVE RECORD:C53([FamilyFile:20])
End if 
  // 
_O_ALL SUBRECORDS:C109([IntakeFile:1]AddPartyFile:21)  // SEARCH ADDL PARTY SUBRECDS FOR ATTY
If (_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21)>0)
	For ($i;1;_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21))
		Case of 
			: ([IntakeFile]AddPartyFile'APType="ATC@")
				vATCNam:=[IntakeFile]AddPartyFile'FirstName+" "+[IntakeFile]AddPartyFile'LastName
				If ([IntakeFile]AddPartyFile'APStAddress>"")
					vATCAddr:=[IntakeFile]AddPartyFile'APStAddress+", "+[IntakeFile]AddPartyFile'APCity+",  "+[IntakeFile]AddPartyFile'ApState+"  "+[IntakeFile]AddPartyFile'APZip
				Else 
					vATCAddr:=""
				End if 
				vATCPhone:=[IntakeFile]AddPartyFile'WPhone
			: ([IntakeFile]AddPartyFile'APType="ATR@")
				vATRNam:=[IntakeFile]AddPartyFile'FirstName+" "+[IntakeFile]AddPartyFile'LastName
				vATRAddr:=[IntakeFile]AddPartyFile'APStAddress+", "+[IntakeFile]AddPartyFile'APCity+",  "+[IntakeFile]AddPartyFile'ApState+"  "+[IntakeFile]AddPartyFile'APZip
				If ([IntakeFile]AddPartyFile'APStAddress>"")
					vATRAddr:=[IntakeFile]AddPartyFile'APStAddress+", "+[IntakeFile]AddPartyFile'APCity+",  "+[IntakeFile]AddPartyFile'ApState+"  "+[IntakeFile]AddPartyFile'APZip
				Else 
					vATRAddr:=""
				End if 
				vATRPhone:=[IntakeFile]AddPartyFile'WPhone
		End case 
		_O_NEXT SUBRECORD:C62([IntakeFile:1]AddPartyFile:21)
	End for 
End if 
  //
vrefer1:=""
vrefer2:=""
vrefer3:=""
_O_ALL SUBRECORDS:C109([IntakeFile:1]Referrals:26)  // DISPLAY 1ST 3 REFERRAL SUBRECDS
If (_O_Records in subselection:C7([IntakeFile:1]Referrals:26)>0)
	For ($i;1;_O_Records in subselection:C7([IntakeFile:1]Referrals:26))
		If ($i<4)  // ONLY 3 SLOTS ON LAYOUT
			$RefPtr:=Get pointer:C304("vrefer"+String:C10($i))
			$RefPtr->:=[IntakeFile]Referrals'Referral
		End if 
		_O_NEXT SUBRECORD:C62([IntakeFile:1]Referrals:26)
	End for 
End if 
vFNamC4:=[IntakeFile:1]CFName:7+" "+[IntakeFile:1]CLName:6  //  LOAD VARIABLES FOR SCREEN 1
vFNamR4:=[IntakeFile:1]RFName:12+" "+[IntakeFile:1]RLName:11
CtEditZip (->[IntakeFile:1]CZip:37)  //REMOVE EDITING CHARACTERS & SPACES
vFZipC4:=[IntakeFile:1]CCity:35+", "+[IntakeFile:1]CState:36+" "+vZip
CtEditZip (->[IntakeFile:1]RZip:42)
vFZipR4:=[IntakeFile:1]RCity:40+", "+[IntakeFile:1]RState:41+" "+vZip
  //
SET WINDOW TITLE:C213("Family Mediation Screen 1")
FORM GOTO PAGE:C247(4)