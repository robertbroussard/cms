//%attributes = {"publishedWeb":true}
  //
  //  CtBuild WS - called in CourtForms to load data in Worksheet 
  //   without blank lines.
  //
vTemp1:=""
vTemp2:=""
CtDivideLine (->vwork;->vTemp1;->vTemp2;31)
If (vTemp1>"")
	vWSLine:=vWSLine+1
	ptrWS:=Get pointer:C304("vLine"+vWSType+String:C10(vWSCol)+String:C10(vWSLine))
	ptrWS->:=vTemp1
End if 
If (vTemp2>"") & ($1=1)  //1 = YES, move 2 lines
	vWSLine:=vWSLine+1
	ptrWS:=Get pointer:C304("vLine"+vWSType+String:C10(vWSCol)+String:C10(vWSLine))
	ptrWS->:=vTemp2
End if 