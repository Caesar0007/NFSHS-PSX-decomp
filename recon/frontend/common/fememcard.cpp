/* frontend/common/fememcard.cpp -- RECONSTRUCTED (FE memory-card save/load + dialogs; C++ TU)
 *   18 FREE fns (namespace nfs4::FRONTEND::COMMON::FEMemCard). Init/DeInit_Memcard tails
 *   rebuilt from m2c (Ghidra truncated to do{}while(true)). Dialog base-hierarchies routed.
 */
#include "fememcard.h"

/* ---- FEMemCard.obj-OWNED globals -- DEFINED here (self-contained; real NFS4.EXE bytes / .bss zero;
   productCode="SLUS-00826" = the retail PSX game ID; textSysMemCardFail_Index = fail-message LUT).
   Only the 4 externed-not-defined gaps (nm-confirmed); TITLE/nomessage/MEMCARD_INITIALIZED are
   already defined elsewhere. ---- */
int          CURRENTPLAYER;   /* @0x80051a68  (bss(zero)) */
char         productCode[11] = { 83, 76, 85, 83, 45, 48, 48, 56, 50, 54, 0 };   /* @0x80051a6c */
char         CURRENTLYUSINGMEMCARD;   /* @0x80051a7c  (bss(zero)) */
int          textSysMemCardFail_Index[7] = { 0, 677, 685, 675, 811, 671, 669 };   /* @0x80051a84 */


/* ---- ChecksumData  [FEMEMCARD.CPP:63-70] ---- */

void ChecksumData(tMemCardData *memCardData)

{
  u_long uVar1;
  
  memCardData->fSize = 0x14ac;
  uVar1 = crc16(&memCardData->frontEnd,0x450);
  memCardData->frontEndCRC = uVar1;
  uVar1 = crc16(&memCardData->carInfo,0xe0);
  memCardData->carInfoCRC = uVar1;
  uVar1 = crc16(&memCardData->trackInfo,0x10);
  memCardData->trackInfoCRC = uVar1;
  uVar1 = crc16(&memCardData->tournament,0xb0);
  memCardData->tournamentCRC = uVar1;
  uVar1 = crc16(memCardData->records,0xe9c);
  memCardData->recordsCRC = uVar1;
  return;
}



/* ---- VerifySuccessfulRead  [FEMEMCARD.CPP:75-86] ---- */

void * VerifySuccessfulRead(tMemCardData *memCardData)

{
  u_long uVar1;
  byte result;
  void *pvVar2;
  
  uVar1 = crc16(&memCardData->frontEnd,0x450);
  pvVar2 = (void *)(uint)(memCardData->frontEndCRC == uVar1);
  uVar1 = crc16(&memCardData->carInfo,0xe0);
  if (memCardData->carInfoCRC != uVar1) {
    pvVar2 = (void *)0x0;
  }
  uVar1 = crc16(&memCardData->trackInfo,0x10);
  if (memCardData->trackInfoCRC != uVar1) {
    pvVar2 = (void *)0x0;
  }
  uVar1 = crc16(&memCardData->tournament,0xb0);
  if (memCardData->tournamentCRC != uVar1) {
    pvVar2 = (void *)0x0;
  }
  uVar1 = crc16(memCardData->records,0xe9c);
  if (memCardData->recordsCRC != uVar1) {
    pvVar2 = (void *)0x0;
  }
  if (memCardData->fSize != 0x14ac) {
    pvVar2 = (void *)0x0;
  }
  return pvVar2;
}



/* ---- MakeWayForMemoryCard  [FEMEMCARD.CPP:90-100] ---- */

void MakeWayForMemoryCard(void)

{
  deltimer(Clock_MasterInterruptHandler);
  return;
}



/* ---- BringThatBeatBack  [FEMEMCARD.CPP:108-110] ---- */

void BringThatBeatBack(void)

{
  addtimer(Clock_MasterInterruptHandler);
  return;
}



/* ---- Confirm  [FEMEMCARD.CPP:124-168] ---- */

int Confirm(int Text,int yesText)

