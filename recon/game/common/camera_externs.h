/* game/common/camera_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

AnimScript *Anim_GetAnim(int handle);
CARDINFO_def *MCRD_getcard(...);
extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj **Cars_gList;
extern GameSetup_tData   GameSetup_gData;
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern Sim_tSimSystemVar simVar;
extern Trk_NewSlice  *BWorldSm_slices;
extern int                numValidCams;              /* 0x8013d3f0 */
extern int               Replay_ReplayMode;          /* replay.obj */
extern int            Cars_gNumCars;
extern int            Input_gLookBehind[2];
extern int            gNumSlices;
extern int       Cars_gNumHumanRaceCars;
extern int   BWorldSm_FindClosestQuadRez(coorddef *c, BWorldSm_Pos *pos, int rez);
extern int InBetween;
extern int Math_Dist3D(coorddef *a,coorddef *b);
extern int Newton_FindGroundElevationGeneral(coorddef *point,coorddef *normal,coorddef *pointOnQuad);
extern tReplayCameraModes Replay_ReplayCamera[2];    /* 0x8011704c */
extern tReplayInterface Replay_ReplayInterface;
extern void  Math_fasttransmult(matrixtdef *a, matrixtdef *b, matrixtdef *out);
extern void *BWorldSm_TunnelFlagSm(BWorldSm_Pos *pos);
extern void *BWorldSm_UNormal(BWorldSm_Pos *pos);
extern void Replay_ReplayFindClosestCamera(int player,int slice);
extern void TrsProj_SetProjection(int cx,int cy,int w,int h);
extern void TrsProj_SetViewTrsProjEnviro(DRender_tView *Vi);
int  Math_VectorLength(coorddef *v);
int Anim_FreeHandle(int handle);
int Anim_GetLastAnimPosRot(int animNum, int flags, coorddef *pt, matrixtdef *mat);
int Anim_Handle(int num);
int BWorldSm_FindClosestQuadMaxIterations(coorddef *pt, BWorldSm_Pos *slicePos, int maxIterations);
 /* @0x800EAD98 eaclib arccos, verify #148 */
 /* @0x800EADBC eaclib: out-args *sin/*cos dropped by Ghidra, verify #148 */
void Math_NormalizeVector(coorddef *v);
 /* eaclib trnsfrm, verify #148 */

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
