//%attributes = {"publishedWeb":true}
  // Print the figures for the State Report Part D for
  // Arbitration Program
  //
  // TOTAL CASES RECEIVED FOR ALL 7 COLUMNS - SECTION II
For ($i;1;7)
	For ($j;2;4)
		astateA{$i}{5}:=astateA{$i}{5}+astateA{$i}{$j}
	End for 
End for 
  // TOTAL CASES CLOSED - NO HEARING
For ($i;1;7)
	For ($j;8;12)
		astateA{$i}{13}:=astateA{$i}{13}+astateA{$i}{$j}
	End for 
End for 
  // TOTAL  ALL CASES CLOSED FOR ALL 7 COLUMNS - SECTION III
For ($i;1;7)
	astateA{$i}{14}:=astateA{$i}{6}+astateA{$i}{7}+astateA{$i}{13}
End for 
  // TOTAL PENDING AT MONTH END
For ($i;1;7)
	astateA{$i}{15}:=astateA{$i}{1}+astateA{$i}{5}-astateA{$i}{14}
End for 
  // TOTAL COLUMN 8 FOR 15 LINES
For ($i;1;15)
	For ($j;1;7)
		astateA{8}{$i}:=astateA{8}{$i}+astateA{$j}{$i}
	End for 
End for 
  //
  // PRINT REPORT FROM LINE AND TOTALS TABLES
vRptName:="State Report - Part D:  ARB"
vTimeFrame:="From: "+String:C10(vBegDate;7)+" To: "+String:C10(vEndDate;7)
vPrintDate:="Date Printed: "+String:C10(Current date:C33;7)
Print form:C5([IntakeFile:1];"RptHeader")
vSubDetail:=""
Print form:C5([IntakeFile:1];"SubHead1")
_O_ARRAY STRING:C218(40;aLineName;0)
INSERT IN ARRAY:C227(aLineName;1;15)  // LOAD TABLE WITH LINE LABELS
aLineName{1}:="I.  Cases Pending - Beginning"
aLineName{2}:="II. A.  Cases Rec. County"
aLineName{3}:="II. B.  Cases Rec. District"
aLineName{4}:="II. C.  Cases Rec. Other"
aLineName{5}:="(II.)  Total Cases Rec."
aLineName{6}:="III. A.  Cases Closed, Settled"
aLineName{7}:="III. B.  Cases Closed, Hearing"
aLineName{8}:="III. C1.  Cases Closed, No Hear-DCL"
aLineName{9}:="III. C2.  Cases Closed, No Hear-N/S"
aLineName{10}:="III. C3.  Cases Closed, No Hear-Crt Ord"
aLineName{11}:="III. C4.  Cases Closed, No Hear-Non Suit"
aLineName{12}:="III. C5.  Cases Closed, No Hear-Other"
aLineName{13}:="(III. C.)  Total Cases Closed, No Hear"
aLineName{14}:="(III.)  Total Cases Closed"
aLineName{15}:="IV.  Cases Pending, End of Month"
For ($i;1;15)
	v1a:=aLineName{$i}
	v2a:=astateA{1}{$i}
	v3a:=astateA{2}{$i}
	v4a:=astateA{3}{$i}
	v5a:=astateA{4}{$i}
	v6a:=astateA{5}{$i}
	v7a:=astateA{6}{$i}
	v8a:=astateA{7}{$i}
	v9a:=astateA{8}{$i}
	Print form:C5([IntakeFile:1];"StateDetailA")
End for 
PAGE BREAK:C6
