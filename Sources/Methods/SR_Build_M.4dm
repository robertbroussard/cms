//%attributes = {"publishedWeb":true}
  // Proc=SR_Build_M.  From StateReport - load array to print MSC stats
  // input is <= vEndDate and in Intake file date order
  // $1 is State Code from dispute table
  //
C_BOOLEAN:C305($pend;$closed)
$pend:=False:C215
$closed:=False:C215
RELATE MANY:C262([IntakeFile:1]CaseNo:1)  //GET DOCKET  RECDS
If (Records in selection:C76([DocketFile:6])>1)
	ORDER BY:C49([DocketFile:6];[DocketFile:6]DocketDate:2;>)
End if 
LAST RECORD:C200([DocketFile:6])  // GET MOST RECENT RESULTS
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
			aStateM{$1}{1}:=aStateM{$1}{1}+1
		End if 
		  //
		  // SECTION II.  CASES RECEIVED DURING MONTH    
	: (([IntakeFile:1]IntakeDate:4>=vBegDate) & ([IntakeFile:1]IntakeDate:4<=vEndDate))
		Case of 
			: ([IntakeFile:1]RefBy:16="Co Civ @")
				aStateM{$1}{2}:=aStateM{$1}{2}+1
			: ([IntakeFile:1]RefBy:16="@ DC")
				aStateM{$1}{3}:=aStateM{$1}{3}+1
			Else 
				aStateM{$1}{4}:=aStateM{$1}{4}+1
		End case 
End case 
  //
  // SECTION III.  CASES CLOSED DURING MONTH
Case of 
	: (Records in selection:C76([DocketFile:6])<1)
		If (([IntakeFile:1]IntakeDate:4>=vBegDate) & ([IntakeFile:1]IntakeDate:4<=vEndDate))
			If ([IntakeFile:1]CaseStatus:25="referred")
				aStateM{$1}{6}:=aStateM{$1}{6}+1  // CLOSED, SETTLED PRIOR
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
			aStateM{$1}{7}:=aStateM{$1}{7}+1  // CLOSED, HEARING HELD
		: ([DocketFile:6]HResults:11="dcl")
			aStateM{$1}{8}:=aStateM{$1}{8}+1  // CLOSED, NO HEARING HELD
	End case 
End if 