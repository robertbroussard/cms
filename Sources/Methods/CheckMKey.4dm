//%attributes = {"publishedWeb":true}
  //Proc: CheckMKey;  called by bMFKey, OK Button, in Form [MediatorFile]MFInput
  //
_O_C_STRING:C293(30;$OldKey;$NewKey)
$OldKey:=[MediatorFile:9]MKey:14
$NewKey:=[MediatorFile:9]MLName:1+", "+[MediatorFile:9]MFName:2
$0:=True:C214
If ($OldKey#$NewKey) & (vNewMed#True:C214)
	CONFIRM:C162("Changing name requires changing the Activity file. Continue?")
	If (OK=1)
		RELATE MANY:C262([MediatorFile:9]MKey:14)
		APPLY TO SELECTION:C70([MedActFile:10];[MedActFile:10]mafKey:1:=$NewKey)
		APPLY TO SELECTION:C70([Groups:13];[Groups:13]GMKEY:1:=$NewKey)
		[MediatorFile:9]MKey:14:=$NewKey
	Else 
		$0:=False:C215
	End if 
Else 
	If (vNewMed=True:C214)
		[MediatorFile:9]MKey:14:=$NewKey
		vNewMed:=False:C215
	End if 
End if 