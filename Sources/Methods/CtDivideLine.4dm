//%attributes = {"publishedWeb":true}
  //Called by CourtForms & CtBuildWS to break a field in half
  //to fit in a short print field
  //$1=ptr to data field, $2=ptr toTemp1, $3=ptr to Temp2, $4=max break off length
  //
C_LONGINT:C283($TotLen)
C_TEXT:C284($TextField)
  //
$TotLen:=Length:C16($1->)  //LENGTH OF TEXT FIELD
If ($TotLen<=$4)  //MOVE ALL CHARACTERS THAT WILL FIT TO 1ST LINE
	$2->:=$1->
	$3->:=""
Else 
	$TextField:=$1->
	For ($i;1;$4)
		If (($TextField[[$i]]=" ") | ($TextField[[$i]]=Char:C90(45)))  //SEEK LAST SPACE OR HYPHEN TO BREAK ON
			$Pos:=$i
		End if 
	End for 
	If ($Pos<1)
		ALERT:C41("Whoa!  Ain't  NO spaces at all!"+Char:C90(13)+Char:C90(13)+"The line will be broken at position "+String:C10($4))  //Mod 10/28/03
		$Pos:=$4
	End if 
	$Len:=$TotLen-$Pos  //GET LENGTH OF REMAINDER FOR 2ND LINE
	$2->:=Substring:C12($TextField;1;$Pos-1)  //MINUS 1 TO OMIT SPACE, MOVE TEXT TO LINE 1
	$3->:=Substring:C12($TextField;$Pos+1;$Len)  //PLUS 1 TO OMIT SPACE, MOVE TEXT TO LINE 2
	Ct2Lines:=True:C214
End if 