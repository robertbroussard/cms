//%attributes = {"publishedWeb":true}
  //G-Procedure:AddParty; This procedure is called with the add party button

  //in the IntInput layout.

  //


C_BOOLEAN:C305($Fixed)

If ([IntakeFile:1]RHPhone:13="")
	[IntakeFile:1]RHPhone:13:="0000000000"
	$Fixed:=True:C214
Else 
	$Fixed:=False:C215
End if 

If (([IntakeFile:1]Program:32="L") | ([IntakeFile:1]Program:32="M") | ([IntakeFile:1]Program:32="A"))
	_O_ADD SUBRECORD:C202([IntakeFile:1]AddPartyFile:21;"APInputLit";*)
Else 
	_O_ADD SUBRECORD:C202([IntakeFile:1]AddPartyFile:21;"CInputAP1";*)
End if 
If (OK=1)
	[IntakeFile:1]AddPartyFlag:20:=True:C214
	SAVE RECORD:C53([IntakeFile:1])
Else 
	If ($Fixed)
		[IntakeFile:1]RHPhone:13:=""
	End if 
End if 
_O_ALL SUBRECORDS:C109([IntakeFile:1]AddPartyFile:21)