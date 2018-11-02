//%attributes = {"publishedWeb":true}
  //G-Proc: Old 'VOM_SchUpdate'  variable routine; this proc will update the
  // variables for the Child Protective Services program when the Status is
  // = to Scheduled.    NOTE:  COOPERATE FOR KIDS (CFK,  PRGRAM = K)
  //    VALUES ARE COMBINED WITH CPS (W) AMOUNTS.
  //
Case of 
	: (vStl=True:C214)
		vWMed:=vWMed+1
		vWStl:=vWStl+1
		vWClosed:=vWClosed+1
	: (vImp=True:C214)
		vWMed:=vWMed+1
		vWImp:=vWImp+1
		vWClosed:=vWClosed+1
	: (vCon=True:C214)
		vWCon:=vWCon+1
		vWClosed:=vWClosed+1
	: (vCont=True:C214)
		vWMed:=vWMed+1
		vWCont:=vWCont+1
	: (vDcl=True:C214)
		vWDcl:=vWDcl+1
		vWClosed:=vWClosed+1
	: (vVen=True:C214)
		vWVen:=vWVen+1
		vWClosed:=vWClosed+1
	: (vRS=True:C214)
		vWRS:=vWRS+1
	: (vNS=True:C214)
		vWNS:=vWNS+1
		vWClosed:=vWClosed+1
End case 
