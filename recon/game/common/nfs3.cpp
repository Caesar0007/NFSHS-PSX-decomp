/* game/common/nfs3.cpp -- RECONSTRUCTED (game boot / module start-up + main() entry; C TU, 11 fns) */
#include "../../nfs4_types.h"
#include "nfs3_externs.h"
#include "new.h"

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
  char *buffer;
  char *data;
  char *cars;
  tCarInfo *carData;
  char filename[64];
  u_long numTiers;
  u_long numMissions;
  u_long numCars;
  short i;
  u_long j;
  GameSetup_tPerpData *perpInfo;

  if (0 < GameSetup_gData.numPerps) {
    sprintf(filename,"%s%s",Paths_Paths[0x25],
            GameSetup_gData.commMode != 1 ? "zHPurs.mis" : "zHPurs2.mis");
    buffer = (char *)loadfileadr(filename,0x10);
    sprintf(filename,"%s%s",Paths_Paths[0x25],"fecars.car");
    cars = (char *)loadfileadr(filename,0x10);

    numTiers = *(u_long *)buffer;
    numMissions = *(u_long *)(buffer + 4);
    numCars = *(u_long *)cars;
    data = buffer + 12;
    data += numTiers * 4;
    data += numMissions * 20;
    data += GameSetup_gData.stageOffset * 44;
    perpInfo = GameSetup_gData.perpInfo;

    i = 0;
    if (0 < GameSetup_gData.numPerps) {
      carData = (tCarInfo *)(cars + 4);
      do {
      for (j = 0; j < numCars; j++) {
        if ((int)(signed char)carData[j].fCarID == (u_int)(u_char)data[0])
          break;
      }
      if (j >= numCars)
        j = 0;

        perpInfo->CarType = carData[j].fSimNumber;
        perpInfo->Colour = (u_char)data[1];
        perpInfo->Personality = (u_char)data[2];
        perpInfo->TimeLimit = *(short *)(data + 4);
        if (GameSetup_gData.commMode != 1) {
          perpInfo->WingmanTime = *(short *)(data + 6);
          perpInfo->SpikeBeltTime = *(short *)(data + 8);
          perpInfo->BlockadeCopTime = *(short *)(data + 10);
        }
        else {
          perpInfo->WingmanTime = -1;
          perpInfo->SpikeBeltTime = -1;
          perpInfo->BlockadeCopTime = -1;
        }

        perpInfo->Distance = *(u_short *)(data + 14);
        perpInfo->SpeedFactor = *(int *)(data + 16);
        perpInfo->WeightFactor = *(int *)(data + 20);
        perpInfo->GlueFactor = *(int *)(data + 24);
        perpInfo->SpeechColour = carData[j].fSpeechColors[(u_char)data[1]];
        perpInfo->HudColour =
            ((carData[j].fColorList[(u_char)data[1]] & 0xff0000) >> 16) |
            (carData[j].fColorList[(u_char)data[1]] & 0xff00) |
            ((carData[j].fColorList[(u_char)data[1]] & 0xff) << 16);

        data += 44;
        perpInfo++;
        i++;
      } while (i < GameSetup_gData.numPerps);
    }
    purgememadr(buffer);
    purgememadr(cars);
  }
}



/* ---- Nfs2_GameModuleStartUp  [NFS3.CPP:357-460] SLD-VERIFIED ---- */


void Nfs2_GameModuleStartUp(int *FrontEndDataStream)

{
  void *pThis;
  
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
    _6Speech_fgSpeech = (int)new ((Speech *)pThis) Speech;
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
  if (((D_801131F8[0] == 1) ? 0x13000 : 0xb000) < largestunused()) {
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
    delete (Speech *)_6Speech_fgSpeech;
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

/* _6Speech_fgUndefined and _6Speech_fgSpeech are both owned by Speech.  This TU
   addresses them absolutely, so their declarations remain pure externs. */
