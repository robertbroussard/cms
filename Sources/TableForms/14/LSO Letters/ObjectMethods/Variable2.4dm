  //Script: vControl2; on LSOLetters.
_O_C_STRING:C293(1;vControl2)
vInitials:=[DailyLtrFile:14]Initials:6
If ([DailyLtrFile:14]Spanish:24=True:C214)
	vText4:="Numero De Caso: "+[DailyLtrFile:14]DLFCaseNo:1
	vPrintDate:="Fecha: "+SpanishDates (Current date:C33)
	vTitle:="Representante de DRC"
	vP3:="Estimado/Estimada "+[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3+": "
Else 
	vText4:="Case Number: "+[DailyLtrFile:14]DLFCaseNo:1
	vPrintDate:="Date: "+String:C10(Current date:C33;3)
	vTitle:=" Case Manager"
	vP3:="Dear "+[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3+":"
	If (([DailyLtrFile:14]DLFCaseNo:1[[9]]="J") & ([DailyLtrFile:14]PartyType:5="R@"))
		vP3:="Dear Parent/Guardian of "+[DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3+":"
	End if 
End if 