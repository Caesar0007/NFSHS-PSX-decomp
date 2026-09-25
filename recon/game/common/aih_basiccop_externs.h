/* game/common/aih_basiccop_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "aih_basiccop_types.h"

/* ---- vtable: AIHigh_BasicCop (this obj) ---- */

extern AICop_spikeBelt_t AICop_spikeBelt;
extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj * AILife_IsSliceInAnyVisibleArea(int slice);
extern Group              *Object_customSFXInst;     /* 0x8013d2d0 */
extern Trk_NewSlice  *BWorldSm_slices;
extern int                 Object_customSliceNum;    /* 0x8013d2d4 */
extern int   BWorldSm_FindClosestQuadRez(coorddef *c, BWorldSm_Pos *pos, int rez);
extern int   Cars_topSpeedCap[22];              /* [carType] */
extern int AICop_gRoadBlockState; /* retail owner emits no enum tag */
#define kAICop_RoadBlockState_None 0
#define kAICop_RoadBlockState_PerpPassed 2
extern int GetPlaneY(const coorddef *norm,const coorddef *pointOnPlane,const coorddef *testPoint);
extern int Object_FindDefWithThisID(int ID);
extern int Object_GetObjDefID(int index);
extern u_int               fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */
extern void  BWorldSm_SetSlice(int slice, BWorldSm_Pos *pos);
extern void *BWorldSm_UForward(BWorldSm_Pos *pos);
extern void *BWorldSm_UNormal(BWorldSm_Pos *pos);
extern void BWorld_InitSpikeBelt(void);
extern void Object_AddCustomObject(SceneElem *elem, int setupSimDataFlag);
extern void Object_ClearCustomObjects(void);
extern "C" int fixedmult(int, int);
extern "C" void __builtin_delete(void *);

/* Prototypes for callees this TU used to call undeclared: CC1PLPSX 2.8.0 accepts the implicit `int f(...)` but wraps
   every such call statement in nested debug scopes retail's SYM does not have (tools/psyq_pipe/implicit_sweep.py). */
extern "C" void transpose(matrixtdef *src, matrixtdef *dst);

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
