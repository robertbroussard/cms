//%attributes = {"publishedWeb":true}
  //G-Proc: MED_SchUpdate; this proc will update the variables for the Mediation 
  //case when the case status is = to Scheduled.
  //
Case of 
	: (vStl=True:C214)
		vMMed:=vMMed+1
		vMStl:=vMStl+1
		vMClosed:=vMClosed+1
	: (vImp=True:C214)
		vMMed:=vMMed+1
		vMImp:=vMImp+1
		vMClosed:=vMClosed+1
	: (vCon=True:C214)
		vMCon:=vMCon+1
		vMClosed:=vMClosed+1
	: (vCont=True:C214)
		vMMed:=vMMed+1
		vMCont:=vMCont+1
	: (vDcl=True:C214)
		vMDcl:=vMDcl+1
		vMClosed:=vMClosed+1
	: (vVen=True:C214)
		vMVen:=vMVen+1
		vMClosed:=vMClosed+1
	: (vRS=True:C214)
		vMRS:=vMRS+1
	: (vNS=True:C214)
		vMNS:=vMNS+1
		vMClosed:=vMClosed+1
End case 