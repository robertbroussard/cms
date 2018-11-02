//%attributes = {"publishedWeb":true}
  //G-Procedure:Prior_Sch
  //
_O_C_INTEGER:C282($i;$Insert)
_O_C_STRING:C293(1;$1)
RELATE MANY:C262([IntakeFile:1]CaseNo:1)
FIRST RECORD:C50([DocketFile:6])
$CaseClosed:=False:C215
$InCurMonth:=False:C215
$InFuture:=False:C215
If (Records in selection:C76([DocketFile:6])>1)
	For ($i;1;Records in selection:C76([DocketFile:6]))
		If ([DocketFile:6]DocketDate:2<vBegDate)
			If ((([DocketFile:6]HResults:11#"CONT") & ([DocketFile:6]HResults:11#"R/S")) & ([DocketFile:6]HResults:11#""))
				$CaseClosed:=True:C214
			End if 
		Else 
			If ([DocketFile:6]DocketDate:2<=vEndDate)
				$InCurMonth:=True:C214
			Else 
				$InFuture:=True:C214
			End if 
		End if 
		NEXT RECORD:C51([DocketFile:6])
	End for 
	Case of 
		: (($CaseClosed=False:C215) & (($InCurMonth=True:C214) | ($InFuture=True:C214)))
			Pen_Prior ($1)  //$1 is the suffix from HBA_Rpt
			G_Scheduled ($1)
		: (($CaseClosed#True:C214) & (($InCurMonth#False:C215) & ($InFuture#False:C215)))
			$Insert:=Size of array:C274(aUnKnowProb)+1
			INSERT IN ARRAY:C227(aUnKnowProb;$Insert)
			aUnKnowProb{$Insert}:=[IntakeFile:1]CaseNo:1+":"+String:C10([IntakeFile:1]IntakeDate:4;4)
	End case 
Else   //These cases have only one record in the [DF], so they should have results.
	If ([DocketFile:6]DocketDate:2<vBegDate)
		If ((([DocketFile:6]HResults:11="CONT") | ([DocketFile:6]HResults:11="R/S")) | ([DocketFile:6]HResults:11=""))
			$Insert:=Size of array:C274(aBadResults)+1
			INSERT IN ARRAY:C227(aBadResults;$Insert)
			aBadResults{$Insert}:=[IntakeFile:1]CaseNo:1+":"+String:C10([IntakeFile:1]IntakeDate:4;7)
			Pen_Prior ($1)
			Pen_Next ($1)
		End if 
	Else 
		Pen_Prior ($1)
		G_Scheduled ($1)
	End if 
End if 