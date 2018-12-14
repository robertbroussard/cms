//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): robert
  // Date and time: 12/13/18, 15:10:13
  // ----------------------------------------------------
  // Method: search_intake
  // Description
  // Replaces ModIntake
  // ----------------------------------------------------

$WinRef:=Open form window:C675([IntakeFile:1];"IntSearchLit";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
FORM SET INPUT:C55([IntakeFile:1];"IntSearchLit")
QUERY BY EXAMPLE:C292([IntakeFile:1])
FORM SET INPUT:C55([IntakeFile:1];"Intake_Input")
