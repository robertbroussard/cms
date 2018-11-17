//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): robert
  // Date and time: 11/16/18, 15:22:39
  // ----------------------------------------------------
  // Method: CreateFamilyRecord
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

  //From Family button object method.
  //looks like we better created this familyFile record.
  //Looks like old process vars are no longer used. And just two family fields.


  // Family button on Main Screen - creates FamilyFile record if needed;.
  // loads atty data for display;  loads 1st 3 referrals
  //
  //vATCNam:=""  // BLANK DISPLAY FIELDS BETWEEN RECORDS
  //vATCAddr:=""
  //vATCPhone:=""
  //vATRNam:=""
  //vATRAddr:=""
  //vATRPhone:=""
  //
QUERY:C277([FamilyFile:20];[FamilyFile:20]FCaseNo:1=[IntakeFile:1]CaseNo:1)
If (Records in selection:C76([FamilyFile:20])=0)
	CREATE RECORD:C68([FamilyFile:20])  // CREATE FAMILYFILE RECD FOR FAM INTAKE
	[FamilyFile:20]FCaseNo:1:=[IntakeFile:1]CaseNo:1
	SAVE RECORD:C53([FamilyFile:20])
End if 
  // 
  //_O_ALL SUBRECORDS([IntakeFile]AddPartyFile)  // SEARCH ADDL PARTY SUBRECDS FOR ATTY
  //If (_O_Records in subselection([IntakeFile]AddPartyFile)>0)
  //For ($i;1;_O_Records in subselection([IntakeFile]AddPartyFile))
  //Case of 
  //: ([IntakeFile]AddPartyFile'APType="ATC@")
  //vATCNam:=[IntakeFile]AddPartyFile'FirstName+" "+[IntakeFile]AddPartyFile'LastName
  //If ([IntakeFile]AddPartyFile'APStAddress>"")
  //vATCAddr:=[IntakeFile]AddPartyFile'APStAddress+", "+[IntakeFile]AddPartyFile'APCity+",  "+[IntakeFile]AddPartyFile'ApState+"  "+[IntakeFile]AddPartyFile'APZip
  //Else 
  //vATCAddr:=""
  //End if 
  //vATCPhone:=[IntakeFile]AddPartyFile'WPhone
  //: ([IntakeFile]AddPartyFile'APType="ATR@")
  //vATRNam:=[IntakeFile]AddPartyFile'FirstName+" "+[IntakeFile]AddPartyFile'LastName
  //vATRAddr:=[IntakeFile]AddPartyFile'APStAddress+", "+[IntakeFile]AddPartyFile'APCity+",  "+[IntakeFile]AddPartyFile'ApState+"  "+[IntakeFile]AddPartyFile'APZip
  //If ([IntakeFile]AddPartyFile'APStAddress>"")
  //vATRAddr:=[IntakeFile]AddPartyFile'APStAddress+", "+[IntakeFile]AddPartyFile'APCity+",  "+[IntakeFile]AddPartyFile'ApState+"  "+[IntakeFile]AddPartyFile'APZip
  //Else 
  //vATRAddr:=""
  //End if 
  //vATRPhone:=[IntakeFile]AddPartyFile'WPhone
  //End case 
  //_O_NEXT SUBRECORD([IntakeFile]AddPartyFile)
  //End for 
  //End if 
  //  //
  //vrefer1:=""
  //vrefer2:=""
  //vrefer3:=""
  //_O_ALL SUBRECORDS([IntakeFile]Referrals)  // DISPLAY 1ST 3 REFERRAL SUBRECDS
  //If (_O_Records in subselection([IntakeFile]Referrals)>0)
  //For ($i;1;_O_Records in subselection([IntakeFile]Referrals))
  //If ($i<4)  // ONLY 3 SLOTS ON LAYOUT
  //$RefPtr:=Get pointer("vrefer"+String($i))
  //$RefPtr->:=[IntakeFile]Referrals'Referral
  //End if 
  //_O_NEXT SUBRECORD([IntakeFile]Referrals)
  //End for 
  //End if 
  //vFNamC4:=[IntakeFile]CFName+" "+[IntakeFile]CLName  //  LOAD VARIABLES FOR SCREEN 1
  //vFNamR4:=[IntakeFile]RFName+" "+[IntakeFile]RLName
  //CtEditZip (->[IntakeFile]CZip)  //REMOVE EDITING CHARACTERS & SPACES
  //vFZipC4:=[IntakeFile]CCity+", "+[IntakeFile]CState+" "+vZip
  //CtEditZip (->[IntakeFile]RZip)
  //vFZipR4:=[IntakeFile]RCity+", "+[IntakeFile]RState+" "+vZip
  //  //
  //SET WINDOW TITLE("Family Mediation Screen 1")
  //FORM GOTO PAGE(4)