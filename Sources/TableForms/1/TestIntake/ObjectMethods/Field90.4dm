If ([IntakeFile:1]Program:32="F")
	If (([IntakeFile:1]DisputeCode:22="108") | ([IntakeFile:1]DisputeCode:22="124"))
	Else 
		ALERT:C41("Family cases require a Dispute Code of 108 or 124")
		[IntakeFile:1]DisputeCode:22:=""
	End if 
End if 