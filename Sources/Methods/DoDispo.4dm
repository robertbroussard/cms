//%attributes = {"publishedWeb":true}
  //G-Proc: Do_Dispo;
_O_C_INTEGER:C282($i;$Insert)
_O_C_STRING:C293(15;vDCtPD;vDHCJPD_No;vDCt_No;vDPD_No)
_O_C_STRING:C293(9;vCaseNo)
_O_C_STRING:C293(6;vDRTC_Date)
If ([IntakeFile:1]Program:32="J")
	vCaseNo:=[IntakeFile:1]CaseNo:1
	vPrintDate:=String:C10(Current date:C33;3)
	vDRefBy:=[IntakeFile:1]RefBy:16
	vDCtPD:=[IntakeFile:1]Ct_PdNo:5
	vDFullName:=""
	vDType:=""
	vDHCJPD_No:=""
	vDCt_No:=""
	vDRTC_Date:=""
	vDPD_No:=""
	vDAmtCSR:=""
	vDMedD_n_T:=""
	vDAmtRes:=""
	GetAllParties 
	_O_ARRAY STRING:C218(41;aDFullName;0)
	_O_ARRAY STRING:C218(10;aDType;0)
	For ($i;1;Size of array:C274(aPLName))
		$Insert:=Size of array:C274(aDFullName)+1
		INSERT IN ARRAY:C227(aDFullName;$Insert)
		INSERT IN ARRAY:C227(aDType;$Insert)
		aDFullName{$Insert}:=aPFName{$i}+" "+aPLName{$i}+"  ("+aPartyType{$i}+")"
		aDType{$Insert}:=aPartyType{$i}
	End for 
	OK:=1
	While (OK=1)
		aDFullName:=0
		vComments:=""  // CLEAR COMMENTS FIELD ON DISPO FOR NEXT REPORT
		DIALOG:C40([DailyLtrFile:14];"Dispo_Input")
		If (OK=1)
			PAGE SETUP:C299([DailyLtrFile:14];"Dispo_Out")
			Print form:C5([DailyLtrFile:14];"Dispo_Out")
			PAGE BREAK:C6
			[IntakeFile:1]InterimCon:30:=[IntakeFile:1]InterimCon:30+"  Disposition printed for: "+vDFullName+String:C10(Current date:C33;4)+"."
			SAVE RECORD:C53([IntakeFile:1])
		End if 
		CONFIRM:C162("Print another disposition for this case?")
	End while 
Else 
	ALERT:C41("This is not a JUMP case; you cannot use this option.")
End if 