//%attributes = {}
  //Print form([IntakeFile];"StateReport_06_A_Filed")

  //things to set:

  //A) Filed or NotFiled?

  //B) YearMonth


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
ARRAY TEXT:C222(pTypePopup;2)
pTypePopup{1}:="Filed"
pTypePopup{2}:="UnFiled"

pStartDate:=1
pEndDate:=1
pTypePopup:=1

  //OpenCenteredWindow (368;228;8;"State Report")

OpenCenteredWindow (260;188;5;"State Report")
DIALOG:C40([IntakeFile:1];"SR_ReportSelect")  // Display a custom search dialog 

GET WINDOW RECT:C443($left;$top;$right;$bottom)
$w:=$right-$left
$h:=$bottom-$top
  //ALERT("Win Dimensions are: "+String($w)+" X "+String($h))

CLOSE WINDOW:C154  // No longer need the modal window 

If (OK=1)  // If the dialog is accepted 

	
	
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
	
	C_TEXT:C284(vSR_CaseType)
	ARRAY TEXT:C222(aSR_CaseType;0)
	ARRAY TEXT:C222(aSR_CaseType;14)
	C_BOOLEAN:C305($Filed;vSR_LegacyPenSelected)
	vSR_LegacyPenSelected:=False:C215
	
	$Filed:=pTypePopup{pTypePopup}="Filed"
	$rec:=Size of array:C274($aYearMonthArray)
	PRINT SETTINGS:C106
	If (ok=1)
		SR_RecDumpLog ("Start";$NumReports;$YearMonth;$Filed;"";"")
		
		For ($j;1;$rec)
			$YearMonth:=$aYearMonthArray{$j}
			SR_SetDefaults 
			vLocation:="Location: Harris County DRC"
			vReportDate:=Get indexed string:C510(11;Num:C11(Substring:C12($YearMonth;5;2))+12)+", "+Substring:C12($YearMonth;1;4)
			  //don't allow future months to be selected

			If (SR_BOM_DC ($YearMonth;$Filed))  //True = "Filed"

				
				If ($Filed)
					$HdrForm:="StateReport_06_Hdr"
					$DetailForm:="StateReport_06_Detail"
					$FooterForm:="StateReport_06_Footer"
				Else 
					$HdrForm:="StateReport_B_06_Hdr"
					$DetailForm:="StateReport_B_06_Detail"
					$FooterForm:="StateReport_06_Footer"
					
				End if 
				
				Print form:C5([IntakeFile:1];$HdrForm)
				  //StateReport_B_06_Hdr

				SR_GetPending ($YearMonth)
				SR_GetFiledCases ($Filed)
				
				$sel:=Size of array:C274(aSR_CaseType)
				ARRAY LONGINT:C221(aBOM;$sel)  //aBOM

				For ($i;1;$sel)
					vSR_CaseType:=aSR_CaseType{$i}
					$CaseTypeS:=Substring:C12(vSR_CaseType;1;1)
					
					If ($Filed)
						vSR_1:=SR_01 ($i;$Filed)  //Same

						vSR_2:=SR_02 ($CaseTypeS;$Filed;$YearMonth)  //Not Used

						vSR_3:=SR_03 ($CaseTypeS;$Filed;$YearMonth)  //Not Used

						vSR_4:=SR_04 ($CaseTypeS;$Filed;$YearMonth)  //Not Used

						vSR_5:=SR_05 ($CaseTypeS;$Filed;$YearMonth)  //Not Used

						vSR_6:=SR_06 ($CaseTypeS;$Filed;$YearMonth)  //Not Used

						vSR_7:=SR_07 ($CaseTypeS;$Filed;$YearMonth)  //Not Used

						vSR_8:=SR_08 ($CaseTypeS;$Filed;$YearMonth)  //#3

						vSR_9:=0  //#4

						vSR_10:=SR_10 ($CaseTypeS;$Filed;$YearMonth)  //#5

						vSR_11:=SR_11 ($CaseTypeS;$Filed;$YearMonth)  //#6

						vSR_12:=SR_12 ($CaseTypeS;$Filed;$YearMonth;$i)  //#7

						If ($i=1)
							vSR_13:=SR_13 ($CaseTypeS;$Filed;$YearMonth)  //#8

							vSR_14:=SR_14   //#9  ` ($CaseTypeS;$Filed;$YearMonth)

						Else 
							vSR_13:=0
							vSR_14:=0
						End if 
					Else 
						vSR_1:=SR_01 ($i;$Filed)  //Same

						vSR_2:=SR_02B ($CaseTypeS;$Filed;$YearMonth)  //done

						vSR_3:=SR_03B ($CaseTypeS;$Filed;$YearMonth)  //done

						vSR_4:=0
						vSR_5:=SR_05B ($CaseTypeS;$Filed;$YearMonth)  //done

						vSR_6:=SR_06B ($CaseTypeS;$Filed;$YearMonth)  //done

						vSR_7:=SR_07B ($CaseTypeS;$Filed;$YearMonth;$i)  //done

						If ($i=1)
							vSR_8:=SR_08B ($CaseTypeS;$Filed;$YearMonth)  //done

							vSR_9:=SR_14   //done

						Else 
							vSR_8:=0
							vSR_9:=0
						End if 
						
					End if 
					Print form:C5([IntakeFile:1];$DetailForm)
				End for 
				Print form:C5([IntakeFile:1];$FooterForm)
			Else 
				BEEP:C151
				ALERT:C41("Report cancelled by user...")
			End if 
		End for 
		ARRAY TEXT:C222(aSR_CaseType;0)
		ARRAY LONGINT:C221(aBOM;0)
		CLEAR SET:C117("Pending")
		CLEAR SET:C117("DC")
		CLEAR SET:C117("R1")
		CLEAR SET:C117("R2")
		CLEAR SET:C117("Final")
		CLEAR SET:C117("RefBy")
		CLEAR SET:C117("AllRecs")
		CLEAR SET:C117("RecipCases")
		CLEAR SET:C117("CaseType")
		SR_RecDumpLog ("End";$NumReports;$YearMonth;$Filed;"";"")
		
	End if 
End if 