/* game/common/aiphysic.h — reconstructed from game/common/aiphysic.cpp (42 fns) */
#ifndef _GAME_COMMON_AIPHYSIC_H_
#define _GAME_COMMON_AIPHYSIC_H_
#include "../../nfs4_types.h"

void AIPhysic_StopCar__FP8Car_tObjii(Car_tObj *carObj, int velScale, int rotScale);   /* :120 */
void AIPhysic_RevEngine__FP8Car_tObj(Car_tObj *carObj);   /* :137 */
void AIPhysic_HandleShifting__FP8Car_tObj(Car_tObj *carObj);   /* :168 */
int AIPhysic_CalculateGear__FP8Car_tObj(Car_tObj *carObj);   /* :214 */
int AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t(Car_tObj *carObj, int gear);   /* :262 */
int AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t(Car_tObj *carObj, int gear);   /* :283 */
int AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t(Car_tObj *carObj, int gear);   /* :303 */
int AIPhysic_CalcAcceleration__FP8Car_tObji(Car_tObj *carObj, int speed);   /* :326 */
int AIPhysic_ModifyAccelerationAccordingToScript__FP8Car_tObji(Car_tObj *carObj, int acc);   /* :404 */
int AIPhysic_CalcDeceleration__FP8Car_tObj(Car_tObj *carObj);   /* :425 */
void AIPhysic_CheckDesiredDirection__FP8Car_tObj(Car_tObj *carObj);   /* :440 */
void AIPhysic_HandleSignalling__FP8Car_tObj(Car_tObj *carObj);   /* :458 */
void AIPhysic_HandleWipeoutTimer__FP8Car_tObj(Car_tObj *carObj);   /* :493 */
void AIPhysic_Main__FP8Car_tObj(Car_tObj *carObj);   /* :529 */
void AIPhysic_CheckForBadPosition__FP8Car_tObj(Car_tObj *carObj);   /* :681 */
int AIPhysics_UseCoolPhysics__FP8Car_tObj(Car_tObj *carObj);   /* :732 */
void AIPhysic_SimplePhysics__FP8Car_tObj(Car_tObj *carObj);   /* :757 */
void AIPhysic_SimplePhysics_LongVel__FP8Car_tObj(Car_tObj *carObj);   /* :825 */
void AIPhysic_SimplePhysics_LatVel__FP8Car_tObj(Car_tObj *carObj);   /* :902 */
void AIPhysic_CoolPhysics__FP8Car_tObj(Car_tObj *carObj);   /* :959 */
void AIPhysic_HandleDirection__FP8Car_tObj(Car_tObj *carObj);   /* :996 */
void AIPhysic_Preperation__FP8Car_tObj(Car_tObj *carObj);   /* :1026 */
int AIPhysic_CalculateRoadPosition__FP8coorddefi(coorddef *pos, int slice);   /* :1075 */
void AIPhysic_GetDesiredVector__FP8Car_tObj(Car_tObj *carObj);   /* :1099 */
void AIPhysic_TargetedGetDesiredVector__FP8Car_tObj(Car_tObj *carObj);   /* :1275 */
int AIPhysic_CheckIfOutOfControl__FP8Car_tObj(Car_tObj *carObj);   /* :1291 */
void AIPhysic_OutOfControlPhysics__FP8Car_tObj(Car_tObj *carObj);   /* :1351 */
int AIPhysic_GetRearEndDamageFactor__FP8Car_tObj(Car_tObj *carObj);   /* :1570 */
void AIPhysic_InControlPhysics__FP8Car_tObj(Car_tObj *carObj);   /* :1604 */
void AIPhysic_FinishUp__FP8Car_tObj(Car_tObj *carObj);   /* :1924 */
void AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType(Car_tObj *carObj, int rampType);   /* :1989 */
int AIPhysic_HitWallCheck__FP8Car_tObj(Car_tObj *carObj);   /* :2073 */
void AIPhysic_ProcessBarrierCollision__FP8Car_tObj(Car_tObj *carObj);   /* :2117 */
void AIPhysic_ProcessCollision__FP8Car_tObj(Car_tObj *carObj);   /* :2134 */
void AIPhysic_ChangeDirection__FP8Car_tObji(Car_tObj *carObj, int time);   /* :2163 */
void AIPhysic_CheckForGripReduction__FP8Car_tObj(Car_tObj *carObj);   /* :2197 */
void AIPhysic_StartUp__Fv(void);   /* :2233 */
void AIPhysic_CleanUp__Fv(void);   /* :2237 */
void AIPhysic_Reset__Fv(void);   /* :2240 */
void AIPhysic_ResetCar__FP8Car_tObj(Car_tObj *carObj);   /* :2243 */
void AIPhysic_InitCar__FP8Car_tObj(Car_tObj *carObj);   /* :2250 */
void AIPhysic_DeInitCar__FP8Car_tObj(Car_tObj *carObj);   /* :2301 */

#endif /* _GAME_COMMON_AIPHYSIC_H_ */
