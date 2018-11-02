//%attributes = {"publishedWeb":true}
  // Proc=SR_Build_A.  From StateReport - load array to print Arbitration stats
  // input is <= vEndDate and in Intake file date order
  // $1 is State Code from dispute table
  //
C_BOOLEAN:C305($pend;$closed)
$pend:=False:C215
$closed:=False:C215
RELATE MANY:C262([IntakeFile:1]CaseNo:1)  //GET DOCKET  RECDS
If (Records in selection:C76([DocketFile:6])>1)
	ORDER BY:C49([DocketFile:6];[DocketFile:6]DocketDate:2;>)
	LAST RECORD:C200([DocketFile:6])  // GET MOST RECENT RESULTS
End if 
Case of 
		  //    
		  //    SECTION I.  CASES OPEN AT BEGINNING OF MONTH
	: ([IntakeFile:1]IntakeDate:4<vBegDate)
		Case of 
			: (([IntakeFile:1]CaseStatus:25="Hold") | ([IntakeFile:1]CaseStatus:25=""))
				$pend:=True:C214
			: ([IntakeFile:1]CaseStatus:25="Scheduled")
				Case of 
					: (Records in selection:C76([DocketFile:6])>0)
						If ([DocketFile:6]DocketDate:2>=vBegDate)
							$pend:=True:C214  // DOCKET DATE IN CURR MONTH IS PENDING HERE
						End if 
						If ([DocketFile:6]DocketDate:2<vBegDate)
							If (([DocketFile:6]HResults:11="R/S") | ([DocketFile:6]HResults:11=""))
								$pend:=True:C214
							End if 
						End if 
				End case 
		End case 
		If ($pend)
			aStateA{$1}{1}:=aStateA{$1}{1}+1
		End if 
		  //
		  // SECTION II.  CASES RECEIVED DURING MONTH    
	: (([IntakeFile:1]IntakeDate:4>=vBegDate) & ([IntakeFile:1]IntakeDate:4<=vEndDate))
		Case of 
			: ([IntakeFile:1]RefBy:16="Co Civ @")
				aStateA{$1}{2}:=aStateA{$1}{2}+1
			: ([IntakeFile:1]RefBy:16="@ DC")
				aStateA{$1}{3}:=aStateA{$1}{3}+1
			Else 
				aStateA{$1}{4}:=aStateA{$1}{4}+1
		End case 
End case 
  //
  // SECTION III.  CASES CLOSED DURING MONTH
Case of 
	: (Records in selection:C76([DocketFile:6])<1)
		If (([IntakeFile:1]IntakeDate:4>=vBegDate) & ([IntakeFile:1]IntakeDate:4<=vEndDate))
			If ([IntakeFile:1]CaseStatus:25="referred")
				aStateA{$1}{6}:=aStateA{$1}{6}+1  // CLOSED, SETTLED PRIOR
			End if 
		End if 
	: (([DocketFile:6]DocketDate:2>=vBegDate) & ([DocketFile:6]DocketDate:2<=vEndDate))
		If (([DocketFile:6]HResults:11#"") & ([DocketFile:6]HResults:11#"r/s"))
			$closed:=True:C214
		End if 
		If ([IntakeFile:1]CaseStatus:25="referred")
			$closed:=True:C214
		End if 
End case 
If ($closed)
	Case of 
		: (([DocketFile:6]HResults:11="stl") | ([DocketFile:6]HResults:11="imp"))
			aStateA{$1}{7}:=aStateA{$1}{7}+1  // CLOSED, HEARING HELD
		: ([DocketFile:6]HResults:11="dcl")
			aStateA{$1}{8}:=aStateA{$1}{8}+1  // CLOSED, NO HEARING HELD, DECLINED 
		: ([DocketFile:6]HResults:11="ns")
			aStateA{$1}{9}:=aStateA{$1}{9}+1  // CLOSED, NO HEARING HELD, NO SHOW              
		Else 
			aStateA{$1}{12}:=aStateA{$1}{12}+1  // CLOSED, NO HEARING HELD, OTHER  
	End case 
End if 