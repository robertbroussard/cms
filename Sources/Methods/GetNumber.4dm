//%attributes = {"publishedWeb":true}
  //Function GetNumber- Called by NewIntake.  This function establishes a unique id 

  //for the intake file when a new record is created.

  //

_O_C_INTEGER:C282($0;$1;$2)
READ WRITE:C146([Constants:11])
QUERY:C277([Constants:11];[Constants:11]Sequence:1=$1)
If ([Constants:11]Sequence:1#$1)
	CREATE RECORD:C68([Constants:11])
	[Constants:11]Sequence:1:=$1
	If (Count parameters:C259=1)
		[Constants:11]Number:2:=268  //Chosen via Nick!  1.25.05

	Else 
		[Constants:11]Number:2:=$2
	End if 
End if 
If (Locked:C147([Constants:11]))
	While (Locked:C147([Constants:11]))
		MESSAGE:C88("Waiting For Constants Record…")
		LOAD RECORD:C52([Constants:11])
	End while 
End if 
$0:=[Constants:11]Number:2
[Constants:11]Number:2:=[Constants:11]Number:2+1
SAVE RECORD:C53([Constants:11])
READ ONLY:C145([Constants:11])
LOAD RECORD:C52([Constants:11])