  //Script: bViewAct; This script will search the MAF for all the activity of the
  //Mediator.
  //
RELATE MANY:C262([MediatorFile:9]MKey:14)
ORDER BY:C49([MedActFile:10]ActDate:5;>)
FORM NEXT PAGE:C248
SET WINDOW TITLE:C213("Mediator Activity Screen")