{
  bool bVar1;
  tFEApplication *ptVar2;
  tFEApplication *ptVar3;
  short sVar4;
  int num, yes;
  char *pcVar5;
  tDialogMessageString *dlgmsg;
  int ret;
  byte putbackon;
  tDialogYesNoMem MyDialog;
  
  BringThatBeatBack();
  tDialogYesNo_ctor(&MyDialog._base_tDialogYesNo);
  MyDialog._base_tDialogYesNo._base_tDialogInteractive._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf =
       (__vtbl_ptr_type (*)[10])tDialogYesNoMem_vtable;
  bVar1 = (FEApp->NoInputMemCardDialog)._base_tDialogMessageString._base_tDialogBase.currentlyOn != 0;
  if (bVar1) {
    Hide((tDialogBase *)&FEApp->NoInputMemCardDialog);
  }
  MyDialog._base_tDialogYesNo._base_tDialogInteractive._base_tDialogMessageString.string =
       TextSys_Word(Text);
  MyDialog._base_tDialogYesNo.yesnowords[1] = 0x292;
  MyDialog._base_tDialogYesNo._base_tDialogInteractive._base_tDialogMessageString._base_tDialogBase.fDefault = 0;
  if (frontEnd.language == '\x03') {
    MyDialog._base_tDialogYesNo._base_tDialogInteractive._base_tDialogMessageString._base_tDialogBase.OffsetX = 0;
    MyDialog._base_tDialogYesNo._base_tDialogInteractive._base_tDialogMessageString._base_tDialogBase.OffsetY = 10;
  }
  MyDialog._base_tDialogYesNo.yesnowords[0] = yesText;
  sVar4 = Run(&MyDialog._base_tDialogYesNo._base_tDialogInteractive);
  ptVar2 = FEApp;
  ret = (int)sVar4;
  if (ret == -1) {
    pcVar5 = TextSys_Word(CURRENTPLAYER + 0x32b);
    ptVar3 = FEApp;
    (ptVar2->MemCardDialog)._base_tDialogMessageString.string = pcVar5;
    Display((tDialogBase *)&ptVar3->MemCardDialog);
    while ((FEApp->MemCardDialog)._base_tDialogMessageString._base_tDialogBase.fFullyOpen != 1) {
      Redraw(FEApp);
    }
    Redraw(FEApp);
  }
  else if (ret != 0) {
    if (bVar1) {
      Display((tDialogBase *)&FEApp->NoInputMemCardDialog);
      while ((FEApp->NoInputMemCardDialog)._base_tDialogMessageString._base_tDialogBase.fFullyOpen != 1) {
        Redraw(FEApp);
      }
    }
    goto Confirm_redrawAndCleanup;
  }
  nomessage = 1;
Confirm_redrawAndCleanup:
  Redraw(FEApp);
  MakeWayForMemoryCard();
  tScreen_dtor((tScreen *)&MyDialog,2);
  return ret;
}



/* ---- OverwriteConfirm  [FEMEMCARD.CPP:171-180] ---- */

int OverwriteConfirm(void)

{
  int iVar1;
  
  iVar1 = Confirm(CURRENTPLAYER + 0x323,0x28f);
  return iVar1;
}



/* ---- OverwriteAlwaysYes  [FEMEMCARD.CPP:184-185] ---- */

int OverwriteAlwaysYes(void)

{
  return 1;
}



/* ---- FormatConfirm  [FEMEMCARD.CPP:191-204] ---- */

int FormatConfirm(void)

{
  int iVar1;
  
  iVar1 = Confirm(CURRENTPLAYER + 0x327,0x290);
  return iVar1;
}



/* ---- LoadingProc  [FEMEMCARD.CPP:209-213] ---- */

void LoadingProc(void)

{
  return;
}



/* ---- LoadingRedrawProc  [FEMEMCARD.CPP:217-221] ---- */

void LoadingRedrawProc(void)

{
  Redraw(FEApp);
  return;
}



/* ---- SavingProc  [FEMEMCARD.CPP:226-230] ---- */

void SavingProc(void)

{
  Redraw(FEApp);
  return;
}



/* ---- Init_Memcard  [FEMEMCARD.CPP:240-316] ---- */
void Init_Memcard(bool redraw,bool pinkslips)
{
  int padrestorestarttick;
  MCRDOPTS_def mcrdopts;

  if (MEMCARD_INITIALIZED != 0) {
    return;
  }
  MEMCARD_INITIALIZED = 1;
  if (MEMCARDFRONTENDISINITTED != 0) {
    AudioMus_StopSong(0);
    timedwait(5);
  }
  PAD_restore();
  padrestorestarttick = ticks;
  do { } while (ticks - padrestorestarttick < 0x3c);
  deltimer(Clock_MasterInterruptHandler);
  timedwait(0x14);
  MCRD_init(0);
  MCRD_getopts(&mcrdopts);
  mcrdopts.productLocation = (PRODUCTLOC)0;
  mcrdopts.productCode = productCode;
  mcrdopts.bMoveIconsToVram = 0;
  mcrdopts.VramIconArea.x = 0x200;
  mcrdopts.VramIconArea.y = 0x100;
  mcrdopts.VramIconArea.w = 0x20;
  mcrdopts.VramIconArea.h = 0x60;
  mcrdopts.ConfirmFormatProc = (void *)FormatConfirm;
  mcrdopts.ConfirmOverwriteProc = (void *)(pinkslips ? OverwriteAlwaysYes : OverwriteConfirm);
  mcrdopts.LoadingDataProc = (void *)(redraw ? LoadingRedrawProc : LoadingProc);
  mcrdopts.SavingDataProc = (void *)SavingProc;
  MCRD_setopts(&mcrdopts);
  addtimer(Clock_MasterInterruptHandler);
  timedwait(0x14);
  padinit();
  timedwait(0x14);
  return;
}

