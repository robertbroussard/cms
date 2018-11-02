//%attributes = {"publishedWeb":true}
  //G-Procedure:CheckProgDay2; This procedure is called from Get ReqDate.

  //C_INTEGER($Day)

  //vDayOK:=False

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

  //End case 


vDayOK:=True:C214  //all days are okay--force True. 12/12/04

$0:=$1