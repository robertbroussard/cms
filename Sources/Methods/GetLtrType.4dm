//%attributes = {"publishedWeb":true}
  //G-Proc: GetLtrType
  // $1=aPartyType(the array element found in calling procedure)
  // $2=aPartyLang(the array element found in calling procedure)
  // $3=[IntakeFile]Program
  // $4=the number of the procedure that was called from DefaultLtrs 
  //       which  in turn called this procedure.
  //
_O_C_STRING:C293(10;$1)
_O_C_STRING:C293(2;$2)
_O_C_STRING:C293(1;$3)
_O_C_INTEGER:C282($4)
Case of 
	: ($4=1)  // HEARING NOTICE
		Case of 
			: (($3="C") | ($3="S") | ($3="D"))
				If ($2="S ")
					If ($1="C@")  //MOD rjb 5/16/08. New Comp. Letter
						$0:="Notice_C (S)"
					Else 
						$0:="Notice (S)"
					End if 
				Else 
					If ($1="C@")  //MOD rjb 5/16/08. New Comp. Letter
						$0:="Notice_C (E)"
					Else 
						$0:="Notice (E)"
					End if 
				End if 
				If ($3="D") & (vJuvLtr="Y")
					$0:="JUMP Letter (E)"
				End if 
			: ($3="J")
				If ([IntakeFile:1]RefBy:16="HCJPD-LSO") | ([IntakeFile:1]RefBy:16="Juv Prob Dept-LSO")
					If ($2="S ")
						$0:="JUMP LSO R Ltr (S)"
					Else 
						$0:="JUMP LSO R Ltr (E)"
					End if 
				Else 
					If ($2="S ")
						$0:="JUMP Letter (S)"
					Else 
						$0:="JUMP Letter (E)"
					End if 
				End if 
			: ($3="F")
				If ($2="S ")
					$0:="Family Notice (S)"
				Else 
					$0:="Family Notice (E)"
				End if 
			: ($3="A")
				If ($2="S ")
					If ($1="C@")  //MOD rjb 5/16/08. New Comp. Letter
						$0:="Notice_C (S)"
					Else 
						$0:="Notice (S)"
					End if 
				Else 
					If ($1="C@")  //MOD rjb 5/16/08. New Comp. Letter
						$0:="Notice_C (E)"
					Else 
						$0:="Notice (E)"
					End if 
				End if 
			: ($3="L")
				If ($2="S ")
					If ($1="C@")  //MOD rjb 5/16/08. New Comp. Letter
						$0:="Notice_C (S)"
					Else 
						$0:="Notice (S)"
					End if 
				Else 
					If ($1="C@")  //MOD rjb 5/16/08. New Comp. Letter
						$0:="Notice_C (E)"
					Else 
						$0:="Notice (E)"
					End if 
				End if 
			: ($3="M")
				If ($2="S ")
					If ($1="C@")  //MOD rjb 5/16/08. New Comp. Letter
						$0:="Notice_C (S)"
					Else 
						$0:="Notice (S)"
					End if 
				Else 
					If ($1="C@")  //MOD rjb 5/16/08. New Comp. Letter
						$0:="Notice_C (E)"
					Else 
						$0:="Notice (E)"
					End if 
				End if 
			: ($3="V")
				If ($2="S ")
					If ($1="C@")  //MOD rjb 5/16/08. New Comp. Letter
						$0:="Notice_C (S)"
					Else 
						$0:="Notice (S)"
					End if 
				Else 
					If ($1="C@")  //MOD rjb 5/16/08. New Comp. Letter
						$0:="Notice_C (E)"
					Else 
						$0:="Notice (E)"
					End if 
				End if 
			: ($3="P")
				If ($2="S ")
					$0:="Prob Notice (S)"  // Now has SPANISH VERSION  1/03
				Else 
					$0:="Prob Notice (E)"  // 10/99 - PROB GETS OWN LETTER          
				End if 
			: ($3="W")  // CPS LETTER, 8/99
				If ($2="S ")
					$0:="CPS Notice (E)"  // NO SPANISH VERSION
				Else 
					$0:="CPS Notice (E)"
				End if 
				
			: ($3="T")
				  //     TRUANT HAS NO LETTERS  -  11/03
				
			: ($3="K")  // CFK LETTER, 1/01
				If ($2="S ")
					$0:="CFK Notice (E)"  // NO SPANISH VERSION
				Else 
					$0:="CFK Notice (E)"
				End if 
			Else 
				ALERT:C41("There is a problem with a party in this case")
		End case 
	: ($4=2)
		If ($1="R@")
			If ([IntakeFile:1]RefBy:16="HCJPD-LSO") | ([IntakeFile:1]RefBy:16="Juv Prob Dept-LSO")
				If ($2="S ")
					$0:="JUMP LSO R Ltr (S)"
				Else 
					$0:="JUMP LSO R Ltr (E)"
				End if 
			Else 
				If ($2="S ")
					$0:="JUMP R Ltr (S)"
				Else 
					$0:="JUMP R Ltr (E)"
				End if 
			End if 
		Else 
			If ($2="S ")
				$0:="JUMP C Ltr (S)"
			Else 
				$0:="JUMP C Ltr (E)"
			End if 
		End if 
	: ($4=3)  // CONTINUATION NOTICE
		If ($2="S ")
			$0:="Family Cont Notice (S)"
		Else 
			$0:="Family Cont Notice (E)"
		End if 
	: ($4=4)  // BA LETTER
		  //BA Letter
End case 