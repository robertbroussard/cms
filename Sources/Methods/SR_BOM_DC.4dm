//%attributes = {}
  //SR_BOM_DC
  //(StateReport_BOM DataCheck)
  //Also loads BOM arrays...
  //11/15/06

  //$1-> YearMonth
  //$2-> True=Filed AND False=NotFiled
C_BOOLEAN:C305($0)

$YearMonth:=$1
$Filed:=$2
QUERY:C277([SR_BOM:22];[SR_BOM:22]YearMonth:2=$YearMonth)
$rec:=Records in selection:C76([SR_BOM:22])

If ($rec=0)
	BEEP:C151
	CONFIRM:C162("There is NO Beginning Of Month (BOM) data for this report... Would you like to co"+"ntinue?")
Else 
	If ($rec#1)
		BEEP:C151
		CONFIRM:C162("Unexpected Selection [SR_BOM]. Notify the Database Administrator. Continue?")
	End if 
End if 

If (ok=1)
	  //QUERY([SR_BOM];[SR_BOM]YearMonth=$YearMonth)
	  //$rec:=Records in selection([SR_BOM])
	If ($rec#0)
		If ($Filed)
			BLOB TO VARIABLE:C533([SR_BOM:22]Filed:3;aBOM)
		Else 
			BLOB TO VARIABLE:C533([SR_BOM:22]NotFiled:4;aBOM)
		End if 
		
	Else 
		ARRAY LONGINT:C221(aBOM;0)
	End if 
	$0:=True:C214
Else 
	$0:=False:C215
End if 