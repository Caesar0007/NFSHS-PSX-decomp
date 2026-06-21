/* game/common/aih_cop_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- vtables: AIHigh_Traffic (this obj) + AIState_Idle (aistate.obj) ---- */
extern __vtbl_ptr_type AIHigh_Cop_vtable[], AIState_Idle_vtable[];

CARDINFO_def *MCRD_getcard(...);
int Speech_Mobile(Car_tObj *carObj);   /* speech.obj flat (was Mobile__6SpeechP8Car_tObj; cast result to Speaker*) */
extern AICop_spikeBelt_t AICop_spikeBelt;
extern AIHigh_Base *highLevelAIObjs[];
extern AITrigger_TriggerManager *triggerManagerCops;
extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj      *Cars_gRaceCarList[];      /* 0x8010fa00 */
extern Car_tObj * AILife_IsSliceInAnyVisibleArea(int slice);
extern Car_tObj *Cars_gTotalSortedList[];
extern GameSetup_tData   GameSetup_gData;
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern Trk_NewSlice  *BWorldSm_slices;
extern copTuning_t copTuningInfo[];
extern int                 generic128HzClock, stackSpeedUpEnbabledFlag;
extern int               Cars_gNumRaceCars;
extern int            Cars_gNumCars;
extern int            gNumSlices;
extern int       Cars_gNumHumanRaceCars;
extern int AICop_NoCopsInArea(int slice,int sliceDistance);
extern int AICop_gRoadBlockState;
extern int AILife_EvaluateLife(Car_tObj *carObj);
extern int AITune_gRoughLapTime;
extern u_int               fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */
extern u_long gWSavePtr;
extern void AILife_ReencarnateCopByLatPosAndRotation(Car_tObj *carObj,int slice,int travelDirection,int latPos,int rotation1024);
extern void AILife_ReencarnateCopByPosition(Car_tObj *carObj,int slice,int travelDirection,coorddef *pos,matrixtdef *ori);
extern void AILife_ReencarnateCopBySlice(Car_tObj *carObj,int slice,int travelDirection,int roadSide,int moving);
extern void AIPhysic_ChangeDirection(Car_tObj *carObj,int time);
extern void BWorld_SetSpikeBelt(int slice,int x,int width);
extern void Cars_ResetCollidedCars(Car_tObj *carObj,int forceReset,int forceParkAtSide);
int AIWorld_ApxSplineDistance(Car_tObj *a, Car_tObj *b);
int AIWorld_ApxSplineDistance(Car_tObj *a, int slice);
int AIWorld_ApxSplineDistance(int slice, Car_tObj *b);
void  trap(int code);
/* AITrigger_TriggerManager::DescribeTrigger/CheckForTriggerAtSlice/GetTrigger now C++ members (aitriger.obj) -- flat externs removed */

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
