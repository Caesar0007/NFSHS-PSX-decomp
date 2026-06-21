/* frontend/common/front.cpp -- RECONSTRUCTED (front-end orchestration + tAllScreens ctor/dtor; C++ TU)
 *   43 fns: free Front_* / stream builders / utility fns + tAllScreens ctor (constructs all
 *   screen objects) + dtor. Free fns in ns nfs4::FRONTEND::COMMON::Front.
 */
#include "front.h"

/* ---- Front.obj-OWNED globals -- DEFINED here (self-contained; .data=real EXE bytes, .bss=zero) ---- */
int          overRide;   /* @0x800517e8  (bss(zero)) */
int          ComingIntoTheFrontEndTheVeryFirstTime;   /* @0x800517ec  (bss(zero)) */
tCarModels   regularCopModels[7][5] = { 24, 24, 24, 23, 22, 24, 24, 24, 23, 22, 24, 24, 24, 24, 22, 24, 24, 24, 24, 25, 26, 26, 26, 24, 25, 26, 26, 26, 24, 25, 27, 27, 27, 27, 27 };   /* @0x800517f0 */
tCarModels   superCopModels[7][5] = { 26, 26, 26, 24, 25, 26, 26, 26, 24, 25, 26, 26, 26, 24, 25, 26, 26, 26, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27 };   /* @0x8005187c */
char         gFE_Cheats[5];   /* @0x80051908  (bss(zero)) */
int          gPSXMemCardFull;   /* @0x80051910  (bss(zero)) */
int          colourChosen[8];   /* @0x80051914  (bss(zero)) */
tAllScreens  *gAllScreens;   /* @0x80051934  (bss(zero)) */
int          memCardReadOK;   /* @0x80051938  (bss(zero)) */
tCarInLineup CarLineup[9];   /* @0x8005193c  (bss(zero)) */
char         picked[11];   /* @0x80051960  (bss(zero)) */


/* ---- Front_ConstructAll  [FRONT.CPP:231-266] ---- */

/* Decoded Phase 83: Front_ConstructAll() - one-shot allocate all menu screens (400 B). Sets up
   gAllScreens layout: screenMain, screenCarSelect, screenCarSelectDuel, screenCarSelectTwoPlayer,
   screenPinkSlips*, screenTrackRecords, screenTrackInfo, screenTrackSelect, screenTournSelect,
   screenTournamentStandings/Trophy, screenTrophyRoom/Info, screenControllerConfig, screenDisplay,
   screenAudio, screenMemcard. These are all the front-end screens linked by gAllScreens.
   
   [ghidra-meta] section: front.text */

void Front_ConstructAll(void)

{
  tAllScreens *dlgThis;
  tFEApplication *this_00;
  tGlobalMenuDefs *this_01;
  uint size;
  
  dlgThis = __builtin_new(0x3bd8);
  gAllScreens = tAllScreens_ctor(dlgThis);
  screenCarSelect = &gAllScreens->screenCarSelect;
  screenCarSelectDuel = &gAllScreens->screenCarSelectDuel;
  screenCarSelectTwoPlayer = &gAllScreens->screenCarSelectTwoPlayer;
  screenCarSelectPlayerTwo = &gAllScreens->screenCarSelectPlayerTwo;
  screenPinkSlipsCarSelectTwoPlayer = &gAllScreens->screenPinkSlipsCarSelectTwoPlayer;
  screenPinkSlipsCarSelectPlayerTwo = &gAllScreens->screenPinkSlipsCarSelectPlayerTwo;
  screenTrackRecords = &gAllScreens->screenTrackRecords;
  screenTrackInfo = &gAllScreens->screenTrackInfo;
  screenTrackSelect = &gAllScreens->screenTrackSelect;
  screenTournSelect = &gAllScreens->screenTournSelect;
  screenTournamentStandings = &gAllScreens->screenTournamentStandings;
  screenTournamentTrophy = &gAllScreens->screenTournamentTrophy;
  screenTrophyRoom = &gAllScreens->screenTrophyRoom;
  screenTrophyInfo = &gAllScreens->screenTrophyInfo;
  screenControllerConfig = &gAllScreens->screenControllerConfig;
  screenDisplay = &gAllScreens->screenDisplay;
  screenAudio = &gAllScreens->screenAudio;
  screenMemcard = &gAllScreens->screenMemcard;
  screenUserName = &gAllScreens->screenUserName;
  screenPinkSlipCongrats = &gAllScreens->screenPinkSlipCongrats;
  screenPinkSlipStandings = &gAllScreens->screenPinkSlipStandings;
  screenTournamentStandings3item = &gAllScreens->screenTournamentStandings3item;
  screenPinkSlips = &gAllScreens->screenPinkSlips;
  size = 0x3b18;
  screenBeTheCopCongrats = &gAllScreens->screenBeTheCopCongrats;
  screenTournamentCongrats = &gAllScreens->screenTournamentCongrats;
  screenMain = &gAllScreens->screenMain;
  this_00 = __builtin_new(0x380);
  FEApp = tFEApplication_ctor(this_00);
  this_01 = __builtin_new(size);
  menuDefs = tGlobalMenuDefs_ctor(this_01);
  return;
}



/* ---- Front_DeleteAll  [FRONT.CPP:270-273] ---- */

/* Decoded Phase 83: Front_DeleteAll() - free all FE allocations (100 B). Mirror of
   Front_ConstructAll.
   
   [ghidra-meta] section: front.text */

void Front_DeleteAll(void)

{
  if (gAllScreens != (tAllScreens *)0x0) {
    tAllScreens_dtor(gAllScreens,3);
  }
  if (FEApp != (tFEApplication *)0x0) {
    tFEApplication_dtor(FEApp,3);
  }
  if (menuDefs != (tGlobalMenuDefs *)0x0) {
    tGlobalMenuDefs_dtor(menuDefs,3);
  }
  return;
}



/* ---- Front_ResetSettingsForCar  [FRONT.CPP:280-284] ---- */

/* Decoded Phase 83: Front_ResetSettingsForCar(int playerIdx, int carID) - reset per-car tuning to
   defaults when car changed (80 B).
   
   [ghidra-meta] section: front.text */

void Front_ResetSettingsForCar(int player,int car)

{
  frontEnd.settingsActive[player] = frontEnd.settingsActive[player] & ~(ushort)(1 << (car & 0x1fU));
  frontEnd.carDownforce[player * 0x18][car] = '2';
  frontEnd.suspension[player * 0x18][car] = '2';
  frontEnd.engineTuning[player * 0x18][car] = '\x03';
  return;
}



/* ---- Front_ResetSettingsMenu  [FRONT.CPP:288-294] ---- */

/* Decoded Phase 83: Front_ResetSettingsMenu(int) - reset menu-display state (72 B, 2 callers).
   
   [ghidra-meta] section: front.text */

void Front_ResetSettingsMenu(int player)

{
  int i;
  int car;
  
  car = 0;
  do {
    Front_ResetSettingsForCar(player,car);
    car = car + 1;
  } while (car < 0x30);
  return;
}



/* ---- Front_ResetPSXController  [FRONT.CPP:299-309] ---- */

/* Decoded Phase 83: Front_ResetPSXController(int port, int) - revert controller config to defaults(108 B, 6 callers).
   
   [ghidra-meta] section: front.text */

void Front_ResetPSXController(int player,int config)

{
  
  timedwait(10);
  PAD_update();
  frontEnd.controlType[player] = (ushort)gPadinfo.buf[player * 4].ID;
  frontEnd.controlConfig[player] = (char)config;
  return;
}



/* ---- Front_ResetPSXAnalogs  [FRONT.CPP:318-330] ---- */

/* Decoded Phase 83: Front_ResetPSXAnalogs(int port) - reset analog stick calibration (68 B).
   
   [ghidra-meta] section: front.text */

void Front_ResetPSXAnalogs(int player)

{
  frontEnd.steeringRange[player] = 'y';
  frontEnd.deadSpot[player] = '\n';
  frontEnd.ImaxRange[player] = -1;
  frontEnd.IImaxRange[player] = -1;
  frontEnd.J1MAX[player] = '\x7f';
  frontEnd.J1MIN[player] = '\x06';
  frontEnd.J2MAX[player] = '\x7f';
  frontEnd.J2MIN[player] = '\x06';
  return;
}



/* ---- GetPSXPadValue  [FRONT.CPP:333-465] ---- */

/* int GetPSXPadValue(int value, int player)
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x80027194 block=CODE size=888B
     Direct callers: 51
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:333
     SYM data: 2 regparms / 0 args / 0 autos
     Sample callers: Front_BuildStream, Controller_SetRamp
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

int GetPSXPadValue(int value,int player)

{
  byte bVar1;
  int newControl;
  byte bVar2;
  int type;
  uint uVar3;
  uint uVar4;
  
  PAD_update();
  if (gPadinfo.buf[player * 4].nopad == '\0') {
    bVar2 = gPadinfo.buf[player * 4].ID;
  }
  else {
    bVar2 = 0;
  }
  if (bVar2 != 0x53) {
    if (bVar2 < 0x54) {
      if (bVar2 == 0x23) {
        if (value == 0x8000) {
          bVar2 = frontEnd.IImaxRange[player];
          uVar3 = 0x2000000;
        }
        else {
          if (0x8000 < value) {
            if (value != 0x200000) {
              if (value != 0x800000) goto front_badPadValue;
              bVar2 = frontEnd.deadSpot[player];
              bVar1 = frontEnd.steeringRange[player];
              goto GetPad_returnJ1J2neg;
            }
            uVar4 = player << 0x1e | ((byte)frontEnd.deadSpot[player] + 0x80) * 0x10000;
            uVar3 = ((byte)frontEnd.steeringRange[player] + 0x80) * 0x100;
            goto GetPad_returnJ1Inverted;
          }
          if (value == 0x400) {
            return player << 0x1e | 0x30aff01;
          }
          if (value != 0x4000) goto front_badPadValue;
          bVar2 = frontEnd.ImaxRange[player];
          uVar3 = 0x1000000;
        }
        uVar4 = player << 0x1e;
        uVar3 = (uint)bVar2 << 8 | uVar3;
        goto GetPad_returnJ1Inverted;
      }
      goto front_badPadValue;
    }
    if (bVar2 != 0x73) goto front_badPadValue;
  }
  if (value == 0x400000) {
    uVar3 = ((byte)frontEnd.J1MIN[player] + 0x80) * 0x10000 | 0x1000000;
    bVar2 = frontEnd.J1MAX[player];
GetPad_returnJ1Pos:
    return player << 0x1e | uVar3 | (bVar2 + 0x80) * 0x100 | 1;
  }
  if (value < 0x400001) {
    if (value == 0x100000) {
      uVar3 = (0x7f - (uint)(byte)frontEnd.J1MIN[player]) * 0x10000 | 0x1000000;
      bVar2 = frontEnd.J1MAX[player];
      goto GetPad_returnJ2;
    }
    if (0x100000 < value) {
      if (value == 0x200000) {
        uVar4 = player << 0x1e | ((byte)frontEnd.J1MIN[player] + 0x80) * 0x10000;
        uVar3 = ((byte)frontEnd.J1MAX[player] + 0x80) * 0x100;
GetPad_returnJ1Inverted:
        return uVar4 | uVar3 | 1;
      }
front_badPadValue:
      return player << 0x1a | value << 8 | 2;
    }
    if (value != -0x80000000) goto front_badPadValue;
    bVar2 = frontEnd.J2MIN[player];
    uVar3 = 0x2000000;
  }
  else {
    if (value != 0x10000000) {
      if (value < 0x10000001) {
        if (value == 0x800000) {
          bVar2 = frontEnd.J1MIN[player];
          bVar1 = frontEnd.J2MAX[player];
GetPad_returnJ1J2neg:
          return player << 0x1e | (0x7f - (uint)bVar2) * 0x10000 | (0x7f - (uint)bVar1) * 0x100 | 1;
        }
        goto front_badPadValue;
      }
      if (value == 0x20000000) {
        bVar2 = frontEnd.J2MIN[player];
        uVar3 = 0x2000000;
      }
      else {
        if (value != 0x40000000) goto front_badPadValue;
        bVar2 = frontEnd.J2MIN[player];
        uVar3 = 0x3000000;
      }
      uVar3 = (bVar2 + 0x80) * 0x10000 | uVar3;
      bVar2 = frontEnd.J2MAX[player];
      goto GetPad_returnJ1Pos;
    }
    bVar2 = frontEnd.J2MIN[player];
    uVar3 = 0x3000000;
  }
  uVar3 = (0x7f - (uint)bVar2) * 0x10000 | uVar3;
  bVar2 = frontEnd.J2MAX[player];
GetPad_returnJ2:
  return player << 0x1e | uVar3 | (0x7f - (uint)bVar2) * 0x100 | 1;
}



/* ---- SetPads  [FRONT.CPP:474-503] ---- */

/* void SetPads()
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x8002750C block=CODE size=316B
     Direct callers: 2
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:474
     Sample callers: Front_SecondaryMemCardCheck, LoadGame
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

void SetPads(void)

{
  bool bVar1;
  int starttick;
  int iVar2;
  int iVar3;
  int i;
  int offs;
  int pad;
  int port;
  int numoffsets;
  byte gotone;
  int theanalogoffset;
  int iVar4;
  int j;
  int iVar5;
  int LookingFor;
  int iVar6;
  tfrontEnd *ptVar7;
  
  ptVar7 = &frontEnd;
  for (iVar5 = 0; iVar4 = ticks, iVar6 = 4, iVar5 < 2; iVar5 = iVar5 + 1) {
    port = iVar5 << 4;
    if (ptVar7->AnalogOn[0] != 0) {
      iVar6 = 7;
    }
    do {
      bVar1 = false;
      if (ticks - iVar4 < 0x80) {
        iVar2 = PadGetState(port);
        bVar1 = iVar2 != 6;
      }
    } while (bVar1);
    iVar2 = PadGetState(port);
    iVar4 = 0;
    if (iVar2 == 6) {
      bVar1 = false;
      iVar2 = PadInfoMode(port,4,-1);
      for (offs = 0; offs < iVar2; offs = offs + 1) {
        iVar3 = PadInfoMode(port,4,offs);
        if (iVar3 == iVar6) {
          bVar1 = true;
          iVar4 = offs;
        }
      }
      if (bVar1) {
        PadSetMainMode(port,iVar4,0);
      }
    }
    ptVar7 = (tfrontEnd *)&ptVar7->raceType;
  }
  return;
}



/* ---- InitFrontEndStructure  [FRONT.CPP:507-664] ---- */

