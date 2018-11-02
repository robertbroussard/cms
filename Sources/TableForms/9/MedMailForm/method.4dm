  // ----------------------------------------------------
  // User name (OS): robert
  // Date and time: 11/18/04, 23:52:42
  // ----------------------------------------------------
  // Method: Form Method: MedMailForm
  // Description: Was in form object vdummy...
  // 
  //
  // Parameters
  // ----------------------------------------------------



  // Object method in Mediator file MedMailForm.  Make Modify data command 
  // invisible on first Dialog screen but avaiable on second.
  //
If (Form event:C388=On Load:K2:1)
	If (vDialog=1)
		OBJECT SET VISIBLE:C603(vModSw;False:C215)
	Else 
		OBJECT SET VISIBLE:C603(vModSw;True:C214)
	End if 
	vEnvelope:=vSavSwEnv
	vLabel:=vSavSwLbl
	vAllMediators:=vSavSwMed  //Restores Force All Mediators Checkbox state.` RJB Mod 10/14/11
	
	If (Current user:C182="Administrator") | (Current user:C182="Designer")  //RJB Add 10/14/11
		OBJECT SET VISIBLE:C603(vAllMediators;True:C214)  //RJB Add 10/14/11
	Else   //RJB Add 10/14/11
		OBJECT SET VISIBLE:C603(vAllMediators;False:C215)  //RJB Add 10/14/11
	End if   //RJB Add 10/14/11
	
End if 
