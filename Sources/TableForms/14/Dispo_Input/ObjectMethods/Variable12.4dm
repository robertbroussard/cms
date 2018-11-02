  //Script: aDFullName;
_O_C_INTEGER:C282($Pos)
_O_C_STRING:C293(1;$CheckNum)
_O_C_STRING:C293(40;$TempStr)
vDFullName:=aDFullName{aDFullName}
vDType:=aDType{aDFullName}
$CheckNum:=""
If (Length:C16(aDType{aDFullName})>2)
	$CheckNum:=Substring:C12(aDType{aDFullName};3;1)
Else 
	$CheckNum:=Substring:C12(aDType{aDFullName};2;1)
End if 
If (((Character code:C91($CheckNum)<48) | (Character code:C91($CheckNum)>57)) | (vDType#"R@"))
	ALERT:C41("This person is not a respondent; Select again.")
	vDFullName:=""
	vDType:=""
	aDFullName:=0
Else 
	$Pos:=Position:C15("(";vDFullName)
	$TempStr:=Delete string:C232(vDFullName;$Pos;10)
	vDFullName:=$TempStr
End if 