/* void InitFrontEndStructure()
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x80027648 block=CODE size=760B
     Direct callers: 1
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:507
     Sample callers: Front_InitialMemCardCheck
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

void InitFrontEndStructure(void)

{
  tfrontEnd *ptVar1;
  tfrontEnd *ptVar2;
  int iVar3;
  tCarInfo *ptVar4;
  int j;
  int iVar5;
  int i;
  int iVar6;
  int iVar7;
  tfrontEnd *ptVar8;
  int iStack_30;
  
  frontEnd.randomSeed = 0;
  frontEnd.catchup = '\x01';
  frontEnd.currentPlayer = '\0';
  frontEnd.cheatFlags = 0;
  frontEnd.cheatFlagsActive = 0;
  frontEnd.secretFlags = 0;
  frontEnd.gameMode = '\0';
  frontEnd.raceType = '\0';
  frontEnd.skillLevel = '\0';
  frontEnd.headstart = '\x14';
  ptVar1 = &frontEnd;
  iVar7 = 0;
  do {
    iVar6 = iVar7 + 1;
    ptVar1->track[0] = '\0';
    ptVar1->lapind[0] = '\0';
    ptVar1->trackmirrored[0] = '\0';
    ptVar1->trackdirection[0] = '\0';
    ptVar1->timeOfDay[0] = '\0';
    ptVar1->weather[0] = '\0';
    ptVar1->traffic[0] = '\0';
    ptVar1->situations[0] = '\0';
    ptVar1->checkPointDisplay[0] = '\0';
    ptVar1->playerCar[0] = '\0';
    ptVar1 = (tfrontEnd *)(iVar7 + -0x7feeb9ff);
    iVar7 = iVar6;
  } while (iVar6 < 5);
  iVar7 = 0;
  ptVar2 = &frontEnd;
  iVar6 = 0;
  iStack_30 = 0;
  frontEnd.localSpeech = '\0';
  frontEnd.opponentUpgrades = '\0';
  frontEnd.dealerCar = '\0';
  frontEnd.sellerCar = '\0';
  frontEnd.damage = '\x01';
  frontEnd.laps = '\0';
  frontEnd.recordlaptime =
       Stattool_ReturnRecordLapTime((ushort)(byte)frontEnd.track[0]);
  frontEnd.tractionassist = '\x01';
  frontEnd.bestline = '\x01';
  frontEnd.checkPointType = '\x01';
  frontEnd.tournament = '\0';
  frontEnd.specialevent = '\0';
  frontEnd.tier = '\0';
  frontEnd.upgrade = '\0';
  frontEnd.policeTier = '\0';
  frontEnd.policeMission = '\0';
  frontEnd.measurement = '\0';
  ptVar1 = ptVar2;
  ptVar8 = ptVar2;
  do {
    iVar5 = 0;
    ptVar1->AnalogOn[0] = 1;
    ptVar2->ABS[0] = '\0';
    ptVar2->transmission[0] = '\x01';
    ptVar2->displaySpeed[0] = '\0';
    ptVar2->displayTach[0] = '\x01';
    ptVar2->displayMap[0] = '\x01';
    ptVar2->displayOpponentID[0] = '\x01';
    ptVar2->displayTime[0] = '\x01';
    ptVar2->displayPosition[0] = '\x01';
    ptVar2->displayLapNumber[0] = '\x01';
    ptVar2->displayMirror[0] = '\0';
    ptVar2->pinkSlipsWins[0] = '\0';
    ptVar1->pinkSlipsCash[0] = 0;
    frontEnd.pinkSlipsForfeit = -1;
    ptVar1->cameraType[0][1] = '\x03';
    ptVar1->cameraType[1][0] = '\x06';
    ptVar1->cameraType[1][1] = '\a';
    ptVar1->cameraType[0][0] = '\0';
    frontEnd.playerNameList[iVar7 * 4][0] = '\0';
    iVar3 = iVar6;
    do {
      frontEnd.cameraSway[0][iVar3] = '\0';
      iVar5 = iVar5 + 1;
      iVar3 = iVar5 + iVar6;
    } while (iVar5 < 4);
    iVar3 = 0;
    ptVar2->rampSteer[0] = '\x01';
    ptVar2->rampGas[0] = '\x01';
    ptVar2->rampBrake[0] = '\x01';
    do {
      ptVar4 = GetCarFromID(&carManager, (short)iVar3);
      iVar5 = iVar3 + iStack_30;
      iVar3 = iVar3 + 1;
      frontEnd.carColors[0][iVar5] = ptVar4->fDefaultColor;
    } while (iVar3 < 0x30);
    ptVar8->controlType[0] = 0x41;
    ptVar2->controlConfig[0] = '\0';
    ptVar2->defaultedPlayerName[0] = '\x01';
    ptVar2->shockMode[0] = 'U';
    ptVar2->shockImpact[0] = 'U';
    Front_ResetPSXAnalogs(iVar7);
    Front_ResetPSXController(iVar7,0);
    ptVar2 = (tfrontEnd *)((int)&ptVar2->randomSeed + 1);
    ptVar8 = (tfrontEnd *)&ptVar8->currentPlayer;
    iVar6 = iVar6 + 4;
    ptVar1 = (tfrontEnd *)&ptVar1->raceType;
    iVar7 = iVar7 + 1;
    iStack_30 = iStack_30 + 0x30;
  } while (iVar7 < 2);
  frontEnd.numBTracksActivated = '\0';
  Front_ResetSettingsMenu(0);
  Front_ResetSettingsMenu(1);
  frontEnd.oppNumber = '\x01';
  frontEnd.audioMode = '\x02';
  frontEnd.oppCar = '\0';
  frontEnd.language = '\0';
  frontEnd.musicVolume = 'U';
  frontEnd.sfxVolume = 'U';
  frontEnd.narrationVolume = 'U';
  frontEnd.engineVolume = 'U';
  frontEnd.ambientVolume = 'U';
  frontEnd.song = '\0';
  gMasterMusicLevel = 0x55;
  gMasterSFXLevel = 0x55;
  gMasterFENarrationLevel = 0x55;
  gMasterAmbientLevel = 0x55;
  frontEnd.sensitivity = '\0';
  frontEnd.GotAPlayList = 0;
  Setup(&CreditManager);
  return;
}



/* ---- LoadConfig  [FRONT.CPP:810-811] ---- */

/* int LoadConfig()
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x80027940 block=CODE size=8B
     Direct callers: 1
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:811
     Sample callers: Front_Menu
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

int LoadConfig(void)

{
  return 0;
}



/* ---- Front_InitialMemCardCheck  [FRONT.CPP:819-847] ---- */

/* Boot-time memcard state initialization.MEMCARDFRONTENDISINITTED = 0;
     gPSXMemCardFull = 0;
     memCardReadOK = 0;
     Stattool_GetAllDefaultRecords(Stats_gTrackRecords, 0);  // load if empty
     InitFrontEndStructure();
     frontEnd.language = 0;
   
   The fOverride=0 in Stattool_GetAllDefaultRecords means 'load defaults only
   if records are empty'. Cheat 0x14 calls the same fn with fOverride=1 to
   forcibly reset records.Decoded Phase 41.
   
   [ghidra-meta] section: front.text */

void Front_InitialMemCardCheck(void)

{
  MEMCARDFRONTENDISINITTED = 0;
  gPSXMemCardFull = 0;
  memCardReadOK = 0;
  Stattool_GetAllDefaultRecords(Stats_gTrackRecords,false);
  InitFrontEndStructure();
  frontEnd.language = '\0';
  return;
}



/* ---- Front_SecondaryMemCardCheck  [FRONT.CPP:852-872] ---- */

/* Decoded Phase 83: Front_SecondaryMemCardCheck() - re-validate memcard on slot 2 (200 B). Used
   during 2-player setup.
   
   [ghidra-meta] section: front.text
   
   [Locals 2026-05-08] Locals renamed via deep-body inspection. FE secondary memcard scan.Init_Memcard(0,0); MEMCARDFRONTENDISINITTED = 0. Outer loop card_i 0..1 (2 cards): inner retry
   loop retry_i 0..2 (3 retries) - LoadGame() sets memCardReadOK if successful (sVar1==0); else
   clears. After all retries: continue to next card. After loop: DeInit_Memcard + SetPads +
   MEMCARDFRONTENDISINITTED=1. j local is caller-side spill. Note: outer loop has no explicit
   termination - exits via the iVar3>=2 check at top of loop body. */

void Front_SecondaryMemCardCheck(void)

{
  short sVar1;
  int i;
  int retry_i;
  int j;
  int card_i;
  
  MEMCARDFRONTENDISINITTED = 0;
  Init_Memcard(false,0);
  card_i = 0;
  do {
    if (1 < card_i) {
      DeInit_Memcard();
      SetPads();
      MEMCARDFRONTENDISINITTED = 1;
      return;
    }
    retry_i = 0;
    if (memCardReadOK == 0) {
      do {
        sVar1 = LoadGame((short)card_i,false,0);
        memCardReadOK = (int)(sVar1 == 0);
        retry_i = retry_i + 1;
        if (2 < retry_i) break;
      } while (memCardReadOK == 0);
    }
    memCardReadOK = 0;
    card_i = card_i + 1;
  } while( true );
}



/* ---- Front_InitGraphics  [FRONT.CPP:880-915] ---- */

/* Decoded Phase 83: Front_InitGraphics() - one-shot front-end graphics init (120 B, 2 callers).Loads font textures, FE shape table from FRONT.BIN.
   
   [ghidra-meta] section: front.text */

void Front_InitGraphics(void)

{
  int iVar1;
  char buffer [40];
  
  initlinkmode(0,1);
  sprintf(buffer,"%szzFE.viv",Paths_Paths[0x23]);
  iVar1 = FILE_addbigsync(buffer,(void *)0x0,100,&gFEBigHandle);
  if (iVar1 == 0) {
    do {
                    /* WARNING: Do nothing block with infinite loop */
    } while( true );
  }
  Platform_ResetDCTBuffer();
  Init_PSX_FrontEnd();
  return;
}



/* ---- Front_InitGraphicsAndDisplayLoading  [FRONT.CPP:919-920] ---- */

/* Decoded Phase 83: Front_InitGraphicsAndDisplayLoading() - init graphics + show loading screen (32
   B). Wrapper that calls InitGraphics + posts loading overlay.
   
   [ghidra-meta] section: front.text */

void Front_InitGraphicsAndDisplayLoading(void)

{
  Front_InitGraphics();
  return;
}



/* ---- Front_Menu  [FRONT.CPP:934-1046] ---- */

/* Decoded Phase 83: Front_Menu(tFront_ProcessingType) - top-level front-end menu driver (692 B).Mode dispatcher: SETUP_RACE / RETURN_FROM_RACE / SAVE / LOAD / etc. Handles raceType==2
   (tournament) with replay-replay==0 special path.
   
   [ghidra-meta] section: front.text */

int Front_Menu(tFront_ProcessingType role)

{
  ushort uVar1;
  Car_tStats *dummyCars;
  long extraMoney;
  int *in_a3;
  int result;
  tAppCommand tVar3;
  tMenuCommand tempCommand;
  
  tVar3 = kApp_Command_StartRace;
  _7tScreen_fSuppressLoadingText = 1;
  gLargestUnused = largestunused();
  FeAudio_InitCommentary((uint)(byte)frontEnd.language,0);
  InitializeSpinningCars();
  Front_ConstructAll();
  uVar1 = GetNumOwnedCars(&carManager, 0);
  if ((int)((uint)uVar1 << 0x10) < 1 && tournamentManager.fMoney < 1) {
    extraMoney = CheapestCarStockPrice(&carManager);
    tournamentManager.fMoney = tournamentManager.fMoney + extraMoney + 1;
  }
  if (role != kFront_QuitToGameSetup) {
    if (1 < (int)role) {
      if (role == kFront_QuitToPostGame) {
        gCalculateVictory = '\x01';
        if ((frontEnd.raceType == '\x02') && (GameSetup_gData.replayMode == 0)) {
          AdvanceToNextTrack(&tournamentManager);
          UpdateAwardInformation(&tournamentManager);
        }
        else if ((frontEnd.raceType == '\x06') && (GameSetup_gData.replayMode == 0)) {
          if (((Cars_gNewCarStatsList[0].finalPosition < 2) && (frontEnd.pinkSlipsForfeit != 0)) ||
             (frontEnd.pinkSlipsForfeit == 1)) {
            frontEnd.pinkSlipsWinner[(byte)frontEnd.pinkSlipsTrackIndex] = 0;
            frontEnd.pinkSlipsWins[0] = frontEnd.pinkSlipsWins[0] + '\x01';
          }
          else {
            frontEnd.pinkSlipsWinner[(byte)frontEnd.pinkSlipsTrackIndex] = 1;
            frontEnd.pinkSlipsWins[1] = frontEnd.pinkSlipsWins[1] + '\x01';
          }
        }
        tVar3 = RunPostGame(FEApp);
      }
      goto FrontMenu_runFrontEndCleanup;
    }
    if (role != kFront_InitialLoad) goto FrontMenu_runFrontEndCleanup;
    LoadConfig();
  }
  if (gUseFrontend != 0) {
    MenuExtended_TransitionFromPostGameToMainMenu(&tempCommand);
    tVar3 = RunFrontEnd(FEApp);
  }
FrontMenu_runFrontEndCleanup:
  Front_DeleteAll();
  FeAudio_DeInitCommentary();
  Audio_FECleanUp();
  TextSys_UnloadWords();
  FeTools_deinit();
  PSXExitFrontend();
  FILE_delbigsync((char *)gFEBigHandle,(void *)0x64);
  gFEBigHandle = 0;
  frontEnd.recordlaptime =
       Stattool_ReturnRecordLapTime((ushort)(byte)frontEnd.track[0]);
  gLargestUnused = largestunused();
  return tVar3;
}



/* ---- OutputDisplaySettings  [FRONT.CPP:1171-1204] ---- */

/* int * OutputDisplaySettings(int * d, int c, int player,
   tTrackInformation * trackInfo)
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x80027DA8 block=CODE size=536B
     Direct callers: 1
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:1171
     SYM data: 4 regparms / 0 args / 0 autos
     Sample callers: Front_AppendPlayerCarData
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

int * OutputDisplaySettings(int *d,int c,int player,tTrackInformation *trackInfo)

{
  byte bVar1;
  int iVar2;
  int valtopass;
  
  bVar1 = frontEnd.displaySpeed[player];
  iVar2 = 0;
  if (bVar1 != 1) {
    if (bVar1 < 2) {
      iVar2 = 2;
      if (bVar1 == 0) {
        iVar2 = (int)CountryMeasurement[trackInfo->fSpeedoCountry];
      }
    }
    else {
      iVar2 = 2;
      if (bVar1 == 2) {
        iVar2 = 1;
      }
    }
  }
  *d = 0x11a;
  d[1] = c;
  d[2] = iVar2;
  d[3] = 0x11b;
  d[4] = c;
  d[5] = (uint)(frontEnd.displaySpeed[player] != '\x03');
  d[6] = 0x11c;
  d[7] = c;
  d[8] = (uint)(byte)frontEnd.displayMap[player];
  d[9] = 0x11d;
  d[10] = c;
  d[0xb] = (uint)(byte)frontEnd.displayOpponentID[player];
  d[0xc] = 0x11e;
  d[0xd] = c;
  d[0xe] = (uint)(byte)frontEnd.displayTime[player];
  d[0xf] = 0x11f;
  d[0x10] = c;
  d[0x11] = (uint)(byte)frontEnd.displayLapNumber[player];
  d[0x12] = 0x120;
  d[0x13] = c;
  d[0x14] = (uint)(byte)frontEnd.displayPosition[player];
  d[0x15] = 0x121;
  d[0x16] = c;
  d[0x17] = (uint)(byte)frontEnd.displayMirror[player];
  d[0x18] = 0x126;
  d[0x19] = c;
  d[0x1a] = (uint)(byte)frontEnd.cameraType[player * 2][0];
  d[0x1b] = 0x127;
  d[0x1c] = c;
  d[0x1d] = (uint)(byte)frontEnd.cameraType[player * 2][1];
  d[0x1e] = 0x128;
  d[0x1f] = c;
  d[0x20] = (uint)(byte)frontEnd.cameraType[player * 2 + 1][0];
  d[0x21] = 0x129;
  d[0x22] = c;
  d[0x23] = (uint)(byte)frontEnd.cameraType[player * 2 + 1][1];
  return d + 0x24;
}



/* ---- Front_GetLapsForType  [FRONT.CPP:1210-1223] ---- */

/* Decoded Phase 83: Front_GetLapsForType() - return default lap count for current raceType (168 B,
   5 callers). Single race=2, tournament round=N from tier table.
   
   [ghidra-meta] section: front.text */

