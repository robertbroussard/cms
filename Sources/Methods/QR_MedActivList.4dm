//%attributes = {"publishedWeb":true}
  // QuickenDirty:  Report of all Mediators whose last activity was earlier 

  //  than the specified cut off date. 


  //Modified by Robert J. Broussard <robert@usersoft.com>

  //UserSoft Technology <www.usersoft.com>

  //Modified: 9/3/02


C_TEXT:C284($Key)  //Mod RJB 9/3/02

C_LONGINT:C283($While)
C_DATE:C307($CutOffDate)
$Key:=""
CREATE EMPTY SET:C140([MediatorFile:9];"sMedSet")
  //

$CutOffDate:=Date:C102(Request:C163("Enter the Cutoff Date as: mm/dd/yyyy"))
$While:=1
While ($While=1)
	Case of 
		: ($CutoffDate=!00-00-00!)
			ALERT:C41("You must enter the Cutoff Date or choose Cancel")
		Else 
			$While:=0
	End case 
	If (OK=0)  //  IF CANCEL PRESSED, THEN GET OUT OF LOOP
		
		$While:=0
	End if 
End while 
  //

ALL RECORDS:C47([MediatorFile:9])
QUERY:C277([MediatorFile:9];[MediatorFile:9]MFInact:15=False:C215)  //   ACTIVE MEDIATORS

ALERT:C41("Mediator records selected  "+String:C10(Records in selection:C76([MediatorFile:9])))
For ($i;1;Records in selection:C76([MediatorFile:9]))
	RELATE MANY:C262([MediatorFile:9]MKey:14)
	If (Records in selection:C76([MedActFile:10])=0)
		If ([MediatorFile:9]DateEntered:11<=$CutOffDate)
			ADD TO SET:C119([MediatorFile:9];"sMedSet")
		End if 
		  //Else 
		
		  // ORDER BY([MedActFile]ActDate)
		
		  //LAST RECORD([MedActFile])
		
		  //If ([MedActFile]ActDate<=$CutOffDate)
		
		  // ADD TO SET([MediatorFile];"sMedSet")
		
		  //End if 
		
	End if 
	NEXT RECORD:C51([MediatorFile:9])
	If ($i=1297)
		TRACE:C157
	End if 
End for 
USE SET:C118("sMedSet")
CLEAR SET:C117("sMedSet")
QR REPORT:C197([MediatorFile:9];"QR_LitActMed";*)