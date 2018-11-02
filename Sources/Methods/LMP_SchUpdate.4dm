//%attributes = {"publishedWeb":true}
  //G-Proc: LMP_SchUpdate; this proc will update the variables for the LMP cases,
  //when the case status is = to Scheduled.
Case of 
	: (vStl=True:C214)
		vLMed:=vLMed+1
		vLStl:=vLStl+1
		vLClosed:=vLClosed+1
	: (vImp=True:C214)
		vLMed:=vLMed+1
		vLImp:=vLImp+1
		vLClosed:=vLClosed+1
	: (vCon=True:C214)
		vLCon:=vLCon+1
		vLClosed:=vLClosed+1
	: (vCont=True:C214)
		vLMed:=vLMed+1
		vLCont:=vLCont+1
	: (vDcl=True:C214)
		vLDcl:=vLDcl+1
		vLClosed:=vLClosed+1
	: (vVen=True:C214)
		vLVen:=vLVen+1
		vLClosed:=vLClosed+1
	: (vRS=True:C214)
		vLRS:=vLRS+1
	: (vNS=True:C214)
		vLNS:=vLNS+1
		vLClosed:=vLClosed+1
End case 