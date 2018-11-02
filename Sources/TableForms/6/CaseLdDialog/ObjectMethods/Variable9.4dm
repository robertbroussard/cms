$vdate:=vdate+1
QUERY:C277([DocketFile:6];[DocketFile:6]DocketSite:1=vSite;*)
QUERY:C277([DocketFile:6]; & ;[DocketFile:6]DocketDate:2=$vdate)
vcasesTue:=Records in selection:C76([DocketFile:6])
vjumpTue:=0
If (vcasesTue>0)
	vdateT:=$vdate
	For ($i;1;vcasesTue)
		If ([DocketFile:6]DFCaseNo:4[[7]]="j")
			vjumpTue:=vjumpTue+1
		End if 
		NEXT RECORD:C51([DocketFile:6])
	End for 
End if 