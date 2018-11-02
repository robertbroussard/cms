  // Script for Find Button in Dialog "ShowAtty"
  //
$Name:=Request:C163("Enter part or all of the Attorney's last name")
$Name:=$Name+"@"
$Found:=Find in array:C230(aAName;$Name)
If ($Found=-1)
	ALERT:C41("That name was not found!")
Else 
	aAName:=$Found
End if 