/* game/common/nfs3.cpp -- RECONSTRUCTED (game boot / module start-up + main() entry; C TU, 11 fns) */
#include "../../nfs4_types.h"
#include "nfs3_externs.h"

/* ---- owning-TU defs for link-harness (extern-declared, never defined; BSS) ---- */
int *gFileMem; int *gFileHandleTable;

/* ---- nfs3.obj-OWNED globals -- DEFINED here (self-contained; SYM-typed via gen_owned_defs:
   .data = real NFS4.EXE bytes, .bss = zero) ---- */
char         befuddleExtensions[14][4] = { 113, 112, 108, 0, 97, 105, 105, 0, 115, 112, 100, 0, 113, 97, 108, 0, 115, 97, 108, 0, 100, 116, 97, 0, 113, 112, 115, 0, 105, 110, 102, 0, 113, 100, 97, 0, 99, 97, 114, 0, 113, 97, 115, 0, 113, 100, 116, 0, 115, 112, 108, 0, 115, 112, 101, 0 };   /* @0x8011423c */
tCarManager  carManager;   /* @0x80114274  (bss(zero)) */
tfrontEnd    frontEnd;   /* @0x80114600  (bss(zero)) */
tTrackManager trackManager;   /* @0x80114a50  (bss(zero)) */
tTournamentManager tournamentManager;   /* @0x80114ad8  (bss(zero)) */
tCreditManager CreditManager;   /* @0x80114d5c  (bss(zero)) */
tRecordBuffer Stats_gTrackRecords[187];   /* @0x80114d94  (bss(zero)) */
char         gTournamentFinishOrder[12];   /* @0x80115c30  (bss(zero)) */
char         befuddleTemp[10];   /* @0x80115c3c  (bss(zero)) */
char         gMusicInSimIsOn = 1;   /* @0x8013d270 */
int          gUseFrontend = 1;   /* @0x8013d274 */
u_long       gFECheats;   /* @0x8013d278  (bss(zero)) */
u_long       gFEBonus;   /* @0x8013d27c  (bss(zero)) */
int          gFEBigHandle;   /* @0x8013d280  (bss(zero)) */
int          MEMCARDFRONTENDISINITTED;   /* @0x8013d284  (bss(zero)) */
char         gCheckTotalTime = 1;   /* @0x8013d288 */
char         gCheckLapTime = 1;   /* @0x8013d289 */
char         gUpdateTournamentInfoFlag = 1;   /* @0x8013d28a */
char         gUpdateKnockoutInfoFlag = 1;   /* @0x8013d28b */
char         gKnockOutSpeechFlag = 1;   /* @0x8013d28c */
char         gCalculateVictory = 1;   /* @0x8013d28d */
char         gPlayerEnteredNameAlready[2];   /* @0x8013d290  (bss(zero)) */
tNfsSystemInfo nfs_sysInfo;   /* @0x8013d2b4  (bss(zero)) */
tMissionManager missionManager;   /* @0x8013d2b8  (bss(zero)) */
char         finishOrder[8];   /* @0x8013d2c0  (bss(zero)) */


/* ---- Nfs2_SystemNLibStartUp  [NFS3.CPP:118-135] SLD-VERIFIED ---- */


void Nfs2_SystemNLibStartUp(void)

{
  int p;

  Platform_SysStartUp();
  Loading_GetInitialMemory();
  if (_6Speech_fgUndefined == 0) {
    p = (int)__builtin_new(0x50);
    *(void ***)(p + 0x4c) = (void **)Speaker_vtable;
    *(int *)(p + 0x48) = 0;
    _6Speech_fgUndefined = p;
  }
  Render_InitLibRender();
  return;
}



/* ---- Nfs2_BefuddleCode  [NFS3.CPP:178-181] SLD-VERIFIED ---- */


void Nfs2_BefuddleCode(void)

{
  int loop;

  loop = 0;
  do {
    strcpy(befuddleTemp,befuddleExtensions[loop]);
    loop = loop + 1;
  } while (loop < 0xe);
  return;
}



/* ---- Nfs2_ResetGame  [NFS3.CPP:186-348] SLD-VERIFIED ---- */


