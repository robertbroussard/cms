//%attributes = {"publishedWeb":true}
  //ALL RECORDS([IntakeFile])
  //DISTINCT VALUES([IntakeFile]CaseStatus;atest)
  //TRACE
  //TRACE

  //Open window

  //<>gFooter:="Harris County Annex 21 "+Char(165)+" 49 San Jacinto, Suite 220 "+Char(165)+" Houston, Texas 77002 "+Char(165)+" Tel (713) 755-8274 "+Char(165)+" Fax (713) 755-8885 "+Char(165)+" www.drchouston.org"+Char(13)+"A Nonprofit Corporation Sponsored by the Houston Bar Association"


DIALOG:C40([DailyLtrFile:14];"DispoOther_Out")

TRACE:C157

CANCEL:C270