int Front_GetLapsForType(void)

{
  uint uVar1;
  short lapconv [2];
  
  lapconv[0] = 2;
  lapconv[1] = 4;
  if (frontEnd.raceType == '\x02') {
    uVar1 = (uint)(tournamentManager.fDefinition)->fTournaments
                  [(uint)(tournamentManager.fDefinition)->fTiers[tournamentManager.fTier].fTournOffset + tournamentManager.fTournament].fNumLaps;
  }
  else {
    uVar1 = (uint)lapconv[(byte)frontEnd.lapind[(byte)frontEnd.pinkSlipsTrackIndex]];
  }
  return uVar1;
}



/* ---- Front_InitStream  [FRONT.CPP:1231-1235] ---- */

/* Decoded Phase 83: Front_InitStream(tFEStream&) - clear tFEStream to safe initial state (48 B).Called first in BuildStream pipeline.
   
   [ghidra-meta] section: front.text */

void Front_InitStream(tFEStream *streamData)

{
  streamData->totalCars = 0;
  streamData->totalModels = 0;
  streamData->currentCar = 0;
  InitializeIngameCarList(&carManager);
  return;
}



/* ---- Front_InitPlayerCars  [FRONT.CPP:1241-1324] ---- */

/* Decoded Phase 83: Front_InitPlayerCars(tFEStream&) - populate playerCars[] from garage state (964
   B). raceType==2 (tournament): garageCar[0] from save. raceType!=6: standard car select. Reads
   carColors[i*0x18][carID] to pick skin from selection menu state.
   
   [ghidra-meta] section: front.text */

void Front_InitPlayerCars(tFEStream *streamData)

{
  uchar uVar1;
  short sVar2;
  char *pcVar3;
  void *pvVar4;
  int iVar5;
  tCarInfo *carInfo;
  tCarInfo *ptVar6;
  short i;
  tCarModels carModel;
  char carColor;
  
  streamData->numPlayers = 0;
  if (frontEnd.raceType == '\x02') {
    GetGarageCar(&carManager, (ushort)(byte)frontEnd.garageCar[0],streamData->playerCars,0);
  }
  else {
    iVar5 = 0;
    if (frontEnd.raceType != '\x06') {
      do {
        sVar2 = (short)iVar5;
        if (frontEnd.carListType == '\0') {
          GetStockCar(&carManager, (ushort)(byte)frontEnd.playerCar[sVar2],
                     streamData->playerCars + streamData->numPlayers);
          ptVar6 = streamData->playerCars + streamData->numPlayers;
          pcVar3 = ptVar6->fShapeName + ((byte)frontEnd.carColors[sVar2 * 0x18][ptVar6->fCarID] - 8)
          ;
        }
        else {
          GetGarageCar(&carManager, (ushort)(byte)frontEnd.garageCar[sVar2],
                     streamData->playerCars + streamData->numPlayers,sVar2);
          ptVar6 = streamData->playerCars + streamData->numPlayers;
          pcVar3 = ptVar6->fShapeName + (ptVar6->fColor - 8);
        }
        ptVar6->fColor = pcVar3[0xaf];
        if (ptVar6->fCarClass == '\a') {
          uVar1 = frontEnd.carCountry[streamData->numPlayers * 0x18][ptVar6->fCarID];
          ptVar6->fColor = '\0';
          ptVar6->fCountry = uVar1;
        }
        streamData->numPlayers = streamData->numPlayers + 1;
        iVar5 = iVar5 + 1;
      } while ((frontEnd.gameMode == '\x01') && (iVar5 * 0x10000 >> 0x10 < 2));
      goto FrontInitPlayers_playerLoop;
    }
    GetPinkSlipsCar(&carManager, (ushort)(byte)frontEnd.pinkSlipsCar[0],streamData->playerCars,0);
    sVar2 = streamData->numPlayers;
    streamData->playerCars[sVar2].fColor =
         streamData->playerCars[sVar2].fColorOrder[streamData->playerCars[sVar2].fColor];
    sVar2 = streamData->numPlayers + 1;
    streamData->numPlayers = sVar2;
    GetPinkSlipsCar(&carManager, (ushort)(byte)frontEnd.pinkSlipsCar[1],streamData->playerCars + sVar2,1);
  }
  sVar2 = streamData->numPlayers;
  streamData->playerCars[sVar2].fColor =
       streamData->playerCars[sVar2].fColorOrder[streamData->playerCars[sVar2].fColor];
  streamData->numPlayers = streamData->numPlayers + 1;
FrontInitPlayers_playerLoop:
  for (sVar2 = 0; iVar5 = (int)sVar2, iVar5 < streamData->numPlayers; sVar2 = sVar2 + 1) {
    carModel = (tCarModels)streamData->playerCars[iVar5].fCarID;
    carColor = streamData->playerCars[iVar5].fColor;
    pvVar4 = IsCarAnAddedModel(&carManager, &carModel,&carColor);
    if ((pvVar4 != (void *)0x1) && (streamData->totalModels < 0xd)) {
      streamData->totalModels = streamData->totalModels + 6;
    }
    AddCarToIngameList(&carManager, &carModel,&carColor);
    streamData->totalCars = streamData->totalCars + 2;
    streamData->carLineup[sVar2].isPlayerCar = 1;
    streamData->carLineup[sVar2].carModel = carModel;
    streamData->carLineup[sVar2].carColor = carColor;
    streamData->carLineup[sVar2].carUpgrades = streamData->playerCars[sVar2].fUpgrades;
  }
  return;
}



/* ---- Front_InitTourneyTraffic  [FRONT.CPP:1329-1358] ---- */

/* Decoded Phase 83: Front_InitTourneyTraffic(tFEStream&) - tournament-mode traffic init (372 B).Different traffic profile per tournament tier.
   
   [ghidra-meta] section: front.text */

void Front_InitTourneyTraffic(tFEStream *streamData)

{
  byte bVar1;
  tTournamentDefinition *ptVar2;
  short sVar3;
  void *pvVar4;
  int iVar5;
  short i;
  int iVar6;
  tCarModels carModel;
  char carColor;
  
  ptVar2 = tournamentManager.fDefinition;
  iVar6 = tournamentManager.fTournament;
  carColor = '\0';
  bVar1 = (tournamentManager.fDefinition)->fTiers[tournamentManager.fTier].fTournOffset;
  streamData->numTraffic = 0;
  if ((frontEnd.raceType == '\x02') && (ptVar2->fTournaments[(uint)bVar1 + iVar6].fTraffic != '\0'))
  {
    iVar6 = 0;
    do {
      iVar5 = iVar6 + 1;
      carModel = (tCarModels)(byte)(streamData->trackInfo).fTrafficCars[(short)iVar6];
      if (5 < iVar5 * 0x10000 >> 0x10) {
        iVar5 = 0;
      }
      pvVar4 = IsCarAnAddedModel(&carManager, &carModel,&carColor);
      if (pvVar4 != (void *)0x1) {
        streamData->totalModels = streamData->totalModels + 1;
        AddCarToIngameList(&carManager, &carModel,&carColor);
      }
      streamData->trafficCars[streamData->numTraffic] = (u_short)carModel;
      sVar3 = streamData->numTraffic + 1;
      streamData->numTraffic = sVar3;
      streamData->totalCars = streamData->totalCars + 1;
      iVar6 = iVar5;
    } while (sVar3 < 3);
  }
  return;
}



/* ---- Front_InitOpponentCars  [FRONT.CPP:1366-1529] ---- */

/* Decoded Phase 83: Front_InitOpponentCars(tFEStream&) - allocate AI opponent cars (1428 B). For
   tournament (raceType==2) AND special (oppNumber==2): full 5-opponent grid. Otherwise 0..N from
   frontEnd.opponents[] picks. Sets numOpponents=0 first, then conditionally adds based on raceType
   + grid size. Each opp gets carID + skin color from grid CSV.
   
   [ghidra-meta] section: front.text
   
   [Locals 2026-05-10 bulk] Bulk-renamed Ghidra SSA temps to type-hinted user-names (ti=int,
   tu=uint, ts=short, tb=byte, tstr=char*, tp=void*, etc.) for audit cleanliness. Generic but
   preserves type info; these are minor secondary-effect register temps that did not warrant
   individual semantic naming. */

void Front_InitOpponentCars(tFEStream *streamData)

{
  byte bVar1;
  tTournamentDefinition *ptVar2;
  short sVar3;
  tCarInfo *ptVar4;
  void *pvVar5;
  uchar uVar6;
  tCarClassType opponentClass;
  int iVar7;
  tPersonalities tVar8;
  short sVar9;
  tCarInfo *carInfo;
  short i;
  int iVar10;
  tTourneyInfo *tourn;
  short numOpponents;
  int iVar11;
  tCarInfo tStack_120;
  tCarModels modelList [3];
  tCarModels carModel;
  char carColor;
  tCarModels tStack_38;
  char loc_34 [4];
  byte usePlayerUpgrades;
  
  streamData->numOpponents = 0;
  ptVar2 = tournamentManager.fDefinition;
  if ((frontEnd.raceType == '\x02') ||
     ((frontEnd.raceType == '\0' && (frontEnd.oppNumber == '\x02')))) {
    if (frontEnd.raceType == '\x02') {
      uVar6 = (tournamentManager.fDefinition)->fTournaments
              [(uint)(tournamentManager.fDefinition)->fTiers[tournamentManager.fTier].fTournOffset +
               tournamentManager.fTournament].fOpponentCarClass;
    }
    else {
      uVar6 = '\n';
    }
    if (uVar6 != '\n') {
      iVar7 = (uint)(tournamentManager.fDefinition)->fTiers[tournamentManager.fTier].fTournOffset +
              tournamentManager.fTournament;
    }
    else {
      iVar7 = (uint)(tournamentManager.fDefinition)->fTiers[2].fTournOffset +
              (uint)(byte)streamData->playerCars[0].fCarID;
    }
    _usePlayerUpgrades = (uint)(uVar6 == '\n');
    iVar11 = 5;
    if (frontEnd.raceType == '\x02') {
      iVar11 = tournamentManager.fNumRacers + -1;
    }
    iVar10 = 0;
    if (0 < iVar11 << 0x10) {
      do {
        sVar3 = (short)iVar10;
        bVar1 = ptVar2->fTournaments[iVar7].fOpponentCar[sVar3];
        carModel = (tCarModels)bVar1;
        ptVar4 = GetCarFromID(&carManager, (ushort)bVar1);
        carColor = ptVar4->fDefaultColor;
        pvVar5 = IsCarAnAddedModel(&carManager, &carModel,&carColor);
        if ((pvVar5 != (void *)0x1) && (streamData->totalModels < 0x10)) {
          streamData->totalModels = streamData->totalModels + 3;
        }
        FindSimilarCar(&carManager, &carModel,&carColor,0,(tCarModels *)0x0);
        AddCarToIngameList(&carManager, &carModel,&carColor);
        streamData->carLineup[sVar3 + 1].isPlayerCar = 0;
        streamData->carLineup[sVar3 + 1].carModel = carModel;
        streamData->carLineup[sVar3 + 1].carColor = ptVar4->fColorOrder[(byte)carColor];
        if (_usePlayerUpgrades == 0) {
          streamData->carLineup[sVar3 + 1].carUpgrades =
               ptVar2->fTournaments[iVar7].fOpponentUpgrades[sVar3];
        }
        else {
          streamData->carLineup[sVar3 + 1].carUpgrades = streamData->playerCars[0].fUpgrades;
        }
        if ((frontEnd.raceType == '\x02') && (frontEnd.tier == '\0')) {
          pvVar5 = FECheat_IsCheatEnabled(cheat_FinishedTournament);
          if ((pvVar5 == (void *)0x0) || (frontEnd.opponentUpgrades == '\0')) {
            streamData->carLineup[sVar3 + 1].carUpgrades = '\0';
          }
          else {
            streamData->carLineup[sVar3 + 1].carUpgrades =
                 ptVar2->fTournaments[iVar7].fOpponentUpgrades[sVar3];
          }
        }
        iVar10 = iVar10 + 1;
        streamData->totalCars = streamData->totalCars + 2;
        streamData->numOpponents = streamData->numOpponents + 1;
      } while (iVar10 * 0x10000 < iVar11 << 0x10);
    }
    sVar3 = 0;
    if (frontEnd.raceType == '\x02') {
      UpdateCarLineup(&tournamentManager);
      iVar10 = 0;
      streamData->numOpponents = (short)tournamentManager.fNumRacers + -1;
      iVar7 = (short)iVar11 + 1;
      if (0 < iVar7) {
        do {
          sVar3 = (short)iVar10;
          streamData->carLineup[sVar3].personality = tournamentManager.fCarLineup[sVar3].personality
          ;
          iVar10 = iVar10 + 1;
          streamData->carLineup[sVar3].position = tournamentManager.fCarLineup[sVar3].position;
        } while (iVar10 * 0x10000 >> 0x10 < iVar7);
      }
    }
    else {
      do {
        sVar9 = sVar3 + 1;
        tVar8 = (tPersonalities)sVar3;
        streamData->carLineup[tVar8 + kPersonalityBlurrr].personality = tVar8;
        streamData->carLineup[tVar8 + kPersonalityBlurrr].position = (char)sVar9;
        sVar3 = sVar9;
      } while (sVar9 < 5);
      streamData->carLineup[0].position = '\x06';
    }
  }
  else if (((byte)frontEnd.raceType < 2) && (frontEnd.oppNumber == '\x01')) {
    GetStockCar(&carManager, (ushort)(byte)frontEnd.oppCar,&tStack_120);
    tStack_38 = (int)tStack_120.fCarID;
    loc_34[0] = tStack_120.fColorOrder[tStack_120.fDefaultColor];
    pvVar5 = IsCarAnAddedModel(&carManager, &tStack_38,loc_34);
    if (pvVar5 != (void *)0x1) {
      if (streamData->totalModels < 0x10) {
        streamData->totalModels = streamData->totalModels + 3;
      }
      else {
        GetClassList(&carManager, (uint)tStack_120.fCarClass,3,modelList);
        FindSimilarCar(&carManager, &tStack_38,loc_34,3,modelList);
      }
    }
    sVar3 = streamData->numOpponents;
    uVar6 = streamData->playerCars[0].fUpgrades;
    streamData->carLineup[1].isPlayerCar = 0;
    streamData->carLineup[1].personality = kPersonalityNemesis;
    streamData->numOpponents = sVar3 + 1;
    sVar3 = streamData->numOpponents;
    streamData->carLineup[1].position = '\x01';
    streamData->carLineup[1].carUpgrades = uVar6;
    streamData->carLineup[1].carModel = tStack_38;
    streamData->carLineup[1].carColor = loc_34[0];
    streamData->carLineup[0].position = (char)sVar3 + '\x01';
    AddCarToIngameList(&carManager, &tStack_38,loc_34);
    streamData->totalCars = streamData->totalCars + 2;
  }
  else {
    streamData->carLineup[0].position = '\x01';
    streamData->carLineup[1].position = '\x02';
  }
  return;
}



/* ---- Front_InitMissions  [FRONT.CPP:1536-1579] ---- */

/* Decoded Phase 83: Front_InitMissions(tFEStream&) - tournament mission setup (304 B). Reads
   tMissionManager state to populate per-tier objectives.
   
   [ghidra-meta] section: front.text */

void Front_InitMissions(tFEStream *streamData)

