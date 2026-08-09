/* game/psx/sim.cpp -- RECONSTRUCTED (NFS4 PSX sim engine core / main loop; C++ TU)
 *   8 fns: Sim_StartUp/Restart/CleanUp/FadeInSFX/ProcessSimSchedules/ProcessPause/CheckForPause/MainGameLoop.
 *   GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "sim_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
int InBetween;
int quitType;
int skipRender;
int unPauseDelay;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Sim_StartUp(void);
void Sim_Restart(void);
void Sim_CleanUp(void);
void Sim_FadeInSFX(void);
void Sim_ProcessSimSchedules(void);
void Sim_ProcessPause(void);
void Sim_CheckForPause(int checkInput);
void Sim_MainGameLoop(void);


/* ---- Sim_StartUp__Fv  [SIM.CPP:186-227] SLD-VERIFIED ---- */
void Sim_StartUp(void)

{
  simVar.restartGame = 1;
  simVar.endSimGame = 0;
  simVar.pauseSim = 0;
  simVar.quickPauseSim = 0;
  simVar.goalClockTicks = 0;
  simVar.currentClockTicks = 0;
  simVar.keyRelease = 0;
  simGlobal.gameStarted = 0;
  simGlobal.gameTicks = 0;
  simGlobal.schedule32Hz = Sched_CreateNewSchedule("Sc32-1",0x46);
  simGlobal.schedule32Hz2 = Sched_CreateNewSchedule("Sc32-2",0xb);
  simGlobal.schedule64Hz = Sched_CreateNewSchedule("Sc64",0x1a);
  FastRandom_StartUp(GameSetup_gData.randSeed);
  AICop_StartUp();
  AIInit_StartUp1();
  R3DCar_StartUp();
  CarIO_StartUp();
  Cars_StartUp();
  R3DCar_PostStartUp();
  AIHigh_StartUp();
  Loading_UpdateLoadingScreen(8);
  Loading_UpdateLoadingScreen(9);
  AIInit_StartUp2();
  Loading_UpdateLoadingScreen(10);
  AudioCmn_Init();
  Sched_AddFunction(simGlobal.schedule64Hz,(void (*)(void *))Camera_Update,(void *)0x0,100);
  return;
}

/* ---- Sim_Restart__Fv  [SIM.CPP:231-260] SLD-VERIFIED ---- */
void Sim_Restart(void)

{
  quitType = 1;
  simVar.endSimGame = 0;
  simVar.pauseSim = 0;
  simVar.quickPauseSim = 0;
  simVar.goalClockTicks = 0;
  simVar.currentClockTicks = 0;
  simGlobal.gameStarted = 0;
  countdown = '\0';
  simGlobal.gameTicks = 0;
  GameSetup_gData.perpArrests = 0;
  FastRandom_StartUp(GameSetup_gData.randSeed);
  AICop_Restart();
  AIInit_Reset1();
  R3DCar_Restart();
  AIHigh_Restart1();
  Cars_Restart();
  AIHigh_Restart2();
  AIInit_Reset2();
  Hud_Reset();
  Render_RestartTrackRender();
  SimQueue_Reset();
  simGlobal.time32Hz = Input_gTime;
  return;
}

/* ---- Sim_CleanUp__Fv  [SIM.CPP:264-286] SLD-VERIFIED ---- */
void Sim_CleanUp(void)

{
  Force_Disable();
  SimQueue_CleanUp();
  Sched_DeleteFunction(simGlobal.schedule64Hz,(void (*)(void *))Camera_Update,(void *)0x0);
  AIInit_CleanUp2();
  AIHigh_CleanUp();
  Cars_CleanUp();
  R3DCar_CleanUp();
  CarIO_CleanUp();
  AIInit_CleanUp1();
  AICop_CleanUp();
  FastRandom_CleanUp();
  Sched_CleanUpSchedule(simGlobal.schedule32Hz);
  Sched_CleanUpSchedule(simGlobal.schedule32Hz2);
  Sched_CleanUpSchedule(simGlobal.schedule64Hz);
  return;
}

/* ---- Sim_FadeInSFX__Fv  [SIM.CPP:290-301] SLD-VERIFIED ---- */
void Sim_FadeInSFX(void)

