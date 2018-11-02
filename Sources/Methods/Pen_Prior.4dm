//%attributes = {"publishedWeb":true}
  //G-Procedure: Pen_Prior - in HBA_Rept;  Intake Date< Begin date for

  // Hold or blank status.

_O_C_INTEGER:C282($Insert)
_O_C_STRING:C293(1;$1)
Case of 
	: ($1="A")
		vAPenPrior:=vAPenPrior+1
	: (($1="C") | ($1="V"))  // 3/97- COMBINE VOM W/COMMUNITY

		vCPenPrior:=vCPenPrior+1
	: ($1="P")
		vPPenPrior:=vPPenPrior+1
	: ($1="F")
		vFPenPrior:=vFPenPrior+1
	: ($1="J")
		vJPenPrior:=vJPenPrior+1
	: ($1="L")
		vLPenPrior:=vLPenPrior+1
	: ($1="T")
		vTPenPrior:=vTPenPrior+1  //        TRUANT   -  11-03

	: ($1="N")  //LTC

		vMPenPrior:=vMPenPrior+1
		  //: ($1="S")

		  //  vSPenPrior:=vSPenPrior+1  ` 3/97 -  REMOVE SPECIAL ED

	: (($1="W") | ($1="K"))
		vWPenPrior:=vWPenPrior+1  // 8/99 - CHILD PROTECT. SVC.      1/01 - CFK

	Else 
		$Insert:=Size of array:C274(aBadSuffix)+1
		INSERT IN ARRAY:C227(aBadSuffix;$Insert)
		aBadSuffix{$Insert}:=[IntakeFile:1]CaseNo:1+":"+String:C10([IntakeFile:1]IntakeDate:4;7)
		vXPenPrior:=vXPenPrior+1
End case 