  //Layout Procedure: TestIntake.  This Method is a Form Method attached to 
  // the IntakeFile for the form TestIntake - used for non-Litigation input
  //
If (Before:C29)
	SetButtons 
	SET WINDOW TITLE:C213("CMS: Intake Input")
	If ([IntakeFile:1]Program:32)="F"
		_O_ENABLE BUTTON:C192(bFamily)
		_O_ENABLE BUTTON:C192(bFamily2)
		_O_ENABLE BUTTON:C192(bFamily3)
	Else 
		_O_DISABLE BUTTON:C193(bFamily)
		_O_DISABLE BUTTON:C193(bFamily2)
		_O_DISABLE BUTTON:C193(bFamily3)
	End if 
	
	If (Current user:C182="Administrator") | (Current user:C182="Designer")
		OBJECT SET VISIBLE:C603(bDelete1;True:C214)
		OBJECT SET VISIBLE:C603(*;"Picture1";True:C214)
		OBJECT SET VISIBLE:C603(*;"Text2";True:C214)
	Else 
		OBJECT SET VISIBLE:C603(bDelete1;False:C215)
		OBJECT SET VISIBLE:C603(*;"Picture1";False:C215)
		OBJECT SET VISIBLE:C603(*;"Text2";False:C215)
	End if 
End if 