{
  int iVar1;
  int iVar2;

  if (simGlobal.gameTicks == 0) {
    iVar2 = gMasterSFXLevel;
    gMasterSFXLevel = 0;
    GameSetup_gData.userSetting.sfxLevel = iVar2;
    return;
  }
  if (simGlobal.gameTicks - 0x11U < 0x40) {
    if (Replay_ReplayInterface.statsScreen != 0) {
      iVar1 = GameSetup_gData.userSetting.sfxLevel >> 2;
      iVar2 = simGlobal.gameTicks + -0x10;
    }
    else {
      iVar2 = GameSetup_gData.userSetting.sfxLevel;
      iVar1 = simGlobal.gameTicks + -0x10;
    }
    gMasterSFXLevel = iVar2 * iVar1 >> 6;
  }
  return;
}

/* ---- Sim_ProcessSimSchedules__Fv  [SIM.CPP:312-531] SLD-VERIFIED ---- */
/* PASS (201/201 insns). The `firstSfx` loop invariant must be declared inside
 * the `i < 4` block: that SLD-confirmed scope keeps its `$s1` initialization
 * after the branch and lets gcc fill the branch delay slot with the speculative
 * `%hi(simGlobal)` load used by the no-loop path. */
void Sim_ProcessSimSchedules(void)

{
  int i;

  if (!(((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&
       (((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) != 0 ||
        ((Cars_gNumHumanRaceCars == 2 &&
          ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) != 0))))))) {
    if (simGlobal.gameStarted == 0) {
      i = (u_char)countdown - 1;
      if (i >= 0) goto countdown_index_ready;
      i = 0;
countdown_index_ready:
      {
        if (i < 4) {
          int firstSfx = 0x23;

          do {
            AudioCmn_GetAsyncSfx(2,i + firstSfx,false);
            i = i + 1;
          } while (i < 4);
        }
      }
      if (simGlobal.gameTicks >= counter[(u_char)countdown]) {
        if (0x1ff < simGlobal.gameTicks) {
          simGlobal.gameStarted = 1;
        }
        AudioCmn_PlaySound(-4,(u_char)countdown + 0x23,0,0x7f,0x40);
        countdown = countdown + '\x01';
      }
      Sim_FadeInSFX();
    }
  }
  else {
    Sim_FadeInSFX();
    simGlobal.gameStarted = 1;
  }
  if ((simGlobal.gameTicks & 1U) == 0) {
    systemtask(0);
    gWSavePtr = (u_long)SetSp(&gScratchLastWord);
    stackSpeedUpEnbabledFlag = 1;
    Stats_ClearPosition();
    Collide_ClearCollisionRegistry();
    Sched_Execute(simGlobal.schedule32Hz);
    Cars_ManageBureaucracy();
    gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
    stackSpeedUpEnbabledFlag = 0;
    Cars_CheckForAccidentScenes();
  }
  gWSavePtr = (u_long)SetSp(&gScratchLastWord);
  stackSpeedUpEnbabledFlag = 1;
  Sched_Execute(simGlobal.schedule64Hz);
  gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
  stackSpeedUpEnbabledFlag = 0;
  if ((simGlobal.gameTicks & 1U) != 0) {
    gWSavePtr = (u_long)SetSp(&gScratchLastWord);
    stackSpeedUpEnbabledFlag = 1;
    AIHigh_Execute();
    gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
    stackSpeedUpEnbabledFlag = 0;
    gWSavePtr = (u_long)SetSp(&gScratchLastWord);
    stackSpeedUpEnbabledFlag = 1;
    Sched_Execute(simGlobal.schedule32Hz2);
    Stats_TrackEndGame();
    Stats_DoPlayerGlue();
    gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
    stackSpeedUpEnbabledFlag = 0;
    AudioClc_SoundCars();
  }
  simGlobal.gameTicks = simGlobal.gameTicks + 1;
  return;
}

/* ---- Sim_ProcessPause__Fv  [SIM.CPP:467-531] SLD-VERIFIED ---- */
void Sim_ProcessPause(void)

