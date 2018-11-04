//%attributes = {"publishedWeb":true}
  //G-Proc: RM_Hold; RM stands for Reporting Month.

  //

C_LONGINT:C283($Insert)
C_TEXT:C284($1)
Case of 
	: ($1="A")
		vAInt:=vAInt+1
		vAPenNext:=vAPenNext+1
	: (($1="C") | ($1="V"))  // COMBINE VOM W/COMMUNITY
		
		vCInt:=vCInt+1
		vCPenNext:=vCPenNext+1
	: ($1="F")
		vFInt:=vFInt+1
		vFPenNext:=vFPenNext+1
	: ($1="J")
		vJInt:=vJInt+1
		vJPenNext:=vJPenNext+1
	: ($1="L")
		vLInt:=vLInt+1
		vLPenNext:=vLPenNext+1
	: ($1="N")  //LTC
		
		vMInt:=vMInt+1
		vMPenNext:=vMPenNext+1
		  // : ($1="S")
		
		  //  vSInt:=vSInt+1
		
		  // vSPenNext:=vSPenNext+1    ` 3/97 - ZERO SPECIAL ED
		
	: ($1="P")
		vPInt:=vPInt+1
		vPPenNext:=vPPenNext+1  // 10/98 - INCLUDE PROBATION 
		
	: ($1="T")
		vTInt:=vTInt+1
		vTPenNext:=vTPenNext+1  //   11/03 - INCLUDE TRUANT       
		
	: (($1="W") | ($1="K"))  //    1/01 - CPS AND CFK  COMBINED
		
		vWInt:=vWInt+1
		vWPenNext:=vWPenNext+1  // 8/99 - INCLUDE CPS        
		
	Else 
		$Insert:=Size of array:C274(aBadSuffix)+1
		INSERT IN ARRAY:C227(aBadSuffix;$Insert)
		aBadSuffix{$Insert}:=[IntakeFile:1]CaseNo:1+":"+String:C10([IntakeFile:1]IntakeDate:4;7)
		vXInt:=vXInt+1
		vXPenNext:=vXPenNext+1
End case 