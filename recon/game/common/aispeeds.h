/* game/common/aispeeds.h — reconstructed from game/common/aispeeds.cpp (29 fns) */
#ifndef _GAME_COMMON_AISPEEDS_H_
#define _GAME_COMMON_AISPEEDS_H_
#include "../../nfs4_types.h"

/* P875: verified source-level free names/signatures; the C++ compiler supplies
   native GCC-v2 linkage names. File-local STAT helpers stay in their .cpp. */

void AISpeeds_StartUp(void);   /* :207 */
void AISpeeds_ReadTuningInfo(void);   /* :220 */
void AISpeeds_CleanUp(void);   /* :326 */
int AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars(Car_tObj *carObj);   /* :347 */
int AISpeeds_CalcOpponentTopSpeed(Car_tObj *carObj, int *unFetteredDesiredSpeed);   /* :377 */
int AISpeeds_NeedToSlowDownForCurve(Car_tObj *carObj, int distanceMeters, int currentSpeed, int futureCurveSpeed);   /* :625 */
int AISpeeds_CalcOpponentCurveSpeed(Car_tObj *carObj);   /* :644 */
int AISpeeds_BTCGetGlueFactor(Car_tObj *carObj);   /* :708 */
Car_tObj * AISpeeds_GetNextAICar(Car_tObj *carObj);   /* :773 */
Car_tObj * AISpeeds_GetPrevAICar(Car_tObj *carObj);   /* :778 */
int AISpeeds_GetCaravanFactor(Car_tObj *carObj);   /* :808 */
int AISpeeds_GetGlueFactor(Car_tObj *carObj);   /* :980 */
int AISpeeds_GetDamageFactor(Car_tObj *carObj);   /* :1122 */
int AISpeeds_LimitGlueMultiplier(Car_tObj *carObj, int f_final);   /* :1149 */
int AISpeeds_CalcCopTopSpeed(Car_tObj *carObj);   /* :1196 */
int AISpeeds_CalcTrafficTopSpeed(Car_tObj *carObj);   /* :1257 */
int AISpeeds_GetLegalSpeed(int slice);   /* :1294 */
int AISpeeds_RandomizeTrafficSpeed(Car_tObj *carObj, int oldsafe);   /* :1312 */
void AISpeeds_CalcDesiredSpeed(Car_tObj *carObj);   /* :1348 */
int AISpeeds_CalculateOncomingCarSpeed(Car_tObj *carObj);   /* :1384 */
void AISpeeds_SetTrafficSpeedRandomFactor(Car_tObj *carObj);   /* :1408 */
void AISpeeds_MaintainLeaderBoard(void);   /* :1421 */
int AISpeeds_GetScriptFactor(Car_tObj *carObj);   /* :1471 */
int AISpeeds_GetUpgradeAccMult(int carIndex);   /* :1492 */
int AISpeeds_GetUpgradeBrakeMult(int carIndex);   /* :1507 */
int AISpeeds_GetUpgradeHandlingMult(int carIndex);   /* :1521 */
int AISpeeds_GetUpgradeTopSpeedMult(int carIndex);   /* :1535 */
int AISpeeds_CalcHumanTopSpeed(Car_tObj *carObj);   /* :1551 */
int AISpeeds_CalcHumanCurveSpeed(Car_tObj *carObj);   /* :1565 */

#endif /* _GAME_COMMON_AISPEEDS_H_ */
