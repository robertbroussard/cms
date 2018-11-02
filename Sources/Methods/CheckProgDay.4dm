//%attributes = {"publishedWeb":true}
  //G-Procedure:CheckProgDay

  //Mod 12/16/04...  getting rid of the DAY CONSTRAINTS

  //C_INTEGER($Day)



vDayOK:=True:C214
$0:=$1

  //vDayOK:=False

  //While (vDayOK=False)

  //$Day:=Day number($1)

  //Case of 

  //: ($Day=2) & ([SiteConstraints]Monday=True)

  //vDayOK:=True

  //: ($Day=3) & ([SiteConstraints]Tuesday=True)

  //vDayOK:=True

  //: ($Day=4) & ([SiteConstraints]Wednesday=True)

  //vDayOK:=True

  //: ($Day=5) & ([SiteConstraints]Thursday=True)

  //vDayOK:=True

  //: ($Day=6) & ([SiteConstraints]Friday=True)

  //vDayOK:=True

  //Else 

  //$1:=$1+1

  //End case 

  //End while 

  //$0:=$1