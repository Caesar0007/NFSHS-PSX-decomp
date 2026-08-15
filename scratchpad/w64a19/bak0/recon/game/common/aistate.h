/* game/common/aistate.h — reconstructed from game/common/aistate.cpp, game/common/aistate.h (64 fns) */
#ifndef _GAME_COMMON_AISTATE_H_
#define _GAME_COMMON_AISTATE_H_
#include "../../nfs4_types.h"

void AIState_StartUp__Fv(void);   /* :25 */
void AIState_Restart__Fv(void);   /* :30 */
void AIState_CleanUp__Fv(void);   /* :36 */
void StateExecute__12AIState_Base(AIState_Base *self);   /* :56 */
void * __12AIState_BaseP8Car_tObj(AIState_Base *self, Car_tObj *carObj);   /* :73 */
void Execute__14AIState_Normal(AIState_Normal *self);   /* :94 */
void * __14AIState_NormalP8Car_tObj(AIState_Normal *self, Car_tObj *carObj);   /* :105 */
void Execute__12AIState_Idle(AIState_Idle *self);   /* :129 */
void SetIdlePosition__12AIState_Idlei(AIState_Idle *self, int roadPosition);   /* :154 */
void * __13AIState_ChaseP8Car_tObjT1P8coorddefiiiii(AIState_Chase *self, Car_tObj *carObj, Car_tObj *targetCar, coorddef *relPosition, int nitrousTicks, int nitrousMinForeDistance, int nitrousMinAftDistance, int aggressionLevel, int delayTime);   /* :180 */
void ___13AIState_Chase(AIState_Chase *self, int __in_chrg);   /* :205 */
void SetTarget__13AIState_ChaseP8Car_tObjP8coorddef(AIState_Chase *self, Car_tObj *targetCar, coorddef *relPosition);   /* :216 */
void SetMurderMode__13AIState_Chaseii(AIState_Chase *self, int murderMode, int murderTicks);   /* :240 */
void SetUp__13AIState_Chase(AIState_Chase *self);   /* :252 */
void DoSlowNitrous__13AIState_Chase(AIState_Chase *self);   /* :287 */
void DoNitrous__13AIState_Chasei(AIState_Chase *self, int checkForHumans);   /* :296 */
void Execute__13AIState_Chase(AIState_Chase *self);   /* :327 */
void FarTargeting__13AIState_Chase(AIState_Chase *self);   /* :414 */
int CalculateCloseTargettingAheadSlowDownFactor__13AIState_Chase(AIState_Chase *self);   /* :443 */
void CloseTargeting__13AIState_Chase(AIState_Chase *self);   /* :462 */
void ApproachTargeting__13AIState_Chasei(AIState_Chase *self, int intercept);   /* :637 */
void CheckForBarriersAndTargetAroundThem__13AIState_Chase(AIState_Chase *self);   /* :718 */
int FindBarrierEndSlice__13AIState_Chase(AIState_Chase *self);   /* :764 */
void ___15AIState_Offroad(AIState_Offroad *self, int __in_chrg);   /* :887 */
void * __15AIState_OffroadP8Car_tObjiP8coorddefP10matrixtdefiii(AIState_Offroad *self, Car_tObj *carObj, int startSlice, coorddef *position, matrixtdef *orientation, int maxSpeedKPH, int releaseTime, int endSlice);   /* :896 */
void UnleashIfInRange__15AIState_OffroadP8Car_tObj(AIState_Offroad *self, Car_tObj *car);   /* :926 */
void Execute__15AIState_Offroad(AIState_Offroad *self);   /* :944 */
void * __17AIState_PurgatoryP8Car_tObj(AIState_Purgatory *self, Car_tObj *carObj);   /* :1001 */
void ___17AIState_Purgatory(AIState_Purgatory *self, int __in_chrg);   /* :1021 */
int TestForRelease__17AIState_Purgatory(AIState_Purgatory *self);   /* :1048 */
void Execute__17AIState_Purgatory(AIState_Purgatory *self);   /* :1068 */
void StartUp__17AIState_Purgatory(void);   /* :1090 */
void * __21AIState_RovingTrafficP8Car_tObjP9trigger_t(AIState_RovingTraffic *self, Car_tObj *carObj, trigger_t *trigger);   /* :1103 */
void CheckIfCarIsNearbyAndStop__21AIState_RovingTrafficP8Car_tObjRi(AIState_RovingTraffic *self, Car_tObj *otherCarObj, int *status);   /* :1130 */
void Execute__21AIState_RovingTraffic(AIState_RovingTraffic *self);   /* :1172 */
void ___14AIState_Donuts(AIState_Donuts *self, int __in_chrg);   /* :1248 */
void Execute__14AIState_Donuts(AIState_Donuts *self);   /* :1256 */
void * __17AIState_GotoSliceP8Car_tObjii(AIState_GotoSlice *self, Car_tObj *carObj, int targetSlice, int stopWhenArrivedAtSlice);   /* :1348 */
void Execute__17AIState_GotoSlice(AIState_GotoSlice *self);   /* :1355 */
int InTargetSliceRange__17AIState_GotoSlicei(AIState_GotoSlice *self, int rangeMeters);   /* :1395 */
void * __14AIState_CruiseP8Car_tObj12cruiseMode_ti(AIState_Cruise *self, Car_tObj *carObj, int cruiseMode, int speedOrFactor);   /* :1403 */
void Execute__14AIState_Cruise(AIState_Cruise *self);   /* :1414 */