/* ---- DeInit_Memcard  [FEMEMCARD.CPP:321-351] ---- */
void DeInit_Memcard(void)
{
  int padrestorestarttick;

  if (MEMCARD_INITIALIZED == 0) {
    return;
  }
  MEMCARD_INITIALIZED = 0;
  deltimer(Clock_MasterInterruptHandler);
  MCRD_restore();
  addtimer(Clock_MasterInterruptHandler);
  PAD_restore();
  padrestorestarttick = ticks;
  do { } while (ticks - padrestorestarttick < 0xc0);
  padinit();
  if (MEMCARDFRONTENDISINITTED != 0) {
    UpdateMusic(FEApp);
  }
  return;
}

/* ---- Init_MemcardFile__FR12MCRDFILE_defsb  [FEMEMCARD.CPP:357-381] ---- */

extern "C" void Init_MemcardFile__FR12MCRDFILE_defsb(MCRDFILE_def *memCardFile,short cardnum,bool notitle)

{
  void *pvVar1;
  char *pcVar2;
  char *pcVar3;
  
  blockclear(memCardFile,0x2c);
  memCardFile->name = "NFS4";
  if (notitle == 0) {
    pvVar1 = PlayerNameExist((uint)(cardnum == 5));
    if (pvVar1 == (void *)0x0) {
      pcVar2 = TextSys_Word(0x279);
      sprintf(TITLE,pcVar2);
    }
    else {
      pcVar2 = TextSys_Word(0x278);
      pcVar3 = PlayerName((uint)(cardnum == 5));
      sprintf(TITLE,"%s%s",pcVar2,pcVar3);
    }
  }
  else {
    TITLE[0] = '\0';
  }
  memCardFile->title = TITLE;
  memCardFile->size = 0x1500;
  memCardFile->offset = 0;
  memCardFile->flags = 0;
  return;
}



/* ---- SaveGame  [FEMEMCARD.CPP:395-583] ---- */

void * SaveGame(short player)

