/* game/common/aistate_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- aistate.obj manual vtable symbols (cross-TU; g++ 2.7.2 _vt_<class>) ---- */
extern __vtbl_ptr_type AIState_Base_vtable[], AIState_Normal_vtable[], AIState_NonActive_vtable[],
  AIState_Idle_vtable[], AIState_Chase_vtable[], AIState_Offroad_vtable[], AIState_Purgatory_vtable[],
  AIState_RovingTraffic_vtable[], AIState_Donuts_vtable[], AIState_GotoSlice_vtable[], AIState_Cruise_vtable[];

/* ---- SS3.23 deleting-dtor free fns (SaveSurface/ObjectFinishedSignAnim pattern): the oracle
   is a real per-class deleting dtor for each of these (not a base-forward that gcc's default
   non-polymorphic-single-inheritance member-dtor synthesis would produce), so the ABI shape is
   hand-written as an extern "C" free fn taking the raw (self,__in_chrg) pair. ---- */
extern void  __builtin_delete(void *);
extern "C" void ___14AIState_Normal(AIState_Normal*,int);
extern "C" void ___17AIState_NonActive(AIState_NonActive*,int);
extern "C" void ___13AIState_Chase(AIState_Chase*,int);
extern "C" void ___17AIState_GotoSlice(AIState_GotoSlice*,int);
extern "C" void ___12AIState_Idle(AIState_Idle*,int);
extern "C" void ___15AIState_Offroad(AIState_Offroad*,int);
extern "C" void ___17AIState_Purgatory(AIState_Purgatory*,int);
extern "C" void ___21AIState_RovingTraffic(AIState_RovingTraffic*,int);
extern "C" void ___14AIState_Donuts(AIState_Donuts*,int);
extern "C" void ___14AIState_Cruise(AIState_Cruise*,int);

extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj      *Cars_gSortedList[];
extern GameSetup_tData   GameSetup_gData;
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern int                 AI_elapsedTime;     /* ai.cpp    @0x8013C554 */
extern Trk_NewSlice  *BWorldSm_slices;
extern int                 Cars_gNumTrafficCars;
extern int            Cars_gNumCars;
extern int            gNumSlices;
extern int       Cars_gNumHumanRaceCars;
extern int AITune_LifeTimer[];
extern int AIWorld_CheckForBarrierBetweenLanes(int slice,int lane0,int lane1);
extern int Newton_CalculateRoadPositionFromSliceAndPosition(int slice,coorddef *position,matrixtdef *matrix);
extern u_int               fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */
extern void *AITune_MaxTraffic[];
extern void Newton_SetInitialSlicePositionOrientationEtc(BO_tNewtonObj *n,int slice,coorddef *offset,int direction);
int AIWorld_ApxSplineDistance(Car_tObj *a, Car_tObj *b);
int AIWorld_ApxSplineDistance(Car_tObj *a, int slice);
int AIWorld_ApxSplineDistance(int slice, Car_tObj *b); /* overloaded */
int AIWorld_SplineDistance(Car_tObj *a, Car_tObj *b);
int AIWorld_SplineDistance(Car_tObj *a, int slice, coorddef *out); /* overloaded in AIWORLD.obj */
void AIScript_ProcessActionsAndReactions(AIScript_t *script, int flags);
void AISpeeds_CalcDesiredSpeed(Car_tObj *carObj);
void AISpeeds_CalcTrafficTopSpeed(Car_tObj *carObj);
void AI_GenericBeginCycle(Car_tObj *carObj);
void AI_GenericCycle(Car_tObj *carObj);
void AI_GenericEndCycle(Car_tObj *carObj);
void AI_TargetLane(Car_tObj *carObj, int lane);
void AudioClc_HonkHorn(Car_tObj *carObj, int a, int b, int c);
/* AIDelayCar ctor/SetNewTargetCar/Update now used as C++ members (aidelaycar.obj) -- flat externs removed */

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
