/* Diagnostic: complete corrected public header, exact typed address references. */
#include "C:/Temp/nfs4-decomp/recon/game/common/ailife.h"

int (*p875_after_0)(Car_tObj *carObj) = &AILife_EvaluateLife;
void (*p875_after_1)(Car_tObj *carObj) = &AILife_RCSetSpeeds;
void (*p875_after_2)(Car_tObj *carObj) = &AILife_RCPickSliceAndDirection;
void (*p875_after_3)(Car_tObj *carObj) = &AILife_RCPickDesiredLatPosition;
void (*p875_after_4)(Car_tObj *carObj, int slice, int desiredLatPos, int direction, int currentSpeed, int rotation1024) = &AILife_PlaceCarAtLocation;
void (*p875_after_5)(Car_tObj *carObj) = &AILife_SetInitialSlicePositionOrientationEtc;
void (*p875_after_6)(Car_tObj *carObj, int rotation1024) = &AILife_PlaceCarAtLocation;
void (*p875_after_7)(Car_tObj *carObj) = &AILife_ReencarnateTraffic;
void (*p875_after_8)(Car_tObj *carObj, int slice, int travelDirection, coorddef *pos, matrixtdef *ori) = &AILife_ReencarnateTrafficByPosition;
void (*p875_after_9)(Car_tObj *carObj, int slice, int travelDirection, int roadSide, int moving) = &AILife_ReencarnateCopBySlice;
void (*p875_after_10)(Car_tObj *carObj, int slice, int travelDirection, coorddef *pos, matrixtdef *ori) = &AILife_ReencarnateCopByPosition;
void (*p875_after_11)(Car_tObj *carObj, int slice, int travelDirection, int latPos, int rotation1024) = &AILife_ReencarnateCopByLatPosAndRotation;
int (*p875_after_12)(coorddef *tPos, Car_tObj *racer) = &AILife_IsCoordInThisLiveArea;
Car_tObj * (*p875_after_13)(Car_tObj *traffic) = &AILife_IsTrafficCarInAnyLiveArea;
int (*p875_after_14)(coorddef *tPos, Car_tObj *racer) = &AILife_IsCoordInThisVisibleArea;
Car_tObj * (*p875_after_15)(Car_tObj *carObj) = &AILife_IsCarInAnyVisibleArea;
Car_tObj * (*p875_after_16)(int slice) = &AILife_IsSliceInAnyVisibleArea;
Car_tObj * (*p875_after_17)(int slice) = &AILife_IsSliceCloseToAnyCopCar;
Car_tObj * (*p875_after_18)(coorddef *pos) = &AILife_IsPositionInAnyVisibleArea;
void (*p875_after_19)(char *format, ...) = &AILife_Debug;
