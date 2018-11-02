//%attributes = {}
  //SR_01

C_LONGINT:C283($Seq;$1;$0)

$Seq:=$1
$Filed:=$2

$size:=Size of array:C274(aBOM)

If ($Seq<=$size)
	  //vSR_01_Total:=vSR_01_Total+aBOM{$Seq}
	$0:=aBOM{$Seq}
Else 
	$0:=0
End if 
