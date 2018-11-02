//%attributes = {}


  //$winRef:=Open form window([IntakeFile];"SR_ReportSelect";1)
  //ALERT("stop")
  //Open window(10;40;370;220;8)  ` Open a modal window 
  //$CurrDate:=Current date
  //For ($i;1;24)
  //$CurrDate:=$CurrDate-30
  //End for 

  //SR_FormatYearMonth
  //-1 = PrevMonth
  //PrevMonth
  //
  //$CurrDate:=Current date
  //$Dayof:=Day of($CurrDate)

  //$SRYear:=Year of($CurrDate)
  //If ($Dayof<10)
  //$CurrDate:=$CurrDate-30
  //$SRMonth:=Month of($CurrDate)-1
  //Else 
  //$SRMonth:=Month of($CurrDate)
  //End if 

  //$YearMonth:=String($SRYear)+String($SRMonth;"00")
$BackMonths:=18
ARRAY TEXT:C222(pStartDate;$BackMonths)
ARRAY TEXT:C222(pEndDate;$BackMonths)
ARRAY TEXT:C222($aSR_YMtDate;$BackMonths)
  //ARRAY TEXT($aSR_EndDate;$BackMonths)
$NextDate:=Add to date:C393(Current date:C33;0;1;0)
For ($i;1;$BackMonths)
	$YearMonth:=SR_PrevYearMonth ($NextDate)
	$YearMonthF:=Substring:C12($YearMonth;1;4)+", "+Get indexed string:C510(11;Num:C11(Substring:C12($YearMonth;5;2)))
	$NextDate:=Date:C102(Substring:C12($YearMonth;5;2)+"/1/"+Substring:C12($YearMonth;1;4))
	pStartDate{$i}:=$YearMonthF
	pEndDate{$i}:=$YearMonthF
	$aSR_YMtDate{$i}:=$YearMonth
	  //$aSR_EndDate{$i}:=$YearMonth
End for 
pStartDate:=1
pEndDate:=1

OpenCenteredWindow (368;228;8;"State Report")
DIALOG:C40([IntakeFile:1];"SR_ReportSelect")  // Display a custom search dialog 
GET WINDOW RECT:C443($left;$top;$right;$bottom)
$w:=$right-$left
$h:=$bottom-$top
  //ALERT("Win Dimensions are: "+String($w)+" X "+String($h))
CLOSE WINDOW:C154  // No longer need the modal window 
If (OK=1)  // If the dialog is accepted 
	  //`BEEP
	  //ALERT("Accept")
	
End if 

$NumReports:=Abs:C99(pStartDate-pEndDate)+1

If (pStartDate>pEndDate)
	  //11>8?
	  //increment end date by $NumRepors...
	$StartingElement:=pEndDate-1
	
Else 
	$StartingElement:=pStartDate-1
End if 

ARRAY TEXT:C222($aYearMonthArray;$NumReports)
For ($i;1;$NumReports)
	$aYearMonthArray{$i}:=$aSR_YMtDate{$StartingElement+$i}
End for 
SORT ARRAY:C229($aYearMonthArray;>)
If (False:C215)
	
	  //Print form([IntakeFile];"StateReport_06_A_Filed")
	
	C_TEXT:C284(vSR_CaseType)
	ARRAY TEXT:C222(aSR_CaseType;0)
	ARRAY TEXT:C222(aSR_CaseType;14)
	C_BOOLEAN:C305($Filed)
	$Filed:=True:C214
	aSR_CaseType{1}:="A. Motor Vehicle Injury/Damage"
	aSR_CaseType{2}:="B. Non-Motor Vehicle Injury/Damage"
	aSR_CaseType{3}:="C. Tax Cases"
	aSR_CaseType{4}:="D. Workers' Compensation"
	aSR_CaseType{5}:="E. Condemnation"
	aSR_CaseType{6}:="F. Accounts, Contracts, & Notes"
	aSR_CaseType{7}:="G. Reciprocals"
	aSR_CaseType{8}:="H. Divorce"
	aSR_CaseType{9}:="I. Other Family Law Matters"
	aSR_CaseType{10}:="J. Other Civil Cases"
	aSR_CaseType{11}:="K. Juvenile Cases"
	aSR_CaseType{12}:="L. Probate Cases"
	aSR_CaseType{13}:="M. Criminal Cases"
	aSR_CaseType{14}:="TOTALS"
	
	vSR_01_Total:=0
	vSR_02_Total:=0
	vSR_03_Total:=0
	vSR_04_Total:=0
	vSR_05_Total:=0
	vSR_06_Total:=0
	vSR_07_Total:=0
	vSR_08_Total:=0
	vSR_09_Total:=0
	vSR_10_Total:=0
	vSR_11_Total:=0
	vSR_12_Total:=0
	vSR_13_Total:=0
	vSR_14_Total:=0
	
	$YearMonth:="200508"
	vLocation:="Location: Harris County DRC"
	vReportDate:=Get indexed string:C510(11;Num:C11(Substring:C12($YearMonth;5;2))+12)+", "+Substring:C12($YearMonth;1;4)
	  //$test:=Get indexed string(11;8+12)
	  //don't allow future months to be selected
	If (True:C214)  //True = "Filed"
		
		PRINT SETTINGS:C106
		Print form:C5([IntakeFile:1];"StateReport_06_Hdr")
		$sel:=Size of array:C274(aSR_CaseType)
		For ($i;1;$sel)
			vSR_CaseType:=aSR_CaseType{$i}
			$CaseTypeS:=Substring:C12(vSR_CaseType;1;1)
			  //If ($i=1)
			If ($i=1)
				vSR_13:=SR_13 ($CaseTypeS;$Filed;$YearMonth)
				vSR_14:=SR_14 ($CaseTypeS;$Filed;$YearMonth)
				
			Else 
				vSR_13:=0
				vSR_14:=0
			End if 
			
			  //Else 
			  //SET VISIBLE(Variable1;True)
			  //End if 
			Print form:C5([IntakeFile:1];"StateReport_06_Detail")
		End for 
		Print form:C5([IntakeFile:1];"StateReport_06_Footer")
	Else 
		BEEP:C151
		ALERT:C41("Report cancelled by user...")
	End if 
End if 