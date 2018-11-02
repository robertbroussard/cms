  //Script: vCode;
If ([IntakeFile]AddPartyFile'APSex=True:C214)
	vCode:=[IntakeFile]AddPartyFile'APRace+"F"+String:C10([IntakeFile]AddPartyFile'APAge)+[IntakeFile]AddPartyFile'Lang
Else 
	vCode:=[IntakeFile]AddPartyFile'APRace+"M"+String:C10([IntakeFile]AddPartyFile'APAge)+[IntakeFile]AddPartyFile'Lang
End if 