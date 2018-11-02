//%attributes = {"publishedWeb":true}
  //G-Proc: Old 'VOM_SchUpdate'  variable routine; this proc will update the
  // variables for the Probation program when the Status is
  // = to Scheduled.
  //
Case of 
	: (vStl=True:C214)
		vPMed:=vPMed+1
		vPStl:=vPStl+1
		vPClosed:=vPClosed+1
	: (vImp=True:C214)
		vPMed:=vPMed+1
		vPImp:=vPImp+1
		vPClosed:=vPClosed+1
	: (vCon=True:C214)
		vPCon:=vPCon+1
		vPClosed:=vPClosed+1
	: (vCont=True:C214)
		vPMed:=vPMed+1
		vPCont:=vPCont+1
	: (vDcl=True:C214)
		vPDcl:=vPDcl+1
		vPClosed:=vPClosed+1
	: (vVen=True:C214)
		vPVen:=vPVen+1
		vPClosed:=vPClosed+1
	: (vRS=True:C214)
		vPRS:=vPRS+1
	: (vNS=True:C214)
		vPNS:=vPNS+1
		vPClosed:=vPClosed+1
End case 
