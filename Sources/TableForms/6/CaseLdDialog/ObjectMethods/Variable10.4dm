$vdate:=vdate+2
QUERY:C277([DocketFile:6];[DocketFile:6]DocketSite:1=vSite;*)
QUERY:C277([DocketFile:6]; & ;[DocketFile:6]DocketDate:2=$vdate)
vcasesWed:=Records in selection:C76([DocketFile:6])
vjumpWed:=0
If (vcasesWed>0)
	vdateW:=$vdate
	For ($i;1;vcasesWed)
		If ([DocketFile:6]DFCaseNo:4[[7]]="j")
			vjumpWed:=vjumpWed+1
		End if 
		NEXT RECORD:C51([DocketFile:6])
	End for 
End if 