/* ---- header-defined (inline / class) functions ---- */
void ___12AIState_Base(AIState_Base *self, int __in_chrg);   /* :24 */
// dup: void ___12AIState_Base(AIState_Base *self, int __in_chrg);   /* :24 */
// dup: void ___12AIState_Base(AIState_Base *self, int __in_chrg);   /* :24 */
// dup: void ___12AIState_Base(AIState_Base *self, int __in_chrg);   /* :24 */
int TestForRelease__12AIState_Base(AIState_Base *self);   /* :25 */
// dup: int TestForRelease__12AIState_Base(AIState_Base *self);   /* :25 */
// dup: int TestForRelease__12AIState_Base(AIState_Base *self);   /* :25 */
// dup: int TestForRelease__12AIState_Base(AIState_Base *self);   /* :25 */
void ___12AIState_None(AIState_None *self, int __in_chrg);   /* :34 */
void Execute__12AIState_None(AIState_None *self);   /* :35 */
void ___14AIState_Normal(AIState_Normal *self, int __in_chrg);   /* :45 */
void ___12AIState_Idle(AIState_Idle *self, int __in_chrg);   /* :58 */
void ___17AIState_NonActive(AIState_NonActive *self, int __in_chrg);   /* :170 */
// dup: void ___17AIState_NonActive(AIState_NonActive *self, int __in_chrg);   /* :170 */
// dup: void ___17AIState_NonActive(AIState_NonActive *self, int __in_chrg);   /* :170 */
void Execute__17AIState_NonActive(AIState_NonActive *self);   /* :174 */
// dup: void Execute__17AIState_NonActive(AIState_NonActive *self);   /* :174 */
// dup: void Execute__17AIState_NonActive(AIState_NonActive *self);   /* :174 */
void ___21AIState_RovingTraffic(AIState_RovingTraffic *self, int __in_chrg);   /* :204 */
int TestForRelease__21AIState_RovingTraffic(AIState_RovingTraffic *self);   /* :210 */
void ___17AIState_GotoSlice(AIState_GotoSlice *self, int __in_chrg);   /* :238 */
void ___14AIState_Cruise(AIState_Cruise *self, int __in_chrg);   /* :262 */

#endif /* _GAME_COMMON_AISTATE_H_ */
