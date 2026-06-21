/* game/common/physics.h — reconstructed from game/common/physics.cpp (22 fns) */
#ifndef _GAME_COMMON_PHYSICS_H_
#define _GAME_COMMON_PHYSICS_H_
#include "../../nfs4_types.h"

void Physics_InitCarSpecs__FP8Car_tObjP10Udff_tInfo(Car_tObj *carObj, Udff_tInfo *handle);   /* :243 */
void Physics_CalculateDerivedCarSpecs__FP8Car_tObj(Car_tObj *carObj);   /* :287 */
void Physics_CheckGamedata__Fv(void);   /* :414 */
int Physics_AttenuateVelocity__FP8Car_tObjiP10matrixtdef(Car_tObj *carObj, int force, matrixtdef *roadMat);   /* :591 */
void Physics_SetCurrentWallType__Fi(int wallType);   /* :665 */
int Physics_GetTorque__FP8Car_tObji(Car_tObj *carObj, int index);   /* :672 */
void Physics_CorrectPostCollisionYaw__FP8Car_tObjiG8coorddef(Car_tObj *carObj, int impactVel, coorddef barrierVec);   /* :680 */
int Physics_DoBarrierCheck__FP8Car_tObj(Car_tObj *carObj);   /* :761 */
void Physics_AutoShift__FP8Car_tObj(Car_tObj *carObj);   /* :938 */
void Physics_RampCarControlValues__FP8Car_tObj(Car_tObj *carObj);   /* :1044 */
void Physics_FixEngineRpm__FP8Car_tObj(Car_tObj *carObj);   /* :1287 */
void Physics_ResetCar__FP8Car_tObj(Car_tObj *carObj);   /* :1313 */
void Physics_StopCar__FP8Car_tObj(Car_tObj *carObj);   /* :1364 */
void Physics_TestForBarrierCollision__FP8Car_tObj(Car_tObj *carObj);   /* :1377 */
void Physics_CalculateRoadGripModifiers__FP8Car_tObj(Car_tObj *carObj);   /* :1394 */
int Physics_CalculateCarAcceleration__FP8Car_tObj(Car_tObj *carObj);   /* :1447 */
void Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct(Car_tObj *carObj, Physics_tWheelAccStruct *wheel);   /* :1680 */
void Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct(Car_tObj *carObj, Physics_tWheelAccStruct *wheel);   /* :1731 */
void Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct(Car_tObj *carObj, Physics_tWheelAccStruct *wheel);   /* :1815 */
int Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii(Car_tObj *carObj, int sliceAhead, int lookAhead);   /* :1982 */
void Physics_Real__FP8Car_tObj(Car_tObj *carObj);   /* :2048 */
void Physics_SimCar__FP8Car_tObj(Car_tObj *carObj);   /* :2507 */

#endif /* _GAME_COMMON_PHYSICS_H_ */
