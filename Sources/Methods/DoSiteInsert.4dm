//%attributes = {"publishedWeb":true}
  //G-Procedure: DoSiteInsert 
_O_C_INTEGER:C282($Insert)
$Insert:=Size of array:C274(aSite)+1
INSERT IN ARRAY:C227(aSite;$Insert)
INSERT IN ARRAY:C227(aTotals;$Insert)
aSite{$Insert}:=[LocationFile:2]LTLocName:2