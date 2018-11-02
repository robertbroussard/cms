//%attributes = {"publishedWeb":true}
  //G-Proc: BuildSearch;   Called by Program Report under page 1 Menu "Reports"
  //   Programs come from a list on the List Editor
  //
_O_C_STRING:C293(1;$Program)
_O_C_STRING:C293(20;$1;$2)
_O_C_INTEGER:C282($Check1;$Check2)
C_BOOLEAN:C305($0)  //12/9/94 - was string
$Check1:=1
$Check2:=1
$0:=True:C214
Case of 
	: ($1="Community-Based")
		$Program:="C"
	: ($1="Family")
		$Program:="F"
	: ($1="JUMP")
		$Program:="J"
	: ($1="Litigation")
		$Program:="L"
	: ($1="Special Ed")
		$Program:="S"
	: ($1="Probation")
		$Program:="P"
	: ($1="Victim-Offender")
		$Program:="V"
	: ($1="CPS")
		$Program:="W"  // ADDED 8-99, CHILD PROTECT. SVC.
	: ($1="CFK")
		$Program:="K"  // ADDED 1-01, COOPERATE FOR KIDS   
	: ($1="TRUANT")
		$Program:="T"  // ADDED 11-03, COOPERATE FOR KIDS        
	Else 
		$Check1:=0
End case 
If ($2="All Referrals")
	$Check2:=0
Else 
	$Referral:=$2
End if 
Case of 
	: (($Check1=0) & ($Check2=0))
		QUERY:C277([IntakeFile:1];[IntakeFile:1]IntakeDate:4>=vBegDate;*)
		  //QUERY([IntakeFile]; & ;[IntakeFile]IntakeDate>=vEndDate)     `mod 7/22/10 RJB
		QUERY:C277([IntakeFile:1]; & ;[IntakeFile:1]IntakeDate:4<=vEndDate)
	: (($Check1=1) & ($Check2=0))
		  //QUERY([IntakeFile]IntakeDate±vBegDate;vEndDate;[IntakeFile]Program=$Program)
		QUERY:C277([IntakeFile:1];[IntakeFile:1]IntakeDate:4>=vBegDate;*)
		  //QUERY([IntakeFile]; & ;[IntakeFile]IntakeDate>=vEndDate;*)  `mod 7/22/10 RJB
		QUERY:C277([IntakeFile:1]; & ;[IntakeFile:1]IntakeDate:4<=vEndDate;*)
		QUERY:C277([IntakeFile:1]; & ;[IntakeFile:1]Program:32=$Program)
	: (($Check1=0) & ($Check2=1))
		  //QUERY([IntakeFile]IntakeDate±vBegDate;vEndDate;[IntakeFile]RefBy=$Referral)
		QUERY:C277([IntakeFile:1];[IntakeFile:1]IntakeDate:4>=vBegDate;*)
		  //QUERY([IntakeFile]; & ;[IntakeFile]IntakeDate>=vEndDate;*)  `mod 7/22/10 RJB
		QUERY:C277([IntakeFile:1]; & ;[IntakeFile:1]IntakeDate:4<=vEndDate;*)
		QUERY:C277([IntakeFile:1]; & ;[IntakeFile:1]Program:32=$Referral)
	: (($Check1=1) & ($Check2=1))
		  //QUERY([IntakeFile]IntakeDate±vBegDate;vEndDate;[IntakeFile]RefBy=$Referral;[IntakeFile]Program=$Program)
		QUERY:C277([IntakeFile:1];[IntakeFile:1]IntakeDate:4>=vBegDate;*)
		  //QUERY([IntakeFile]; & ;[IntakeFile]IntakeDate>=vEndDate;*)  `mod 7/22/10 RJB
		QUERY:C277([IntakeFile:1]; & ;[IntakeFile:1]IntakeDate:4<=vEndDate;*)
		QUERY:C277([IntakeFile:1]; & ;[IntakeFile:1]Program:32=$Referral;*)
		QUERY:C277([IntakeFile:1]; & ;[IntakeFile:1]Program:32=$Program)
	Else 
		$0:=False:C215
End case 
