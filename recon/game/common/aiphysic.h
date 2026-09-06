/* game/common/aiphysic.h — reconstructed from game/common/aiphysic.cpp (42 fns) */
#ifndef _GAME_COMMON_AIPHYSIC_H_
#define _GAME_COMMON_AIPHYSIC_H_
#include "../../nfs4_types.h"

/* P875: verified source-level free names/signatures; the C++ compiler supplies
   native GCC-v2 linkage names. File-local STAT helpers stay in their .cpp. */

void AIPhysic_StopCar(Car_tObj *carObj, int velScale, int rotScale);   /* :120 */
void AIPhysic_RevEngine(Car_tObj *carObj);   /* :137 */
void AIPhysic_HandleShifting(Car_tObj *carObj);   /* :168 */
Gear_t AIPhysic_CalculateGear(Car_tObj *carObj);   /* :214 */
int AIPhysic_GearInvSpeedRange(Car_tObj *carObj, Gear_t gear);   /* :262 */
int AIPhysic_GearTopSpeed(Car_tObj *carObj, Gear_t gear);   /* :283 */
int AIPhysic_GearBottomSpeed(Car_tObj *carObj, Gear_t gear);   /* :303 */
int AIPhysic_CalcAcceleration(Car_tObj *carObj, int speed);   /* :326 */
int AIPhysic_ModifyAccelerationAccordingToScript(Car_tObj *carObj, int acc);   /* :404 */
int AIPhysic_CalcDeceleration(Car_tObj *carObj);   /* :425 */
void AIPhysic_CheckDesiredDirection(Car_tObj *carObj);   /* :440 */
void AIPhysic_HandleSignalling(Car_tObj *carObj);   /* :458 */
void AIPhysic_HandleWipeoutTimer(Car_tObj *carObj);   /* :493 */
void AIPhysic_Main(Car_tObj *carObj);   /* :529 */
void AIPhysic_CheckForBadPosition(Car_tObj *carObj);   /* :681 */
int AIPhysics_UseCoolPhysics(Car_tObj *carObj);   /* :732 */
void AIPhysic_SimplePhysics(Car_tObj *carObj);   /* :757 */
void AIPhysic_SimplePhysics_LongVel(Car_tObj *carObj);   /* :825 */
void AIPhysic_SimplePhysics_LatVel(Car_tObj *carObj);   /* :902 */
void AIPhysic_CoolPhysics(Car_tObj *carObj);   /* :959 */
void AIPhysic_HandleDirection(Car_tObj *carObj);   /* :996 */
void AIPhysic_Preperation(Car_tObj *carObj);   /* :1026 */
int AIPhysic_CalculateRoadPosition(coorddef *pos, int slice);   /* :1075 */
void AIPhysic_GetDesiredVector(Car_tObj *carObj);   /* :1099 */
void AIPhysic_TargetedGetDesiredVector(Car_tObj *carObj);   /* :1275 */
int AIPhysic_CheckIfOutOfControl(Car_tObj *carObj);   /* :1291 */
void AIPhysic_OutOfControlPhysics(Car_tObj *carObj);   /* :1351 */
int AIPhysic_GetRearEndDamageFactor(Car_tObj *carObj);   /* :1570 */
void AIPhysic_InControlPhysics(Car_tObj *carObj);   /* :1604 */
void AIPhysic_FinishUp(Car_tObj *carObj);   /* :1924 */
void AIPhysic_CalculateRampedDesiredLatPos(Car_tObj *carObj, eRampType rampType);   /* :1989 */
int AIPhysic_HitWallCheck(Car_tObj *carObj);   /* :2073 */
void AIPhysic_ProcessBarrierCollision(Car_tObj *carObj);   /* :2117 */
void AIPhysic_ProcessCollision(Car_tObj *carObj);   /* :2134 */
void AIPhysic_ChangeDirection(Car_tObj *carObj, int time);   /* :2163 */
void AIPhysic_CheckForGripReduction(Car_tObj *carObj);   /* :2197 */
void AIPhysic_StartUp(void);   /* :2233 */
void AIPhysic_CleanUp(void);   /* :2237 */
void AIPhysic_Reset(void);   /* :2240 */
void AIPhysic_ResetCar(Car_tObj *carObj);   /* :2243 */
void AIPhysic_InitCar(Car_tObj *carObj);   /* :2250 */
void AIPhysic_DeInitCar(Car_tObj *carObj);   /* :2301 */

#endif /* _GAME_COMMON_AIPHYSIC_H_ */
