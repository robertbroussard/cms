  //Script: Field of [IntakeFile]InterimCon located on page 2 of "TestIntake".
C_LONGINT:C283($OK;$Insert)
C_TEXT:C284($Date;$Time)
C_TEXT:C284($Initials)
If (Modified:C32([IntakeFile:1]InterimCon:30))
	$OK:=1
	While ($OK=1)
		$Initials:=Uppercase:C13(Substring:C12(Request:C163("Please enter 2 Initials, no space: ");1;2))
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