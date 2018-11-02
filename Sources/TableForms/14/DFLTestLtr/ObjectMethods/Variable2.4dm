  //Script vControl1; on DLFTestLtr
  //
C_TEXT:C284(vFamStyle)
_O_C_STRING:C293(1;vControl1)
vInitials:=[DailyLtrFile:14]Initials:6
If ([DailyLtrFile:14]Spanish:24=True:C214)
	vText4:="Numero De Archivo: "+[DailyLtrFile:14]DLFCaseNo:1
	vPrintDate:="Fecha: "+SpanishDates (Current date:C33)
	vTitle:="Representante de DRC"
	Case of 
		: (([DailyLtrFile:14]LtrType:2="BA Letter (S)") & ([DailyLtrFile:14]Copy:25=False:C215))
			vP1:="Referente al caso entre: "+[DailyLtrFile:14]Style:12
			vP2:="Fecha de audiencia: "+[DailyLtrFile:14]SDate:22
			vP3:="Estimado/Estimada "+[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3+": "
			vP4:="Cont: Fotocopia del acuerdo"
			vP5:="c: "+[DailyLtrFile:14]OPName:11
			vP6:="    Archivo"
		: (([DailyLtrFile:14]LtrType:2="BA Letter (S)") & ([DailyLtrFile:14]Copy:25=True:C214))
			vP1:="Referente al caso entre: "+[DailyLtrFile:14]Style:12
			vP2:="Fecha de audiencia: "+[DailyLtrFile:14]SDate:22
			vP3:="Estimado/Estimada "+[DailyLtrFile:14]OPName2:26+":"
			vP4:="Cont: Fotocopia del acuerdo"
			vP5:="c: "+[DailyLtrFile:14]OPName:11
			vP6:="    Archivo"
		: ([DailyLtrFile:14]LtrType:2="Family@")
			vP1:=""
			vP2:="Referente al caso entre: "+[DailyLtrFile:14]Style:12
			vP3:="Estimado/Estimada "+[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3+":"
			vP4:=""
			vP5:=""
			vP6:=""
		Else 
			vP1:=""
			vP2:=""
			vP3:="Estimado/Estimada "+[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3+": "
			vP4:=""
			vP5:=""
			vP6:=""
	End case 
Else 
	vText4:="File Number: "+[DailyLtrFile:14]DLFCaseNo:1
	vPrintDate:="Date: "+String:C10(Current date:C33;3)
	vTitle:="Case Manager"
	Case of 
		: (([DailyLtrFile:14]LtrType:2="BA Letter (E)") & ([DailyLtrFile:14]Copy:25=False:C215))
			vP1:="In The matter of: "+[DailyLtrFile:14]Style:12
			vP2:="Mediation Date: "+String:C10([DailyLtrFile:14]DocDate:10;3)
			vP3:="Dear "+[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3+":"
			vP4:="Encl: Copy of Agreement"
			vP5:="c: "+[DailyLtrFile:14]OPName:11
			vP6:="    File Copy"
		: (([DailyLtrFile:14]LtrType:2="BA Letter (E)") & ([DailyLtrFile:14]Copy:25=True:C214))
			vP1:="In The matter of: "+[DailyLtrFile:14]Style:12
			vP2:="Mediation Date: "+String:C10([DailyLtrFile:14]DocDate:10;3)
			vP3:="Dear "+[DailyLtrFile:14]OPName2:26+":"
			vP4:="Encl: Copy of Agreement"
			vP5:="c: "+[DailyLtrFile:14]OPName:11
			vP6:="    File Copy"
		: ([DailyLtrFile:14]LtrType:2="Family@")
			vP1:=""
			vP2:="RE: Mediation between "+[DailyLtrFile:14]Style:12
			vP3:="Dear "+[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3+":"
			vP4:=""
			vP5:=""
			vP6:=""
		Else 
			vP1:=""
			vP2:=""
			vP3:="Dear "+[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3+":"
			  //      
			If (([DailyLtrFile:14]DLFCaseNo:1[[9]]="J") & ([DailyLtrFile:14]PAge:29<18))
				vP3:="Dear Parent/Guardian of "+[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3+":"
			End if 
			If (([DailyLtrFile:14]LtrType:2="JUMP@") & ([DailyLtrFile:14]DLFCaseNo:1[[9]]="D") & ([DailyLtrFile:14]PartyType:5="C@"))
				vP3:="Dear Parent/Guardian of "+[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3+":"
			End if 
			If (([DailyLtrFile:14]LtrType:2="JUMP@") & ([DailyLtrFile:14]DLFCaseNo:1[[9]]="D") & ([DailyLtrFile:14]PartyType:5="R@"))
				vP3:="Dear Parent/Guardian of "+[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3+":"
			End if 
			vP4:=""
			vP5:=""
			vP6:=""
	End case 
End if 