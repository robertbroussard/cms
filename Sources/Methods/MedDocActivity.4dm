//%attributes = {"publishedWeb":true}
  //G-Procedure: MedDocAvtivity; This procedure will add mediators to the 
  //case they mediated.
  //
_O_C_STRING:C293(35;$mafTempKey)
$mafTempKey:=""
$pgm:=[DocketFile:6]DFCaseNo:4[[9]]  // PROGRAM LETTER IS IN POS. 9 OF CASE NO.
If (($pgm="A") | ($pgm="L") | ($pgm="M"))
	$bypass:=1
Else 
	$bypass:=0
End if 
If (([DocketFile:6]HResults:11#"") | (([DocketFile:6]HResults:11="") & ($bypass=1)))
	Case of 
		: ([DocketFile:6]HResults:11="CON")
			ALERT:C41("This case is listed as conciliated. You can't add a Mediator.")
		: ([DocketFile:6]HResults:11="DCL")
			ALERT:C41("This case is listed as declined. You can't add a Mediator.")
		: ([DocketFile:6]HResults:11="NS")
			ALERT:C41("This case is listed as a no show. You can't add a Mediator.")
		: ([DocketFile:6]HResults:11="R/S")
			ALERT:C41("This case has been rescheduled. You can't add a Mediator.")
		Else 
			If (([DocketFile:6]HLenght:12#0) | (([DocketFile:6]HLenght:12=0) & ($bypass=1)))
				FORM SET INPUT:C55([MedActFile:10];"MAFDocInput")
				CREATE RECORD:C68([MedActFile:10])
				[MedActFile:10]mafCaseNo:3:=[DocketFile:6]DFCaseNo:4
				[MedActFile:10]ActDate:5:=[DocketFile:6]DocketDate:2
				[MedActFile:10]AmtOfTime:6:=[DocketFile:6]HLenght:12
				[MedActFile:10]mafDocKey:2:=[DocketFile:6]DocKey:6
				$mafTempKey:=[DocketFile:6]DocKey:6
				[MedActFile:10]ActResults:8:=[DocketFile:6]HResults:11
				SAVE RECORD:C53([MedActFile:10])
				MODIFY RECORD:C57([MedActFile:10];*)
				If (OK#1)
					DELETE RECORD:C58([MedActFile:10])
				End if 
			Else 
				ALERT:C41("You must enter the hearing length before continuing.")
			End if 
	End case 
Else 
	ALERT:C41("You must enter the hearing results before you can continue.")
End if 
RELATE MANY:C262([DocketFile:6]DocKey:6)