void Nfs2_ResetGame(void)

{
  Replay_ResetReplay();
  BWorld_Restart();
  Sim_Restart();
  Camera_Init();
  Weather_Restart();
  AudioCmn_Reset();
  Speech_Reset();
  AudioClc_StartUp();
  DashHUD_ResetHUD();
  return;
}



/* ---- NFS4_LoadPerps  [NFS3.CPP:247-348] SLD-VERIFIED ---- */


void NFS4_LoadPerps(void)

{
  u_char bVar1;
  int *addr;
  u_int *addr_00;
  int iVar2;
  u_long numTiers;
  u_int *puVar3;
  u_long j;
  u_int uVar4;
  int *piVar5;
  char *pcVar6;
  u_char *pbVar7;
  char *data;
  u_char *pbVar8;
  u_long numCars;
  int numMissions;
  u_int uVar9;
  tCarInfo *carData;
  u_int *puVar10;
  GameSetup_tPerpData *perpInfo;
  GameSetup_tPerpData *pGVar11;
  short i;
  int iVar12;
  char *buffer;
  char *cars;
  char filename [64];
  
  if (0 < GameSetup_gData.numPerps) {
    if (GameSetup_gData.commMode == 1) {
      pcVar6 = "zHPurs2.mis";
    }
    else {
      pcVar6 = "zHPurs.mis";
    }
    addr = (int *)sprintf(filename,"%s%s",Paths_Paths[0x25],pcVar6);
    loadfileadr(filename,0x10);
    addr_00 = (u_int *)sprintf(filename,"%s%s",Paths_Paths[0x25],"fecars.car")
    ;
    loadfileadr(filename,0x10);
    pGVar11 = GameSetup_gData.perpInfo;
    iVar12 = 0;
    uVar9 = *addr_00;
    pbVar8 = (u_char *)(addr + *addr + (numMissions = addr[1]) * 5 + GameSetup_gData.stageOffset * 0xb + 3);
    if (0 < GameSetup_gData.numPerps) {
      puVar10 = addr_00 + 1;
      piVar5 = &GameSetup_gData.perpInfo[0].HudColour;
      pbVar7 = pbVar8 + 1;
      do {
        uVar4 = 0;
        if (uVar9 == 0) {
NFS4LoadPerps_defaultZero:
          uVar4 = 0;
          iVar2 = 0;
        }
        else {
          puVar3 = puVar10;
          do {
            if ((int)(char)*puVar3 == (u_int)*pbVar8) break;
            uVar4 = uVar4 + 1;
            puVar3 = puVar3 + 0x33;
          } while (uVar4 < uVar9);
          iVar2 = uVar4 << 1;
          if (uVar9 <= uVar4) goto NFS4LoadPerps_defaultZero;
        }
        pGVar11->CarType = (u_int)*(u_char *)((int)puVar10 + (iVar2 + uVar4) * 0x44 + 1);
        piVar5[-2] = (u_int)*pbVar7;
        piVar5[1] = (u_int)pbVar7[1];
        piVar5[2] = (int)*(short *)(pbVar7 + 3);
        if (GameSetup_gData.commMode == 1) {
          piVar5[3] = -1;
          piVar5[4] = -1;
          piVar5[5] = -1;
        }
        else {
          piVar5[3] = (int)*(short *)(pbVar7 + 5);
          piVar5[4] = (int)*(short *)(pbVar7 + 7);
          piVar5[5] = (int)*(short *)(pbVar7 + 9);
        }
        pbVar8 = pbVar8 + 0x2c;
        pGVar11 = pGVar11 + 1;
        piVar5[6] = (u_int)*(u_short *)(pbVar7 + 0xd);
        iVar12 = iVar12 + 1;
        piVar5[7] = *(int *)(pbVar7 + 0xf);
        piVar5[8] = *(int *)(pbVar7 + 0x13);
        piVar5[9] = *(int *)(pbVar7 + 0x17);
        piVar5[-1] = (u_int)*(u_char *)((int)puVar10 + (u_int)*pbVar7 + uVar4 * 0xcc + 0x84);
        bVar1 = *pbVar7;
        pbVar7 = pbVar7 + 0x2c;
        *piVar5 = (u_int)*(u_char *)((int)puVar10 + (u_int)bVar1 * 4 + uVar4 * 0xcc + 0x46) |
                  puVar10[uVar4 * 0x33 + bVar1 + 0x11] & 0xff00 |
                  (puVar10[uVar4 * 0x33 + bVar1 + 0x11] & 0xff) << 0x10;
        piVar5 = piVar5 + 0xd;
      } while (iVar12 * 0x10000 >> 0x10 < GameSetup_gData.numPerps);
    }
    purgememadr(addr);
    purgememadr(addr_00);
  }
  return;
}



