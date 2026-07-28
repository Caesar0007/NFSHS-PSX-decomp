/* game/common/ai.cpp -- RECONSTRUCTED (NFS4 main AI driver; 40 free AI_* fns).
 *   Per-car AI cycle: car/world avoidance, lane merits/speeds, reactions & behavior,
 *   barrier/obstacle handling, lane choice + lateral position + lane-slack. SYM-v3 locals;
 *   vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "ai_externs.h"


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
void AI_AddCollidableObjects(Car_tObj *carObj,Group *groupSimObjs);
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
  int iVar1;
  
  iVar1 = 0;
  do {
    iVar1 = iVar1 + 1;
    CarLogic_gObs[0][2] = 0;
    CarLogic_gObs[0][1] = 0;
    CarLogic_gObs[0][0] = 0;
  } while (iVar1 < 1);
  return;
}

/* ---- AI_DoReactions__FP8Car_tObj  [@0x80057b94] ---- */
void AI_DoReactions(Car_tObj *carObj)
{
  int target;
  int absDistance;
  int seconds;
  int metersDistance;
  int iVar1;
  int uVar2;
  Car_tObj *otherCarObj;
  
  iVar1 = AIScript_DoReAction(&carObj->script,8);
  if (iVar1 == -1) goto LAB_horncheck;
  if (GameSetup_gData.raceType == 1) goto LAB_horncheck;
  AudioClc_SetHorn(carObj,1);
  goto LAB_afterhorn;
LAB_horncheck:
  if ((carObj->control).horn != '\0') {
    AudioClc_SetHorn(carObj,0);
  }
LAB_afterhorn:
  iVar1 = AIScript_DoReAction(&carObj->script,0x1000);
  if (iVar1 == -1) goto LAB_80057cc0;
  if (GameSetup_gData.raceType == 1) goto LAB_80057cc0;
  {
    uVar2 = (int)(simGlobal.gameTicks & 0x18U) >> 3;
    switch (uVar2) {
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
  iVar1 = AIScript_DoReAction(&carObj->script,0x20);
  if (iVar1 != -1) {
    otherCarObj = Cars_gList[iVar1];
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
  Car_tObj *otherCarObjLocal;
  Car_tObj *carObjLocal;
  int absDistance;

  carObjLocal = carObj;
  otherCarObjLocal = otherCarObj;
  absDistance =
      __builtin_abs(AIWorld_ApxSplineDistance(carObjLocal,otherCarObjLocal));
  if (AIWorld_GameOdometer(carObjLocal) < 0x3200000) {
    return;
  }
  if (((simGlobal.gameTicks - (otherCarObjLocal->N).collision.lastTime < 0xf) &&
       ((otherCarObjLocal->N).collision.lastOtherObj != (BO_tNewtonObj *)0x0)) &&
      ((Car_tObj *)(otherCarObjLocal->N).collision.lastOtherObj == carObjLocal)) {
    AIScript_SubmitPlayerAction(&carObjLocal->script,
                                otherCarObjLocal->carIndex,0,
                                simGlobal.gameTicks);
  }
  int direction = carObjLocal->direction;
  if (otherCarObjLocal->currentSpeed * direction + 0x280000 <
      carObjLocal->currentSpeed * carObjLocal->direction) {
    if (0xbffff < absDistance) goto LAB_80057f34;
    AIScript_SubmitPlayerAction(&carObjLocal->script,
                                otherCarObjLocal->carIndex,1,
                                simGlobal.gameTicks);
  }
  if ((absDistance < 0xc0000) &&
      (otherCarObjLocal->laneIndex == carObjLocal->laneIndex)) {
    int otherOdometer = AIWorld_GameOdometer(otherCarObjLocal);
    if (AIWorld_GameOdometer(carObjLocal) < otherOdometer) {
      AIScript_SubmitPlayerAction(&carObjLocal->script,
                                  otherCarObjLocal->carIndex,2,
                                  simGlobal.gameTicks);
    }
    else {
      AIScript_SubmitPlayerAction(&carObjLocal->script,
                                  otherCarObjLocal->carIndex,3,
                                  simGlobal.gameTicks);
    }
  }
LAB_80057f34:
  if ((otherCarObjLocal->swapCar == carObjLocal) &&
      (simGlobal.gameTicks - carObjLocal->swapTime < 0xf)) {
    int carOdometer = AIWorld_GameOdometer(carObjLocal);
    if (AIWorld_GameOdometer(otherCarObjLocal) < carOdometer) {
      AIScript_SubmitPlayerAction(&carObjLocal->script,
                                  otherCarObjLocal->carIndex,4,
                                  simGlobal.gameTicks);
    }
    else {
      AIScript_SubmitPlayerAction(&carObjLocal->script,
                                  otherCarObjLocal->carIndex,5,
                                  simGlobal.gameTicks);
    }
  }
  if (((absDistance < 0x1e0000) &&
       ((otherCarObjLocal->control).horn != '\0')) &&
      (GameSetup_gData.Time == 0))
  {
    AIScript_SubmitPlayerAction(&carObjLocal->script,
                                otherCarObjLocal->carIndex,6,
                                simGlobal.gameTicks);
  }
  return;
}

/* ---- AI_DoReactionsAndBehavior__FP8Car_tObj  [@0x80058014] ---- */
void AI_DoReactionsAndBehavior(Car_tObj *carObj)
{
  Car_tObj *otherCarObj;
  int iVar2;
  Car_tObj **ppCVar1;

  AI_DoReactions(carObj);
  iVar2 = 0;
  ppCVar1 = Cars_gList;
  while (1) {
    if (Cars_gNumCars <= iVar2) {
      break;
    }
    otherCarObj = *ppCVar1;
    if (((carObj != otherCarObj) && ((otherCarObj->N).active != '\0')) &&
        ((otherCarObj->carFlags & 4U) != 0)) {
      AI_CheckForPlayerActions(carObj,otherCarObj);
      if ((carObj->carFlags & 8U) != 0) {
        AI_OpponentBlockPlayer(carObj,otherCarObj);
      }
    }
    ppCVar1 = ppCVar1 + 1;
    iVar2 = iVar2 + 1;
  }
  return;
}

/* ---- AI_OpponentBlockPlayer__FP8Car_tObjT0  [@0x800580d8] ---- */
void AI_OpponentBlockPlayer(Car_tObj *carObj,Car_tObj *otherCarObj)
{
  int otherCarObjSlice;
  int distance;
  u_char bVar1;
  int iVar3;

  iVar3 = AI_IsMellowZone(carObj,0x1900000);
  if (iVar3 != 0) {
    return;
  }
  if (!(AI_Info.deltaYaw < curveynessLevelStarts[2])) {
    return;
  }
  otherCarObjSlice = (otherCarObj->N).simRoadInfo.slice;
  distance =
      AIWorld_SplineDistance(carObj,otherCarObj) * carObj->direction;
  iVar3 = AIScript_DoReAction(&carObj->script,0x400);
  if ((iVar3 != -1) && (0 <= distance) && (distance <= 0x31ffff)) {
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
  {
    int *personality = (int *)carObj->personality;
    if (personality[0] <= distance) {
      return;
    }
    if (distance < personality[1]) {
      return;
    }
  }
  bVar1 = *(u_char *)(otherCarObjSlice * 0x20 + (int)BWorldSm_slices + 0x1d);
  if (otherCarObj->laneIndex < (int)(7 - (u_int)(bVar1 >> 4))) {
    return;
  }
  if ((int)((bVar1 & 0xf) + 6) < otherCarObj->laneIndex) {
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
  dir = carObj->direction;
  speed = carObj->currentSpeed / 0x10000;
  if (speed < 0) {
    speed = -speed;
    slice = (int)(carObj->N).simRoadInfo.slice;
  }
  else {
    slice = (int)(carObj->N).simRoadInfo.slice;
  }
  slicesAhead = speed = (speed << 0x12) / 0x60000;
  speed = slicesAhead * dir;
  forwardSlice0 = slice + speed;
  if (0 <= speed) {
    if (gNumSlices <= forwardSlice0) {
      forwardSlice0 = forwardSlice0 - gNumSlices;
    }
  }
  else {
    if (forwardSlice0 < 0) {
      forwardSlice0 = forwardSlice0 + gNumSlices;
    }
  }
  speed = (slicesAhead + 1) * dir;
  forwardSlice1 = slice + speed;
  if (0 <= speed) {
    if (gNumSlices <= forwardSlice1) {
      forwardSlice1 = forwardSlice1 - gNumSlices;
    }
  }
  else {
    if (forwardSlice1 < 0) {
      forwardSlice1 = forwardSlice1 + gNumSlices;
    }
  }
  profileHere = *(short *)(slice * 0x20 + (int)BWorldSm_slices + 0x16);
  if (AIWorld_IsDriveableLane_UsingMask(slice,masks[0]) == 0) {
    CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + -0xa0000;
  }
  if (AIWorld_IsDriveableLane_UsingMask(slice,masks[1]) == 0) {
    CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + -0xa0000;
  }
  if (AIWorld_IsDriveableLane_UsingMask(slice,masks[2]) == 0) {
    CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + -0xa0000;
  }
  if ((profileHere != *(short *)(forwardSlice0 * 0x20 + (int)BWorldSm_slices + 0x16)) ||
     (profileHere != *(short *)(forwardSlice1 * 0x20 + (int)BWorldSm_slices + 0x16))) {
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

      speed = sliceLoop * dir;
      checkSlice = slice + speed;
      if (0 <= speed) {
        if (gNumSlices <= checkSlice) {
          checkSlice = checkSlice - gNumSlices;
        }
      }
      else if (checkSlice < 0) {
        checkSlice = checkSlice + gNumSlices;
      }
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
  int iVar1;
  
  iVar1 = AI_IsMellowZone(carObj,0x3c0000);
  if (iVar1 == 0) {
    iVar1 = -0x40000;
    if ((carObj->carFlags & 0x10U) != 0) {
      iVar1 = -0xc0000;
    }
    if ((((Cars_gNumTrafficCars != 0) || (Cars_gNumCopCars != 0)) && (AITune_oneWay == 0)) &&
       ((carObj->AIFlags & 2U) == 0)) {
      if (carObj->direction == AITune_driveSide) {
        if (carObj->laneIndex + -1 < 7) {
          CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + iVar1;
        }
        if (carObj->laneIndex < 7) {
          CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + iVar1;
        }
      }
      else {
        if (6 < carObj->laneIndex) {
          CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + iVar1;
        }
        if (6 < carObj->laneIndex + 1) {
          CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + iVar1;
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
  int laneIndex;
  int adjLaneIndex;
  u_char bVar1;

  absLaneLookAhead = carObj->currentSpeed;
  if (absLaneLookAhead < 0) {
    absLaneLookAhead = -absLaneLookAhead;
  }
  laneIndex = fixedmult(absLaneLookAhead,0x6aaa);
  adjLaneIndex = laneIndex;
  if (laneIndex < 0) {
    adjLaneIndex = laneIndex + 0xffff;
  }
  laneIndex = adjLaneIndex >> 0x10;
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
  bVar1 = BWorldSm_slices[lookAheadSlice].laneCount;
  laneIndex = carObj->laneIndex;
  if ((laneIndex < (int)(7 - (u_int)(bVar1 >> 4))) || ((int)((bVar1 & 0xf) + 6) < laneIndex)) {
    bVar1 = *(u_char *)((carObj->N).simRoadInfo.slice * 0x20 + (char *)BWorldSm_slices + 0x1d);
    if (laneIndex < (int)(7 - (u_int)(bVar1 >> 4))) {
      return;
    }
    if ((int)((bVar1 & 0xf) + 6) < laneIndex) {
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
  int lane;
  u_char bVar1;

  slice = (int)(carObj->N).simRoadInfo.slice;
  shoulder_merit = -0x4e666;
  if (((((carObj->carFlags & 0x10U) != 0) &&
       (shoulder_merit = -0x260000, AI_Info.blockingCars[1] != (Car_tObj *)0x0)) &&
      ((AI_Info.blockingCars[1]->carFlags & 1U) != 0)) && (0x8e38e < AI_Info.blockingCars[1]->speed)
     ) {
    shoulder_merit = 0x50000;
  }
  lane = carObj->laneIndex + -1;
  bVar1 = BWorldSm_slices[slice].laneCount;
  if ((lane == 6 - (u_int)(bVar1 >> 4)) || (lane == (bVar1 & 0xf) + 7)) {
    int merit0 = CarLogic_gObs[0][0] + shoulder_merit;
    CarLogic_gObs[0][0] = merit0;
    Trk_NewSlice *sl = (Trk_NewSlice *)((carObj->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices);
    if ((sl->leftDrive << 8) - (sl->avgPavedWidthLf << 0xf) * (sl->laneCount >> 4) <
        (carObj->N).dimension.x) {
      CarLogic_gObs[0][0] = merit0 + -0x640000;
    }
  }
  lane = carObj->laneIndex + 1;
  bVar1 = BWorldSm_slices[slice].laneCount;
  if ((lane == 6 - (u_int)(bVar1 >> 4)) || (lane == (bVar1 & 0xf) + 7)) {
    int merit2 = CarLogic_gObs[0][2] + shoulder_merit;
    CarLogic_gObs[0][2] = merit2;
    Trk_NewSlice *sl = (Trk_NewSlice *)((carObj->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices);
    if ((sl->rightDrive << 8) - (sl->avgPavedWidthRt << 0xf) * (sl->laneCount & 0xf) <
        (carObj->N).dimension.x) {
      CarLogic_gObs[0][2] = merit2 + -0x640000;
    }
  }
  if ((carObj->laneIndex == 6 - (u_int)(BWorldSm_slices[slice].laneCount >> 4)) ||
      (carObj->laneIndex == (BWorldSm_slices[slice].laneCount & 0xf) + 7)) {
    CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + shoulder_merit;
    isRight = (carObj->laneIndex < 7) ^ 1;
    if (carObj->laneIndex < 7) {
      Trk_NewSlice *sl = (Trk_NewSlice *)((carObj->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices);
      if ((sl->leftDrive << 8) - (sl->avgPavedWidthLf << 0xf) * (sl->laneCount >> 4) <
          (carObj->N).dimension.x) {
        goto CENTER_DEMERIT;
      }
    }
    if (isRight != 0) {
      Trk_NewSlice *sl;
      sl = (Trk_NewSlice *)((carObj->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices);
      if ((sl->rightDrive << 8) - (sl->avgPavedWidthRt << 0xf) * (sl->laneCount & 0xf) <
          (carObj->N).dimension.x) {
CENTER_DEMERIT:
        CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + -0x640000;
      }
    }
  }
  lane = carObj->laneIndex + -1;
  bVar1 = BWorldSm_slices[slice].laneCount;
  if ((lane < (int)(6 - (u_int)(bVar1 >> 4))) || ((int)((bVar1 & 0xf) + 7) < lane)) {
    CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + -0x3e80000;
  }
  if ((carObj->laneIndex < (int)(6 - (u_int)(BWorldSm_slices[slice].laneCount >> 4))) ||
      ((int)((BWorldSm_slices[slice].laneCount & 0xf) + 7) < carObj->laneIndex)) {
    CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + -0x3e80000;
  }
  lane = carObj->laneIndex + 1;
  bVar1 = BWorldSm_slices[slice].laneCount;
  if ((lane < (int)(6 - (u_int)(bVar1 >> 4))) || ((int)((bVar1 & 0xf) + 7) < lane)) {
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
  u_int carObjLaneShift;
  u_int carObjLeftLaneBits;
  u_int carObjThisLaneBits;
  u_int carObjRightLaneBits;
  int maxDistanceToCheck;
  int collisionSpeed;
  int aheadCollisionSpeed;
  int iVar2;

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
  carObjLaneShift = carObj->laneIndex;
  carObjIndexInSortedList = carObj->sortIndex;
  carObjLeftLaneBits = 1 << (carObjLaneShift - 1);
  carObjThisLaneBits = 1 << (carObjLaneShift);
  carObjRightLaneBits = 1 << (carObjLaneShift + 1);
  do {
    if ((carsFound == 3) || (Cars_gNumCars <= ci)) {
      return;
    }
    iVar2 = carObjIndexInSortedList + ci * carObj->direction + Cars_gNumCars;
    otherCarObj = Cars_gSortedList[iVar2 % Cars_gNumCars];
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
          int forwardDistanceIntMeters;

          forwardDistanceIntMeters = (distanceFixedMeters < 0)
              ? distanceFixedMeters + 0xffff
              : distanceFixedMeters;
          distanceIntMeters =
              (forwardDistanceIntMeters >> 0x10) + -2;
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
  int iVar1;

  dSpeed = carObj->desiredSpeed;
  cSpeed = carObj->currentSpeed;
  iVar1 = AIWorld_GameOdometer(carObj);
  considerDesired = 0x257ffff < iVar1;
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
      laneSpeed = laneInfo->laneSpeeds[lane];
      if (cSpeed <= laneSpeed) {
        if (laneInfo->blockingCars[lane] == (Car_tObj *)0x0) {
          goto noLaneSpeedMerit;
        }
        *observation =
            *observation + fixedmult(laneSpeed - cSpeed,-0x14ccc);
        laneSpeed = laneInfo->laneSpeeds[lane];
      }
      if ((dSpeed <= laneSpeed) &&
          (laneInfo->blockingCars[lane] != (Car_tObj *)0x0)) {
        *observation =
            *observation + fixedmult(laneSpeed - dSpeed,-0x8000);
      }
noLaneSpeedMerit:
      laneSpeed = laneInfo->laneSpeedsAhead[lane];
      if (cSpeed <= laneSpeed) {
        if (laneInfo->blockingCars[lane] == (Car_tObj *)0x0) {
          goto noLaneSpeedAheadMerit;
        }
        *observation =
            *observation + fixedmult(laneSpeed - cSpeed,-0x8000);
        laneSpeed = laneInfo->laneSpeedsAhead[lane];
      }
      if ((dSpeed <= laneSpeed) &&
          (laneInfo->blockingCars[lane] != (Car_tObj *)0x0)) {
        *observation =
            *observation + fixedmult(laneSpeed - dSpeed,-0x1999);
      }
noLaneSpeedAheadMerit:
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
  int iVar2;
  int runningIndex;

  carObjIndexInSortedList = carObj->sortIndex;
  lanesFilled = 0;
  if (((carObj->carFlags & 8U) != 0) &&
     (AI_IsMellowZone(carObj,lanesFilled) == 0)) {
    clearAheadMerits[2] = 0x40000;
    clearAheadMerits[1] = 0x40000;
    clearAheadMerits[0] = 0x40000;
    ci = carObj->direction;
    carsFound = lanesFilled;
    runningIndex = ci * ci + carObjIndexInSortedList;
    dir = ci;
    while ((carsFound != 3) && (ci < Cars_gNumCars)) {
      otherCarObj = Cars_gSortedList[(runningIndex + Cars_gNumCars) % Cars_gNumCars];
      if (carObj == otherCarObj) goto NEXT_CAR;
      if ((otherCarObj->N).active == '\0') goto NEXT_CAR;
      iVar2 = AIWorld_SplineDistance(otherCarObj,carObj);
      if (iVar2 + 0x40000U >= 0x6e0000) goto NEXT_CAR;
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
      runningIndex = runningIndex + dir;
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
  int iVar1;

  slice = carObj->lookAheadSlice;
  if ((carObj->carFlags & 8U) != 0) {
    iVar1 = fixedmult(*(int *)((char *)carObj->personality + 0x44),
                       (int)(signed char)AIDataRecord_BestLine->dataBuffer_
                            [slice] << 0xe);
    carObj->preferredLateralPosition = iVar1;
    carObj->preferredLateralPositionPower = 0x50000;
    carObj->preferredLateralPosition = iVar1 - carObj->laneSlack * carObj->direction;
  }
  return;
}

/* ---- AI_AddCollidableObjects__FP8Car_tObjP5Group  [@0x8005972c] ---- */
void AI_AddCollidableObjects(Car_tObj *carObj,Group *groupSimObjs)
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
          BWorldSm_slices[(carObj->N).simRoadInfo.slice].center;
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
  int iVar1;
  int spikeSlice;
  int leftLatPos;
  int width;

  iVar1 = BWorld_GetSpikeBelt(&spikeSlice,&leftLatPos,&width);
  if (iVar1 == 0) {
    return;
  }
  iVar1 = AIWorld_ApxSplineDistance(spikeSlice,carObj);
  if (0x63ffff <= iVar1 * carObj->direction - 1U) {
    return;
  }
  AI_SubmitObstacle(carObj,-0x280000,leftLatPos,leftLatPos + width,spikeSlice);
  return;
}

/* ---- AI_SubmitObstacle__FP8Car_tObjiiii  [@0x800599e4] ---- */
void AI_SubmitObstacle(Car_tObj *carObj,int importance,int leftLatPosition,int rightLatPosition,int slice)
{
  u_int leftEdgeIndex;
  u_int rightEdgeIndex;
  int observations[3];
  int leftDistance;
  int rightDistance;
  int edgeIndex;

  memset((u_char *)observations,'\0',0xc);
  leftEdgeIndex = AIWorld_LaneIndex(slice,leftLatPosition);
  rightEdgeIndex = AIWorld_LaneIndex(slice,rightLatPosition);
  if ((rightEdgeIndex < 0xe) && (leftEdgeIndex < 0xe)) {
    edgeIndex = carObj->laneIndex + -1;
    if (((int)leftEdgeIndex <= edgeIndex) && (edgeIndex <= (int)rightEdgeIndex)) {
      observations[0] = importance;
    }
    if (((int)leftEdgeIndex <= carObj->laneIndex) && (carObj->laneIndex <= (int)rightEdgeIndex)) {
      observations[1] = importance;
    }
    edgeIndex = carObj->laneIndex + 1;
    if (((int)leftEdgeIndex <= edgeIndex) && (edgeIndex <= (int)rightEdgeIndex)) {
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
  int iVar2;

  visibleCar = AILife_IsCarInAnyVisibleArea(carObj);
  if ((carObj->carFlags & 0x10U) != 0) {
    /* @0x80059BC8: stored bool (sltu zero,iVar2) of the ternary -- honk unless value == 0
     * (value = ~direction when D_8011321C, else direction^1). */
    int dir = carObj->direction;
    int honk = ((D_8011321C == 0) ? (dir ^ 1) : ~dir) != 0;
    if ((honk && (visibleCar != (Car_tObj *)0x0)) && (-0x30000 < AI_Info.laneSpeeds[1])) {
      randtemp = fastRandom * randSeed;
      fastRandom = randtemp & 0xffff;
      iVar2 = (int)((randtemp >> 8 & 0xffff) * 1000 >> 0x10);
      if (((GameSetup_gData.commMode != 1) && (iVar2 < 5)) &&
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
  int result;

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
  if (7 <= absLaneIndex) {
    u_int laneWidth =
        (u_int)*(u_char *)((char *)BWorldSm_slices +
                           (carInWay->N).simRoadInfo.slice * 0x20 + 0x1f);

    laneWidth = laneWidth * 0x8000;
    leftRoadEdge = (absLaneIndex + -7) * laneWidth;
    rightRoadEdge = leftRoadEdge + laneWidth;
  }
  else {
    u_int laneWidth =
        (u_int)*(u_char *)((char *)BWorldSm_slices +
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
  Car_tObj *carObjLocal;
  Car_tObj *carInWay;
  int slice;
  bool bVar1;
  int iVar2;
  u_int laneInfo;
  int desiredLane;
  int iVar4;
  int minLatPosition;

  carObjLocal = carObj;
  slice = (int)(carObjLocal->N).simRoadInfo.slice;
  carInWay = AI_Info.blockingCars[AI_Info.desiredLaneSide];
  if ((0 < carObjLocal->preferredLateralPositionPower) &&
      (AI_CheckPreferredLateralPosition(carObjLocal) == 1)) {
    return;
  }
  bVar1 = false;
  if (carInWay != (Car_tObj *)0x0) {
    iVar2 = AIWorld_ApxSplineDistance(carInWay,carObjLocal);
    if (0 < iVar2) {
      iVar2 = AIWorld_ApxSplineDistance(carInWay,carObjLocal);
      if (iVar2 <= 0x13ffff) {
        goto blockingCar;
      }
      goto noBlockingCar;
    }
    else {
      if (0x13ffff <
          -AIWorld_ApxSplineDistance(carInWay,carObjLocal)) {
        goto noBlockingCar;
      }
    }
blockingCar:
    if (AI_IsMellowZone(carObjLocal,0x3e80000) == 0) {
      bVar1 = true;
    }
  }
noBlockingCar:
  if ((bVar1) && (AI_TryToShareLanes(carObjLocal,carInWay) == 1)) {
    return;
  }
  iVar2 = slice * 0x20 + (int)BWorldSm_slices;
  laneInfo = *(u_char *)(iVar2 + 0x1d);
  desiredLane = AI_Info.desiredLane;
  if ((desiredLane == 6 - (laneInfo >> 4)) ||
      (desiredLane == (laneInfo & 0xf) + 7)) {
    if (desiredLane < 7) {
      int laneWidth;

      laneWidth = (u_int)*(u_char *)(iVar2 + 0x1e) * 0x8000;
      carObjLocal->desiredLatPos =
          (desiredLane + -6) * laneWidth - (carObjLocal->N).dimension.x;
    }
    else {
      int laneWidth;

      laneWidth = (u_int)*(u_char *)(iVar2 + 0x1f) * 0x8000;
      carObjLocal->desiredLatPos =
          (desiredLane + -7) * laneWidth + (carObjLocal->N).dimension.x;
    }
  }
  else {
    if (desiredLane < 7) {
      int laneWidth;

      laneWidth = (u_int)*(u_char *)(iVar2 + 0x1e) * 0x8000;
      carObjLocal->desiredLatPos =
          (desiredLane + -6) * laneWidth - ((u_int)laneWidth >> 1);
    }
    else {
      int laneWidth;

      laneWidth = (u_int)*(u_char *)(iVar2 + 0x1f) * 0x8000;
      carObjLocal->desiredLatPos =
          (desiredLane + -7) * laneWidth + ((u_int)laneWidth >> 1);
    }
  }
  iVar2 = slice * 0x20;
  iVar4 = *(short *)(iVar2 + (int)BWorldSm_slices + 0x1a) * 0x100 -
          (carObjLocal->N).dimension.x;
  if (iVar4 < carObjLocal->desiredLatPos) {
    carObjLocal->desiredLatPos = iVar4;
  }
  minLatPosition = (carObjLocal->N).dimension.x +
                   *(short *)(iVar2 + (int)BWorldSm_slices + 0x18) * -0x100;
  if (carObjLocal->desiredLatPos < minLatPosition) {
    carObjLocal->desiredLatPos = minLatPosition;
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
  Car_tObj *carObjLocal;
  int Drel_hit;
  int Dlane;
  int Vrel_hit;
  int Vlane;
  int finalLaneSpeed;
  int a;
  int b;

  carObjLocal = carObj;
  if (((AI_Info.desiredLane != carObjLocal->laneIndex) && (AI_Info.blockingCars[1] != (Car_tObj *)0x0))
     && ((AI_Info.blockingCars[1]->N).deadTimer == 0)) {
    Drel_hit = AIWorld_SplineDistance(carObjLocal,AI_Info.blockingCars[1]);
    if (0 < Drel_hit) {
      Drel_hit = AIWorld_SplineDistance(carObjLocal,AI_Info.blockingCars[1]);
    }
    else {
      Drel_hit = -AIWorld_SplineDistance(carObjLocal,AI_Info.blockingCars[1]);
    }
    Vrel_hit = carObjLocal->currentSpeed - AI_Info.blockingCars[1]->currentSpeed;
    if (Vrel_hit < 1) {
      Vrel_hit = AI_Info.blockingCars[1]->currentSpeed - carObjLocal->currentSpeed;
    }
    Dlane = carObjLocal->desiredLatPos - carObjLocal->roadPosition;
    if (Dlane < 1) {
      Dlane = carObjLocal->roadPosition - carObjLocal->desiredLatPos;
    }
    if (0 < AIWorld_CalcLateralVelocity(carObjLocal)) {
      Vlane = AIWorld_CalcLateralVelocity(carObjLocal);
    }
    else {
      Vlane = -AIWorld_CalcLateralVelocity(carObjLocal);
    }
    a = fixedmult(Dlane,Vrel_hit);
    b = fixedmult(Drel_hit,Vlane);
    a = fixedmult(a,0x13333);
    if (a < b) {
      if (AI_Info.desiredLane > carObjLocal->laneIndex) {
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
  if (carObjLocal->direction == 1) {
    if (finalLaneSpeed < carObjLocal->desiredSpeed) {
      carObjLocal->desiredSpeed = finalLaneSpeed;
    }
    if (carObjLocal->desiredSpeed < -0x14ccc) {
      carObjLocal->desiredSpeed = -0x14ccc;
    }
  }
  else {
    if (carObjLocal->desiredSpeed < finalLaneSpeed) {
      carObjLocal->desiredSpeed = finalLaneSpeed;
    }
    if (0x14ccc < carObjLocal->desiredSpeed) {
      carObjLocal->desiredSpeed = 0x14ccc;
    }
  }
  if ((AI_Info.desiredLane != carObjLocal->laneIndex) && (AI_Info.blockingCars[1] != (Car_tObj *)0x0)) {
    if (__builtin_abs(AI_Info.blockingCars[1]->currentSpeed) < 0xa0000) {
      int adjustedSpeed;

      if (carObjLocal->direction == 1) {
        adjustedSpeed = carObjLocal->desiredSpeed;
        if (adjustedSpeed < AI_AdjustedLaneMinSpeed()) {
          adjustedSpeed = 0x6aaaa;
        }
      }
      else {
        adjustedSpeed = carObjLocal->desiredSpeed;
        if (-0x6aaaa < adjustedSpeed) {
          adjustedSpeed = -0x6aaaa;
        }
      }
      carObjLocal->desiredSpeed = adjustedSpeed;
    }
  }
  return;
}

/* ---- AI_IsMellowZone__FP8Car_tObji  [@0x8005a628] ---- */
int AI_IsMellowZone(Car_tObj *carObj,int delay)
{
  int index;
  int odom;
  int numCars;
  int endMellow;
  u_char bVar1;

  index = carObj->sortIndex;
  odom = AIWorld_GameOdometer(carObj);
  if ((carObj->carFlags & 8U) == 0) {
    goto RET0;
  }
  bVar1 = *(u_char *)((char *)BWorldSm_slices + (carObj->N).simRoadInfo.slice * 0x20 + 0x1d);
  if (carObj->laneIndex == 6 - (u_int)(bVar1 >> 4)) {
    goto RET0;
  }
  if (carObj->laneIndex == (bVar1 & 0xf) + 7) {
RET0:
    return 0;
  }
  numCars = Cars_gNumAIRaceCars;
  endMellow = 0x6400000;
  if (numCars < 5) {
    endMellow = 0x3200000;
  }
  if (numCars < 2) {
    endMellow = 0xc80000;
  }
  if (numCars == 0) {
    endMellow = 0;
  }
  return odom + index * 0x540000 <= endMellow + delay;
}

/* ---- AI_KeepCarsInLane__FP8Car_tObj  [@0x8005a714] ---- */
void AI_KeepCarsInLane(Car_tObj *carObj)
{
  int local[4];
  (void)local;
  return;
}

/* ---- AI_PushFinishedCarsToSide__FP8Car_tObj  [@0x8005a724] ---- */
void AI_PushFinishedCarsToSide(Car_tObj *carObj)
{
  int absDistancePastFinish;
  int totalSortIndex;
  u_char bVar1;
  int iVar2;
  
  if (((carObj->carFlags & 1U) != 0) && ((carObj->stats).finishType == 2)) {
    int raceT = GameSetup_gData.raceType;
    if ((raceT == 1) || (raceT == 5)) {
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
      iVar2 = carObj->laneIndex;
      bVar1 = *(u_char *)((char *)BWorldSm_slices + (carObj->N).simRoadInfo.slice * 0x20 + 0x1d);
      if ((iVar2 == 6 - (u_int)(bVar1 >> 4)) || (iVar2 == (bVar1 & 0xf) + 7)) {
        CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + 0x960000;
      }
      else if (iVar2 < 7) {
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
  u_int newRand = fastRandom * randSeed;
  carObj->laneSlack = *(int *)((char *)carObj->personality + (newRand >> 6 & 0xc) + 0xc);
  randtemp = newRand;
  fastRandom = newRand & 0xffff;
  return;
}
