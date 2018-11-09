//%attributes = {"publishedWeb":true}
  //  // G-Procedure: ShowAtty; This proc builds array of all
  //  // Additional Party Attorneys for Family Cases, not Referred,
  //  // within the last year and a half.
  //  //
  //C_LONGINT($i;j;$Insert;vNbrRec;$NbrDays)
  //C_TEXT(vShowHdr)
  //C_TEXT(vCaseNo)
  //C_DATE($Date)
  //  //
  //ARRAY TEXT(aAName;0)
  //ARRAY TEXT(aACaseNo;0)
  //ARRAY TEXT(aACName;0)
  //ARRAY TEXT(aARName;0)
  //ARRAY TEXT(aAStatus;0)
  //  //
  //$While:=1
  //While ($While=1)
  //$While:=0
  //$Holdit:=Request("Enter days of history desired, Default is:  ";"183")
  //$NbrDays:=Num($holdit)
  //If (($NbrDays=0) & (OK=1))
  //ALERT("You must enter a valid number!")
  //$While:=1
  //End if 
  //End while 
  //If (OK=1)
  //$Date:=Current date-$NbrDays  // DATE MINUS DAYS OF HISTORY TO GET START DATE.
  //QUERY([IntakeFile];[IntakeFile]Program="F")
  //QUERY SELECTION([IntakeFile];[IntakeFile]IntakeDate>$Date)
  //If (Records in selection([IntakeFile])>0)  // SELECT INTAKE FAMILY RECORDS
  //vNbrRec:=(Records in selection([IntakeFile]))
  //FIRST RECORD([IntakeFile])
  //For ($i;1;Records in selection([IntakeFile]))
  //  //    
  //_O_ALL SUBRECORDS([IntakeFile]AddPartyFile)
  //If (_O_Records in subselection([IntakeFile]AddPartyFile)>0)
  //_O_FIRST SUBRECORD([IntakeFile]AddPartyFile)
  //For ($j;1;_O_Records in subselection([IntakeFile]AddPartyFile))
  //  //        
  //If ([IntakeFile]AddPartyFile'APType="A@")  // SELECT ATTORNEY SUBRECORDS
  //$Insert:=Size of array(aAName)+1
  //INSERT IN ARRAY(aAName;$Insert)  // EXPAND & LOAD ARRAY OF ATTY SUBRECDS FOR THIS CASE
  //INSERT IN ARRAY(aACaseNo;$Insert)
  //INSERT IN ARRAY(aACName;$Insert)
  //INSERT IN ARRAY(aARName;$Insert)
  //INSERT IN ARRAY(aAStatus;$Insert)
  //aAName{$Insert}:=[IntakeFile]AddPartyFile'LastName+", "+[IntakeFile]AddPartyFile'FirstName
  //aACaseNo{$Insert}:=[IntakeFile]CaseNo
  //aACName{$Insert}:=[IntakeFile]CLName
  //aARName{$Insert}:=[IntakeFile]RLName
  //aAStatus{$Insert}:=[IntakeFile]CaseStatus
  //End if   // CHECK IF ATTY
  //_O_NEXT SUBRECORD([IntakeFile]AddPartyFile)
  //End for   // GET SUBRECORDS
  //End if   // NBR SUBRECORDS > 0
  //NEXT RECORD([IntakeFile])
  //End for   // GET INTAKE RECDS
  //End if   // NBR FAM RECDS > 0
  //  //
  //$While:=1
  //vSort:=1
  //While ($While=1)
  //$While:=0
  //vCaseNo:=""
  //If (Size of array(aAName)>0)
  //$ArraySize:=String(Size of array(aAName))
  //Case of 
  //: (vSort=1)
  //SORT ARRAY(aAName;aACaseNo;aACName;aARName;aAStatus)
  //: (vSort=2)
  //SORT ARRAY(aACaseNo;aAName;aACName;aARName;aAStatus)
  //: (vSort=3)
  //SORT ARRAY(aACName;aAName;aACaseNo;aARName;aAStatus)
  //: (vSort=4)
  //SORT ARRAY(aARName;aAName;aACaseNo;aACName;aAStatus)
  //: (vSort=5)
  //SORT ARRAY(aAStatus;aAName;aACaseNo;aACName;aARName)
  //End case 
  //bSort:=0
  //vSort:=0
  //aAName:=35
  //vShowHdr:="Attorneys for the "+String(vnbrRec)+" Family Cases ("+$ArraySize+" Atty Rcds) Since "+String($Date)
  //DIALOG([IntakeFile];"ShowAttyDialog")  // DISPLAY ARRAY LIST OF ATTYS
  //If ((OK=1) & (vCaseNo>""))  // A CASE NBR WAS SELECTED TO DISPLAY
  //$While:=1  // CONTINUE WHILE LOOP FOR NEXT CASE
  //vsort:=0
  //SetInputLayout 
  //QUERY([IntakeFile];[IntakeFile]CaseNo=vCaseNo)
  //MODIFY RECORD([IntakeFile];*)
  //End if   // test selection of case no
  //If ((OK=1) & (vSort>0))
  //$While:=1
  //End if 
  //End if   // Array size = 0
  //End while   // end loop
  //End if   // Cancel from request for days of history  
  //  //
  //CLEAR VARIABLE(aAName)
  //CLEAR VARIABLE(aACaseNo)
  //CLEAR VARIABLE(aACName)
  //CLEAR VARIABLE(aARName)
  //CLEAR VARIABLE(aAStatus)
  //UNLOAD RECORD([IntakeFile])
  //UNLOAD RECORD([DocketFile])
  //UNLOAD RECORD([FamilyFile])
  //UNLOAD RECORD([CrtAddrFile])