//%attributes = {"publishedWeb":true}
  // G-Procedure: ShowAtty; This proc builds array of all
  // Additional Party Attorneys for Family Cases, not Referred,
  // within the last year and a half.
  //
C_LONGINT:C283($i;j;$Insert;vNbrRec;$NbrDays)
C_TEXT:C284(vShowHdr)
C_TEXT:C284(vCaseNo)
C_DATE:C307($Date)
  //
ARRAY TEXT:C222(aAName;0)
ARRAY TEXT:C222(aACaseNo;0)
ARRAY TEXT:C222(aACName;0)
ARRAY TEXT:C222(aARName;0)
ARRAY TEXT:C222(aAStatus;0)
  //
$While:=1
While ($While=1)
	$While:=0
	$Holdit:=Request:C163("Enter days of history desired, Default is:  ";"183")
	$NbrDays:=Num:C11($holdit)
	If (($NbrDays=0) & (OK=1))
		ALERT:C41("You must enter a valid number!")
		$While:=1
	End if 
End while 
If (OK=1)
	$Date:=Current date:C33-$NbrDays  // DATE MINUS DAYS OF HISTORY TO GET START DATE.
	QUERY:C277([IntakeFile:1];[IntakeFile:1]Program:32="F")
	QUERY SELECTION:C341([IntakeFile:1];[IntakeFile:1]IntakeDate:4>$Date)
	If (Records in selection:C76([IntakeFile:1])>0)  // SELECT INTAKE FAMILY RECORDS
		vNbrRec:=(Records in selection:C76([IntakeFile:1]))
		FIRST RECORD:C50([IntakeFile:1])
		For ($i;1;Records in selection:C76([IntakeFile:1]))
			  //    
			_O_ALL SUBRECORDS:C109([IntakeFile:1]AddPartyFile:21)
			If (_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21)>0)
				_O_FIRST SUBRECORD:C61([IntakeFile:1]AddPartyFile:21)
				For ($j;1;_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21))
					  //        
					If ([IntakeFile]AddPartyFile'APType="A@")  // SELECT ATTORNEY SUBRECORDS
						$Insert:=Size of array:C274(aAName)+1
						INSERT IN ARRAY:C227(aAName;$Insert)  // EXPAND & LOAD ARRAY OF ATTY SUBRECDS FOR THIS CASE
						INSERT IN ARRAY:C227(aACaseNo;$Insert)
						INSERT IN ARRAY:C227(aACName;$Insert)
						INSERT IN ARRAY:C227(aARName;$Insert)
						INSERT IN ARRAY:C227(aAStatus;$Insert)
						aAName{$Insert}:=[IntakeFile]AddPartyFile'LastName+", "+[IntakeFile]AddPartyFile'FirstName
						aACaseNo{$Insert}:=[IntakeFile:1]CaseNo:1
						aACName{$Insert}:=[IntakeFile:1]CLName:6
						aARName{$Insert}:=[IntakeFile:1]RLName:11
						aAStatus{$Insert}:=[IntakeFile:1]CaseStatus:25
					End if   // CHECK IF ATTY
					_O_NEXT SUBRECORD:C62([IntakeFile:1]AddPartyFile:21)
				End for   // GET SUBRECORDS
			End if   // NBR SUBRECORDS > 0
			NEXT RECORD:C51([IntakeFile:1])
		End for   // GET INTAKE RECDS
	End if   // NBR FAM RECDS > 0
	  //
	$While:=1
	vSort:=1
	While ($While=1)
		$While:=0
		vCaseNo:=""
		If (Size of array:C274(aAName)>0)
			$ArraySize:=String:C10(Size of array:C274(aAName))
			Case of 
				: (vSort=1)
					SORT ARRAY:C229(aAName;aACaseNo;aACName;aARName;aAStatus)
				: (vSort=2)
					SORT ARRAY:C229(aACaseNo;aAName;aACName;aARName;aAStatus)
				: (vSort=3)
					SORT ARRAY:C229(aACName;aAName;aACaseNo;aARName;aAStatus)
				: (vSort=4)
					SORT ARRAY:C229(aARName;aAName;aACaseNo;aACName;aAStatus)
				: (vSort=5)
					SORT ARRAY:C229(aAStatus;aAName;aACaseNo;aACName;aARName)
			End case 
			bSort:=0
			vSort:=0
			aAName:=35
			vShowHdr:="Attorneys for the "+String:C10(vnbrRec)+" Family Cases ("+$ArraySize+" Atty Rcds) Since "+String:C10($Date)
			DIALOG:C40([IntakeFile:1];"ShowAttyDialog")  // DISPLAY ARRAY LIST OF ATTYS
			If ((OK=1) & (vCaseNo>""))  // A CASE NBR WAS SELECTED TO DISPLAY
				$While:=1  // CONTINUE WHILE LOOP FOR NEXT CASE
				vsort:=0
				SetInputLayout 
				QUERY:C277([IntakeFile:1];[IntakeFile:1]CaseNo:1=vCaseNo)
				MODIFY RECORD:C57([IntakeFile:1];*)
			End if   // test selection of case no
			If ((OK=1) & (vSort>0))
				$While:=1
			End if 
		End if   // Array size = 0
	End while   // end loop
End if   // Cancel from request for days of history  
  //
CLEAR VARIABLE:C89(aAName)
CLEAR VARIABLE:C89(aACaseNo)
CLEAR VARIABLE:C89(aACName)
CLEAR VARIABLE:C89(aARName)
CLEAR VARIABLE:C89(aAStatus)
UNLOAD RECORD:C212([IntakeFile:1])
UNLOAD RECORD:C212([DocketFile:6])
UNLOAD RECORD:C212([FamilyFile:20])
UNLOAD RECORD:C212([CrtAddrFile:19])