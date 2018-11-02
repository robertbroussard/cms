  //Script:aPFName;
If (aPFName{aPFName}#"")
	$TempFName:=aPFName{aPFName}
	  // vElement:=Find in array(aPFName;$TempFName)
	vElement:=aPFName
Else 
	ALERT:C41("Please don't select a blank line!")
End if 