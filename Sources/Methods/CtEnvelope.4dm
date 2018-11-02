//%attributes = {"publishedWeb":true}
  //
  //  Called by CourtForms to build envelopes for printing by CtPrtLitigate
  //  builds array aEnvelope
  //
If (vwork>"")
	vn1:=vn1+1
	If (vn1>5)
		ALERT:C41("Too many fields - Array counter = "+String:C10(vn1))
	End if 
	aEnvelope{vn1}{vn2}:=vwork
End if 