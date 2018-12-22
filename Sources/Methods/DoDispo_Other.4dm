//%attributes = {"publishedWeb":true}
  // G-Proc: DoDispo_Other:  procedure to put out disposition form OTHER than

  // Juvenile and Family

  // 

C_TEXT:C284(vDCtPD;vDHCJPD_No;vDCt_No;vDPD_No)
C_TEXT:C284(vCaseNo)
C_TEXT:C284(vDRTC_Date)
If (([IntakeFile:1]Program:32#"J") & ([IntakeFile:1]Program:32#"F"))
	vCaseNo:=[IntakeFile:1]CaseNo:1
	vPrintDate:=String:C10(Current date:C33;3)
	vDRefBy:=[IntakeFile:1]RefBy:16
	vDCtPD:=[IntakeFile:1]CauseNo:5
	vDCaseStyle:=[IntakeFile:1]CaseStyle:23
	vDFullName:=[IntakeFile:1]RFName:12+" "+[IntakeFile:1]RLName:11
	vDPD_No:=""
	vDMedD_n_T:=""
	vDAmtRes:=""
	vComments:=""
	vcopy:=""
	DIALOG:C40([DailyLtrFile:14];"DispoOther_In")
	If (OK=1)
		PAGE SETUP:C299([DailyLtrFile:14];"DispoOther_Out")
		Print form:C5([DailyLtrFile:14];"DispoOther_Out")
		PAGE BREAK:C6
		vcopy:="COPY"
		PAGE SETUP:C299([DailyLtrFile:14];"DispoOther_Out")
		Print form:C5([DailyLtrFile:14];"DispoOther_Out")
		PAGE BREAK:C6
		[IntakeFile:1]InterimCon:30:=[IntakeFile:1]InterimCon:30+"  (Disposition printed for: "+vDFullName+" "+String:C10(Current date:C33;4)
		[IntakeFile:1]InterimCon:30:=[IntakeFile:1]InterimCon:30+" @ "+String:C10(Current time:C178;4)+" "+vInitials+")"
		SAVE RECORD:C53([IntakeFile:1])
	End if 
Else 
	ALERT:C41("Cannot use this form for Jump or Family dispositions."+Char:C90(13)+"Select the proper button, either #2 or #5.")
End if 