{
  tFEApplication *ptVar1;
  tFEApplication *ptVar2;
  int iVar3;
  void *bigfile;
  CARDINFO_def *pCVar4;
  char *pcVar5;
  tfrontEnd *ptVar6;
  int iVar7, event;
  int i;
  tTournamentManager *this_00;
  short sVar8;
  tDialogMessageString *dlgmsg;
  int returnmessage;
  int iVar9;
  byte finished;
  void *pvVar10;
  byte returnvalue;
  void *pvVar11;
  char *shapeFile;
  tMemCardData memCardData;
  char memorycardbuffer [256];
  tDialogNoInputMessage WarningDialog;
  MCRDFILE_def memCardFile;
  char shapeFileName [64];
  short cardNum;
  
  iVar7 = 0;
  this_00 = &tournamentManager;
  ptVar6 = &frontEnd;
  CURRENTPLAYER = (int)player;
  CURRENTLYUSINGMEMCARD = 1;
  do {
    ptVar6->AnalogOn[0] = 1;
    if (gPadinfo.buf[(uint)(iVar7 != 0) * 4].ID != 's') {
      ptVar6->AnalogOn[0] = 0;
    }
    iVar7 = iVar7 + 1;
    ptVar6 = (tfrontEnd *)&ptVar6->raceType;
  } while (iVar7 < 2);
  tScreen_ctor((tScreen *)&WarningDialog);
  WarningDialog._base_tDialogMessageString._base_tDialogBase.currentlyOn = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.reservedheight = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.MaxH = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.OffsetY = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.OffsetX = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.height = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.width = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.top = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.left = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.MaxW = 0x120;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.specificPlayer = -1;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.fDefault = 0;
  WarningDialog._base_tDialogMessageString.Centerit = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.fFullyOpen = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.timeOutTicks = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.fFadeText = 0x80;
  WarningDialog._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf =
       (__vtbl_ptr_type (*)[10])tDialogNoInputMessage_vtable;
  WarningDialog._base_tDialogMessageString.string =
       TextSys_Word(player + 0x276);
  WarningDialog._base_tDialogMessageString._base_tDialogBase.OffsetX = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.OffsetY = 0x32;
  Display((tDialogBase *)&WarningDialog);
  while (pvVar10 = (void *)0x0, WarningDialog._base_tDialogMessageString._base_tDialogBase.fFullyOpen != 1) {
    Redraw(FEApp);
  }
  iVar9 = 0x28b;
  Redraw(FEApp);
  iVar7 = ((int)((uint)(ushort)player << 0x10) >> 0xe) + 1;
  sVar8 = (short)iVar7;
  nomessage = 0;
  MakeWayForMemoryCard();
  iVar7 = iVar7 * 0x10000;
  Init_MemcardFile__FR12MCRDFILE_defsb(&memCardFile,(short)((uint)iVar7 >> 0x10),false);
  memCardFile.pData = (u_char *)&memCardData;
  while (iVar3 = MCRD_handlecardevents(iVar7 >> 0x10), iVar3 == 0x15) {
    VSync(0);
  }
  blockmove(&frontEnd,&memCardData.frontEnd,0x450);
  SaveTournament(this_00,&memCardData.tournament);
  SaveTracks(&trackManager,&memCardData.trackInfo);
  SaveCars(&carManager, &memCardData.carInfo);
  blockmove(Stats_gTrackRecords,memCardData.records,0xe9c);
  memCardData.pinkSlipsNoCheat = rand();
  FECheat_SaveBonus(&memCardData.bonus);
  sprintf(shapeFileName,"%szMem.psh",Paths_Paths[0x20]);
  bigfile = (void *)loadshapeadr(shapeFileName,(void *)0x0);
  memCardFile.flags = 0x200;
  memCardFile.icon[0] = shapepointer(bigfile,0);
  memCardFile.icon[1] = (shapetbl *)0x0;
  memCardFile.icon[2] = (shapetbl *)0x0;
  ChecksumData(&memCardData);
  pvVar11 = (void *)0x0;
  while (pvVar10 == (void *)0x0) {
    iVar7 = MCRD_handlecardevents((int)sVar8);
    systemtask(0);
    VSync(0);
    switch(iVar7) {
    case 2:
    case 3:
    case 7:
    case 10:
    case 0xb:
    case 0xd:
    case 0x17:
      pCVar4 = MCRD_getcard(((int)((uint)(ushort)player << 0x10) >> 0xe) + 1);
      iVar9 = 0x29d;
      if ((pCVar4->status != -3) && (iVar9 = 0x325, pCVar4->status == -1)) {
        iVar9 = 0x32b;
      }
      pvVar10 = (void *)0x1;
      break;
    case 0xc:
      iVar9 = 0x28b;
      pvVar10 = (void *)0x1;
      pvVar11 = pvVar10;
      break;
    case 0x16:
      if (gMemCardInfo.bReady != 0) {
        MCRD_savefile((int)sVar8,&memCardFile);
      }
    }
  }
  while (iVar7 = MCRD_handlecardevents((int)sVar8), iVar7 != 0x16) {
    VSync(0);
  }
  purgememadr(bigfile);
  BringThatBeatBack();
  if (nomessage == 0) {
    Hide((tDialogBase *)&FEApp->NoInputMemCardDialog);
    ptVar1 = FEApp;
    pcVar5 = TextSys_Word(iVar9 + player);
    ptVar2 = FEApp;
    (ptVar1->MemCardDialog)._base_tDialogMessageString.string = pcVar5;
    Display((tDialogBase *)&ptVar2->MemCardDialog);
    while ((FEApp->MemCardDialog)._base_tDialogMessageString._base_tDialogBase.fFullyOpen != 1) {
      Redraw(FEApp);
    }
    Redraw(FEApp);
  }
  screenMemcard->fGetNewIcons = 1;
  Hide((tDialogBase *)&WarningDialog);
  Redraw(FEApp);
  CURRENTLYUSINGMEMCARD = 0;
  tScreen_dtor((tScreen *)&WarningDialog,2);
  return pvVar11;
}



/* ---- LoadGame__FsbT1  [FEMEMCARD.CPP:591-812] ---- */

extern "C" short LoadGame__FsbT1(short player,bool PinkSlips,byte WithDialogs)

