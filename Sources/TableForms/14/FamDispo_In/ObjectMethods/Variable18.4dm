  // Script for vFDControl in Layout FamDispo_In

If (False:C215)
	
	C_BOOLEAN:C305(vDRO_Sw)
	If (vMedSw=False:C215)
		vMed1:=""
		vMed2:=""
		vOtherDate:=""
		bMedSwY:=0
		bMedSwN:=1
		OBJECT SET ENTERABLE:C238(vMed1;False:C215)
		OBJECT SET ENTERABLE:C238(vMed2;False:C215)
		OBJECT SET ENTERABLE:C238(vResult;False:C215)
		OBJECT SET ENTERABLE:C238(vOtherDate;False:C215)
		_O_ENABLE BUTTON:C192(cRsn1)
		_O_ENABLE BUTTON:C192(cRsn2)
		_O_ENABLE BUTTON:C192(cRsn3)
		_O_ENABLE BUTTON:C192(cRsn4)
		_O_ENABLE BUTTON:C192(cRsn5)
		_O_ENABLE BUTTON:C192(cRsn6)
		_O_ENABLE BUTTON:C192(cRsn7)
		_O_ENABLE BUTTON:C192(cRsn8)
	Else 
		bMedSwY:=1
		bMedSwN:=0
		mRsn1:=0
		mRsn2:=0
		mRsn3:=0
		cRsn1:=0
		cRsn2:=0
		cRsn3:=0
		cRsn4:=0
		cRsn5:=0
		cRsn6:=0
		cRsn7:=0
		cRsn8:=0
		OBJECT SET ENTERABLE:C238(vMed1;True:C214)
		OBJECT SET ENTERABLE:C238(vMed2;True:C214)
		OBJECT SET ENTERABLE:C238(vResult;True:C214)
		OBJECT SET ENTERABLE:C238(vOtherDate;True:C214)
		_O_DISABLE BUTTON:C193(cRsn1)
		_O_DISABLE BUTTON:C193(cRsn2)
		_O_DISABLE BUTTON:C193(cRsn3)
		_O_DISABLE BUTTON:C193(cRsn4)
		_O_DISABLE BUTTON:C193(cRsn5)
		_O_DISABLE BUTTON:C193(cRsn6)
		_O_DISABLE BUTTON:C193(cRsn7)
		_O_DISABLE BUTTON:C193(cRsn8)
	End if 
	If (vDRO_Sw=True:C214)
		rDROSwY:=1
		rDROSwN:=0
	Else 
		rDROSwY:=0
		rDROSwN:=1
	End if 
	If ((vJudDist[[1]]#"J") & (vJudDist[[1]]#"D"))  // NOT JP OR DRO
		$Number:=Substring:C12(vJudDist;1;3)+"TH JUDICIAL DISTRICT"
		vJudDist:=$Number
	End if 
	GOTO OBJECT:C206(vFDControl)
End if 
