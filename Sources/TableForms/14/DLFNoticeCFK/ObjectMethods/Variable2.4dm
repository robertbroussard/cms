  //Script vControl1; on Form: DLFNoticeCFK
  //
C_TEXT:C284(vFamStyle)
C_TEXT:C284(vControl1)
vInitials:=[DailyLtrFile:14]Initials:6
If ([DailyLtrFile:14]Spanish:24=True:C214)
	vText4:="Numero De Archivo: "+[DailyLtrFile:14]DLFCaseNo:1
	vPrintDate:="Fecha: "+SpanishDates (Current date:C33)
	vLtrStyle:="Referente al caso entre: "+[DailyLtrFile:14]Style:12
	vTitle:="Representante de DRC"
	vP1:=""
	vP2:=""
	vP3:="Estimado/Estimada "+[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3+": "
	vP4:=""
	vP5:=""
	vP6:=""
Else 
	OBJECT SET FORMAT:C236([DailyLtrFile:14]DLFCaseNo:1;"####-####-#")
	vText4:="DRC File Number: "
	vPrintDate:="Date: "+String:C10(Current date:C33;3)
	vP1:=""
	vP2:=""
	vP3:="Dear "+[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3+":"
	  //vP4:=""
	  //vP6:=""
	vTitle:="Child Protection Mediation Program"
End if 