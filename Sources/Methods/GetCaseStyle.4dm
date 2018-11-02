//%attributes = {"publishedWeb":true}
  //G-Procedure: GetCaseStyle;
Case of 
	: (([IntakeFile:1]CFName:7#"") & ([IntakeFile:1]RFName:12#""))
		[IntakeFile:1]CaseStyle:23:=[IntakeFile:1]CFName:7+" "+[IntakeFile:1]CLName:6+" and "+[IntakeFile:1]RFName:12+" "+[IntakeFile:1]RLName:11
	: (([IntakeFile:1]CFName:7="") & ([IntakeFile:1]RFName:12#""))
		[IntakeFile:1]CaseStyle:23:=[IntakeFile:1]CLName:6+" and "+[IntakeFile:1]RFName:12+" "+[IntakeFile:1]RLName:11
	: (([IntakeFile:1]CFName:7#"") & ([IntakeFile:1]RFName:12=""))
		[IntakeFile:1]CaseStyle:23:=[IntakeFile:1]CFName:7+" "+[IntakeFile:1]CLName:6+" and "+[IntakeFile:1]RLName:11
	: (([IntakeFile:1]CFName:7="") & ([IntakeFile:1]RFName:12=""))
		[IntakeFile:1]CaseStyle:23:=[IntakeFile:1]CLName:6+" and "+[IntakeFile:1]RLName:11
	Else 
		[IntakeFile:1]CaseStyle:23:=[IntakeFile:1]CFName:7+" "+[IntakeFile:1]CLName:6+" and "+[IntakeFile:1]RFName:12+" "+[IntakeFile:1]RLName:11
End case 