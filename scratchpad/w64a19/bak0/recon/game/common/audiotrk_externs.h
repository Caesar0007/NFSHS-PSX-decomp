/* game/common/audiotrk_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AUDIOTRK_EXTERNS_H_
#define _GAME_COMMON_AUDIOTRK_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern CAudioList *gGameAudioList;
extern DRender_tCalcView AudioClc_gRenderView;
extern GameSetup_tData   GameSetup_gData;
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern Trk_AnimateInst * Anim_gInstanceFromIndex[8];
extern Trk_NewSlice  *BWorldSm_slices;
extern int   AudioCmn_GetAsyncSfx(int a, int b, bool c);
extern int   DrawW_GetAnimationTime(Trk_AnimateInst *animInst);
extern int  Anim_GetPos(Trk_AnimateInst *animInst, int flags, int ticks, coorddef *pt, int *animTicks, int *animLength);
extern int CopSpeak_gNumTrackSfx;
extern int Math_Dist3D(coorddef *a,coorddef *b);
extern int gMasterAmbientLevel;
extern void  BWorldSm_SetSlice(int slice, BWorldSm_Pos *pos);
extern void CopSpeak_Server(void);
int  BWorldSm_FindClosestSlice(coorddef *pt, BWorldSm_Pos *slicePos);
int AudioClc_CalcAzimuth(DRender_tCalcView *view, coorddef *object);
int AudioClc_CalcDopplerShiftRatio(coorddef *objectPos, coorddef *objectVel);
int AudioCmn_PlaySFX(int a, int b, int c, int d, int e, int f);
void  trap(int code);
void freeVoiceChannel(int sndPlayer);

#endif /* _GAME_COMMON_AUDIOTRK_EXTERNS_H_ */
