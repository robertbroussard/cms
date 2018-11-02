//%attributes = {"publishedWeb":true}
  // FamDROCourt - called by FamDispo to get the real DRO court nbr from the 
  // Referred To list on the Intake file
  //
C_BOOLEAN:C305(vIsGalveston;vDRO_Sw)
vNoCourt:=0
$ValidCourt:=0
vIsGalveston:=False:C215
$Number:=Substring:C12([IntakeFile:1]RefBy:16;1;3)
If ((($Number>"244") & ($Number<"329")) | ($Number="214"))
	$ValidCourt:=1
	vJudDist:=$Number+"TH JUDICIAL DISTRICT"
End if 
If (Position:C15("Co Crt, Galves";[IntakeFile:1]RefBy:16)>0)
	vIsGalveston:=True:C214
	$ValidCourt:=1
End if 
If ([IntakeFile:1]RefBy:16="Fourteenth Crt Appls")
	$ValidCourt:=1
End if 
If ([IntakeFile:1]RefBy:16="CCL Wash Cty")
	$ValidCourt:=1
End if 
If ($ValidCourt=0)
	If (vJudDist="DRO")
		vDRO_Sw:=True:C214
		rDROSwY:=1
		rDROSwN:=0
	End if 
	_O_ALL SUBRECORDS:C109([IntakeFile:1]Referrals:26)
	If (_O_Records in subselection:C7([IntakeFile:1]Referrals:26)>0)
		For (i;1;_O_Records in subselection:C7([IntakeFile:1]Referrals:26))
			$Number:=Substring:C12([IntakeFile]Referrals'Referral;1;3)
			If (($Number>"244") & ($Number<"316"))
				vJudDist:=$Number+"TH JUDICIAL DISTRICT"
				$ValidCourt:=1
			End if 
			If (Position:C15("Co Crt, Galves";[IntakeFile]Referrals'Referral)>0)
				vIsGalveston:=True:C214
				$ValidCourt:=1
			End if 
			_O_NEXT SUBRECORD:C62([IntakeFile:1]Referrals:26)
		End for 
	End if 
	If ($ValidCourt=0)
		CONFIRM:C162("No referred-to Court:"+Char:C90(13)+Char:C90(13)+"OK -> return to main screen"+Char:C90(13)+"Cancel -> proceed w/o court")
		If (OK=1)
			vNoCourt:=1  // NO COURT LISTED, SO DO NOT PRINT
		Else 
			vNoCourt:=0  // NO COURT LISTED, BUT PRINT ANYWAY
		End if 
	End if 
End if 