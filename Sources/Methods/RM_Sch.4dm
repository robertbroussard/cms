//%attributes = {"publishedWeb":true}
  //G-Proc: RM_Sch; RM stands for Reporting Month.  Called by HBA_Rept

  //

_O_C_INTEGER:C282($Insert)
_O_C_STRING:C293(1;$1)
Case of 
	: ($1="A")
		vAInt:=vAInt+1
	: (($1="C") | ($1="V"))  // COMBINE VOM/COMMUNITY

		vCInt:=vCInt+1
	: ($1="F")
		vFInt:=vFInt+1
	: ($1="J")
		vJInt:=vJInt+1
	: ($1="T")
		vTInt:=vTInt+1  //                TRUANT  12/2003

	: ($1="L")
		vLInt:=vLInt+1
	: ($1="N")  //LTC

		vMInt:=vMInt+1
		  //: ($1="S")

		  // vSInt:=vSInt+1

	: ($1="P")
		vPInt:=vPInt+1  // 10/98 - INCLUDE PROBATION    

	: (($1="W") | ($1="K"))
		vWInt:=vWInt+1  // 8/99 - INCLUDE CPS  - 1/01 COMBINE W/ CFK

	Else 
		$Insert:=Size of array:C274(aBadSuffix)+1
		INSERT IN ARRAY:C227(aBadSuffix;$Insert)
		aBadSuffix{$Insert}:=[IntakeFile:1]CaseNo:1+":"+String:C10([IntakeFile:1]IntakeDate:4;7)
		vXInt:=vXInt+1
End case 