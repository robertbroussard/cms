//%attributes = {"publishedWeb":true}
  //G-Proc: BuildLineArrays;
_O_C_INTEGER:C282($i)
_O_ARRAY STRING:C218(40;aLineName;0)  //this probably should be built when needed?
INSERT IN ARRAY:C227(aLineName;1;38)
For ($i;1;38)
	Case of 
		: ($i=1)
			aLineName{$i}:="I."
		: ($i=2)
			aLineName{$i}:="II A."
		: ($i=3)
			aLineName{$i}:="II B."
		: ($i=4)
			aLineName{$i}:="II C."
		: ($i=5)
			aLineName{$i}:="II D."
		: ($i=6)
			aLineName{$i}:="II E."
		: ($i=7)
			aLineName{$i}:="II F."
		: ($i=8)
			aLineName{$i}:="II G."
		: ($i=9)
			aLineName{$i}:="II H."
		: ($i=10)
			aLineName{$i}:="II I."
		: ($i=11)
			aLineName{$i}:="II J."
		: ($i=12)
			aLineName{$i}:="II K."
		: ($i=13)
			aLineName{$i}:="II L."
		: ($i=14)
			aLineName{$i}:="II M."
		: ($i=15)
			aLineName{$i}:="II N."
		: ($i=16)
			aLineName{$i}:="II O."
		: ($i=17)
			aLineName{$i}:="II P."
		: ($i=18)
			aLineName{$i}:="II Q."
		: ($i=19)
			aLineName{$i}:="II R."
		: ($i=20)
			aLineName{$i}:="II S."
		: ($i=21)
			aLineName{$i}:="(II.) Total - Received"
		: ($i=22)
			aLineName{$i}:="III A 1."
		: ($i=23)
			aLineName{$i}:="III A 2."
		: ($i=24)
			aLineName{$i}:="III A 3."
		: ($i=25)
			aLineName{$i}:="III A 4."
		: ($i=26)
			aLineName{$i}:="(III A.) Subtotal - Resolved Prior"
		: ($i=27)
			aLineName{$i}:="III B 1."
		: ($i=28)
			aLineName{$i}:="III B 2."
		: ($i=29)
			aLineName{$i}:="III B 3."
		: ($i=30)
			aLineName{$i}:="(III B.) Subtotal - Hearing Held"
		: ($i=31)
			aLineName{$i}:="III C 1."
		: ($i=32)
			aLineName{$i}:="III C 2."
		: ($i=33)
			aLineName{$i}:="III C 3."
		: ($i=34)
			aLineName{$i}:="III C4."
		: ($i=35)
			aLineName{$i}:="III C 5."
		: ($i=36)
			aLineName{$i}:="(III C.) Subtotal - No Hearing Held"
		: ($i=37)
			aLineName{$i}:="(III.) Total Closed"
		: ($i=38)
			aLineName{$i}:="IV. Cases Pending End of Month"
	End case 
End for 