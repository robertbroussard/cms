//%attributes = {"publishedWeb":true}
  //G-Proc: ProgRpt
SET WINDOW TITLE:C213("DRC: Program Report")
C_TEXT:C284(vProgram;vReferral)
C_TEXT:C284($Program)
C_LONGINT:C283($TIntakes;$Held;$i;$j;$Cont;$Con;$Dialog;$RptLoop1;$Imp;$Stl)
C_BOOLEAN:C305($SearchOK)  //12/9/94 - was undefined
vRptName:=""
vBegDate:=!00-00-00!
vEndDate:=!00-00-00!
vTimeFrame:=""
vPrintDate:=""
$RptLoop1:=0
$Dialog:=1
While ($Dialog=1)
	DIALOG:C40([IntakeFile:1];"RptSelections")
	If (OK=1)
		Case of 
			: (vBegDate=!00-00-00!)
				ALERT:C41("You must enter the Beginning Date or choose Cancel.")
			: (vEndDate=!00-00-00!)
				ALERT:C41("You must enter the Ending Date of choose Cancel.")
			: (vProgram="")
				ALERT:C41("Program was not specified. Select a program or choose Cancel.")
			: (vReferral="")
				ALERT:C41("Referral source was not specified. Select a Referral source or choose Cancel.")
			Else 
				$Dialog:=0
				$RptLoop1:=1
		End case 
	Else 
		$Dialog:=0
	End if 
End while 
While ($RptLoop1=1)
	$RptLoop1:=0
	$SearchOK:=BuildSearch (vProgram;vReferral)
	$TIntakes:=Records in selection:C76([IntakeFile:1])
	If (($TIntakes>0) & ($SearchOK=True:C214))
		BuildRefBy 
		BuildPResults 
		vRptName:="Mediation Program Report For: "+vProgram
		vTimeFrame:="From "+String:C10(vBegDate;7)+" to "+String:C10(vEndDate;7)
		vPrintDate:="Date Printed: "+String:C10(Current date:C33;7)+" Time: "+String:C10(Current time:C178;5)
		PRINT SETTINGS:C106
		  //PAGE SETUP([IntakeFile];"RptHeader")
		Print form:C5([IntakeFile:1];"RptHeader")
		vSubDetail:="Referral Source for this Report: "+vReferral
		Print form:C5([IntakeFile:1];"SubHead1")
		vSubDetail:=String:C10($TIntakes)+" intakes during report period."
		Print form:C5([IntakeFile:1];"SubHead1")
		vSubDetail:=""
		Print form:C5([IntakeFile:1];"SubHead1")
		For ($i;1;Size of array:C274(aProgram))
			Case of 
				: (aProgram{$i}="C")
					$Program:="Community-Based"
				: (aProgram{$i}="F")
					$Program:="Family"
				: (aProgram{$i}="J")
					$Program:="JUMP"
				: (aProgram{$i}="L")
					$Program:="Litigation"
				: (aProgram{$i}="S")
					$Program:="Special Ed"
				: (aProgram{$i}="P")
					$Program:="Probation"
				: (aProgram{$i}="T")  //             TRUANT        12/2003
					$Program:="Truant"
				: ((aProgram{$i}="W") | (aProgram{$i}="W"))
					$Program:="CPS"  //    COMBINE CPS AND CFK     1/01
				Else 
					$Program:="All Programs"
			End case 
			vText1:=$Program
			vText2:=""
			vText3:=""
			Print form:C5([IntakeFile:1];"SubHead2")
			For ($j;1;14)
				vText1:=""
				vText2:=""
				vText3:=""
				Case of 
					: ($j=1)
						vText1:="Intakes"
					: ($j=2)
						vText1:="Hold"
					: ($j=3)
						vText1:="Referred"
					: ($j=4)
						vText1:="Direct Assistance"
					: ($j=5)
						vText1:="Scheduled"
					: ($j=6)
						vText1:="Conciliated"
					: ($j=7)
						vText1:="Mediations Held"
					: ($j=8)
						vText1:="Settled"
					: ($j=9)
						vText1:="Impasse"
					: ($j=10)
						vText1:="Continued"
					: ($j=11)
						vText1:="Ventilated"
					: ($j=12)
						vText1:="Declined"
					: ($j=13)
						vText1:="No Show"
					: ($j=14)
						vText1:="Rescheduled"
				End case 
				vText2:=String:C10(aTotals{$i}{$j})
				Print form:C5([IntakeFile:1];"RptTextDetail")
			End for 
			$con:=aTotals{$i}{6}
			$stl:=aTotals{$i}{8}
			$held:=aTotals{$i}{7}
			$cont:=aTotals{$i}{10}
			$imp:=aTotals{$i}{9}
			vText1:="Program Settlement Rate: "+String:C10(Trunc:C95(((($con+$stl)/(($held+$con)-$cont))*100);2))
			vText2:=""
			Print form:C5([IntakeFile:1];"SubHead2")
			vText1:=""
			vText2:=""
			Print form:C5([IntakeFile:1];"SubHead2")
		End for 
		vSubDetail:="Referral Source for this report: "+vReferral
		Print form:C5([IntakeFile:1];"SubHead1")
		vText1:="Referral Source"
		vText2:="Num."
		vText3:="Per."
		Print form:C5([IntakeFile:1];"SubHead2")
		For ($i;1;Size of array:C274(aRefBy))
			v1:=aRefBy{$i}
			v2:=aRefByNum{$i}
			v3:=aRefByPer{$i}
			Print form:C5([IntakeFile:1];"RptNumDetail")
		End for 
		PAGE BREAK:C6
	Else 
		ALERT:C41("There are no records matching your description")
	End if 
End while 