/* ---- Nfs2_GameModuleStartUp  [NFS3.CPP:357-460] SLD-VERIFIED ---- */


void Nfs2_GameModuleStartUp(int *FrontEndDataStream)

{
  void *pThis;
  int iVar1;
  int iVar2;
  
  Audio_InitDriver(0,0);
  restoretextdraw();
  Platform_InitMemory();
  Platform_ResetDCTBuffer();
  GameSetup_StartUp(FrontEndDataStream);
  Replay_InitReplay();
  Nfs2_BefuddleCode();
  Loading_DrawLoadingScreen();
  Loading_UpdateLoadingScreen(1);
  NFS4_LoadPerps();
  Loading_UpdateLoadingScreen(2);
  Physics_CheckGamedata();
  Clock_SystemStartUp();
  AudioCmn_LoadGameSamples();
  CopSpeak_StartUp();
  if ((GameSetup_gData.raceType == 1) && (_6Speech_fgSpeech == 0)) {
    pThis = __builtin_new(0x3a4);
    _6Speech_fgSpeech = (int)Speech_ct((Speech *)pThis);
  }
  Render_InitPauseMenu();
  Render_InitTrackRender();
  Loading_UpdateLoadingScreen(4);
  BWorld_Init();
  Loading_UpdateLoadingScreen(6);
  Hrz_InitHorizon();
  Night_InitNightDriving();
  Weather_Init();
  Loading_UpdateLoadingScreen(7);
  Sim_StartUp();
  Render_InitTrackRenderPostSim();
  Hud_InitMap();
  SimQueue_StartUp();
  iVar1 = largestunused();
  if (GameSetup_gData.commMode == 1) {
    iVar2 = 0x13000;
  }
  else {
    iVar2 = 0xb000;
  }
  if (iVar2 < iVar1) {
    AudioMus_SysStartUp(0x6000,0x14000,"ymus");
  }
  AudioMus_BuildPlayList(GameSetup_gData.userSetting.numplaylistsongs,GameSetup_gData.userSetting.playlist);
  largestunused();
  return;
}



/* ---- Nfs2_CleanUpGameModule  [NFS3.CPP:464-549] SLD-VERIFIED ---- */


void Nfs2_CleanUpGameModule(void)

{
  Car_tObj *pCVar1;
  Car_tStats *pCVar2;
  Car_tStats *pCVar3;
  Car_tObj **ppCVar4;
  int iVar5;
  int k;
  int iVar7;
  int iVar8;
  
  Render_KillTrackRender();
  Render_KillPauseMenu();
  k = 0;
  if (0 < GameSetup_gData.numCars) {
    iVar5 = 0;
    do {
      ppCVar4 = Cars_gList + (iVar5 >> 0x10);
      ((*ppCVar4)->stats).carType = (*ppCVar4)->carInfo->carType;
      ((*ppCVar4)->stats).carClass = (*ppCVar4)->carInfo->carClass;
      ((*ppCVar4)->stats).carNameIndex = (*ppCVar4)->carInfo->carNameIndex;
      ((*ppCVar4)->stats).carFlags = (*ppCVar4)->carFlags;
      pCVar1 = *ppCVar4;
      pCVar3 = Cars_gNewCarStatsList + (iVar5 >> 0x10);
      pCVar2 = &pCVar1->stats;
      do {
        iVar5 = pCVar2->sliceTotal;
        iVar7 = pCVar2->sliceTime;
        iVar8 = pCVar2->slice;
        pCVar3->extractSlice = pCVar2->extractSlice;
        pCVar3->sliceTotal = iVar5;
        pCVar3->sliceTime = iVar7;
        pCVar3->slice = iVar8;
        pCVar2 = (Car_tStats *)&pCVar2->lastSlice;
        pCVar3 = (Car_tStats *)&pCVar3->lastSlice;
      } while (pCVar2 != (Car_tStats *)&pCVar1->crash);
      k = k + 1;
      iVar5 = k * 0x10000;
    } while (k * 0x10000 >> 0x10 < GameSetup_gData.numCars);
  }
  Replay_StoringReplay();
  AudioCmn_DeInit();
  if (_6Speech_fgSpeech != 0) {
    Speech_dt((Speech *)_6Speech_fgSpeech,3);
    _6Speech_fgSpeech = 0;
  }
  CopSpeak_CleanUp();
  Clock_SystemCleanUp();
  GameSetup_CleanUp();
  Sim_CleanUp();
  Hrz_KillHorizon();
  BWorld_DeInit();
  Camera_Kill();
  Weather_DeInit();
  Audio_DeInitDriver();
  return;
}



