//%attributes = {"publishedWeb":true}
  //G-Proc: PrintEnvelope;
  //
C_TEXT:C284($Zip;$Xerox)
$Xerox:="NO"
CONFIRM:C162("Are you printing with the Xerox Printer?";"Yes";"No")
If (OK=1)
	$Xerox:="YES"
End if 
GetAllParties 
vInstruct:="Select party for envelope:"
OK:=1
While (OK=1)
	DIALOG:C40([LetterFile:15];"PartiesDialog")
	If (OK=1)
		$Zip:=aZip{vElement}
		If ((Substring:C12($Zip;6;1)=" ") | (Substring:C12($Zip;6;1)="_"))
			$Zip:=Substring:C12(aZip{vElement};1;5)
		Else 
			$Zip:=Insert string:C231(aZip{vElement};"-";6)
		End if 
		Case of 
			: (aFirm{vElement}="")
				vText1:=Uppercase:C13(aPFName{vElement}+" "+aPLName{vElement})
				vText2:=Uppercase:C13(aStAdd{vElement})
				vText3:=Uppercase:C13(aCity{vElement}+", "+agpState{vElement}+"  "+$Zip)
				vText4:=""
			: (aFirm{vElement}#"")
				vText1:=Uppercase:C13(aPFName{vElement}+" "+aPLName{vElement})
				vText2:=Uppercase:C13(aFirm{vElement})
				vText3:=Uppercase:C13(aStAdd{vElement})
				vText4:=Uppercase:C13(aCity{vElement}+", "+agpState{vElement}+"  "+$Zip)
		End case 
		If (([IntakeFile:1]Program:32="J") & (aPartyType{vElement}="R@"))
			CONFIRM:C162("Include 'PARENT/GUARDIAN OF' in the address line?")
			If (OK=1)
				vText1:="PARENT/GUARDIAN OF "+vText1
			End if 
		End if 
		PAGE SETUP:C299([DailyLtrFile:14];"Envelopes2")
		If (OK=1)
			If ($Xerox="YES")
				PAGE SETUP:C299([DailyLtrFile:14];"EnvelopeXerox")
				PRINT SETTINGS:C106
				Print form:C5([DailyLtrFile:14];"EnvelopeXerox")
			Else 
				Print form:C5([DailyLtrFile:14];"EnvelopeCenter2")
			End if 
			PAGE BREAK:C6
		End if 
		CONFIRM:C162("Print another envelope?")
	End if 
End while 