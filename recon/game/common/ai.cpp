/* game/common/ai.cpp -- RECONSTRUCTED (NFS4 main AI driver; 40 free AI_* fns).
 *   Per-car AI cycle: car/world avoidance, lane merits/speeds, reactions & behavior,
 *   barrier/obstacle handling, lane choice + lateral position + lane-slack. SYM-v3 locals;
 *   vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "ai_types.h"
#include "ai_externs.h"

#define WRAP_SLICE(a,b) (((a) >= 0) \
    ? ((((b) + (a)) >= gNumSlices) ? ((b) + (a)) - gNumSlices : ((b) + (a))) \
    : ((((b) + (a)) < 0) ? ((b) + (a)) + gNumSlices : ((b) + (a))))

#define AI_SLICE_BYTE(slice, offset) \
    (*(u_char *)(AI_BWorldSmSlices + (slice) * 0x20 + (offset)))
#define AI_SLICE_SHORT(slice, offset) \
    (*(short *)(AI_BWorldSmSlices + (slice) * 0x20 + (offset)))


/* ---- ai.obj-owned globals (.bss zero) ---- */
int          curveynessLevelStarts[4] = { 0, 10, 15, 25 };   /* @0x8010ccd4 */
int          CarLogic_gObs[1][3];   /* @0x8010cce4  (bss(zero)) */
AI_tInfo     AI_Info;   /* @0x8010ccf0  (bss(zero)) */
int          AI_time;   /* @0x8013c550  (bss(zero)) */
int          AI_elapsedTime;   /* @0x8013c554  (bss(zero)) */
int          AI_iTime;   /* @0x8013c558  (bss(zero)) */


/* ---- intra-TU forward declarations ---- */
void AI_StartUp(void);
void AI_CleanUp(void);
void AI_Main_OverallSetup(void);
void AI_CarAvoidance(Car_tObj *carObj);
void AI_WorldAvoidance(Car_tObj *carObj);
void AI_InitAIInfo(Car_tObj *carObj);
void AI_GenericBeginCycle(Car_tObj *carObj);
void AI_GenericCycle(Car_tObj *carObj);
void AI_GenericEndCycle(Car_tObj *carObj);
void AI_TargetLane(Car_tObj *carObj,int lane);
void AI_ClearLaneMerits(void);
void AI_DoReactions(Car_tObj *carObj);
void AI_CheckForPlayerActions(Car_tObj *carObj,Car_tObj *otherCarObj);
void AI_DoReactionsAndBehavior(Car_tObj *carObj);
void AI_OpponentBlockPlayer(Car_tObj *carObj,Car_tObj *otherCarObj);
void AI_CheckForBarriers(Car_tObj *carObj);
void AI_SetupOncomingLaneDemerits(Car_tObj *carObj);
void AI_HandleChangeInNumLanes(Car_tObj *carObj);
void AI_HandleShouldersAndOffRoad(Car_tObj *carObj);
void AI_CalculateLaneSpeeds(Car_tObj *carObj);
void AI_CalcMeritsBasedOnSpeed(Car_tObj *carObj);
void AI_CheckForClearLanes(Car_tObj *carObj);
void AI_CalcBestLineMerits(Car_tObj *carObj);
static void AI_AddCollidableObjects(Car_tObj *carObj,Group *groupSimObjs);
void AI_AvoidObjects(Car_tObj *carObj);
void AI_AvoidSpikeBelt(Car_tObj *carObj);
void AI_SubmitObstacle(Car_tObj *carObj,int importance,int leftLatPosition,int rightLatPosition,int slice);
void AI_HandleTrafficHonking(Car_tObj *carObj);
void AI_CheckForCarsOnSide(Car_tObj *carObj);
void AI_ProcessObservationsAndChooseLane(Car_tObj *carObj);
void AI_ChooseBestLane(Car_tObj *carObj);
int AI_CheckPreferredLateralPosition(Car_tObj *carObj);
int AI_TryToShareLanes(Car_tObj *carObj,Car_tObj *carInWay);
void AI_CalculateDesiredLatPosition(Car_tObj *carObj);
void AI_CalculateAdjustedDesiredSpeed(Car_tObj *carObj);
int AI_IsMellowZone(Car_tObj *carObj,int delay);
void AI_KeepCarsInLane(Car_tObj *carObj);
void AI_PushFinishedCarsToSide(Car_tObj *carObj);
void AI_MaybeChangeLaneSlack(Car_tObj *carObj);
void AI_ChooseNewLaneSlack(Car_tObj *carObj);


/* ---- AI_StartUp__Fv  [@0x8005797c] ---- */
void AI_StartUp(void)
{
  return;
}

/* ---- AI_CleanUp__Fv  [@0x80057984] ---- */
void AI_CleanUp(void)
{
  return;
}

/* ---- AI_Main_OverallSetup__Fv  [@0x8005798c] ---- */
void AI_Main_OverallSetup(void)
{
  return;
}

/* ---- AI_CarAvoidance__FP8Car_tObj  [@0x80057994] ---- */
void AI_CarAvoidance(Car_tObj *carObj)
{
  AI_SetupOncomingLaneDemerits(carObj);
  AI_CalculateLaneSpeeds(carObj);
  AI_CalcMeritsBasedOnSpeed(carObj);
  AI_CheckForClearLanes(carObj);
  AI_CheckForCarsOnSide(carObj);
  return;
}

/* ---- AI_WorldAvoidance__FP8Car_tObj  [@0x800579d8] ---- */
void AI_WorldAvoidance(Car_tObj *carObj)
{
  AI_CheckForBarriers(carObj);
  AI_HandleChangeInNumLanes(carObj);
  AI_HandleShouldersAndOffRoad(carObj);
  AI_CalcBestLineMerits(carObj);
  AI_AvoidObjects(carObj);
  AI_AvoidSpikeBelt(carObj);
  return;
}

/* ---- AI_InitAIInfo__FP8Car_tObj  [@0x80057a24] ---- */
void AI_InitAIInfo(Car_tObj *carObj)
{
  AI_Info.blockingCars[2] = (Car_tObj *)0x0;
  AI_Info.blockingCars[1] = (Car_tObj *)0x0;
  AI_Info.blockingCars[0] = (Car_tObj *)0x0;
  AI_Info.blockingCarsDist[2] = 0;
  AI_Info.blockingCarsDist[1] = 0;
  AI_Info.blockingCarsDist[0] = 0;
  AI_Info.deltaYaw = AIWorld_CalculateDeltaRoadYaw(carObj);
  AI_Info.desiredLane = 0;
  return;
}

/* ---- AI_GenericBeginCycle__FP8Car_tObj  [@0x80057a6c] ---- */
void AI_GenericBeginCycle(Car_tObj *carObj)
{
  AI_InitAIInfo(carObj);
  AI_ClearLaneMerits();
  return;
}

/* ---- AI_GenericCycle__FP8Car_tObj  [@0x80057a94] ---- */
void AI_GenericCycle(Car_tObj *carObj)
{
  AI_MaybeChangeLaneSlack(carObj);
  AI_DoReactionsAndBehavior(carObj);
  AI_PushFinishedCarsToSide(carObj);
  AI_KeepCarsInLane(carObj);
  AI_HandleTrafficHonking(carObj);
  AI_CarAvoidance(carObj);
  AI_WorldAvoidance(carObj);
  return;
}

/* ---- AI_GenericEndCycle__FP8Car_tObj  [@0x80057ae8] ---- */
void AI_GenericEndCycle(Car_tObj *carObj)
{
  AI_ProcessObservationsAndChooseLane(carObj);
  AI_CalculateDesiredLatPosition(carObj);
  AI_CalculateAdjustedDesiredSpeed(carObj);
  return;
}

/* ---- AI_TargetLane__FP8Car_tObji  [@0x80057b1c] ---- */
void AI_TargetLane(Car_tObj *carObj,int lane)
{
  if (carObj->laneIndex < lane) {
    CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + 0x50000;
    return;
  }
  if (lane < carObj->laneIndex) {
    CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + 0x50000;
  }
  return;
}

/* ---- AI_ClearLaneMerits__Fv  [@0x80057b6c] ---- */
void AI_ClearLaneMerits(void)
{
  int o;
  
  o = 0;
  do {
    o = o + 1;
    CarLogic_gObs[0][2] = 0;
    CarLogic_gObs[0][1] = 0;
    CarLogic_gObs[0][0] = 0;
  } while (o < 1);
  return;
}

