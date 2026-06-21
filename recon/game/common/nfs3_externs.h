/* game/common/nfs3_externs.h -- auto-generated cross-TU decls for nfs3.cpp */
#ifndef _GAME_COMMON_NFS3_EXTERNS_H_
#define _GAME_COMMON_NFS3_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"
#include "new.h"

/* cross-TU globals + unmangled lib fns referenced by nfs3.obj */
extern int _6Speech_fgUndefined;            /* Speech::fgUndefined (Speaker*) */
extern int _6Speech_fgSpeech;               /* Speech::fgSpeech (Speech*) */
extern __vtbl_ptr_type Speaker_vtable[];     /* @0x80055dc4  Speech::Speaker vtable (defined in speech.cpp); Ghidra fabricated the name "Speech_Speaker_vtable" for this same VA */
// [owned->defined in nfs3.cpp] extern char befuddleExtensions[][4];
extern char *Paths_Paths[];
extern GameSetup_tData GameSetup_gData;
// [owned->defined in nfs3.cpp] extern tfrontEnd frontEnd;
extern Sim_tSimSystemVar simVar;
extern Car_tObj **Cars_gList;
extern Car_tObj *Cars_gHumanRaceCarList[];
extern Car_tStats *Cars_gNewCarStatsList;
// [owned->defined in nfs3.cpp] extern int Cars_gNumHumanRaceCars, gUseFrontend, quitType;
extern int Cars_gNumHumanRaceCars, quitType;
extern int *gFileMem, *gFileHandleTable;
extern tReplayInterface Replay_ReplayInterface;
extern int Replay_ReplayMode, ComingIntoTheFrontEndTheVeryFirstTime, CF_DVLC;
// [owned->defined in nfs3.cpp] extern tCarManager carManager; extern tTrackManager trackManager;
// [owned->defined in nfs3.cpp] extern tTournamentManager tournamentManager; extern tMissionManager missionManager;
extern unsigned char bigBuf[];
extern void trap(unsigned int);
                   /* GCC global-ctor caller (crt0) */
/* libc / eaclib / libgpu / libetc (unmangled) */
extern void restoretextdraw(void);

extern int AudioClc_StartUp(void);
extern int AudioCmn_DeInit(void);
extern int AudioCmn_LoadGameSamples(void);
extern int AudioCmn_Reset(void);
extern int AudioMus_BuildPlayList(int, int*);
extern int AudioMus_PlaySong(char*);
extern int AudioMus_SysStartUp(int, int, char*);
extern int Audio_DeInitDriver(void);
extern int Audio_InitDriver(int, int);
extern int BWorld_DeInit(void);
extern int BWorld_Init(void);
extern int BWorld_Restart(void);
extern int Camera_Init(void);
extern int Camera_Kill(void);
extern int Clock_SystemCleanUp(void);
extern int Clock_SystemStartUp(void);
extern int CopSpeak_CleanUp(void);
extern int CopSpeak_StartUp(void);
extern int DashHUD_ResetHUD(void);
extern int Draw_DirectSetEnvironment(int, int, int, int, int, int, int, int, int, int);
extern int FECheat_ActivateBonus(tCheatCode);
extern int Front_BuildStream(int*);
extern int Front_GetInGameVars(void);
extern int Front_InitGraphics(void);
extern int Front_InitGraphicsAndDisplayLoading(void);
extern int Front_Menu(tFront_ProcessingType);
extern int GameSetup_CleanUp(void);
extern int GameSetup_StartUp(int*);
extern int Hrz_InitHorizon(void);
extern int Hrz_KillHorizon(void);
extern int Hud_InitMap(void);
/* tCar/Track/Mission/TournamentManager::Initialize/LoadDescription now called as C++ members (front.obj) -- flat externs removed */
extern int Loading_DrawLoadingScreen(void);
extern int Loading_GetInitialMemory(void);
extern int Loading_UpdateLoadingScreen(int);
extern int MinFront_ParseOptions(void);
extern int Night_InitNightDriving(void);
extern int Physics_CheckGamedata(void);
extern int Platform_DebuggerPollHost(void);
extern int Platform_InitMemory(void);
extern int Platform_ResetDCTBuffer(void);
extern int Platform_SysStartUp(void);
/* tCar/Track/Mission/TournamentManager::ReleaseDescription now C++ members (front.obj) -- flat externs removed */
extern int Render_InitLibRender(void);
extern int Render_InitPauseMenu(void);
extern int Render_InitTrackRender(void);
extern int Render_InitTrackRenderPostSim(void);
extern int Render_KillPauseMenu(void);
extern int Render_KillTrackRender(void);
extern int Replay_InitReplay(void);
extern int Replay_ResetReplay(void);
extern int Replay_StoringReplay(void);
/* tCarManager::SetClassViewable now called as C++ member (front.obj) -- flat extern removed */
extern int SimQueue_StartUp(void);
extern int Sim_CleanUp(void);
extern int Sim_MainGameLoop(void);
extern int Sim_Restart(void);
extern int Sim_StartUp(void);
extern int Speech_ct(Speech *);
extern int Stats_GetNumOpponents(void);
extern int Weather_DeInit(void);
extern int Weather_Init(void);
extern int Weather_Restart(void);
extern void Speech_Reset();
extern void Speech_dt(Speech *, int);

#endif
