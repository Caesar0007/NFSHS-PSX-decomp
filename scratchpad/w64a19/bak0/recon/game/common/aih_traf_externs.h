/* game/common/aih_traf_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "../../nfs4_types.h"

/* ---- vtables: AIHigh_Traffic (this obj) + AIState_Idle (aistate.obj) ---- */
extern __vtbl_ptr_type AIHigh_Traffic_vtable[], AIState_Idle_vtable[];

extern AIHigh_Traffic *highLevelAIObjs[];
extern AITrigger_TriggerManager *triggerManagerTraffic;
extern Car_tObj * AILife_IsSliceInAnyVisibleArea(int slice);
extern Car_tObj *Cars_gCopCarList[];
extern Car_tObj *Cars_gTotalSortedList[];
extern Trk_NewSlice  *BWorldSm_slices;
extern int            Cars_gNumCars;
extern int            gNumSlices;
extern int AILife_EvaluateLife(Car_tObj *carObj);
extern int Cars_gNumCopCars;
extern u_int               fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */
extern void AILife_ReencarnateTraffic(Car_tObj *carObj);
extern void Newton_SetInitialSlicePositionOrientationEtc(BO_tNewtonObj *n,int slice,coorddef *offset,int direction);
int  BWorldSm_FindClosestSlice(coorddef *pt, BWorldSm_Pos *slicePos);
int AIWorld_ApxSplineDistance(Car_tObj *a, Car_tObj *b);
int AIWorld_ApxSplineDistance(Car_tObj *a, int slice);
int AIWorld_ApxSplineDistance(int slice, Car_tObj *b);
void AILife_ReencarnateTrafficByPosition(Car_tObj *carObj, int a, int b, coorddef *pt, matrixtdef *mat);
/* AITrigger_TriggerManager::CheckForTriggerAtSlice/GetTrigger/DescribeTrigger now called as C++ members (aitriger.obj) -- flat externs removed */

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