/* ---- AI_DoReactions__FP8Car_tObj  [@0x80057b94] ---- */
void AI_DoReactions(Car_tObj *carObj)
{
  int target;
  int absDistance;
  int seconds;
  int metersDistance;
  Car_tObj *otherCarObj;
  
  target = AIScript_DoReAction(&carObj->script,8);
  if (target == -1) goto LAB_horncheck;
  if (GameSetup_gData.raceType == RaceType_HotPursuit) goto LAB_horncheck;
  AudioClc_SetHorn(carObj,1);
  goto LAB_afterhorn;
LAB_horncheck:
  if ((carObj->control).horn != '\0') {
    AudioClc_SetHorn(carObj,0);
  }
LAB_afterhorn:
  target = AIScript_DoReAction(&carObj->script,0x1000);
  if (target == -1) goto LAB_80057cc0;
  if (GameSetup_gData.raceType == RaceType_HotPursuit) goto LAB_80057cc0;
  {
    switch ((int)(AI_SimGlobalWords[1] & 0x18U) >> 3) {
    case 0:
      AudioClc_HonkHorn(carObj,4,0x10,8);
      break;
    case 1:
      AudioClc_HonkHorn(carObj,2,0x20,0xc);
      break;
    case 2:
      AudioClc_HonkHorn(carObj,7,0x28,0x10);
      break;
    case 3:
      AudioClc_HonkHorn(carObj,1,0x20,0);
      break;
    default:
      goto LAB_80057cc0;
    }
  }
LAB_80057cc0:
  target = AIScript_DoReAction(&carObj->script,0x200);
  if (target != -1) {
    absDistance = __builtin_abs(AIWorld_ApxSplineDistance(carObj,Cars_gList[target]));
    if (0xc0000 < absDistance) {
      seconds = AIScript_GetReactionTicksLeft(&carObj->script);
      if (seconds < 0) {
        seconds = seconds + 0x1f;
      }
      if ((seconds >> 5 & 1U) != 0) {
        CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + 0x1e0000;
      }
      else {
        CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + 0x1e0000;
      }
    }
  }
  target = AIScript_DoReAction(&carObj->script,0x20);
  if (target != -1) {
    otherCarObj = Cars_gList[target];
    metersDistance = AIWorld_SplineDistance(carObj,otherCarObj);
    if (metersDistance * carObj->direction < 0x40000) {
      AI_TargetLane(carObj,otherCarObj->laneIndex);
    }
  }
  return;
}

/* ---- AI_CheckForPlayerActions__FP8Car_tObjT0  [@0x80057dd4] ---- */
void AI_CheckForPlayerActions(Car_tObj *carObj,Car_tObj *otherCarObj)
{
  int absDistance;

  absDistance =
      __builtin_abs(AIWorld_ApxSplineDistance(carObj,otherCarObj));
  if (AIWorld_GameOdometer(carObj) < 0x3200000) {
    return;
  }
  if (((AI_SimGlobalWords[1] - (otherCarObj->N).collision.lastTime < 0xf) &&
       ((otherCarObj->N).collision.lastOtherObj != (BO_tNewtonObj *)0x0)) &&
      ((Car_tObj *)(otherCarObj->N).collision.lastOtherObj == carObj)) {
    AIScript_SubmitPlayerAction(&carObj->script,
                                otherCarObj->carIndex,0,
                                AI_SimGlobalWords[1]);
  }
  /* SYM-CODEGEN-CARRIER: direction -- repeating the member expression keeps
     144 instructions but moves retail's `lw v1,1364(s1)`, producing two
     oracle ordering diffs. */
  int direction = carObj->direction;
  if (otherCarObj->currentSpeed * direction + 0x280000 <
      carObj->currentSpeed * carObj->direction) {
    if (0xbffff < absDistance) goto LAB_80057f34;
    AIScript_SubmitPlayerAction(&carObj->script,
                                otherCarObj->carIndex,1,
                                AI_SimGlobalWords[1]);
  }
  if ((absDistance < 0xc0000) &&
      (otherCarObj->laneIndex == carObj->laneIndex)) {
    if (AIWorld_GameOdometer(otherCarObj) > AIWorld_GameOdometer(carObj)) {
      AIScript_SubmitPlayerAction(&carObj->script,
                                  otherCarObj->carIndex,2,
                                  AI_SimGlobalWords[1]);
    }
    else {
      AIScript_SubmitPlayerAction(&carObj->script,
                                  otherCarObj->carIndex,3,
                                  AI_SimGlobalWords[1]);
    }
  }
LAB_80057f34:
  if ((otherCarObj->swapCar == carObj) &&
      (AI_SimGlobalWords[1] - carObj->swapTime < 0xf)) {
    if (AIWorld_GameOdometer(carObj) > AIWorld_GameOdometer(otherCarObj)) {
      AIScript_SubmitPlayerAction(&carObj->script,
                                  otherCarObj->carIndex,4,
                                  AI_SimGlobalWords[1]);
    }
    else {
      AIScript_SubmitPlayerAction(&carObj->script,
                                  otherCarObj->carIndex,5,
                                  AI_SimGlobalWords[1]);
    }
  }
  if (((absDistance < 0x1e0000) &&
       ((otherCarObj->control).horn != '\0')) &&
      (GameSetup_gData.Time == 0))
  {
    AIScript_SubmitPlayerAction(&carObj->script,
                                otherCarObj->carIndex,6,
                                AI_SimGlobalWords[1]);
  }
  return;
}

/* ---- AI_DoReactionsAndBehavior__FP8Car_tObj  [@0x80058014] ---- */
void AI_DoReactionsAndBehavior(Car_tObj *carObj)
{
  Car_tObj *otherCarObj;
  int t;

  AI_DoReactions(carObj);
  t = 0;
  while (1) {
    if (Cars_gNumCars <= t) {
      break;
    }
    otherCarObj = Cars_gList[t];
    if (((carObj != otherCarObj) && ((otherCarObj->N).active != '\0')) &&
        ((otherCarObj->carFlags & 4U) != 0)) {
      AI_CheckForPlayerActions(carObj,otherCarObj);
      if ((carObj->carFlags & 8U) != 0) {
        AI_OpponentBlockPlayer(carObj,otherCarObj);
      }
    }
    t = t + 1;
  }
  return;
}

/* ---- AI_OpponentBlockPlayer__FP8Car_tObjT0  [@0x800580d8] ---- */
void AI_OpponentBlockPlayer(Car_tObj *carObj,Car_tObj *otherCarObj)
{
  int otherCarObjSlice;
  int distance;

  if (AI_IsMellowZone(carObj,0x1900000) != 0) {
    return;
  }
  if (!(AI_Info.deltaYaw < curveynessLevelStarts[2])) {
    return;
  }
  otherCarObjSlice = (otherCarObj->N).simRoadInfo.slice;
  distance =
      AIWorld_SplineDistance(carObj,otherCarObj) * carObj->direction;
  if ((AIScript_DoReAction(&carObj->script,0x400) != -1) &&
      (0 <= distance) && (distance <= 0x31ffff)) {
    if (otherCarObj->laneIndex < carObj->laneIndex) {
      CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + -0x40000;
    }
    else if (otherCarObj->laneIndex == carObj->laneIndex) {
      CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + -0x40000;
    }
    else {
      CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + -0x40000;
    }
    return;
  }
  if (distance < -0x60000) {
    return;
  }
  if (carObj->personality->blockMaxDistance <= distance) {
    return;
  }
  if (distance < carObj->personality->blockMinDistance) {
    return;
  }
  if (otherCarObj->laneIndex <
      (int)(7 - (u_int)(AI_SLICE_BYTE(otherCarObjSlice,0x1d) >> 4))) {
    return;
  }
  if ((int)((AI_SLICE_BYTE(otherCarObjSlice,0x1d) & 0xf) + 6) <
      otherCarObj->laneIndex) {
    return;
  }
  if (otherCarObj->currentSpeed * otherCarObj->direction < 0x140001) {
    return;
  }
  if (otherCarObj->laneIndex < carObj->laneIndex) {
    CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + 0x40000;
  }
  else if (otherCarObj->laneIndex == carObj->laneIndex) {
    CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + 0x40000;
  }
  else {
    CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + 0x40000;
  }
  return;
}

