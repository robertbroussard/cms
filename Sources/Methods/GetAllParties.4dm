//%attributes = {"publishedWeb":true}
  //G-Procedure: GetAllParties; This proc gets all the parties without reguard to 
  //the party type.
_O_C_INTEGER:C282($i;$Insert)
_O_ARRAY STRING:C218(50;aPLName;2)
_O_ARRAY STRING:C218(50;aPFName;2)
_O_ARRAY STRING:C218(10;aPartyType;2)
_O_ARRAY STRING:C218(25;aFirm;2)
_O_ARRAY STRING:C218(60;aStAdd;2)
_O_ARRAY STRING:C218(20;aCity;2)
_O_ARRAY STRING:C218(2;agpState;2)
_O_ARRAY STRING:C218(9;aZip;2)
_O_ARRAY STRING:C218(2;aPartyLang;2)
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
  //Additional parties if any
_O_ALL SUBRECORDS:C109([IntakeFile:1]AddPartyFile:21)
If (_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21)>0)
	_O_FIRST SUBRECORD:C61([IntakeFile:1]AddPartyFile:21)
	For ($i;1;_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21))
		$Insert:=Size of array:C274(aPartyType)+1
		INSERT IN ARRAY:C227(aPartyType;$Insert)
		INSERT IN ARRAY:C227(aPLName;$Insert)
		INSERT IN ARRAY:C227(aPFName;$Insert)
		INSERT IN ARRAY:C227(aFirm;$Insert)
		INSERT IN ARRAY:C227(aStAdd;$Insert)
		INSERT IN ARRAY:C227(aCity;$Insert)
		INSERT IN ARRAY:C227(agpState;$Insert)
		INSERT IN ARRAY:C227(aZip;$Insert)
		INSERT IN ARRAY:C227(aPartyLang;$Insert)
		aPartyType{$Insert}:=[IntakeFile]AddPartyFile'APType
		aPLName{$Insert}:=[IntakeFile]AddPartyFile'LastName
		aPFName{$Insert}:=[IntakeFile]AddPartyFile'FirstName
		aFirm{$Insert}:=[IntakeFile]AddPartyFile'APFirm
		aStAdd{$Insert}:=[IntakeFile]AddPartyFile'APStAddress
		aCity{$Insert}:=[IntakeFile]AddPartyFile'APCity
		agpState{$Insert}:=[IntakeFile]AddPartyFile'ApState
		aZip{$Insert}:=[IntakeFile]AddPartyFile'APZip
		aPartyLang{$Insert}:=[IntakeFile]AddPartyFile'Lang
		_O_NEXT SUBRECORD:C62([IntakeFile:1]AddPartyFile:21)
	End for 
End if 