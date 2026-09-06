/* game/common/aiworld.h — reconstructed from game/common/aiworld.cpp (22 fns) */
#ifndef _GAME_COMMON_AIWORLD_H_
#define _GAME_COMMON_AIWORLD_H_
#include "aiworld_types.h"

/* P875: verified source-level free names/signatures; the C++ compiler supplies
   native GCC-v2 linkage names. File-local STAT helpers stay in their .cpp. */

int AIWorld_ZSplineDistance(Car_tObj *carObj, Car_tObj *otherCarObj);   /* :29 */
int AIWorld_ZSplineDistance(coorddef *pos1, coorddef *pos2, matrixtdef *roadMatrix);   /* :38 */
int AIWorld_ApxSplineDistance(Car_tObj *carObj, Car_tObj *otherCarObj);   /* :52 */
int AIWorld_ApxSplineDistance(Car_tObj *carObj, int location);   /* :67 */
int AIWorld_ApxSplineDistance(int location, Car_tObj *carObj);   /* :82 */
int AIWorld_ApxSplineDistance(int locationA, int locationB);   /* :87 */
int AIWorld_SplineDistance(Car_tObj *carObj, Car_tObj *otherCarObj);   /* :107 */
int AIWorld_SplineDistance(Car_tObj *carObj, int location, coorddef *position);   /* :119 */
int AIWorld_GameOdometer(Car_tObj *carObj);   /* :143 */
int AIWorld_IsDriveableLaneInSliceRange(int startSlice, int numSlicesToCheck, int direction, int laneIndex);   /* :172 */
int AIWorld_IsDriveableLane(int slice, int laneIndex);   /* :203 */
int AIWorld_GetProfileMask(int laneIndex);   /* :228 */
int AIWorld_IsDriveableLane_UsingMask(int slice, int mask);   /* :250 */
int AIWorld_CheckForBarrierBetweenLanes(int slice, int lane0, int lane1);   /* :264 */
int AIWorld_LaneIndex(int slice, int position);   /* :290 */
void AIWorld_CalculateLaneInfo(Car_tObj *carObj);   /* :326 */
int AIWorld_CalculateDeltaRoadYaw(Car_tObj *carObj);   /* :485 */
int AIWorld_CalcRoadBend(Car_tObj *carObj, int lookAhead);   /* :518 */
int AIWorld_CalcFutureLateralVel(Car_tObj *carObj, int slicesAhead);   /* :537 */
void AIWorld_CalcSpeed(Car_tObj *carObj);   /* :557 */
int AIWorld_CalcLateralVelocity(Car_tObj *carObj);   /* :567 */
void AIWorld_FindBarrierLessLaneAndPosition(Car_tObj *carObj, int *goodLane, int *goodPosition);   /* :578 */

#endif /* _GAME_COMMON_AIWORLD_H_ */