/* ---- AI_CheckForBarriers__FP8Car_tObj  [@0x800582d4] ---- */
void AI_CheckForBarriers(Car_tObj *carObj)
{
  int dir;
  int slicesAhead;
  int forwardSlice0;
  int forwardSlice1;
  int interval;
  int masks[3];
  int laneNotChecked[3] = {1, 1, 1};
  int speed;
  int sliceLoop;
  int slice;
  int profileHere;

  masks[0] = AIWorld_GetProfileMask(carObj->laneIndex + -1);
  masks[1] = AIWorld_GetProfileMask(carObj->laneIndex);
  masks[2] = AIWorld_GetProfileMask(carObj->laneIndex + 1);
  slice = (int)carObj->N.simRoadInfo.slice;
  dir = carObj->direction;
  speed = carObj->currentSpeed / 0x10000;
  speed = __builtin_abs(speed);
  slicesAhead = (speed << 0x12) / 0x60000;
  forwardSlice0 = WRAP_SLICE(slicesAhead * dir,slice);
  forwardSlice1 = WRAP_SLICE((slicesAhead + 1) * dir,slice);
  profileHere = *(short *)(slice * 0x20 + (int)AI_BWorldSmSlices + 0x16);
  if (AIWorld_IsDriveableLane_UsingMask(slice,masks[0]) == 0) {
    CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + -0xa0000;
  }
  if (AIWorld_IsDriveableLane_UsingMask(slice,masks[1]) == 0) {
    CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + -0xa0000;
  }
  if (AIWorld_IsDriveableLane_UsingMask(slice,masks[2]) == 0) {
    CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + -0xa0000;
  }
  if ((profileHere != *(short *)(forwardSlice0 * 0x20 + (int)AI_BWorldSmSlices + 0x16)) ||
     (profileHere != *(short *)(forwardSlice1 * 0x20 + (int)AI_BWorldSmSlices + 0x16))) {
    carObj->barrierThinkHarder = 0x49;
  }
  if (0 < carObj->barrierThinkHarder) {
    interval = (slicesAhead * 0xa3d) / 0x10000;
    sliceLoop = 0;
    if (interval == 0) {
      interval = 1;
    }
    carObj->barrierThinkHarder = carObj->barrierThinkHarder - AI_elapsedTime;
    while (sliceLoop < slicesAhead) {
      int checkSlice;

      checkSlice = WRAP_SLICE(sliceLoop * dir,slice);
      if ((laneNotChecked[0] != 0) &&
         (AIWorld_IsDriveableLane_UsingMask(checkSlice,masks[0]) == 0)) {
        laneNotChecked[0] = 0;
        CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + -0x280000;
      }
      if ((laneNotChecked[1] != 0) &&
        (AIWorld_IsDriveableLane_UsingMask(checkSlice,masks[1]) == 0)) {
        laneNotChecked[1] = 0;
        CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + -0x280000;
      }
      if ((laneNotChecked[2] != 0) &&
        (AIWorld_IsDriveableLane_UsingMask(checkSlice,masks[2]) == 0)) {
        laneNotChecked[2] = 0;
        CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + -0x280000;
      }
      sliceLoop = sliceLoop + interval;
    }
  }
  return;
}

/* ---- AI_SetupOncomingLaneDemerits__FP8Car_tObj  [@0x80058694] ---- */
void AI_SetupOncomingLaneDemerits(Car_tObj *carObj)
{
  int opposingLaneMerit;
  
  opposingLaneMerit = AI_IsMellowZone(carObj,0x3c0000);
  if (opposingLaneMerit == 0) {
    opposingLaneMerit = -0x40000;
    if ((carObj->carFlags & 0x10U) != 0) {
      opposingLaneMerit = -0xc0000;
    }
    if ((((Cars_gNumTrafficCars != 0) || (Cars_gNumCopCars != 0)) && (AITune_oneWay == 0)) &&
       ((carObj->AIFlags & 2U) == 0)) {
      if (carObj->direction == AITune_driveSide) {
        if (carObj->laneIndex + -1 < 7) {
          CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + opposingLaneMerit;
        }
        if (carObj->laneIndex < 7) {
          CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + opposingLaneMerit;
        }
      }
      else {
        if (6 < carObj->laneIndex) {
          CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + opposingLaneMerit;
        }
        if (6 < carObj->laneIndex + 1) {
          CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + opposingLaneMerit;
        }
      }
    }
  }
  return;
}

/* ---- AI_HandleChangeInNumLanes__FP8Car_tObj  [@0x800587ec] ---- */
void AI_HandleChangeInNumLanes(Car_tObj *carObj)
{
  int lookAheadSlice;
  int absLaneLookAhead;
  int lookAhead;
  int laneIndex;
  /* SYM-CODEGEN-CARRIER: laneCount -- retail names only the four int locals above.  This
   * byte cache recreates the compiler web needed by the authoritative PASS;
   * spelling both laneCount reads directly removes one instruction and
   * recolors lookAhead/laneIndex. */
  u_char laneCount;

  absLaneLookAhead = carObj->currentSpeed;
  if (absLaneLookAhead < 0) {
    absLaneLookAhead = -absLaneLookAhead;
  }
  laneIndex = fixedmult(absLaneLookAhead,0x6aaa);
  lookAhead = laneIndex;
  if (laneIndex < 0) {
    lookAhead = laneIndex + 0xffff;
  }
  laneIndex = lookAhead >> 0x10;
  if (laneIndex < 5) {
    laneIndex = 5;
  }
  laneIndex = carObj->direction * laneIndex;
  if (0 <= laneIndex) {
    lookAheadSlice = (carObj->N).simRoadInfo.slice + laneIndex;
    if (gNumSlices <= lookAheadSlice) {
      lookAheadSlice = lookAheadSlice - gNumSlices;
      goto LAB_800588a4;
    }
  }
  else {
    lookAheadSlice = (carObj->N).simRoadInfo.slice + laneIndex;
    if (lookAheadSlice < 0) {
      lookAheadSlice = lookAheadSlice + gNumSlices;
    }
  }
LAB_800588a4:
  laneCount = AI_SLICE_BYTE(lookAheadSlice,0x1d);
  laneIndex = carObj->laneIndex;
  if ((laneIndex < (int)(7 - (u_int)(laneCount >> 4))) ||
      ((int)((laneCount & 0xf) + 6) < laneIndex)) {
    laneCount = AI_SLICE_BYTE((carObj->N).simRoadInfo.slice,0x1d);
    if (laneIndex < (int)(7 - (u_int)(laneCount >> 4))) {
      return;
    }
    if ((int)((laneCount & 0xf) + 6) < laneIndex) {
      return;
    }
    if (laneIndex < 7) {
      CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + 0x280000;
    }
    else {
      CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + 0x280000;
    }
  }
  return;
}

/* ---- AI_HandleShouldersAndOffRoad__FP8Car_tObj  [@0x8005895c] ---- */
void AI_HandleShouldersAndOffRoad(Car_tObj *carObj)
{
  int slice;
  int shoulder_merit;
  int isRight;

  slice = (int)(carObj->N).simRoadInfo.slice;
  shoulder_merit = -0x4e666;
  if (((((carObj->carFlags & 0x10U) != 0) &&
       (shoulder_merit = -0x260000, AI_Info.blockingCars[1] != (Car_tObj *)0x0)) &&
      ((AI_Info.blockingCars[1]->carFlags & 1U) != 0)) && (0x8e38e < AI_Info.blockingCars[1]->speed)
     ) {
    shoulder_merit = 0x50000;
  }
  if ((carObj->laneIndex - 1 ==
       6 - (u_int)(AI_SLICE_BYTE(slice,0x1d) >> 4)) ||
      (carObj->laneIndex - 1 ==
       (AI_SLICE_BYTE(slice,0x1d) & 0xf) + 7)) {
    CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + shoulder_merit;
    /* SYM-CODEGEN-CARRIER: sl -- direct typed slice access drops retail from
       241 to 221 instructions and produces 222 allocation/order diffs. */
    char *sl = (char *)((carObj->N).simRoadInfo.slice * 0x20 +
                        (int)AI_BWorldSmSlices);
    if ((*(short *)(sl + 0x18) << 8) -
        (*(u_char *)(sl + 0x1e) << 0xf) * (*(u_char *)(sl + 0x1d) >> 4) <
        (carObj->N).dimension.x) {
      CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + -0x640000;
    }
  }
  if ((carObj->laneIndex + 1 ==
       6 - (u_int)(AI_SLICE_BYTE(slice,0x1d) >> 4)) ||
      (carObj->laneIndex + 1 ==
       (AI_SLICE_BYTE(slice,0x1d) & 0xf) + 7)) {
    CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + shoulder_merit;
    char *sl = (char *)((carObj->N).simRoadInfo.slice * 0x20 +
                        (int)AI_BWorldSmSlices);
    if ((*(short *)(sl + 0x1a) << 8) -
        (*(u_char *)(sl + 0x1f) << 0xf) * (*(u_char *)(sl + 0x1d) & 0xf) <
        (carObj->N).dimension.x) {
      CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + -0x640000;
    }
  }
  if ((carObj->laneIndex == 6 - (u_int)(AI_SLICE_BYTE(slice,0x1d) >> 4)) ||
      (carObj->laneIndex == (AI_SLICE_BYTE(slice,0x1d) & 0xf) + 7)) {
    CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + shoulder_merit;
    isRight = (carObj->laneIndex < 7) ^ 1;
    if (carObj->laneIndex < 7) {
      char *sl = (char *)((carObj->N).simRoadInfo.slice * 0x20 +
                          (int)AI_BWorldSmSlices);
      if ((*(short *)(sl + 0x18) << 8) -
          (*(u_char *)(sl + 0x1e) << 0xf) * (*(u_char *)(sl + 0x1d) >> 4) <
          (carObj->N).dimension.x) {
        goto CENTER_DEMERIT;
      }
    }
    if (isRight != 0) {
      char *sl;
      sl = (char *)((carObj->N).simRoadInfo.slice * 0x20 +
                    (int)AI_BWorldSmSlices);
      if ((*(short *)(sl + 0x1a) << 8) -
          (*(u_char *)(sl + 0x1f) << 0xf) * (*(u_char *)(sl + 0x1d) & 0xf) <
          (carObj->N).dimension.x) {
CENTER_DEMERIT:
        CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + -0x640000;
      }
    }
  }
  if ((carObj->laneIndex - 1 <
       (int)(6 - (u_int)(AI_SLICE_BYTE(slice,0x1d) >> 4))) ||
      ((int)((AI_SLICE_BYTE(slice,0x1d) & 0xf) + 7) <
       carObj->laneIndex - 1)) {
    CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + -0x3e80000;
  }
  if ((carObj->laneIndex < (int)(6 - (u_int)(AI_SLICE_BYTE(slice,0x1d) >> 4))) ||
      ((int)((AI_SLICE_BYTE(slice,0x1d) & 0xf) + 7) < carObj->laneIndex)) {
    CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + -0x3e80000;
  }
  if ((carObj->laneIndex + 1 <
       (int)(6 - (u_int)(AI_SLICE_BYTE(slice,0x1d) >> 4))) ||
      ((int)((AI_SLICE_BYTE(slice,0x1d) & 0xf) + 7) <
       carObj->laneIndex + 1)) {
    CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + -0x3e80000;
  }
  return;
}