{
  char cVar1;
  char cVar2;
  char cVar3;
  short i;
  int iVar4;
  char cVar5;
  tCarModels fBestCar;
  char oldTier;
  char oldMission;
  
  streamData->pMission = (tMissionInfo *)0x0;
  streamData->pStages = (tStageInfo *)0x0;
  cVar3 = frontEnd.policeMission;
  cVar2 = frontEnd.policeTier;
  cVar5 = '\0';
  if (frontEnd.raceType == '\x01') {
    _i = 0;
    if (0 < streamData->numPlayers) {
      iVar4 = 0;
      do {
        if (streamData->playerCars[iVar4 >> 0x10].fCarClass != '\a') {
          return;
        }
        cVar1 = streamData->playerCars[iVar4 >> 0x10].fCarID;
        _i = _i + 1;
        if (cVar5 < cVar1) {
          cVar5 = cVar1;
        }
        iVar4 = _i * 0x10000;
      } while (_i * 0x10000 >> 0x10 < (int)streamData->numPlayers);
    }
    frontEnd.policeTier = cVar5 + -0x16;
    frontEnd.policeMission = '\0';
    LoadDescription(&missionManager,true);
    GetMissionToRace(&missionManager,&streamData->pMission);
    GetMissionStages(&missionManager,(ushort)(byte)frontEnd.policeTier,
               (ushort)(byte)frontEnd.policeMission,&streamData->pStages);
  }
  frontEnd.policeTier = cVar2;
  frontEnd.policeMission = cVar3;
  return;
}



/* ---- Front_InitCopCars  [FRONT.CPP:1606-1696] ---- */

/* Decoded Phase 83: Front_InitCopCars(tFEStream&) - populate cop cars (960 B). Picks cop count +
   types based on raceType + selected difficulty. Reserves AI slots for cops separate from
   opponents.
   
   [ghidra-meta] section: front.text */

void Front_InitCopCars(tFEStream *streamData)

{
  ushort uVar1;
  tCarModels *ptVar2;
  void *pvVar3;
  short sVar4;
  int iVar5;
  tCarModels tVar6;
  uint uVar7;
  tCarModels tVar8;
  tCarModels fBestModel;
  uint uVar9;
  tCarClassType fBestClass;
  short i;
  int iVar10;
  tCarModels copModel;
  char copColor;
  
  tVar8 = cm_MercedesSLK;
  iVar10 = 0;
  uVar9 = 0;
  copColor = '\0';
  streamData->numCops = 0;
  streamData->numSuperCops = 0;
  if (0 < streamData->numPlayers) {
    iVar5 = 0;
    do {
      tVar6 = (tCarModels)streamData->playerCars[iVar5 >> 0x10].fCarID;
      if ((int)tVar8 < (int)tVar6) {
        tVar8 = tVar6;
      }
      uVar7 = (uint)streamData->playerCars[iVar5 >> 0x10].fCarClass;
      iVar10 = iVar10 + 1;
      if (uVar9 < uVar7) {
        uVar9 = uVar7;
      }
      iVar5 = iVar10 * 0x10000;
    } while (iVar10 * 0x10000 >> 0x10 < (int)streamData->numPlayers);
  }
  if ((streamData->pMission == (tMissionInfo *)0x0) || (streamData->pStages == (tStageInfo *)0x0)) {
    if (frontEnd.raceType == '\x01') {
      iVar10 = 0;
      if (0 < streamData->numPlayers) {
        iVar5 = 0;
        do {
          iVar10 = iVar10 + 1;
          if (streamData->playerCars[iVar5 >> 0x10].fCarClass == '\a') {
            return;
          }
          iVar5 = iVar10 * 0x10000;
        } while (iVar10 * 0x10000 >> 0x10 < (int)streamData->numPlayers);
      }
      if ((streamData->numPlayers == 1) && (streamData->numOpponents == 0)) {
        streamData->numCops = 2;
        streamData->numSuperCops = 1;
      }
      else if (streamData->numPlayers == 2) {
        streamData->numCops = 0;
        streamData->numSuperCops = 2;
      }
      else {
        streamData->numCops = 4;
        streamData->numSuperCops = 0;
      }
      uVar1 = streamData->numSuperCops;
      iVar10 = 0;
      if (0 < (int)streamData->numCops + (int)streamData->numSuperCops) {
        iVar5 = 0;
        do {
          if (iVar5 < (int)((uint)uVar1 << 0x10)) {
            ptVar2 = superCopModels[uVar9] + (byte)(streamData->trackInfo).fCountry;
          }
          else {
            ptVar2 = regularCopModels[uVar9] + (byte)(streamData->trackInfo).fCountry;
          }
          copModel = *ptVar2;
          pvVar3 = IsCarAnAddedModel(&carManager, &copModel,&copColor);
          if (pvVar3 != (void *)0x1) {
            streamData->totalModels = streamData->totalModels + 3;
            AddCarToIngameList(&carManager, &copModel,&copColor);
          }
          sVar4 = (short)iVar10;
          streamData->copCars[sVar4] = copModel;
          iVar10 = iVar10 + 1;
          streamData->totalCars = streamData->totalCars + 2;
          streamData->copCountry[sVar4] = (ushort)(byte)(streamData->trackInfo).fCountry;
          uVar1 = streamData->numSuperCops;
          iVar5 = iVar10 * 0x10000;
        } while (iVar10 * 0x10000 >> 0x10 < (int)streamData->numCops + (int)streamData->numSuperCops
                );
      }
    }
  }
  else if ((frontEnd.gameMode != '\x01') && (iVar10 = 0, streamData->pMission->fNumStages != '\0'))
  {
    iVar5 = 0;
    do {
      if ((-1 < streamData->pStages[iVar5 >> 0x10].fWingman) ||
         (iVar10 = iVar10 + 1, -1 < streamData->pStages[iVar5 >> 0x10].fBlockadeCop)) {
        streamData->copCars[streamData->numCops] = tVar8;
        streamData->copCountry[streamData->numCops] = (ushort)streamData->playerCars[0].fCountry;
        streamData->numCops = streamData->numCops + 1;
        streamData->totalCars = streamData->totalCars + 2;
        return;
      }
      iVar5 = iVar10 * 0x10000;
    } while (iVar10 * 0x10000 >> 0x10 < (int)(uint)streamData->pMission->fNumStages);
  }
  return;
}



/* ---- Front_InitPerps  [FRONT.CPP:1702-1747] ---- */

/* Decoded Phase 83: Front_InitPerps(tFEStream&) - allocate Behind-The-Cop perp slots (456 B).
   
   [ghidra-meta] section: front.text */

void Front_InitPerps(tFEStream *streamData)

{
  byte bVar1;
  tCarInfo *ptVar2;
  int iVar3;
  int iVar4;
  void *pvVar5;
  short j;
  int iVar6;
  tCarInfo *carInfo;
  short i;
  short sVar7;
  tCarModels carModel;
  char carColor;
  
  streamData->numPerpObjects = 0;
  streamData->numPerps = 0;
  if (streamData->pMission != (tMissionInfo *)0x0) {
    for (sVar7 = 0; iVar6 = (int)sVar7, iVar6 < (int)(uint)streamData->pMission->fNumStages;
        sVar7 = sVar7 + 1) {
      bVar1 = streamData->pStages[iVar6].fCarModel;
      carModel = (tCarModels)bVar1;
      carColor = streamData->pStages[iVar6].fColor;
      ptVar2 = GetCarFromID(&carManager, (ushort)bVar1);
      iVar3 = 0;
      iVar6 = 0;
      do {
        iVar4 = iVar6 + 1;
        if ((int)ptVar2->fColorOrder[iVar3 >> 0x10] == (uint)(byte)carColor) break;
        iVar3 = iVar4 * 0x10000;
        iVar6 = iVar4;
      } while (iVar4 * 0x10000 >> 0x10 < 0x10);
      carColor = (char)iVar6;
      pvVar5 = IsCarAnAddedModel(&carManager, &carModel,&carColor);
      if (pvVar5 != (void *)0x1) {
        if (streamData->totalModels < 0x10) {
          streamData->totalModels = streamData->totalModels + 6;
        }
        AddCarToIngameList(&carManager, &carModel,&carColor);
        streamData->totalCars = streamData->totalCars + 2;
        streamData->perps[streamData->numPerpObjects].carModel = carModel;
        streamData->perps[streamData->numPerpObjects].carColor = streamData->pStages[sVar7].fColor;
        streamData->numPerpObjects = streamData->numPerpObjects + 1;
      }
      streamData->numPerps = streamData->numPerps + 1;
    }
  }
  return;
}



/* ---- Front_InitTrack  [FRONT.CPP:1754-1801] ---- */

/* Decoded Phase 83: Front_InitTrack(tFEStream&) - serialize selected track data (452 B). trackId +
   numLaps + Weather + timeOfDay + reverse.
   
   [ghidra-meta] section: front.text */

void Front_InitTrack(tFEStream *streamData)

{
  tTrackInformation *src;
  int iVar1;
  tTrackInfo *tournTrack;
  
  if (frontEnd.raceType == '\x02') {
    GetTrackToRace(&tournamentManager,&streamData->track);
    src = GetTrackByID(&trackManager,(short)(streamData->track).fTrackNumber);
    blockmove(src,&streamData->trackInfo,0x30);
  }
  else {
    GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
               &streamData->trackInfo);
    (streamData->track).fTrackNumber = (streamData->trackInfo).fTrackID;
    if ((frontEnd.carListType == '\x01') || (frontEnd.raceType == '\x01')) {
      (streamData->track).fDirection = frontEnd.trackdirection[(byte)frontEnd.pinkSlipsTrackIndex];
      (streamData->track).fMirrored = frontEnd.trackmirrored[(byte)frontEnd.pinkSlipsTrackIndex];
      (streamData->track).fTimeOfDay = frontEnd.timeOfDay[(byte)frontEnd.pinkSlipsTrackIndex];
      (streamData->track).fWeather = frontEnd.weather[(byte)frontEnd.pinkSlipsTrackIndex];
    }
    else {
      (streamData->track).fWeather = '\0';
      (streamData->track).fTimeOfDay = '\0';
      (streamData->track).fMirrored = '\0';
      (streamData->track).fDirection = '\0';
    }
    (streamData->track).fDifficulty = 0x10000;
  }
  if (1 < (streamData->track).fDirection) {
    iVar1 = rand();
    (streamData->track).fDirection = (byte)iVar1 & 1;
  }
  if (1 < (streamData->track).fMirrored) {
    iVar1 = rand();
    (streamData->track).fMirrored = (byte)iVar1 & 1;
  }
  if (1 < (streamData->track).fTimeOfDay) {
    iVar1 = rand();
    (streamData->track).fTimeOfDay = (byte)iVar1 & 1;
  }
  if (1 < (streamData->track).fWeather) {
    iVar1 = rand();
    (streamData->track).fWeather = (byte)iVar1 & 1;
  }
  return;
}



/* ---- Front_InitTraffic  [FRONT.CPP:1809-1879] ---- */

/* Decoded Phase 83: Front_InitTraffic(tFEStream&) - allocate traffic-car slots (568 B). Count from
   track BWorld + Weather (rain reduces traffic).
   
   [ghidra-meta] section: front.text */

void Front_InitTraffic(tFEStream *streamData)

{
  bool bVar1;
  byte bTraffic;
  short sVar2;
  int iVar3;
  void *pvVar4;
  int iVar5;
  short maxTraffic;
  short sVar6;
  short i;
  tCarModels carModel;
  char carColor;
  
  carColor = '\0';
  sVar6 = 6;
  if (frontEnd.gameMode == '\x01') {
    sVar6 = 3;
  }
  if ((frontEnd.raceType == '\x01') && (sVar6 = 2, (streamData->track).fTimeOfDay == '\x01')) {
    sVar6 = 1;
  }
  bVar1 = frontEnd.traffic[(byte)frontEnd.pinkSlipsTrackIndex] != '\0';
  if ((byte)frontEnd.raceType < 2) {
    if ((frontEnd.carListType == '\0') && (frontEnd.raceType == '\0')) {
      bVar1 = true;
    }
    else if (frontEnd.raceType == '\x01') {
      bVar1 = frontEnd.traffic[0] != '\0';
    }
    if (2 < (streamData->trackInfo).fTrackDifficulty) {
      bVar1 = false;
    }
    if ((streamData->trackInfo).fIsEgg != '\0') {
      bVar1 = false;
    }
    if (frontEnd.gameMode == '\x01') {
      if (frontEnd.raceType == '\x01') {
        bVar1 = false;
      }
    }
    else if (frontEnd.oppNumber == '\x02') {
      bVar1 = false;
    }
  }
  else if (frontEnd.raceType != '\x06') {
    bVar1 = false;
  }
  if ((bVar1) && (streamData->numTraffic = 0, sVar6 != 0)) {
    iVar3 = 0;
    do {
      iVar5 = iVar3 + 1;
      carModel = (tCarModels)(byte)(streamData->trackInfo).fTrafficCars[(short)iVar3];
      iVar3 = iVar5;
      if (5 < iVar5 * 0x10000 >> 0x10) {
        iVar3 = 0;
      }
      pvVar4 = IsCarAnAddedModel(&carManager, &carModel,&carColor);
      if (pvVar4 != (void *)0x1) {
        AddCarToIngameList(&carManager, &carModel,&carColor);
      }
      streamData->trafficCars[streamData->numTraffic] = (u_short)carModel;
      sVar2 = streamData->numTraffic + 1;
      streamData->numTraffic = sVar2;
    } while (sVar2 < sVar6);
  }
  return;
}



/* ---- Front_AppendPlayerCarData  [FRONT.CPP:1889-1963] ---- */

/* Decoded Phase 83: Front_AppendPlayerCarData(int* outStream, tFEStream&) - serialize player car
   data into stream (1252 B). Writes per-player: currentCar, position, fSimNumber, color (from
   carManager). Also handles 2-player split-screen with two adjacent records.
   
   [ghidra-meta] section: front.text */

int * Front_AppendPlayerCarData(int *stream,tFEStream *streamData)

