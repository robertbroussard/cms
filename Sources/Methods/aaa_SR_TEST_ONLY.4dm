//%attributes = {}
  //11/15/6

QUERY:C277([IntakeFile:1];[IntakeFile:1]CaseNo:1="@J")

TRACE:C157
  //QUERY([DocketFile];[DocketFile]HResults="")
  //RELATE ONE SELECTION([DocketFile];[IntakeFile])

ALL RECORDS:C47([SR_BOM:22])
LAST RECORD:C200([SR_BOM:22])
If (Records in selection:C76([SR_BOM:22])=0)
	CREATE RECORD:C68([SR_BOM:22])
	
End if 
BLOB TO VARIABLE:C533([SR_BOM:22]Filed:3;atest)


ARRAY TEXT:C222(atest;3)

atest{1}:="b"
atest{2}:="c"
atest{3}:="a"

VARIABLE TO BLOB:C532(atest;[SR_BOM:22]Filed:3)

ARRAY TEXT:C222(atest;0)

TRACE:C157

BLOB TO VARIABLE:C533([SR_BOM:22]Filed:3;atest)

TRACE:C157

SAVE RECORD:C53([SR_BOM:22])