/* ---- AI_CalculateLaneSpeeds__FP8Car_tObj  [@0x80058d20] ---- */
void AI_CalculateLaneSpeeds(Car_tObj *carObj)
{
  Car_tObj *otherCarObj;
  int ci;
  int carObjIndexInSortedList;
  int carsFound;
  int lanesFilled;
  int distanceFixedMeters;
  int distanceIntMeters;
  int distanceFixedMetersSignChecked;
  int inverseCollisionTime;
  int inverseAheadCollisionTime;
  int carObjLeftLaneBits;
  int carObjThisLaneBits;
  int carObjRightLaneBits;
  int maxDistanceToCheck;
  int collisionSpeed;
  int aheadCollisionSpeed;

  lanesFilled = 0;
  ci = 0;
  carsFound = 0;
  maxDistanceToCheck = *(int *)((char *)carObj->personality + 8);
  AI_Info.laneSpeeds[0] =
      AI_Info.laneSpeedsAhead[0] = carObj->desiredSpeed;
  AI_Info.laneSpeeds[1] =
      AI_Info.laneSpeedsAhead[1] = carObj->desiredSpeed;
  AI_Info.laneSpeeds[2] =
      AI_Info.laneSpeedsAhead[2] = carObj->desiredSpeed;
  carObjIndexInSortedList = carObj->sortIndex;
  carObjLeftLaneBits = 1 << (carObj->laneIndex - 1);
  carObjThisLaneBits = 1 << carObj->laneIndex;
  carObjRightLaneBits = 1 << (carObj->laneIndex + 1);
  do {
    if ((carsFound == 3) || (Cars_gNumCars <= ci)) {
      return;
    }
    otherCarObj = Cars_gSortedList[
        (carObjIndexInSortedList + ci * carObj->direction + Cars_gNumCars) %
        Cars_gNumCars];
    if ((carObj != otherCarObj) && ((otherCarObj->N).active != '\0')) {
      distanceFixedMeters = AIWorld_SplineDistance(otherCarObj,carObj);
      distanceFixedMetersSignChecked = distanceFixedMeters * carObj->direction;
      if (__builtin_abs(carObj->currentSpeed) < 0x1638e3) {
        inverseCollisionTime = 0xd555;
        inverseAheadCollisionTime = 0x6666;
      }
      else {
        inverseCollisionTime = 0x14000;
        inverseAheadCollisionTime = 0x8e38;
      }
      if (distanceFixedMetersSignChecked < 0xf0000) {
        inverseCollisionTime = 0x2aaa;
        inverseAheadCollisionTime = 0x1999;
      }
      if (((carObj->N).dimension.z < distanceFixedMetersSignChecked) &&
        (distanceFixedMetersSignChecked < maxDistanceToCheck)) {
        if (carObj->direction == 1) {
          distanceIntMeters = distanceFixedMeters / 0x10000 - 2;
          if ((carObj->carFlags & 0x28U) != 0) {
            if (distanceIntMeters <= 0) {
              distanceIntMeters = 1;
            }
          }
          distanceIntMeters =
              (distanceIntMeters < 0) ? 0 : distanceIntMeters;
        }
        else {
          distanceIntMeters = distanceFixedMeters;
          if (distanceIntMeters < 0) {
            distanceIntMeters = distanceIntMeters + 0xffff;
          }
          distanceIntMeters = (distanceIntMeters >> 0x10) + 2;
          if (((carObj->carFlags & 0x28U) != 0) && (1 < distanceIntMeters)) {
            distanceIntMeters = -1;
          }
          distanceIntMeters =
              (0 < distanceIntMeters) ? 0 : distanceIntMeters;
        }
        collisionSpeed = otherCarObj->currentSpeed + distanceIntMeters * inverseCollisionTime;
        aheadCollisionSpeed = otherCarObj->currentSpeed + distanceIntMeters * inverseAheadCollisionTime;
        if (((otherCarObj->carInLane & carObjThisLaneBits) != 0) && ((lanesFilled & carObjThisLaneBits) == 0)) {
          lanesFilled = lanesFilled | carObjThisLaneBits;
          carsFound = carsFound + 1;
          AI_Info.laneSpeeds[1] = collisionSpeed;
          AI_Info.laneSpeedsAhead[1] = aheadCollisionSpeed;
          AI_Info.blockingCars[1] = otherCarObj;
          AI_Info.blockingCarsDist[1] = distanceFixedMetersSignChecked;
        }
        if (((carObj->laneIndex - 1U < 0xe) && ((otherCarObj->carInLane & carObjLeftLaneBits) != 0)) &&
           ((lanesFilled & carObjLeftLaneBits) == 0)) {
          lanesFilled = lanesFilled | carObjLeftLaneBits;
          carsFound = carsFound + 1;
          AI_Info.laneSpeeds[0] = collisionSpeed;
          AI_Info.laneSpeedsAhead[0] = aheadCollisionSpeed;
          AI_Info.blockingCars[0] = otherCarObj;
          AI_Info.blockingCarsDist[0] = distanceFixedMetersSignChecked;
        }
        if (((carObj->laneIndex + 1U < 0xe) && ((otherCarObj->carInLane & carObjRightLaneBits) != 0)) &&
           ((lanesFilled & carObjRightLaneBits) == 0)) {
          lanesFilled = lanesFilled | carObjRightLaneBits;
          carsFound = carsFound + 1;
          AI_Info.laneSpeeds[2] = collisionSpeed;
          AI_Info.laneSpeedsAhead[2] = aheadCollisionSpeed;
          AI_Info.blockingCars[2] = otherCarObj;
          AI_Info.blockingCarsDist[2] = distanceFixedMetersSignChecked;
        }
      }
    }
    ci = ci + 1;
  } while( true );
}

