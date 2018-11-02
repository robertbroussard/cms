//%attributes = {"publishedWeb":true}
  //G-Procedure:BuildDocArray
  //
_O_C_INTEGER:C282($Elements;$Count;$SlotCount;$NumCases;vcasesMon;vcasesTue;vcasesWed)
C_BOOLEAN:C305(vskipMon)
vskipMon:=False:C215
QUERY:C277([DocketFile:6];[DocketFile:6]DocketSite:1=vSite;*)
QUERY:C277([DocketFile:6]; & ;[DocketFile:6]DocketDate:2=vDate)
$Elements:=Records in selection:C76([DocketFile:6])
_O_ARRAY STRING:C218(10;aTimeSlot;$Elements)
_O_ARRAY STRING:C218(9;aCaseNo;$Elements)
_O_ARRAY STRING:C218(80;aCName;$Elements)
_O_ARRAY STRING:C218(80;aRName;$Elements)
ARRAY INTEGER:C220(aSlotCount;1)
_O_ARRAY STRING:C218(10;aSlotName;1)
If (vNextAvail=1)
	If ((vDayOK) & (Day number:C114(vDate)=2) & (vSite="Downtown Night"))
		CREATE SET:C116([DocketFile:6];"Docketset")
		DIALOG:C40([DocketFile:6];"CaseLdDialog")
		USE SET:C118("Docketset")
		CLEAR SET:C117("Docketset")
		If (OK#1)
			vskipmon:=True:C214
		End if 
	End if 
End if 
Case of 
	: (vskipMon)
	: ($Elements=0)
		INSERT IN ARRAY:C227(aTimeSlot;1;1)
		INSERT IN ARRAY:C227(aCaseNo;1;1)
		INSERT IN ARRAY:C227(aCName;1;1)
		INSERT IN ARRAY:C227(aRName;1;1)
		aTimeSlot{1}:=""
	: ($Elements=1)
		RELATE ONE:C42([DocketFile:6]DFCaseNo:4)
		aTimeSlot{$Elements}:=[DocketFile:6]TimeSlot:3
		aCaseNo{$Elements}:=[DocketFile:6]DFCaseNo:4
		aCName{$Elements}:=[IntakeFile:1]CLName:6+", "+[IntakeFile:1]CFName:7
		aRName{$Elements}:=[IntakeFile:1]RLName:11+", "+[IntakeFile:1]RFName:12
	: ($Elements>1)
		For ($Count;1;$Elements)
			RELATE ONE:C42([DocketFile:6]DFCaseNo:4)
			aTimeSlot{$Count}:=[DocketFile:6]TimeSlot:3
			aCaseNo{$Count}:=[DocketFile:6]DFCaseNo:4
			aCName{$Count}:=[IntakeFile:1]CLName:6+", "+[IntakeFile:1]CFName:7
			aRName{$Count}:=[IntakeFile:1]RLName:11+", "+[IntakeFile:1]RFName:12
			NEXT RECORD:C51([DocketFile:6])
		End for 
		SORT ARRAY:C229(aTimeSlot;aCaseNo;aCName;aRName;>)
		$SlotCount:=0
		$NumCases:=0
		For ($Count;1;$Elements)
			If ($SlotCount#0)
				If (aTimeSlot{$Count}=aTimeSlot{$Count-1})
					$NumCases:=$NumCases+1
					aSlotCount{$SlotCount}:=$NumCases
				Else 
					$SlotCount:=$SlotCount+1
					$NumCases:=1
					INSERT IN ARRAY:C227(aSlotCount;$SlotCount;1)
					INSERT IN ARRAY:C227(aSlotName;$SlotCount;1)
					aSlotCount{$SlotCount}:=1
					aSlotName{$SlotCount}:=aTimeSlot{$Count}
				End if 
			Else 
				$SlotCount:=1
				$NumCases:=1
				aSlotCount{$SlotCount}:=1
				aSlotName{$SlotCount}:=aTimeSlot{$Count}
			End if 
		End for 
		SORT ARRAY:C229(aSlotName;aSlotCount;>)
End case 