//%attributes = {"publishedWeb":true}
  //G-Procedure: BatchStyle;
_O_C_INTEGER:C282($i)
FORM SET INPUT:C55([IntakeFile:1];"IntSearch")
ALL RECORDS:C47([IntakeFile:1])
If (Records in selection:C76([IntakeFile:1])>=1)
	For ($i;1;Records in selection:C76([IntakeFile:1]))
		GetCaseStyle   //Mod 10/28/03
		SAVE RECORD:C53([IntakeFile:1])
		NEXT RECORD:C51([IntakeFile:1])
	End for 
End if 