/* ---- AI_CalcMeritsBasedOnSpeed__FP8Car_tObj  [@0x800590b4] ---- */
void AI_CalcMeritsBasedOnSpeed(Car_tObj *carObj)
{
  int dSpeed;
  int cSpeed;
  int considerDesired;

  dSpeed = carObj->desiredSpeed;
  cSpeed = carObj->currentSpeed;
  considerDesired = 0x257ffff < AIWorld_GameOdometer(carObj);
  if ((AI_Info.blockingCars[0] != (Car_tObj *)0x0) && (AI_Info.blockingCarsDist[0] < 0x1e0000)) {
    CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + -0xe0000;
  }
  if ((AI_Info.blockingCars[1] != (Car_tObj *)0x0) && (AI_Info.blockingCarsDist[1] < 0x1e0000)) {
    CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + -0xe0000;
  }
  if ((AI_Info.blockingCars[2] != (Car_tObj *)0x0) && (AI_Info.blockingCarsDist[2] < 0x1e0000)) {
    CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + -0xe0000;
  }
  if (carObj->direction == 1) {
    /* SYM-CODEGEN-CARRIER: observation -- the matched NFS2 `for (i...)`
       source form compiles NFS4 to 226 rather than 224 instructions and
       produces 266 allocation/flow diffs. */
    int *observation;
    /* SYM-CODEGEN-CARRIER: observationBase -- direct end-bound spellings
       compile to 222 instructions with ten oracle diffs. */
    int *observationBase;
    /* SYM-CODEGEN-CARRIER: laneInfo -- required strength-reduced AI_Info base. */
    AI_tInfo *laneInfo;
    /* SYM-CODEGEN-CARRIER: laneSpeed -- required retail load/result lifetime. */
    int laneSpeed;
    /* SYM-CODEGEN-CARRIER: lane -- literal `[0]` changes the saved-register
       set/frame and compiles to 230 instructions with 232 oracle diffs. */
    int lane;

    lane = 0;
    observation = &CarLogic_gObs[0][0];
    observationBase = observation;
    laneInfo = &AI_Info;
    do {
      laneSpeed = laneInfo->laneSpeeds[lane];
      if (laneSpeed <= cSpeed) {
        if (laneInfo->blockingCars[lane] != (Car_tObj *)0x0) {
          *observation =
              *observation + fixedmult(cSpeed - laneSpeed,-0x14ccc);
          laneSpeed = laneInfo->laneSpeeds[lane];
        }
      }
      if (((laneSpeed <= dSpeed) &&
           (laneInfo->blockingCars[lane] != (Car_tObj *)0x0)) &&
          considerDesired)
      {
        *observation =
            *observation + fixedmult(dSpeed - laneSpeed,-0x8000);
      }
      laneSpeed = laneInfo->laneSpeedsAhead[lane];
      if (laneSpeed <= cSpeed) {
        if (laneInfo->blockingCars[lane] != (Car_tObj *)0x0) {
          *observation =
              *observation + fixedmult(cSpeed - laneSpeed,-0x8000);
          laneSpeed = laneInfo->laneSpeedsAhead[lane];
        }
      }
      if (((laneSpeed <= dSpeed) &&
           (laneInfo->blockingCars[lane] != (Car_tObj *)0x0)) &&
          considerDesired)
      {
        *observation =
            *observation + fixedmult(dSpeed - laneSpeed,-0x1999);
      }
      observation = observation + 1;
      laneInfo = (AI_tInfo *)(laneInfo->blockingCars + 1);
    } while ((int)observation < (int)(observationBase + 3));
  }
  else {
    int *observation;
    int *observationBase;
    AI_tInfo *laneInfo;
    int laneSpeed;
    int lane;

    lane = 0;
    observation = &CarLogic_gObs[0][0];
    observationBase = observation;
    laneInfo = &AI_Info;
    do {
      /* 04Q (objdiff 99.96 -> 100): the old `goto noLaneSpeedMerit` skip device
       * FORCED a jump-threaded flow (blockingCars==0 skipping the dSpeed block
       * entirely) that the oracle does NOT have -- retail re-enters the dSpeed
       * block and re-tests.  verify_asm was blind to it (branch targets are
       * normalized to T); objdiff caught the 2 target diffs.  The plain
       * nested-if shape below (same as the direction==1 loop) is behaviorally
       * identical and produces the oracle's un-threaded targets. */
      laneSpeed = laneInfo->laneSpeeds[lane];
      if (cSpeed <= laneSpeed) {
        if (laneInfo->blockingCars[lane] != (Car_tObj *)0x0) {
          *observation =
              *observation + fixedmult(laneSpeed - cSpeed,-0x14ccc);
        }
        laneSpeed = laneInfo->laneSpeeds[lane];  /* reload OUTSIDE the inner if */
      }
      if ((dSpeed <= laneSpeed) &&
          (laneInfo->blockingCars[lane] != (Car_tObj *)0x0)) {
        *observation =
            *observation + fixedmult(laneSpeed - dSpeed,-0x8000);
      }
      laneSpeed = laneInfo->laneSpeedsAhead[lane];
      if (cSpeed <= laneSpeed) {
        if (laneInfo->blockingCars[lane] != (Car_tObj *)0x0) {
          *observation =
              *observation + fixedmult(laneSpeed - cSpeed,-0x8000);
        }
        laneSpeed = laneInfo->laneSpeedsAhead[lane];
      }
      if ((dSpeed <= laneSpeed) &&
          (laneInfo->blockingCars[lane] != (Car_tObj *)0x0)) {
        *observation =
            *observation + fixedmult(laneSpeed - dSpeed,-0x1999);
      }
      observation = observation + 1;
      laneInfo = (AI_tInfo *)(laneInfo->blockingCars + 1);
    } while ((int)observation < (int)(observationBase + 3));
  }
  return;
}

/* ---- AI_CheckForClearLanes__FP8Car_tObj  [@0x80059434] ---- */
void AI_CheckForClearLanes(Car_tObj *carObj)
{
  int lanesFilled;
  int dir;
  int carsFound;
  int ci;
  Car_tObj *otherCarObj;
  int carObjIndexInSortedList;
  int clearAheadMerits[3];

  carObjIndexInSortedList = carObj->sortIndex;
  lanesFilled = 0;
  if (((carObj->carFlags & 8U) != 0) &&
     (AI_IsMellowZone(carObj,lanesFilled) == 0)) {
    clearAheadMerits[2] = 0x40000;
    clearAheadMerits[1] = 0x40000;
    clearAheadMerits[0] = 0x40000;
    ci = carObj->direction;
    carsFound = lanesFilled;
    dir = ci;
    while ((carsFound != 3) && (ci < Cars_gNumCars)) {
      otherCarObj = Cars_gSortedList[
          (carObjIndexInSortedList + ci * dir + Cars_gNumCars) % Cars_gNumCars];
      if (carObj == otherCarObj) goto NEXT_CAR;
      if ((otherCarObj->N).active == '\0') goto NEXT_CAR;
      if (AIWorld_SplineDistance(otherCarObj,carObj) + 0x40000U >= 0x6e0000) goto NEXT_CAR;
      if (((otherCarObj->carInLane >> carObj->laneIndex & 1U) != 0) &&
         ((lanesFilled >> carObj->laneIndex & 1U) == 0)) {
        clearAheadMerits[1] = 0;
        carsFound = carsFound + 1;
        lanesFilled = lanesFilled | 1 << carObj->laneIndex;
      }
      if ((0 < carObj->laneIndex) &&
         (((otherCarObj->carInLane >> (carObj->laneIndex - 1) & 1U) != 0) &&
         ((lanesFilled >> (carObj->laneIndex - 1) & 1U) == 0))) {
        clearAheadMerits[0] = 0;
        carsFound = carsFound + 1;
        lanesFilled = lanesFilled | 1 << (carObj->laneIndex - 1U);
      }
      if ((carObj->laneIndex + 1U < 0xe) &&
         (((otherCarObj->carInLane >> (carObj->laneIndex + 1) & 1U) != 0) &&
         ((lanesFilled >> (carObj->laneIndex + 1) & 1U) == 0))) {
        clearAheadMerits[2] = 0;
        carsFound = carsFound + 1;
        lanesFilled = lanesFilled | 1 << (carObj->laneIndex + 1U);
      }
NEXT_CAR:
      ci = ci + 1;
    }
    CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + clearAheadMerits[0];
    CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + clearAheadMerits[1];
    CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + clearAheadMerits[2];
  }
  return;
}

/* ---- AI_CalcBestLineMerits__FP8Car_tObj  [@0x800596a4] ---- */
void AI_CalcBestLineMerits(Car_tObj *carObj)
{
  int checkSlice;
  int slice;
  char*buffer;
  int latPos;

  slice = carObj->lookAheadSlice;
  if ((carObj->carFlags & 8U) != 0) {
    latPos = fixedmult(*(int *)((char *)carObj->personality + 0x44),
                        (int)(signed char)AIDataRecord_BestLine->dataBuffer_
                             [slice] << 0xe);
    carObj->preferredLateralPosition = latPos;
    carObj->preferredLateralPositionPower = 0x50000;
    carObj->preferredLateralPosition = latPos - carObj->laneSlack * carObj->direction;
  }
  return;
}

/* ---- AI_AddCollidableObjects__FP8Car_tObjP5Group  [@0x8005972c] ---- */
static void AI_AddCollidableObjects(Car_tObj *carObj,Group *groupSimObjs)
{
  Trk_SimObject*simObjs;
  static BWorldSm_Pos spos;
  static char firstTime;
  int objectIndex;
  coorddef pt;
  coorddef centerSlice;
  coorddef centerToPt;
  int latPos;
  int avoidance;
  int radius;

  simObjs = (Trk_SimObject *)(groupSimObjs + 1);
  if (firstTime != '\0') {
    firstTime = '\0';
    BWorldSm_SetSlice(0,(BWorldSm_Pos *)&spos);
  }
  objectIndex = 0;
  while (1) {
    if (groupSimObjs->m_num_elements <= objectIndex) {
      break;
    }
    pt.x = simObjs[objectIndex].point[0];
    pt.y = simObjs[objectIndex].point[1];
    pt.z = simObjs[objectIndex].point[2];
    BWorldSm_FindClosestSlice(&pt,(BWorldSm_Pos *)&spos);
    if ((u_int)(AIWorld_ApxSplineDistance(spos.slice,carObj) *
                carObj->direction - 1) < 0x63ffff) {
      centerSlice = *(coorddef *)
          (AI_BWorldSmSlices + (carObj->N).simRoadInfo.slice * 0x20);
      centerToPt.x = pt.x - centerSlice.x;
      centerToPt.y = pt.y - centerSlice.y;
      centerToPt.z = pt.z - centerSlice.z;
      latPos =
          (carObj->N).roadMatrix.m[0] / 0x100 * (centerToPt.x / 0x100) +
          (carObj->N).roadMatrix.m[1] / 0x100 * (centerToPt.y / 0x100) +
          (carObj->N).roadMatrix.m[2] / 0x100 * (centerToPt.z / 0x100);
      avoidance = -0xd0000;
      if (simObjs[objectIndex].type == 1) {
        avoidance = -0x280000;
      }
      radius = simObjs[objectIndex].radius;
      AI_SubmitObstacle(carObj,avoidance,latPos + radius * -0x200,latPos + radius * 0x200,spos.slice);   /* H17: 5th arg (slice) was 0; oracle 0x800598E4 reload spos.slice -> feeds AIWorld_LaneIndex */
    }
    objectIndex = objectIndex + 1;
  }
  return;
}

