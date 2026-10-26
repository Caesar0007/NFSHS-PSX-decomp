/* game/common/audiotrk_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AUDIOTRK_EXTERNS_H_
#define _GAME_COMMON_AUDIOTRK_EXTERNS_H_

/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/fixdmult.h"
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/random.h"
#include "eaclib/psx/eacpsxz/systask.h"
#include "eaclib/psx/eacpsxz/timer.h"
}
extern "C" {
int SNDmemlargestunused(unsigned char **out);
int SNDover(...);
u_short PAD_state(int padID);
}

extern CAudioList *gGameAudioList;
extern DRender_tCalcView AudioClc_gRenderView;
extern GameSetup_tData GameSetup_gData;
extern Sim_tSimGlobalVar simGlobal;
extern Trk_AnimateInst * Anim_gInstanceFromIndex[8];
/* Owner-derived bworldSm type, SYM1cec71..1cedc3. The original foreign
 * header visibility is not established by AudioTrk's surviving type stream. */
#include "shared/Trk_NewSlice.h"






extern Trk_NewSlice *BWorldSm_slices; /* SYM1d937e */
extern int   AudioCmn_GetAsyncSfx(int bank, int patch, bool checkonly); /* SYM191b4b..191b70 */
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
