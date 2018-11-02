//%attributes = {}
  // ----------------------------------------------------

  // User name (OS): robert

  // Date and time: 11/19/04, 14:54:40

  // ----------------------------------------------------

  // Method: RunDBUpdate

  // Description

  // Will run the method if it has not already been run.

  //After first Run it will populate DBUpdate to prevent unwanted future runs.

  //

  // Parameters

  //Example

  //RunDBUpdate ("DocketSite_CampusUpdate")

  // ----------------------------------------------------


_O_C_STRING:C293(50;$ProcName;$1)
C_TEXT:C284(vDBUpdateLockDetail)

$ProcName:=$1
vDBUpdateLockDetail:=""

READ WRITE:C146([DBUpdate:21])

QUERY:C277([DBUpdate:21];[DBUpdate:21]ProcName:3=$ProcName;*)
QUERY:C277([DBUpdate:21]; & ;[DBUpdate:21]Status:4="Completed")

$sel:=Records in selection:C76([DBUpdate:21])

Case of 
	: ($sel=1)
		  //Do nothing already run (updated)...

	: ($sel=0)
		  //run the proc.

		CREATE RECORD:C68([DBUpdate:21])
		[DBUpdate:21]Date_Run:1:=Current date:C33
		[DBUpdate:21]Time_Run:2:=Current time:C178
		[DBUpdate:21]ProcName:3:=$ProcName
		[DBUpdate:21]Status:4:="Started"
		SAVE RECORD:C53([DBUpdate:21])
		EXECUTE FORMULA:C63($ProcName)
		[DBUpdate:21]Status:4:="Completed"
		[DBUpdate:21]LockDetail:5:=vDBUpdateLockDetail
		SAVE RECORD:C53([DBUpdate:21])
	Else 
		BEEP:C151
		BEEP:C151
		ALERT:C41("Invalid 'DBUpdate' selection--Alert DBA ASAP!")
		
End case 


UNLOAD RECORD:C212([DBUpdate:21])