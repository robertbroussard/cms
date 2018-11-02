  // Delete the default underscore so it will not be saved in the file and printed
  //
If (_O_During:C30)
	[MediatorFile:9]FaxNumber:16:=Replace string:C233([MediatorFile:9]FaxNumber:16;"_";"")
End if 