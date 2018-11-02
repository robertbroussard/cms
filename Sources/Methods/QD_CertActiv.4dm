//%attributes = {"publishedWeb":true}
  // Total Mediator activity to check eligibility for certificates
  //
_O_C_INTEGER:C282(vCObs;vJObs;vCCom;vJCom;vFCom;$datectr)
C_REAL:C285(vCCE)
PRINT SETTINGS:C106
vprintdate:=String:C10(Current date:C33)
vpage:=0
valpha:=""
$linecount:=99
ALL RECORDS:C47([MediatorFile:9])
QUERY:C277([MediatorFile:9];[MediatorFile:9]CertFlag:17=True:C214)
ORDER BY:C49([MediatorFile:9];[MediatorFile:9]MKey:14)
FIRST RECORD:C50([MediatorFile:9])
ALERT:C41("Flagged Mediator Records Selected:  "+String:C10(Records in selection:C76([MediatorFile:9])))
For ($i;1;Records in selection:C76([MediatorFile:9]))
	RELATE MANY:C262([MediatorFile:9]MKey:14)
	If (Records in selection:C76([MedActFile:10])>0)
		ORDER BY:C49([MedActFile:10]ActDate:5;<)  // DESCENDING SORT
		FIRST RECORD:C50([MedActFile:10])
		vCCE:=0
		vCObs:=0
		vJObs:=0
		vCCom:=0
		vJCom:=0
		vFCom:=0
		vCMed:=0
		vJMed:=0
		$datectr:=1
		For ($j;1;Records in selection:C76([MedActFile:10]))
			Case of 
				: ([MedActFile:10]Role_Activity:4="Train@")
				: ([MedActFile:10]ActResults:8="VEN@")
				: ([MedActFile:10]ActResults:8="CONT")
				: ([MedActFile:10]Role_Activity:4="C.E.")
					vCCE:=vCCE+[MedActFile:10]AmtOfTime:6
				: ([MedActFile:10]Role_Activity:4="Obs@")
					If (([MedActFile:10]mafCaseNo:3[[9]]="j") | ([MedActFile:10]mafCaseNo:3[[9]]="v"))
						vJObs:=vJObs+1
					Else 
						vCObs:=vCObs+1
					End if 
				: ([MedActFile:10]Role_Activity:4="Co-med@")
					Case of 
						: (([MedActFile:10]mafCaseNo:3[[9]]="j") | ([MedActFile:10]mafCaseNo:3[[9]]="v"))
							vJCom:=vJCom+1
						: ([MedActFile:10]mafCaseNo:3[[9]]="F")
							vFCom:=vFCom+1
						Else 
							vCCom:=vCCom+1
					End case 
				: (([MedActFile:10]Role_Activity:4="med@") | ([MedActFile:10]Role_Activity:4="moder@") | ([MedActFile:10]Role_Activity:4="arb@"))
					Case of 
						: (([MedActFile:10]mafCaseNo:3[[9]]="j") | ([MedActFile:10]mafCaseNo:3[[9]]="v"))
							vJMed:=vJMed+1
						: ([MedActFile:10]mafCaseNo:3[[9]]="F")  // ALL FAMILY RECDS COUNTED AS CO-MEDIATIONS
							vFCom:=vFCom+1
						Else 
							vCMed:=vCMed+1
					End case 
			End case 
			NEXT RECORD:C51([MedActFile:10])
		End for 
		If ($datectr>0)
			vQual:=""
			If ((vCMed>=12) & (vCCom>=4) & (vCObs>=2) & (vCCE>=9))
				vQual:="MED"
			End if 
			If ((vJMed>=8) & (vJCom>=2) & (vJObs>=1))
				vQual:=vQual+"  V  "
			End if 
			vTotFam:=vFMed+vFCom
			If (vTotFam>=6)
				vQual:=vQual+"  F  "
			End if 
			If ($linecount>33)
				$linecount:=0
				vpage:=vpage+1
				PAGE BREAK:C6
				Print form:C5([MediatorFile:9];"PrtHdr_MedCert")
			End if 
			Print form:C5([MediatorFile:9];"PrtLin_MedCert")
			$linecount:=$linecount+1
		End if 
	End if 
	NEXT RECORD:C51([MediatorFile:9])
End for 
PAGE BREAK:C6