{
  int iVar1;
  uint uVar2;
  short sVar3;
  tCarInfo *carInfo;
  tCarLineup *carLineup;
  short i;
  int iVar4;
  
  iVar4 = 0;
  if (0 < streamData->numPlayers) {
    do {
      *stream = 0x119;
      sVar3 = (short)iVar4;
      stream[1] = (int)streamData->currentCar;
      stream[2] = (int)streamData->carLineup[sVar3].position;
      stream[3] = 0x104;
      stream[4] = (int)streamData->currentCar;
      carInfo = streamData->playerCars + sVar3;
      stream[5] = (uint)carInfo->fSimNumber;
      stream[6] = 0x106;
      stream[7] = (int)streamData->currentCar;
      stream[8] = (uint)(byte)frontEnd.transmission[sVar3];
      stream[9] = 0x10a;
      stream[10] = (int)streamData->currentCar;
      stream[0xb] = (uint)carInfo->fColor;
      stream[0xc] = 0x10b;
      stream[0xd] = (int)streamData->currentCar;
      stream[0xe] = 0;
      stream[0xf] = 0x111;
      stream[0x10] = (int)streamData->currentCar;
      if (((frontEnd.ABS[sVar3] == '\0') || (carInfo->fABSAvailable == '\0')) &&
         (carInfo->fCarID != '\x1c')) {
        stream[0x11] = 0;
      }
      else {
        stream[0x11] = 1;
      }
      stream[0x12] = 0x115;
      stream[0x13] = (int)streamData->currentCar;
      if (((frontEnd.ABS[sVar3] == '\0') || (carInfo->fTractionAvailable == '\0')) &&
         (carInfo->fCarID != '\x1c')) {
        stream[0x14] = 0;
      }
      else {
        stream[0x14] = 1;
      }
      stream[0x15] = 0x110;
      stream[0x16] = (int)streamData->currentCar;
      stream[0x17] = (byte)streamData->carLineup[sVar3].carUpgrades >> 2 & 1;
      stream[0x18] = 0x112;
      stream[0x19] = (int)streamData->currentCar;
      stream[0x1a] = (byte)streamData->carLineup[sVar3].carUpgrades >> 1 & 1;
      stream[0x1b] = 0x10d;
      stream[0x1c] = (int)streamData->currentCar;
      stream[0x1d] = (byte)streamData->carLineup[sVar3].carUpgrades & 1;
      stream[0x1e] = 0x10c;
      stream[0x1f] = (int)streamData->currentCar;
      stream[0x20] = 0;
      stream[0x21] = 0x122;
      stream[0x22] = (int)streamData->currentCar;
      stream[0x23] = (uint)*(byte *)((int)carInfo->fColorList + (uint)carInfo->fColor * 4 + 2) |
                    carInfo->fColorList[carInfo->fColor] & 0xff00 |
                    (carInfo->fColorList[carInfo->fColor] & 0xff) << 0x10;
      stream[0x24] = 0x123;
      stream[0x25] = (int)streamData->currentCar;
      stream[0x26] = carInfo->fHudColor[(streamData->track).fTimeOfDay];
      stream[0x27] = 0x124;
      stream[0x28] = (int)streamData->currentCar;
      stream[0x29] = (uint)carInfo->fSpeechColors[carInfo->fColor];
      stream[0x2a] = 0x125;
      stream[0x2b] = (int)streamData->currentCar;
      stream[0x2c] = (uint)carInfo->fCountry;
      if (carInfo->fCarClass == '\a') {
        stream[0x2d] = 0x105;
        stream[0x2e] = (int)streamData->currentCar;
        iVar1 = 0x41;
      }
      else {
        stream[0x2d] = 0x105;
        stream[0x2e] = (int)streamData->currentCar;
        iVar1 = 1;
      }
      stream[0x2f] = iVar1;
      stream[0x30] = 0x113;
      stream[0x31] = (int)streamData->currentCar;
      if ((carInfo->fUpgrades & 2) == 0) {
        uVar2 = (uint)carInfo->fDefaultTires;
      }
      else {
        uVar2 = 2;
      }
      stream[0x32] = uVar2;
      stream[0x33] = 0x107;
      iVar1 = (int)sVar3;
      stream[0x34] = (int)streamData->currentCar;
      stream[0x35] = (uint)(byte)frontEnd.rampSteer[iVar1];
      stream[0x36] = 0x108;
      stream[0x37] = (int)streamData->currentCar;
      stream[0x38] = (uint)(byte)frontEnd.rampGas[iVar1];
      stream[0x39] = 0x109;
      stream[0x3a] = (int)streamData->currentCar;
      stream[0x3b] = (uint)(byte)frontEnd.rampBrake[iVar1];
      stream = OutputDisplaySettings(stream + 0x3c,(int)streamData->currentCar,iVar1,&streamData->trackInfo);
      iVar4 = iVar4 + 1;
      streamData->currentCar = streamData->currentCar + 1;
    } while (iVar4 * 0x10000 >> 0x10 < (int)streamData->numPlayers);
  }
  *stream = 0x1d;
  stream[1] = (int)streamData->numPlayers;
  stream[2] = 0x1e;
  stream[3] = (int)streamData->numOpponents;
  stream[4] = 0xe;
  stream[5] = 0;
  return stream + 6;
}



/* ---- Front_AppendOpponentData  [FRONT.CPP:1968-1998] ---- */

/* Decoded Phase 83: Front_AppendOpponentData(int*, tFEStream&) - serialize opponent cars into
   stream (820 B). Each opponent: carID + personality + skill + color + grid position.
   
   [ghidra-meta] section: front.text */

int * Front_AppendOpponentData(int *stream,tFEStream *streamData)

{
  byte bVar1;
  tCarInfo *carInfo;
  int iVar2;
  tCarInfo *ptVar3;
  tCarLineup *carLineup;
  short i;
  int iVar4;
  
  iVar4 = 0;
  if (0 < streamData->numOpponents) {
    do {
      iVar2 = (int)(short)iVar4 + (int)streamData->numPlayers;
      ptVar3 = GetCarFromID(&carManager, (short)streamData->carLineup[iVar2].carModel);
      *stream = 0x119;
      stream[1] = (int)streamData->currentCar;
      stream[2] = (int)streamData->carLineup[iVar2].position;
      stream[3] = 0x104;
      stream[4] = (int)streamData->currentCar;
      stream[5] = (uint)ptVar3->fSimNumber;
      stream[6] = 0x106;
      stream[7] = (int)streamData->currentCar;
      stream[8] = 1;
      stream[9] = 0x105;
      stream[10] = (int)streamData->currentCar;
      stream[0xb] = 2;
      stream[0xc] = 0x114;
      stream[0xd] = (int)streamData->currentCar;
      stream[0xe] = streamData->carLineup[iVar2].personality;
      stream[0xf] = 0x118;
      stream[0x10] = (int)streamData->currentCar;
      stream[0x11] = streamData->carLineup[iVar2].personality;
      stream[0x12] = 0x10a;
      stream[0x13] = (int)streamData->currentCar;
      stream[0x14] = (uint)(byte)streamData->carLineup[iVar2].carColor;
      stream[0x15] = 0x10b;
      stream[0x16] = (int)streamData->currentCar;
      stream[0x17] = 0;
      stream[0x18] = 0x110;
      stream[0x19] = (int)streamData->currentCar;
      stream[0x1a] = (byte)streamData->carLineup[iVar2].carUpgrades & 1;
      stream[0x1b] = 0x112;
      stream[0x1c] = (int)streamData->currentCar;
      stream[0x1d] = (byte)streamData->carLineup[iVar2].carUpgrades >> 1 & 1;
      stream[0x1e] = 0x10d;
      stream[0x1f] = (int)streamData->currentCar;
      stream[0x20] = (byte)streamData->carLineup[iVar2].carUpgrades >> 2 & 1;
      stream[0x21] = 0x10c;
      stream[0x22] = (int)streamData->currentCar;
      stream[0x23] = 0;
      stream[0x24] = 0x125;
      stream[0x25] = (int)streamData->currentCar;
      stream[0x26] = 0;
      stream[0x27] = 0x122;
      stream[0x28] = (int)streamData->currentCar;
      bVar1 = streamData->carLineup[iVar2].carColor;
      stream[0x29] = (uint)*(byte *)((int)ptVar3->fColorList + (uint)bVar1 * 4 + 2) |
                     ptVar3->fColorList[bVar1] & 0xff00 | (ptVar3->fColorList[bVar1] & 0xff) << 0x10
      ;
      stream[0x2a] = 0x123;
      stream[0x2b] = (int)streamData->currentCar;
      stream[0x2c] = ptVar3->fHudColor[(streamData->track).fTimeOfDay];
      stream[0x2d] = 0x124;
      stream[0x2e] = (int)streamData->currentCar;
      iVar4 = iVar4 + 1;
      stream[0x2f] = (uint)ptVar3->fSpeechColors[(byte)streamData->carLineup[iVar2].carColor];
      streamData->currentCar = streamData->currentCar + 1;
      stream = stream + 0x30;
    } while (iVar4 * 0x10000 >> 0x10 < (int)streamData->numOpponents);
  }
  return stream;
}



/* ---- Front_AppendCopData  [FRONT.CPP:2003-2035] ---- */

/* Decoded Phase 83: Front_AppendCopData(int*, tFEStream&) - serialize cop data (596 B). Per-cop:
   carID + chase-strategy + initial slice.
   
   [ghidra-meta] section: front.text */

int * Front_AppendCopData(int *stream,tFEStream *streamData)

{
  tCarInfo *ptVar1;
  int iVar2;
  int iVar3;
  short i;
  short sVar4;
  
  if (0 < (int)streamData->numCops + (int)streamData->numSuperCops) {
    *stream = 0xc;
    stream[1] = 1;
    stream = stream + 2;
  }
  for (sVar4 = 0; iVar3 = (int)sVar4,
      iVar3 < (int)streamData->numCops + (int)streamData->numSuperCops; sVar4 = sVar4 + 1) {
    ptVar1 = GetCarFromID(&carManager, (short)streamData->copCars[iVar3]);
    *stream = 0x104;
    iVar2 = 8;
    stream[1] = (int)streamData->currentCar;
    stream[2] = (uint)ptVar1->fSimNumber;
    stream[3] = 0x106;
    stream[4] = (int)streamData->currentCar;
    stream[5] = 1;
    stream[6] = 0x105;
    stream[7] = (int)streamData->currentCar;
    if (iVar3 < streamData->numSuperCops) {
      iVar2 = 0x10;
    }
    stream[8] = iVar2;
    stream[9] = 0x118;
    stream[10] = (int)streamData->currentCar;
    stream[0xb] = (byte)frontEnd.skillLevel + 5;
    stream[0xc] = 0x10a;
    stream[0xd] = (int)streamData->currentCar;
    stream[0xe] = 0;
    stream[0xf] = 0x10b;
    stream[0x10] = (int)streamData->currentCar;
    stream[0x11] = 0;
    stream[0x12] = 0x10c;
    stream[0x13] = (int)streamData->currentCar;
    stream[0x14] = 0;
    stream[0x15] = 0x125;
    stream[0x16] = (int)streamData->currentCar;
    stream[0x17] = (int)streamData->copCountry[iVar3];
    stream[0x18] = 0x110;
    stream[0x19] = (int)streamData->currentCar;
    stream[0x1a] = 0;
    stream[0x1b] = 0x112;
    stream[0x1c] = (int)streamData->currentCar;
    stream[0x1d] = 0;
    stream[0x1e] = 0x10d;
    stream[0x1f] = (int)streamData->currentCar;
    stream[0x20] = 0;
    stream = stream + 0x21;
    streamData->currentCar = streamData->currentCar + 1;
  }
  return stream;
}



/* ---- Front_AppendPerpData  [FRONT.CPP:2040-2076] ---- */

/* Decoded Phase 83: Front_AppendPerpData(int*, tFEStream&) - serialize perp (Behind-The-Cop chase
   target) data (664 B). Writes per-perp carID + escape route + initial speed.
   
   [ghidra-meta] section: front.text */

int * Front_AppendPerpData(int *stream,tFEStream *streamData)

{
  tCarInfo *ptVar1;
  int iVar2;
  int *piVar3;
  short i;
  int iVar4;
  
  if (streamData->pMission == (tMissionInfo *)0x0) {
    *stream = 0x25;
    stream[1] = 0;
    stream[2] = 0x26;
    stream[3] = 0;
  }
  else {
    *stream = 0x25;
    stream[1] = (uint)streamData->pMission->fNumStages;
    stream[2] = 0x26;
    stream[3] = (uint)streamData->pMission->fStageOffset;
  }
  piVar3 = stream + 4;
  iVar4 = 0;
  if (0 < streamData->numPerpObjects) {
    do {
      iVar2 = (iVar4 << 0x10) >> 0xd;
      ptVar1 = GetCarFromID(&carManager, *(short *)((int)&streamData->perps[0].carModel + iVar2));
      *piVar3 = 0x104;
      iVar4 = iVar4 + 1;
      piVar3[1] = (int)streamData->currentCar;
      piVar3[2] = (uint)ptVar1->fSimNumber;
      piVar3[3] = 0x106;
      piVar3[4] = (int)streamData->currentCar;
      piVar3[5] = 1;
      piVar3[6] = 0x10a;
      piVar3[7] = (int)streamData->currentCar;
      piVar3[8] = (uint)(byte)(&streamData->perps[0].carColor)[iVar2];
      piVar3[9] = 0x10b;
      piVar3[10] = (int)streamData->currentCar;
      piVar3[0xb] = 0;
      piVar3[0xc] = 0x105;
      piVar3[0xd] = (int)streamData->currentCar;
      piVar3[0xe] = 2;
      piVar3[0xf] = 0x118;
      piVar3[0x10] = (int)streamData->currentCar;
      piVar3[0x11] = 0;
      piVar3[0x12] = 0x10c;
      piVar3[0x13] = (int)streamData->currentCar;
      piVar3[0x14] = 1;
      piVar3[0x15] = 0x125;
      piVar3[0x16] = (int)streamData->currentCar;
      piVar3[0x17] = 0;
      piVar3[0x18] = 0x110;
      piVar3[0x19] = (int)streamData->currentCar;
      piVar3[0x1a] = 0;
      piVar3[0x1b] = 0x112;
      piVar3[0x1c] = (int)streamData->currentCar;
      piVar3[0x1d] = 0;
      piVar3[0x1e] = 0x10d;
      piVar3[0x1f] = (int)streamData->currentCar;
      piVar3[0x20] = 0;
      streamData->currentCar = streamData->currentCar + 1;
      piVar3 = piVar3 + 0x21;
    } while (iVar4 * 0x10000 >> 0x10 < (int)streamData->numPerpObjects);
  }
  *piVar3 = 0x25;
  piVar3[1] = (int)streamData->numPerps;
  return piVar3 + 2;
}



/* ---- Front_AppendTrafficData  [FRONT.CPP:2081-2109] ---- */

/* Decoded Phase 83: Front_AppendTrafficData(int*, tFEStream&) - serialize traffic cars (592 B).Type + density + spawn-rate from track tuning.
   
   [ghidra-meta] section: front.text */

int * Front_AppendTrafficData(int *stream,tFEStream *streamData)

{
  tCarInfo *ptVar1;
  int density;
  short i;
  int iVar2;
  
  iVar2 = 0;
  if (0 < streamData->numTraffic) {
    do {
      ptVar1 = GetCarFromID(&carManager, *(short *)((int)streamData->trafficCars + ((iVar2 << 0x10) >> 0xf)));
      *stream = 0x104;
      iVar2 = iVar2 + 1;
      stream[1] = (int)streamData->currentCar;
      stream[2] = (uint)ptVar1->fSimNumber;
      stream[3] = 0x106;
      stream[4] = (int)streamData->currentCar;
      stream[5] = 1;
      stream[6] = 0x10a;
      stream[7] = (int)streamData->currentCar;
      stream[8] = 0;
      stream[9] = 0x10b;
      stream[10] = (int)streamData->currentCar;
      stream[0xb] = 0;
      stream[0xc] = 0x105;
      stream[0xd] = (int)streamData->currentCar;
      stream[0xe] = 4;
      stream[0xf] = 0x118;
      stream[0x10] = (int)streamData->currentCar;
      stream[0x11] = 8;
      stream[0x12] = 0x10c;
      stream[0x13] = (int)streamData->currentCar;
      stream[0x14] = 1;
      stream[0x15] = 0x125;
      stream[0x16] = (int)streamData->currentCar;
      stream[0x17] = 0;
      stream[0x18] = 0x110;
      stream[0x19] = (int)streamData->currentCar;
      stream[0x1a] = 0;
      stream[0x1b] = 0x112;
      stream[0x1c] = (int)streamData->currentCar;
      stream[0x1d] = 0;
      stream[0x1e] = 0x10d;
      stream[0x1f] = (int)streamData->currentCar;
      stream[0x20] = 0;
      streamData->currentCar = streamData->currentCar + 1;
      stream = stream + 0x21;
    } while (iVar2 * 0x10000 >> 0x10 < (int)streamData->numTraffic);
  }
  iVar2 = (int)streamData->numTraffic / 3;
  if ((0 < streamData->numTraffic) && (iVar2 < 1)) {
    iVar2 = 1;
  }
  *stream = 0xd;
  stream[1] = iVar2;
  return stream + 2;
}



