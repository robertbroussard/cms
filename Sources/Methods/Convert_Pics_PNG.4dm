//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): robert
  // Date and time: 11/03/18, 23:12:08
  // ----------------------------------------------------
  // Method: Convert_Pics_PNG
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------
  //This method converts all pictures in the library to PNG format and then writes them back to the library

C_TEXT:C284($pictureName_t)
C_PICTURE:C286($picture_c)
C_LONGINT:C283($i;$pictureID_l)
ARRAY LONGINT:C221($pictureID_al;0)
ARRAY TEXT:C222($pictureName_at;0)

PICTURE LIBRARY LIST:C564($pictureID_al;$pictureName_at)

For ($i;1;Size of array:C274($pictureID_al))
	$pictureID_l:=$pictureID_al{$i}
	$pictureName_t:=$pictureName_at{$i}
	GET PICTURE FROM LIBRARY:C565($pictureID_l;$picture_c)
	
	  // convert the picture
	CONVERT PICTURE:C1002($picture_c;".png")
	
	  // make all white pixels transparent
	TRANSFORM PICTURE:C988($picture_c;Transparency:K61:11;0x00FFFFFF)
	
	  // write back to library
	SET PICTURE TO LIBRARY:C566($picture_c;$pictureID_l;$pictureName_t)
End for 
