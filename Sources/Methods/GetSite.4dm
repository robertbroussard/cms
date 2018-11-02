//%attributes = {"publishedWeb":true}
  //G-Procedure: GetSite;  called by SiteReport on Menu bar
_O_C_STRING:C293(15;$1)
_O_C_STRING:C293(2;$0)
Case of 
	: ($1="DRC")
		$0:="01"
	: ($1="DA")
		$0:="02"
	: ($1="City Prosecutor")
		$0:="03"
	: ($1="Pasadena")
		$0:="04"
	: ($1="Ripley")
		$0:="05"
	: ($1="CFC")
		$0:="06"
	: ($1="JP Green")
		$0:="09"
	: ($1="JP Patronella")
		$0:="10"
	: ($1="JP Risner")
		$0:="11"
	: ($1="JP Rodriguez")
		$0:="12"
	: ($1="JP Fury")
		$0:="13"
	: ($1="HCJPD")
		$0:="14"
	: ($1="JP Lawrence")
		$0:="15"
	: ($1="JP Gorczynski")
		$0:="16"
	: ($1="JP Polumbo")
		$0:="17"
	: ($1="Magnolia")
		$0:="18"
	: ($1="JP Vara")
		$0:="19"
	: ($1="JP Bell")  //ADDED 10/3/94    
		$0:="20"
	: ($1="JP Parrott")
		$0:="21"
	: ($1="JP Yeoman")
		$0:="22"
	: ($1="Pasadena PD - Juvenile")
		$0:="23"
	: ($1="Incarnation")
		$0:="24"
	: ($1="Katy Christ. M.")
		$0:="25"
	: ($1="Galena Park")
		$0:="26"
	: ($1="Tomball PD")
		$0:="27"
	Else 
		$0:="@"
End case 