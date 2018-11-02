If ([IntakeFile:1]Program:32="L") | ([IntakeFile:1]Program:32="M") | ([IntakeFile:1]Program:32="A")
	[IntakeFile:1]CaseStyle:23:=[IntakeFile:1]CFName:7+" "+[IntakeFile:1]CLName:6+" vs. "+[IntakeFile:1]RFName:12+" "+[IntakeFile:1]RLName:11
Else 
	[IntakeFile:1]CaseStyle:23:=[IntakeFile:1]CFName:7+" "+[IntakeFile:1]CLName:6+" and "+[IntakeFile:1]RFName:12+" "+[IntakeFile:1]RLName:11
End if 