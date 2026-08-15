/* game/common/ai.h — reconstructed from game/common/ai.cpp (40 fns) */
#ifndef _GAME_COMMON_AI_H_
#define _GAME_COMMON_AI_H_
#include "../../nfs4_types.h"

void AI_StartUp__Fv(void);   /* :135 */
void AI_CleanUp__Fv(void);   /* :138 */
void AI_Main_OverallSetup__Fv(void);   /* :157 */
void AI_CarAvoidance__FP8Car_tObj(Car_tObj *carObj);   /* :169 */
void AI_WorldAvoidance__FP8Car_tObj(Car_tObj *carObj);   /* :183 */
void AI_InitAIInfo__FP8Car_tObj(Car_tObj *carObj);   /* :196 */
void AI_GenericBeginCycle__FP8Car_tObj(Car_tObj *carObj);   /* :226 */
void AI_GenericCycle__FP8Car_tObj(Car_tObj *carObj);   /* :253 */
void AI_GenericEndCycle__FP8Car_tObj(Car_tObj *carObj);   /* :276 */
void AI_TargetLane__FP8Car_tObji(Car_tObj *carObj, int lane);   /* :322 */
void AI_ClearLaneMerits__Fv(void);   /* :345 */
void AI_DoReactions__FP8Car_tObj(Car_tObj *carObj);   /* :357 */
void AI_CheckForPlayerActions__FP8Car_tObjT0(Car_tObj *carObj, Car_tObj *otherCarObj);   /* :446 */
void AI_DoReactionsAndBehavior__FP8Car_tObj(Car_tObj *carObj);   /* :495 */
void AI_OpponentBlockPlayer__FP8Car_tObjT0(Car_tObj *carObj, Car_tObj *otherCarObj);   /* :531 */
void AI_CheckForBarriers__FP8Car_tObj(Car_tObj *carObj);   /* :602 */
void AI_SetupOncomingLaneDemerits__FP8Car_tObj(Car_tObj *carObj);   /* :685 */
void AI_HandleChangeInNumLanes__FP8Car_tObj(Car_tObj *carObj);   /* :724 */
void AI_HandleShouldersAndOffRoad__FP8Car_tObj(Car_tObj *carObj);   /* :769 */
void AI_CalculateLaneSpeeds__FP8Car_tObj(Car_tObj *carObj);   /* :841 */
void AI_CalcMeritsBasedOnSpeed__FP8Car_tObj(Car_tObj *carObj);   /* :1011 */
void AI_CheckForClearLanes__FP8Car_tObj(Car_tObj *carObj);   /* :1075 */
void AI_CalcBestLineMerits__FP8Car_tObj(Car_tObj *carObj);   /* :1189 */
void AI_AddCollidableObjects__FP8Car_tObjP5Group(Car_tObj *carObj, Group *groupSimObjs);   /* :1231 */
void AI_AvoidObjects__FP8Car_tObj(Car_tObj *carObj);   /* :1278 */
void AI_AvoidSpikeBelt__FP8Car_tObj(Car_tObj *carObj);   /* :1287 */
void AI_SubmitObstacle__FP8Car_tObjiiii(Car_tObj *carObj, int importance, int leftLatPosition, int rightLatPosition, int slice);   /* :1306 */
void AI_HandleTrafficHonking__FP8Car_tObj(Car_tObj *carObj);   /* :1351 */
void AI_CheckForCarsOnSide__FP8Car_tObj(Car_tObj *carObj);   /* :1380 */
void AI_ProcessObservationsAndChooseLane__FP8Car_tObj(Car_tObj *carObj);   /* :1420 */
void AI_ChooseBestLane__FP8Car_tObj(Car_tObj *carObj);   /* :1465 */
int AI_CheckPreferredLateralPosition__FP8Car_tObj(Car_tObj *carObj);   /* :1504 */
int AI_TryToShareLanes__FP8Car_tObjT0(Car_tObj *carObj, Car_tObj *carInWay);   /* :1662 */
void AI_CalculateDesiredLatPosition__FP8Car_tObj(Car_tObj *carObj);   /* :1722 */
void AI_CalculateAdjustedDesiredSpeed__FP8Car_tObj(Car_tObj *carObj);   /* :1828 */
int AI_IsMellowZone__FP8Car_tObji(Car_tObj *carObj, int delay);   /* :1927 */
void AI_KeepCarsInLane__FP8Car_tObj(Car_tObj *carObj);   /* :1958 */
void AI_PushFinishedCarsToSide__FP8Car_tObj(Car_tObj *carObj);   /* :1992 */
void AI_MaybeChangeLaneSlack__FP8Car_tObj(Car_tObj *carObj);   /* :2039 */
void AI_ChooseNewLaneSlack__FP8Car_tObj(Car_tObj *carObj);   /* :2069 */

#endif /* _GAME_COMMON_AI_H_ */
