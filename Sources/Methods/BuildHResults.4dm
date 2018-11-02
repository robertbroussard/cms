//%attributes = {"publishedWeb":true}
  //G-Proc: BuildHResults
_O_C_INTEGER:C282($Con;$Stl;$Cont;$Held;$j)
ARRAY INTEGER:C220(aHRTotals;9;2)
_O_C_STRING:C293(5;vSch)
FIRST RECORD:C50([DocketFile:6])
For ($j;1;Records in selection:C76([DocketFile:6]))
	RELATE ONE:C42([DocketFile:6]DFCaseNo:4)
	ADD TO SET:C119([IntakeFile:1];"OKSet")
	Case of 
		: ([DocketFile:6]HResults:11="CON")
			aHRTotals{1}{1}:=aHRTotals{1}{1}+1  // 1 is Con
		: ([DocketFile:6]HResults:11="STL")
			aHRTotals{2}{1}:=aHRTotals{2}{1}+1  // 2 is Med
			aHRTotals{3}{1}:=aHRTotals{3}{1}+1  //3 is Stl
		: ([DocketFile:6]HResults:11="IMP")
			aHRTotals{2}{1}:=aHRTotals{2}{1}+1  // 2 is Med
			aHRTotals{4}{1}:=aHRTotals{4}{1}+1  // 4 is Imp
		: ([DocketFile:6]HResults:11="CONT")
			aHRTotals{2}{1}:=aHRTotals{2}{1}+1  // 2 is Med
			aHRTotals{5}{1}:=aHRTotals{5}{1}+1  // 5 is Cont
		: ([DocketFile:6]HResults:11="VEN")
			aHRTotals{6}{1}:=aHRTotals{6}{1}+1  // 6 is Ven
		: ([DocketFile:6]HResults:11="DCL")
			aHRTotals{7}{1}:=aHRTotals{7}{1}+1  // 7 is Dcl
		: ([DocketFile:6]HResults:11="NS")
			aHRTotals{8}{1}:=aHRTotals{8}{1}+1  // 8 is NS
		: ([DocketFile:6]HResults:11="R/S")
			aHRTotals{9}{1}:=aHRTotals{9}{1}+1  // 9 is RS
	End case 
	NEXT RECORD:C51([DocketFile:6])
End for 
$Con:=aHRTotals{1}{1}
$Stl:=aHRTotals{3}{1}
$Cont:=aHRTotals{5}{1}
$Held:=aHRTotals{2}{1}
vStlRate:=String:C10(Trunc:C95(($Con+$Stl)/(($Held+$Con)-$Cont)*100;2))
vHeld:=String:C10(aHRTotals{2}{1})
vSch:=String:C10(Records in set:C195("OKSet"))