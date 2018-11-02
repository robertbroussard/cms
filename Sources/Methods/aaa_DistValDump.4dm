//%attributes = {}
  //11/14/06

  //$FldPtr:=->[IntakeFile]RefBy
$FldPtr:=->[DocketFile:6]HResults:11
$TblePtr:=Table:C252(Table:C252($FldPtr))
$FldName:=Field name:C257($FldPtr)

ARRAY TEXT:C222(adisvals;0)
ALL RECORDS:C47($TblePtr->)
  // DISTINCT VALUES(($FldPtr->);aDisVals)
DISTINCT VALUES:C339([DocketFile:6]HResults:11;aDisVals)
vdoc:=Create document:C266($FldName+"4.txt")
If (ok=1)
	For ($i;1;Size of array:C274(aDisVals))
		SEND PACKET:C103(vdoc;aDisVals{$i}+Char:C90(13))
		MESSAGE:C88("Processing: "+aDisVals{$i}+" of "+String:C10(Size of array:C274(aDisVals))+Char:C90(13))
		
	End for 
	CLOSE DOCUMENT:C267(vdoc)
	
	
End if 
BEEP:C151
ALERT:C41("DONE!")