/* game/common/aispeeds.h — reconstructed from game/common/aispeeds.cpp (29 fns) */
#ifndef _GAME_COMMON_AISPEEDS_H_
#define _GAME_COMMON_AISPEEDS_H_
#include "../../nfs4_types.h"

void AISpeeds_StartUp__Fv(void);   /* :207 */
void AISpeeds_ReadTuningInfo__Fv(void);   /* :220 */
void AISpeeds_CleanUp__Fv(void);   /* :326 */
int AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars__FP8Car_tObj(Car_tObj *carObj);   /* :347 */
int AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi(Car_tObj *carObj, int *unFetteredDesiredSpeed);   /* :377 */
int AISpeeds_NeedToSlowDownForCurve__FP8Car_tObjiii(Car_tObj *carObj, int distanceMeters, int currentSpeed, int futureCurveSpeed);   /* :625 */
int AISpeeds_CalcOpponentCurveSpeed__FP8Car_tObj(Car_tObj *carObj);   /* :644 */
int AISpeeds_BTCGetGlueFactor__FP8Car_tObj(Car_tObj *carObj);   /* :708 */
void * AISpeeds_GetNextAICar__FP8Car_tObj(Car_tObj *carObj);   /* :773 */
void * AISpeeds_GetPrevAICar__FP8Car_tObj(Car_tObj *carObj);   /* :778 */
int AISpeeds_GetCaravanFactor__FP8Car_tObj(Car_tObj *carObj);   /* :808 */
int AISpeeds_GetGlueFactor__FP8Car_tObj(Car_tObj *carObj);   /* :980 */
int AISpeeds_GetDamageFactor__FP8Car_tObj(Car_tObj *carObj);   /* :1122 */
int AISpeeds_LimitGlueMultiplier__FP8Car_tObji(Car_tObj *carObj, int f_final);   /* :1149 */
int AISpeeds_CalcCopTopSpeed__FP8Car_tObj(Car_tObj *carObj);   /* :1196 */
int AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj(Car_tObj *carObj);   /* :1257 */
int AISpeeds_GetLegalSpeed__Fi(int slice);   /* :1294 */
int AISpeeds_RandomizeTrafficSpeed__FP8Car_tObji(Car_tObj *carObj, int oldsafe);   /* :1312 */
void AISpeeds_CalcDesiredSpeed__FP8Car_tObj(Car_tObj *carObj);   /* :1348 */
int AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj(Car_tObj *carObj);   /* :1384 */
void AISpeeds_SetTrafficSpeedRandomFactor__FP8Car_tObj(Car_tObj *carObj);   /* :1408 */
void AISpeeds_MaintainLeaderBoard__Fv(void);   /* :1421 */
int AISpeeds_GetScriptFactor__FP8Car_tObj(Car_tObj *carObj);   /* :1471 */
int AISpeeds_GetUpgradeAccMult__Fi(int carIndex);   /* :1492 */
int AISpeeds_GetUpgradeBrakeMult__Fi(int carIndex);   /* :1507 */
int AISpeeds_GetUpgradeHandlingMult__Fi(int carIndex);   /* :1521 */
int AISpeeds_GetUpgradeTopSpeedMult__Fi(int carIndex);   /* :1535 */
int AISpeeds_CalcHumanTopSpeed__FP8Car_tObj(Car_tObj *carObj);   /* :1551 */
int AISpeeds_CalcHumanCurveSpeed__FP8Car_tObj(Car_tObj *carObj);   /* :1565 */

#endif /* _GAME_COMMON_AISPEEDS_H_ */
