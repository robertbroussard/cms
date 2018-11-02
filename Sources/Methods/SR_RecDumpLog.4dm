//%attributes = {}
  //SR_RecDumpLog

$par:=$1
$RptNum:=$2
$YearMonth:=$3
$Filed:=$4  //Filed or NotFiled
$CaseType:=$5
$ColVal:=$6
$Logic:=$CaseType+$ColVal

C_TIME:C306(vSRDoc)
C_TEXT:C284($CaseType;$ColVal;$Logic;$6;$5;$3;$1;$par;$YearMonth)

Case of 
	: ($Filed)
		$Type:="Filed"
		
	: (Not:C34($Filed))
		$Type:="NotFiled"
	Else 
		BEEP:C151
		$Type:=""
End case 


Case of 
	: ($par="Write") & (vSRDoc#?00:00:00?)
		  //vSRDoc:=Append document($txt)
		
		USE SET:C118("Final")
		$rec:=Records in set:C195("Final")
		FIRST RECORD:C50([IntakeFile:1])
		For ($i;1;$rec)
			$txt:=[IntakeFile:1]CaseNo:1+Char:C90(9)+String:C10([IntakeFile:1]IntakeDate:4)+Char:C90(9)+[IntakeFile:1]CLName:6+", "+[IntakeFile:1]CFName:7+Char:C90(9)+[IntakeFile:1]RefBy:16+Char:C90(9)+[IntakeFile:1]DisputeCode:22+Char:C90(9)+[IntakeFile:1]CaseStatus:25+Char:C90(9)+$YearMonth+Char:C90(9)+$Type+Char:C90(9)+$Logic+Char:C90(13)
			SEND PACKET:C103(vSRDoc;$txt)
			NEXT RECORD:C51([IntakeFile:1])
		End for 
		
		
	: ($par="Start")
		$CurrTime:=Current time:C178(*)
		vSR_StartTime:=$CurrTime
		$CurrDate:=Current date:C33(*)
		$YrStr:=String:C10(Year of:C25($CurrDate))
		$MonthStr:=String:C10(Month of:C24($CurrDate);"00")
		$DayStr:=String:C10(Day of:C23($CurrDate);"00")
		$HrStr:=String:C10($CurrTime\3600)
		$MinStr:=String:C10(($CurrTime\60)%60)
		
		$DocName:=$YrStr+$MonthStr+$DayStr+$HrStr+$MinStr+".txt"
		
		vSRDoc:=Create document:C266($DocName)
		
		
		If (ok=1)
			$txt:=""
			$txt:=$txt+$DocName+" ("+String:C10($RptNum)+")"+Char:C90(13)
			$txt:=$txt+"Date/Time: "+String:C10($CurrDate)+"/"+String:C10($CurrTime)+Char:C90(13)+Char:C90(13)
			$txt:=$txt+"CaseNum"+Char:C90(9)+"Int_Date"+Char:C90(9)+"C_Name"+Char:C90(9)+"RefBy"+Char:C90(9)+"DispCode"+Char:C90(9)+"Status"+Char:C90(9)+"YearMonth"+Char:C90(9)+"Type"+Char:C90(9)+"Logic"+Char:C90(13)
			
			SEND PACKET:C103(vSRDoc;$txt)
			  //CLOSE DOCUMENT(vSRDoc)
			
		Else 
			vSRDoc:=?00:00:00?
			
		End if 
		
		
	: ($par="End")
		$CurrTime:=Current time:C178(*)
		$ElapsedTime:=$CurrTime-vSR_StartTime
		$txt:="End Time: "+String:C10($CurrTime)+Char:C90(13)+"Elapsed Time: "+String:C10($ElapsedTime)+"."
		SEND PACKET:C103(vSRDoc;$txt)
		
		CLOSE DOCUMENT:C267(vSRDoc)
End case 