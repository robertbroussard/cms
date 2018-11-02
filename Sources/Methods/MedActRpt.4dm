//%attributes = {"publishedWeb":true}
  //G-Proc: MedActRpt
_O_C_INTEGER:C282($i;$Dialog;$RptLoop1)
_O_C_STRING:C293(65;$Temp;vPrintRate)
SET WINDOW TITLE:C213("DRC: Mediator Activity Reports")
_O_ARRAY STRING:C218(30;aMaster;0)
_O_ARRAY STRING:C218(30;aMKey;0)
ARRAY DATE:C224(aMDate;0)
_O_ARRAY STRING:C218(20;aMType;0)
ARRAY REAL:C219(aMTime;0)
_O_ARRAY STRING:C218(5;aMResult;0)
_O_ARRAY STRING:C218(20;aMProg;0)
vTotalHours:=0
vMed:=0
vmafStl:=0
vmafImp:=0
vRptName:=""
vBegDate:=!00-00-00!
vEndDate:=!00-00-00!
vTimeFrame:=""
vPrintDate:=""
$RptLoop1:=0
$Dialog:=1
vSelection:=""
vText1:=""
CLEAR VARIABLE:C89(aDisplay)
ALL RECORDS:C47([GroupLookup:17])
SELECTION TO ARRAY:C260([GroupLookup:17]GL_Group:1;aSGroup)
SORT ARRAY:C229(aSGroup;>)
INSERT IN ARRAY:C227(aSGroup;1)
aSGroup{1}:="All Groups"
While ($Dialog=1)
	DIALOG:C40([MediatorFile:9];"MedRptSelect")
	If (OK=1)
		vText1:=""
		Case of 
			: (vBegDate=!00-00-00!)
				ALERT:C41("You must enter the Beginning Date or choose Cancel.")
			: (vEndDate=!00-00-00!)
				ALERT:C41("You must enter the Ending Date or choose Cancel.")
			: (((vOption1=0) & (vOption2=0)) & (vOption3=0))
				ALERT:C41("Report option was not specified. Select an option or choose Cancel.")
			Else 
				If (vSelection="")
					ALERT:C41("Mediator or Mediator group was not selected. Make selection or choose cancel")
				Else 
					$Dialog:=0
					$RptLoop1:=1
				End if 
		End case 
	Else 
		$Dialog:=0
	End if 
End while 
While ($RptLoop1=1)
	$RptLoop1:=0
	Case of 
		: (vOption1=1)
			vPrintRate:=Request:C163("Print Settlement Rate?  Enter 'y' or 'n'.";"N")
			If (vPrintRate#"y")
				vPrintRate:="n"
			End if 
			QUERY:C277([MediatorFile:9];[MediatorFile:9]MKey:14=vSelection)
			If (Records in selection:C76([MediatorFile:9])=1)
				RELATE MANY:C262([MediatorFile:9]MKey:14)
				If (Records in selection:C76([MedActFile:10])>0)
					GetActivity 
					If (Size of array:C274(aMKey)>0)
						PrintActivity2 
					End if 
				Else 
					ALERT:C41("No activity to report for "+vSelection+".")
				End if 
			Else 
				ALERT:C41("Mediator "+vSelection+" not found.")
			End if 
		: (vOption2=1)
			If (vSelection#"All Groups")
				QUERY:C277([MediatorFile:9];[Groups:13]Group:2=vSelection)
				If (Records in selection:C76([MediatorFile:9])>0)
					GetActivity 
					If (Size of array:C274(aMKey)>0)
						PrintActivity2 
					End if 
				Else 
					ALERT:C41("No activity to report for group :"+vSelection)
				End if 
			Else 
				ALL RECORDS:C47([MediatorFile:9])
				GetActivity 
				If (Size of array:C274(aMKey)>0)
					PrintActivity2 
				End if 
			End if 
		: (vOption3=1)
			If (vSelection#"All Groups")
				QUERY:C277([MediatorFile:9];[Groups:13]Group:2=vSelection)
				If (Records in selection:C76([MediatorFile:9])>0)
					GetActivity 
				Else 
					ALERT:C41("No activity to report for group :"+vSelection)
				End if 
			Else 
				ALL RECORDS:C47([MediatorFile:9])
				GetActivity 
			End if 
			If (Size of array:C274(aMKey)>0)
				For ($i;1;Size of array:C274(aMKey))
					vTotalHours:=vTotalHours+aMTime{$i}
					If (aMResult{$i}="STL")
						vMed:=vMed+1
						vmafStl:=vmafStl+1
					Else 
						If (aMResult{$i}="IMP")
							vMed:=vMed+1
							vmafImp:=vmafImp+1
						End if 
					End if 
				End for 
				$Temp:="Summary Report for Group:  "+vSelection
				PrintHeader ($Temp)
				vSubDetail:="Total Volunteer Hours for Group:  "+vSelection+" "+String:C10(vTotalHours;"###,##0.00")
				Print form:C5([IntakeFile:1];"SubHead1")
				vSubDetail:=""
				Print form:C5([IntakeFile:1];"SubHead1")
				vSubDetail:="Settlement Rate for Group:  "+String:C10((vmafStl/vMed)*100;"###,##0.00")+" %"
				Print form:C5([IntakeFile:1];"SubHead1")
				$NumMed:=Size of array:C274(aMaster)
				For ($i;1;Size of array:C274(aMaster))
					$Find:=Find in array:C230(aMkey;aMaster{$i};1)
					If ($Find=-1)
						$NumMed:=$NumMed-1  // DON'T COUNT MEDIATORS WITH NO CURRENT ACTIVITY RECDS
					End if 
				End for 
				vSubDetail:="Number of Mediators in Group: "+vSelection+",  "+String:C10($NumMed)
				Print form:C5([IntakeFile:1];"SubHead1")
				PAGE BREAK:C6
			End if 
	End case 
End while 
CLEAR VARIABLE:C89(vSubDetail)
CLEAR VARIABLE:C89(aMaster)
CLEAR VARIABLE:C89(aMKey)
CLEAR VARIABLE:C89(aMDate)
CLEAR VARIABLE:C89(aMType)
CLEAR VARIABLE:C89(aMTime)
CLEAR VARIABLE:C89(aMResult)
CLEAR VARIABLE:C89(aMProg)
SET WINDOW TITLE:C213("DRC Case Management System")