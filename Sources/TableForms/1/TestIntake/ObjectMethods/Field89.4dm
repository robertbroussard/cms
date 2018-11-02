If ([IntakeFile:1]Program:32="F")
	If (([IntakeFile:1]ifRelCode:17="211") | ([IntakeFile:1]ifRelCode:17="213") | ([IntakeFile:1]ifRelCode:17="214"))
	Else 
		ALERT:C41("Family cases require a Relation Code of 211, 213, or 214")
		[IntakeFile:1]ifRelCode:17:=""
	End if 
End if 