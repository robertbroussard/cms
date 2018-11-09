  //Layout Procedure: TestIntake.  This Method is a Form Method attached to 
  // the IntakeFile for the form TestIntake - used for non-Litigation input
  //
If (Form event:C388=On Load:K2:1)
	
	SetButtons 
	SET WINDOW TITLE:C213("CMS: Intake Input")
	If ([IntakeFile:1]Program:32)="F"
		OBJECT SET ENABLED:C1123(bFamily;True:C214)
		OBJECT SET ENABLED:C1123(bFamily2;True:C214)
		OBJECT SET ENABLED:C1123(bFamily3;True:C214)
	Else 
		OBJECT SET ENABLED:C1123(bFamily;False:C215)
		OBJECT SET ENABLED:C1123(bFamily2;False:C215)
		OBJECT SET ENABLED:C1123(bFamily3;False:C215)
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