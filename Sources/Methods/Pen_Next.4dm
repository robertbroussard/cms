//%attributes = {"publishedWeb":true}
  //G-Procedure; Pen_Next  -  HBA_REPT,  Intake date < Begin date

  // for Hold and blank status.

  //

_O_C_INTEGER:C282($Insert;$Found)
_O_C_STRING:C293(1;$1)
Case of 
	: ($1="A")
		vAPenNext:=vAPenNext+1
	: (($1="C") | ($1="V"))  // 3/97- COMBINE VOM W/COMMUNITY

		vCPenNext:=vCPenNext+1
	: ($1="P")
		vPPenNext:=vPPenNext+1  // PROBATION    10/98

	: ($1="F")
		vFPenNext:=vFPenNext+1
	: ($1="J")
		vJPenNext:=vJPenNext+1
	: ($1="T")
		vTPenNext:=vTPenNext+1  //      TRUANT  -  11-03

	: ($1="L")
		vLPenNext:=vLPenNext+1
	: ($1="N")  //LTC

		vMPenNext:=vMPenNext+1
		  // : ($1="S")

		  //  vSPenNext:=vSPenNext+1    ` 3/97- ZERO SPECIAL ED

	: (($1="W") | ($1="K"))
		vWPenNext:=vWPenNext+1  // 8/99 - CHILD PROTECT. SVC.  1/01 - COMBINE W/ CFK

	Else 
		$Found:=Find in array:C230(aBadSuffix;[IntakeFile:1]CaseNo:1)
		If ($Found=-1)
			$Insert:=Size of array:C274(aBadSuffix)+1
			INSERT IN ARRAY:C227(aBadSuffix;$Insert)
			aBadSuffix{$Insert}:=[IntakeFile:1]CaseNo:1+":"+String:C10([IntakeFile:1]IntakeDate:4;7)
		End if 
		vXPenNext:=vXPenNext+1
End case 