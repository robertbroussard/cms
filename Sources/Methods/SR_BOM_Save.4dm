//%attributes = {}
  //SR_BOM_Save

$YearMonth:=$1
$Filed:=$2

$YearNum:=Num:C11(Substring:C12($YearMonth;1;4))
$MonthNum:=Num:C11(Substring:C12($YearMonth;5;2))

If ($MonthNum=12)
	$MonthString:="01"
	$YearString:=String:C10($YearNum+1)
Else 
	$MonthString:=String:C10($MonthNum+1;"00")
	$YearString:=String:C10($YearNum)
End if 

$YearMonth:=$YearString+$MonthString

QUERY:C277([SR_BOM:22];[SR_BOM:22]YearMonth:2=$YearMonth)
$rec:=Records in selection:C76([SR_BOM:22])

If ($rec=0)
	CREATE RECORD:C68([SR_BOM:22])
	[SR_BOM:22]ID:1:=Sequence number:C244([SR_BOM:22])
	[SR_BOM:22]CurrDate:5:=Current date:C33(*)
	[SR_BOM:22]YearMonth:2:=$YearMonth
End if 

If ($Filed)
	VARIABLE TO BLOB:C532(aBOM;[SR_BOM:22]Filed:3)
Else 
	VARIABLE TO BLOB:C532(aBOM;[SR_BOM:22]NotFiled:4)
End if 

If (ok#1)
	BEEP:C151
	ALERT:C41("Problem saving BLOB..."+$YearMonth+".")
End if 

SAVE RECORD:C53([SR_BOM:22])