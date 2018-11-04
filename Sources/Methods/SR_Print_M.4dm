//%attributes = {"publishedWeb":true}
  // Print the figures for the State Report Parts C for
  // MSC Program
  //
  // TOTAL CASES RECEIVED FOR ALL 7 COLUMNS - SECTION II
For ($i;1;7)
	For ($j;2;4)
		astatem{$i}{5}:=astatem{$i}{5}+astatem{$i}{$j}
	End for 
End for 
  // TOTAL CASES CLOSED FOR ALL 7 COLUMNS - SECTION III
For ($i;1;7)
	For ($j;6;8)
		astatem{$i}{9}:=astatem{$i}{9}+astatem{$i}{$j}
	End for 
End for 
  // TOTAL PENDING AT MONTH END
For ($i;1;7)
	astatem{$i}{10}:=astatem{$i}{1}+astatem{$i}{5}-astatem{$i}{9}
End for 
  // TOTAL COLUMN 8 FOR 10 LINES
For ($i;1;10)
	For ($j;1;7)
		astatem{8}{$i}:=astatem{8}{$i}+astatem{$j}{$i}
	End for 
End for 
  // PRINT REPORT FROM LINE AND TOTALS TABLES
vRptName:="State Report - Part C:  MSC"
vTimeFrame:="From: "+String:C10(vBegDate;7)+" To: "+String:C10(vEndDate;7)
vPrintDate:="Date Printed: "+String:C10(Current date:C33;7)
Print form:C5([IntakeFile:1];"RptHeader")
vSubDetail:=""
Print form:C5([IntakeFile:1];"SubHead1")
ARRAY TEXT:C222(aLineName;0)
INSERT IN ARRAY:C227(aLineName;1;10)  // LOAD TABLE WITH LINE LABELS
aLineName{1}:="I.  Cases Pending - Beginning"
aLineName{2}:="II. A.  Cases Rec. County"
aLineName{3}:="II. B.  Cases Rec. District"
aLineName{4}:="II. C.  Cases Rec. Other"
aLineName{5}:="(II.)  Total Cases Rec."
aLineName{6}:="III. A.  Cases Closed, Settled"
aLineName{7}:="III. B.  Cases Closed, Hearing"
aLineName{8}:="III. C.  Cases Closed, No Hearing"
aLineName{9}:="(III.)  Total Cases Closed"
aLineName{10}:="IV.  Cases Pending, End of Month"
For ($i;1;10)
	v1m:=aLineName{$i}
	v2m:=aStateM{1}{$i}
	v3m:=aStateM{2}{$i}
	v4m:=aStateM{3}{$i}
	v5m:=aStateM{4}{$i}
	v6m:=aStateM{5}{$i}
	v7m:=aStateM{6}{$i}
	v8m:=aStateM{7}{$i}
	v9m:=aStateM{8}{$i}
	Print form:C5([IntakeFile:1];"StateDetailM")
End for 
PAGE BREAK:C6