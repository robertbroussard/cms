//%attributes = {"publishedWeb":true}
  //G-Proc:XMP_SchUpdate; this proc will update the variables for the cases,
  // that dont have a correct suffix, when the case status is = to Scheduled.
  //
Case of 
	: (vStl=True:C214)
		vXMed:=vXMed+1
		vXStl:=vXStl+1
		vXClosed:=vXClosed+1
	: (vImp=True:C214)
		vXMed:=vXMed+1
		vXImp:=vXImp+1
		vXClosed:=vXClosed+1
	: (vCon=True:C214)
		vXCon:=vXCon+1
		vXClosed:=vXClosed+1
	: (vCont=True:C214)
		vXMed:=vXMed+1
		vXCont:=vXCont+1
	: (vDcl=True:C214)
		vXDcl:=vXDcl+1
		vXClosed:=vXClosed+1
	: (vVen=True:C214)
		vXVen:=vXVen+1
		vXClosed:=vXClosed+1
	: (vRS=True:C214)
		vXRS:=vXRS+1
	: (vNS=True:C214)
		vXNS:=vXNS+1
		vXClosed:=vXClosed+1
End case 