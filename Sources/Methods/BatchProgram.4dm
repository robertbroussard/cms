//%attributes = {"publishedWeb":true}
  //G-Procedure: BatchProgram;
C_LONGINT:C283($i)
C_TEXT:C284($String)
ALL RECORDS:C47([IntakeFile:1])
For ($i;1;Records in selection:C76([IntakeFile:1]))
	$String:=Substring:C12([IntakeFile:1]CaseNo:1;9;1)
	Case of 
		: ($String="C")
			[IntakeFile:1]Program:32:="C"
		: ($String="F")
			[IntakeFile:1]Program:32:="F"
		: ($String="J")
			[IntakeFile:1]Program:32:="J"
		: ($String="L")
			[IntakeFile:1]Program:32:="L"
		: ($String="S")
			[IntakeFile:1]Program:32:="S"
	End case 
	SAVE RECORD:C53([IntakeFile:1])
	NEXT RECORD:C51([IntakeFile:1])
End for 