//%attributes = {}
  // ----------------------------------------------------

  // User name (OS): robert

  // Date and time: 12/16/04, 22:37:54

  // ----------------------------------------------------

  // Method: Del_TimeSlotDups

  // Description

  // Deletes all duplicate recs in the TimeSlots table.

  //

  // Parameters

  // ----------------------------------------------------

C_TEXT:C284($CurrRec;$PrevRec)
C_LONGINT:C283($i;$rec)

READ WRITE:C146([TimeSlots:12])
ALL RECORDS:C47([TimeSlots:12])
$sel:=Records in selection:C76([TimeSlots:12])
FIRST RECORD:C50([TimeSlots:12])
For ($i;1;$sel)
	QUERY:C277([SiteConstraints:7];[SiteConstraints:7]Site:1=[TimeSlots:12]tsSite:1)
	If (Records in selection:C76([SiteConstraints:7])=0)
		DELETE RECORD:C58([TimeSlots:12])  //delete orphans

	End if 
	NEXT RECORD:C51([TimeSlots:12])
End for 

ALL RECORDS:C47([TimeSlots:12])
$sel:=Records in selection:C76([TimeSlots:12])
ORDER BY:C49([TimeSlots:12];[TimeSlots:12]tsSite:1;>;[TimeSlots:12]tsTime:2;>;[TimeSlots:12]MaxPerSlot:3;>)
FIRST RECORD:C50([TimeSlots:12])
CREATE EMPTY SET:C140([TimeSlots:12];"DupRecs")
For ($i;2;$sel)
	$PrevRec:=[TimeSlots:12]tsSite:1+[TimeSlots:12]tsTime:2
	GOTO SELECTED RECORD:C245([TimeSlots:12];$i)
	$CurrRec:=[TimeSlots:12]tsSite:1+[TimeSlots:12]tsTime:2
	If ($PrevRec=$CurrRec)  //The CurrRec is a duplicate and must be deleted or tagged for deletion

		ADD TO SET:C119([TimeSlots:12];"DupRecs")
	End if 
End for 
USE SET:C118("DupRecs")
DELETE SELECTION:C66([TimeSlots:12])
CLEAR SET:C117("DupRecs")
