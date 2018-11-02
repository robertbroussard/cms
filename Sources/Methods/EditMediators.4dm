//%attributes = {"publishedWeb":true}
  //G-Procedure: EditMediators - This procedure uses Search By Layout with the 

  //layout"IntSearch" to search for the case to be modified and then the procedure 

  //either finds the Mediator and displays the record or provides the user with an 

  //error message.  {:()

  // 

SET WINDOW TITLE:C213("Mediator Input Screen")
_O_C_STRING:C293(5;$Dis1)
_O_C_INTEGER:C282($Loop)
_O_C_STRING:C293(1;$CR)
vNewMed:=False:C215
$Loop:=1
vCheckKey:=False:C215
While ($Loop=1)
	FORM SET INPUT:C55([MediatorFile:9];"MedSearch")
	QUERY BY EXAMPLE:C292([MediatorFile:9])
	Case of 
		: (OK=1) & (Records in selection:C76([MediatorFile:9])=1)
			FORM SET INPUT:C55([MediatorFile:9];"MFInput")
			MODIFY RECORD:C57([MediatorFile:9];*)
			$Loop:=0
		: (OK=1) & (Records in selection:C76([MediatorFile:9])>1)
			$Dis1:=String:C10(Records in selection:C76([MediatorFile:9]))
			FORM SET INPUT:C55([MediatorFile:9];"MFInput")
			FORM SET OUTPUT:C54([MediatorFile:9];"MFOutput")
			CONFIRM:C162($Dis1+" records found! Press OK to view all records; press Cancel to search again.")
			If (OK=1)
				CONFIRM:C162("Would you like to sort the records by Last Name?")
				If (OK=1)
					ORDER BY:C49([MediatorFile:9];[MediatorFile:9]MLName:1;>;[MediatorFile:9]MFName:2;>)
				End if 
				MODIFY SELECTION:C204([MediatorFile:9];*)
				$Loop:=0
			Else 
				$Loop:=1
			End if 
		: (Records in selection:C76([MediatorFile:9])=0) & (OK=1)
			$CR:=Char:C90(13)
			CONFIRM:C162("That record not found!"+$CR+"Do you want to try again?")
			If (OK=1)
				$Loop:=1
			Else 
				$Loop:=0
			End if 
		Else   //Else of case-to kill loop

			$Loop:=0
	End case 
End while 
aaa_ResetGroupLookup 
UNLOAD RECORD:C212([MediatorFile:9])
SET WINDOW TITLE:C213("DRC Case Management System")