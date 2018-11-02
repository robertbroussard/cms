//%attributes = {"publishedWeb":true}
  //G-Procedure:SetLength, called by NewIntake;  This Function takes the value that 
  //G-Variable vTempCaseNo by the GP:GetNumber and sets the length to a 4 digit
  // string based on the original length of the number.
  //
_O_C_STRING:C293(4;$1;$0)
Case of 
	: (Length:C16($1)=1)
		$0:="000"+$1
	: (Length:C16($1)=2)
		$0:="00"+$1
	: (Length:C16($1)=3)
		$0:="0"+$1
	Else 
		$0:=$1
End case 