/* ---- Front_AppendTrackData  [FRONT.CPP:2114-2146] ---- */

/* Decoded Phase 83: Front_AppendTrackData(int*, tFEStream&) - serialize track data (320 B).
   
   [ghidra-meta] section: front.text */

int * Front_AppendTrackData(int *stream,tFEStream *streamData)

{
  int valtopass;
  int iVar1;
  tTrackInformation trackInfo;
  
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
             &trackInfo);
  iVar1 = 0;
  if (frontEnd.displaySpeed[0] != '\x01') {
    if (((byte)frontEnd.displaySpeed[0] < 2) || (frontEnd.displaySpeed[0] != '\x02')) {
      iVar1 = (int)CountryMeasurement[trackInfo.fSpeedoCountry];
    }
    else {
      iVar1 = 1;
    }
  }
  *stream = 0x1a;
  stream[1] = iVar1;
  stream[2] = 0x18;
  stream[3] = (uint)(streamData->track).fMirrored;
  stream[4] = 0x19;
  stream[5] = (uint)(streamData->track).fDirection;
  stream[6] = 0x14;
  stream[7] = (uint)(streamData->track).fWeather;
  stream[8] = 0x17;
  stream[9] = (uint)(streamData->track).fTimeOfDay;
  stream[10] = 0x12;
  stream[0xb] = (uint)(streamData->trackInfo).fSimNumber;
  stream[0xc] = 0xb;
  stream[0xd] = (streamData->track).fDifficulty;
  return stream + 0xe;
}



/* ---- Front_EnableLocalSpeech  [FRONT.CPP:2269-2290] ---- */

/* FE-side hook to enable speech for the local player. 2 FE callers.Sets up gSpeech->speechEnabled flag and routes audio for the player
   channel.Decoded Phase 49.
   
   [ghidra-meta] section: front.text
   
   [Locals 2026-05-08] Locals renamed via deep-body inspection. FE local-speech-enable test. Returns
   1 if pinkslip-mode (raceType==1) AND track's language differs from current AND track lang in {<3,
   6}. Conditions: ret=0 default; if raceType==1: GetTrack populates trackInfo; check lang!=current
   AND (lang<3 OR lang==6) - then ret=1. Used by Front_BuildStream to switch speech-bank for race
   intros (e.g., German driver on French track plays the host's local language). result is
   caller-side spill. */

void * Front_EnableLocalSpeech(void)

{
  byte result;
  void *ret;
  tTrackInformation trackInfo;
  
  ret = (void *)0x0;
  if (frontEnd.raceType == '\x01') {
    GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
               &trackInfo);
    ret = (void *)0x0;
    if ((trackInfo.fLanguage != frontEnd.language) &&
       (((byte)trackInfo.fLanguage < 3 || (ret = (void *)0x0, trackInfo.fLanguage == '\x06')))) {
      ret = (void *)0x1;
    }
  }
  return ret;
}



/* ---- Front_BuildStream  [FRONT.CPP:2299-2722] ---- */

/* Decoded Phase 83: Front_BuildStream(int* outStream) - build complete tFEStream race-setup blob(4000 B - biggest Front fn). Composes player cars + opponent cars + cops + traffic + perps +
   missions + track data + tourney traffic into a single contiguous int-stream buffer that gets
   passed to GameSetup at race transition. Calls Front_InitStream + all Init*+Append* sub-builders
   in order. Drives entire game-->race handoff.
   
   [ghidra-meta] section: front.text */

int * Front_BuildStream(int *stream)

{
  void *pvVar1;
  int *piVar2;
  int colourLoop;
  int j, type;
  int iVar3;
  uint uVar4;
  tfrontEnd *ptVar5;
  uint uVar6;
  int numplaylistsongs;
  int iVar7;
  int *d;
  uint *puVar8;
  int *piVar9;
  int trackLang;
  int gameLang;
  int config;
  tFEStream streamData;
  
  Front_InitStream(&streamData);
  Front_InitPlayerCars(&streamData);
  Front_InitTrack(&streamData);
  Front_InitTourneyTraffic(&streamData);
  Front_InitOpponentCars(&streamData);
  Front_InitMissions(&streamData);
  Front_InitCopCars(&streamData);
  Front_InitPerps(&streamData);
  Front_InitTraffic(&streamData);
  frontEnd.randomSeed = (short)ticks;
  seedrandom((int)frontEnd.randomSeed);
  iVar3 = 7;
  piVar2 = colourChosen + 7;
  do {
    *piVar2 = 0;
    iVar3 = iVar3 + -1;
    piVar2 = piVar2 + -1;
  } while (-1 < iVar3);
  Controller_SetRamp();
  resizememadr(stream,0x10000);
  *stream = 0x34;
  uVar4 = (uint)(byte)frontEnd.controlConfig[0];
  stream[2] = 0x35;
  stream[1] = uVar4;
  uVar4 = (uint)(byte)frontEnd.deadSpot[0];
  stream[4] = 0x36;
  stream[3] = uVar4;
  uVar4 = (uint)(byte)frontEnd.steeringRange[0];
  stream[6] = 0x37;
  stream[5] = uVar4;
  uVar4 = (uint)(byte)frontEnd.IImaxRange[0];
  stream[8] = 0x38;
  stream[7] = uVar4;
  uVar4 = (uint)(byte)frontEnd.ImaxRange[0];
  stream[10] = 0x39;
  stream[9] = uVar4;
  uVar4 = (uint)(byte)frontEnd.J1MAX[0];
  stream[0xc] = 0x3a;
  stream[0xb] = uVar4;
  uVar4 = (uint)(byte)frontEnd.J1MIN[0];
  stream[0xe] = 0x3b;
  stream[0xd] = uVar4;
  uVar4 = (uint)(byte)frontEnd.J2MAX[0];
  stream[0x10] = 0x3c;
  stream[0xf] = uVar4;
  uVar4 = (uint)(byte)frontEnd.J2MIN[0];
  stream[0x12] = 0x3d;
  stream[0x11] = uVar4;
  uVar4 = (uint)(byte)frontEnd.shockMode[0];
  stream[0x14] = 0x3e;
  stream[0x13] = uVar4;
  stream[0x15] = (uint)(byte)frontEnd.shockImpact[0];
  stream[0x16] = 0x3f;
  uVar4 = (uint)(byte)frontEnd.controlConfig[1];
  stream[0x18] = 0x40;
  stream[0x17] = uVar4;
  uVar4 = (uint)(byte)frontEnd.deadSpot[1];
  stream[0x1a] = 0x41;
  stream[0x19] = uVar4;
  uVar4 = (uint)(byte)frontEnd.steeringRange[1];
  stream[0x1c] = 0x42;
  stream[0x1b] = uVar4;
  uVar4 = (uint)(byte)frontEnd.IImaxRange[1];
  stream[0x1e] = 0x43;
  stream[0x1d] = uVar4;
  uVar4 = (uint)(byte)frontEnd.ImaxRange[1];
  stream[0x20] = 0x44;
  stream[0x1f] = uVar4;
  uVar4 = (uint)(byte)frontEnd.J1MAX[1];
  stream[0x22] = 0x45;
  stream[0x21] = uVar4;
  uVar4 = (uint)(byte)frontEnd.J1MIN[1];
  stream[0x24] = 0x46;
  stream[0x23] = uVar4;
  uVar4 = (uint)(byte)frontEnd.J2MAX[1];
  stream[0x26] = 0x47;
  stream[0x25] = uVar4;
  uVar4 = (uint)(byte)frontEnd.J2MIN[1];
  stream[0x28] = 0x48;
  stream[0x27] = uVar4;
  uVar4 = (uint)(byte)frontEnd.shockMode[1];
  stream[0x2a] = 0x49;
  stream[0x29] = uVar4;
  uVar4 = (uint)(byte)frontEnd.shockImpact[1];
  stream[0x2c] = 0x21;
  stream[0x2b] = uVar4;
  stream[0x2d] = -1;
  stream[0x2e] = 3;
  stream[0x2f] = 1;
  stream[0x30] = 0x1b;
  iVar3 = (int)frontEnd.randomSeed;
  stream[0x32] = 0x4a;
  stream[0x33] = 0;
  stream[0x34] = 0x24;
  stream[0x31] = iVar3;
  uVar4 = (uint)(byte)frontEnd.language;
  if ((frontEnd.localSpeech == '\0') ||
     (pvVar1 = Front_EnableLocalSpeech(), pvVar1 == (void *)0x0)) {
    stream[0x35] = uVar4;
  }
  else {
    stream[0x35] = (uint)(byte)streamData.trackInfo.fLanguage;
  }
  stream[0x36] = 0x27;
  stream[0x37] = (uint)(byte)frontEnd.language;
  stream[0x38] = 0x28;
  stream[0x39] = (uint)(byte)frontEnd.measurement;
  stream[0x3a] = 0x11;
  stream[0x3b] = 0;
  stream[0x3c] = 9;
  stream[0x3d] = (uint)(byte)frontEnd.skillLevel;
  stream[0x3e] = 10;
  stream[0x3f] = (uint)(byte)frontEnd.gameMode;
  stream[0x40] = 7;
  stream[0x41] = (uint)(byte)frontEnd.raceType;
  stream[0x42] = 0x115;
  stream[0x43] = 0;
  stream[0x44] = 0;
  stream[0x45] = 0x117;
  stream[0x46] = 0;
  stream[0x47] = 0;
  stream[0x48] = 0xf;
  stream[0x49] = (uint)(byte)frontEnd.catchup;
  piVar2 = Front_AppendTrackData(stream + 0x4a,&streamData);
  *piVar2 = 0x13;
  piVar2[1] = (uint)(byte)frontEnd.song;
  piVar2[2] = 0x2a;
  piVar2[3] = (uint)(byte)frontEnd.audioMode;
  piVar2[4] = 0x2b;
  piVar2[5] = (uint)(byte)frontEnd.musicVolume;
  piVar2[6] = 0x2c;
  piVar2[7] = (uint)(byte)frontEnd.sfxVolume;
  piVar2[8] = 0x2d;
  piVar2[9] = (uint)(byte)frontEnd.engineVolume;
  piVar2[10] = 0x2e;
  piVar2[0xb] = (uint)(byte)frontEnd.narrationVolume;
  piVar2[0xc] = 0x2f;
  piVar2[0xd] = (uint)(byte)frontEnd.ambientVolume;
  piVar2[0xe] = 0x16;
  puVar8 = (uint *)(piVar2 + 0xf);
  if (streamData.playerCars[0].fCarID == '\x1c') {
    *puVar8 = 0;
  }
  else if (frontEnd.raceType == '\x02') {
    *puVar8 = 1;
  }
  else {
    *puVar8 = (uint)(byte)frontEnd.damage;
  }
  iVar7 = 0;
  iVar3 = 0;
  ptVar5 = &frontEnd;
  do {
    if (ptVar5->FEPlayList[0] != 0) {
      iVar7 = iVar7 + 1;
    }
    iVar3 = iVar3 + 1;
    ptVar5 = (tfrontEnd *)&ptVar5->raceType;
  } while (iVar3 < 0x28);
  piVar2[0x10] = 0x30;
  piVar2[0x11] = iVar7;
  piVar2[0x12] = 0x4c;
  piVar2[0x13] = iVar7;
  piVar2 = piVar2 + 0x14;
  iVar3 = 0;
  ptVar5 = &frontEnd;
  do {
    if (ptVar5->FEPlayList[0] != 0) {
      *piVar2 = iVar3;
      piVar2 = piVar2 + 1;
    }
    iVar3 = iVar3 + 1;
    ptVar5 = (tfrontEnd *)&ptVar5->raceType;
  } while (iVar3 < 0x28);
  *piVar2 = 0x29;
  iVar3 = Stattool_ReturnRecordLapTime((short)streamData.track.fTrackNumber);
  piVar2[1] = iVar3;
  piVar2[2] = 8;
  if ((frontEnd.raceType != '\0') || (iVar3 = 1, frontEnd.carListType != '\0')) {
    iVar3 = Front_GetLapsForType();
  }
  piVar2[3] = iVar3;
  if (((streamData.playerCars[0].fCarClass == '\a') || (streamData.playerCars[1].fCarClass == '\a'))
     || ((frontEnd.raceType == '\0' && ((frontEnd.oppNumber == '\0' && (frontEnd.gameMode == '\0')))
         ))) {
    piVar2[4] = 0x20;
    piVar2[5] = 0;
    piVar2[6] = 0x32;
    piVar2[7] = 0;
    piVar2[8] = 0x33;
    piVar2[9] = 0;
  }
  else {
    piVar2[4] = 0x20;
    piVar2[5] = (uint)(byte)frontEnd.checkPointType;
    piVar2[6] = 0x32;
    if (frontEnd.checkPointDisplay[0] == '\x01') {
      iVar3 = 2;
      if (CountryMeasurement[streamData.trackInfo.fSpeedoCountry] != 0) {
        iVar3 = 1;
      }
    }
    else {
      iVar3 = 0;
    }
    piVar2[7] = iVar3;
    piVar2[8] = 0x33;
    if (frontEnd.checkPointDisplay[1] == '\x01') {
      iVar3 = 2;
      if (CountryMeasurement[streamData.trackInfo.fSpeedoCountry] != 0) {
        iVar3 = 1;
      }
    }
    else {
      iVar3 = 0;
    }
    piVar2[9] = iVar3;
  }
  piVar2 = Front_AppendPlayerCarData(piVar2,&streamData);
  piVar2 = Front_AppendOpponentData(piVar2,&streamData);
  piVar2 = Front_AppendPerpData(piVar2,&streamData);
  piVar2 = Front_AppendCopData(piVar2,&streamData);
  piVar2 = Front_AppendTrafficData(piVar2,&streamData);
  *piVar2 = 0x1c;
  piVar2[1] = (int)streamData.numPlayers + (int)streamData.numOpponents + (int)streamData.numCops +
              (int)streamData.numSuperCops + (int)streamData.numPerpObjects +
              (int)streamData.numTraffic;
  piVar2[2] = 0xe5;
  iVar3 = GetPSXPadValue(1,0);
  piVar2[3] = iVar3;
  piVar2[4] = 0xeb;
  iVar3 = GetPSXPadValue(8,0);
  piVar2[5] = iVar3;
  piVar2[6] = 0xe8;
  iVar3 = GetPSXPadValue(0x80,0);
  piVar2[7] = iVar3;
  piVar2[8] = 0xe9;
  iVar3 = GetPSXPadValue(0x20,0);
  piVar2[9] = iVar3;
  piVar2[10] = 0xe6;
  iVar3 = GetPSXPadValue(0x10,0);
  piVar2[0xb] = iVar3;
  piVar2[0xc] = 0xe7;
  iVar3 = GetPSXPadValue(0x40,0);
  piVar2[0xd] = iVar3;
  piVar2[0xe] = 0xea;
  iVar3 = GetPSXPadValue(0x4000,0);
  piVar2[0xf] = iVar3;
  uVar4 = (uint)(byte)frontEnd.controlConfig[0];
  if (frontEnd.controlType[0] == 0x23) {
    iVar3 = 0;
  }
  else if ((frontEnd.controlType[0] == 0x53) || (iVar3 = 2, frontEnd.controlType[0] == 0x73)) {
    iVar3 = 1;
  }
  piVar2[0x10] = 0x4f;
  iVar7 = GetPSXPadValue(mappings[uVar4][0][iVar3],0);
  piVar2[0x11] = iVar7;
  piVar2[0x12] = 0x50;
  iVar7 = GetPSXPadValue(mappings[uVar4][1][iVar3],0);
  piVar2[0x13] = iVar7;
  piVar2[0x14] = 0x51;
  iVar7 = GetPSXPadValue(mappings[uVar4][2][iVar3],0);
  piVar2[0x15] = iVar7;
  piVar2[0x16] = 0x52;
  iVar7 = GetPSXPadValue(mappings[uVar4][3][iVar3],0);
  piVar2[0x17] = iVar7;
  piVar2[0x18] = 0xfb;
  iVar7 = GetPSXPadValue(mappings[uVar4][8][iVar3],0);
  piVar2[0x19] = iVar7;
  piVar2[0x1a] = 0x53;
  iVar7 = GetPSXPadValue(mappings[uVar4][4][iVar3],0);
  piVar2[0x1b] = iVar7;
  piVar2[0x1c] = 0x66;
  iVar7 = GetPSXPadValue(mappings[uVar4][5][iVar3],0);
  piVar2[0x1d] = iVar7;
  piVar2[0x1e] = 0x67;
  iVar7 = GetPSXPadValue(mappings[uVar4][6][iVar3],0);
  piVar2[0x1f] = iVar7;
  piVar2[0x20] = 0x68;
  iVar7 = GetPSXPadValue(mappings[uVar4][0xc][iVar3],0);
  piVar2[0x21] = iVar7;
  if (streamData.track.fTimeOfDay == '\0') {
    piVar2[0x22] = 0x73;
    piVar2[0x23] = 0;
    piVar2[0x24] = 0x54;
    uVar6 = mappings[uVar4][9][iVar3];
    if (iVar3 == 1) {
      uVar6 = uVar6 | 6;
    }
  }
  else {
    piVar2[0x22] = 0x73;
    iVar7 = GetPSXPadValue(mappings[uVar4][9][iVar3],0);
    piVar2[0x23] = iVar7;
    piVar2[0x24] = 0x54;
    uVar6 = 0;
    if (iVar3 == 1) {
      uVar6 = 6;
    }
  }
  iVar7 = GetPSXPadValue(uVar6,0);
  piVar2[0x25] = iVar7;
  piVar2[0x26] = 0x4d;
  iVar7 = GetPSXPadValue(mappings[uVar4][0xb][iVar3],0);
  piVar2[0x27] = iVar7;
  piVar2[0x28] = 0x75;
  iVar7 = GetPSXPadValue(mappings[uVar4][7][iVar3],0);
  piVar2[0x29] = iVar7;
  piVar2[0x2a] = 0x65;
  iVar7 = GetPSXPadValue(mappings[uVar4][7][iVar3],0);
  piVar2[0x2b] = iVar7;
  piVar2[0x2c] = 0x85;
  iVar7 = GetPSXPadValue(0x800,0);
  piVar2[0x2d] = iVar7;
  piVar9 = piVar2 + 0x2e;
  if (streamData.playerCars[0].fCarClass == '\a') {
    if (frontEnd.gameMode != '\x01') {
      *piVar9 = 0x7a;
      iVar7 = GetPSXPadValue(0x8000,0);
      piVar2[0x2f] = iVar7;
      piVar2[0x30] = 0x7b;
      iVar7 = GetPSXPadValue(0x2000,0);
      piVar2[0x31] = iVar7;
      piVar2[0x32] = 0x7c;
      iVar7 = GetPSXPadValue(0x1000,0);
      piVar2[0x33] = iVar7;
      piVar9 = piVar2 + 0x34;
    }
    *piVar9 = 0x81;
    uVar4 = mappings[uVar4][10][iVar3];
    piVar9 = piVar9 + 1;
    if (iVar3 == 1) {
      uVar4 = uVar4 | 6;
    }
  }
  else {
    *piVar9 = 0x82;
    uVar6 = mappings[uVar4][10][iVar3];
    if (iVar3 == 1) {
      uVar6 = uVar6 | 6;
    }
    iVar7 = GetPSXPadValue(uVar6,0);
    piVar2[0x2f] = iVar7;
    piVar2[0x30] = 0x7d;
    iVar7 = GetPSXPadValue(mappings[uVar4][0][iVar3],0);
    piVar2[0x31] = iVar7;
    piVar2[0x32] = 0x7e;
    iVar3 = GetPSXPadValue(mappings[uVar4][1][iVar3],0);
    piVar2[0x33] = iVar3;
    piVar2[0x34] = 0x81;
    piVar9 = piVar2 + 0x35;
    uVar4 = 0x40;
  }
  iVar3 = GetPSXPadValue(uVar4,0);
  *piVar9 = iVar3;
  piVar2 = piVar9 + 1;
  if (frontEnd.gameMode == '\x01') {
    uVar4 = (uint)(byte)frontEnd.controlConfig[1];
    if (frontEnd.controlType[1] == 0x23) {
      iVar3 = 0;
    }
    else if ((frontEnd.controlType[1] == 0x53) || (iVar3 = 2, frontEnd.controlType[1] == 0x73)) {
      iVar3 = 1;
    }
    *piVar2 = 0x9b;
    iVar7 = GetPSXPadValue(mappings[uVar4][0][iVar3],1);
    piVar9[2] = iVar7;
    piVar9[3] = 0x9c;
    iVar7 = GetPSXPadValue(mappings[uVar4][1][iVar3],1);
    piVar9[4] = iVar7;
    piVar9[5] = 0x9d;
    iVar7 = GetPSXPadValue(mappings[uVar4][2][iVar3],1);
    piVar9[6] = iVar7;
    piVar9[7] = 0x9e;
    iVar7 = GetPSXPadValue(mappings[uVar4][3][iVar3],1);
    piVar9[8] = iVar7;
    piVar9[9] = 0xfc;
    iVar7 = GetPSXPadValue(mappings[uVar4][8][iVar3],1);
    piVar9[10] = iVar7;
    piVar9[0xb] = 0x9f;
    iVar7 = GetPSXPadValue(mappings[uVar4][4][iVar3],1);
    piVar9[0xc] = iVar7;
    piVar9[0xd] = 0xb2;
    iVar7 = GetPSXPadValue(mappings[uVar4][5][iVar3],1);
    piVar9[0xe] = iVar7;
    piVar9[0xf] = 0xb3;
    iVar7 = GetPSXPadValue(mappings[uVar4][6][iVar3],1);
    piVar9[0x10] = iVar7;
    piVar9[0x11] = 0xb4;
    iVar7 = GetPSXPadValue(mappings[uVar4][0xc][iVar3],1);
    piVar9[0x12] = iVar7;
    if (streamData.track.fTimeOfDay == '\0') {
      piVar9[0x13] = 0xbf;
      piVar9[0x14] = 0;
      piVar9[0x15] = 0xa0;
      uVar6 = mappings[uVar4][9][iVar3];
      if (iVar3 == 1) {
        uVar6 = uVar6 | 6;
      }
    }
    else {
      piVar9[0x13] = 0xbf;
      iVar7 = GetPSXPadValue(mappings[uVar4][9][iVar3],1);
      piVar9[0x14] = iVar7;
      piVar9[0x15] = 0xa0;
      uVar6 = 0;
      if (iVar3 == 1) {
        uVar6 = 6;
      }
    }
    iVar7 = GetPSXPadValue(uVar6,1);
    piVar9[0x16] = iVar7;
    piVar9[0x17] = 0x99;
    iVar7 = GetPSXPadValue(mappings[uVar4][0xb][iVar3],1);
    piVar9[0x18] = iVar7;
    piVar9[0x19] = 0xc1;
    iVar7 = GetPSXPadValue(mappings[uVar4][7][iVar3],1);
    piVar9[0x1a] = iVar7;
    piVar9[0x1b] = 0xb1;
    iVar7 = GetPSXPadValue(mappings[uVar4][7][iVar3],1);
    piVar9[0x1c] = iVar7;
    piVar9[0x1d] = 0xd1;
    iVar7 = GetPSXPadValue(0x800,1);
    piVar9[0x1e] = iVar7;
    if (streamData.playerCars[1].fCarClass == '\a') {
      piVar9[0x1f] = 0xcd;
      uVar4 = mappings[uVar4][10][iVar3];
      piVar9 = piVar9 + 0x20;
      if (iVar3 == 1) {
        uVar4 = uVar4 | 6;
      }
    }
    else {
      piVar9[0x1f] = 0xce;
      uVar6 = mappings[uVar4][10][iVar3];
      if (iVar3 == 1) {
        uVar6 = uVar6 | 6;
      }
      iVar7 = GetPSXPadValue(uVar6,1);
      piVar9[0x20] = iVar7;
      piVar9[0x21] = 0xc9;
      iVar7 = GetPSXPadValue(mappings[uVar4][0][iVar3],1);
      piVar9[0x22] = iVar7;
      piVar9[0x23] = 0xca;
      iVar3 = GetPSXPadValue(mappings[uVar4][1][iVar3],1);
      piVar9[0x24] = iVar3;
      piVar9[0x25] = 0xcd;
      piVar9 = piVar9 + 0x26;
      uVar4 = 0x40;
    }
    iVar3 = GetPSXPadValue(uVar4,1);
    *piVar9 = iVar3;
    piVar2 = piVar9 + 1;
  }
  *piVar2 = 0;
  resizememadr(stream,(int)piVar2 + (4 - (int)stream));
  return stream;
}