/* ---- AI_AvoidObjects__FP8Car_tObj  [@0x80059928] ---- */
void AI_AvoidObjects(Car_tObj *carObj)
{
  if (Object_customObjInst != (Group *)0x0) {
    AI_AddCollidableObjects(carObj,Object_customSimObjs);
  }
  return;
}

/* ---- AI_AvoidSpikeBelt__FP8Car_tObj  [@0x8005995c] ---- */
void AI_AvoidSpikeBelt(Car_tObj *carObj)
{
  int spikeSlice;
  int leftLatPos;
  int width;

  if (BWorld_GetSpikeBelt(&spikeSlice,&leftLatPos,&width) == 0) {
    return;
  }
  if (0x63ffff <= AIWorld_ApxSplineDistance(spikeSlice,carObj) * carObj->direction - 1U) {
    return;
  }
  AI_SubmitObstacle(carObj,-0x280000,leftLatPos,leftLatPos + width,spikeSlice);
  return;
}

/* ---- AI_SubmitObstacle__FP8Car_tObjiiii  [@0x800599e4] ---- */
void AI_SubmitObstacle(Car_tObj *carObj,int importance,int leftLatPosition,int rightLatPosition,int slice)
{
  int leftEdgeIndex;
  int rightEdgeIndex;
  int observations[3];
  int leftDistance;
  int rightDistance;

  memset((u_char *)observations,'\0',0xc);
  leftEdgeIndex = AIWorld_LaneIndex(slice,leftLatPosition);
  rightEdgeIndex = AIWorld_LaneIndex(slice,rightLatPosition);
  if (((u_int)rightEdgeIndex < 0xe) && ((u_int)leftEdgeIndex < 0xe)) {
    if (((int)leftEdgeIndex <= carObj->laneIndex + -1) &&
        (carObj->laneIndex + -1 <= (int)rightEdgeIndex)) {
      observations[0] = importance;
    }
    if (((int)leftEdgeIndex <= carObj->laneIndex) && (carObj->laneIndex <= (int)rightEdgeIndex)) {
      observations[1] = importance;
    }
    if (((int)leftEdgeIndex <= carObj->laneIndex + 1) &&
        (carObj->laneIndex + 1 <= (int)rightEdgeIndex)) {
      observations[2] = importance;
    }
    if (((observations[0] != 0) && (observations[1] != 0)) && (observations[2] != 0)) {
      leftDistance = carObj->roadPosition - leftLatPosition;
      rightDistance = carObj->roadPosition - rightLatPosition;
      leftDistance = __builtin_abs(leftDistance);
      rightDistance = __builtin_abs(rightDistance);
      if (leftDistance < rightDistance) {
        observations[0] = 0;
      }
      else {
        observations[2] = 0;
      }
    }
    CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + observations[0];
    CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + observations[1];
    CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + observations[2];
  }
  return;
}

/* D_8011321C == GameSetup_gData.reverseTrack (GameSetup_gData+0x30) -- standalone-symbol
 * form matches the reloc, same precedent as aiinit.cpp AIInit_RestartAICar / hud.cpp. */
extern int D_8011321C;

/* ---- AI_HandleTrafficHonking__FP8Car_tObj  [@0x80059b88] ---- */
void AI_HandleTrafficHonking(Car_tObj *carObj)
{
  Car_tObj*visibleCar;
  /* SYM-CODEGEN-CARRIER: randomValue -- folding the scaled RNG result into
     the following guard remains 65 instructions but rotates the `$a0/$v1`
     allocation across the RNG stores, producing 24 oracle diffs. */
  int randomValue;

  visibleCar = AILife_IsCarInAnyVisibleArea(carObj);
  if ((carObj->carFlags & 0x10U) != 0) {
    /* SYM-CODEGEN-CARRIER: direction -- repeating the member read in both
       ternary arms compiles to 73 instructions/16 oracle diffs instead of
       retail's single load and 65-instruction PASS. */
    int direction = carObj->direction;
    /* @0x80059BC8: stored bool (sltu zero,result) of the ternary -- honk unless value == 0
     * (value = ~direction when D_8011321C, else direction^1). */
    /* SYM-CODEGEN-CARRIER: shouldHonk -- testing the ternary directly, while
       retaining `direction`, creates a branch diamond: 68 instructions and
       5 oracle diffs rather than retail's materialized boolean PASS. */
    bool shouldHonk =
      ((D_8011321C == 0) ? (direction ^ 1) : ~direction) != 0;
    if ((shouldHonk &&
         (visibleCar != (Car_tObj *)0x0)) &&
        (-0x30000 < AI_Info.laneSpeeds[1])) {
      randtemp = fastRandom * randSeed;
      fastRandom = randtemp & 0xffff;
      randomValue = (int)((randtemp >> 8 & 0xffff) * 1000 >> 0x10);
      if (((GameSetup_gData.commMode != 1) && (randomValue < 5)) &&
         (carObj->currentSpeed != 0)) {
        AudioClc_HonkHorn(carObj,2,0x20,8);
      }
    }
  }
  return;
}

/* ---- AI_CheckForCarsOnSide__FP8Car_tObj  [@0x80059c8c] ---- */
void AI_CheckForCarsOnSide(Car_tObj *carObj)
{
  Car_tObj*otherCarObj;
  int ci;
  int absDistance;
  int blockDistance;

  if ((carObj->carFlags & 0x10U) == 0) {
    blockDistance =
        (carObj->N).dimension.z * 2 + (carObj->N).dimension.z / 2;
    for (ci = 0; ci < Cars_gNumCars; ci++) {
      otherCarObj = Cars_gList[ci];
      if ((carObj != otherCarObj) && ((otherCarObj->N).active != '\0')) {
        absDistance = __builtin_abs(AIWorld_SplineDistance(otherCarObj,carObj));
        if ((absDistance < 0xa0001) && (absDistance < blockDistance)) {
          if (otherCarObj->laneIndex == carObj->laneIndex + -1) {
            CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + -0x60000;
          }
          else if (otherCarObj->laneIndex == carObj->laneIndex + 1) {
            CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + -0x60000;
          }
        }
      }
    }
  }
  return;
}

/* ---- AI_ProcessObservationsAndChooseLane__FP8Car_tObj  [@0x80059ddc] ---- */
void AI_ProcessObservationsAndChooseLane(Car_tObj *carObj)
{
  AI_Info.laneWeights[0] = CarLogic_gObs[0][0];
  AI_Info.laneWeights[1] = CarLogic_gObs[0][1];
  AI_Info.laneWeights[2] = CarLogic_gObs[0][2];
  AI_ChooseBestLane(carObj);
  return;
}

/* ---- AI_ChooseBestLane__FP8Car_tObj  [@0x80059e20] ---- */
void AI_ChooseBestLane(Car_tObj *carObj)
{
  int best;

  best = AI_Info.laneWeights[1];
  AI_Info.desiredLane = carObj->laneIndex;
  AI_Info.desiredLaneSide = 1;
  if (AI_Info.laneWeights[1] < AI_Info.laneWeights[0]) {
    AI_Info.desiredLane = carObj->laneIndex + -1;
    best = AI_Info.laneWeights[0];
    AI_Info.desiredLaneSide = 0;
  }
  if (best < AI_Info.laneWeights[2]) {
    AI_Info.desiredLane = carObj->laneIndex + 1;
    AI_Info.desiredLaneSide = 2;
  }
  if (AI_Info.desiredLane < 0) {
    AI_Info.desiredLane = 0;
    return;
  }
  if (0xd < AI_Info.desiredLane) {
    AI_Info.desiredLane = 0xd;
  }
  return;
}