{
  int iVar1;
  int r;
  
  if (unPauseDelay <= clock_realTime.time32Hz) {
    iVar1 = MPause_Logic();
    if (iVar1 == 1) {
      if (simVar.quickPauseSim == 0) {
        AudioCmn_UnPause();
      }
      gSimQueue_BlockSelf = 0;
      simVar.pauseSim = 0;
      Force_UnPause();
    }
    else if (iVar1 == 2) {
      AudioCmn_UnPauseAndRestart();
      simVar.pauseSim = 1;
      simVar.endSimGame = 1;
      simVar.restartGame = 1;
    }
    else {
      if (1 < iVar1 - 4U) {
        return;
      }
      if (iVar1 == 5) {
        GameSetup_gData.pinkSlipsForfeit = (int)(Device_gPausePortIndex != '\0');
      }
      Hud_BTC_QuitOut();
      AudioCmn_UnPauseAndRestart();
      simVar.pauseSim = 0;
      simVar.endSimGame = 1;
      simVar.restartGame = 0;
      Stats_ExtrapolateOpponentTimes(1);
      quitType = 1;
    }
    MPause_EndPauseMenu();
  }
  return;
}

/* ---- Sim_CheckForPause__Fi  [SIM.CPP:536-551] SLD-VERIFIED ---- */
void Sim_CheckForPause(int checkInput)

{
  int iVar1;
  
  if ((((Replay_ReplayMode < 2) && (simVar.restartGame == 0)) && (0x20 < simGlobal.gameTicks)) &&
     (((checkInput != 0 && (iVar1 = Input_Interface(6,1), iVar1 != 0)) ||
      (Device_gForcePause != 0)))) {
    unPauseDelay = clock_realTime.time32Hz + 4;
    AudioCmn_Pause();
    gSimQueue_BlockSelf = 1;
    simVar.pauseSim = 1;
    Force_Pause();
  }
  return;
}

/* ---- Sim_MainGameLoop__Fv  [SIM.CPP:554-826] SLD-VERIFIED ---- */
/* MATCH (W56-A15, 45->31): retail stores the NAMED-ONE constant for InBetween
 * (InBetween==0 here so `InBetween = one` == `InBetween++`), sharing the `1`
 * with the `speed == one` compare. `int one;` assigned `one = 1;` at the START
 * of the else{} block (its materialization position = oracle's `li s0,1`) is the
 * dial (function-scope `int one = 1;` hoists to prologue -> +2 regress).
 * RESIDUAL 31 = the oracle splits the two Sim_ProcessSimSchedules() calls across
 * the else{} block (block-layout: jal#1; j; [else]; jal#2) which our cross-jump
 * keeps together, cascading a lastRealTick/lastGoalTick s5/s6 -> s6/s7 rotation.
 * Block-order/permuter floor; polarity already matches (bne speed!=3). */
void Sim_MainGameLoop(void)

