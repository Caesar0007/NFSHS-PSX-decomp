/* game/common/ai.h — reconstructed from game/common/ai.cpp (40 fns) */
#ifndef _GAME_COMMON_AI_H_
#define _GAME_COMMON_AI_H_
#include "../../nfs4_types.h"

/* P875: verified source-level free names/signatures; the C++ compiler supplies
   native GCC-v2 linkage names. File-local STAT helpers stay in their .cpp. */

void AI_StartUp(void);   /* :135 */
void AI_CleanUp(void);   /* :138 */
void AI_Main_OverallSetup(void);   /* :157 */
void AI_CarAvoidance(Car_tObj *carObj);   /* :169 */
void AI_WorldAvoidance(Car_tObj *carObj);   /* :183 */
void AI_InitAIInfo(Car_tObj *carObj);   /* :196 */
void AI_GenericBeginCycle(Car_tObj *carObj);   /* :226 */
void AI_GenericCycle(Car_tObj *carObj);   /* :253 */
void AI_GenericEndCycle(Car_tObj *carObj);   /* :276 */
void AI_TargetLane(Car_tObj *carObj, int lane);   /* :322 */
void AI_ClearLaneMerits(void);   /* :345 */
void AI_DoReactions(Car_tObj *carObj);   /* :357 */
void AI_CheckForPlayerActions(Car_tObj *carObj, Car_tObj *otherCarObj);   /* :446 */
void AI_DoReactionsAndBehavior(Car_tObj *carObj);   /* :495 */
void AI_OpponentBlockPlayer(Car_tObj *carObj, Car_tObj *otherCarObj);   /* :531 */
void AI_CheckForBarriers(Car_tObj *carObj);   /* :602 */
void AI_SetupOncomingLaneDemerits(Car_tObj *carObj);   /* :685 */
void AI_HandleChangeInNumLanes(Car_tObj *carObj);   /* :724 */
void AI_HandleShouldersAndOffRoad(Car_tObj *carObj);   /* :769 */
void AI_CalculateLaneSpeeds(Car_tObj *carObj);   /* :841 */
void AI_CalcMeritsBasedOnSpeed(Car_tObj *carObj);   /* :1011 */
void AI_CheckForClearLanes(Car_tObj *carObj);   /* :1075 */
void AI_CalcBestLineMerits(Car_tObj *carObj);   /* :1189 */
void AI_AvoidObjects(Car_tObj *carObj);   /* :1278 */
void AI_AvoidSpikeBelt(Car_tObj *carObj);   /* :1287 */
void AI_SubmitObstacle(Car_tObj *carObj, int importance, int leftLatPosition, int rightLatPosition, int slice);   /* :1306 */
void AI_HandleTrafficHonking(Car_tObj *carObj);   /* :1351 */
void AI_CheckForCarsOnSide(Car_tObj *carObj);   /* :1380 */
void AI_ProcessObservationsAndChooseLane(Car_tObj *carObj);   /* :1420 */
void AI_ChooseBestLane(Car_tObj *carObj);   /* :1465 */
int AI_CheckPreferredLateralPosition(Car_tObj *carObj);   /* :1504 */
int AI_TryToShareLanes(Car_tObj *carObj, Car_tObj *carInWay);   /* :1662 */
void AI_CalculateDesiredLatPosition(Car_tObj *carObj);   /* :1722 */
void AI_CalculateAdjustedDesiredSpeed(Car_tObj *carObj);   /* :1828 */
int AI_IsMellowZone(Car_tObj *carObj, int delay);   /* :1927 */
void AI_KeepCarsInLane(Car_tObj *carObj);   /* :1958 */
void AI_PushFinishedCarsToSide(Car_tObj *carObj);   /* :1992 */
void AI_MaybeChangeLaneSlack(Car_tObj *carObj);   /* :2039 */
void AI_ChooseNewLaneSlack(Car_tObj *carObj);   /* :2069 */

#endif /* _GAME_COMMON_AI_H_ */
