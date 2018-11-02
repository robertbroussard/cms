  //Script: bAddAct; This script will add a record for the [MAF] file.
FORM SET INPUT:C55([MedActFile:10];"Input_Act")
CREATE RECORD:C68([MedActFile:10])
[MedActFile:10]mafKey:1:=[MediatorFile:9]MKey:14
SAVE RECORD:C53([MedActFile:10])
MODIFY RECORD:C57([MedActFile:10];*)
If (OK#1)
	DELETE RECORD:C58([MedActFile:10])
End if 
RELATE MANY:C262([MediatorFile:9]MKey:14)
ORDER BY:C49([MedActFile:10]ActDate:5;>)