/* ---- Front_GetInGameVars  [FRONT.CPP:2728-2752] ---- */

/* Decoded Phase 83: Front_GetInGameVars() - copy GameSetup_gData controller fields into frontEnd
   struct (244 B). Imports controllerData, deadSpot, steeringRange, ImaxRange/IImaxRange, shockMode,
   shockImpact, pinkSlips state for menu display.
   
   [ghidra-meta] section: front.text */

void Front_GetInGameVars(void)

{
  GameSetup_tData *pGVar1;
  int i;
  int iVar2;
  int iVar3;
  
  frontEnd.musicVolume = (byte)gMasterMusicLevel;
  AudioMus_Volume((int)((uint)(byte)gMasterMusicLevel * 0x23) >> 6);
  pGVar1 = &GameSetup_gData;
  frontEnd.sfxVolume = (char)gMasterSFXLevel;
  frontEnd.engineVolume = (char)gMasterEngineLevel;
  frontEnd.narrationVolume = (char)gMasterFENarrationLevel;
  frontEnd.ambientVolume = (char)gMasterAmbientLevel;
  frontEnd.pinkSlipsForfeit = (short)GameSetup_gData.pinkSlipsForfeit;
  iVar2 = 0;
  do {
    frontEnd.controlConfig[iVar2] = (char)(pGVar1->controllerData).controllerConfig[0];
    frontEnd.deadSpot[iVar2] = (char)(pGVar1->controllerData).deadSpot[0];
    frontEnd.steeringRange[iVar2] = (char)(pGVar1->controllerData).steeringRange[0];
    frontEnd.IImaxRange[iVar2] = (char)(pGVar1->controllerData).IImaxRange[0];
    frontEnd.ImaxRange[iVar2] = (char)(pGVar1->controllerData).ImaxRange[0];
    iVar3 = iVar2 + 1;
    frontEnd.shockMode[iVar2] = (char)(pGVar1->controllerData).shockMode[0];
    frontEnd.shockImpact[iVar2] = (char)(pGVar1->controllerData).shockImpact[0];
    pGVar1 = (GameSetup_tData *)&pGVar1->numLaps;
    iVar2 = iVar3;
  } while (iVar3 < 2);
  return;
}



/* ---- SetLicensePlate  [FRONT.CPP:2762-2771] ---- */

/* void SetLicensePlate()
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x8002B7CC block=CODE size=168B
     Direct callers: 3
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:2762
     Sample callers: Initialize__16tScreenCarSelect, DoMemCardStuff__25tScreenPinkSlipsCarSelect,
   Initialize__15tScreenCongrats
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md.
   
   [Locals 2026-05-08] Locals renamed via deep-body inspection. Sets license-plate text for both
   players. Loop p=0..1 (2 players, sign-extended via *0x10000 >> 0x10 dance for compiler): fmt =
   PlayerName(p); s = &frontEnd.licensePlate[p*4] (4-char plate buffer per player). sprintf(plate,
   name) -> raw name. UpperCaseItKeepingInMindThoseBloodySpecialCharacters (sic) normalizes accented
   Latin chars. s_lower (then re-lowercases? - likely creates mixed case). CarIO_CleanUpLicense +
   CarIO_CreateLicense generate the plate texture for car rendering. */

void SetLicensePlate(void)

{
  char *fmt;
  char (*s)[8];
  int p;
  int player;
  short i;
  int p_next;
  
  p_next = 0;
  p = 0;
  do {
    player = p >> 0x10;
    fmt = PlayerName(player);
    s = frontEnd.licensePlate + player * 4;
    sprintf(*s,fmt);
    StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters(*s);
    s_lower(*s);
    CarIO_CleanUpLicense(player);
    CarIO_CreateLicense(*s,0,player);
    p_next = p_next + 1;
    p = p_next * 0x10000;
  } while (p_next * 0x10000 >> 0x10 < 2);
  return;
}



/* ---- SetPlayList  [FRONT.CPP:2777-2811] ---- */

/* void SetPlayList(int ivealreadygotone)
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x8002B874 block=CODE size=236B
     Direct callers: 1
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:2777
     SYM data: 1 regparms / 0 args / 0 autos
     Sample callers: Init_PSX_FrontEnd
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

void SetPlayList(int ivealreadygotone)

{
  AudioMus_tSongList *addr;
  int iVar1;
  int i;
  int iVar2;
  AudioMus_tSongList *songlist;
  AudioMus_tSongList *pAVar3;
  
  AudioMus_SysCleanUp();
  AudioMus_SysStartUp(0xc000,0x18000,"ymus");
  addr = AudioMus_GetSongList("game*",0);
  if (ivealreadygotone == 0) {
    iVar2 = 0x27;
    iVar1 = -0x7feeb964;
    do {
      *(u_int *)(iVar1 + 0x39c) = 0;
      iVar2 = iVar2 + -1;
      iVar1 = iVar1 + -4;
    } while (-1 < iVar2);
    iVar1 = 0;
    pAVar3 = addr;
    if (0 < addr->numsongs) {
      do {
        frontEnd.FEPlayList[pAVar3[4].currentsong] = 1;
        iVar1 = iVar1 + 1;
        pAVar3 = pAVar3 + 8;
      } while (iVar1 < addr->numsongs);
    }
  }
  frontEnd.GotAPlayList = 1;
  purgememadr(addr);
  AudioMus_SysCleanUp();
  AudioMus_SysStartUp(0xd800,0x18000,"amus");
  return;
}



/* ---- Front_GetTrackRaced  [FRONT.CPP:2815-2830] ---- */

/* Decoded Phase 83: Front_GetTrackRaced() - return track ID for current race (112 B, 10 callers -
   hot). raceType==2 (tournament): track from tourney progress; otherwise from menu selection.
   
   [ghidra-meta] section: front.text */

short Front_GetTrackRaced(void)

{
  short trackraced;
  short sVar1;
  tTrackInformation trackInfo;
  
  if (frontEnd.raceType == '\x02') {
    sVar1 = GetLastTrackRaced(&tournamentManager);
  }
  else {
    GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
               &trackInfo);
    sVar1 = (short)trackInfo.fTrackID;
  }
  return sVar1;
}



/* ---- PlayerNameExist  [FRONT.CPP:2834-2837] ---- */

/* void * PlayerNameExist(int player)
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x8002B9D0 block=CODE size=44B
     Direct callers: 2
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:2834
     SYM data: 1 regparms / 0 args / 0 autos
     Sample callers: Init_MemcardFile,
   Cars_InitializeCarTablesFlagsAndCounters
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

void * PlayerNameExist(int player)

{
  uint uVar1;
  
  uVar1 = strlen(frontEnd.playerNameList[player * 4]);
  return (void *)(uint)(uVar1 != 0);
}



/* ---- PlayerName  [FRONT.CPP:2841-2850] ---- */