{
  bool bVar1;
  tFEApplication *ptVar2;
  tFEApplication *ptVar3;
  int iVar4;
  int iVar5;
  void *pvVar6;
  CARDINFO_def *pCI;
  int memCardResult;
  char *pcVar8;
  tTournamentManager *this_00;
  int iVar9;
  int card;
  int iVar10;
  tDialogMessageString *dlgmsg;
  byte finished;
  int iVar11;
  int returnmessage;
  int iVar12;
  short cardNum;
  short sVar13;
  int result;
  ushort cardnum;
  int count;
  tMemCardData memCardData;
  char memorycardbuffer [256];
  tDialogNoInputMessage WarningDialog;
  MCRDFILE_def memCardFile;
  
  iVar10 = WithDialogs;
  iVar9 = PinkSlips;
  this_00 = (tTournamentManager *)(int)player;
  iVar11 = (int)player;
  cardnum = (ushort)(iVar11 << 2) | 1;
  CURRENTLYUSINGMEMCARD = 1;
  CURRENTPLAYER = iVar11;
  tScreen_ctor((tScreen *)&WarningDialog);
  WarningDialog._base_tDialogMessageString._base_tDialogBase.currentlyOn = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.reservedheight = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.MaxH = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.OffsetY = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.OffsetX = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.height = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.width = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.top = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.left = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.MaxW = 0x120;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.specificPlayer = -1;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.fDefault = 0;
  WarningDialog._base_tDialogMessageString.Centerit = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.fFullyOpen = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.timeOutTicks = 0;
  WarningDialog._base_tDialogMessageString._base_tDialogBase.fFadeText = 0x80;
  WarningDialog._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf =
       (__vtbl_ptr_type (*)[10])tDialogNoInputMessage_vtable;
  if ((iVar10 != 0) || (iVar9 != 0)) {
    WarningDialog._base_tDialogMessageString.string =
         TextSys_Word(iVar11 + 0x276);
    if (iVar9 == 0) {
      WarningDialog._base_tDialogMessageString._base_tDialogBase.OffsetX = 0;
      WarningDialog._base_tDialogMessageString._base_tDialogBase.OffsetY = 0x32;
    }
    Display((tDialogBase *)&WarningDialog);
    while (WarningDialog._base_tDialogMessageString._base_tDialogBase.fFullyOpen != 1) {
      Redraw(FEApp);
    }
    Redraw(FEApp);
  }
  bVar1 = false;
  sVar13 = 0;
  iVar11 = 0x2c;
  nomessage = 0;
  if (iVar10 != 0) {
    iVar11 = 0;
  }
  iVar12 = 0x28d;
LoadGame_memcardInit:
  iVar11 = iVar11 + 1;
  MakeWayForMemoryCard();
  card = (int)(short)cardnum;
  Init_MemcardFile__FR12MCRDFILE_defsb(&memCardFile,cardnum,true);
  while( true ) {
    iVar4 = MCRD_handlecardevents(card);
    if (iVar4 != 0x15) break;
    VSync(0);
  }
  memCardFile.flags = 0;
  iVar4 = (int)player;
  memCardFile.pData = (u_char *)&memCardData;
switchD_80035054_caseD_4:
  if (bVar1) goto LAB_80035238;
  iVar5 = MCRD_handlecardevents(card);
  systemtask(0);
  VSync(0);
  switch(iVar5) {
  case 2:
  case 3:
  case 7:
  case 10:
  case 0xb:
  case 0x10:
  case 0x17:
    pCI = MCRD_getcard(iVar4 * 4 + 1);
    Hide((tDialogBase *)&FEApp->NoInputMemCardDialog);
    if (pCI->status == -2) {
      iVar12 = 0x29f;
      sVar13 = 2;
    }
    else {
      sVar13 = 1;
      if (pCI->status == -1) {
        sVar13 = 3;
        iVar12 = 0x32b;
      }
      else {
        iVar12 = 0x329;
      }
    }
    break;
  default:
    goto switchD_80035054_caseD_4;
  case 0xf:
    pvVar6 = VerifySuccessfulRead(&memCardData);
    if (pvVar6 != (void *)0x0) {
      sVar13 = 0;
      if (iVar9 == 0) {
        if (iVar4 == 0) {
          blockmove(&memCardData.frontEnd,&frontEnd,0x450);
          LoadTournament(this_00,&memCardData.tournament);
          LoadTracks(&trackManager,&memCardData.trackInfo);
          blockmove(memCardData.records,Stats_gTrackRecords,0xe9c);
          FECheat_LoadBonus(&memCardData.bonus);
        }
        else {
          sprintf(frontEnd.playerNameList[iVar4 * 4],memCardData.frontEnd.playerNameList[0]);
        }
        LoadCars(&carManager, &memCardData.carInfo,player);
      }
      else {
        frontEnd.gPinkSlipsNoCheat[iVar4] = memCardData.pinkSlipsNoCheat;
        LoadPinkSlipsCars(&carManager, &memCardData.carInfo,player);
        sprintf(frontEnd.playerNameList[iVar4 * 4],memCardData.frontEnd.playerNameList[0]);
        frontEnd.pinkSlipsCash[iVar4] = memCardData.tournament.fSaveMoney;
      }
      iVar12 = 0x28d;
      SetPads();
      bVar1 = true;
      goto switchD_80035054_caseD_4;
    }
    sVar13 = 1;
    if (iVar10 != 0) {
      bVar1 = true;
      if (nomessage == 0) {
        Hide((tDialogBase *)&FEApp->NoInputMemCardDialog);
        Hide((tDialogBase *)&FEApp->MemCardDialog);
        ptVar2 = FEApp;
        pcVar8 = TextSys_Word(iVar4 + 0x329);
        ptVar3 = FEApp;
        (ptVar2->MemCardDialog)._base_tDialogMessageString.string = pcVar8;
        Display((tDialogBase *)&ptVar3->MemCardDialog);
        bVar1 = true;
      }
      goto switchD_80035054_caseD_4;
    }
    break;
  case 0x16:
    MCRD_loadfile(card,&memCardFile,0);
    goto switchD_80035054_caseD_4;
  }
  bVar1 = true;
  goto switchD_80035054_caseD_4;
LAB_80035238:
  while (iVar4 = MCRD_handlecardevents(card), iVar4 != 0x16) {
    VSync(0);
  }
  BringThatBeatBack();
  if ((iVar12 == 0x28d) || (2 < iVar11)) {
    if ((iVar10 != 0) && (nomessage == 0)) {
      Hide((tDialogBase *)&FEApp->NoInputMemCardDialog);
      Hide((tDialogBase *)&FEApp->MemCardDialog);
      ptVar2 = FEApp;
      pcVar8 = TextSys_Word(iVar12 + player);
      ptVar3 = FEApp;
      (ptVar2->MemCardDialog)._base_tDialogMessageString.string = pcVar8;
      Display((tDialogBase *)&ptVar3->MemCardDialog);
      while ((FEApp->MemCardDialog)._base_tDialogMessageString._base_tDialogBase.fFullyOpen != 1) {
        Redraw(FEApp);
      }
      Redraw(FEApp);
    }
    Front_ResetPSXController((int)player,(uint)(byte)frontEnd.controlConfig[player]);
    if (iVar9 == 0) {
      if (frontEnd.raceType == '\x06') {
        frontEnd.raceType = '\0';
      }
      gMasterSFXLevel = (int)(byte)frontEnd.sfxVolume;
    }
    if ((iVar10 != 0) || (iVar9 != 0)) {
      Hide((tDialogBase *)&WarningDialog);
    }
    if (iVar10 != 0) {
      Redraw(FEApp);
    }
    CURRENTLYUSINGMEMCARD = 0;
    tScreen_dtor((tScreen *)&WarningDialog,2);
    return sVar13;
  }
  goto LoadGame_memcardInit;
}



