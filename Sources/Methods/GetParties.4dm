//%attributes = {"publishedWeb":true}
  //G-Procedure: GetParties;
  //
_O_C_STRING:C293(3;$CheckNum;$Pgm)
_O_C_INTEGER:C282($i;$Insert)
$CheckNum:=""
_O_ARRAY STRING:C218(50;aPLName;2)
_O_ARRAY STRING:C218(50;aPFName;2)
_O_ARRAY STRING:C218(10;aPartyType;2)
_O_ARRAY STRING:C218(25;aFirm;2)
_O_ARRAY STRING:C218(60;aStAdd;2)
_O_ARRAY STRING:C218(20;aCity;2)
_O_ARRAY STRING:C218(2;agpState;2)
_O_ARRAY STRING:C218(9;aZip;2)
_O_ARRAY STRING:C218(2;aPartyLang;2)
ARRAY INTEGER:C220(aAge;2)  //             add:   pass age forward
  //C1 Information
aPartyType{1}:="C1"
aPLName{1}:=[IntakeFile:1]CLName:6
aPFName{1}:=[IntakeFile:1]CFName:7
aFirm{1}:=[IntakeFile:1]CFirm:33
aStAdd{1}:=[IntakeFile:1]CStAddress:34
aCity{1}:=[IntakeFile:1]CCity:35
agpState{1}:=[IntakeFile:1]CState:36
aZip{1}:=[IntakeFile:1]CZip:37
aPartyLang{1}:=[IntakeFile:1]CLang:10
aAge{1}:=[IntakeFile:1]CAge:45  //              08/02:    carry age  to Juve. Ltrs
  //R1 Information
aPartyType{2}:="R1"
aPLName{2}:=[IntakeFile:1]RLName:11
aPFName{2}:=[IntakeFile:1]RFName:12
aFirm{2}:=[IntakeFile:1]RFirm:38
aStAdd{2}:=[IntakeFile:1]RStAddress:39
aCity{2}:=[IntakeFile:1]RCity:40
agpState{2}:=[IntakeFile:1]RState:41
aZip{2}:=[IntakeFile:1]RZip:42
aPartyLang{2}:=[IntakeFile:1]RLang:15
aAge{2}:=[IntakeFile:1]RAge:48  //              08/02:    carry age  to Juve. Ltrs
  //Additional parties if any
_O_ALL SUBRECORDS:C109([IntakeFile:1]AddPartyFile:21)
If (_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21)>0)
	_O_FIRST SUBRECORD:C61([IntakeFile:1]AddPartyFile:21)
	For ($i;1;_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21))
		If (Length:C16([IntakeFile]AddPartyFile'APType)>3)
			$CheckNum:="X"  // DON'T ACCEPT COMBO TYPES - PARENTS
		Else 
			If (Length:C16([IntakeFile]AddPartyFile'APType)>2)
				$CheckNum:=Substring:C12([IntakeFile]AddPartyFile'APType;3;1)
			Else 
				$CheckNum:=Substring:C12([IntakeFile]AddPartyFile'APType;2;1)
			End if 
		End if 
		$Pgm:=[IntakeFile:1]Program:32
		If (((Character code:C91($CheckNum)>=48) & (Character code:C91($CheckNum)<=57)) | ($Pgm="F") | ($Pgm="W") | ($Pgm="K") | ($Pgm="J"))
			$Insert:=Size of array:C274(aPartyType)+1  // TEST FOR FAMILY & PRINT ENVELOPES FOR ALL & "J" RECDS (10/02)
			INSERT IN ARRAY:C227(aPartyType;$Insert)
			INSERT IN ARRAY:C227(aPLName;$Insert)
			INSERT IN ARRAY:C227(aPFName;$Insert)
			INSERT IN ARRAY:C227(aFirm;$Insert)
			INSERT IN ARRAY:C227(aStAdd;$Insert)
			INSERT IN ARRAY:C227(aCity;$Insert)
			INSERT IN ARRAY:C227(agpState;$Insert)
			INSERT IN ARRAY:C227(aZip;$Insert)
			INSERT IN ARRAY:C227(aPartyLang;$Insert)
			INSERT IN ARRAY:C227(aAge;$Insert)  //         add:  10/16   insert age
			aPartyType{$Insert}:=[IntakeFile]AddPartyFile'APType
			aPLName{$Insert}:=[IntakeFile]AddPartyFile'LastName
			aPFName{$Insert}:=[IntakeFile]AddPartyFile'FirstName
			aFirm{$Insert}:=[IntakeFile]AddPartyFile'APFirm
			aStAdd{$Insert}:=[IntakeFile]AddPartyFile'APStAddress
			aCity{$Insert}:=[IntakeFile]AddPartyFile'APCity
			agpState{$Insert}:=[IntakeFile]AddPartyFile'ApState
			aZip{$Insert}:=[IntakeFile]AddPartyFile'APZip
			aPartyLang{$Insert}:=[IntakeFile]AddPartyFile'Lang
			aAge{$insert}:=[IntakeFile]AddPartyFile'APAge  //         10/16:  add
		End if 
		_O_NEXT SUBRECORD:C62([IntakeFile:1]AddPartyFile:21)
	End for 
End if 