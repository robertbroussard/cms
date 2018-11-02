//%attributes = {"publishedWeb":true}
  //G-Procedure: AddMediator

SET WINDOW TITLE:C213("Mediator Input Screen")
_O_C_INTEGER:C282($Loop)
vNewMed:=True:C214
$Loop:=1
vCheckKey:=False:C215
While ($Loop=1)
	FORM SET INPUT:C55([MediatorFile:9];"MFInput")
	FORM SET OUTPUT:C54([MediatorFile:9];"MFOutput")
	[Groups:13]Group:2:=""
	ADD RECORD:C56([MediatorFile:9];*)
	If (OK=1)
		[MediatorFile:9]MKey:14:=[MediatorFile:9]MLName:1+", "+[MediatorFile:9]MFName:2
		[MediatorFile:9]DateEntered:11:=Current date:C33
		SAVE RECORD:C53([MediatorFile:9])
	End if 
	CONFIRM:C162("Do you want to add another Mediator at this time?")
	If (OK#1)
		$Loop:=0
	End if 
End while 
aaa_ResetGroupLookup 
SET WINDOW TITLE:C213("DRC Case Management System")