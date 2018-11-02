//%attributes = {"publishedWeb":true}
  //(P) FamMediate - called by FamilyDispo to look up mediator activity
  // and mediator names for the Family Disposition Form - Letter button 2.
  //
_O_C_INTEGER:C282($i;$aSize;ActSize;$Insert;$i)
C_DATE:C307($ActDate)
_O_C_STRING:C293(255;vOtherDate)
C_BOOLEAN:C305(vMedSw)
  //
vOtherDate:=""
vResult:=""
QUERY:C277([MedActFile:10];[MedActFile:10]mafCaseNo:3=vCaseNo)  // FIND ACTIVITY RECDS FOR DISPO
If (Records in selection:C76([MedActFile:10])=0)
	vMedSw:=False:C215
	vMedActDate:=!00-00-00!
Else 
	vMedSw:=True:C214
	ORDER BY:C49([MedActFile:10];[MedActFile:10]ActDate:5;<)
	vMedActDate:=[MedActFile:10]ActDate:5  // STORE LATEST ACTIVITY
	Case of 
		: ([MedActFile:10]ActResults:8="STL")  // TRANSLATE SELECTED RESULTS FOR DISPO
			vResult:="settlement"
		: ([MedActFile:10]ActResults:8="IMP")
			vResult:="impasse"
		: ([MedActFile:10]ActResults:8="VEN")
			vResult:="ventilation"
			vMedSw:=False:C215
			vMedActDate:=!00-00-00!
	End case 
	RELATE ONE:C42([MedActFile:10]mafKey:1)
	If (Records in selection:C76([MediatorFile:9])=0)  // USE MAFKEY TO FIND MEDIATOR RECD & LOAD NAME(S)
		ALERT:C41("No mediator for activity record: "+[MedActFile:10]mafKey:1)
	Else 
		If ([MediatorFile:9]JrOrSuffix:10>"")  // REMOVE EXTRANEOUS SPACE ON PRINTOUT
			$Spacer:=" "
		Else 
			$Spacer:=""
		End if 
		vMed1:=[MediatorFile:9]MFName:2+" "+[MediatorFile:9]MLName:1+$Spacer+[MediatorFile:9]JrOrSuffix:10
		If (Records in selection:C76([MedActFile:10])>1)  // IS THERE A 2ND MEDIATOR RECORD?
			NEXT RECORD:C51([MedActFile:10])
			If ([MedActFile:10]ActDate:5=vMedActDate)  // SAME DATE = SAME MEDIATION
				RELATE ONE:C42([MedActFile:10]mafKey:1)
				If (Records in selection:C76([MediatorFile:9])=0)
					ALERT:C41("No mediator for activity record: "+[MedActFile:10]mafKey:1)
				Else 
					vMed2:=[MediatorFile:9]MFName:2+" "+[MediatorFile:9]MLName:1+" "+[MediatorFile:9]JrOrSuffix:10
				End if   // Relate to 2nd mediator name
			End if   // Test date
		End if   // nbr maf recds >1
	End if   // if mediator recds = 0
	ORDER BY:C49([MedActFile:10];[MedActFile:10]ActDate:5;>)
	$ActSize:=Records in selection:C76([MedActFile:10])  // LIST ALL ACTIVITY DATES FOR CASE
	$ActDate:=!00-00-00!
	ARRAY DATE:C224(aDate;0)
	FIRST RECORD:C50([MedActFile:10])
	For ($i;1;$ActSize)
		If ([MedActFile:10]ActDate:5#$ActDate)  // CHECK FOR & SKIP DUPLICATE ACTIVITY DATES
			$ActDate:=[MedActFile:10]ActDate:5
			$Insert:=Size of array:C274(aDate)+1  // BUILD ARRAY OF UNIQUE ACTIVITY DATES
			INSERT IN ARRAY:C227(aDate;$Insert)
			aDate{$Insert}:=[MedActFile:10]ActDate:5
		End if 
		NEXT RECORD:C51([MedActFile:10])
	End for 
	$Insert:=0
	$aSize:=Size of array:C274(aDate)
	For ($i;1;$aSize)
		$Insert:=$Insert+1
		$And:=", "
		Case of 
			: ($aSize=1)
				$And:=""
			: ($i=$aSize)
				$And:=""
			: ($i=($aSize-1))
				$And:=" and "
		End case 
		vOtherDate:=vOtherDate+(String:C10(aDate{$Insert};7))+$And  // DATE TYPE 7: 4 DIGIT YEAR
	End for 
End if   // nbr maf recds = 0
ARRAY DATE:C224(aDate;0)