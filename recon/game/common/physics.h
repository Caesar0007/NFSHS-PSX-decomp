/* game/common/physics.h — reconstructed from game/common/physics.cpp (22 fns) */
#ifndef _GAME_COMMON_PHYSICS_H_
#define _GAME_COMMON_PHYSICS_H_
#include "../../nfs4_types.h"

/* P875: native source names/signatures; C++ supplies linkage mangling.
 * File-private functions stay in the implementation; class members remain
 * exposed by the included types without duplicate free declarations. */

void Physics_InitCarSpecs(Car_tObj *carObj,Udff_tInfo *handle);   /* :243 */
void Physics_CalculateDerivedCarSpecs(Car_tObj *carObj);   /* :287 */
void Physics_CheckGamedata(void);   /* :414 */
int Physics_AttenuateVelocity(Car_tObj *carObj,int force,matrixtdef *roadMat);   /* :591 */
void Physics_SetCurrentWallType(int wallType);   /* :665 */
int Physics_GetTorque(Car_tObj *carObj,int index);   /* :672 */
void Physics_CorrectPostCollisionYaw(Car_tObj *carObj,int impactVel,coorddef barrierVec);   /* :680 */
int Physics_DoBarrierCheck(Car_tObj *carObj);   /* :761 */
void Physics_AutoShift(Car_tObj *carObj);   /* :938 */
void Physics_RampCarControlValues(Car_tObj *carObj);   /* :1044 */
void Physics_FixEngineRpm(Car_tObj *carObj);   /* :1287 */
void Physics_ResetCar(Car_tObj *carObj);   /* :1313 */
void Physics_StopCar(Car_tObj *carObj);   /* :1364 */
void Physics_TestForBarrierCollision(Car_tObj *carObj);   /* :1377 */
void Physics_CalculateRoadGripModifiers(Car_tObj *carObj);   /* :1394 */
int Physics_CalculateCarAcceleration(Car_tObj *carObj);   /* :1447 */
void Physics_CalcWheelLockAcc(Car_tObj *carObj,Physics_tWheelAccStruct *wheel);   /* :1680 */
void Physics_CalcTractionCircleAcc(Car_tObj *carObj,Physics_tWheelAccStruct *wheel);   /* :1731 */
void Physics_CalculateTireForces(Car_tObj *carObj,Physics_tWheelAccStruct *wheel);   /* :1815 */
int Physics_CalculateRSControlDesiredPosition(Car_tObj *carObj,int sliceAhead,int lookAhead);   /* :1982 */
void Physics_Real(Car_tObj *carObj);   /* :2048 */
void Physics_SimCar(Car_tObj *carObj);   /* :2507 */

#endif /* _GAME_COMMON_PHYSICS_H_ */
