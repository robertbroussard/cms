//%attributes = {"publishedWeb":true}
  // (P) GetFamParties - called by FamilyDispo - 
  // copies additional parties, except attorneys, to FamDispo style
  //
C_TEXT:C284(vStyle)
$FDStyleC:=""
$FDStyleR:=""
$FDStyleX:=""
$Spacer:=""
If (vJudDist="JP@")  // JP DISPOS NEED EXTRA SPACE AROUND 'AND' IN STYLE
	$Spacer:=" "
End if 
_O_QUERY SUBRECORDS:C108([IntakeFile:1]AddPartyFile:21;[IntakeFile]AddPartyFile'APType[[1]]#"A")
If (_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21)>0)
	_O_ORDER SUBRECORDS BY:C107([IntakeFile:1]AddPartyFile:21;[IntakeFile]AddPartyFile'APType;>;[IntakeFile]AddPartyFile'LastName;>)
	For ($i;1;_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21))
		If ([IntakeFile]AddPartyFile'APType[[1]]#"A")  // SKIP ATTORNEYS
			Case of   // BUILD STYLE IN ORDER: Cs, Rs, OTHERs
				: ([IntakeFile]AddPartyFile'APType[[1]]="C")
					$FDStyleC:=$FDStyleC+"AND "+[IntakeFile]AddPartyFile'FirstName+" "
					$FDStyleC:=$FDStyleC+[IntakeFile]AddPartyFile'LastName+Char:C90(13)+$Spacer
				: ([IntakeFile]AddPartyFile'APType[[1]]="R")
					$FDStyleR:=$FDStyleR+"AND "+[IntakeFile]AddPartyFile'FirstName+" "
					$FDStyleR:=$FDStyleR+[IntakeFile]AddPartyFile'LastName+Char:C90(13)+$Spacer
				Else 
					$FDStyleX:=$FDStyleX+"AND "+[IntakeFile]AddPartyFile'FirstName+" "
					$FDStyleX:=$FDStyleX+[IntakeFile]AddPartyFile'LastName+Char:C90(13)+$Spacer
			End case 
		End if 
		_O_NEXT SUBRECORD:C62([IntakeFile:1]AddPartyFile:21)
	End for 
End if 
  //
If (vJudDist="JP@")  // JP COURT HAS ALL NAMES IN 1 LINE
	If (_O_Records in subselection:C7([IntakeFile:1]AddPartyFile:21)<1)
		$FDStyle:=vFullNameC+" and "+$FDStyleC+" "+vFullNameR+", "
	Else   // INSERT 'AND' BETWEEN C AND R NAMES
		$FDStyle:=vFullNameC+",  "+$FDStyleC+" "+vFullNameR+", "
	End if 
	$FDStyle:=$FDStyle+$FDStyleR+" "+$FDStyleX
	$Len:=Length:C16($FDStyle)
	$Ctr:=Length:C16($FDStyle)
	While (((Substring:C12($FDStyle;$Ctr;5))#" AND ") & ($Ctr>1))
		$Ctr:=$Ctr-1  // COUNT FROM END OF STYLE TO FIND LAST 'AND'
	End while 
	If ((Substring:C12($FDStyle;$Ctr;5))=" AND ")
		$FDStyle:=Change string:C234($FDStyle;" XXX ";$Ctr)  // MARK LAST 'AND'
	End if 
	$FDStyle:=Replace string:C233($FDStyle;" AND ";" ")  // DELETE ALL OTHER 'AND's
	$FDStyle:=Replace string:C233($FDStyle;Char:C90(13);", ")
	$FDStyle:=Replace string:C233($FDStyle;"XXX";"and ")
	$FDStyle:=Replace string:C233($FDStyle;"   ";" ")  // REMOVE TRIPLE SPACES
	$FDStyle:=Replace string:C233($FDStyle;"  ";" ")  // REMOVE DOUBLE SPACES
Else 
	$FDStyle:=$FDStyleC
	If ($FDStyleR>"")
		$FDStyle:=$FDStyle+$FDStyleR
	End if 
	If ($FDStyleX>"")
		$FDStyle:=$FDStyle+$FDStyleX
	End if 
End if 
$Len:=Length:C16($FDStyle)
If ($Len>0)  // REMOVE COMMAS IN LAST 4 PLACES
	For ($i;0;3)
		If ($FDStyle[[$Len-$i]]=",")
			$FDStyle[[$Len-$i]]:=" "
		End if 
	End for 
End if 
vStyle:=$FDStyle