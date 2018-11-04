//%attributes = {"publishedWeb":true}
  //G-Proc: SR_Totals
  //
C_LONGINT:C283($i;$j;$TempNum)
  //Get the totals for element 6 for all 38 lines.
For ($i;1;38)
	For ($j;1;5)
		aState{6}{$i}:=aState{6}{$i}+aState{$j}{$i}
	End for 
End for 
  //Add the totals for the intake section for all 6 columns.
For ($i;1;6)
	For ($j;2;20)
		aState{$i}{21}:=aState{$i}{21}+aState{$i}{$j}
	End for 
End for 
  //Get subtotals for the intake page (line 26).
For ($i;1;6)
	For ($j;22;25)
		aState{$i}{26}:=aState{$i}{26}+aState{$i}{$j}
	End for 
End for 
  //Get subtotals for the intake page (line 30).
For ($i;1;6)
	For ($j;27;29)
		aState{$i}{30}:=aState{$i}{30}+aState{$i}{$j}
	End for 
End for 
  //Get subtotals for the intake page (line 36).
For ($i;1;6)
	For ($j;31;35)
		aState{$i}{36}:=aState{$i}{36}+aState{$i}{$j}
	End for 
End for 
  //Get totals for the intake page (line 37).
For ($i;1;6)
	$TempNum:=0
	$TempNum:=$TempNum+aState{$i}{26}
	$TempNum:=$TempNum+aState{$i}{30}
	$TempNum:=$TempNum+aState{$i}{36}
	aState{$i}{37}:=$TempNum
End for 
  //Get totals for the test (line 38).
For ($i;1;6)
	aState{$i}{38}:=(aState{$i}{1}+aState{$i}{21})-aState{$i}{37}
End for 