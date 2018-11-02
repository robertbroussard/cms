  //Script: Field of [IntakeFile]InterimCon located on page 2 of "Coutbased input...".
_O_C_INTEGER:C282($OK;$Insert)
_O_C_STRING:C293(10;$Date)
_O_C_STRING:C293(8;$Time)
_O_C_STRING:C293(2;$Initials)
If (Modified:C32([IntakeFile:1]InterimCon:30))
	$OK:=1
	While ($OK=1)
		$Initials:=(Uppercase:C13(Request:C163("Please enter your Initials: ")))
		If (($Initials#"") & (OK#0))
			$Insert:=Length:C16([IntakeFile:1]InterimCon:30)+2
			$Date:=String:C10(Current date:C33;7)
			$Time:=String:C10(Current time:C178;5)
			  //$String:=Insert string([IntakeFile]InterimCon;"  ("+$Date+" @ "+$Time+" "+$Initials+")";$Insert)
			$String:="  ("+$Date+" @ "+$Time+" "+$Initials+")"
			[IntakeFile:1]InterimCon:30:=[IntakeFile:1]InterimCon:30+$String
			$OK:=0
		Else 
			CONFIRM:C162("You must enter your initials!")
			If (OK#1)
				$OK:=0
			End if 
		End if 
	End while 
End if 