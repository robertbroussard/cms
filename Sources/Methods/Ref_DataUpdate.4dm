//%attributes = {}
  // ----------------------------------------------------

  // User name (OS): robert

  // Date and time: 12/13/04, 02:01:01

  // ----------------------------------------------------

  // Method: Ref_DataUpdate

  // Description

  // 

  //

  // Parameters

  // ----------------------------------------------------


_O_ARRAY STRING:C218(20;aOldTruantList;0)
C_LONGINT:C283($IntakeFileLocked;$CrtAddrLocked)

$IntakeFileLocked:=0
$CrtAddrLocked:=0

LIST TO ARRAY:C288("Old_RefTruant";aOldTruantList)
$size:=Size of array:C274(aOldTruantList)

If ($size>0)
	
	READ WRITE:C146([IntakeFile:1])
	READ WRITE:C146([CrtAddrFile:19])
	
	QUERY:C277([IntakeFile:1];[IntakeFile:1]RefBy:16=aOldTruantList{1};*)
	For ($i;2;$size)
		QUERY:C277([IntakeFile:1]; | ;[IntakeFile:1]RefBy:16=aOldTruantList{$i};*)
	End for 
	QUERY:C277([IntakeFile:1])
	
	RELATE ONE SELECTION:C349([IntakeFile:1];[CrtAddrFile:19])
	
	$sel:=Records in selection:C76([IntakeFile:1])
	FIRST RECORD:C50([IntakeFile:1])
	For ($i;1;$sel)
		If (Not:C34(Locked:C147([IntakeFile:1])))
			[IntakeFile:1]RefBy:16:="School Campus"
			SAVE RECORD:C53([IntakeFile:1])
		Else 
			$IntakeFileLocked:=$IntakeFileLocked+1
		End if 
		NEXT RECORD:C51([IntakeFile:1])
	End for 
	
	
	$sel:=Records in selection:C76([CrtAddrFile:19])
	FIRST RECORD:C50([CrtAddrFile:19])
	For ($i;1;$sel)
		If (Not:C34(Locked:C147([CrtAddrFile:19])))
			[CrtAddrFile:19]CCRefBy:1:="School Campus"
			SAVE RECORD:C53([CrtAddrFile:19])
		Else 
			$CrtAddrLocked:=$CrtAddrLocked+1
		End if 
		NEXT RECORD:C51([CrtAddrFile:19])
	End for 
	
	UNLOAD RECORD:C212([IntakeFile:1])
	UNLOAD RECORD:C212([CrtAddrFile:19])
	
	If ($IntakeFileLocked#0) | ($CrtAddrLocked#0)  //something was locked

		BEEP:C151
		BEEP:C151
		BEEP:C151
		$txt:="Ref_DataUpdate Incomplete. Locked Record Condition as follows:"+Char:C90(13)+"IntakeFile: "+String:C10($IntakeFileLocked)+Char:C90(13)+"CourtAddress: "+String:C10($CrtAddrLocked)+Char:C90(13)+Char:C90(13)+"Report this to your DBA immediately!"
		ALERT:C41($txt)
	Else 
		$txt:="Success!  No Locked Records Detected."
		BEEP:C151
	End if 
	vDBUpdateLockDetail:=$txt
End if 
