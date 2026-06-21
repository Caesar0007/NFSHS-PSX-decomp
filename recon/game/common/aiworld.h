/* game/common/aiworld.h — reconstructed from game/common/aiworld.cpp (22 fns) */
#ifndef _GAME_COMMON_AIWORLD_H_
#define _GAME_COMMON_AIWORLD_H_
#include "../../nfs4_types.h"

int AIWorld_ZSplineDistance__FP8Car_tObjT0(Car_tObj *carObj, Car_tObj *otherCarObj);   /* :29 */
int AIWorld_ZSplineDistance__FP8coorddefT0P10matrixtdef(coorddef *pos1, coorddef *pos2, matrixtdef *roadMatrix);   /* :38 */
int AIWorld_ApxSplineDistance__FP8Car_tObjT0(Car_tObj *carObj, Car_tObj *otherCarObj);   /* :52 */
int AIWorld_ApxSplineDistance__FP8Car_tObji(Car_tObj *carObj, int location);   /* :67 */
int AIWorld_ApxSplineDistance__FiP8Car_tObj(int location, Car_tObj *carObj);   /* :82 */
int AIWorld_ApxSplineDistance__Fii(int locationA, int locationB);   /* :87 */
int AIWorld_SplineDistance__FP8Car_tObjT0(Car_tObj *carObj, Car_tObj *otherCarObj);   /* :107 */
int AIWorld_SplineDistance__FP8Car_tObjiP8coorddef(Car_tObj *carObj, int location, coorddef *position);   /* :119 */
int AIWorld_GameOdometer__FP8Car_tObj(Car_tObj *carObj);   /* :143 */
int AIWorld_IsDriveableLaneInSliceRange__Fiiii(int startSlice, int numSlicesToCheck, int direction, int laneIndex);   /* :172 */
int AIWorld_IsDriveableLane__Fii(int slice, int laneIndex);   /* :203 */
int AIWorld_GetProfileMask__Fi(int laneIndex);   /* :228 */
int AIWorld_IsDriveableLane_UsingMask__Fii(int slice, int mask);   /* :250 */
int AIWorld_CheckForBarrierBetweenLanes__Fiii(int slice, int lane0, int lane1);   /* :264 */
int AIWorld_LaneIndex__Fii(int slice, int position);   /* :290 */
void AIWorld_CalculateLaneInfo__FP8Car_tObj(Car_tObj *carObj);   /* :326 */
int AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj(Car_tObj *carObj);   /* :485 */
int AIWorld_CalcRoadBend__FP8Car_tObji(Car_tObj *carObj, int lookAhead);   /* :518 */
int AIWorld_CalcFutureLateralVel__FP8Car_tObji(Car_tObj *carObj, int slicesAhead);   /* :537 */
void AIWorld_CalcSpeed__FP8Car_tObj(Car_tObj *carObj);   /* :557 */
int AIWorld_CalcLateralVelocity__FP8Car_tObj(Car_tObj *carObj);   /* :567 */
void AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1(Car_tObj *carObj, int *goodLane, int *goodPosition);   /* :578 */

#endif /* _GAME_COMMON_AIWORLD_H_ */
