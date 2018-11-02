//%attributes = {"publishedWeb":true}
  //G-Procedure:CheckInvalid;Called from GetNextAvail2
  //
QUERY:C277([InvalidDateFile:8];[InvalidDateFile:8]InvalidDate:2=$1)
If (Records in selection:C76([InvalidDateFile:8])#0)
	$1:=$1+1
	vAdvanced:=True:C214
Else 
	vAdvanced:=False:C215
End if 
$0:=$1