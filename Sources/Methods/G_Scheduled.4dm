//%attributes = {"publishedWeb":true}
  //G-Procedure: Scheduled

  //

_O_C_INTEGER:C282($j;$NumOutside;$Insert)
_O_C_STRING:C293(1;$1)
RELATE MANY:C262([IntakeFile:1]CaseNo:1)
FIRST RECORD:C50([DocketFile:6])
$NumOutside:=0
$Closed:=False:C215
For ($j;1;Records in selection:C76([DocketFile:6]))
	vStl:=False:C215
	vImp:=False:C215
	vCon:=False:C215
	vCont:=False:C215
	vDcl:=False:C215
	vVen:=False:C215
	vRS:=False:C215
	vNS:=False:C215
	If ([DocketFile:6]DocketDate:2<vBegDate)
		NEXT RECORD:C51([DocketFile:6])
	Else 
		If ([DocketFile:6]DocketDate:2<=vEndDate)
			Case of 
				: ([DocketFile:6]HResults:11="STL")
					vStl:=True:C214
					$Closed:=True:C214
				: ([DocketFile:6]HResults:11="IMP")
					vImp:=True:C214
					$Closed:=True:C214
				: ([DocketFile:6]HResults:11="CON")
					vCon:=True:C214
					$Closed:=True:C214
				: ([DocketFile:6]HResults:11="CONT")
					vCont:=True:C214
				: ([DocketFile:6]HResults:11="DCL")
					vDcl:=True:C214
					$Closed:=True:C214
				: ([DocketFile:6]HResults:11="VEN")
					vVen:=True:C214
					$Closed:=True:C214
				: ([DocketFile:6]HResults:11="R/S")
					vRS:=True:C214
				: ([DocketFile:6]HResults:11="NS")
					vNS:=True:C214
					$Closed:=True:C214
				Else 
					$Insert:=Size of array:C274(aBIMResults)+1
					INSERT IN ARRAY:C227(aBIMResults;$Insert)
					aBIMResults{$Insert}:=[IntakeFile:1]CaseNo:1+":"+String:C10([IntakeFile:1]IntakeDate:4;7)
			End case 
			Case of 
				: ($1="A")
					ARB_SchUpdate 
				: (($1="C") | ($1="V"))  // COMBINE VOM W/COMMUNITY

					CBMP_SchUpdate 
				: ($1="F")
					FMP_SchUpdate 
				: ($1="J")
					JUMP_SchUpdate 
				: ($1="L")
					LMP_SchUpdate 
				: ($1="T")
					Truant_SchUpdate   //           TRUANT  12/2003

				: ($1="N")  //LTC

					MED_SchUpdate 
				: ($1="P")
					PROB_SchUpdate 
				: (($1="W") | ($1="K"))  //   1/01 - CFK COMBINED W/ CPS

					CPS_SchUpdate   // 8/99 - ADD CHILD PROTECTIVE SVC.

					  // : ($1="S")

					  //  SEMP_SchUpdate     ` 3/97 - ZERO SPECIAL ED

				Else 
					XMP_SchUpdate 
			End case 
			NEXT RECORD:C51([DocketFile:6])
		Else 
			If ([DocketFile:6]DocketDate:2>vEndDate)
				$NumOutside:=$NumOutside+1
			Else 
				$Insert:=Size of array:C274(aBadDate)+1
				INSERT IN ARRAY:C227(aBadDate;$Insert)
				aBadDate{$Insert}:=[IntakeFile:1]CaseNo:1+":"+String:C10([IntakeFile:1]IntakeDate:4;7)
			End if 
			NEXT RECORD:C51([DocketFile:6])
		End if 
	End if 
End for 
If (($NumOutside>0) & ($Closed=False:C215))
	Pen_Next ($1)
End if 