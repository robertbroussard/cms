  //Script :bChooseTime;

  //

C_LONGINT:C283($tsElements;$SelTCount;$Count;$Find;$Insert)
C_BOOLEAN:C305($HasTimeSlots)
CLEAR VARIABLE:C89(aSelTime)
OBJECT SET ENABLED:C1123(bChooseTime;False:C215)
$HasTimeSlots:=True:C214
QUERY:C277([TimeSlots:12];[TimeSlots:12]tsSite:1=vSite)
If (Records in selection:C76([TimeSlots:12])>1) & (aTimeSlot{1}#"")
	$tsElements:=Records in selection:C76([TimeSlots:12])
	$SelTCount:=0
	ARRAY TEXT:C222(aSelTime;1)
	For ($Count;1;$tsElements)
		$Find:=Find in array:C230(aSlotName;[TimeSlots:12]tsTime:2)
		Case of 
			: ($Find#-1) & ($SelTCount#0)
				If (aSlotCount{$Find}<[TimeSlots:12]MaxPerSlot:3)
					$SelTCount:=$SelTCount+1
					INSERT IN ARRAY:C227(aSelTime;$SelTCount;1)
					aSelTime{$SelTCount}:=[TimeSlots:12]tsTime:2
				End if 
			: ($Find#-1) & ($SelTCount=0)
				If (aSlotCount{$Find}<[TimeSlots:12]MaxPerSlot:3)
					$SelTCount:=1
					aSelTime{$SelTCount}:=[TimeSlots:12]tsTime:2
				End if 
			: ($Find=-1) & ($SelTCount#0)
				$SelTCount:=$SelTCount+1
				INSERT IN ARRAY:C227(aSelTime;$SelTCount;1)
				aSelTime{$SelTCount}:=[TimeSlots:12]tsTime:2
			: ($Find=-1) & ($SelTCount=0)
				$SelTCount:=1
				aSelTime{$SelTCount}:=[TimeSlots:12]tsTime:2
		End case 
		NEXT RECORD:C51([TimeSlots:12])
	End for 
	SORT ARRAY:C229(aSelTime;>)
	DIALOG:C40([DocketFile:6];"SelTimeDialog")
Else 
	If (Records in selection:C76([TimeSlots:12])>1)
		$tsElements:=Records in selection:C76([TimeSlots:12])
		ARRAY TEXT:C222(aSelTime;$tsElements)
		For ($Count;1;$tsElements)
			aSelTime{$Count}:=[TimeSlots:12]tsTime:2
			NEXT RECORD:C51([TimeSlots:12])
		End for 
		SORT ARRAY:C229(aSelTime;>)
		DIALOG:C40([DocketFile:6];"SelTimeDialog")
	Else 
		If (Records in selection:C76([TimeSlots:12])=1)
			ALERT:C41("The only slot for this site is "+[TimeSlots:12]tsTime:2+". This case will be scheduled in it.")
			vSchTime:=[TimeSlots:12]tsTime:2
			vSlotOK:=1
			vSchOK:=1
		Else 
			ALERT:C41("There has been an error!! This Case has not been scheduled."+Char:C90(13)+Char:C90(13)+"No Time Slots Found! Verify related [TimeSlots] data associated with: "+vSite+".")
			$HasTimeSlots:=False:C215
		End if 
	End if 
End if 
If (OK=1) & ($HasTimeSlots)
	
	CREATE RECORD:C68([DocketFile:6])
	[DocketFile:6]DocketSite:1:=vSite
	[DocketFile:6]DocketDate:2:=vDate
	[DocketFile:6]TimeSlot:3:=vSchTime
	[DocketFile:6]DFCaseNo:4:=vCaseNo
	[DocketFile:6]DocKey:6:=vSite+String:C10(vDate;7)+vCaseNo  // DATE FORMAT IS MM/DD/YYYY FORCED
	
	If (aTimeSlot{1}="")
		$Insert:=1
	Else 
		$Insert:=Size of array:C274(aTimeSlot)+1
		INSERT IN ARRAY:C227(aTimeSlot;$Insert;1)
		INSERT IN ARRAY:C227(aCaseNo;$Insert;1)
		INSERT IN ARRAY:C227(aCName;$Insert;1)
		INSERT IN ARRAY:C227(aRName;$Insert;1)
	End if 
	aTimeSlot{$Insert}:=vSchTime
	SAVE RECORD:C53([DocketFile:6])
	PUSH RECORD:C176([DocketFile:6])
	  // UNLOAD RECORD([DocketFile])
	
	QUERY:C277([IntakeFile:1];[IntakeFile:1]CaseNo:1=vCaseNo)
	If (Records in selection:C76([IntakeFile:1])=1)
		vTempStatus:=[IntakeFile:1]CaseStatus:25
		[IntakeFile:1]CaseStatus:25:="Scheduled"
		SAVE RECORD:C53([IntakeFile:1])
		aCaseNo{$Insert}:=vCaseNo
		aCName{$Insert}:=[IntakeFile:1]CLName:6+", "+[IntakeFile:1]CFName:7
		aRName{$Insert}:=[IntakeFile:1]RLName:11+", "+[IntakeFile:1]RFName:12
		SORT ARRAY:C229(aTimeSlot;aCaseNo;aCName;aRName;>)
		  // UNLOAD RECORD([IntakeFile])
		
	Else 
		ALERT:C41("There has been an error in Script'bChooseTime'.")
	End if 
Else 
	ALERT:C41("Case Number "+vCaseNo+" has not been scheduled.")
	CONFIRM:C162("To try again, choose OK; else choose Cancel.")
	If (OK=1)
		ACCEPT:C269
		vSCLoop2:=1
	End if 
End if 