//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): robert
  // Date and time: 11/09/18, 16:19:20
  // ----------------------------------------------------
  // Method: Util_Build_Notes
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------


Case of 
	: (True:C214)  //v17.b10, started dev 11/9/18.
		  //CTGetHot, method disable. Was called from menu that was deleted.
		  //CtShowHold, method disable. Was called from menu that was deleted.
		  //PrintDailyLtr, method disable. Was called from menu that was deleted.
		  //ShowAtty, method disable. Was called from menu that was deleted.
		  //Disabled but not deleted form: ShowAttyDialog
	: (True:C214)  //v17.b11, 12/8/18. 12/12/18.
		  //Compatibility settings removed (v17 defaults.
		  //Enabled SDI mode Windows.
		  //Methods saved in Unicode mode, did not compile at first.
		  //SR_GetPending syntax fix.
		  //added buttons to intake listing
		  //changed buttons to Light Grey
		  //added Add Intake code to listing form
		  //added intake listing shortcuts
		  //query by example form redesign, added hot field.
		  //ShowHolds menu deleted...
		  //GetHot menu deleted...
		  //Reschedule Reschedule case menu deleted, can edit from intake now.
		  //[DocketFile]DFInput. Updated buttons to LG.
		  //EnterDocResults, enter docket results menu deleted, edit via IintakeForm double-click.
	: (True:C214)  //v17.b12, 12/19/18.
		  //disabled required Intake Location and ID field values.
		  //Query by example checkbox fields having 3 states under investigation.
		  //custom zip code display code added to intake input, formats 5 and 9 digit codes.
		  //Unicode MyDot Update now uses hex 2022 to get the bullet for letters and footers
		  //created new custom Intake Print report, two pages carefully merged to one.
		  //CT/PD field renamed to CauseNum as well as the labels renamed to "Cause No".
		  //Program Report Fix, was printing all pipe characters (undefined stylesheet).
		  //Program Report dialog enahncement, optimized the tab order.
		  //fixed litigation summary worksheets various forms 
		  //added print dialog call to litigation worksheet reports. CtPrtLitigate, CtPrtArbitrate, CtPrtModerate.
		  //extensive subrecord code rewrite on method: CourtForms.
		
		
		
		
End case 
