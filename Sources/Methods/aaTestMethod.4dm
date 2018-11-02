//%attributes = {"publishedWeb":true}
  //ALL RECORDS([IntakeFile])
  //DISTINCT VALUES([IntakeFile]CaseStatus;atest)
  //TRACE
  //TRACE

  //Open window

<>gFooter:="Harris County Annex 21 "+Char:C90(165)+" 49 San Jacinto, Suite 220 "+Char:C90(165)+" Houston, Texas 77002 "+Char:C90(165)+" Tel (713) 755-8274 "+Char:C90(165)+" Fax (713) 755-8885 "+Char:C90(165)+" www.drchouston.org"+Char:C90(13)+"A Nonprofit Corporation Sponsored by the Houston Bar Association"


DIALOG:C40([DailyLtrFile:14];"DispoOther_Out")

TRACE:C157

CANCEL:C270
