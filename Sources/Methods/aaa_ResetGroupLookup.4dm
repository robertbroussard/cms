//%attributes = {}
  // ----------------------------------------------------

  // User name (OS): robert

  // Date and time: 12/13/04, 00:31:59

  // ----------------------------------------------------

  // Method: aaa_ResetGroupLookup

  // Description

  // 

  //

  // Parameters

  // ----------------------------------------------------


READ WRITE:C146([GroupLookup:17])
READ WRITE:C146([Groups:13])
ALL RECORDS:C47([GroupLookup:17])
DELETE SELECTION:C66([GroupLookup:17])
FLUSH CACHE:C297
REDUCE SELECTION:C351([GroupLookup:17];0)

ALL RECORDS:C47([Groups:13])
DISTINCT VALUES:C339([Groups:13]Group:2;$aGroup)
ARRAY TO SELECTION:C261($aGroup;[GroupLookup:17]GL_Group:1)


