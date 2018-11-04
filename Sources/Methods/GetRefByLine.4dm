//%attributes = {"publishedWeb":true}
  //G-Proc:GetRefByLine;
C_LONGINT:C283($0)
Case of 
	: (([IntakeFile:1]RefBy:16="ADA@") | ([IntakeFile:1]RefBy:16="DA@"))
		$0:=2
	: (([IntakeFile:1]RefBy:16="AG@") | ([IntakeFile:1]RefBy:16="Attorney General"))
		$0:=15
	: ([IntakeFile:1]RefBy:16="BBB")
		$0:=18
	: (([IntakeFile:1]RefBy:16="CFC") | ([IntakeFile:1]RefBy:16="Ripley House"))
		$0:=8
	: ([IntakeFile:1]RefBy:16="Neighborhood@")
		$0:=8
	: (([IntakeFile:1]RefBy:16="County Clerk") | ([IntakeFile:1]RefBy:16="CP@"))
		$0:=15
	: ([IntakeFile:1]RefBy:16="@Co Crim")
		$0:=5
	: ((Character code:C91([IntakeFile:1]RefBy:16)>=48) & (Character code:C91([IntakeFile:1]RefBy:16)<=57))
		$0:=6
	: ([IntakeFile:1]RefBy:16="DRO")
		$0:=16
	: (([IntakeFile:1]RefBy:16="Family") | ([IntakeFile:1]RefBy:16="Friend"))
		$0:=13
	: ([IntakeFile:1]RefBy:16="GCLF")
		$0:=11
	: (([IntakeFile:1]RefBy:16="HCJPD@") | ([IntakeFile:1]RefBy:16="HHA"))
		$0:=15
	: (([IntakeFile:1]RefBy:16="Houston Housing Auth@") | ([IntakeFile:1]RefBy:16="Juv@"))
		$0:=15
	: ([IntakeFile:1]RefBy:16="JP@")
		$0:=3
	: (([IntakeFile:1]RefBy:16="@Legal Line") | ([IntakeFile:1]RefBy:16="Media"))
		$0:=14
	: ([IntakeFile:1]RefBy:16="@Mayor@")
		$0:=15
	: ([IntakeFile:1]RefBy:16="Previous@")
		$0:=13
	: ([IntakeFile:1]RefBy:16="Private Attorney")
		$0:=10
	: ([IntakeFile:1]RefBy:16="Self")
		$0:=13
	: ([IntakeFile:1]RefBy:16="TEC")
		$0:=15
	: (([IntakeFile:1]RefBy:16="CCL@") | ([IntakeFile:1]RefBy:16="Co Civ@"))
		$0:=5
	: ([IntakeFile:1]RefBy:16="Prob@")
		$0:=6
	: ([IntakeFile:1]RefBy:16="Constable@")
		$0:=17
	: (([IntakeFile:1]RefBy:16="@PD@") | ([IntakeFile:1]RefBy:16="@SD@") | ([IntakeFile:1]RefBy:16="@Sheriff@"))
		$0:=17
	: (([IntakeFile:1]RefBy:16="TDPS") | ([IntakeFile:1]RefBy:16="DPS"))
		$0:=17
	Else 
		$0:=19
End case 


