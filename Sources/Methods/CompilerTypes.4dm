//%attributes = {"publishedWeb":true}
  //G-Procedure: CompilerTypes;

  //Modified by Robert J. Broussard <robert@usersoft.com>
  //UserSoft Technology <www.usersoft.com>
  //Modified: 9/3/02

C_LONGINT:C283(bDelete2;bDelete1;bPrintSum;bSubDel;bSwitch)
C_LONGINT:C283(bAddAct;bEditAct;bPrintAct;bReturnMI;bAddMed;bEditMed;bDelMed)
C_LONGINT:C283(bAddParty;bDelParty;bEditParty;bAdvance;bStartOver;bEnterDate;bQuit)
C_LONGINT:C283(bAPOK;bAPCancel;bFirstSub;bCancel;bCancelDis;bChooseTime;bCSOK)
C_LONGINT:C283(bDCancel;bDeleteSub;bDFIDelete;bDFI_ER_OK;bDFIOK;bDocDiaOK)
C_LONGINT:C283(bDOK;bENCancel;bENOK;bKevin;bLastSub;bLetter;bMAFDelete;bMAFDone)
C_LONGINT:C283(bMAFOK;bMFCancel;bMFDelete;bMFOK;bNextSub;bNotes)
C_LONGINT:C283(bOK;bPCCancel;bPCDiaOK;bPrevSub;bRefDel;bSCancel;bSearchOK)
C_LONGINT:C283(bSecret;bSortByC;bSortbyNum;bSortbyR;bStatus;bSubAdd;bSummaries)
C_LONGINT:C283(bViewAct;bGoSum;rsdCancel;rsdOK;vArb;vBlank;bDocDisDone;bDocDisCan;vCBMP)
C_LONGINT:C283(cRsn1;cRsn2;cRsn3;cRsn4;cRsn5;cRsn6;cRsn7;cRsn8)
C_LONGINT:C283(vCPenPrior;vCInt;vCRef;vCMed;vCStl;vCImp;vCCont;vCCon;vCDcl;vCNS;vCVen;vCRS;vCClosed;vCPenNext)
C_LONGINT:C283(vFPenPrior;vFInt;vFRef;vFMed;vFStl;vFImp;vFCont;vFCon;vFDcl;vFNS;vFVen;vFRS;vFClosed;vFPenNext)
C_LONGINT:C283(vJPenPrior;vJInt;vJRef;vJMed;vJStl;vJImp;vJCont;vJCon;vJDcl;vJNS;vJVen;vJRS;vJClosed;vJPenNext)
C_LONGINT:C283(vLPenPrior;vLInt;vLRef;vLMed;vLStl;vLImp;vLCont;vLCon;vLDcl;vLNS;vLVen;vLRS;vLClosed;vLPenNext)
C_LONGINT:C283(vSPenPrior;vSInt;vSRef;vSMed;vSStl;vSImp;vSCont;vSCon;vSDcl;vSNS;vSVen;vSRS;vSClosed;vSPenNext)
C_LONGINT:C283(vXPenPrior;vXInt;vXRef;vXMed;vXStl;vXImp;vXCont;vXCon;vXDcl;vXNS;vXVen;vXRS;vXClosed;vXPenNext)
C_LONGINT:C283(vCFTA;vCNoCon;vDApology;vDCon;vDCSRHours;vDetails;vDFCancel;vDFDelete;vDFOK;vDirAssist)
C_LONGINT:C283(vDMediated;vDMR;vDNotMed;vDRDone;vD_ATC;vD_Imp;vD_Stl;vElement;vFamily;vJUMP)
C_LONGINT:C283(vLit;vmafStl;vmafImp;vMed;vMSC;vNextAvail;vNumLines;vOption1;vOption2;vOption3)
C_LONGINT:C283(vPage;vSchCases;vpdDCL;vpdCON;vpdNS;vpdVEN;vTMED;vpdSTL;vpdIMP;vpdCONT;vpdRS)
C_LONGINT:C283(vRDcl;vReqDate;vRFTA;vRNoCon;vSchOK;vSCLoop1;vSCLoop2;vSelectMade;vSetHold;vSetRefer;vSchCase)
C_LONGINT:C283(vSlotOK;vSpecialEd;vTEnvBatch;vTEnvOnline;vTEnvRpt;vTLtrBatch;vTLtrOnline;vTLtrRpt)
C_LONGINT:C283(vVO;X;ZZ1;ZZ2;ZZ3;ZZ4;ZZ5;ZZ6;ZZ7;ZZ8;ZZ9;vSwitch;vShort;vShortIntak;vProbation;vCPS;vCFK)
C_LONGINT:C283(vTruant)
ARRAY TEXT:C222(aDisplay;0)
ARRAY TEXT:C222(aSMed;0)
ARRAY TEXT:C222(aSGroup;0)
ARRAY TEXT:C222(aIDNumber;0)
ARRAY TEXT:C222(aISName;0)
ARRAY TEXT:C222(aLtrType;0)
ARRAY TEXT:C222(aSDisplay;0)
C_TEXT:C284(vDummy;vSquiggly)
C_TEXT:C284(vIDNum;vPreFix;vSuffix)

C_TEXT:C284(vAPFlag;vBStatus;vPStatus;vEnvelopeText;vTempResult;vCZip)  //Mod RJB 9/3/02
C_LONGINT:C283(vEnvelope)  //Add RJB 9/3/02
  //Note some elements of vEnvelope were used as a String while
  //some uses required vEnvelope to be an integer...
  //All uses of vEnvelope that required a string usage were
  //updated to use the new vEnvelopeText variable
  //One item updated was the "Daily Correspondance Report".

C_TEXT:C284(vC1Code;vR1Code;vCode;vStlRate)
C_TEXT:C284(vDAmtCSR;vDAmtRes;vDPgNo;vDType;vHeld;vLFPage;vLRFPage;vSchTime)
C_TEXT:C284(vTimeSlot)
C_TEXT:C284(vP6)
C_TEXT:C284(vType)
C_TEXT:C284(vIntSite)
C_TEXT:C284(vDContD_n_T;vDetails2;vDMedD_n_T;vDRefBy;vTempStatus)
C_TEXT:C284(vTitle)
C_TEXT:C284(CPrintName;RPrintName;vInstruct;vISName;vMediator;vpdMed;vTimeFrame)
C_TEXT:C284(vP4;vP5)
C_TEXT:C284(vDFullName;vDispute;vPrintDate;vSelection;vSite;v1)
C_TEXT:C284(vText1;vText2;vText3;vText4;vText5)  //Mod RJB 9/3/02
  //Note: See method "MedMailOut"
C_TEXT:C284(vP1;vSubDetail)
C_TEXT:C284(vProbLine;vP2;vP3;vCOParty;vROParty;vInitials;vPInitials;vITName)  //Mod RJB 9/3/02