//%attributes = {"publishedWeb":true}
  // QuickenDirty:  Report of all Mediators whose last activity was within the 

  // specified dates for the Litigation or Family programs.  Sort activity date 

  // descending so can get the latest activity and put that activity record

  // to a set.  At end, activate this set of records and print Quick Report.

  //

C_TEXT:C284($Key;$Program)
C_LONGINT:C283($While)
C_DATE:C307($StartDate;$EndDate)
$Key:=""
  //

ALERT:C41("Did you change Report Header to 'Litigation' or 'Family' in Page Setup "+"under the File Menu")
$Program:=Request:C163("Enter 'L' for Litigation or 'F' for Family";"L")
If (OK=1)
	CREATE EMPTY SET:C140([MedActFile:10];"sMafSet")
	$StartDate:=Date:C102(Request:C163("Enter the Beginning Date as: mm/dd/yyyy"))
	$EndDate:=Date:C102(Request:C163("Enter the Ending Date as: mm/dd/yyyy"))
	If (($Program#"F") & ($Program#"L"))
		$Program:="L"
	End if 
	$While:=1
	While ($While=1)
		Case of 
			: ($StartDate=!00-00-00!)
				ALERT:C41("You must enter the Beginning Date or choose Cancel")
			: ($EndDate=!00-00-00!)
				ALERT:C41("You must enter the Ending Date or choose Cancel")
			Else 
				$While:=0
		End case 
		If (OK=0)
			$While:=0
		End if 
	End while 
	  //  
	
	If (OK=1)
		  //    
		
		QUERY:C277([MedActFile:10];[MedActFile:10]ActDate:5>=$StartDate;*)
		QUERY:C277([MedActFile:10]; & ;[MedActFile:10]ActDate:5<=$EndDate)
		If ($Program="L")
			QUERY SELECTION:C341([MedActFile:10];[MedActFile:10]mafCaseNo:3="@A";*)
			QUERY SELECTION:C341([MedActFile:10]; | ;[MedActFile:10]mafCaseNo:3="@L";*)
			QUERY SELECTION:C341([MedActFile:10]; | ;[MedActFile:10]mafCaseNo:3="@M")
		Else 
			QUERY SELECTION:C341([MedActFile:10];[MedActFile:10]mafCaseNo:3="@F")
		End if 
		  //
		
		ORDER BY:C49([MedActFile:10];[MedActFile:10]mafKey:1;>;[MedActFile:10]ActDate:5;<)
		  //
		
		For ($i;1;Records in selection:C76([MedActFile:10]))
			If ([MedActFile:10]mafKey:1#$Key)
				ADD TO SET:C119([MedActFile:10];"sMafSet")
			End if 
			$Key:=[MedActFile:10]mafKey:1
			NEXT RECORD:C51([MedActFile:10])
		End for 
		USE SET:C118("sMafSet")
		CLEAR SET:C117("sMafSet")
		QR REPORT:C197([MedActFile:10];"QR_LitActMed";*)
	End if 
End if 