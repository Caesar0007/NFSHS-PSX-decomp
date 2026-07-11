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
  u_int uVar2;
  int ticksOn;
  int ticksOff;
  Car_tObj *otherCarObj;
  
  iVar1 = AIScript_DoReAction(&carObj->script,8);
  if ((iVar1 == -1) || (GameSetup_gData.raceType == 1)) {
    if ((carObj->control).horn != '\0') {
      iVar1 = 0;
      goto LAB_80057bec;
    }
  }
  else {
    iVar1 = 1;
LAB_80057bec:
    AudioClc_SetHorn(carObj,iVar1);
  }
  iVar1 = AIScript_DoReAction(&carObj->script,0x1000);
  if ((iVar1 != -1) && (GameSetup_gData.raceType != 1)) {
    uVar2 = (int)(simGlobal.gameTicks & 0x18U) >> 3;
    if (uVar2 == 1) {
      iVar1 = 2;
      ticksOn = 0x20;
      ticksOff = 0xc;
    }
    else if (uVar2 < 2) {
      if (uVar2 != 0) goto LAB_80057cc0;
      iVar1 = 4;
      ticksOn = 0x10;
      ticksOff = 8;
    }
    else if (uVar2 == 2) {
      iVar1 = 7;
      ticksOn = 0x28;
      ticksOff = 0x10;
    }
    else {
      if (uVar2 != 3) goto LAB_80057cc0;
      iVar1 = 1;
      ticksOn = 0x20;
      ticksOff = 0;
    }
    AudioClc_HonkHorn(carObj,iVar1,ticksOn,ticksOff);
  }
LAB_80057cc0:
  iVar1 = AIScript_DoReAction(&carObj->script,0x200);
  if (iVar1 != -1) {
    iVar1 = AIWorld_ApxSplineDistance(carObj,Cars_gList[iVar1]);
    if (iVar1 < 0) {
      iVar1 = -iVar1;
    }
    if (0xc0000 < iVar1) {
      iVar1 = AIScript_GetReactionTicksLeft(&carObj->script);
      if (iVar1 < 0) {
        iVar1 = iVar1 + 0x1f;
      }
      if ((iVar1 >> 5 & 1U) == 0) {
        CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + 0x1e0000;
      }
      else {
        CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + 0x1e0000;
      }
    }
  }
  iVar1 = AIScript_DoReAction(&carObj->script,0x20);
  if (iVar1 != -1) {
    otherCarObj = Cars_gList[iVar1];
    iVar1 = AIWorld_SplineDistance(carObj,otherCarObj);
    if (iVar1 * carObj->direction < 0x40000) {
      AI_TargetLane(carObj,otherCarObj->laneIndex);
    }
  }
  return;
}

