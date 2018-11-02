  //Script:SpanishOnly: This script will ensure that the field SpanishOnly and 
  //AllowSpanish will be set properly so that the site constraints for a 
  //site will be correct.
If ([SiteConstraints:7]AllowSpanish:13=False:C215) & ([SiteConstraints:7]SpanishOnly:14=True:C214)
	ALERT:C41("You have set Spanish Only or Allow Spanish wrong. Please check your entry.")
End if 