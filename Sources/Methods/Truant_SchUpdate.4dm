//%attributes = {"publishedWeb":true}
  //G-Proc: Old 'VOM_SchUpdate'  variable routine; this proc will update the
  // variables for the Truant Services program when the Status is
  // = to Scheduled. 
  //
Case of 
	: (vStl=True:C214)
		vTMed:=vTMed+1
		vTStl:=vTStl+1
		vTClosed:=vTClosed+1
	: (vImp=True:C214)
		vTMed:=vTMed+1
		vTImp:=vTImp+1
		vTClosed:=vTClosed+1
	: (vCon=True:C214)
		vTCon:=vTCon+1
		vTClosed:=vTClosed+1
	: (vCont=True:C214)
		vTMed:=vTMed+1
		vTCont:=vTCont+1
	: (vDcl=True:C214)
		vTDcl:=vTDcl+1
		vTClosed:=vTClosed+1
	: (vVen=True:C214)
		vTVen:=vTVen+1
		vTClosed:=vTClosed+1
	: (vRS=True:C214)
		vTRS:=vTRS+1
	: (vNS=True:C214)
		vTNS:=vTNS+1
		vTClosed:=vTClosed+1
End case 