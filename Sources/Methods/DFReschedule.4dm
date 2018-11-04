//%attributes = {"publishedWeb":true}
  //G-Procedure: DFReschedule

C_LONGINT:C283($Blank;$Cont;$RS;$i)
C_TEXT:C284($Display1)
C_TEXT:C284($Display2)
C_TEXT:C284($1)
C_TEXT:C284($2)
$RS1:=False:C215
$RS2:=False:C215
$Error:=False:C215
$Blank:=0
$Cont:=0
$RS:=0
QUERY:C277([DocketFile:6];[DocketFile:6]DFCaseNo:4=$1)
Case of 
	: ((Records in selection:C76([DocketFile:6])=1) & ([DocketFile:6]HResults:11="R/S"))
		$RS:=1
	: ((Records in selection:C76([DocketFile:6])=1) & ([DocketFile:6]HResults:11="CONT"))
		$Cont:=1
	: (Records in selection:C76([DocketFile:6])>1)
		For ($i;1;(Records in selection:C76([DocketFile:6])))
			Case of 
				: ([DocketFile:6]HResults:11="")  //case1
					$Blank:=$Blank+1
				: ([DocketFile:6]HResults:11="CONT")  //case2
					$Cont:=$Cont+1
				: ([DocketFile:6]HResults:11="R/S")  //case3
					$RS:=$RS+1
				Else 
					ALERT:C41("ERROR RS1; This case is closed and can't be rescheduled.")
					$RS1:=True:C214  //error all other cases.
					$Error:=True:C214
			End case 
			NEXT RECORD:C51([DocketFile:6])
		End for 
	Else 
		ALERT:C41("Error RS2; No case found in docket file.")
		$RS2:=True:C214
		$Error:=True:C214
End case 
If ($Error=False:C215)
	Case of 
		: ((($Blank=0) & ($RS<=2)) | (($Blank=0) & ($Cont<=2)))
			QUERY:C277([DocketFile:6];[DocketFile:6]DFCaseNo:4=$1;*)
			QUERY:C277([DocketFile:6]; & ;[DocketFile:6]DocketSite:1=$2;*)
			QUERY:C277([DocketFile:6]; & ;[DocketFile:6]DocketDate:2=$3)
			If (Records in selection:C76([DocketFile:6])=1)
				SchCase 
			Else 
				ALERT:C41("There has been an error during the reschedule, contact administrator.")
			End if 
		: ($Blank>1)
			$Display1:=String:C10($Blank)+" entries in Docket File with no Hearing Results."
			$Display2:=" Case can not be rescheduled."
			ALERT:C41($Display1+$Display2)
		: (($RS>2) | ($Cont>2))
			If (($RS>2) & ($Cont<2))
				CONFIRM:C162("Case has been rescheduled "+String:C10($RS)+" times. Reschedule again?")
			Else 
				If (($Cont>2) & ($RS<2))
					CONFIRM:C162("Case has been continued "+String:C10($Cont)+" times. Continue again?")
				Else 
					CONFIRM:C162("Case has been continued "+String:C10($Cont)+" times and rescheduled "+String:C10($RS)+". Reschedule again?")
				End if 
			End if 
			If (OK=1)
				SchCase 
				If (vSchOK#1)
					ALERT:C41("Case "+$1+" has not been rescheduled.")
				End if 
			Else 
				ALERT:C41("ERROR RS3; Case can't be rescheduled.")
			End if 
	End case 
End if 