/* ---- LoadFrontendOverlay  [NFS3.CPP:560-580] SLD-VERIFIED ---- */


void LoadFrontendOverlay(void)

{
  int handle;
  int iVar1;
  
  handle = asyncloadfileat("front.bin",bigBuf);
  while (iVar1 = getasyncreadstatus(handle), iVar1 == 0) {
    systemtask(0);
  }
  return;
}



/* ---- LoadOverlay  [NFS3.CPP:589-596] SLD-VERIFIED ---- */


void LoadOverlay(void)

{
  int handle;
  int iVar1;
  char fname [60];
  
  LoadFrontendOverlay();
  sprintf(fname,"%sDCT.BIN",Paths_Paths[0x20]);
  handle = asyncloadfileat(fname,(int)&CF_DVLC);
  while (iVar1 = getasyncreadstatus(handle), iVar1 == 0) {
    systemtask(0);
  }
  return;
}



/* ---- NFS4_LoadingIcon  [NFS3.CPP:626-669] SLD-VERIFIED ---- */


void NFS4_LoadingIcon(void)

{
  void *ldfile;
  void *shp;
  int lang;
  char fname [80];
  RECT r;

  sprintf(fname,"%sldic.psh",Paths_Paths[0x25]);
  ldfile = loadfileadr(fname,0);
  lang = (int)(u_char)frontEnd.language;
  if (5 < lang) {
    lang = 0;
  }
  shp = shapepointer(ldfile,lang);
  r.w = 0x400;
  r.x = 0;
  r.y = 0;
  r.h = 0x200;
  ClearImage(&r,'\0','\0','\0');
  DrawSync(0);
  initlinkmode(0,100,0);   /* oracle 0x94650: a2=0 (dropped 3rd arg) */
  Draw_DirectSetEnvironment(0,0,0x200,0xf0,1,1,1,0,0,0);
  settrans(0);
  movfxya(shp,0x1e2 - *(short *)((int)shp + 4),0xd2);
  DrawSync(0);
  purgememadr(ldfile);
  initlinkmode(0,1,1);   /* oracle 0x946c0: a2=1 (dropped 3rd arg) */
  return;
}



/* ---- NFS3_CheckForFileOperations  [NFS3.CPP:686-694] SLD-VERIFIED ---- */


void NFS3_CheckForFileOperations(void)

{
  int *p;
  int *piVar1;
  
  for (piVar1 = (int *)gFileMem; piVar1 < (u_int)gFileHandleTable; piVar1 = piVar1 + 1) {
    if (*piVar1 != 0) {
      trap(0x666);
    }
  }
  return;
}



/* ---- main  [NFS3.CPP:703-935] SLD-VERIFIED ---- */

int main(void)

