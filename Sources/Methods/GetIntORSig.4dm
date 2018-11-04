//%attributes = {"publishedWeb":true}
  //G-Proc: GetIntORSig;
  //
C_LONGINT:C283($1)
vInitials:=""
$0:=True:C214
If ($1=1)
	While (vInitials="")
		vInitials:=Uppercase:C13(Substring:C12(Request:C163("Enter initials (only 2 please):");1;2))
		If (vInitials="")
			CONFIRM:C162("Enter initials or choose Cancel to stop this operation.")
			If (OK#1)
				$0:=False:C215
				vInitials:="XX"
			End if 
		End if 
	End while 
Else 
	While (vInitials="")
		vInitials:=Request:C163("Enter your NAME:")
		If (vInitials="")
			CONFIRM:C162("Enter NAME or choose Cancel to stop this operation.")
			If (OK#1)
				$0:=False:C215
				vInitials:="XX"
			End if 
		End if 
	End while 
	If (((b1=1) | (b3=1)) & (vInitials#""))  //CHG 9/30/94, 8/25/95
		vITName:=vInitials  //SAVE FULL NAME FOR HEARING NOTICE
		vInitials:=vITName[[1]]  //RELOAD INITIALS
		For ($i;2;Length:C16(vITName))  //SKIP 1ST LETTER
			If ((vITName[[$i]]<"a") | (vITName[[$i]]>"z")) & (vITName[[$i]]#".")
				vInitials:=vInitials+(vITName[[$i+1]])
			End if 
		End for 
	End if 
End if 