  //Script:aPartyType;
If (aPartyType{aPartyType}#"")
	$TempType:=aPartyType{aPartyType}
	vElement:=Find in array:C230(aPartyType;$TempType)
Else 
	ALERT:C41("Please don't select a blank line!")
End if 