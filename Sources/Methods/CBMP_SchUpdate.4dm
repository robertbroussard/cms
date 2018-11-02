//%attributes = {"publishedWeb":true}
  //G-Proc: CBMP_SchUpdate; this proc will update the variables for the CBMP cases,
  //when the case status is = to Scheduled.
  //
Case of 
	: (vStl=True:C214)
		vCMed:=vCMed+1
		vCStl:=vCStl+1
		vCClosed:=vCClosed+1
	: (vImp=True:C214)
		vCMed:=vCMed+1
		vCImp:=vCImp+1
		vCClosed:=vCClosed+1
	: (vCon=True:C214)
		vCCon:=vCCon+1
		vCClosed:=vCClosed+1
	: (vCont=True:C214)
		vCMed:=vCMed+1
		vCCont:=vCCont+1
	: (vDcl=True:C214)
		vCDcl:=vCDcl+1
		vCClosed:=vCClosed+1
	: (vVen=True:C214)
		vCVen:=vCVen+1
		vCClosed:=vCClosed+1
	: (vRS=True:C214)
		vCRS:=vCRS+1
	: (vNS=True:C214)
		vCNS:=vCNS+1
		vCClosed:=vCClosed+1
End case 