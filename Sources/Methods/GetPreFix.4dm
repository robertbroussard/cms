//%attributes = {"publishedWeb":true}
  //G-Proc: GetPreFix
C_TEXT:C284($Year)
C_TEXT:C284($0)
$Year:=String:C10(Year of:C25(Current date:C33))
  //$0:=Substring($Year;3;2)
$0:=$Year  // Now  use 4 digit year