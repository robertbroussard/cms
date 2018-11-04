//%attributes = {"publishedWeb":true}
  //G-Prog: GetProgram;
C_TEXT:C284($Temp)
C_TEXT:C284($1)
C_TEXT:C284($0)
$Temp:=Substring:C12($1;9;1)
Case of 
	: ($Temp="C")
		$0:="Community-Based"
	: ($Temp="P")
		$0:="Probation"
	: ($Temp="F")
		$0:="Family"
	: ($Temp="J")
		$0:="JUMP"
	: ($Temp="L")
		$0:="Litigation"
	: ($Temp="S")
		$0:="Special Ed."
	: ($Temp="W")
		$0:="CPS"
	: ($Temp="K")
		$0:="CFK"
	: ($Temp="T")
		$0:="Truant"  // ADD TRUANT  11-03
	Else 
		$0:=""
End case 