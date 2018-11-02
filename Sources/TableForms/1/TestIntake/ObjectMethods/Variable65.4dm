  // Delete 'C-SAYS' & 'R-SAYS' in turn and move the appropriate
  // data to the C & R dispute display fields.  SAME AS BUTTON ON PAGE 4
  //
$Position:=Position:C15("R SAYS";[IntakeFile:1]DDiscription:27)  // DELETE  R-SAYS
If ($Position>0)
	vFDesc_C:=Delete string:C232([IntakeFile:1]DDiscription:27;$Position;3200)  // LOAD IN C-SAYS
Else 
	ALERT:C41("'C SAYS' not found, loading whole field")
	vFDesc_C:=[IntakeFile:1]DDiscription:27
End if 
  //
$Position:=$Position-1  // DELETE C-SAYS UP TO R-SAYS
If ($Position>0)
	vFDesc_R:=Delete string:C232([IntakeFile:1]DDiscription:27;1;$Position)  // LOAD IN R-SAYS 
Else 
	ALERT:C41("'R SAYS' not found, loading whole field")
	vFDesc_R:=[IntakeFile:1]DDiscription:27
End if 
  //
$Position:=Position:C15("R WANTS";[IntakeFile:1]ResDesired:28)  // FIND BEGINNING OF R-WANTS
If ($Position>0)
	vFResultC:=Delete string:C232([IntakeFile:1]ResDesired:28;$Position;3200)  // DELETE R-WANTS
Else 
	ALERT:C41("'R WANTS' not found, loading whole field")
	vFResultC:=[IntakeFile:1]ResDesired:28
End if 
  //
$Position:=$Position-1  // DELETE ONLY UP TO R-WANTS
If ($Position>0)
	vFResultR:=Delete string:C232([IntakeFile:1]ResDesired:28;1;$Position)
Else 
	ALERT:C41("'R WANTS' not found, Loading whole field")
	vFResultR:=[IntakeFile:1]ResDesired:28
End if 
  //
SET WINDOW TITLE:C213("Family Mediation Screen 2")
FORM GOTO PAGE:C247(5)