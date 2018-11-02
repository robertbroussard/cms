//%attributes = {"publishedWeb":true}
RELATE ONE:C42([DailyLtrFile:14]LtrType:2;[LetterFile:15]LFLtrName:1)
If ([DailyLtrFile:14]Spanish:24=False:C215)
	$TempText:=[LetterFile:15]Letter Text:2
	$TempText:=Replace string:C233($TempText;"<OPName>";[DailyLtrFile:14]OPName:11)
	$TempText:=Replace string:C233($TempText;"<Dispute>";[DailyLtrFile:14]Dispute:7)
	$TempText:=Replace string:C233($TempText;"<Scheduled>";[DailyLtrFile:14]Scheduled:8)
	$TempText:=Replace string:C233($TempText;"<SiteAddress>";[DailyLtrFile:14]SiteAddress:9)
	$TempText:=Replace string:C233($TempText;"<DocDate>";String:C10([DailyLtrFile:14]DocDate:10;3))
	$TempText:=Replace string:C233($TempText;"<SDocDate>";[DailyLtrFile:14]SDate:22)
	$TempText:=Replace string:C233($TempText;"<TimeSlot>";[DailyLtrFile:14]TimeSlot:19)
	$TempText:=Replace string:C233($TempText;"<Style>";[DailyLtrFile:14]Style:12)
	$TempText:=Replace string:C233($TempText;"<Referral Source>";[DailyLtrFile:14]RefSource:27)
	$TempText:=Replace string:C233($TempText;"<MyDot>";Char:C90(165))
	[DailyLtrFile:14]DLFText:18:=$TempText
Else 
	$TempText:=[LetterFile:15]Letter Text:2
	$TempText:=Replace string:C233($TempText;"<OPName>";[DailyLtrFile:14]OPName:11)
	$TempText:=Replace string:C233($TempText;"<Dispute>";[DailyLtrFile:14]Dispute:7)
	$TempText:=Replace string:C233($TempText;"<Scheduled>";[DailyLtrFile:14]Scheduled:8)
	$TempText:=Replace string:C233($TempText;"<SiteAddress>";[DailyLtrFile:14]SiteAddress:9)
	$TempText:=Replace string:C233($TempText;"<DocDate>";String:C10([DailyLtrFile:14]DocDate:10;3))
	$TempText:=Replace string:C233($TempText;"<SDocDate>";[DailyLtrFile:14]SDate:22)
	$TempText:=Replace string:C233($TempText;"<TimeSlot>";[DailyLtrFile:14]TimeSlot:19)
	$TempText:=Replace string:C233($TempText;"<Style>";[DailyLtrFile:14]Style:12)
	$TempText:=Replace string:C233($TempText;"<Referral Source>";[DailyLtrFile:14]RefSource:27)
	$TempText:=Replace string:C233($TempText;"<MyDot>";Char:C90(165))
	[DailyLtrFile:14]DLFText:18:=$TempText
End if 