/* Diagnostic only: original public prototypes, exact typed address references. */
#include "ailife.before.h"

int (*p875_before_0)(Car_tObj *carObj) = &AILife_EvaluateLife__FP8Car_tObj;
void (*p875_before_1)(Car_tObj *carObj) = &AILife_RCSetSpeeds__FP8Car_tObj;
void (*p875_before_2)(Car_tObj *carObj) = &AILife_RCPickSliceAndDirection__FP8Car_tObj;
void (*p875_before_3)(Car_tObj *carObj) = &AILife_RCPickDesiredLatPosition__FP8Car_tObj;
void (*p875_before_4)(Car_tObj *carObj, int slice, int desiredLatPos, int direction, int currentSpeed, int rotation1024) = &AILife_PlaceCarAtLocation__FP8Car_tObjiiiii;
void (*p875_before_5)(Car_tObj *carObj) = &AILife_SetInitialSlicePositionOrientationEtc__FP8Car_tObj;
void (*p875_before_6)(Car_tObj *carObj, int rotation1024) = &AILife_PlaceCarAtLocation__FP8Car_tObji;
void (*p875_before_7)(Car_tObj *carObj) = &AILife_ReencarnateTraffic__FP8Car_tObj;
void (*p875_before_8)(Car_tObj *carObj, int slice, int travelDirection, coorddef *pos, matrixtdef *ori) = &AILife_ReencarnateTrafficByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef;
void (*p875_before_9)(Car_tObj *carObj, int slice, int travelDirection, int roadSide, int moving) = &AILife_ReencarnateCopBySlice__FP8Car_tObjiiii;
void (*p875_before_10)(Car_tObj *carObj, int slice, int travelDirection, coorddef *pos, matrixtdef *ori) = &AILife_ReencarnateCopByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef;
void (*p875_before_11)(Car_tObj *carObj, int slice, int travelDirection, int latPos, int rotation1024) = &AILife_ReencarnateCopByLatPosAndRotation__FP8Car_tObjiiii;
int (*p875_before_12)(coorddef *tPos, Car_tObj *racer) = &AILife_IsCoordInThisLiveArea__FP8coorddefP8Car_tObj;
void * (*p875_before_13)(Car_tObj *traffic) = &AILife_IsTrafficCarInAnyLiveArea__FP8Car_tObj;
int (*p875_before_14)(coorddef *tPos, Car_tObj *racer) = &AILife_IsCoordInThisVisibleArea__FP8coorddefP8Car_tObj;
void * (*p875_before_15)(Car_tObj *carObj) = &AILife_IsCarInAnyVisibleArea__FP8Car_tObj;
void * (*p875_before_16)(int slice) = &AILife_IsSliceInAnyVisibleArea__Fi;
void * (*p875_before_17)(int slice) = &AILife_IsSliceCloseToAnyCopCar__Fi;
void * (*p875_before_18)(coorddef *pos) = &AILife_IsPositionInAnyVisibleArea__FP8coorddef;
void (*p875_before_19)(char *format) = &AILife_Debug__FPce;