{
  u_int uVar1;
  int *setup;
  int iVar2;
  char *pattern;
  short oldReplayMode;
  
  __main();
  oldReplayMode = 0;
  Platform_DebuggerPollHost();
  Nfs2_SystemNLibStartUp();
  Audio_InitDriver(0,0);
  Audio_DeInitDriver();
  SetVideoMode(0);
  frontEnd.language = -1;
  LoadFrontendOverlay();
  ComingIntoTheFrontEndTheVeryFirstTime = 1;
  (&carManager)->Initialize();
  (&carManager)->LoadDescription();
  FECheat_ActivateBonus(cheat_Roadster);
  (&carManager)->SetClassViewable((tCarClassType)0, 1);
  (&carManager)->SetClassViewable((tCarClassType)1, 1);
  (&carManager)->SetClassViewable((tCarClassType)2, 1);
  (&carManager)->SetClassViewable((tCarClassType)3, 1);
  (&carManager)->SetClassViewable((tCarClassType)4, 1);
  (&carManager)->SetClassViewable((tCarClassType)5, 1);
  (&tournamentManager)->Initialize();
  (&missionManager)->Initialize();
  (&trackManager)->Initialize();
  (&tournamentManager)->LoadDescription();
  (&trackManager)->LoadDescription();
  Front_InitGraphics();
  Front_Menu(0);
  do {
    NFS3_CheckForFileOperations();
    setup = (int *)MinFront_ParseOptions();
    if (gUseFrontend != 0) {
      setup = (int *)Front_BuildStream(setup);
    }
    (&trackManager)->ReleaseDescription();
    (&missionManager)->ReleaseDescription();
    (&tournamentManager)->ReleaseDescription();
    (&carManager)->ReleaseDescription();
    initlinkmode(0,1,1);
    NFS3_CheckForFileOperations();
    Nfs2_GameModuleStartUp(setup);
    NFS3_CheckForFileOperations();
    while (simVar.restartGame != 0) {
      simVar.restartGame = 0;
      Nfs2_ResetGame();
      Sim_MainGameLoop();
      if ((GameSetup_gData.replayMode < 2) || (GameSetup_gData.instantReplay != 0)) {
        if ((simVar.restartGame == 0) || (GameSetup_gData.instantReplay != 0)) {
          GameSetup_gData.replayMode = 2;
          if (GameSetup_gData.instantReplay == 0) {
            Replay_ReplayInterface.statsScreen = 1;
            iVar2 = Stats_GetNumOpponents();
            if ((1 < iVar2) &&
               (((GameSetup_gData.raceType != 1 && (GameSetup_gData.raceType != 5)) ||
                (((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0 &&
                 ((Cars_gNumHumanRaceCars != 2 ||
                  ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0)))))))) {
              if ((Cars_gHumanRaceCarList[0]->stats).finalPosition == 1) {
                pattern = "win*";
              }
              else {
                pattern = "lose*";
              }
              AudioMus_PlaySong(pattern);
            }
          }
          else {
            Replay_ReplayInterface.statsScreen = 0;
          }
          Replay_ReplayMode = 2;
          simVar.restartGame = 1;
          GameSetup_gData.instantReplay = 0;
        }
      }
      else {
        Replay_ReplayInterface.statsScreen = 0;
      }
    }
    Nfs2_CleanUpGameModule();
    NFS4_LoadingIcon();
    LoadOverlay();
    NFS3_CheckForFileOperations();
    Front_InitGraphicsAndDisplayLoading();
    GameSetup_gData.replayMode = (int)oldReplayMode;
    Front_GetInGameVars();
    (&carManager)->LoadDescription();
    (&tournamentManager)->LoadDescription();
    (&trackManager)->LoadDescription();
    uVar1 = 1;
    if (quitType == 1) {
      uVar1 = 2;
    }
    Front_Menu(uVar1);
    oldReplayMode = (short)GameSetup_gData.replayMode;
    NFS3_CheckForFileOperations();
  } while( true );
}



/* end of nfs3.cpp */

/* owning-TU def (extern-declared, never defined; link-harness).
   _6Speech_fgUndefined is OWNED by Speech (3 speech fns reach it via %gp_rel); nfs3 is a
   NON-owner -> its oracle (Nfs2_SystemNLibStartUp) uses ABSOLUTE lui/%hi, so leave it a pure
   extern (a tentative def here forced a wrong .comm gp-rel; methodology 3.12 #6). Data lives
   in asm/data/sdata_8013C54C.sdata.s @0x8013cd88. */
int _6Speech_fgSpeech;
