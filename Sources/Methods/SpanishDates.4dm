//%attributes = {"publishedWeb":true}
  //G-Proc: SpanishDates;
C_LONGINT:C283($Day;$Mon)
C_TEXT:C284($DayString;$MonString)
C_TEXT:C284($0)
$Day:=Day number:C114($1)
$Mon:=Month of:C24($1)
Case of 
	: ($Day=1)
		$DayString:="domingo"
	: ($Day=2)
		$DayString:="lunes"
	: ($Day=3)
		$DayString:="martes"
	: ($Day=4)
		$DayString:="miércoles"
	: ($Day=5)
		$DayString:="jueves"
	: ($Day=6)
		$DayString:="viernes"
	: ($Day=7)
		$DayString:="sábado"
	Else 
		$DayString:="!!! Improper day!!!"
End case 
Case of 
	: ($Mon=1)
		$MonString:="enero"
	: ($Mon=2)
		$MonString:="febrero"
	: ($Mon=3)
		$MonString:="marzo"
	: ($Mon=4)
		$MonString:="abril"
	: ($Mon=5)
		$MonString:="mayo"
	: ($Mon=6)
		$MonString:="junio"
	: ($Mon=7)
		$MonString:="julio"
	: ($Mon=8)
		$MonString:="agosto"
	: ($Mon=9)
		$MonString:="septiembre"
	: ($Mon=10)
		$MonString:="octubre"
	: ($Mon=11)
		$MonString:="noviembre"
	: ($Mon=12)
		$MonString:="diciembre"
	Else 
		$MonString:="!!! Improper Month !!!"
End case 
$0:=$DayString+", "+String:C10(Day of:C23($1))+" de "+$MonString+", "+String:C10(Year of:C25($1))