/* Diagnostic: complete corrected public header, exact typed address references. */
#include "C:/Temp/nfs4-decomp/recon/game/common/aiworld.h"

int (*p875_after_0)(Car_tObj *carObj, Car_tObj *otherCarObj) = &AIWorld_ZSplineDistance;
int (*p875_after_1)(coorddef *pos1, coorddef *pos2, matrixtdef *roadMatrix) = &AIWorld_ZSplineDistance;
int (*p875_after_2)(Car_tObj *carObj, Car_tObj *otherCarObj) = &AIWorld_ApxSplineDistance;
int (*p875_after_3)(Car_tObj *carObj, int location) = &AIWorld_ApxSplineDistance;
int (*p875_after_4)(int location, Car_tObj *carObj) = &AIWorld_ApxSplineDistance;
int (*p875_after_5)(int locationA, int locationB) = &AIWorld_ApxSplineDistance;
int (*p875_after_6)(Car_tObj *carObj, Car_tObj *otherCarObj) = &AIWorld_SplineDistance;
int (*p875_after_7)(Car_tObj *carObj, int location, coorddef *position) = &AIWorld_SplineDistance;
int (*p875_after_8)(Car_tObj *carObj) = &AIWorld_GameOdometer;
int (*p875_after_9)(int startSlice, int numSlicesToCheck, int direction, int laneIndex) = &AIWorld_IsDriveableLaneInSliceRange;
int (*p875_after_10)(int slice, int laneIndex) = &AIWorld_IsDriveableLane;
int (*p875_after_11)(int laneIndex) = &AIWorld_GetProfileMask;
int (*p875_after_12)(int slice, int mask) = &AIWorld_IsDriveableLane_UsingMask;
int (*p875_after_13)(int slice, int lane0, int lane1) = &AIWorld_CheckForBarrierBetweenLanes;
int (*p875_after_14)(int slice, int position) = &AIWorld_LaneIndex;
void (*p875_after_15)(Car_tObj *carObj) = &AIWorld_CalculateLaneInfo;
int (*p875_after_16)(Car_tObj *carObj) = &AIWorld_CalculateDeltaRoadYaw;
int (*p875_after_17)(Car_tObj *carObj, int lookAhead) = &AIWorld_CalcRoadBend;
int (*p875_after_18)(Car_tObj *carObj, int slicesAhead) = &AIWorld_CalcFutureLateralVel;
void (*p875_after_19)(Car_tObj *carObj) = &AIWorld_CalcSpeed;
int (*p875_after_20)(Car_tObj *carObj) = &AIWorld_CalcLateralVelocity;
void (*p875_after_21)(Car_tObj *carObj, int *goodLane, int *goodPosition) = &AIWorld_FindBarrierLessLaneAndPosition;
