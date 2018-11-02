//%attributes = {"publishedWeb":true}
  //G-Proc: JUMP_SchUpdate; this proc will update the variables for the JUMP cases,
  //when the case status is = to Scheduled.
Case of 
	: (vStl=True:C214)
		vJMed:=vJMed+1
		vJStl:=vJStl+1
		vJClosed:=vJClosed+1
	: (vImp=True:C214)
		vJMed:=vJMed+1
		vJImp:=vJImp+1
		vJClosed:=vJClosed+1
	: (vCon=True:C214)
		vJCon:=vJCon+1
		vJClosed:=vJClosed+1
	: (vCont=True:C214)
		vJMed:=vJMed+1
		vJCont:=vJCont+1
	: (vDcl=True:C214)
		vJDcl:=vJDcl+1
		vJClosed:=vJClosed+1
	: (vVen=True:C214)
		vJVen:=vJVen+1
		vJClosed:=vJClosed+1
	: (vRS=True:C214)
		vJRS:=vJRS+1
	: (vNS=True:C214)
		vJNS:=vJNS+1
		vJClosed:=vJClosed+1
End case 