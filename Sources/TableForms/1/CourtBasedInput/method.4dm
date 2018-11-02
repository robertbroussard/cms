  // Layout Procedure: CourtBasedInput - This method is a Form Method attached to
  // the IntakeFile for the form CourtBasedInput - used for Litigation input
  //
If (Before:C29)
	SetButtons 
	SET WINDOW TITLE:C213("CMS: Intake Input")
	
	If (Current user:C182="Administrator") | (Current user:C182="Designer")
		OBJECT SET VISIBLE:C603(bDelete1;True:C214)
		OBJECT SET VISIBLE:C603(*;"Rectangle4";True:C214)
		OBJECT SET VISIBLE:C603(*;"Text2";True:C214)
		OBJECT SET VISIBLE:C603(*;"Picture1";True:C214)
	Else 
		OBJECT SET VISIBLE:C603(bDelete1;False:C215)
		OBJECT SET VISIBLE:C603(*;"Rectangle4";False:C215)
		OBJECT SET VISIBLE:C603(*;"Text2";False:C215)
		OBJECT SET VISIBLE:C603(*;"Picture1";False:C215)
	End if 
	
End if 