//%attributes = {"publishedWeb":true}
  //G-Proc: PrintCaseSum; This procedure prints the case summary for a Case. The
  //procedure is called from the "print summary" button on the Case Summary Screen.
vRelateText:=[IntakeFile:1]HowLong:18+" "+[IntakeFile:1]TPeriod:19
CREATE SET:C116([IntakeFile:1];"PrintSum")
ONE RECORD SELECT:C189([IntakeFile:1])
_O_ALL SUBRECORDS:C109([IntakeFile:1]AddPartyFile:21)
_O_ALL SUBRECORDS:C109([IntakeFile:1]Referrals:26)
If ([IntakeFile:1]AddPartyFlag:20=True:C214)
	vAPFlag:="Yes"
Else 
	vAPFlag:="No"
End if 
FORM SET OUTPUT:C54([IntakeFile:1];"CaseSumPrint")
ORDER BY:C49([IntakeFile:1]CaseNo:1;>)
ACCUMULATE:C303(x)
BREAK LEVEL:C302(0)
PAGE SETUP:C299([IntakeFile:1];"CaseSumPrint")
PRINT SELECTION:C60([IntakeFile:1];*)
FORM SET OUTPUT:C54([IntakeFile:1];"DisplaySel2")
USE SET:C118("PrintSum")
CLEAR SET:C117("PrintSum")