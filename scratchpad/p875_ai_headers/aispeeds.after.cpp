/* Diagnostic: complete corrected public header, exact typed address references. */
#include "C:/Temp/nfs4-decomp/recon/game/common/aispeeds.h"

void (*p875_after_0)(void) = &AISpeeds_StartUp;
void (*p875_after_1)(void) = &AISpeeds_ReadTuningInfo;
void (*p875_after_2)(void) = &AISpeeds_CleanUp;
int (*p875_after_3)(Car_tObj *carObj) = &AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars;
int (*p875_after_4)(Car_tObj *carObj, int *unFetteredDesiredSpeed) = &AISpeeds_CalcOpponentTopSpeed;
int (*p875_after_5)(Car_tObj *carObj, int distanceMeters, int currentSpeed, int futureCurveSpeed) = &AISpeeds_NeedToSlowDownForCurve;
int (*p875_after_6)(Car_tObj *carObj) = &AISpeeds_CalcOpponentCurveSpeed;
int (*p875_after_7)(Car_tObj *carObj) = &AISpeeds_BTCGetGlueFactor;
Car_tObj * (*p875_after_8)(Car_tObj *carObj) = &AISpeeds_GetNextAICar;
Car_tObj * (*p875_after_9)(Car_tObj *carObj) = &AISpeeds_GetPrevAICar;
int (*p875_after_10)(Car_tObj *carObj) = &AISpeeds_GetCaravanFactor;
int (*p875_after_11)(Car_tObj *carObj) = &AISpeeds_GetGlueFactor;
int (*p875_after_12)(Car_tObj *carObj) = &AISpeeds_GetDamageFactor;
int (*p875_after_13)(Car_tObj *carObj, int f_final) = &AISpeeds_LimitGlueMultiplier;
int (*p875_after_14)(Car_tObj *carObj) = &AISpeeds_CalcCopTopSpeed;
int (*p875_after_15)(Car_tObj *carObj) = &AISpeeds_CalcTrafficTopSpeed;
int (*p875_after_16)(int slice) = &AISpeeds_GetLegalSpeed;
int (*p875_after_17)(Car_tObj *carObj, int oldsafe) = &AISpeeds_RandomizeTrafficSpeed;
void (*p875_after_18)(Car_tObj *carObj) = &AISpeeds_CalcDesiredSpeed;
int (*p875_after_19)(Car_tObj *carObj) = &AISpeeds_CalculateOncomingCarSpeed;
void (*p875_after_20)(Car_tObj *carObj) = &AISpeeds_SetTrafficSpeedRandomFactor;
void (*p875_after_21)(void) = &AISpeeds_MaintainLeaderBoard;
int (*p875_after_22)(Car_tObj *carObj) = &AISpeeds_GetScriptFactor;
int (*p875_after_23)(int carIndex) = &AISpeeds_GetUpgradeAccMult;
int (*p875_after_24)(int carIndex) = &AISpeeds_GetUpgradeBrakeMult;
int (*p875_after_25)(int carIndex) = &AISpeeds_GetUpgradeHandlingMult;
int (*p875_after_26)(int carIndex) = &AISpeeds_GetUpgradeTopSpeedMult;
int (*p875_after_27)(Car_tObj *carObj) = &AISpeeds_CalcHumanTopSpeed;
int (*p875_after_28)(Car_tObj *carObj) = &AISpeeds_CalcHumanCurveSpeed;
