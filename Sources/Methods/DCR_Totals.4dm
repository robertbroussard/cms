//%attributes = {"publishedWeb":true}
  //G-Proc: DCR_Totals
  //
C_LONGINT:C283($i)
ALL RECORDS:C47([LtrRptFile:16])
FIRST RECORD:C50([LtrRptFile:16])
vTLtrBatch:=0
vTLtrOnline:=0
vTLtrRpt:=0
vTEnvBatch:=0
vTEnvOnline:=0
vTEnvRpt:=0
For ($i;1;Records in selection:C76([LtrRptFile:16]))
	If ([LtrRptFile:16]PrintStatus:6=True:C214)
		vTLtrRpt:=vTLtrRpt+1
		If ([LtrRptFile:16]Batch_Or_Other:10=True:C214)
			vTLtrBatch:=vTLtrBatch+1
		Else 
			vTLtrOnline:=vTLtrOnline+1
		End if 
	End if 
	If ([LtrRptFile:16]Envelope:12=True:C214)
		vTEnvRpt:=vTEnvRpt+1
		If ([LtrRptFile:16]Batch_Or_Other:10=True:C214)
			vTEnvBatch:=vTEnvBatch+1
		Else 
			vTEnvOnline:=vTEnvOnline+1
		End if 
	End if 
	NEXT RECORD:C51([LtrRptFile:16])
End for 
