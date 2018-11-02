//%attributes = {"publishedWeb":true}
  //G-Proc: FMP_SchUpdate; this proc will update the variables for the FMP cases,
  //when the case status is = to Scheduled.
Case of 
	: (vStl=True:C214)
		vFMed:=vFMed+1
		vFStl:=vFStl+1
		vFClosed:=vFClosed+1
	: (vImp=True:C214)
		vFMed:=vFMed+1
		vFImp:=vFImp+1
		vFClosed:=vFClosed+1
	: (vCon=True:C214)
		vFCon:=vFCon+1
		vFClosed:=vFClosed+1
	: (vCont=True:C214)
		vFMed:=vFMed+1
		vFCont:=vFCont+1
	: (vDcl=True:C214)
		vFDcl:=vFDcl+1
		vFClosed:=vFClosed+1
	: (vVen=True:C214)
		vFVen:=vFVen+1
		vFClosed:=vFClosed+1
	: (vRS=True:C214)
		vFRS:=vFRS+1
	: (vNS=True:C214)
		vFNS:=vFNS+1
		vFClosed:=vFClosed+1
End case 