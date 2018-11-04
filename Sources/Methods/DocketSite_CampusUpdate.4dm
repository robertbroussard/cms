//%attributes = {}
  // ----------------------------------------------------

  // User name (OS): robert

  // Date and time: 11/19/04, 14:58:55

  // ----------------------------------------------------

  // Method: DocketSite_CampusUpdate

  // Description

  // 

  //

  // Parameters

  // ----------------------------------------------------




ARRAY TEXT:C222(aOldTruantList;0)
C_LONGINT:C283($DocketFileLocked;$SiteConstraintsLocked;$TimeSlotsLocked)

$DocketFileLocked:=0
$SiteConstraintsLocked:=0
$TimeSlotsLocked:=0

LIST TO ARRAY:C288("Old_TruantList";aOldTruantList)
$size:=Size of array:C274(aOldTruantList)

If ($size>0)
	
	READ WRITE:C146([SiteConstraints:7])
	READ WRITE:C146([DocketFile:6])
	READ WRITE:C146([TimeSlots:12])
	
	QUERY:C277([SiteConstraints:7];[SiteConstraints:7]Site:1=aOldTruantList{1};*)
	For ($i;2;$size)
		QUERY:C277([SiteConstraints:7]; | ;[SiteConstraints:7]Site:1=aOldTruantList{$i};*)
	End for 
	QUERY:C277([SiteConstraints:7])
	
	RELATE MANY SELECTION:C340([DocketFile:6]DocketSite:1)
	
	$sel:=Records in selection:C76([DocketFile:6])
	FIRST RECORD:C50([DocketFile:6])
	For ($i;1;$sel)
		If (Not:C34(Locked:C147([DocketFile:6])))
			[DocketFile:6]DocketSite:1:="School Campus"
			SAVE RECORD:C53([DocketFile:6])
		Else 
			$DocketFileLocked:=$DocketFileLocked+1
		End if 
		NEXT RECORD:C51([DocketFile:6])
	End for 
	
	RELATE MANY SELECTION:C340([TimeSlots:12]tsSite:1)
	
	$sel:=Records in selection:C76([TimeSlots:12])
	FIRST RECORD:C50([TimeSlots:12])
	For ($i;1;$sel)
		If (Not:C34(Locked:C147([TimeSlots:12])))
			[TimeSlots:12]tsSite:1:="School Campus"
			SAVE RECORD:C53([TimeSlots:12])
		Else 
			$TimeSlotsLocked:=$TimeSlotsLocked+1
		End if 
		NEXT RECORD:C51([TimeSlots:12])
	End for 
	
	If ($TimeSlotsLocked=0) & ($DocketFileLocked=0)
		
		$sel:=Records in selection:C76([SiteConstraints:7])
		FIRST RECORD:C50([SiteConstraints:7])
		For ($i;1;$sel)
			If (Not:C34(Locked:C147([SiteConstraints:7])))
				[SiteConstraints:7]Site:1:="School Campus"
				SAVE RECORD:C53([SiteConstraints:7])
			Else 
				$SiteConstraintsLocked:=$SiteConstraintsLocked+1
			End if 
			NEXT RECORD:C51([SiteConstraints:7])
		End for 
		
		REDUCE SELECTION:C351([SiteConstraints:7];($sel-1))
		DELETE SELECTION:C66([SiteConstraints:7])
		
	End if 
	
	UNLOAD RECORD:C212([TimeSlots:12])
	UNLOAD RECORD:C212([SiteConstraints:7])
	UNLOAD RECORD:C212([DocketFile:6])
	
	If ($SiteConstraintsLocked#0) | ($TimeSlotsLocked#0) | ($DocketFileLocked#0)  //something was locked
		
		BEEP:C151
		BEEP:C151
		BEEP:C151
		$txt:="DocketSiteUpdateProcedure Incomplete. Locked Record Condition as follows:"+Char:C90(13)+"SiteConstraints: "+String:C10($SiteConstraintsLocked)+Char:C90(13)+"TimeSlots: "+String:C10($TimeSlotsLocked)+Char:C90(13)+"DocketFile: "+String:C10($DocketFileLocked)+Char:C90(13)+Char:C90(13)+"Report this to your DBA immediately!"
		ALERT:C41($txt)
	Else 
		$txt:="Success!  No Locked Records Detected."
		BEEP:C151
	End if 
	vDBUpdateLockDetail:=$txt
End if 

