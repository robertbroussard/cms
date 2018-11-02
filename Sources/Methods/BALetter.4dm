//%attributes = {"publishedWeb":true}
  //G-Proc: BALetter;
_O_C_INTEGER:C282($Find)
_O_C_STRING:C293(2;$TFind)
If (vTempResult="STL")
	vElement:=0
	OK:=1
	While (OK=1)
		GetParties 
		vInstruct:="Select party for BA letter:"
		DIALOG:C40([LetterFile:15];"PartiesDialog")
		If (OK=1)
			If (aPartyLang{vElement}="S ")  // VELEMENT POINTER SET IN  DIALOG ABOVE
				SpanishRec_DLF (vElement;"BA Letter (S)";False:C215)
			End if 
			NewRec_DLF (vElement;"BA Letter (E)";False:C215)
			If (aPartyType{vElement}="C@")
				$TFind:="R1"
			Else 
				$TFind:="C1"
			End if 
			$Find:=Find in array:C230(aPartyType;$TFind)
			If ($Find#-1)
				If (aPartyLang{$Find}="S ")
					SpanishRec_DLF ($Find;"BA Letter (S)";True:C214)
				End if 
				NewRec_DLF ($Find;"BA Letter (E)";True:C214)
			End if 
			CONFIRM:C162("Do you want to send another BA letter for this case?")
			If (OK#1)
				EnterNotesText ("R";vInitials)
				CONFIRM:C162("Would you like to print letters now?")
				If (OK=1)
					PrintNow (vInitials)
				End if 
			End if 
		End if 
	End while 
Else 
	ALERT:C41("This case has not been settled. You can not print a BA Letter.")
	DoError (2;vInitials;vInitials)  // No Records generated yet.
End if 
  //I don't know about this error message here ???.