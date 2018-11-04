//%attributes = {"publishedWeb":true}
  //G-Proc: InitialNotice;
  //
C_TEXT:C284($TempLtr)
C_LONGINT:C283($i)
If ([IntakeFile:1]Program:32="J")
	If ([IntakeFile:1]CaseStatus:25="Hold")
		GetParties 
		For ($i;1;Size of array:C274(aPLName))
			If (aPartyLang{$i}="S ")
				$TempLtr:=GetLtrType (aPartyType{$i};aPartyLang{$i};[IntakeFile:1]Program:32;2)
				SpanishRec_DLF ($i;$TempLtr;False:C215)
			End if 
			$TempLtr:=GetLtrType (aPartyType{$i};"E ";[IntakeFile:1]Program:32;2)
			NewRec_DLF ($i;$TempLtr;False:C215)
		End for 
		EnterNotesText ("R";vInitials)
		CONFIRM:C162("Would you like to print letters now?")
		If (OK=1)
			PrintNow (vInitials)
		End if 
	Else 
		ALERT:C41("Initial notices can only be sent if the JUMP case is on Hold.")
	End if 
Else 
	ALERT:C41("This is not a JUMP case, you can't use this option;  use option 1.")
End if 