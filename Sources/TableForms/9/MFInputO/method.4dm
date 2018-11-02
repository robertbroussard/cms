  // This Method is a Form Method attached to the
  //  Mediator File Form MFInputO
  //
If (Before:C29)  //Layout Proc: MFInput;
	If ([MediatorFile:9]DateEntered:11=!00-00-00!)
		[MediatorFile:9]DateEntered:11:=Current date:C33
	End if 
End if 