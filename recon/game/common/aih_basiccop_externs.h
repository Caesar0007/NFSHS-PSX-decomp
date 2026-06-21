/* game/common/aih_basiccop_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- vtable: AIHigh_BasicCop (this obj) ---- */
extern __vtbl_ptr_type AIHigh_BasicCop_vtable[];

int Speech_Mobile(Car_tObj *carObj);   /* speech.obj flat free fn (was mangled Mobile__6SpeechP8Car_tObj; Speech::Mobile is a static, reconstructed flat) */
extern AICop_spikeBelt_t AICop_spikeBelt;
extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj * AILife_IsSliceInAnyVisibleArea(int slice);
extern Group              *Object_customSFXInst;     /* 0x8013d2d0 */
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern Trk_NewSlice  *BWorldSm_slices;
extern int                 Object_customSliceNum;    /* 0x8013d2d4 */
extern int   BWorldSm_FindClosestQuadRez(coorddef *c, BWorldSm_Pos *pos, int rez);
extern int   Cars_topSpeedCap[22];              /* [carType] */
extern int AICop_gRoadBlockState;
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

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
