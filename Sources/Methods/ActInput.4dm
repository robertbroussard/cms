//%attributes = {"publishedWeb":true}
  //G-Proc: ActInput; This proc is called from the menu item
  // "Input Activity". 
  //
FORM SET INPUT:C55([MedActFile:10];"Input_Act")
FORM SET OUTPUT:C54([MedActFile:10];"ActReport")
OBJECT SET ENTERABLE:C238([MedActFile:10]Role_Activity:4;True:C214)
OBJECT SET ENTERABLE:C238([MedActFile:10]ActDate:5;True:C214)
OBJECT SET ENTERABLE:C238([MedActFile:10]AmtOfTime:6;True:C214)
OBJECT SET ENTERABLE:C238([MedActFile:10]mafKey:1;True:C214)
Repeat 
	ADD RECORD:C56([MedActFile:10];*)
	CONFIRM:C162("Add another record?")
Until (OK#1)