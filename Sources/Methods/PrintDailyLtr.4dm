//%attributes = {"publishedWeb":true}
  //  //G-Procedure: PrintDailyLtr
  //C_LONGINT($i;$Temp;$Print;$PrintLoop;$OK1;$OK2)
  //C_TEXT($Dis1;$Dis2)
  //C_TEXT($CR)
  //$OK1:=1
  //$OK2:=1
  //$PrintLoop:=0
  //$Temp:=0
  //$Print:=0
  //ALL RECORDS([DailyLtrFile])
  //If (Records in selection([DailyLtrFile])>0)
  //vPInitials:=""
  //While (vPInitials="")
  //vPInitials:=Uppercase(Request("Enter Initials(2 only): "))
  //If (OK#1)
  //CONFIRM("Stop Printing?")
  //If (OK=1)
  //vPInitials:="XX"
  //$PrintLoop:=0
  //End if 
  //Else 
  //$PrintLoop:=1
  //End if 
  //End while 
  //While ($PrintLoop=1)
  //$PrintLoop:=0
  //CREATE SET([DailyLtrFile];"DLFSet")
  //CREATE EMPTY SET([DailyLtrFile];"PrintSet")
  //CREATE EMPTY SET([DailyLtrFile];"ErrorSet")
  //CREATE EMPTY SET([DailyLtrFile];"EnvelopeSet")
  //CREATE EMPTY SET([DailyLtrFile];"LSOSet")
  //FIRST RECORD([DailyLtrFile])
  //For ($i;1;Records in selection([DailyLtrFile]))
  //If (CheckRecord =True)
  //ADD TO SET([DailyLtrFile];"PrintSet")
  //If ([DailyLtrFile]PrintEnv=True)
  //ADD TO SET([DailyLtrFile];"EnvelopeSet")
  //End if 
  //If ([DailyLtrFile]LtrType="JUMP LSO@")
  //ADD TO SET([DailyLtrFile];"LSOSet")
  //End if 
  //Else 
  //DoError (4;[DailyLtrFile]Initials;vPInitials)
  //ADD TO SET([DailyLtrFile];"ErrorSet")
  //End if 
  //NEXT RECORD([DailyLtrFile])
  //End for 
  //DIFFERENCE("PrintSet";"LSOSet";"PrintSet")
  //$Print:=Records in set("PrintSet")+Records in set("LSOSet")
  //If ($Print>0)
  //$Print:=Records in set("PrintSet")+Records in set("LSOSet")
  //ALERT("Preparing to print "+String($Print)+" letters.")
  //If (Records in set("LSOSet")>0)
  //USE SET("LSOSet")
  //ORDER BY([DailyLtrFile];[DailyLtrFile]DLFCaseNo;>)
  //ACCUMULATE($Temp)
  //BREAK LEVEL(1;0)
  //FORM SET OUTPUT([DailyLtrFile];"LSO Letters")
  //PAGE SETUP([DailyLtrFile];"LSO Letters")
  //PRINT SELECTION([DailyLtrFile];*)
  //If (OK#1)
  //$OK2:=0
  //End if 
  //End if 
  //USE SET("PrintSet")
  //ORDER BY([DailyLtrFile];[DailyLtrFile]DLFCaseNo;>)
  //ACCUMULATE($Temp)
  //BREAK LEVEL(1;0)
  //FORM SET OUTPUT([DailyLtrFile];"DFLTestLtr")
  //PAGE SETUP([DailyLtrFile];"DFLTestLtr")
  //PRINT SELECTION([DailyLtrFile];*)
  //If (OK#1)
  //$OK1:=0
  //End if 
  //USE SET("EnvelopeSet")
  //ORDER BY([DailyLtrFile];[DailyLtrFile]DLFCaseNo;>)
  //$CR:=Char(13)
  //$Dis1:=("Preparing to print "+String(Records in set("EnvelopeSet"))+" envelopes.")
  //$Dis2:=$CR+"Place envelopes into the printer."
  //ALERT($Dis1+$Dis2)
  //PAGE SETUP([DailyLtrFile];"Envelopes")
  //If (vPrinter360="Y")  // SET IN STARTUP PROC IF USING LASERWRITER 360 - CENTER ENVELOPE ALIGN.
  //FORM SET OUTPUT([DailyLtrFile];"EnvelopeCenter")
  //PRINT SELECTION([DailyLtrFile])
  //Else 
  //FORM SET OUTPUT([DailyLtrFile];"Envelopes")
  //PRINT SELECTION([DailyLtrFile])
  //End if 
  //UNION("PrintSet";"LSOSet";"PrintSet")
  //USE SET("PrintSet")
  //Else 
  //$OK1:=0
  //End if 
  //If ((OK=1) & ($OK1=1)) & ($OK2=1)
  //For ($i;1;Records in selection([DailyLtrFile]))
  //DoRptEntry ("B";vPInitials)
  //NEXT RECORD([DailyLtrFile])
  //End for 
  //PDLNotes (vPInitials)
  //ALERT("Please check that all the letters and envelopes printed properly.")
  //CONFIRM("Are you prepared to delete all of the records in the daily letter file?")
  //If (OK=1)
  //UNION("PrintSet";"ErrorSet";"PrintSet")
  //USE SET("PrintSet")
  //DELETE SELECTION([DailyLtrFile])
  //End if 
  //Else 
  //For ($i;1;Records in selection([DailyLtrFile]))
  //DoError (6;vPInitials;vPInitials)
  //NEXT RECORD([DailyLtrFile])
  //End for 
  //ALERT("There was a problem printing, check the correspondence report for reason.")
  //End if 
  //DCR_Totals 
  //FORM SET OUTPUT([LtrRptFile];"LRFDailyRpt")
  //PAGE SETUP([LtrRptFile];"LRFDailyRpt")
  //ORDER BY([LtrRptFile]TimePrinted;[LtrRptFile]LtrCaseNo;>)
  //ACCUMULATE(x)
  //BREAK LEVEL(0)
  //PRINT SELECTION([LtrRptFile];*)
  //DELETE SELECTION([LtrRptFile])
  //End while 
  //Else 
  //ALERT("There are no letters to print.")
  //End if 
  //CLEAR SET("PrintSet")
  //CLEAR SET("ErrorSet")
  //CLEAR SET("Envelopes")
  //CLEAR SET("LSOSet")
  //UNLOAD RECORD([IntakeFile])