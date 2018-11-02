  // Object Method:  in [MediatorFile];"MedEnvelope" AND "MedLabel"  - 
  // make addresses upper case and omit blank lines in address.
  //
_O_C_STRING:C293(10;$Zip)
C_LONGINT:C283($ctr)
_O_ARRAY STRING:C218(75;aADDR;5)
aADDR{1}:=""
aADDR{2}:=""
aADDR{3}:=""
aADDR{4}:=""
aADDR{5}:=""
$ctr:=1
$Zip:=[MediatorFile:9]MedZip:9
If ((Substring:C12($Zip;6;1)=" ") | (Substring:C12($Zip;6;1)="_"))
	$Zip:=Substring:C12([MediatorFile:9]MedZip:9;1;5)  // REMOVE PLACEHOLDERS FROM ZIP CODE
Else 
	$Zip:=Insert string:C231([MediatorFile:9]MedZip:9;"-";6)
End if 
aADDR{$ctr}:=Uppercase:C13([MediatorFile:9]MTitle:3+" "+[MediatorFile:9]MFName:2+" "+[MediatorFile:9]MLName:1)
Case of 
	: ([MediatorFile:9]Firm:4>"")
		$ctr:=$ctr+1
		aADDR{$ctr}:=Uppercase:C13([MediatorFile:9]Firm:4)
End case 
Case of 
	: ([MediatorFile:9]Add1:5>"")
		$ctr:=$ctr+1
		aADDR{$ctr}:=Uppercase:C13([MediatorFile:9]Add1:5)
End case 
Case of 
	: ([MediatorFile:9]Add2:6>"")
		$ctr:=$ctr+1
		aADDR{$ctr}:=Uppercase:C13([MediatorFile:9]Add2:6)
End case 
$ctr:=$ctr+1
aADDR{$ctr}:=Uppercase:C13([MediatorFile:9]City:7+" "+[MediatorFile:9]State:8+" "+$Zip)
vText1:=aADDR{1}
vText2:=aADDR{2}
vText3:=aADDR{3}
vText4:=aADDR{4}
vText5:=aADDR{5}