{
  int lastRealTick;
  int lastGoalTick;
  int one;
  GameSetup_tData *replaySetup;

  quitType = 1;
  lastRealTick = clock_realTime.time64Hz + 10000;
  lastGoalTick = 0;
  simGlobal.time32Hz = Input_gTime;
  do {
    if (simVar.endSimGame != 0) goto SimMainLoop_endGame;
    systemtask(0);
    {
      int realTick;
      int diffReal;
      int diffGoal;

      realTick = clock_realTime.time64Hz;
      simVar.goalClockTicks = gSimQueue_Ticker * 2;
      diffReal = realTick - lastRealTick;
      diffGoal = simVar.goalClockTicks - lastGoalTick;
      if (diffReal > diffGoal) {
        simVar.goalClockTicks++;
      }
      lastRealTick = realTick;
      lastGoalTick = simVar.goalClockTicks;
    }
    if (0x10 < Input_gTime - simGlobal.time32Hz) {
      simGlobal.time32Hz = Input_gTime;
    }
    replaySetup = &GameSetup_gData;
    while ((simGlobal.time32Hz <= Input_gTime && (simVar.endSimGame == 0))) {
      if ((Replay_ReplayMode == 2) && (simVar.pauseSim == 0)) {
        Replay_GetInterfaceKey();
        if (Replay_ReplayInterface.depressed == 4) {
          Replay_ReplayInterface.depressed = 0;
          simVar.endSimGame = Replay_ReplayInterface.end;
          if (replaySetup->instantReplay != 0) {
            AudioCmn_UnPauseAndRestart();
          }
          else {
            if ((Replay_ReplayInterface.end != 0) && (simVar.quickPauseSim != 0)) {
              simVar.quickPauseSim = 0;
              AudioCmn_UnPauseAndQuit();
            }
            else if (simVar.quickPauseSim != Replay_ReplayInterface.pause) {
              simVar.quickPauseSim = Replay_ReplayInterface.pause;
              if (simVar.quickPauseSim != 0) {
                Camera_Update();
                AudioCmn_Pause();
              }
              else {
                AudioCmn_UnPause();
              }
            }
          }
        }
      }
      if (simVar.endSimGame == 0) {
        if (simVar.pauseSim != 0) {
          Sim_ProcessPause();
          simVar.keyRelease = 0x18;
        }
        else {
          if (Input_Interface(0x15,1) != 0) {
            AudioMus_SwitchSong();
            Hud_ActivateCDPlayer = 1;
          }
          if (simVar.keyRelease != 0) {
            if (Input_Interface(simVar.keyRelease,0) == 0) {
              simVar.keyRelease = 0;
            }
          }
          else {
            int i;
            char *gameSetup;

            i = 0;
            gameSetup = (char *)&GameSetup_gData;
            if (i > (int)(u_int)(*(int *)(gameSetup + 0xc) == 1))
              goto SimMainLoop_inputDone;
SimMainLoop_inputLoop:
              if ((Input_Interface(i != 0 ? 0x1b : 0x1a,1) != 0) &&
                  (Replay_ReplayMode < 2)) {
                Camera_NextMode(i);
              }
              if (Input_Interface(i != 0 ? 0x1d : 0x1c,1) != 0) {
                DashHUD_ToggleHud(i);
              }
              *(int *)((i << 2) + (int)Input_gLookBehind) =
                  Input_Interface(i + 0x16,0);
              Sim_CheckForPause(1);
              i++;
              if (i <= (int)(u_int)(*(int *)(gameSetup + 0xc) == 1))
                goto SimMainLoop_inputLoop;
SimMainLoop_inputDone:
              ;
          }
        }
      }
      simGlobal.time32Hz = simGlobal.time32Hz + 1;
    }
    skipRender = 0;
    if (((simVar.pauseSim == 0) && (simVar.quickPauseSim == 0)) && (simVar.endSimGame == 0)) {
      if (simVar.currentClockTicks > simVar.goalClockTicks) {
        skipRender = 1;
      }
      else {
        one = 1;
        do {
          if ((simVar.currentClockTicks & 1U) == 0) {
            SimQueue_SetCurrentInput(simVar.currentClockTicks >> 1);
          }
          InBetween = 0;
          if ((Replay_ReplayMode != 2) ||
              (Replay_ReplayInterface.speed == 2) ||
              ((Replay_ReplayInterface.speed == one) &&
               ((simVar.currentClockTicks & 1U) == 0)) ||
              ((Replay_ReplayInterface.speed == 0) &&
               ((simVar.currentClockTicks & 3U) == 0))) {
            Sim_ProcessSimSchedules();
          }
          else {
            if (Replay_ReplayInterface.speed == 3) {
              Sim_ProcessSimSchedules();
              Sim_ProcessSimSchedules();
            }
            else {
              InBetween = one;
              Camera_Update();
            }
          }
          simVar.currentClockTicks = simVar.currentClockTicks + 1;
        } while (simVar.currentClockTicks <= simVar.goalClockTicks);
      }
    }
    else {
      Camera_Update();
    }
    if (skipRender == 0) {
      Render_Render(simVar.pauseSim);
    }
    if ((Input_MainExitKey() != 0) ||
        ((Replay_ReplayMode == 3 && (0x40 < simGlobal.gameTicks)))) {
      simVar.endSimGame = 1;
    }
  } while( true );
SimMainLoop_endGame:
  if (Replay_ReplayMode < 2) {
    GameSetup_gData.finalPerpArrests = GameSetup_gData.perpArrests;
  }
  return;
}

/* end of sim.cpp */
