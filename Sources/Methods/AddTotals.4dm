//%attributes = {"publishedWeb":true}
  //G-Procedure: AddTotals; Called from BuildPResults
  //
C_LONGINT:C283($1;$i)
aTotals{$1}{1}:=aTotals{$1}{1}+1  // 1 is Intakes 
Case of 
	: ([IntakeFile:1]CaseStatus:25="Hold")
		aTotals{$1}{2}:=aTotals{$1}{2}+1  // 2 is Hold
	: ([IntakeFile:1]CaseStatus:25="Referred")
		aTotals{$1}{3}:=aTotals{$1}{3}+1  // 3 is Referred
	: ([IntakeFile:1]CaseStatus:25="Direct Assistance")
		aTotals{$1}{4}:=aTotals{$1}{4}+1  // 4 Is Direct Assistance
	: ([IntakeFile:1]CaseStatus:25="Scheduled")
		aTotals{$1}{5}:=aTotals{$1}{5}+1  // 5 is Scheduled
		RELATE MANY:C262([IntakeFile:1]CaseNo:1)
		FIRST RECORD:C50([DocketFile:6])
		For ($i;1;Records in selection:C76([DocketFile:6]))
			Case of 
				: ([DocketFile:6]HResults:11="CON")
					aTotals{$1}{6}:=aTotals{$1}{6}+1  // 6 is Sch & Con
				: ([DocketFile:6]HResults:11="STL")
					aTotals{$1}{7}:=aTotals{$1}{7}+1  // 7 is Sch & Med
					aTotals{$1}{8}:=aTotals{$1}{8}+1  //8 is Sch & Stl
				: ([DocketFile:6]HResults:11="IMP")
					aTotals{$1}{7}:=aTotals{$1}{7}+1  // 7 is Sch & Med
					aTotals{$1}{9}:=aTotals{$1}{9}+1  // 9 is Sch & Imp
				: ([DocketFile:6]HResults:11="CONT")
					aTotals{$1}{7}:=aTotals{$1}{7}+1  // 7 is Sch & Med
					aTotals{$1}{10}:=aTotals{$1}{10}+1  // 10 is Sch & Cont
				: ([DocketFile:6]HResults:11="VEN")
					aTotals{$1}{11}:=aTotals{$1}{11}+1  // 11 is Sch & Ven
				: ([DocketFile:6]HResults:11="DCL")
					aTotals{$1}{12}:=aTotals{$1}{12}+1  // 12 is Sch & Dcl
				: ([DocketFile:6]HResults:11="NS")
					aTotals{$1}{13}:=aTotals{$1}{13}+1  // 13 is Sch & NS
				: ([DocketFile:6]HResults:11="R/S")
					aTotals{$1}{14}:=aTotals{$1}{14}+1  // 14 is Sch & RS
			End case 
			NEXT RECORD:C51([DocketFile:6])
		End for 
End case 