/* ---- AI_CheckForPlayerActions__FP8Car_tObjT0  [@0x80057dd4] ---- */
void AI_CheckForPlayerActions(Car_tObj *carObj,Car_tObj *otherCarObj)
{
  int absDistance;
  int iVar1;
  int iVar2;
  Car_tObj *pCVar3;
  int iVar4;
  AIScript_tPlayAction AVar5;
  
  iVar1 = AIWorld_ApxSplineDistance(carObj,otherCarObj);
  if (iVar1 < 0) {
    iVar1 = -iVar1;
  }
  iVar2 = AIWorld_GameOdometer(carObj);
  if (iVar2 < 0x3200000) {
    return;
  }
  if (((simGlobal.gameTicks - (otherCarObj->N).collision.lastTime < 0xf) &&
      (pCVar3 = (Car_tObj *)(otherCarObj->N).collision.lastOtherObj, pCVar3 != (Car_tObj *)0x0)) &&
     (pCVar3 == carObj)) {
    AIScript_SubmitPlayerAction(&carObj->script,otherCarObj->carIndex,0,simGlobal.gameTicks);
  }
  if (otherCarObj->currentSpeed * carObj->direction + 0x280000 <
      carObj->currentSpeed * carObj->direction) {
    if (0xbffff < iVar1) goto LAB_80057f34;
    AIScript_SubmitPlayerAction(&carObj->script,otherCarObj->carIndex,1,simGlobal.gameTicks);
  }
  if ((iVar1 < 0xc0000) && (otherCarObj->laneIndex == carObj->laneIndex)) {
    iVar2 = AIWorld_GameOdometer(otherCarObj);
    iVar4 = AIWorld_GameOdometer(carObj);
    if (iVar4 < iVar2) {
      iVar2 = otherCarObj->carIndex;
      AVar5 = 2;
    }
    else {
      iVar2 = otherCarObj->carIndex;
      AVar5 = 3;
    }
    AIScript_SubmitPlayerAction(&carObj->script,iVar2,AVar5,simGlobal.gameTicks);
  }
LAB_80057f34:
  if ((otherCarObj->swapCar == carObj) && (simGlobal.gameTicks - carObj->swapTime < 0xf)) {
    iVar2 = AIWorld_GameOdometer(carObj);
    iVar4 = AIWorld_GameOdometer(otherCarObj);
    if (iVar4 < iVar2) {
      iVar2 = otherCarObj->carIndex;
      AVar5 = 4;
    }
    else {
      iVar2 = otherCarObj->carIndex;
      AVar5 = 5;
    }
    AIScript_SubmitPlayerAction(&carObj->script,iVar2,AVar5,simGlobal.gameTicks);
  }
  if (((iVar1 < 0x1e0000) && ((otherCarObj->control).horn != '\0')) && (GameSetup_gData.Time == 0))
  {
    AIScript_SubmitPlayerAction(&carObj->script,otherCarObj->carIndex,6,simGlobal.gameTicks);
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
  short sVar2;
  int iVar3;
  int iVar4;
  
  iVar3 = AI_IsMellowZone(carObj,0x1900000);
  if (iVar3 != 0) {
    return;
  }
  if (0xe < AI_Info.deltaYaw) {
    return;
  }
  sVar2 = (otherCarObj->N).simRoadInfo.slice;
  iVar3 = AIWorld_SplineDistance(carObj,otherCarObj);
  iVar3 = iVar3 * carObj->direction;
  iVar4 = AIScript_DoReAction(&carObj->script,0x400);
  if (((iVar4 == -1) || (iVar3 < 0)) || (0x31ffff < iVar3)) {
    if (iVar3 < -0x60000) {
      return;
    }
    if (*(int *)carObj->personality <= iVar3) {
      return;
    }
    if (iVar3 < ((int *)carObj->personality)[1]) {
      return;
    }
    iVar3 = otherCarObj->laneIndex;
    bVar1 = *(u_char *)(sVar2 * 0x20 + (int)BWorldSm_slices + 0x1d);
    if (iVar3 < (int)(7 - (u_int)(bVar1 >> 4))) {
      return;
    }
    if ((int)((bVar1 & 0xf) + 6) < iVar3) {
      return;
    }
    if (otherCarObj->currentSpeed * otherCarObj->direction < 0x140001) {
      return;
    }
    if (carObj->laneIndex <= iVar3) {
      if (iVar3 != carObj->laneIndex) {
        iVar3 = 0x40000;
        goto LAB_800582b0;
      }
      iVar3 = 0x40000;
      goto LAB_8005829c;
    }
    iVar3 = 0x40000;
  }
  else {
    if (carObj->laneIndex <= otherCarObj->laneIndex) {
      if (otherCarObj->laneIndex != carObj->laneIndex) {
        iVar3 = -0x40000;
LAB_800582b0:
        CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + iVar3;
        return;
      }
      iVar3 = -0x40000;
LAB_8005829c:
      CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + iVar3;
      return;
    }
    iVar3 = -0x40000;
  }
  CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + iVar3;
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
  int laneNotChecked[3];
  int speed;
  int sliceLoop;
  int profileHere;
  int checkSlice;
  short sVar1;
  bool bVar2;
  bool bVar3;
  bool bVar4;
  int mask;
  int mask_00;
  int mask_01;
  int iVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  int iVar10;
  int slice;
  
  bVar2 = true;
  bVar3 = true;
  bVar4 = true;
  mask = AIWorld_GetProfileMask(carObj->laneIndex + -1);
  mask_00 = AIWorld_GetProfileMask(carObj->laneIndex);
  mask_01 = AIWorld_GetProfileMask(carObj->laneIndex + 1);
  iVar8 = carObj->direction;
  iVar7 = carObj->currentSpeed;
  slice = (int)(carObj->N).simRoadInfo.slice;
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xffff;
  }
  iVar7 = iVar7 >> 0x10;
  if (iVar7 < 0) {
    iVar7 = -iVar7;
  }
  iVar7 = (iVar7 << 0x12) / 0x60000;
  iVar10 = slice + iVar7 * iVar8;
  if (iVar7 * iVar8 < 0) {
    if (iVar10 < 0) {
      iVar10 = iVar10 + gNumSlices;
    }
  }
  else if (gNumSlices <= iVar10) {
    iVar10 = iVar10 - gNumSlices;
  }
  iVar5 = (iVar7 + 1) * iVar8;
  iVar9 = slice + iVar5;
  if (iVar5 < 0) {
    if (iVar9 < 0) {
      iVar9 = iVar9 + gNumSlices;
    }
  }
  else if (gNumSlices <= iVar9) {
    iVar9 = iVar9 - gNumSlices;
  }
  sVar1 = *(short *)(slice * 0x20 + (int)BWorldSm_slices + 0x16);
  iVar5 = AIWorld_IsDriveableLane_UsingMask(slice,mask);
  if (iVar5 == 0) {
    CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + -0xa0000;
  }
  iVar5 = AIWorld_IsDriveableLane_UsingMask(slice,mask_00);
  if (iVar5 == 0) {
    CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + -0xa0000;
  }
  iVar5 = AIWorld_IsDriveableLane_UsingMask(slice,mask_01);
  if (iVar5 == 0) {
    CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + -0xa0000;
  }
  if ((sVar1 != *(short *)(iVar10 * 0x20 + (int)BWorldSm_slices + 0x16)) ||
     (sVar1 != *(short *)(iVar9 * 0x20 + (int)BWorldSm_slices + 0x16))) {
    carObj->barrierThinkHarder = 0x49;
  }
  if (0 < carObj->barrierThinkHarder) {
    iVar10 = iVar7 * 0xa3d;
    if (iVar10 < 0) {
      iVar10 = iVar10 + 0xffff;
    }
    iVar10 = iVar10 >> 0x10;
    iVar5 = 0;
    if (iVar10 == 0) {
      iVar10 = 1;
    }
    carObj->barrierThinkHarder = carObj->barrierThinkHarder - AI_elapsedTime;   /* H16: subtraction dropped (m2c self-assign fold); oracle 0x8005855C $v0=$a0-AI_elapsedTime, 0x80058560 store */
    for (; iVar5 < iVar7; iVar5 = iVar5 + iVar10) {
      iVar9 = slice + iVar5 * iVar8;
      if (iVar5 * iVar8 < 0) {
        if (iVar9 < 0) {
          iVar9 = iVar9 + gNumSlices;
        }
      }
      else if (gNumSlices <= iVar9) {
        iVar9 = iVar9 - gNumSlices;
      }
      if ((bVar2) &&
         (iVar6 = AIWorld_IsDriveableLane_UsingMask(iVar9,mask),
         iVar6 == 0)) {
        bVar2 = false;
        CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + -0x280000;
      }
      if ((bVar3) &&
         (iVar6 = AIWorld_IsDriveableLane_UsingMask(iVar9,mask_00),
         iVar6 == 0)) {
        bVar3 = false;
        CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + -0x280000;
      }
      if ((bVar4) &&
         (iVar9 = AIWorld_IsDriveableLane_UsingMask(iVar9,mask_01),
         iVar9 == 0)) {
        bVar4 = false;
        CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + -0x280000;
      }
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
  int lookAhead;
  int laneIndex;
  u_char bVar1;

  lookAhead = carObj->currentSpeed;
  if (lookAhead < 0) {
    lookAhead = -lookAhead;
  }
  lookAhead = fixedmult(lookAhead,0x6aaa);
  if (lookAhead < 0) {
    lookAhead = lookAhead + 0xffff;
  }
  lookAhead = lookAhead >> 0x10;
  if (lookAhead < 5) {
    lookAhead = 5;
  }
  absLaneLookAhead = lookAhead * carObj->direction;
  if (absLaneLookAhead < 0) {
    absLaneLookAhead = (carObj->N).simRoadInfo.slice + absLaneLookAhead;
    lookAheadSlice = absLaneLookAhead * 0x20;
    if (-1 < absLaneLookAhead) goto LAB_800588a4;
    absLaneLookAhead = absLaneLookAhead + gNumSlices;
  }
  else {
    absLaneLookAhead = (carObj->N).simRoadInfo.slice + absLaneLookAhead;
    lookAheadSlice = absLaneLookAhead * 0x20;
    if (absLaneLookAhead < gNumSlices) goto LAB_800588a4;
    absLaneLookAhead = absLaneLookAhead - gNumSlices;
  }
  lookAheadSlice = absLaneLookAhead << 5;
LAB_800588a4:
  bVar1 = *(u_char *)((char *)BWorldSm_slices + lookAheadSlice + 0x1d);
  laneIndex = carObj->laneIndex;
  if ((((laneIndex < (int)(7 - (u_int)(bVar1 >> 4))) || ((int)((bVar1 & 0xf) + 6) < laneIndex)) &&
      (bVar1 = *(u_char *)((char *)BWorldSm_slices + (carObj->N).simRoadInfo.slice * 0x20 + 0x1d),
      (int)(7 - (u_int)(bVar1 >> 4)) <= laneIndex)) && (laneIndex <= (int)((bVar1 & 0xf) + 6))) {
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
  u_char bVar1;
  bool bVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  
  iVar5 = (int)(carObj->N).simRoadInfo.slice;
  iVar4 = -0x4e666;
  if (((((carObj->carFlags & 0x10U) != 0) &&
       (iVar4 = -0x260000, AI_Info.blockingCars[1] != (Car_tObj *)0x0)) &&
      ((AI_Info.blockingCars[1]->carFlags & 1U) != 0)) && (0x8e38e < AI_Info.blockingCars[1]->speed)
     ) {
    iVar4 = 0x50000;
  }
  iVar3 = carObj->laneIndex + -1;
  bVar1 = *(u_char *)((char *)BWorldSm_slices + iVar5 * 0x20 + 0x1d);
  if ((iVar3 == 6 - (u_int)(bVar1 >> 4)) || (iVar3 == (bVar1 & 0xf) + 7)) {
    CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + iVar4;
    iVar3 = (int)((char *)BWorldSm_slices + (carObj->N).simRoadInfo.slice * 0x20);
    if ((int)(*(short *)(iVar3 + 0x18) * 0x100 -
             (u_int)*(u_char *)(iVar3 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar3 + 0x1d) >> 4)) <
        (carObj->N).dimension.x) {
      CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + -0x640000;
    }
  }
  iVar3 = carObj->laneIndex + 1;
  bVar1 = *(u_char *)((char *)BWorldSm_slices + iVar5 * 0x20 + 0x1d);
  if ((iVar3 == 6 - (u_int)(bVar1 >> 4)) || (iVar3 == (bVar1 & 0xf) + 7)) {
    CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + iVar4;
    iVar3 = (int)((char *)BWorldSm_slices + (carObj->N).simRoadInfo.slice * 0x20);
    if ((int)(*(short *)(iVar3 + 0x1a) * 0x100 -
             (u_int)*(u_char *)(iVar3 + 0x1f) * 0x8000 * (*(u_char *)(iVar3 + 0x1d) & 0xf)) <
        (carObj->N).dimension.x) {
      CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + -0x640000;
    }
  }
  bVar1 = *(u_char *)((char *)BWorldSm_slices + iVar5 * 0x20 + 0x1d);
  if ((carObj->laneIndex == 6 - (u_int)(bVar1 >> 4)) || (carObj->laneIndex == (bVar1 & 0xf) + 7)) {
    CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + iVar4;
    bVar2 = carObj->laneIndex < 7;
    if (((bVar2) &&
        (iVar4 = (int)((char *)BWorldSm_slices + (carObj->N).simRoadInfo.slice * 0x20),
        (int)(*(short *)(iVar4 + 0x18) * 0x100 -
             (u_int)*(u_char *)(iVar4 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar4 + 0x1d) >> 4)) <
        (carObj->N).dimension.x)) ||
       ((!bVar2 &&
        (iVar4 = (int)((char *)BWorldSm_slices + (carObj->N).simRoadInfo.slice * 0x20),
        (int)(*(short *)(iVar4 + 0x1a) * 0x100 -
             (u_int)*(u_char *)(iVar4 + 0x1f) * 0x8000 * (*(u_char *)(iVar4 + 0x1d) & 0xf)) <
        (carObj->N).dimension.x)))) {
      CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + -0x640000;
    }
  }
  bVar1 = *(u_char *)((char *)BWorldSm_slices + iVar5 * 0x20 + 0x1d);
  iVar4 = carObj->laneIndex + -1;
  if ((iVar4 < (int)(6 - (u_int)(bVar1 >> 4))) || ((int)((bVar1 & 0xf) + 7) < iVar4)) {
    CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + -0x3e80000;
  }
  bVar1 = *(u_char *)((char *)BWorldSm_slices + iVar5 * 0x20 + 0x1d);
  if ((carObj->laneIndex < (int)(6 - (u_int)(bVar1 >> 4))) ||
     ((int)((bVar1 & 0xf) + 7) < carObj->laneIndex)) {
    CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + -0x3e80000;
  }
  bVar1 = *(u_char *)((char *)BWorldSm_slices + iVar5 * 0x20 + 0x1d);
  iVar4 = carObj->laneIndex + 1;
  if ((iVar4 < (int)(6 - (u_int)(bVar1 >> 4))) || ((int)((bVar1 & 0xf) + 7) < iVar4)) {
    CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + -0x3e80000;
  }
  return;
}

/* ---- AI_CalculateLaneSpeeds__FP8Car_tObj  [@0x80058d20] ---- */
void AI_CalculateLaneSpeeds(Car_tObj *carObj)
{
  Car_tObj*otherCarObj;
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
  int iVar1;
  int iVar2;
  int iVar3;
  u_int uVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  Car_tObj *carObj_00;
  u_int uVar8;
  int iVar9;
  int iVar10;
  u_int uVar11;
  u_int uVar12;
  
  uVar8 = 0;
  iVar10 = 0;
  iVar9 = 0;
  iVar1 = *(int *)(carObj->personality + 8);
  AI_Info.laneSpeeds[0] = carObj->desiredSpeed;
  AI_Info.laneSpeeds[1] = carObj->desiredSpeed;
  AI_Info.laneSpeeds[2] = carObj->desiredSpeed;
  uVar4 = carObj->laneIndex;
  iVar7 = carObj->sortIndex;
  uVar12 = 1 << (uVar4 - 1);
  uVar11 = 1 << (uVar4);
  uVar4 = 1 << (uVar4 + 1);
  AI_Info.laneSpeedsAhead[0] = AI_Info.laneSpeeds[0];
  AI_Info.laneSpeedsAhead[1] = AI_Info.laneSpeeds[1];
  AI_Info.laneSpeedsAhead[2] = AI_Info.laneSpeeds[2];
  do {
    if ((iVar9 == 3) || (Cars_gNumCars <= iVar10)) {
      return;
    }
    iVar2 = iVar7 + iVar10 * carObj->direction + Cars_gNumCars;
    carObj_00 = Cars_gSortedList[iVar2 % Cars_gNumCars];
    if ((carObj != carObj_00) && ((carObj_00->N).active != '\0')) {
      iVar3 = AIWorld_SplineDistance(carObj_00,carObj);
      iVar2 = iVar3 * carObj->direction;
      iVar5 = carObj->currentSpeed;
      if (iVar5 < 0) {
        iVar5 = -iVar5;
      }
      if (iVar5 < 0x1638e3) {
        iVar6 = 0xd555;
        iVar5 = 0x6666;
      }
      else {
        iVar6 = 0x14000;
        iVar5 = 0x8e38;
      }
      if (iVar2 < 0xf0000) {
        iVar6 = 0x2aaa;
        iVar5 = 0x1999;
      }
      if (((carObj->N).dimension.z < iVar2) && (iVar2 < iVar1)) {
        if (carObj->direction == 1) {
          if (iVar3 < 0) {
            iVar3 = iVar3 + 0xffff;
          }
          iVar3 = (iVar3 >> 0x10) + -2;
          if ((carObj->carFlags & 0x28U) != 0) {
            if (0 < iVar3) goto LAB_80058f88;
            iVar3 = 1;
          }
          if (iVar3 < 0) {
            iVar3 = 0;
          }
        }
        else {
          if (iVar3 < 0) {
            iVar3 = iVar3 + 0xffff;
          }
          iVar3 = (iVar3 >> 0x10) + 2;
          if (((carObj->carFlags & 0x28U) != 0) && (1 < iVar3)) {
            iVar3 = -1;
          }
          if (0 < iVar3) {
            iVar3 = 0;
          }
        }
LAB_80058f88:
        iVar6 = carObj_00->currentSpeed + iVar3 * iVar6;
        iVar5 = carObj_00->currentSpeed + iVar3 * iVar5;
        if (((carObj_00->carInLane & uVar11) != 0) && ((uVar8 & uVar11) == 0)) {
          uVar8 = uVar8 | uVar11;
          iVar9 = iVar9 + 1;
          AI_Info.blockingCars[1] = carObj_00;
          AI_Info.blockingCarsDist[1] = iVar2;
          AI_Info.laneSpeeds[1] = iVar6;
          AI_Info.laneSpeedsAhead[1] = iVar5;
        }
        if (((carObj->laneIndex - 1U < 0xe) && ((carObj_00->carInLane & uVar12) != 0)) &&
           ((uVar8 & uVar12) == 0)) {
          uVar8 = uVar8 | uVar12;
          iVar9 = iVar9 + 1;
          AI_Info.blockingCars[0] = carObj_00;
          AI_Info.blockingCarsDist[0] = iVar2;
          AI_Info.laneSpeeds[0] = iVar6;
          AI_Info.laneSpeedsAhead[0] = iVar5;
        }
        if (((carObj->laneIndex + 1U < 0xe) && ((carObj_00->carInLane & uVar4) != 0)) &&
           ((uVar8 & uVar4) == 0)) {
          uVar8 = uVar8 | uVar4;
          iVar9 = iVar9 + 1;
          AI_Info.blockingCars[2] = carObj_00;
          AI_Info.blockingCarsDist[2] = iVar2;
          AI_Info.laneSpeeds[2] = iVar6;
          AI_Info.laneSpeedsAhead[2] = iVar5;
        }
      }
    }
    iVar10 = iVar10 + 1;
  } while( true );
}

/* ---- AI_CalcMeritsBasedOnSpeed__FP8Car_tObj  [@0x800590b4] ---- */
void AI_CalcMeritsBasedOnSpeed(Car_tObj *carObj)
{
  int dSpeed;
  int cSpeed;
  int considerDesired;
  int iVar1;
  int iVar2;
  int (*paiVar3) [3];
  AI_tInfo *pAVar4;
  int iVar5;
  int iVar6;
  
  iVar6 = carObj->desiredSpeed;
  iVar5 = carObj->currentSpeed;
  iVar1 = AIWorld_GameOdometer(carObj);
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
    paiVar3 = CarLogic_gObs;
    pAVar4 = &AI_Info;
    do {
      iVar2 = pAVar4->laneSpeeds[0];
      if ((iVar2 <= iVar5) && (pAVar4->blockingCars[0] != (Car_tObj *)0x0)) {
        iVar2 = fixedmult(iVar5 - iVar2,-0x14ccc);
        (*paiVar3)[0] = (*paiVar3)[0] + iVar2;
        iVar2 = pAVar4->laneSpeeds[0];
      }
      if (((iVar2 <= iVar6) && (pAVar4->blockingCars[0] != (Car_tObj *)0x0)) && (0x257ffff < iVar1))
      {
        iVar2 = fixedmult(iVar6 - iVar2,-0x8000);
        (*paiVar3)[0] = (*paiVar3)[0] + iVar2;
      }
      iVar2 = pAVar4->laneSpeedsAhead[0];
      if ((iVar2 <= iVar5) && (pAVar4->blockingCars[0] != (Car_tObj *)0x0)) {
        iVar2 = fixedmult(iVar5 - iVar2,-0x8000);
        (*paiVar3)[0] = (*paiVar3)[0] + iVar2;
        iVar2 = pAVar4->laneSpeedsAhead[0];
      }
      if (((iVar2 <= iVar6) && (pAVar4->blockingCars[0] != (Car_tObj *)0x0)) && (0x257ffff < iVar1))
      {
        iVar2 = fixedmult(iVar6 - iVar2,-0x1999);
        (*paiVar3)[0] = (*paiVar3)[0] + iVar2;
      }
      paiVar3 = paiVar3 + 1;
      pAVar4 = (AI_tInfo *)(pAVar4->blockingCars + 1);
    } while ((int)paiVar3 < -0x7fef3310);
  }
  else {
    paiVar3 = CarLogic_gObs;
    pAVar4 = &AI_Info;
    do {
      iVar1 = pAVar4->laneSpeeds[0];
      if (iVar5 <= iVar1) {
        if (pAVar4->blockingCars[0] != (Car_tObj *)0x0) {
          iVar1 = fixedmult(iVar1 - iVar5,-0x14ccc);
          (*paiVar3)[0] = (*paiVar3)[0] + iVar1;
        }
        iVar1 = pAVar4->laneSpeeds[0];
      }
      if ((iVar6 <= iVar1) && (pAVar4->blockingCars[0] != (Car_tObj *)0x0)) {
        iVar1 = fixedmult(iVar1 - iVar6,-0x8000);
        (*paiVar3)[0] = (*paiVar3)[0] + iVar1;
      }
      iVar1 = pAVar4->laneSpeedsAhead[0];
      if (iVar5 <= iVar1) {
        if (pAVar4->blockingCars[0] != (Car_tObj *)0x0) {
          iVar1 = fixedmult(iVar1 - iVar5,-0x8000);
          (*paiVar3)[0] = (*paiVar3)[0] + iVar1;
        }
        iVar1 = pAVar4->laneSpeedsAhead[0];
      }
      if ((iVar6 <= iVar1) && (pAVar4->blockingCars[0] != (Car_tObj *)0x0)) {
        iVar1 = fixedmult(iVar1 - iVar6,-0x1999);
        (*paiVar3)[0] = (*paiVar3)[0] + iVar1;
      }
      paiVar3 = paiVar3 + 1;
      pAVar4 = (AI_tInfo *)(pAVar4->blockingCars + 1);
    } while ((int)paiVar3 < -0x7fef3310);
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
  Car_tObj*otherCarObj;
  int carObjIndexInSortedList;
  int clearAheadMerits[3];
  int iVar1;
  int iVar2;
  u_int uVar3;
  int iVar4;
  Car_tObj *carObj_00;
  u_int uVar5;
  int iVar6;
  int iVar7;
  int local_38;
  int local_34;
  int local_30;
  
  iVar4 = carObj->sortIndex;
  uVar5 = 0;
  if (((carObj->carFlags & 8U) != 0) &&
     (iVar1 = AI_IsMellowZone(carObj,0), iVar1 == 0)) {
    local_30 = 0x40000;
    local_34 = 0x40000;
    local_38 = 0x40000;
    iVar7 = carObj->direction;
    iVar6 = 0;
    iVar4 = iVar7 * iVar7 + iVar4;
    iVar1 = iVar7;
    do {
      if (Cars_gNumCars <= iVar1) break;
      carObj_00 = Cars_gSortedList[(iVar4 + Cars_gNumCars) % Cars_gNumCars];
      if (((carObj != carObj_00) && ((carObj_00->N).active != '\0')) &&
         (iVar2 = AIWorld_SplineDistance(carObj_00,carObj),
         iVar2 + 0x40000U < 0x6e0000)) {
        uVar3 = carObj->laneIndex;
        if (((carObj_00->carInLane >> (uVar3) & 1U) != 0) &&
           (((int)uVar5 >> (uVar3) & 1U) == 0)) {
          local_34 = 0;
          iVar6 = iVar6 + 1;
          uVar5 = uVar5 | 1 << (carObj->laneIndex);
          uVar3 = carObj->laneIndex;
        }
        if (((0 < (int)uVar3) && ((carObj_00->carInLane >> (uVar3 - 1) & 1U) != 0)) &&
           (((int)uVar5 >> (uVar3 - 1) & 1U) == 0)) {
          local_38 = 0;
          iVar6 = iVar6 + 1;
          uVar5 = uVar5 | 1 << (carObj->laneIndex - 1U);
        }
        uVar3 = carObj->laneIndex + 1;
        if (((uVar3 < 0xe) && ((carObj_00->carInLane >> (uVar3) & 1U) != 0)) &&
           (((int)uVar5 >> (uVar3) & 1U) == 0)) {
          local_30 = 0;
          iVar6 = iVar6 + 1;
          uVar5 = uVar5 | 1 << (carObj->laneIndex + 1U);
        }
      }
      iVar4 = iVar4 + iVar7;
      iVar1 = iVar1 + 1;
    } while (iVar6 != 3);
    CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + local_38;
    CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + local_34;
    CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + local_30;
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
                       (int)(signed char)(AIDataRecord_BestLine->_base_AIDataRecord_t).dataBuffer_
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
  int iVar1;
  int *piVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  int importance;
  Group *pGVar8;
  int iVar9;
  coorddef local_48;
  int local_38;
  int local_34;
  int local_30;
  int local_28;
  int local_24;
  int local_20;
  
  pGVar8 = groupSimObjs + 1;
  if (firstTime != '\0') {
    firstTime = '\0';
    BWorldSm_SetSlice(0,(BWorldSm_Pos *)&spos);
  }
  for (iVar9 = 0; iVar9 < groupSimObjs->m_num_elements; iVar9 = iVar9 + 1) {
    local_48.x = pGVar8->m_num_elements;
    local_48.y = pGVar8[1].m_num_elements;
    local_48.z = pGVar8[2].m_num_elements;
    BWorldSm_FindClosestSlice(&local_48,(BWorldSm_Pos *)&spos);
    iVar1 = AIWorld_ApxSplineDistance(spos.slice,carObj);   /* H17: arg0 was 0; oracle 0x800597B4 $a0=*(short*)spos=spos.slice */
    if (iVar1 * carObj->direction - 1U < 0x63ffff) {
      piVar2 = (int *)((char *)BWorldSm_slices + (carObj->N).simRoadInfo.slice * 0x20);
      local_38 = *piVar2;
      local_34 = piVar2[1];
      local_30 = piVar2[2];
      local_28 = local_48.x - local_38;
      local_24 = local_48.y - local_34;
      local_20 = local_48.z - local_30;
      iVar1 = (carObj->N).roadMatrix.m[0];
      if (iVar1 < 0) {
        iVar1 = iVar1 + 0xff;
      }
      iVar3 = local_28;
      if (local_28 < 0) {
        iVar3 = local_28 + 0xff;
      }
      iVar6 = (carObj->N).roadMatrix.m[1];
      if (iVar6 < 0) {
        iVar6 = iVar6 + 0xff;
      }
      iVar4 = local_24;
      if (local_24 < 0) {
        iVar4 = local_24 + 0xff;
      }
      iVar7 = (carObj->N).roadMatrix.m[2];
      if (iVar7 < 0) {
        iVar7 = iVar7 + 0xff;
      }
      iVar5 = local_20;
      if (local_20 < 0) {
        iVar5 = local_20 + 0xff;
      }
      importance = -0xd0000;
      iVar1 = (iVar1 >> 8) * (iVar3 >> 8) + (iVar6 >> 8) * (iVar4 >> 8) +
              (iVar7 >> 8) * (iVar5 >> 8);
      if (*(char *)((int)&pGVar8[4].m_num_elements + 3) == '\x01') {
        importance = -0x280000;
      }
      iVar3 = (int)(short)pGVar8[3].m_num_elements;
      AI_SubmitObstacle(carObj,importance,iVar1 + iVar3 * -0x200,iVar1 + iVar3 * 0x200,spos.slice);   /* H17: 5th arg (slice) was 0; oracle 0x800598E4 reload spos.slice -> feeds AIWorld_LaneIndex */
    }
    pGVar8 = pGVar8 + 5;
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
  int leftEdgeIndex;
  int rightEdgeIndex;
  int observations[3];
  int leftDistance;
  int rightDistance;
  u_int uVar1;
  u_int uVar2;
  int iVar3;
  int iVar4;
  int local_28;
  int local_24;
  int local_20;
  
  memset((u_char *)&local_28,'\0',0xc);
  uVar1 = AIWorld_LaneIndex(slice,leftLatPosition);
  uVar2 = AIWorld_LaneIndex(slice,rightLatPosition);
  if ((uVar2 < 0xe) && (uVar1 < 0xe)) {
    iVar4 = carObj->laneIndex + -1;
    if (((int)uVar1 <= iVar4) && (iVar4 <= (int)uVar2)) {
      local_28 = importance;
    }
    if (((int)uVar1 <= carObj->laneIndex) && (carObj->laneIndex <= (int)uVar2)) {
      local_24 = importance;
    }
    iVar4 = carObj->laneIndex + 1;
    if (((int)uVar1 <= iVar4) && (iVar4 <= (int)uVar2)) {
      local_20 = importance;
    }
    if (((local_28 != 0) && (local_24 != 0)) && (local_20 != 0)) {
      iVar4 = carObj->roadPosition - leftLatPosition;
      iVar3 = carObj->roadPosition - rightLatPosition;
      if (iVar4 < 0) {
        iVar4 = -iVar4;
      }
      if (iVar3 < 0) {
        iVar3 = -iVar3;
      }
      if (iVar4 < iVar3) {
        local_28 = 0;
      }
      else {
        local_20 = 0;
      }
    }
    CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + local_28;
    CarLogic_gObs[0][1] = CarLogic_gObs[0][1] + local_24;
    CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + local_20;
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
    iVar2 = ~carObj->direction;
    if (D_8011321C == 0) {
      iVar2 = carObj->direction ^ 1;
    }
    /* @0x80059BC8: unsigned sltu zero,iVar2 -- honk unless iVar2 == 0 (iVar2 = ~direction /
     * direction^1). */
    if (((iVar2 != 0) && (visibleCar != (Car_tObj *)0x0)) && (-0x30000 < AI_Info.laneSpeeds[1])) {
      randtemp = fastRandom * randSeed;
      fastRandom = randtemp & 0xffff;
      if ((((int)((randtemp >> 8 & 0xffff) * 1000 >> 0x10) < 5) && (GameSetup_gData.commMode != 1)) &&
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
  Car_tObj *carObj_00;
  Car_tObj **ppCVar4;
  int demerit;

  ci = 0;
  if (((carObj->carFlags & 0x10U) == 0) && (blockDistance = (carObj->N).dimension.z, 0 < Cars_gNumCars)) {
    demerit = -0x60000;
    ppCVar4 = Cars_gList;
    do {
      carObj_00 = *ppCVar4;
      if ((carObj != carObj_00) && ((carObj_00->N).active != '\0')) {
        absDistance = AIWorld_SplineDistance(carObj_00,carObj);
        if (absDistance < 0) {
          absDistance = -absDistance;
        }
        if ((absDistance < 0xa0001) && (absDistance < blockDistance * 2 + blockDistance / 2)) {
          if (carObj_00->laneIndex == carObj->laneIndex + -1) {
            CarLogic_gObs[0][0] = CarLogic_gObs[0][0] + demerit;
          }
          else if (carObj_00->laneIndex == carObj->laneIndex + 1) {
            CarLogic_gObs[0][2] = CarLogic_gObs[0][2] + demerit;
          }
        }
      }
      ppCVar4 = ppCVar4 + 1;
      ci = ci + 1;
    } while (ci < Cars_gNumCars);
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
  bool bVar1;
  int iVar2;
  u_int uVar3;
  u_int uVar4;
  u_int uVar5;
  u_int uVar6;
  int local_20 [4];
  
  iVar2 = AIWorld_LaneIndex((int)(carObj->N).simRoadInfo.slice,
                     (carObj->preferredLateralPosition - (carObj->N).dimension.x) + -0x4000);
  if (iVar2 == carObj->laneIndex) {
    uVar6 = 1;
  }
  else {
    uVar6 = (iVar2 < carObj->laneIndex ^ 1) << 1;
  }
  local_20[2] = AI_Info.laneWeights[2];
  local_20[0] = AI_Info.laneWeights[0];
  local_20[1] = AI_Info.laneWeights[1];
  local_20[uVar6] = local_20[uVar6] + carObj->preferredLateralPositionPower;
  iVar2 = local_20[0];
  if (local_20[0] < local_20[1]) {
    iVar2 = local_20[1];
  }
  uVar5 = (u_int)(local_20[0] < local_20[1]);
  if (iVar2 < local_20[2]) {
    uVar5 = 2;
  }
  iVar2 = AIWorld_LaneIndex((int)(carObj->N).simRoadInfo.slice,
                     carObj->preferredLateralPosition + (carObj->N).dimension.x + 0x4000);
  if (iVar2 == carObj->laneIndex) {
    uVar4 = 1;
  }
  else {
    uVar4 = (iVar2 < carObj->laneIndex ^ 1) << 1;
  }
  local_20[2] = AI_Info.laneWeights[2];
  local_20[0] = AI_Info.laneWeights[0];
  local_20[1] = AI_Info.laneWeights[1];
  local_20[uVar4] = local_20[uVar4] + carObj->preferredLateralPositionPower;
  bVar1 = local_20[0] < local_20[1];
  if (bVar1) {
    local_20[0] = local_20[1];
  }
  uVar3 = (u_int)bVar1;
  if (local_20[0] < local_20[2]) {
    uVar3 = 2;
  }
  iVar2 = 0;
  if ((uVar5 == uVar6) && (uVar3 == uVar4)) {
    iVar2 = 1;
    carObj->desiredLatPos = carObj->preferredLateralPosition;
  }
  return iVar2;
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
  int iVar1;
  u_int uVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  
  iVar3 = (carObj->N).dimension.x;
  iVar3 = iVar3 + iVar3 / 2;
  if (AI_Info.desiredLane < 7) {
    uVar2 = (u_int)*(u_char *)((char *)BWorldSm_slices + (carInWay->N).simRoadInfo.slice * 0x20 + 0x1e);
    iVar1 = (AI_Info.desiredLane + -6) * uVar2 * 0x8000;
    iVar4 = iVar1 + uVar2 * -0x8000;
  }
  else {
    iVar1 = (u_int)*(u_char *)((char *)BWorldSm_slices + (carInWay->N).simRoadInfo.slice * 0x20 + 0x1f) *
            0x8000;
    iVar4 = (AI_Info.desiredLane + -7) * iVar1;
    iVar1 = iVar4 + iVar1;
  }
  iVar6 = carInWay->roadPosition - carInWay->roadSpan;
  iVar4 = iVar6 - iVar4;
  iVar5 = carInWay->roadPosition + carInWay->roadSpan;
  iVar1 = iVar1 - iVar5;
  if ((iVar1 <= iVar3) && (iVar4 <= iVar3)) {
    return 0;
  }
  if (iVar4 < iVar1) {
    iVar5 = iVar5 + iVar1 / 2;
  }
  else {
    iVar5 = iVar6 - iVar4 / 2;
  }
  carObj->desiredLatPos = iVar5;
  return 1;
}

/* ---- AI_CalculateDesiredLatPosition__FP8Car_tObj  [@0x8005a15c] ---- */
void AI_CalculateDesiredLatPosition(Car_tObj *carObj)
{
  Car_tObj*carInWay;
  int slice;
  bool bVar1;
  int iVar2;
  u_int uVar3;
  Car_tObj *carObj_00;
  int iVar4;
  
  iVar4 = (int)(carObj->N).simRoadInfo.slice;
  carObj_00 = AI_Info.blockingCars[AI_Info.desiredLaneSide];
  if ((0 < carObj->preferredLateralPositionPower) &&
     (iVar2 = AI_CheckPreferredLateralPosition(carObj), iVar2 == 1)) {
    return;
  }
  bVar1 = false;
  if (carObj_00 != (Car_tObj *)0x0) {
    iVar2 = AIWorld_ApxSplineDistance(carObj_00,carObj);
    if (iVar2 < 1) {
      iVar2 = AIWorld_ApxSplineDistance(carObj_00,carObj);
      iVar2 = -iVar2;
    }
    else {
      iVar2 = AIWorld_ApxSplineDistance(carObj_00,carObj);
    }
    if ((iVar2 < 0x140000) && (iVar2 = AI_IsMellowZone(carObj,0x3e80000), iVar2 == 0))
    {
      bVar1 = true;
    }
  }
  if ((bVar1) && (iVar2 = AI_TryToShareLanes(carObj,carObj_00), iVar2 == 1)) {
    return;
  }
  iVar2 = iVar4 * 0x20 + (int)BWorldSm_slices;
  if ((AI_Info.desiredLane == 6 - (u_int)(*(u_char *)(iVar2 + 0x1d) >> 4)) ||
     (AI_Info.desiredLane == (*(u_char *)(iVar2 + 0x1d) & 0xf) + 7)) {
    if (AI_Info.desiredLane < 7) {
      iVar2 = (AI_Info.desiredLane + -6) * (u_int)*(u_char *)(iVar2 + 0x1e) * 0x8000 -
              (carObj->N).dimension.x;
      goto LAB_8005a30c;
    }
    iVar2 = (AI_Info.desiredLane + -7) * (u_int)*(u_char *)(iVar2 + 0x1f) * 0x8000;
    uVar3 = (carObj->N).dimension.x;
  }
  else {
    if (AI_Info.desiredLane < 7) {
      uVar3 = (u_int)*(u_char *)(iVar2 + 0x1e) * 0x8000;
      iVar2 = (AI_Info.desiredLane + -6) * uVar3 - (uVar3 >> 1);
      goto LAB_8005a30c;
    }
    uVar3 = (u_int)*(u_char *)(iVar2 + 0x1f) * 0x8000;
    iVar2 = (AI_Info.desiredLane + -7) * uVar3;
    uVar3 = uVar3 >> 1;
  }
  iVar2 = iVar2 + uVar3;
LAB_8005a30c:
  carObj->desiredLatPos = iVar2;
  iVar4 = iVar4 * 0x20;
  iVar2 = *(short *)(iVar4 + BWorldSm_slices + 0x1a) * 0x100 - (carObj->N).dimension.x;
  if (iVar2 < carObj->desiredLatPos) {
    carObj->desiredLatPos = iVar2;
  }
  iVar4 = (carObj->N).dimension.x + *(short *)(iVar4 + BWorldSm_slices + 0x18) * -0x100;
  if (carObj->desiredLatPos < iVar4) {
    carObj->desiredLatPos = iVar4;
  }
  return;
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
  bool bVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  
  iVar2 = AI_Info.laneSpeeds[1];
  if (((AI_Info.desiredLane != carObj->laneIndex) && (AI_Info.blockingCars[1] != (Car_tObj *)0x0))
     && ((AI_Info.blockingCars[1]->N).deadTimer == 0)) {
    iVar2 = AIWorld_SplineDistance(carObj,AI_Info.blockingCars[1]);
    if (iVar2 < 1) {
      iVar2 = AIWorld_SplineDistance(carObj,AI_Info.blockingCars[1]);
      iVar2 = -iVar2;
    }
    else {
      iVar2 = AIWorld_SplineDistance(carObj,AI_Info.blockingCars[1]);
    }
    iVar5 = carObj->currentSpeed - AI_Info.blockingCars[1]->currentSpeed;
    if (iVar5 < 1) {
      iVar5 = AI_Info.blockingCars[1]->currentSpeed - carObj->currentSpeed;
    }
    iVar4 = carObj->desiredLatPos - carObj->roadPosition;
    if (iVar4 < 1) {
      iVar4 = carObj->roadPosition - carObj->desiredLatPos;
    }
    iVar3 = AIWorld_CalcLateralVelocity(carObj);
    if (iVar3 < 1) {
      iVar3 = AIWorld_CalcLateralVelocity(carObj);
      iVar3 = -iVar3;
    }
    else {
      iVar3 = AIWorld_CalcLateralVelocity(carObj);
    }
    iVar5 = fixedmult(iVar4,iVar5);
    iVar4 = fixedmult(iVar2,iVar3);
    iVar5 = fixedmult(iVar5,0x13333);
    iVar2 = AI_Info.laneSpeeds[1];
    if ((iVar5 < iVar4) && (iVar2 = AI_Info.laneSpeeds[0], carObj->laneIndex < AI_Info.desiredLane))
    {
      iVar2 = AI_Info.laneSpeeds[2];
    }
  }
  if (carObj->direction == 1) {
    if (iVar2 < carObj->desiredSpeed) {
      carObj->desiredSpeed = iVar2;
    }
    iVar2 = -0x14ccc;
    bVar1 = carObj->desiredSpeed < -0x14ccc;
  }
  else {
    if (carObj->desiredSpeed < iVar2) {
      carObj->desiredSpeed = iVar2;
    }
    iVar2 = 0x14ccc;
    bVar1 = 0x14ccc < carObj->desiredSpeed;
  }
  if (bVar1) {
    carObj->desiredSpeed = iVar2;
  }
  if ((AI_Info.desiredLane != carObj->laneIndex) && (AI_Info.blockingCars[1] != (Car_tObj *)0x0)) {
    iVar2 = AI_Info.blockingCars[1]->currentSpeed;
    if (iVar2 < 0) {
      iVar2 = -iVar2;
    }
    if (iVar2 < 0xa0000) {
      if (carObj->direction == 1) {
        iVar2 = carObj->desiredSpeed;
        if (iVar2 < 0x6aaaa) {
          iVar2 = 0x6aaaa;
        }
      }
      else {
        iVar2 = carObj->desiredSpeed;
        if (-0x6aaaa < iVar2) {
          iVar2 = -0x6aaaa;
        }
      }
      carObj->desiredSpeed = iVar2;
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
  u_char bVar1;

  index = carObj->sortIndex;
  odom = AIWorld_GameOdometer(carObj);
  if ((carObj->carFlags & 8U) != 0) {
    bVar1 = *(u_char *)((char *)BWorldSm_slices + (carObj->N).simRoadInfo.slice * 0x20 + 0x1d);
    if ((carObj->laneIndex != 6 - (u_int)(bVar1 >> 4)) && (carObj->laneIndex != (bVar1 & 0xf) + 7)) {
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
      return endMellow + delay < odom + index * 0x540000 ^ 1;
    }
  }
  return 0;
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
  int iVar3;
  Car_tObj **ppCVar4;
  
  if ((((carObj->carFlags & 1U) != 0) && ((carObj->stats).finishType == 2)) &&
     (((GameSetup_gData.raceType != 1 && (GameSetup_gData.raceType != 5)) ||
      ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) == 0 &&
       ((Cars_gNumHumanRaceCars != 2 || (((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) == 0)))))))) {
    iVar2 = AIWorld_ApxSplineDistance(carObj,0);
    if (iVar2 < 0) {
      iVar2 = -iVar2;
    }
    iVar3 = 0;
    if (0 < Cars_gNumCars) {
      ppCVar4 = Cars_gTotalSortedList;
      do {
        if (*ppCVar4 == carObj) break;
        iVar3 = iVar3 + 1;
        ppCVar4 = ppCVar4 + 1;
      } while (iVar3 < Cars_gNumCars);
    }
    if (iVar3 * 0x280000 <= iVar2) {
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
  return;
}

/* ---- AI_MaybeChangeLaneSlack__FP8Car_tObj  [@0x8005a8c0] ---- */
void AI_MaybeChangeLaneSlack(Car_tObj *carObj)
{
  int adaptedSlice;
  int range;
  u_int uVar2;

  adaptedSlice = carObj->carIndex * 2;
  if (0 <= adaptedSlice) {
    adaptedSlice = (carObj->N).simRoadInfo.slice + adaptedSlice;
    if (gNumSlices <= adaptedSlice) {
      adaptedSlice = adaptedSlice - gNumSlices;
    }
  }
  else {
    adaptedSlice = (carObj->N).simRoadInfo.slice + adaptedSlice;
    if (adaptedSlice < 0) {
      adaptedSlice = adaptedSlice + gNumSlices;
    }
  }
  uVar2 = carObj->carFlags;
  if ((((uVar2 & 4) == 0) && (((uVar2 & 8) == 0 || ((adaptedSlice >> 4) << 4 == adaptedSlice)))) &&
     (((uVar2 & 0x10) == 0 || ((adaptedSlice >> 1) << 1 == adaptedSlice)))) {
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
