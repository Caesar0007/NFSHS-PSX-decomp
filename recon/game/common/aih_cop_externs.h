/* game/common/aih_cop_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "aih_cop_types.h"

/* ---- vtables: AIHigh_Traffic (this obj) + AIState_Idle (aistate.obj) ---- */

extern AICop_spikeBelt_t AICop_spikeBelt;
extern AIHigh_Base *highLevelAIObjs[];
extern AITrigger_TriggerManager *triggerManagerCops;
extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj      *Cars_gRaceCarList[];      /* 0x8010fa00 */
extern Car_tObj * AILife_IsSliceInAnyVisibleArea(int slice);
extern Car_tObj *Cars_gTotalSortedList[];
extern int GameSetup_gData[650]; /* word view (2600 bytes): retail aih_cop.obj records no GameSetup_tData */
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
inline int AIState_Chase::IsSlowingDown() { return simGlobal.gameTicks < slowDownEndTime_; }   /* aistate.h:184 body, here after simGlobal (retail HighExecute inlines it) */
extern Trk_NewSlice  *BWorldSm_slices;
extern copTuning_t copTuningInfo[];
extern volatile int        generic128HzClock; extern int stackSpeedUpEnbabledFlag;
extern int               Cars_gNumRaceCars;
extern int            Cars_gNumCars;
extern int            gNumSlices;
extern int       Cars_gNumHumanRaceCars;
extern int AICop_NoCopsInArea(int slice,int sliceDistance);
extern AICop_RoadBlockState AICop_gRoadBlockState;
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
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/eac_math.h"
}
/* AITrigger_TriggerManager::DescribeTrigger/CheckForTriggerAtSlice/GetTrigger now C++ members (aitriger.obj) -- flat externs removed */

/* Prototypes for callees this TU used to call undeclared: CC1PLPSX 2.8.0 accepts the implicit `int f(...)` but wraps
   every such call statement in nested debug scopes retail's SYM does not have (tools/psyq_pipe/implicit_sweep.py). */
extern "C" unsigned long SetSp(unsigned long);

/* The PRNG step CheckForWipeOut reads: retail's SLD/SYM record it as a header inline (its block pair
   carries the caller's line, its loads the caller's statement line), not a .cpp-local one. */
static inline int AI_Rand(void)
{
  randtemp = fastRandom * randSeed;
  fastRandom = randtemp & 0xffff;
  return (int)((randtemp >> 8) & 0xffff);
}

/* HighExecute's trigger dispatch switches on this one-parameter inline (see aih_traf.cpp): its post-inline
   line note tags the dispatch with the switch's closing line, and its record sits after the case bodies. */
static inline int TriggerType(int *type) { return *type; } /* int view of trigger_t.any.type: retail aih_cop.obj has no trigger_t TPDEF here (run `CarBank coorddef AIHigh_BasicCop`) and HighExecute records no inlined formal */
static inline int NumRaceCars(void) { return Cars_gNumRaceCars; }
static inline int NumHumanRaceCars(void) { return Cars_gNumHumanRaceCars; }
static inline int PerpChase_CopFreeTicks(int *copFreeTicks) { return *copFreeTicks; } /* int view: retail records no 22nd AICop_PerpChaseInfo here */
static inline copLevel_t *PerpChase_ChaseLevel(void *chaseLevel) { return *(copLevel_t **)chaseLevel; } /* untyped view: no PerpChaseInfo record */


























#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