/* ---- SavePinkSlipsCars  [FEMEMCARD.CPP:818-1069] ---- */
PinkSlipsErrorCode
SavePinkSlipsCars(short player,short withoutCarInGarageNumber)

{
  bool bVar1;
  PinkSlipsErrorCode PVar2;
  short sVar3;
  int iVar4;
  void *addr;
  int iVar5;
  void *pvVar6;
  CARDINFO_def *pCVar7;
  int card, memCardResult;
  int event;
  PinkSlipsErrorCode result;
  PinkSlipsErrorCode PVar8;
  byte finished;
  PinkSlipsErrorCode PVar9;
  byte finishedsave;
  char *shapeFile;
  tMemCardData memCardData;
  char memorycardbuffer [256];
  char shapeFileName [64];
  MCRDFILE_def memCardFile;
  short cardNum;
  
  MakeWayForMemoryCard();
  CURRENTPLAYER = (int)player;
  iVar4 = CURRENTPLAYER * 4 + 1;
  PVar9 = PinkSlipsNoError;
  bVar1 = false;
  sVar3 = (short)iVar4;
  iVar4 = iVar4 * 0x10000;
  CURRENTLYUSINGMEMCARD = 1;
  nomessage = 0;
  sprintf(shapeFileName,"%szMem.psh",Paths_Paths[0x20]);
  addr = (void *)loadshapeadr(shapeFileName,(void *)0x0);
  Init_MemcardFile__FR12MCRDFILE_defsb(&memCardFile,(short)((uint)iVar4 >> 0x10),true);
  while (iVar5 = MCRD_handlecardevents(iVar4 >> 0x10), iVar5 == 0x15) {
    VSync(0);
  }
  iVar4 = (int)player;
  memCardFile.pData = (u_char *)&memCardData;
  memCardFile.flags = 0;
  PVar2 = PinkSlipsNoError;
switchD_80035530_caseD_4:
  PVar8 = PVar2;
  if (PVar9 != PinkSlipsNoError) {
    while (iVar4 = MCRD_handlecardevents((int)sVar3), iVar4 != 0x16) {
      VSync(0);
    }
    purgememadr(addr);
    BringThatBeatBack();
    CURRENTLYUSINGMEMCARD = 0;
    return PVar8;
  }
  card = (int)sVar3;
  iVar5 = MCRD_handlecardevents(card);
  systemtask(0);
  VSync(0);
  PVar2 = PVar8;
  switch(iVar5) {
  case 2:
  case 0x10:
    pCVar7 = MCRD_getcard(iVar4 * 4 + 1);
    PVar8 = PinkSlipsError_NotFormatted;
    if ((pCVar7->status != -2) && (PVar8 = PinkSlipsError_LoadFailed, pCVar7->status == -1)) {
      PVar8 = PinkSlipsError_CardNotFound;
    }
    break;
  case 3:
  case 7:
  case 10:
  case 0xb:
  case 0x17:
    PVar9 = PinkSlipsError_NotOriginalCard;
    PVar2 = PinkSlipsError_LoadFailed;
  default:
    goto switchD_80035530_caseD_4;
  case 0xf:
    pvVar6 = VerifySuccessfulRead(&memCardData);
    if (pvVar6 == (void *)0x0) {
      PVar8 = PinkSlipsError_LoadFailed;
    }
    else {
      PVar9 = PinkSlipsError_NotOriginalCard;
      PVar2 = PVar9;
      if (frontEnd.gPinkSlipsNoCheat[iVar4] != memCardData.pinkSlipsNoCheat)
      goto switchD_80035530_caseD_4;
      SavePinkSlipsCars(&carManager,&memCardData.carInfo,player);
      while (iVar5 = MCRD_handlecardevents(card), iVar5 == 0x15) {
        VSync(0);
      }
      memCardFile.flags = 0x200;
      memCardFile.icon[0] = shapepointer(addr,0);
      memCardFile.icon[1] = (shapetbl *)0x0;
      memCardFile.icon[2] = (shapetbl *)0x0;
      ChecksumData(&memCardData);
      while (!bVar1) {
        iVar5 = MCRD_handlecardevents(card);
        systemtask(0);
        VSync(0);
        switch(iVar5) {
        case 2:
        case 3:
        case 7:
        case 10:
        case 0xb:
        case 0xd:
        case 0x17:
          Hide((tDialogBase *)&FEApp->NoInputMemCardDialog);
          pCVar7 = MCRD_getcard(iVar4 * 4 + 1);
          PVar8 = PinkSlipsError_CardFull;
          if ((pCVar7->status != -3) && (PVar8 = PinkSlipsError_SaveFailed, pCVar7->status == -1)) {
            PVar8 = PinkSlipsError_CardNotFound;
          }
          bVar1 = true;
          break;
        case 0xc:
          bVar1 = true;
          PVar8 = PinkSlipsNoError;
          break;
        case 0x16:
          if (gMemCardInfo.bReady != 0) {
            MCRD_savefile(card,&memCardFile);
          }
        }
      }
    }
    break;
  case 0x16:
    MCRD_loadfile(card,&memCardFile,0);
    goto switchD_80035530_caseD_4;
  }
  PVar9 = PinkSlipsError_NotOriginalCard;
  PVar2 = PVar8;
  goto switchD_80035530_caseD_4;
}



