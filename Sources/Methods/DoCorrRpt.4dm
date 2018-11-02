//%attributes = {"publishedWeb":true}
  //G-Proc: DoCorrRpt;
ALERT:C41("Correspondence Report has been discontinued")
  //x:=0
  //DCR_Totals 
  //OUTPUT LAYOUT([LtrRptFile];"LRFDailyRpt")
  //PAGE SETUP([LtrRptFile];"LRFDailyRpt")
  //SORT SELECTION([LtrRptFile]TimePrinted;[LtrRptFile]LtrCaseNo;>)
  //ACCUMULATE(x)
  //BREAK LEVEL(0)
  //PRINT SELECTION([LtrRptFile])
  //DELETE SELECTION([LtrRptFile])