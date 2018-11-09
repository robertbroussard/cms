//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): robert
  // Date and time: 11/08/18, 13:36:21
  // ----------------------------------------------------
  // Method: m_quit_4d
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

CONFIRM:C162("Are you sure that you want to quit?")
If (OK=1)
	QUIT 4D:C291
End if 