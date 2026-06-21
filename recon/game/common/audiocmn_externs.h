/* game/common/audiocmn_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AUDIOCMN_EXTERNS_H_
#define _GAME_COMMON_AUDIOCMN_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

CARDINFO_def *MCRD_getcard(...);
extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj **Cars_gList;
extern GameSetup_tData   GameSetup_gData;
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern camera_info       Camera_gInfo[2];            /* camera.obj */
extern char *Audio_gLangAssignmentTable[];
extern char *gAudioBasePath;
extern char GameSetup_gCarNames[51][5];
extern int            gNumSlices;
extern int       Cars_gNumHumanRaceCars;
extern int  Stats_GetNumOpponents(void);                                            /* stats.obj */
extern int  Stats_GetPosition(Car_tObj *car);                                       /* stats.obj */
extern int  gMasterFENarrationLevel, gStereoMode, Audio_direct3davail;
extern int AudioCmn_LoadBank(char *filename,int BankNum);
extern int AudioEng_StartUp(int player,char *carname);
extern int CopSpeak_GetEnginePatch(int type,int timbre);
extern int CopSpeak_Request(CopSpeak_tRequest *r);
extern int CopSpeak_SfxQueued(void);
extern int Weather_GetNumParticles(int player);
extern tReplayInterface Replay_ReplayInterface;
extern void *BWorldSm_TunnelFlagSm(BWorldSm_Pos *pos);
extern void AudioEng_Resume(void);
extern void AudioEng_Set(int player,int vol,int esp,int gas,int cam,int dop,int azi,int dir);
extern void AudioEng_StartServer(void);
extern void AudioTrk_StartUp(void);
extern void CopSpeak_InitRequest(CopSpeak_tRequest *r);
struct Audio_tFESFXTable { int languages; unsigned char audioCounter; }; extern struct Audio_tFESFXTable Audio_gFESFXTable;
void  trap(int code);
void AudioMus_Volume(int);

#endif /* _GAME_COMMON_AUDIOCMN_EXTERNS_H_ */
