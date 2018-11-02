  // [DF]CaseLdDialog Form;  button for Monday's case load - method
  // 
vcasesMon:=Records in selection:C76([DocketFile:6])
vjumpMon:=0
If (vcasesMon>0)
	vdateM:=vdate
	For ($i;1;vcasesMon)
		If ([DocketFile:6]DFCaseNo:4[[9]]="j")
			vjumpMon:=vjumpMon+1
		End if 
		NEXT RECORD:C51([DocketFile:6])
	End for 
End if 