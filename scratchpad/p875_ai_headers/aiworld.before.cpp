/* Diagnostic only: original public prototypes, exact typed address references. */
#include "aiworld.before.h"

int (*p875_before_0)(Car_tObj *carObj, Car_tObj *otherCarObj) = &AIWorld_ZSplineDistance__FP8Car_tObjT0;
int (*p875_before_1)(coorddef *pos1, coorddef *pos2, matrixtdef *roadMatrix) = &AIWorld_ZSplineDistance__FP8coorddefT0P10matrixtdef;
int (*p875_before_2)(Car_tObj *carObj, Car_tObj *otherCarObj) = &AIWorld_ApxSplineDistance__FP8Car_tObjT0;
int (*p875_before_3)(Car_tObj *carObj, int location) = &AIWorld_ApxSplineDistance__FP8Car_tObji;
int (*p875_before_4)(int location, Car_tObj *carObj) = &AIWorld_ApxSplineDistance__FiP8Car_tObj;
int (*p875_before_5)(int locationA, int locationB) = &AIWorld_ApxSplineDistance__Fii;
int (*p875_before_6)(Car_tObj *carObj, Car_tObj *otherCarObj) = &AIWorld_SplineDistance__FP8Car_tObjT0;
int (*p875_before_7)(Car_tObj *carObj, int location, coorddef *position) = &AIWorld_SplineDistance__FP8Car_tObjiP8coorddef;
int (*p875_before_8)(Car_tObj *carObj) = &AIWorld_GameOdometer__FP8Car_tObj;
int (*p875_before_9)(int startSlice, int numSlicesToCheck, int direction, int laneIndex) = &AIWorld_IsDriveableLaneInSliceRange__Fiiii;
int (*p875_before_10)(int slice, int laneIndex) = &AIWorld_IsDriveableLane__Fii;
int (*p875_before_11)(int laneIndex) = &AIWorld_GetProfileMask__Fi;
int (*p875_before_12)(int slice, int mask) = &AIWorld_IsDriveableLane_UsingMask__Fii;
int (*p875_before_13)(int slice, int lane0, int lane1) = &AIWorld_CheckForBarrierBetweenLanes__Fiii;
int (*p875_before_14)(int slice, int position) = &AIWorld_LaneIndex__Fii;
void (*p875_before_15)(Car_tObj *carObj) = &AIWorld_CalculateLaneInfo__FP8Car_tObj;
int (*p875_before_16)(Car_tObj *carObj) = &AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj;
int (*p875_before_17)(Car_tObj *carObj, int lookAhead) = &AIWorld_CalcRoadBend__FP8Car_tObji;
int (*p875_before_18)(Car_tObj *carObj, int slicesAhead) = &AIWorld_CalcFutureLateralVel__FP8Car_tObji;
void (*p875_before_19)(Car_tObj *carObj) = &AIWorld_CalcSpeed__FP8Car_tObj;
int (*p875_before_20)(Car_tObj *carObj) = &AIWorld_CalcLateralVelocity__FP8Car_tObj;
void (*p875_before_21)(Car_tObj *carObj, int *goodLane, int *goodPosition) = &AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1;