/* ---- AI_CheckPreferredLateralPosition__FP8Car_tObj  [@0x80059eac] ---- */
int AI_CheckPreferredLateralPosition(Car_tObj *carObj)
{
  int carSideLane;
  int carLeftSideLaneWRTcurrent;
  int carRightSideLaneWRTcurrent;
  int tempLanePowers[3];
  int bestLanePower;
  int leftBestLane;
  int rightBestLane;

  carSideLane = AIWorld_LaneIndex((int)(carObj->N).simRoadInfo.slice,
                     (carObj->preferredLateralPosition - (carObj->N).dimension.x) + -0x4000);
  if (carSideLane == carObj->laneIndex) {
    carLeftSideLaneWRTcurrent = 1;
  }
  else {
    carLeftSideLaneWRTcurrent = (carSideLane < carObj->laneIndex ^ 1) << 1;
  }
  tempLanePowers[0] = AI_Info.laneWeights[0];
  tempLanePowers[1] = AI_Info.laneWeights[1];
  tempLanePowers[2] = AI_Info.laneWeights[2];
  tempLanePowers[carLeftSideLaneWRTcurrent] = tempLanePowers[carLeftSideLaneWRTcurrent] +
                                               carObj->preferredLateralPositionPower;
  bestLanePower = tempLanePowers[0];
  leftBestLane = 0;
  if (tempLanePowers[0] < tempLanePowers[1]) {
    leftBestLane = 1;
    bestLanePower = tempLanePowers[1];
  }
  if (bestLanePower < tempLanePowers[2]) {
    leftBestLane = 2;
  }
  carSideLane = AIWorld_LaneIndex((int)(carObj->N).simRoadInfo.slice,
                     carObj->preferredLateralPosition + (carObj->N).dimension.x + 0x4000);
  if (carSideLane == carObj->laneIndex) {
    carRightSideLaneWRTcurrent = 1;
  }
  else {
    carRightSideLaneWRTcurrent = (carSideLane < carObj->laneIndex ^ 1) << 1;
  }
  tempLanePowers[0] = AI_Info.laneWeights[0];
  tempLanePowers[1] = AI_Info.laneWeights[1];
  tempLanePowers[2] = AI_Info.laneWeights[2];
  tempLanePowers[carRightSideLaneWRTcurrent] = tempLanePowers[carRightSideLaneWRTcurrent] +
                                                carObj->preferredLateralPositionPower;
  bestLanePower = tempLanePowers[0];
  rightBestLane = 0;
  if (tempLanePowers[0] < tempLanePowers[1]) {
    rightBestLane = 1;
    bestLanePower = tempLanePowers[1];
  }
  if (bestLanePower < tempLanePowers[2]) {
    rightBestLane = 2;
  }
  if ((leftBestLane == carLeftSideLaneWRTcurrent) && (rightBestLane == carRightSideLaneWRTcurrent)) {
    carObj->desiredLatPos = carObj->preferredLateralPosition;
    return 1;
  }
  return 0;
}

/* ---- AI_TryToShareLanes__FP8Car_tObjT0  [@0x8005a060] ---- */
int AI_TryToShareLanes(Car_tObj *carObj,Car_tObj *carInWay)
{
  int absLaneIndex;
  int leftRoadEdge;
  int rightRoadEdge;
  int gapLeft;
  int gapRight;
  int minGapSize;

  minGapSize =
      (carObj->N).dimension.x + (carObj->N).dimension.x / 2;
  absLaneIndex = AI_Info.desiredLane;
  /* SYM-CODEGEN-CARRIER: laneWidth -- PsyQ omits both block-local instances,
   * but their separate lexical lifetimes reproduce the retail allocation.
   * Reusing the later SYM-named gapLeft instead gives 64 diffs; this form is
   * authoritative PASS at 63/63 instructions. */
  if (7 <= absLaneIndex) {
    u_int laneWidth =
        (u_int)*(u_char *)((char *)AI_BWorldSmSlices +
                           (carInWay->N).simRoadInfo.slice * 0x20 + 0x1f);

    laneWidth = laneWidth * 0x8000;
    leftRoadEdge = (absLaneIndex + -7) * laneWidth;
    rightRoadEdge = leftRoadEdge + laneWidth;
  }
  else {
    u_int laneWidth =
        (u_int)*(u_char *)((char *)AI_BWorldSmSlices +
                           (carInWay->N).simRoadInfo.slice * 0x20 + 0x1e);

    laneWidth = laneWidth * 0x8000;
    rightRoadEdge = (absLaneIndex + -6) * laneWidth;
    leftRoadEdge = rightRoadEdge - laneWidth;
  }
  gapLeft =
      (carInWay->roadPosition - carInWay->roadSpan) - leftRoadEdge;
  gapRight =
      rightRoadEdge - (carInWay->roadPosition + carInWay->roadSpan);
  if ((minGapSize < gapRight) || (minGapSize < gapLeft)) {
    if (gapLeft < gapRight) {
      carObj->desiredLatPos =
          carInWay->roadPosition + carInWay->roadSpan + gapRight / 2;
    }
    else {
      carObj->desiredLatPos =
          carInWay->roadPosition - carInWay->roadSpan - gapLeft / 2;
    }
    return 1;
  }
  return 0;
}

/* ---- AI_CalculateDesiredLatPosition__FP8Car_tObj  [@0x8005a15c] ---- */
void AI_CalculateDesiredLatPosition(Car_tObj *carObj)
{
  Car_tObj *carInWay;
  int slice;
  /* SYM-CODEGEN-CARRIER: blockingCarNearby -- folding this materialized
     result into the MellowZone/TryToShareLanes short-circuit compiles to 139
     rather than 141 instructions and rotates saved registers across 60 diffs. */
  bool blockingCarNearby;

  slice = (int)(carObj->N).simRoadInfo.slice;
  carInWay = AI_Info.blockingCars[AI_Info.desiredLaneSide];
  if ((0 < carObj->preferredLateralPositionPower) &&
      (AI_CheckPreferredLateralPosition(carObj) == 1)) {
    return;
  }
  blockingCarNearby = false;
  if (carInWay != (Car_tObj *)0x0) {
    if (0 < AIWorld_ApxSplineDistance(carInWay,carObj)) {
      if (AIWorld_ApxSplineDistance(carInWay,carObj) <= 0x13ffff) {
        goto blockingCar;
      }
      goto noBlockingCar;
    }
    else {
      if (0x13ffff <
          -AIWorld_ApxSplineDistance(carInWay,carObj)) {
        goto noBlockingCar;
      }
    }
blockingCar:
    if (AI_IsMellowZone(carObj,0x3e80000) == 0) {
      blockingCarNearby = true;
    }
  }
noBlockingCar:
  if ((blockingCarNearby) &&
      (AI_TryToShareLanes(carObj,carInWay) == 1)) {
    return;
  }
  if ((AI_Info.desiredLane ==
       6 - (AI_SLICE_BYTE(slice,0x1d) >> 4)) ||
      (AI_Info.desiredLane ==
       (AI_SLICE_BYTE(slice,0x1d) & 0xf) + 7)) {
    if (AI_Info.desiredLane < 7) {
      /* SYM-CODEGEN-CARRIER: laneWidth -- direct width expressions compile
         to 140 rather than 141 instructions and produce 25 operand-birth and
         scheduling diffs, including reversed multiply registers. */
      int laneWidth;

      laneWidth = (u_int)AI_SLICE_BYTE(slice,0x1e) * 0x8000;
      carObj->desiredLatPos =
          (AI_Info.desiredLane + -6) * laneWidth - (carObj->N).dimension.x;
    }
    else {
      int laneWidth;

      laneWidth = (u_int)AI_SLICE_BYTE(slice,0x1f) * 0x8000;
      carObj->desiredLatPos =
          (AI_Info.desiredLane + -7) * laneWidth + (carObj->N).dimension.x;
    }
  }
  else {
    if (AI_Info.desiredLane < 7) {
      int laneWidth;

      laneWidth = (u_int)AI_SLICE_BYTE(slice,0x1e) * 0x8000;
      carObj->desiredLatPos =
          (AI_Info.desiredLane + -6) * laneWidth - ((u_int)laneWidth >> 1);
    }
    else {
      int laneWidth;

      laneWidth = (u_int)AI_SLICE_BYTE(slice,0x1f) * 0x8000;
      carObj->desiredLatPos =
          (AI_Info.desiredLane + -7) * laneWidth + ((u_int)laneWidth >> 1);
    }
  }
  if (AI_SLICE_SHORT(slice,0x1a) * 0x100 -
        (carObj->N).dimension.x < carObj->desiredLatPos) {
    carObj->desiredLatPos =
        AI_SLICE_SHORT(slice,0x1a) * 0x100 - (carObj->N).dimension.x;
  }
  if (carObj->desiredLatPos <
      (carObj->N).dimension.x + AI_SLICE_SHORT(slice,0x18) * -0x100) {
    carObj->desiredLatPos =
        (carObj->N).dimension.x + AI_SLICE_SHORT(slice,0x18) * -0x100;
  }
  return;
}

static inline int AI_AdjustedLaneMinSpeed(void)
{
  return 0x6aaaa;
}