/* char * PlayerName(int player)
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x8002B9FC block=CODE size=140B
     Direct callers: 17
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:2841
     SYM data: 1 regparms / 0 args / 0 autos
     Sample callers: Init_MemcardFile, MainLoop__14tFEApplicationP5tMenu,
   SavePinkSlipsCarsWithErrorDialogs, StatChk_SaveRecordLapTime
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md.
   
   [Locals 2026-05-08] Locals renamed via deep-body inspection. Returns ALL-UPPER player name. s =
   &frontEnd.allUpperCasedPlayerNameList[player*4]. sprintf(*s, frontEnd.playerNameList[player*4])
   copies the raw name. name_len = strlen(*s); on empty: same default fallback as
   PlayerNameMixedCase (wordnum = 0x4E or player+0x50 from TextSys). Else:
   StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters in-place uppercases (handles
   accented Latin chars). Returns *s. Mirror of PlayerNameMixedCase but enforces uppercase output.
    */

char * PlayerName(int player)

{
  uint name_len;
  char (*s)[8];
  int wordnum;
  
  s = frontEnd.allUpperCasedPlayerNameList + player * 4;
  sprintf(*s,frontEnd.playerNameList[player * 4]);
  name_len = strlen(*s);
  if (name_len == 0) {
    wordnum = 0x4e;
    if (frontEnd.gameMode == '\x01') {
      wordnum = player + 0x50;
    }
    s = (char (*) [8])TextSys_Word(wordnum);
  }
  else {
    StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters(*s);
  }
  return *s;
}



/* ---- PlayerNameMixedCase  [FRONT.CPP:2859-2866] ---- */

/* char * PlayerNameMixedCase(int player)
   
   Game-side C helper (uncategorized) (game-c-other).Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.Provenance:
     @0x8002BA88 block=CODE size=108B
     Direct callers: 1
     SLD source: nfs4/FRONTEND/COMMON/FRONT.CPP:2859
     SYM data: 1 regparms / 0 args / 0 autos
     Sample callers: Cars_InitializeCarTablesFlagsAndCounters
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.Build date: 1999-02-22.See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md.
   
   [Locals 2026-05-08] Locals renamed via deep-body inspection. Returns mixed-case player name (with
   default fallback). s = &frontEnd.playerNameList[player*4]. name_len = strlen(*s). On empty name:
   wordnum = 0x4E (= 'PLAYER' default text-id); for 2-player mode: wordnum = player + 0x50 (=
   'PLAYER ONE' / 'PLAYER TWO'); s = TextSys_Word(wordnum). Returns *s (= the displayed name).Mixed-case = 'Foo' rather than the 'FOO' variant in PlayerName (which forces uppercase via
   StatTool helper). */

char * PlayerNameMixedCase(int player)

{
  uint name_len;
  char (*s)[8];
  int wordnum;
  
  s = frontEnd.playerNameList + player * 4;
  name_len = strlen(*s);
  if (name_len == 0) {
    wordnum = 0x4e;
    if (frontEnd.gameMode == '\x01') {
      wordnum = player + 0x50;
    }
    s = (char (*) [8])TextSys_Word(wordnum);
  }
  return *s;
}



/* ---- tAllScreens::ctor  [FRONT.CPP:226-232] ---- */

tAllScreens::tAllScreens()

{
  
  tScreen_ctor((tScreen *)this);
  *(void **)&((this->screenMain)._base_tScreen._vf) = (void *)tScreenMain_vtable;
  tScreenCarSelect_ctor(&this->screenCarSelect);
  tScreenCarSelect_ctor(&(this->screenCarSelectDuel)._base_tScreenCarSelect);
  *(void **)&((this->screenCarSelectDuel)._base_tScreenCarSelect._base_tScreen._vf) = (void *)tScreenCarSelectDuel_vtable;
  tScreenCarSelect_ctor(&(this->screenCarSelectTwoPlayer)._base_tScreenCarSelect);
  *(void **)&((this->screenCarSelectTwoPlayer)._base_tScreenCarSelect._base_tScreen._vf) = (void *)tScreenCarSelectTwoPlayer_vtable;
  tScreen_ctor((tScreen *)&(this->screenCarSelectTwoPlayer).CarDialog);
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.MaxW = 0x120;
  *(void **)&((this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf) = (void *)tDialogBase_vtable;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.currentlyOn = 0;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.reservedheight = 0;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.MaxH = 0;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.OffsetY = 0;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.OffsetX = 0;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.height = 0;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.width = 0;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.top = 0;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.left = 0;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.specificPlayer = -1;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.fDefault = 0;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.timeOutTicks = 0;
  *(void **)&((this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf) = (void *)tDialogMessageString_vtable;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString.Centerit = 0;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.fFullyOpen = 0;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.timeOutTicks = 0;
  (this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase.fFadeText = 0x80;
  *(void **)&((this->screenCarSelectTwoPlayer).CarDialog._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf) = (void *)tDialogBackUpOnly_vtable;
  tScreenCarSelect_ctor(&(this->screenCarSelectPlayerTwo)._base_tScreenCarSelect);
  *(void **)&((this->screenCarSelectPlayerTwo)._base_tScreenCarSelect._base_tScreen._vf) = (void *)tScreenCarSelectTwoPlayer_vtable;
  tScreen_ctor((tScreen *)&(this->screenCarSelectPlayerTwo).CarDialog);
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.MaxW = 0x120;
  *(void **)&((this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf) = (void *)tDialogBase_vtable;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.currentlyOn = 0;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.reservedheight = 0;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.MaxH = 0;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.OffsetY = 0;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.OffsetX = 0;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.height = 0;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.width = 0;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.top = 0;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.left = 0;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.specificPlayer = -1;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.fDefault = 0;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.timeOutTicks = 0;
  *(void **)&((this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf) = (void *)tDialogMessageString_vtable;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString.Centerit = 0;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.fFullyOpen = 0;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.timeOutTicks = 0;
  (this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase.fFadeText = 0x80;
  *(void **)&((this->screenCarSelectPlayerTwo).CarDialog._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf) = (void *)tDialogBackUpOnly_vtable;
  tScreenCarSelect_ctor((tScreenCarSelect *)&this->screenPinkSlipsCarSelectTwoPlayer);
  *(void **)&((this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer._base_tScreenCarSelect._base_tScreen._vf) = (void *)tScreenCarSelectTwoPlayer_vtable;
  tScreen_ctor((tScreen *)
                   &(this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog);
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.MaxW = 0x120;
  *(void **)&((this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf) = (void *)tDialogBase_vtable;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.currentlyOn = 0;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.reservedheight = 0;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.MaxH = 0;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.OffsetY = 0;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.OffsetX = 0;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.height = 0;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.width = 0;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.top = 0;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.left = 0;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.specificPlayer = -1;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.fDefault = 0;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.timeOutTicks = 0;
  *(void **)&((this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf) = (void *)tDialogMessageString_vtable;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString.Centerit = 0;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.fFullyOpen = 0;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.timeOutTicks = 0;
  (this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.fFadeText = 0x80;
  *(void **)&((this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf) = (void *)tDialogBackUpOnly_vtable;
  *(void **)&((this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer._base_tScreenCarSelect._base_tScreen._vf) = (void *)tScreenPinkSlipsCarSelect_vtable;
  tScreenCarSelect_ctor((tScreenCarSelect *)&this->screenPinkSlipsCarSelectPlayerTwo);
  *(void **)&((this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer._base_tScreenCarSelect._base_tScreen._vf) = (void *)tScreenCarSelectTwoPlayer_vtable;
  tScreen_ctor((tScreen *)
                   &(this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog);
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.MaxW = 0x120;
  *(void **)&((this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf) = (void *)tDialogBase_vtable;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.currentlyOn = 0;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.reservedheight = 0;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.MaxH = 0;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.OffsetY = 0;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.OffsetX = 0;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.height = 0;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.width = 0;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.top = 0;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.left = 0;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.specificPlayer = -1;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.fDefault = 0;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.timeOutTicks = 0;
  *(void **)&((this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf) = (void *)tDialogMessageString_vtable;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString.Centerit = 0;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.fFullyOpen = 0;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.timeOutTicks = 0;
  (this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase.fFadeText = 0x80;
  *(void **)&((this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog._base_tDialogMessageString._base_tDialogBase._base_tScreen._vf) = (void *)tDialogBackUpOnly_vtable;
  *(void **)&((this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer._base_tScreenCarSelect._base_tScreen._vf) = (void *)tScreenPinkSlipsCarSelect_vtable;
  tScreen_ctor(&(this->screenTrackRecords)._base_tScreen);
  *(void **)&((this->screenTrackRecords)._base_tScreen._vf) = (void *)tScreenTrackRecords_vtable;
  tScreen_ctor(&(this->screenTrackInfo)._base_tScreen);
  *(void **)&((this->screenTrackInfo)._base_tScreen._vf) = (void *)tScreenTrackInfo_vtable;
  tScreen_ctor(&(this->screenTrackSelect)._base_tScreen);
  *(void **)&((this->screenTrackSelect)._base_tScreen._vf) = (void *)tScreenTrackSelect_vtable;
  tScreenTournSelect_ctor(&this->screenTournSelect);
  tScreenTournamentStandings_ctor(&this->screenTournamentStandings);
  tScreen_ctor((tScreen *)&this->screenTournamentTrophy);
  *(void **)&((this->screenTournamentTrophy)._base_tScreenCongrats._base_tScreen._vf) = (void *)tScreenTournamentTrophy_vtable;
  tScreenTrophyRoom_ctor(&this->screenTrophyRoom);
  tScreen_ctor(&(this->screenTrophyInfo)._base_tScreen);
  *(void **)&((this->screenTrophyInfo)._base_tScreen._vf) = (void *)tScreenTrophyInfo_vtable;
  tScreenControllerConfig_ctor(&this->screenControllerConfig);
  tScreen_ctor(&(this->screenDisplay)._base_tScreen);
  *(void **)&((this->screenDisplay)._base_tScreen._vf) = (void *)tScreenDisplay_vtable;
  tScreenAudio_ctor(&this->screenAudio);
  tScreenMemcard_ctor(&this->screenMemcard);
  tScreen_ctor(&(this->screenUserName)._base_tScreen);
  *(void **)&((this->screenUserName)._base_tScreen._vf) = (void *)tScreenUserName_vtable;
  tScreen_ctor((tScreen *)&this->screenPinkSlipCongrats);
  *(void **)&((this->screenPinkSlipCongrats)._base_tScreenCongrats._base_tScreen._vf) = (void *)tScreenPinkSlipCongrats_vtable;
  tScreenTournamentStandings_ctor((tScreenTournamentStandings *)&this->screenPinkSlipStandings);
  *(void **)&((this->screenPinkSlipStandings)._base_tScreenTournamentStandings3item._base_tScreenTournamentStandings._base_tScreen._vf) = (void *)tScreenPinkSlipStandings_vtable;
  tScreenTournamentStandings_ctor(&(this->screenTournamentStandings3item)._base_tScreenTournamentStandings);
  *(void **)&((this->screenTournamentStandings3item)._base_tScreenTournamentStandings._base_tScreen._vf) = (void *)tScreenTournamentStandings3item_vtable;
  tScreen_ctor(&(this->screenPinkSlips)._base_tScreen);
  *(void **)&((this->screenPinkSlips)._base_tScreen._vf) = (void *)tScreenPinkSlips_vtable;
  tScreen_ctor((tScreen *)&this->screenBeTheCopCongrats);
  *(void **)&((this->screenBeTheCopCongrats)._base_tScreenCongrats._base_tScreen._vf) = (void *)tScreenBeTheCopCongrats_vtable;
  tScreen_ctor((tScreen *)&this->screenTournamentCongrats);
  *(void **)&((this->screenTournamentCongrats)._base_tScreenCongrats._base_tScreen._vf) = (void *)tScreenTournamentCongrats_vtable;
  return;
}



/* ---- tAllScreens::dtor  [FRONT.CPP:226-232] ---- */

tAllScreens::~tAllScreens()

{
  short trackraced;
  int colourLoop;
  short maxTraffic;
  char oldMission;
  int theanalogoffset;
  int j;
  int LookingFor;
  short numOpponents;
  tCarModels copModel;
  char copColor;
  tMenuCommand tempCommand;
  tCarModels carModel;
  char carColor;
  short lapconv [2];
  
  tScreen_dtor((tScreen *)&this->screenTournamentCongrats,2);
  tScreen_dtor((tScreen *)&this->screenBeTheCopCongrats,2);
  tScreen_dtor(&(this->screenPinkSlips)._base_tScreen,2);
  tScreen_dtor((tScreen *)&this->screenTournamentStandings3item,2);
  tScreen_dtor((tScreen *)&this->screenPinkSlipStandings,2);
  tScreen_dtor((tScreen *)&this->screenPinkSlipCongrats,2);
  tScreen_dtor(&(this->screenUserName)._base_tScreen,2);
  tScreen_dtor(&(this->screenMemcard)._base_tScreen,2);
  tScreen_dtor(&(this->screenAudio)._base_tScreen,2);
  tScreen_dtor(&(this->screenDisplay)._base_tScreen,2);
  tScreen_dtor((tScreen *)&(this->screenControllerConfig).negconPopUp,2);
  tScreen_dtor(&(this->screenControllerConfig)._base_tScreen,2);
  tScreen_dtor(&(this->screenTrophyInfo)._base_tScreen,2);
  tScreenTrophyRoom_dtor(&this->screenTrophyRoom,2);
  tScreen_dtor((tScreen *)&this->screenTournamentTrophy,2);
  tScreen_dtor(&(this->screenTournamentStandings)._base_tScreen,2);
  tScreenTournSelect_dtor(&this->screenTournSelect,2);
  tScreen_dtor(&(this->screenTrackSelect)._base_tScreen,2);
  tScreen_dtor(&(this->screenTrackInfo)._base_tScreen,2);
  tScreen_dtor(&(this->screenTrackRecords)._base_tScreen,2);
  tScreen_dtor((tScreen *)
                    &(this->screenPinkSlipsCarSelectPlayerTwo)._base_tScreenCarSelectTwoPlayer.CarDialog,2
                   );
  tScreenCarSelect_dtor((tScreenCarSelect *)&this->screenPinkSlipsCarSelectPlayerTwo,2);
  tScreen_dtor((tScreen *)
                    &(this->screenPinkSlipsCarSelectTwoPlayer)._base_tScreenCarSelectTwoPlayer.CarDialog,2
                   );
  tScreenCarSelect_dtor((tScreenCarSelect *)&this->screenPinkSlipsCarSelectTwoPlayer,2);
  tScreen_dtor((tScreen *)&(this->screenCarSelectPlayerTwo).CarDialog,2);
  tScreenCarSelect_dtor(&(this->screenCarSelectPlayerTwo)._base_tScreenCarSelect,2);
  tScreen_dtor((tScreen *)&(this->screenCarSelectTwoPlayer).CarDialog,2);
  tScreenCarSelect_dtor(&(this->screenCarSelectTwoPlayer)._base_tScreenCarSelect,2);
  tScreenCarSelect_dtor(&(this->screenCarSelectDuel)._base_tScreenCarSelect,2);
  tScreenCarSelect_dtor(&this->screenCarSelect,2);
  tScreen_dtor((tScreen *)this,2);
  return;
}



/* end of front.cpp */

/* owning-TU def (extern-declared, never defined; link-harness) */
int _usePlayerUpgrades;
