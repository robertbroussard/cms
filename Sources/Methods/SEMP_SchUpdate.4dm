//%attributes = {"publishedWeb":true}
  //G-Proc: SEMP_SchUpdate; this proc will update the variables for the SEMP cases,
  //when the case status is = to Scheduled.
Case of 
	: (vStl=True:C214)
		vSMed:=vSMed+1
		vSStl:=vSStl+1
		vSClosed:=vSClosed+1
	: (vImp=True:C214)
		vSMed:=vSMed+1
		vSImp:=vSImp+1
		vSClosed:=vSClosed+1
	: (vCon=True:C214)
		vSCon:=vSCon+1
		vSClosed:=vSClosed+1
	: (vCont=True:C214)
		vSMed:=vSMed+1
		vSCont:=vSCont+1
	: (vDcl=True:C214)
		vSDcl:=vSDcl+1
		vSClosed:=vSClosed+1
	: (vVen=True:C214)
		vSVen:=vSVen+1
		vSClosed:=vSClosed+1
	: (vRS=True:C214)
		vSRS:=vSRS+1
	: (vNS=True:C214)
		vSNS:=vSNS+1
		vSClosed:=vSClosed+1
End case 