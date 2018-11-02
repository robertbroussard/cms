//%attributes = {"publishedWeb":true}
  //G-Proc: PrintHeader;
vRptName:=$1
vTimeFrame:="From: "+String:C10(vBegDate;7)+" To: "+String:C10(vEndDate;7)
vPrintDate:="Date Printed: "+String:C10(Current date:C33;7)+" Time: "+String:C10(Current time:C178;5)
PAGE SETUP:C299([IntakeFile:1];"RptHeader")
Print form:C5([IntakeFile:1];"RptHeader")