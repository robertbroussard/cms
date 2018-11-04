//%attributes = {"publishedWeb":true}
  //G-Proc: GetReqDate;
  //
C_TEXT:C284($Display1)
C_TEXT:C284($Display2)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($MainLoop)
$Display2:=""
$LangOK:=False:C215
$SiteOK:=False:C215
vDayOK:=False:C215
vAdvanced:=True:C214
$Date:=vDate
$MainLoop:=1
While ($MainLoop=1)
	$MainLoop:=0
	$SiteOK:=CheckSite ($1;$2)  //$1=[IntakeFile]CaseNo & $2=vSite from SchCase.
	If ($SiteOK=True:C214)
		$LangOK:=CheckSpanish 
		If ($LangOK=True:C214)
			Repeat 
				$Date:=CheckProgDay2 ($Date)
				$Date:=CheckInvalid2 ($Date)
				If ((vDayOK#True:C214) | (vAdvanced#False:C215))
					$Date:=GetUserDecision ($Date)
				End if 
			Until ((vDayOK=True:C214) & (vAdvanced=False:C215))
			$0:=$Date
		Else 
			$Display1:="Site and language don't match!"+Char:C90(13)
			$Display2:="Click OK to choose new site or Cancel to quit."
			CONFIRM:C162($Display1+$Display2)
			If (OK=1)
				vSCLoop1:=1  //Turn on the first loop in SchCase.
			End if 
			$0:=!00-00-00!
		End if 
	Else 
		$Display1:="This program is not allowed at "+$2+"."
		$Display2:="Click OK to choose new site or Cancel to quit."
		CONFIRM:C162($Display1+$Display2)
		If (OK=1)
			vSCLoop1:=1  //Turn on the first loop in SchCase.
			$0:=!00-00-00!
		End if 
	End if 
End while 