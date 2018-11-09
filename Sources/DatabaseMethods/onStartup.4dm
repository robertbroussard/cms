  //G-Procedure: StartUp

<>TestMode:=True:C214

CompilerTypes   // (P) TO SET TYPES OF VARIABLES IN DATABASE
C_TEXT:C284(vPrinter360)
SET WINDOW TITLE:C213("DRC Case Management System")
READ ONLY:C145([Constants:11])
READ ONLY:C145([LocationFile:2])
READ ONLY:C145([ISIDTable:3])
READ ONLY:C145([RelCodeFile:5])
READ ONLY:C145([DisputeFile:4])
vNewMed:=False:C215
vHBA:=False:C215
vSwitch:=0
vPrinter360:="Y"  //HP PRINTERS ARE CENTER FEED SO FORCE 'Y'

QUERY:C277([DailyLtrFile:14];[DailyLtrFile:14]PrintDate:23<Current date:C33)
DELETE SELECTION:C66([DailyLtrFile:14])

RunDBUpdate ("DocketSite_CampusUpdate")
RunDBUpdate ("DocketSite_CPSUpdate")
RunDBUpdate ("SiteConstraintsDataUpdate")
RunDBUpdate ("aaa_ResetGroupLookup")
RunDBUpdate ("Ref_DataUpdate")
RunDBUpdate ("Del_TimeSlotDups")

  //<>gFooter:="Harris County Annex 21 "+Ascii(165)+" test."
<>gFooter:="Harris County Annex 21 "+Char:C90(165)+" 49 San Jacinto, Suite 220 "+Char:C90(165)+" Houston, Texas 77002 "+Char:C90(165)+" Tel (713) 755-8274 "+Char:C90(165)+" Fax (713) 755-8885 "+Char:C90(165)+" www.drchouston.org"+Char:C90(13)+"A Nonprofit Corporation Sponsored by the Houston Bar Association"
