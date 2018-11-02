//%attributes = {"publishedWeb":true}
  //G-Proc: PrintFamilySum; This procedure prints the case summary for a Family Case
  //procedure is called from the "print family sum" button on the 4th Case Summary
  //Screen.
  //
vRelateText:=[IntakeFile:1]HowLong:18+" "+[IntakeFile:1]TPeriod:19
vMarStatTxt:=[FamilyFile:20]FMarStatLen:5+" "+[FamilyFile:20]FMarStatUnit:96
CREATE SET:C116([IntakeFile:1];"PrintFamSum")
ONE RECORD SELECT:C189([IntakeFile:1])
_O_ALL SUBRECORDS:C109([IntakeFile:1]AddPartyFile:21)
_O_ALL SUBRECORDS:C109([IntakeFile:1]Referrals:26)
FORM SET OUTPUT:C54([IntakeFile:1];"FamSumPrint")
ORDER BY:C49([IntakeFile:1]CaseNo:1;>)
ACCUMULATE:C303(x)
BREAK LEVEL:C302(0)
PAGE SETUP:C299([IntakeFile:1];"FamSumPrint")
PRINT SELECTION:C60([IntakeFile:1];*)
FORM SET OUTPUT:C54([IntakeFile:1];"DisplaySel2")
USE SET:C118("PrintFamSum")
CLEAR SET:C117("PrintFamSum")