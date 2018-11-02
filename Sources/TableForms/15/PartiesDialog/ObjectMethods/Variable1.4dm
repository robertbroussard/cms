  //Script:aPLName;
If (aPLName{aPLName}#"")
	$TempLName:=aPLName{aPLName}
	  //vElement:=Find in array(aPLName;$TempLName)
	vElement:=aPLName  // AVOID WRONG NAME IF 2 NAMES ARE SAME
Else 
	ALERT:C41("Please don't select a blank line!")
End if 