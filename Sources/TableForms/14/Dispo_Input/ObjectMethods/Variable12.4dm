  //Script: aDFullName;
C_LONGINT:C283($Pos)
C_TEXT:C284($CheckNum)
C_TEXT:C284($TempStr)
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