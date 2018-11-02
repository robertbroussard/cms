//%attributes = {}
  //SR_GetFiledCases

  //create an array of list names...
  //Create arrays for each list
  //combine the contents of each list array to a master array
  //use the master array to define a selection of Cases.

$Filed:=$1

ARRAY TEXT:C222($aLists;8)
ARRAY TEXT:C222($aCourtRef;0)

$aLists{1}:="Criminal District"
$aLists{2}:="Civil District"
$aLists{3}:="County Civil"
$aLists{4}:="County Criminal"
$aLists{5}:="Municipal, Houston"
$aLists{6}:="Justices of the Peace"
$aLists{7}:="Apellate State"
$aLists{8}:="Appellate Federal"

$size:=Size of array:C274($aLists)

For ($i;1;$size)
	LIST TO ARRAY:C288($aLists{$i};$aTempList)
	$TempSize:=Size of array:C274($aTempList)
	For ($j;1;$TempSize)
		$Elem:=Size of array:C274($aCourtRef)+1
		INSERT IN ARRAY:C227($aCourtRef;$Elem)
		$aCourtRef{$Elem}:=$aTempList{$j}
	End for 
End for 

  //Special Exception:
  //ADD-> `QUERY([IntakeFile];[IntakeFile]RefBy="Muni, Pasadena")
$Elem:=Size of array:C274($aCourtRef)+1
INSERT IN ARRAY:C227($aCourtRef;$Elem)
$aCourtRef{$Elem}:="Muni, Pasadena"

$size:=Size of array:C274($aCourtRef)
QUERY WITH ARRAY:C644([IntakeFile:1]RefBy:16;$aCourtRef)
CREATE SET:C116([IntakeFile:1];"FiledCases")  //now, the set should contain ALL court-related cases...

If (Not:C34($Filed))  //If NOT Filed get reverse selection.
	ALL RECORDS:C47([IntakeFile:1])
	CREATE SET:C116([IntakeFile:1];"AllRecs")
	DIFFERENCE:C122("AllRecs";"FiledCases";"UnFiledCases")  //now we have the cases NOT filed...
End if 
