//%attributes = {"publishedWeb":true}
  //G-Proc: GetActivity
  //
C_LONGINT:C283($i;$j;$Find;$Start;$Insert)
SELECTION TO ARRAY:C260([MediatorFile:9]MKey:14;aMaster)
FIRST RECORD:C50([MediatorFile:9])
For ($i;1;Records in selection:C76([MediatorFile:9]))
	RELATE MANY:C262([MediatorFile:9]MKey:14)
	If (Records in selection:C76([MedActFile:10])>0)
		FIRST RECORD:C50([MedActFile:10])
		For ($j;1;Records in selection:C76([MedActFile:10]))
			If (([MedActFile:10]AmtOfTime:6>0) | ([MedActFile:10]Role_Activity:4="Med. came@"))
				  //     LITIGATION CREATES ACTIVITY RCD W/0 HOURS  OR  
				  //     MEDIATOR SHOWS, BUT NO CASES AVAILABLE - 0 HOURS        
				$Insert:=Size of array:C274(aMKey)+1
				INSERT IN ARRAY:C227(aMKey;$Insert)
				INSERT IN ARRAY:C227(aMDate;$Insert)
				INSERT IN ARRAY:C227(aMType;$Insert)
				INSERT IN ARRAY:C227(aMTime;$Insert)
				INSERT IN ARRAY:C227(aMResult;$Insert)
				INSERT IN ARRAY:C227(aMProg;$Insert)
				aMKey{$Insert}:=[MedActFile:10]mafKey:1
				aMDate{$Insert}:=[MedActFile:10]ActDate:5
				aMType{$Insert}:=[MedActFile:10]Role_Activity:4
				If ((aMType{$Insert}="Moderator") | (aMType{$Insert}="Moderator-Admin"))
					aMType{$Insert}:="Mediator"  // MSC NOT SEPARATE, SO CHANGE TO MEDIATOR SUM
				End if 
				aMTime{$Insert}:=[MedActFile:10]AmtOfTime:6
				aMResult{$Insert}:=[MedActFile:10]ActResults:8
				aMProg{$Insert}:=[MedActFile:10]mafCaseNo:3
			End if 
			NEXT RECORD:C51([MedActFile:10])
		End for 
	End if 
	NEXT RECORD:C51([MediatorFile:9])
End for 
For ($i;1;Size of array:C274(aMKey))
	If ((aMDate{$i}<vBegDate) | (aMDate{$i}>vEndDate))
		aMDate{$i}:=!00-00-00!
	End if 
End for 
$Start:=1
Repeat 
	$Find:=Find in array:C230(aMDate;!00-00-00!;$Start)
	If ($Find#-1)
		$Start:=$Find
		DELETE FROM ARRAY:C228(aMKey;$Find)
		DELETE FROM ARRAY:C228(aMDate;$Find)
		DELETE FROM ARRAY:C228(aMType;$Find)
		DELETE FROM ARRAY:C228(aMTime;$Find)
		DELETE FROM ARRAY:C228(aMResult;$Find)
		DELETE FROM ARRAY:C228(aMProg;$Find)
	End if 
Until ($Find=-1)