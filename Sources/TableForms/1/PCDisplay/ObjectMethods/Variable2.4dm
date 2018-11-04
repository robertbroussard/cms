  //Script: bSummaries; This procedure prints the case summary for
  //each case in the selection and the button is located on "PCDisplay".
C_LONGINT:C283($i;$j)
$J:=Records in selection:C76([IntakeFile:1])
vPrintDate:=String:C10(Current date:C33)
FIRST RECORD:C50([IntakeFile:1])
PAGE SETUP:C299([IntakeFile:1];"CaseSumPrint")
FORM SET OUTPUT:C54([IntakeFile:1];"CaseSumPrint")
CONFIRM:C162("Print all the case summaries?")
If (OK=1)
	For ($i;1;$j)
		CREATE SET:C116([IntakeFile:1];"PrintSum")
		ONE RECORD SELECT:C189([IntakeFile:1])
		vRelateText:=[IntakeFile:1]HowLong:18+" "+[IntakeFile:1]TPeriod:19
		_O_ALL SUBRECORDS:C109([IntakeFile:1]AddPartyFile:21)
		_O_ALL SUBRECORDS:C109([IntakeFile:1]Referrals:26)
		If ([IntakeFile:1]AddPartyFlag:20=True:C214)
			vAPFlag:="Yes"
		Else 
			vAPFlag:="No"
		End if 
		ORDER BY:C49([IntakeFile:1]CaseNo:1;>)  //10/26/93
		BREAK LEVEL:C302(0)
		ACCUMULATE:C303(x)
		PRINT SELECTION:C60([IntakeFile:1];*)
		USE SET:C118("PrintSum")
		CLEAR SET:C117("PrintSum")
		NEXT RECORD:C51([IntakeFile:1])
	End for 
End if 
USE SET:C118("PCTempSet")
ORDER BY:C49([IntakeFile:1];[IntakeFile:1]CaseNo:1;>)
FORM SET OUTPUT:C54([IntakeFile:1];"PCDisplay")