//%attributes = {"publishedWeb":true}
  //G-Proc: RM_RefNClosed; RM stands for Reporting Month.

  // Status = "Referred" or "Direct Assistance"

  //

_O_C_INTEGER:C282($Insert)
_O_C_STRING:C293(1;$1)
Case of 
	: ($1="A")
		vAInt:=vAInt+1
		vARef:=vARef+1
		vAClosed:=vAClosed+1
	: (($1="C") | ($1="V"))  // COMBINE VOM W/COMMUNITY

		vCInt:=vCInt+1
		vCRef:=vCRef+1
		vCClosed:=vCClosed+1
	: ($1="F")
		vFInt:=vFInt+1
		vFRef:=vFRef+1
		vFClosed:=vFClosed+1
	: ($1="J")
		vJInt:=vJInt+1
		vJRef:=vJRef+1
		vJClosed:=vJClosed+1
	: ($1="L")
		vLInt:=vLInt+1
		vLRef:=vLRef+1
		vLClosed:=vLClosed+1
	: ($1="T")  //                          TRUANT  -  12/2003

		vTInt:=vTInt+1
		vTRef:=vTRef+1
		vTClosed:=vTClosed+1
	: ($1="N")  //LTC

		vMInt:=vMInt+1
		vMRef:=vMRef+1
		vMClosed:=vMClosed+1
		  // : ($1="S")

		  //  vSInt:=vSInt+1

		  // vSRef:=vSRef+1

		  //vSClosed:=vSClosed+1    ` 3/97 - ZERO SPECIAL ED

	: ($1="P")
		vPInt:=vPInt+1
		vPRef:=vPRef+1
		vPClosed:=vPClosed+1  // 1/98 - INCLUDE PROBATION

	: (($1="W") | ($1="K"))
		vWInt:=vWInt+1
		vWRef:=vWRef+1
		vWClosed:=vWClosed+1  // 8/99 - INCLUDE CPS - 1/01 INCLUDE CFK

	Else 
		$Insert:=Size of array:C274(aBadSuffix)+1
		INSERT IN ARRAY:C227(aBadSuffix;$Insert)
		aBadSuffix{$Insert}:=[IntakeFile:1]CaseNo:1+":"+String:C10([IntakeFile:1]IntakeDate:4;7)
		vXInt:=vXInt+1
		vXRef:=vXRef+1
		vXClosed:=vXClosed+1
End case 