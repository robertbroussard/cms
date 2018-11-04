//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): robert
  // Date and time: 11/03/18, 18:08:02
  // ----------------------------------------------------
  // Method: Set_ZipCode_Display
  // Description
  // 
  //
  // Parameters:  $1 = pointer
  // ----------------------------------------------------

C_POINTER:C301($1;$ZipCode)

$ZipCode:=$1

Case of 
	: (Length:C16($ZipCode->)=5)
		OBJECT SET FORMAT:C236($ZipCode->;"|Zip_Display_Standard")
	: (Length:C16($ZipCode->)=9)
		OBJECT SET FORMAT:C236($ZipCode->;"|Zip_Display_Extended")
	Else 
		OBJECT SET FORMAT:C236($ZipCode->;"")
End case 