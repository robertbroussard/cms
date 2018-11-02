//%attributes = {"publishedWeb":true}
  //G-Proc: CheckRoles; CheckRoles is called from the OK button on the DFInput 
  //layout. It Checks that all of the Mediator Roles were entered properly.
  //
_O_C_STRING:C293(80;$Dis1;$Dis2)
_O_C_STRING:C293(20;$Role1;$Role2;$Role3)
$RoleOK:=False:C215
RELATE MANY:C262([DocketFile:6]DocKey:6)
If (Records in selection:C76([MedActFile:10])>1)  // PUT ADMIN. MODERATOR ON TOP
	If ([MedActFile:10]mafCaseNo:3[[9]]="M")
		ORDER BY:C49([MedActFile:10];[MedActFile:10]mafDocKey:2;>;[MedActFile:10]Role_Activity:4;<)
	End if 
End if 
FIRST RECORD:C50([MedActFile:10])
If (Records in selection:C76([MedActFile:10])>=1)  //main if statement
	Case of 
		: (([IntakeFile:1]Program:32="A") & (Records in selection:C76([MedActFile:10])#1))
			ALERT:C41("There can be only one Arbitrator")
			vLastError:=False:C215
		: (([IntakeFile:1]Program:32="A") & (Records in selection:C76([MedActFile:10])=1) & ([DocketFile:6]HResults:11#"STL"))
			ALERT:C41("Arbitrated results must be STL")
			vLastError:=False:C215
		: (([IntakeFile:1]Program:32="A") & ([MedActFile:10]Role_Activity:4#"Arbitrator"))
			ALERT:C41("The role for an arbitration case must be 'Arbitrator'")
			vLastError:=False:C215
		: (([IntakeFile:1]Program:32="A") & (Records in selection:C76([MedActFile:10])=1) & ([DocketFile:6]HResults:11="STL"))
			$RoleOK:=True:C214
		: (([IntakeFile:1]Program:32="M") & (Records in selection:C76([MedActFile:10])#3))
			ALERT:C41("There must be three moderators - one Admin & two regular")
			vLastError:=False:C215
		Else 
			Case of 
				: (Records in selection:C76([MedActFile:10])=1)
					Case of 
						: (([MedActFile:10]Role_Activity:4#"Mediator") & (([DocketFile:6]HResults:11="STL") | ([DocketFile:6]HResults:11="IMP")))
							ALERT:C41("There is only one mediator listed for this case.  The role should be 'Mediator'.")
							vLastError:=False:C215
						: (([MedActFile:10]Role_Activity:4#"Ventilation") & ([DocketFile:6]HResults:11="VEN"))
							ALERT:C41("This case is listed as a ventilation.  "+Char:C90(13)+"The role should be 'Ventilation'.")
							vLastError:=False:C215
						: (([MedActFile:10]Role_Activity:4#"Mediator") & ([DocketFile:6]HResults:11="CONT"))
							ALERT:C41("This Case is listed as a continuation.  "+Char:C90(13)+"The role should be Mediator.")
							vLastError:=False:C215
						Else 
							$RoleOK:=True:C214
					End case 
				: (Records in selection:C76([MedActFile:10])=2)
					$Role1:=[MedActFile:10]Role_Activity:4
					NEXT RECORD:C51([MedActFile:10])
					$Role2:=[MedActFile:10]Role_Activity:4
					If ([DocketFile:6]HResults:11="VEN")
						Case of 
							: (($Role1="Ventilation") & ($Role2="Observer"))
								$RoleOK:=True:C214
							: (($Role2="Ventilation") & ($Role1="Observer"))
								$RoleOK:=True:C214
							Else 
								$Dis1:="roles should  be Ventilation and Observer."
								ALERT:C41("This case is listed as a ventilation.  The 2 mediators' "+$Dis1)
								vLastError:=False:C215
						End case 
					Else 
						Case of 
							: (($Role1="Mediator") & ($Role2="Observer"))
								$RoleOK:=True:C214
							: (($Role1="Observer") & ($Role2="Mediator"))
								$RoleOK:=True:C214
							: (($Role1="Co-mediator") & ($Role2="Co-mediator"))
								$RoleOK:=True:C214
							Else 
								$Dis1:="There are 2 mediators listed for this case.  "+Char:C90(13)
								$Dis2:="Their roles should be Mediator & Observer "+Char:C90(13)+"or both should be Co-mediators"
								ALERT:C41($Dis1+$Dis2)
								vLastError:=False:C215
						End case 
					End if 
				: (Records in selection:C76([MedActFile:10])=3)
					$Role1:=[MedActFile:10]Role_Activity:4
					NEXT RECORD:C51([MedActFile:10])
					$Role2:=[MedActFile:10]Role_Activity:4
					NEXT RECORD:C51([MedActFile:10])
					$Role3:=[MedActFile:10]Role_Activity:4
					Case of 
						: (([IntakeFile:1]Program:32="M") & ($Role1="Moderator-Admin") & ($Role2="Moderator") & ($Role3="Moderator"))
							$RoleOK:=True:C214
						: ([IntakeFile:1]Program:32="M")
							$RoleOK:=False:C215
							ALERT:C41("First Moderator role must be Moderator-Admin")
						Else 
							If ([DocketFile:6]HResults:11="VEN")
								ALERT:C41("There can only be one mediator in a Ventilation- 3 are listed.")
								vLastError:=False:C215
							Else 
								Case of 
									: ((($Role1="Co-mediator") & ($Role2="Co-mediator")) & ($Role3="Observer"))
										$RoleOK:=True:C214
									: ((($Role1="Co-mediator") & ($Role2="Observer")) & ($Role3="Co-mediator"))
										$RoleOK:=True:C214
									: ((($Role1="Observer") & ($Role2="Co-mediator")) & ($Role3="Co-mediator"))
										$RoleOK:=True:C214
										
										  //                      ADDED COMBO'S FOR MORE "OBSERVER"S
										
									: ((($Role1="Mediator") & ($Role2="Observer")) & ($Role3="Observer"))
										$RoleOK:=True:C214
									: ((($Role1="Observer") & ($Role2="Mediator")) & ($Role3="Observer"))
										$RoleOK:=True:C214
									: ((($Role1="Observer") & ($Role2="Observer")) & ($Role3="Mediator"))
										$RoleOK:=True:C214
										
									Else 
										
										ALERT:C41("This case has 3 mediators. "+Char:C90(13)+"The mediator roles should be 2 co-mediators "+Char:C90(13)+" & 1 Observer")
										vLastError:=False:C215
								End case 
							End if 
					End case 
					
				: (Records in selection:C76([MedActFile:10])<6)  //                   ACCEPT MULTIPLE OBSERVERS    3/03
					$RoleOK:=True:C214
					
				: (Records in selection:C76([MedActFile:10])>5)
					ALERT:C41("Error: You can't have more than 5 mediators per case.")
					vLastError:=False:C215
			End case 
	End case 
Else 
	ALERT:C41("This case should have at least one mediator. Please correct this before exiting.")
	vLastError:=False:C215
End if   //Main if statement
$0:=$RoleOK