  //  FORM IS "Envelope Center" under Daily Letter File
  //  Form Method is "vText1"
  //  If Program is "J" & age is <18, insert "to Parent/Guardian of" in greeting
  //
C_TEXT:C284($Zip)
$Zip:=[DailyLtrFile:14]PZip:17
If ((Substring:C12($Zip;6;1)=" ") | (Substring:C12($Zip;6;1)="_"))
	$Zip:=Substring:C12([DailyLtrFile:14]PZip:17;1;5)
Else 
	$Zip:=Insert string:C231([DailyLtrFile:14]PZip:17;"-";6)
End if 
vText1:=""
$CheckOff:=0
Case of 
	: ([DailyLtrFile:14]PFirm:13="")
		vText1:=Uppercase:C13([DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3)
		vText2:=Uppercase:C13([DailyLtrFile:14]PStAddress:14)
		vText3:=Uppercase:C13([DailyLtrFile:14]PCity:15+", "+[DailyLtrFile:14]PState:16+"  "+$Zip)
		vText4:=""
	: ([DailyLtrFile:14]PFirm:13#"")
		vText1:=Uppercase:C13([DailyLtrFile:14]FName:4+" "+[DailyLtrFile:14]LName:3)
		vText2:=Uppercase:C13([DailyLtrFile:14]PFirm:13)
		vText3:=Uppercase:C13([DailyLtrFile:14]PStAddress:14)
		vText4:=Uppercase:C13([DailyLtrFile:14]PCity:15+", "+[DailyLtrFile:14]PState:16+"  "+$Zip)
End case 
If (([DailyLtrFile:14]DLFCaseNo:1[[9]]="J") & ([DailyLtrFile:14]PAge:29<18))
	vText1:="PARENT/GUARDIAN OF "+vText1
	$CheckOff:=1
End if 
If ($CheckOff#1)
	If (([DailyLtrFile:14]LtrType:2="JUMP@") & ([DailyLtrFile:14]PartyType:5="R@"))
		  //vText1:="PARENT/GUARDIAN OF "+vText1
	End if 
End if 