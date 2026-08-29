#include "sim_types.h"
/* sim_externs.h -- extern decls for game/psx/sim.cpp (NFS4 PSX sim engine core). */
#ifndef SIM_EXTERNS_H
#define SIM_EXTERNS_H

/* ---- libc + harvested + SYM free-fns/globals ---- */
extern Car_tObj * Cars_gHumanRaceCarList[2];
extern Sim_GameSetupCodegenView GameSetup_gData asm("GameSetup_gData");
extern Sim_tSimGlobalVar simGlobal;                /* 0x8011e0ac */
extern Sim_tSimSystemVar simVar;
extern char   Device_gPausePortIndex;  /* Ghidra char literal \x01/\0 */
extern int               Replay_ReplayMode;   /* 0x8013d3f4 */
extern int            Hud_ActivateCDPlayer;
extern int            Input_gLookBehind[2];
extern int          gMasterSFXLevel;
extern int    Device_gForcePause;      /* = iVar1/0/1 */
extern int    Skid_gCtrlScratch_94, Skid_gCtrlScratch_98, Skid_gScratchPos1, Skid_gScratchPos2;
extern int   gSimQueue_BlockSelf;
extern int   gSimQueue_Ticker;
extern int Cars_gNumHumanRaceCars;
extern int Input_Interface(unsigned long, int);
extern int stackSpeedUpEnbabledFlag;
extern Sim_ReplayCodegenView Replay_ReplayInterface asm("Replay_ReplayInterface");
extern u_long gWSavePtr;
                 /* eaclib EACPSXZ systask */
extern void  Sched_AddFunction(Sched_tSchedule *s, void (*fn)(void *), void *arg, int hz);
extern void AICop_CleanUp(void);
extern void AICop_Restart(void);
extern void AICop_StartUp(void);
extern void AIHigh_CleanUp(void);
extern void AIHigh_Execute(void);
extern void AIHigh_Restart1(void);
extern void AIHigh_Restart2(void);
extern void AIHigh_StartUp(void);
extern void AIInit_CleanUp1(void);
extern void AIInit_CleanUp2(void);
extern void AIInit_Reset1(void);
extern void AIInit_Reset2(void);
extern void AIInit_StartUp1(void);
extern void AIInit_StartUp2(void);
extern void AudioClc_SoundCars(void);
extern void AudioCmn_GetAsyncSfx(int, int, bool);
extern void AudioCmn_Init(void);
extern void AudioCmn_Pause(void);
extern void AudioCmn_PlaySound(int, int, int, int, int);
extern void AudioCmn_UnPause(void);
extern void AudioCmn_UnPauseAndQuit(void);
extern void AudioCmn_UnPauseAndRestart(void);
extern void AudioMus_SwitchSong(void);
extern void Camera_NextMode(int);
extern void Camera_Update(void);
extern void CarIO_CleanUp(void);
extern void CarIO_StartUp(void);
extern void Cars_CheckForAccidentScenes(void);
extern void Cars_CleanUp(void);
extern void Cars_ManageBureaucracy(void);
extern void Cars_Restart(void);
extern void Cars_StartUp(void);
extern void Collide_ClearCollisionRegistry(void);
extern void DashHUD_ToggleHud(int);
extern void FastRandom_CleanUp(void);
extern void FastRandom_StartUp(unsigned int);
extern void Force_Disable(void);
extern void Force_Pause(void);
extern void Force_UnPause(void);
extern void Hud_BTC_QuitOut(void);
extern void Hud_Reset(void);
extern int Input_MainExitKey(void);
extern void Loading_UpdateLoadingScreen(int);
extern void MPause_EndPauseMenu(void);
extern int MPause_Logic(void);
extern void R3DCar_CleanUp(void);
extern void R3DCar_PostStartUp(void);
extern void R3DCar_Restart(void);
extern void R3DCar_StartUp(void);
extern void Render_Render(int);
extern void Render_RestartTrackRender(void);
extern void Replay_GetInterfaceKey(void);
extern void Sched_CleanUpSchedule(Sched_tSchedule *);
extern Sched_tSchedule *Sched_CreateNewSchedule(char *, int);
extern void Sched_DeleteFunction(Sched_tSchedule *, void (*)(void *), void *);
extern void Sched_Execute(Sched_tSchedule *);
extern void SimQueue_CleanUp(void);
extern void SimQueue_Reset(void);
extern void SimQueue_SetCurrentInput(int);
extern void Stats_ClearPosition(void);
extern void Stats_DoPlayerGlue(void);
extern void Stats_ExtrapolateOpponentTimes(int);
extern void Stats_TrackEndGame(void);

extern Sim_ClockCodegenView clock_realTime asm("clock_realTime");
extern int counter[4];
extern char countdown;   /* byte global (defined `char countdown;` in audiocmn.cpp @0x8013c63c) -> sb store */
extern int Input_gTime;
extern int InBetween;
extern int unPauseDelay;
extern int skipRender;
extern int quitType;

extern "C" {
void *SetSp(...);
int systemtask(...);
}

#endif
