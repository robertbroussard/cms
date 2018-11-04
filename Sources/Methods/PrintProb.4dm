//%attributes = {"publishedWeb":true}
  //G-Proc: PrintProb; this procedure is called from HBA_Rpt and it prints
  //the contents of several text fields that were updated during the report
  //procedure.
  //
C_LONGINT:C283($i;$j;$Insert)
C_TEXT:C284($1)
If (Size of array:C274(ArrPtr->)>0)
	If (vPrintHead=True:C214)
		Print form:C5([IntakeFile:1];"hba_header")
		vPrintHead:=False:C215
	End if 
	vProbLine:=$1
	Print form:C5([IntakeFile:1];"hbaProb_Line")
	vProbLine:="Total cases this section: "+String:C10(Size of array:C274(ArrPtr->))+"."
	Print form:C5([IntakeFile:1];"hbaProb_Line")
	vNumLines:=vNumLines+1
	$NumTimes:=(Size of array:C274(ArrPtr->)\3)
	$NumLeft:=(Size of array:C274(ArrPtr->)%3)
	ARRAY TEXT:C222(aProbLine;0)
	For ($i;1;$NumTimes)
		INSERT IN ARRAY:C227(aProbLine;$i;1)
		For ($j;1;3)
			aProbLine{$i}:=aProbLine{$i}+ArrPtr->{$j}+";  "
		End for 
		DELETE FROM ARRAY:C228(ArrPtr->;1;3)
	End for 
	If ($NumLeft>0)
		$Insert:=Size of array:C274(aProbLine)+1
		INSERT IN ARRAY:C227(aProbLine;$Insert;1)
		For ($i;1;$NumLeft)
			aProbLine{$Insert}:=aProbLine{$Insert}+ArrPtr->{$i}+";  "
		End for 
	End if 
	For ($i;1;Size of array:C274(aProbLine))
		vProbLine:=aProbLine{$i}
		Print form:C5([IntakeFile:1];"hbaProb_Line")
		vNumLines:=vNumLines+1
		If (vNumLines>=40)
			PAGE BREAK:C6
			vPage:=vPage+1
			vPrintDate:="Printed: "+String:C10(Current date:C33;7)+"; Page: "+String:C10(vPage)
			vNumLines:=0
			Print form:C5([IntakeFile:1];"hba_header")
		End if 
	End for 
	If (vNumLines>=40)
		vNumLines:=0
		PAGE BREAK:C6
		vPrintHead:=True:C214
	End if 
End if 