/* ---- AI_CalculateAdjustedDesiredSpeed__FP8Car_tObj  [@0x8005a390] ---- */
void AI_CalculateAdjustedDesiredSpeed(Car_tObj *carObj)
{
  int Drel_hit;
  int Dlane;
  int Vrel_hit;
  int Vlane;
  int finalLaneSpeed;
  int a;
  int b;

  if (((AI_Info.desiredLane != carObj->laneIndex) && (AI_Info.blockingCars[1] != (Car_tObj *)0x0))
     && ((AI_Info.blockingCars[1]->N).deadTimer == 0)) {
    Drel_hit = AIWorld_SplineDistance(carObj,AI_Info.blockingCars[1]);
    if (0 < Drel_hit) {
      Drel_hit = AIWorld_SplineDistance(carObj,AI_Info.blockingCars[1]);
    }
    else {
      Drel_hit = -AIWorld_SplineDistance(carObj,AI_Info.blockingCars[1]);
    }
    Vrel_hit = carObj->currentSpeed - AI_Info.blockingCars[1]->currentSpeed;
    if (Vrel_hit < 1) {
      Vrel_hit = AI_Info.blockingCars[1]->currentSpeed - carObj->currentSpeed;
    }
    Dlane = carObj->desiredLatPos - carObj->roadPosition;
    if (Dlane < 1) {
      Dlane = carObj->roadPosition - carObj->desiredLatPos;
    }
    if (0 < AIWorld_CalcLateralVelocity(carObj)) {
      Vlane = AIWorld_CalcLateralVelocity(carObj);
    }
    else {
      Vlane = -AIWorld_CalcLateralVelocity(carObj);
    }
    a = fixedmult(Dlane,Vrel_hit);
    b = fixedmult(Drel_hit,Vlane);
    a = fixedmult(a,0x13333);
    if (a < b) {
      if (AI_Info.desiredLane > carObj->laneIndex) {
        finalLaneSpeed = AI_Info.laneSpeeds[2];
      }
      else {
        finalLaneSpeed = AI_Info.laneSpeeds[0];
      }
    }
    else {
      finalLaneSpeed = AI_Info.laneSpeeds[1];
    }
  }
  else {
    finalLaneSpeed = AI_Info.laneSpeeds[1];
  }
  if (carObj->direction == 1) {
    if (finalLaneSpeed < carObj->desiredSpeed) {
      carObj->desiredSpeed = finalLaneSpeed;
    }
    if (carObj->desiredSpeed < -0x14ccc) {
      carObj->desiredSpeed = -0x14ccc;
    }
  }
  else {
    if (carObj->desiredSpeed < finalLaneSpeed) {
      carObj->desiredSpeed = finalLaneSpeed;
    }
    if (0x14ccc < carObj->desiredSpeed) {
      carObj->desiredSpeed = 0x14ccc;
    }
  }
  if ((AI_Info.desiredLane != carObj->laneIndex) && (AI_Info.blockingCars[1] != (Car_tObj *)0x0)) {
    if (__builtin_abs(AI_Info.blockingCars[1]->currentSpeed) < 0xa0000) {
      /* SYM-CODEGEN-CARRIER: adjustedSpeed -- the retail debug block retains
         no result name. Direct per-arm member clamping shrinks 166 to 160
         instructions and leaves 22 diffs; a single conditional assignment is
         165/166 with 77 allocation/control-flow diffs. This scoped result
         preserves retail's shared final store and saved-register web. */
      int adjustedSpeed;

      if (carObj->direction == 1) {
        adjustedSpeed = carObj->desiredSpeed;
        if (adjustedSpeed < AI_AdjustedLaneMinSpeed()) {
          adjustedSpeed = 0x6aaaa;
        }
      }
      else {
        adjustedSpeed = carObj->desiredSpeed;
        if (-0x6aaaa < adjustedSpeed) {
          adjustedSpeed = -0x6aaaa;
        }
      }
      carObj->desiredSpeed = adjustedSpeed;
    }
  }
  return;
}

/* ---- AI_IsMellowZone__FP8Car_tObji  [@0x8005a628] ---- */
int AI_IsMellowZone(Car_tObj *carObj,int delay)
{
  int index;
  int odom;
  int endMellow;

  index = carObj->sortIndex;
  odom = AIWorld_GameOdometer(carObj);
  if ((carObj->carFlags & 8U) == 0) {
    goto RET0;
  }
  if (carObj->laneIndex ==
      6 - (u_int)(*(u_char *)((char *)AI_BWorldSmSlices +
                              (carObj->N).simRoadInfo.slice * 0x20 + 0x1d) >> 4)) {
    goto RET0;
  }
  if (carObj->laneIndex ==
      (*(u_char *)((char *)AI_BWorldSmSlices +
                   (carObj->N).simRoadInfo.slice * 0x20 + 0x1d) & 0xf) + 7) {
RET0:
    return 0;
  }
  endMellow = 0x6400000;
  if (Cars_gNumAIRaceCars < 5) {
    endMellow = 0x3200000;
  }
  if (Cars_gNumAIRaceCars < 2) {
    endMellow = 0xc80000;
  }
  if (Cars_gNumAIRaceCars == 0) {
    endMellow = 0;
  }
  return odom + index * 0x540000 <= endMellow + delay;
}

/* ---- AI_KeepCarsInLane__FP8Car_tObj  [@0x8005a714] ---- */
void AI_KeepCarsInLane(Car_tObj *carObj)
{
  /* SYM-CODEGEN-CARRIER: local -- retail has an otherwise empty 16-byte
     frame (`addiu sp,-16` / `addiu sp,16`) although the SYM records no named
     local.  Removing this unused four-int array is FAIL 2 at 2/4 instructions;
     retaining it is PASS at 4/4.  The evidence cannot recover its source name. */
  int local[4];
  (void)local;
  return;
}

/* ---- AI_PushFinishedCarsToSide__FP8Car_tObj  [@0x8005a724] ---- */
void AI_PushFinishedCarsToSide(Car_tObj *carObj)
{
  int absDistancePastFinish;
  int totalSortIndex;
  
  if (((carObj->carFlags & 1U) != 0) && ((carObj->stats).finishType == 2)) {
    if ((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) {
      if (((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) == 0) {
        if (Cars_gNumHumanRaceCars == 2) {
          /* BUGFIX: second check reads human player [1] (oracle 0x8010E924), was [0] */
          if (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) == 0) goto PUSH;
        }
        else goto PUSH;
      }
    }
    else {
PUSH:
    absDistancePastFinish =
        __builtin_abs(AIWorld_ApxSplineDistance(carObj,0));
    totalSortIndex = 0;
    while (totalSortIndex < Cars_gNumCars) {
      if (Cars_gTotalSortedList[totalSortIndex] == carObj) {
        break;
      }
      totalSortIndex = totalSortIndex + 1;
    }
    if (totalSortIndex * 0x280000 <= absDistancePastFinish) {
      if ((carObj->laneIndex ==
           6 - (u_int)(AI_SLICE_BYTE((carObj->N).simRoadInfo.slice,0x1d) >> 4)) ||
          (carObj->laneIndex ==
           (AI_SLICE_BYTE((carObj->N).simRoadInfo.slice,0x1d) & 0xf) + 7)) {
        CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + 0x960000;
      }
      else if (carObj->laneIndex < 7) {
        CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + 0x960000;
      }
      else {
        CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + 0x960000;
      }
    }
    }
  }
  return;
}

/* ---- AI_MaybeChangeLaneSlack__FP8Car_tObj  [@0x8005a8c0] ---- */
void AI_MaybeChangeLaneSlack(Car_tObj *carObj)
{
  int adaptedSlice;
  int range;

  if (0 <= carObj->carIndex * 2) {
    adaptedSlice = (carObj->N).simRoadInfo.slice + carObj->carIndex * 2;
    if (gNumSlices <= adaptedSlice) {
      adaptedSlice = adaptedSlice - gNumSlices;
    }
  }
  else {
    adaptedSlice = (carObj->N).simRoadInfo.slice + carObj->carIndex * 2;
    if (adaptedSlice < 0) {
      adaptedSlice = adaptedSlice + gNumSlices;
    }
  }
  if ((((carObj->carFlags & 4) == 0) &&
      (((carObj->carFlags & 8) == 0 || ((adaptedSlice >> 4) << 4 == adaptedSlice)))) &&
     (((carObj->carFlags & 0x10) == 0 || ((adaptedSlice >> 1) << 1 == adaptedSlice)))) {
    range = *(int *)((char *)carObj->personality + 0x1c);
    randtemp = fastRandom * randSeed;
    fastRandom = randtemp & 0xffff;
    if (range * (randtemp >> 8 & 0xffff) >> 0x10 == 1) {
      AI_ChooseNewLaneSlack(carObj);
    }
  }
  return;
}

/* ---- AI_ChooseNewLaneSlack__FP8Car_tObj  [@0x8005a9dc] ---- */
void AI_ChooseNewLaneSlack(Car_tObj *carObj)
{
  carObj->laneSlack = *(int *)((char *)carObj->personality +
      ((fastRandom * randSeed) >> 6 & 0xc) + 0xc);
  randtemp = fastRandom * randSeed;
  fastRandom = randtemp & 0xffff;
  return;
}
