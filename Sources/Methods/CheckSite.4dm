//%attributes = {"publishedWeb":true}
  //G-Procedure:CheckSite

  //

C_TEXT:C284($TempSuffix)
C_TEXT:C284($1)  //CHG FROM '7' - CASE NBR

C_TEXT:C284($2)
QUERY:C277([SiteConstraints:7];[SiteConstraints:7]Site:1=$2)
If (Records in selection:C76([SiteConstraints:7])=1)
	$TempSuffix:=Substring:C12($1;9;1)  // CASE NBR DISPLACEMENT FOR PROGRAM CODE
	
	Case of 
		: ($TempSuffix="C") & ([SiteConstraints:7]CBMP:3=True:C214)
			$0:=True:C214
		: ($TempSuffix="C") & ([SiteConstraints:7]CommDev:20=True:C214)  // COMMUN DEV- WAS 'D'
			
			$0:=True:C214
		: ($TempSuffix="J") & ([SiteConstraints:7]JUMP:5=True:C214)
			$0:=True:C214
		: ($TempSuffix="S") & ([SiteConstraints:7]SEMP:7=True:C214)
			$0:=True:C214
		: ($TempSuffix="F") & ([SiteConstraints:7]FMP:4=True:C214)
			$0:=True:C214
		: ($TempSuffix="L") & ([SiteConstraints:7]LMP:6=True:C214)
			$0:=True:C214
		: ($TempSuffix="M") & ([SiteConstraints:7]MSC:18=True:C214)
			$0:=True:C214
		: ($TempSuffix="A") & ([SiteConstraints:7]Arbitration:19=True:C214)
			$0:=True:C214
		: ($TempSuffix="V") & ([SiteConstraints:7]VOMP:17=True:C214)
			$0:=True:C214
		: ($TempSuffix="P") & ([SiteConstraints:7]Prob:21=True:C214)  // PROBATION
			
			$0:=True:C214
		: ($TempSuffix="W") & ([SiteConstraints:7]CPS:22=True:C214)  // CHILD PROTECT. SVC.
			
			$0:=True:C214
		: ($TempSuffix="K") & ([SiteConstraints:7]CFK:23=True:C214)  // COOPERATE FOR  KIDS
			
			$0:=True:C214
		: ($TempSuffix="T") & ([SiteConstraints:7]Truant:24=True:C214)  //   TRUANT
			
			$0:=True:C214
		: ($TempSuffix="N") & ([SiteConstraints:7]LTC:25=True:C214)  //   Long-Term Care (LTC)
			
			$0:=True:C214
		Else 
			$0:=False:C215
			ALERT:C41("Error in Site: "+$TempSuffix+" Program not allowed."+Char:C90(13)+Char:C90(13)+"Verify [SiteConstraints] settings.")
	End case 
Else 
	$0:=False:C215
	ALERT:C41("Error in 'CheckSite' procedure;If Statement.")
End if 