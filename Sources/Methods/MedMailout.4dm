//%attributes = {"publishedWeb":true}
  // MedMailout - Select Mediators by Group and print envelopes
  // or labels for them.  Can display & modify selection before printing

  //Modified by Robert J. Broussard <robert@usersoft.com>
  //UserSoft Technology <www.usersoft.com>
  //Modified: 9/3/02 & 11/18/04

_O_C_INTEGER:C282($i;vEnvelope;vLabel;vModSw;$while;vDialog;vSavSwEnv;vSavSwLbl;vAllMediators;$InactiveMediators;vSavSwMed)
_O_C_STRING:C293(75;$PrevName)  //Mod RJB 9/3/02
_O_C_STRING:C293(20;vGroup1;vGroup2;vGroup3)  //Mod RJB 9/3/02
C_TEXT:C284($InactiveMediatorText)
SET WINDOW TITLE:C213("DRC: Mediator Mail Out")
vText1:=""
vSavSwEnv:=1
vSavSwLbl:=0
vSavSwMed:=0
vLabel:=0
vGroup1:=""
vGroup2:=""
vGroup3:=""
CLEAR VARIABLE:C89(aGroup1)
CLEAR VARIABLE:C89(aGroup2)
CLEAR VARIABLE:C89(aGroup3)
$InactiveMediators:=0
  //
  // MAKE ARRAYS FOR SELECTING GROUPS FOR MAIL OUT
  //
  //Create GrouLUArrays via Distinct Vals of Group.

ALL RECORDS:C47([GroupLookup:17])
SELECTION TO ARRAY:C260([GroupLookup:17]GL_Group:1;aGroup1)
SORT ARRAY:C229(aGroup1;>)
COPY ARRAY:C226(aGroup1;aGroup2)
COPY ARRAY:C226(aGroup1;aGroup3)
vDialog:=1
vAllMediators:=0  //Default to unchecked    `RJB Add 10/14/11
DIALOG:C40([MediatorFile:9];"MedMailForm")  //DISPLAYS ARRAYS FOR GROUP SELECTION
vSavSwEnv:=vEnvelope
vSavSwLbl:=vLabel
vSavSwMed:=vAllMediators  //Saves Force All Mediators Checkbox state.
  //vSavModSw:=vModSw
  //
  // FIND ALL MEDIATORS IN SELECTED GROUPS & OMIT DUPLICATE NAMES
  // & BUILD MEDIATOR FILE (IN A SET) FOR ADDRESSES
  //
If (OK=1)
	QUERY:C277([Groups:13];[Groups:13]Group:2=vGroup1;*)
	QUERY:C277([Groups:13]; | ;[Groups:13]Group:2=vGroup2;*)
	QUERY:C277([Groups:13]; | ;[Groups:13]Group:2=vGroup3)
	QUERY SELECTION:C341([Groups:13];[Groups:13]Group:2#"NONE")
	QUERY SELECTION:C341([Groups:13];[Groups:13]Group:2#"")
	ORDER BY:C49([Groups:13];[Groups:13]GMKEY:1;>)
	FIRST RECORD:C50([Groups:13])
	$PrevName:=""
	CREATE EMPTY SET:C140([MediatorFile:9];"sMedSet")
	If (Records in selection:C76([Groups:13])>0)
		For ($i;1;Records in selection:C76([Groups:13]))
			If ($PrevName#[Groups:13]GMKEY:1)
				RELATE ONE:C42([Groups:13]GMKEY:1)
				If ([MediatorFile:9]MFInact:15=False:C215)  // NOT INACTIVE  `reactivated 11/30/09
					ADD TO SET:C119([MediatorFile:9];"sMedSet")
				Else   //consider inactive mediators, use if Checkbox was checked....
					If (vAllMediators=1)  //RJB Add 10/14/11
						ADD TO SET:C119([MediatorFile:9];"sMedSet")  //RJB Add 10/14/11
						$InactiveMediators:=$InactiveMediators+1
					End if   //RJB Add 10/14/11
				End if 
			End if 
			$PrevName:=[Groups:13]GMKEY:1
			  //End if 
			NEXT RECORD:C51([Groups:13])
		End for 
		  // 
		  // ALLOWS USER TO DISPLAY, EDIT, AND PRINT SELECTED RECORDS
		  //    
		USE SET:C118("sMedSet")
		ORDER BY:C49([MediatorFile:9];[MediatorFile:9]MKey:14;>)
		
		If ($InactiveMediators>0)  //RJB Add 10/14/11
			$InactiveMediatorText:=Char:C90(13)+"Including: "+String:C10($InactiveMediators)+" Inactive Mediators."  //RJB Add 10/14/11
		Else 
			$InactiveMediatorText:=""  //RJB Add 10/14/11
		End if 
		
		If (False:C215)
			FORM SET OUTPUT:C54([MediatorFile:9];"MedAddress")
			MODIFY SELECTION:C204([MediatorFile:9])
		End if 
		
		$while:=1
		While ($while=1)  // LOOP TO SHOW # RCDS IF CHOOSE DISPLAY
			$while:=0
			$RecInSel:=Records in selection:C76([MediatorFile:9])
			If (vEnvelope=1)
				vText1:="There are "+String:C10($RecInSel)+" ENVELOPES to be printed."+$InactiveMediatorText
			Else 
				vText1:="There are "+String:C10($RecInSel)+" LABELS or "+String:C10(Int:C8(($RecInSel/30)+1))+" PAGE(S) to be printed."+$InactiveMediatorText
			End if 
			vDialog:=2
			DIALOG:C40([MediatorFile:9];"MedMailForm")  // REUSE SAME DIALOG FORM
			If (OK=1)
				If (vModSw=1)
					vModSw:=0
					FORM SET OUTPUT:C54([MediatorFile:9];"MedAddress")
					MODIFY SELECTION:C204([MediatorFile:9])
					FIRST RECORD:C50([MediatorFile:9])
					If (Records in set:C195("userset")>0)  // RECORDS WERE SELECTED
						COPY SET:C600("userset";"sMedSet")
						USE SET:C118("sMedSet")
						$while:=1
					End if 
				End if 
			End if 
		End while 
		  //    
		  // PRINT ENVELOPES OR LABELS DEPENDING ON SELECTION ON DIALOG   
		  //
		If (OK=1)
			If (vEnvelope=1)
				FORM SET OUTPUT:C54([MediatorFile:9];"MedEnvelope")
				PRINT SELECTION:C60([MediatorFile:9])  //removed print settings suppression dialog.
			End if 
			If (vLabel=1)
				FORM SET OUTPUT:C54([MediatorFile:9];"MedLabel")
				PRINT LABEL:C39([MediatorFile:9])  //removed print settings suppression dialog.
			End if 
		End if 
	Else 
		ALERT:C41("No Groups were selected!")
	End if 
End if 
CLEAR VARIABLE:C89(aGroup1)
CLEAR VARIABLE:C89(aGroup2)
CLEAR VARIABLE:C89(aGroup3)
CLEAR VARIABLE:C89(aAddr)
CLEAR SET:C117("sMedSet")
FORM SET OUTPUT:C54([MediatorFile:9];"MFOutput")
SET WINDOW TITLE:C213("DRC Case Management System")