/* ---- SavePinkSlipsCarsWithErrorDialogs  [FEMEMCARD.CPP:1090] ---- */
PinkSlipsErrorCode
SavePinkSlipsCarsWithErrorDialogs(short player,short WillLoseCar,short withoutCarInGarageNumber)

{
  short sVar1;
  PinkSlipsErrorCode PVar2;
  char *pcVar3;
  char *pcVar4;
  tDialogYesNo *dlgmsg;
  int count;
  int iVar5;
  PinkSlipsErrorCode err;
  int yes;
  int player_00;
  int retry;
  char *shapeFile;
  tDialogYesNo RetryCancelDialog;
  tDialogNoInputMessage WillLoseCarMessage;
  char string [500];
  char string2 [500];
  tDialogNoInputMessage WarningDialog;
  
  tDialogYesNo_ctor(&RetryCancelDialog);
  tScreen_ctor((tScreen *)&WillLoseCarMessage);
  sVar1 = 0;
  player_00 = (int)player;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.currentlyOn = 0;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.reservedheight = 0;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.MaxH = 0;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.OffsetY = 0;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.OffsetX = 0;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.height = 0;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.width = 0;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.top = 0;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.left = 0;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.MaxW = 0x120;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.specificPlayer = -1;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.fDefault = 0;
  WillLoseCarMessage._base_tDialogMessageString.Centerit = 0;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.fFullyOpen = 0;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.timeOutTicks = 0;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.fFadeText = 0x80;
  WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf =
       (__vtbl_ptr_type (*)[10])tDialogNoInputMessage_vtable;
  RetryCancelDialog.yesnowords[0] = 0x291;
  RetryCancelDialog.yesnowords[1] = 0x292;
  RetryCancelDialog._base_tDialogInteractive._base_tDialogMessageString._base_tDialogBase.fDefault = 1;
  RetryCancelDialog._base_tDialogInteractive._base_tDialogMessageString._base_tDialogBase.specificPlayer = player;
  do {
    Display((tDialogBase *)&FEApp->NoInputMemCardDialog);
    while ((FEApp->NoInputMemCardDialog)._base_tDialogMessageString._base_tDialogBase.fFullyOpen != 1) {
      Redraw(FEApp);
    }
    iVar5 = 0;
    Redraw(FEApp);
    tScreen_ctor((tScreen *)&WarningDialog);
    WarningDialog._base_tDialogMessageString._base_tDialogBase.currentlyOn = 0;
    WarningDialog._base_tDialogMessageString._base_tDialogBase.reservedheight = 0;
    WarningDialog._base_tDialogMessageString._base_tDialogBase.MaxH = 0;
    WarningDialog._base_tDialogMessageString._base_tDialogBase.OffsetY = 0;
    WarningDialog._base_tDialogMessageString._base_tDialogBase.OffsetX = 0;
    WarningDialog._base_tDialogMessageString._base_tDialogBase.height = 0;
    WarningDialog._base_tDialogMessageString._base_tDialogBase.width = 0;
    WarningDialog._base_tDialogMessageString._base_tDialogBase.top = 0;
    WarningDialog._base_tDialogMessageString._base_tDialogBase.left = 0;
    WarningDialog._base_tDialogMessageString._base_tDialogBase.MaxW = 0x120;
    WarningDialog._base_tDialogMessageString._base_tDialogBase.specificPlayer = -1;
    WarningDialog._base_tDialogMessageString._base_tDialogBase.fDefault = 0;
    WarningDialog._base_tDialogMessageString.Centerit = 0;
    WarningDialog._base_tDialogMessageString._base_tDialogBase.fFullyOpen = 0;
    WarningDialog._base_tDialogMessageString._base_tDialogBase.timeOutTicks = 0;
    WarningDialog._base_tDialogMessageString._base_tDialogBase.fFadeText = 0x80;
    WarningDialog._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf =
         (__vtbl_ptr_type (*)[10])tDialogNoInputMessage_vtable;
    WarningDialog._base_tDialogMessageString.string =
         TextSys_Word(player_00 + 0x276);
    WarningDialog._base_tDialogMessageString._base_tDialogBase.OffsetX = 0;
    WarningDialog._base_tDialogMessageString._base_tDialogBase.OffsetY = 0x32;
    Display((tDialogBase *)&WarningDialog);
    while (WarningDialog._base_tDialogMessageString._base_tDialogBase.fFullyOpen != 1) {
      Redraw(FEApp);
    }
    Redraw(FEApp);
    do {
      PVar2 = SavePinkSlipsCars(player,withoutCarInGarageNumber);
      iVar5 = iVar5 + 1;
      if (PVar2 == PinkSlipsNoError) break;
      timedwait(5);
    } while (iVar5 < 3);
    Hide((tDialogBase *)&WarningDialog);
    Redraw(FEApp);
    if (PVar2 != PinkSlipsNoError) {
      Hide((tDialogBase *)&FEApp->NoInputMemCardDialog);
      pcVar3 = TextSys_Word(textSysMemCardFail_Index[PVar2] + player_00);
      sprintf(string,pcVar3);
      if (WillLoseCar != 0) {
        iVar5 = 0x298;
        if (WillLoseCar == 2) {
          iVar5 = 0x299;
        }
        pcVar3 = TextSys_Word(iVar5);
        pcVar4 = PlayerName(player_00);
        sprintf(string2,pcVar3,pcVar4);
        WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.OffsetX = 0;
        WillLoseCarMessage._base_tDialogMessageString._base_tDialogBase.OffsetY = -0x3c;
        WillLoseCarMessage._base_tDialogMessageString.string = string2;
        Display((tDialogBase *)&WillLoseCarMessage);
      }
      RetryCancelDialog._base_tDialogInteractive._base_tDialogMessageString.string = string;
      sVar1 = Run(&RetryCancelDialog._base_tDialogInteractive);
      Hide((tDialogBase *)&WillLoseCarMessage);
    }
    tScreen_dtor((tScreen *)&WarningDialog,2);
    if ((PVar2 == PinkSlipsNoError) || (sVar1 == 0)) {
      tScreen_dtor((tScreen *)&WillLoseCarMessage,2);
      tScreen_dtor((tScreen *)&RetryCancelDialog,2);
      return PVar2;
    }
  } while( true );
}



/* end of fememcard.cpp */

extern "C" {
void ___23tMenuItemGoToMenuButton(void *);
void ___19tMemoryCardMenuItem(void *thisp) { ___23tMenuItemGoToMenuButton(thisp); }
}
