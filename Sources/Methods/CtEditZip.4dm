//%attributes = {"publishedWeb":true}
  //
  //Edit zip codes to delete spaces & underscores
  //$1 is pointer to field being edited
  //
vZip:=$1->
vZip:=Replace string:C233(vZip;Char:C90(95);"")  //DELETE UNDERSCORE IN FORMAT   
vZip:=Replace string:C233(vZip;" ";"")  //REMOVE SPACES FOR HONEST LENGTH   
If (Length:C16(vZip)>6)
	vZip:=Insert string:C231(vZip;"-";6)  // FORMAT EXTENDED ZIPCODES
Else 
	vZip:=Replace string:C233(vZip;"-";"")  //DELETE DASH IN FORMAT    
End if 