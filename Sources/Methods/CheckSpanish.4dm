//%attributes = {"publishedWeb":true}
  //G-Procedure: CheckSpanish;
  //
C_LONGINT:C283($Count)
$Temp:=False:C215
_O_ALL SUBRECORDS:C109([IntakeFile:1]AddPartyFile:21)
Case of 
	: ([IntakeFile:1]CLang:10="S ")
		$Temp:=True:C214
	: ([IntakeFile:1]RLang:15="S ")
		$Temp:=True:C214
	: (_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21)#0)
		For ($Count;1;_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21))
			If ([IntakeFile]AddPartyFile'Lang="S ")
				$Temp:=True:C214
			End if 
		End for 
End case 
Case of 
	: ($Temp=True:C214) & ([SiteConstraints:7]AllowSpanish:13=True:C214)
		$0:=True:C214
	: ($Temp=False:C215) & ([SiteConstraints:7]AllowSpanish:13=False:C215)
		$0:=True:C214
	: ($Temp=False:C215) & ([SiteConstraints:7]SpanishOnly:14=True:C214)
		$0:=False:C215
	: ($Temp=True:C214) & ([SiteConstraints:7]AllowSpanish:13=False:C215)
		$0:=False:C215
	: ($Temp=False:C215) & ([SiteConstraints:7]AllowSpanish:13=True:C214)
		$0:=True:C214
	Else 
		$0:=False:C215
End case 