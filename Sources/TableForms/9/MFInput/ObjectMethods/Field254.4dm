  // Object Method in Form [MediatorFile];"MFInput" 
  // to flag a record as inactive
  //
C_LONGINT:C283(vForeground;vBackground)
  //
RELATE MANY:C262([MediatorFile:9]MKey:14)
If ([MediatorFile:9]MFInact:15=False:C215)
	vMFNotice:="    active"
	vForeground:=7
	vBackground:=0
	OBJECT SET COLOR:C271(vMFNotice;-(vForeground+(256*vBackground)))
End if 
If ([MediatorFile:9]MFInact:15=True:C214)
	vMFNotice:="    I N A C T I V E"
	vForeground:=2
	vBackground:=1
	OBJECT SET COLOR:C271(vMFNotice;-(vForeground+(256*vBackground)))
End if 
If (Records in selection:C76([Groups:13])>0)
	SELECTION TO ARRAY:C260([Groups:13]Group:2;aKeep)
	$Keep:=Find in array:C230(aKeep;"KEEP ACTIVE")
	If ($Keep#-1)  // IS A KEEP-ACTIVE GROUP FOR THIS MEDIATOR
		If ([MediatorFile:9]MFInact:15=True:C214)
			[MediatorFile:9]MFInact:15:=False:C215
			If (vMFNotice="Keep Active")
				vMFNotice:="  Active"  // MAKE 'ACTIVE' THE 2ND TIME THRU
				vForeground:=7
				vBackground:=0
			Else 
				vMFNotice:="Keep Active"
				vForeground:=2
				vBackground:=0
			End if 
			OBJECT SET COLOR:C271(vMFNotice;-(vForeground+(256*vBackground)))
		End if 
	End if 
	NEXT RECORD:C51([Groups:13])
End if 