//%attributes = {"publishedWeb":true}
  //G-Proc: SR_Scheduled;
_O_C_INTEGER:C282($j;$1;$NumOutside)
RELATE MANY:C262([IntakeFile:1]CaseNo:1)
FIRST RECORD:C50([DocketFile:6])
$NumOutside:=0
$Closed:=False:C215
For ($j;1;Records in selection:C76([DocketFile:6]))
	If ([DocketFile:6]DocketDate:2<vBegDate)
		NEXT RECORD:C51([DocketFile:6])
	Else 
		If ([DocketFile:6]DocketDate:2<=vEndDate)
			Case of 
				: ([DocketFile:6]HResults:11="STL")
					aState{$1}{27}:=aState{$1}{27}+1  //SR: This line is for settled cases.
					$Closed:=True:C214
				: ([DocketFile:6]HResults:11="IMP")
					aState{$1}{28}:=aState{$1}{28}+1  //SR: This line is for impasses
					$Closed:=True:C214
				: ([DocketFile:6]HResults:11="CON")
					aState{$1}{23}:=aState{$1}{23}+1  //SR: This line is for conciliations
					$Closed:=True:C214
					  // : ([DocketFile]HResults="CONT")   `Cont's don't Count for the state report.
				: ([DocketFile:6]HResults:11="DCL")
					aState{$1}{31}:=aState{$1}{31}+1
					$Closed:=True:C214
				: ([DocketFile:6]HResults:11="VEN")
					aState{$1}{35}:=aState{$1}{35}+1
					$Closed:=True:C214
					  //: ([DocketFile]HResults="R/S")     `R/S's dont Count for the state report.
				: ([DocketFile:6]HResults:11="NS")
					aState{$1}{33}:=aState{$1}{33}+1
					$Closed:=True:C214
			End case 
			NEXT RECORD:C51([DocketFile:6])
		Else 
			If ([DocketFile:6]DocketDate:2>vEndDate)
				$NumOutside:=$NumOutside+1
			End if 
			NEXT RECORD:C51([DocketFile:6])
		End if 
	End if 
End for 
If (($NumOutside>0) & ($Closed=False:C215))
	aState{$1}{38}:=aState{$1}{38}+1
End if 