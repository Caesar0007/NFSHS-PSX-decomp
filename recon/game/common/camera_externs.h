/* game/common/camera_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "camera_types.h"

struct AnimScript;
struct CARDINFO_def;

AnimScript *Anim_GetAnim(int handle);
int Camera_AnimGetTimedAnimPosRot(AnimScript *, coorddef *, matrixtdef *)
    asm("GetTimedAnimPosRot__10AnimScriptP8coorddefP10matrixtdef");
extern "C" CARDINFO_def *MCRD_getcard(int);
extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj *Cars_gList[];   /* real ARRAY @0x8010F9DC (asm/data), NOT ptr-to-ptr - la form */
/* These externally-owned aggregate bodies are absent from camera.obj's retail
 * SYM graph.  Keep their exact symbols and source field offsets without
 * importing unrelated foreign type definitions into this translation unit. */
extern GameSetup_tData GameSetup_gData;
extern int Camera_SimGlobalWords[] asm("simGlobal");
extern int Camera_SimVarWords[] asm("simVar");
extern u_char (*Camera_BWorldSmSlices)[32] asm("BWorldSm_slices");
#define CAMERA_SLICE_CENTER(slice) ((coorddef *)&Camera_BWorldSmSlices[(slice)][0])
#define CAMERA_SLICE_FORWARD(slice, axis) ((signed char)Camera_BWorldSmSlices[(slice)][0x0f + (axis)])
#define CAMERA_SLICE_RIGHT(slice, axis) ((signed char)Camera_BWorldSmSlices[(slice)][0x12 + (axis)])
#define CAMERA_SLICE_PAVED_PROFILE(slice) (*(short *)&Camera_BWorldSmSlices[(slice)][0x16])
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
extern linedef Camera_ReplayCamera[] asm("Replay_ReplayCamera");
extern int Camera_ReplayInterfaceWords[] asm("Replay_ReplayInterface");
#define CAMERA_REPLAY_DEFAULT(player) Camera_ReplayCamera[(player)].start
#define CAMERA_REPLAY_MODE(player) Camera_ReplayCamera[(player)].colour
extern void  Math_fasttransmult(matrixtdef *a, matrixtdef *b, matrixtdef *out);
extern bool BWorldSm_TunnelFlagSm(BWorldSm_Pos *pos);
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
extern "C" int fixedmult(int, int);
extern "C" int fixeddiv(int, int);
extern "C" int memset(...);
extern "C" void transform(...);
extern "C" void transpose(...);
 /* eaclib trnsfrm, verify #148 */

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
