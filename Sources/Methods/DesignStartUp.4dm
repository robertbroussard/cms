//%attributes = {"publishedWeb":true}
  //G-Procedure: DesignStartUp
CONFIRM:C162("Run Start up?")
If (OK=1)
	SET WINDOW TITLE:C213("DRC Case Management System")
	READ ONLY:C145([Constants:11])
	READ ONLY:C145([LocationFile:2])
	READ ONLY:C145([ISIDTable:3])
	READ ONLY:C145([RelCodeFile:5])
	READ ONLY:C145([DisputeFile:4])
End if 