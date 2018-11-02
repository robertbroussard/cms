
If (Form event:C388=On Printing Detail:K2:18)
	  //BEEP
	If (Not:C34((vSR_13+vSR_14)=0))
		OBJECT SET VISIBLE:C603(*;"Rectangle2";False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*;"Rectangle2";True:C214)
	End if 
	
End if 