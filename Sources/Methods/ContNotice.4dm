//%attributes = {"publishedWeb":true}
  //G-Proc: ContNotice;
  //
_O_C_INTEGER:C282($i)
_O_C_STRING:C293(30;$LetterType;$TempLtr)
If ([IntakeFile:1]Program:32="F")
	If (vBlank=1)
		$LetterType:="Family Cont Notice"
		GetParties 
		For ($i;1;Size of array:C274(aPLName))
			If (aPartyLang{$i}="S ")
				$TempLtr:=GetLtrType (aPartyType{$i};"S ";[IntakeFile:1]Program:32;3)
				SpanishRec_DLF ($i;$TempLtr;False:C215)
			End if 
			$TempLtr:=GetLtrType (aPartyType{$i};"E ";[IntakeFile:1]Program:32;3)
			NewRec_DLF ($i;$TempLtr;False:C215)
		End for 
		EnterNotesText ("R";vInitials)
		CONFIRM:C162("Would you like to print letters now?")
		If (OK=1)
			PrintNow (vInitials)
		End if 
	Else 
		ALERT:C41("This case has a problem with the hearing results. Letters will not be printed.")
	End if 
Else 
	ALERT:C41("This is not a Family case, you can't use this option;  use option 1.")
	  //probably should do an error message here???.
End if 