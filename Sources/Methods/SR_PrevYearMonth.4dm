//%attributes = {}
  //SR_PrevYearMonth

  //$1->$Date
  //$0-> $YearMonthVal

$DateVal:=$1

$MonthOf:=Month of:C24($DateVal)
$YearOf:=Year of:C25($DateVal)

If ($MonthOf=1)
	$MonthOf:=12
	$YearOf:=$YearOf-1
Else 
	$MonthOf:=$MonthOf-1
End if 

$0:=String:C10($YearOf)+String:C10($MonthOf;"00")