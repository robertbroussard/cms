//%attributes = {"publishedWeb":true}
  //G-Procedure: DoSiteInsert 
C_LONGINT:C283($Insert)
$Insert:=Size of array:C274(aSite)+1
INSERT IN ARRAY:C227(aSite;$Insert)
INSERT IN ARRAY:C227(aTotals;$Insert)
aSite{$Insert}:=[LocationFile:2]LTLocName:2