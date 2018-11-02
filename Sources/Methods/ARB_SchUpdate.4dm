//%attributes = {"publishedWeb":true}
  //G-Proc: ARB_SchUpdate; this proc will update the variables for Arbitration cases
  //when the case status is = to Scheduled.
Case of 
	: (vStl=True:C214)
		vAMed:=vAMed+1
		vAStl:=vAStl+1
		vAClosed:=vAClosed+1
	: (vImp=True:C214)
		vAMed:=vAMed+1
		vAImp:=vAImp+1
		vAClosed:=vAClosed+1
	: (vCon=True:C214)
		vACon:=vACon+1
		vAClosed:=vAClosed+1
	: (vCont=True:C214)
		vAMed:=vAMed+1
		vACont:=vACont+1
	: (vDcl=True:C214)
		vADcl:=vADcl+1
		vAClosed:=vAClosed+1
	: (vVen=True:C214)
		vAVen:=vAVen+1
		vAClosed:=vAClosed+1
	: (vRS=True:C214)
		vARS:=vARS+1
	: (vNS=True:C214)
		vANS:=vANS+1
		vAClosed:=vAClosed+1
End case 