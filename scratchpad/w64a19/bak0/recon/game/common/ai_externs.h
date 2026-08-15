/* game/common/ai_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern AIDataRecord_BestLine_t *AIDataRecord_BestLine;   /* @0x8013c5a0 */
extern Car_tObj      *Cars_gSortedList[];
extern Car_tObj * AILife_IsCarInAnyVisibleArea(Car_tObj *carObj);
extern Car_tObj *Cars_gList[];
extern Car_tObj *Cars_gHumanRaceCarList[];
extern Car_tObj *Cars_gTotalSortedList[];
extern GameSetup_tData   GameSetup_gData;
extern Group              *Object_customObjInst;     /* 0x8013d2c8 */
extern Group              *Object_customSimObjs;     /* 0x8013d2cc */
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern Trk_NewSlice  *BWorldSm_slices;
extern int                 Cars_gNumCopCars;
extern int                 Cars_gNumTrafficCars;
extern int                AITune_driveSide;
extern int            Cars_gNumCars;
extern int            gNumSlices;
extern int       Cars_gNumHumanRaceCars;
extern int   Cars_gNumAIRaceCars;
extern int AIScript_DoReAction(AIScript_t *script,AIScript_tAIReaction testReaction);
extern int AIScript_GetReactionTicksLeft(AIScript_t *script);
extern int AITune_oneWay;
extern int AIWorld_CalcLateralVelocity(Car_tObj *carObj);
extern int AIWorld_CalculateDeltaRoadYaw(Car_tObj *carObj);
extern int AIWorld_GameOdometer(Car_tObj *carObj);
extern int AIWorld_GetProfileMask(int laneIndex);
extern int AIWorld_IsDriveableLane_UsingMask(int slice,int mask);
extern int AIWorld_LaneIndex(int slice,int position);
extern int BWorld_GetSpikeBelt(int *slice,int *x,int *width);
extern u_int               fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */
extern void  BWorldSm_SetSlice(int slice, BWorldSm_Pos *pos);
extern void AIScript_SubmitPlayerAction(AIScript_t *script,int humCarIndex,AIScript_tPlayAction playerAction, int currentTime64);
extern void AudioClc_SetHorn(Car_tObj *car,int state);
int  BWorldSm_FindClosestSlice(coorddef *pt, BWorldSm_Pos *slicePos);
int AIWorld_ApxSplineDistance(Car_tObj *a, Car_tObj *b);
int AIWorld_SplineDistance(Car_tObj *a, Car_tObj *b);
void  trap(int code);
void AudioClc_HonkHorn(Car_tObj *carObj, int a, int b, int c);

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
