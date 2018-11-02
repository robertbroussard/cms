  //Script: vR1Code;
If ([IntakeFile:1]RSex:46=True:C214)
	vR1Code:=[IntakeFile:1]RRace:47+"F"+String:C10([IntakeFile:1]RAge:48)+[IntakeFile:1]RLang:15
Else 
	vR1Code:=[IntakeFile:1]RRace:47+"M"+String:C10([IntakeFile:1]RAge:48)+[IntakeFile:1]RLang:15
End if 