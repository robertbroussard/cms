//%attributes = {"publishedWeb":true}
  //G-Proc: PrintMedAct;

_O_C_INTEGER:C282($i;$Find;$Start;$Times)
_O_C_STRING:C293(20;$Type;$ActTitle)
vRatio:=0
vRatioTimes:=0
SORT ARRAY:C229(aMaster;>)
SORT ARRAY:C229(aMDate;aMKey;aMType;aMTime;aMResult;aMProg;>)
vGTotal:=0
For ($i;1;Size of array:C274(aMaster))
	$Finished:=False:C215
	$Times:=0
	$Header:=False:C215
	vTotalHours:=0
	vMed:=0
	vmafStl:=0
	vmafImp:=0
	While ($Finished=False:C215)
		$Times:=$Times+1
		$ActTitle:=""
		$Type:=""
		Case of 
			: ($Times=1)
				$Type:="Mediator"
				$ActTitle:="Mediations"
			: ($Times=2)
				$Type:="Co-mediator"
				$ActTitle:="Co-Mediations"
			: ($Times=3)
				$Type:="Ventilation"
				$ActTitle:="Ventilations"
			: ($Times=4)
				$Type:="Observer"
				$ActTitle:="Observations"
			: ($Times=5)
				$Type:="C.E."
				$ActTitle:="C.E. Activity"
			: ($Times=6)
				$Type:="DRC Contact"
				$ActTitle:="DRC Contacts"
			: ($Times=7)
				$Type:="Office Help"
				$ActTitle:="Office Help"
			: ($Times=8)
				$Type:="Trainer"
				$ActTitle:="Trainer"
			: ($Times=9)
				$Type:="Med. came; no cases"
				$ActTitle:="Med. came; no cases"
			Else 
				$Times:=0
		End case 
		$SubHeader:=False:C215
		$Start:=1
		vTimeSubT:=0
		Repeat 
			$Find:=Find in array:C230(aMKey;aMaster{$i};$Start)
			If ($Find#-1)
				$Start:=$Find
				If ((aMType{$find}="Arbitrator") | (aMType{$find}="Moderator-Admin") | (aMType{$find}="Moderator"))
					aMType{$find}:="Mediator"  // ARB & MOD NOT PRINTED ON STATUS RPT - TREATED AS MEDIATOR

				End if 
				If (aMType{$Find}=$Type)
					If (aMResult{$Find}="STL") & (aMType{$Find}#"Observer")
						vMed:=vMed+1
						vmafStl:=vmafStl+1
					Else 
						If (aMResult{$Find}="IMP") & (aMType{$Find}#"Observer")
							vMed:=vMed+1
							vmafImp:=vmafImp+1
						End if 
					End if 
					If ($Header=False:C215)
						$Header:=True:C214
						$Temp:="Mediator Activity Report for: "+aMaster{$i}
						PrintHeader ($Temp)
					End if 
					If ($SubHeader=False:C215)
						$SubHeader:=True:C214
						vSubDetail:=""
						Print form:C5([IntakeFile:1];"SubHead1")
						vText1:=$ActTitle
						vText2:="Date"
						vText3:="Hours"
						Print form:C5([IntakeFile:1];"SubHead2")
					End if 
					vText1:=aMProg{$Find}+" "+aMResult{$Find}
					vText2:=String:C10(aMDate{$Find};7)
					vText3:=String:C10(Trunc:C95(aMTime{$Find};2))
					vTimeSubT:=vTimeSubT+aMTime{$Find}
					Print form:C5([IntakeFile:1];"RptTextDetail")
					DELETE FROM ARRAY:C228(aMDate;$Find)
					DELETE FROM ARRAY:C228(aMType;$Find)
					DELETE FROM ARRAY:C228(aMTime;$Find)
					DELETE FROM ARRAY:C228(aMResult;$Find)
					DELETE FROM ARRAY:C228(aMKey;$Find)
					DELETE FROM ARRAY:C228(aMProg;$Find)
				Else 
					$Start:=$Find+1
				End if 
			Else 
				If ($Times=0)
					$Finished:=True:C214
				End if 
			End if 
		Until (($Find=-1) | ($Times=0))
		If ($SubHeader=True:C214)
			vText1:="Subtotal: "+$ActTitle
			vText2:=""
			vText3:=String:C10(Trunc:C95(vTimeSubT;2))
			vTotalHours:=vTotalHours+vTimeSubT
			Print form:C5([IntakeFile:1];"SubHead2")
		End if 
	End while 
	If ($Header=True:C214)
		vSubDetail:=""
		Print form:C5([IntakeFile:1];"SubHead1")
		vGTotal:=vGTotal+vTotalHours
		vSubDetail:="Total volunteer hours: "+String:C10(vTotalHours)
		Print form:C5([IntakeFile:1];"SubHead1")
		vSubDetail:=""
		Print form:C5([IntakeFile:1];"SubHead1")
		$TempNum:=(vmafStl/vMed)*100
		vRatio:=vRatio+$TempNum
		vRatioTimes:=vRatioTimes+1
		vSubDetail:="Mediator settlement rate: "+String:C10($TempNum;"###,##0.00")+" %"
		If (vPrintRate="n")
			vSubDetail:=""
		End if 
		Print form:C5([IntakeFile:1];"SubHead1")
		PAGE BREAK:C6
	End if 
End for 
If (vOption2=1)
	$Temp:="Summary Report for Group:  "+vSelection
	PrintHeader ($Temp)
	vSubDetail:="Total Volunteer Hours for Group:  "+vSelection+" "+String:C10(vGTotal;"###,##0.00")
	Print form:C5([IntakeFile:1];"SubHead1")
	vSubDetail:=""
	Print form:C5([IntakeFile:1];"SubHead1")
	vSubDetail:="Settlement Rate for Group:  "+String:C10(vRatio/vRatioTimes;"###,##0.00")+" %"
	Print form:C5([IntakeFile:1];"SubHead1")
	PAGE BREAK:C6
End if 