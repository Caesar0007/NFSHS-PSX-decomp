/* game/common/aispeeds.cpp -- RECONSTRUCTED (NFS4 AI action/reaction scripting; 8 free AIScript_* fns).
 *   Player-action submission + reaction-table processing. SYM-v3 locals; vs disasm-v2.txt.
 *   NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "aispeeds_externs.h"

extern char *DAT_80116470;   /* @0x80116470 -- AI bigfile path prefix (char*); materialized (bss=0) in materialized_data.cpp */
extern int AI_elapsedTime;   /* @0x8013C554 (ai.cpp:15) -- AI frame elapsed-time global; used by GetCaravanFactor caravanTimer decrement (H35) */


/* ---- aispeeds.obj-owned globals (.bss zero) ---- */
AISpeeds_Upgrade_t engineUpgrade;   /* @0x8010dce0  (bss(zero)) */
AISpeeds_Upgrade_t suspensionUpgrade;   /* @0x8010dcf0  (bss(zero)) */
AISpeeds_Upgrade_t aeroUpgrade;   /* @0x8010dd00  (bss(zero)) */
speedData_t  Track2Speeds[9] = { {50u, 3982u}, {196u, 7395u}, {293u, 7395u}, {332u, 3982u}, {390u, 7395u}, {624u, 7395u}, {665u, 3982u}, {1026u, 7395u}, {10000u, 3982u} };   /* @0x8010dd10 */
speedData_t  Track3Speeds[3] = { {7u, 5688u}, {236u, 3555u}, {10000u, 5688u} };   /* @0x8010dd34 */
speedData_t  Track5Speeds[3] = { {369u, 7964u}, {674u, 5688u}, {10000u, 7964u} };   /* @0x8010dd40 */
speedData_t  Track6Speeds[5] = { {26u, 3555u}, {327u, 7111u}, {393u, 3555u}, {627u, 7111u}, {10000u, 3555u} };   /* @0x8010dd4c */
speedData_t  Track7Speeds[6] = { {29u, 5688u}, {429u, 7964u}, {617u, 7964u}, {655u, 5688u}, {823u, 7964u}, {10000u, 5688u} };   /* @0x8010dd60 */
extern speedData_t Track0Speeds[1], Track1Speeds[1], Track4Speeds[1], Track8Speeds[1], Track9Speeds[1], Track10Speeds[1];  /* defined below (sdata @0x8013c5b8+) */
speedData_t  *AISpeeds_TrackSpeeds[11] = {   /* @0x8010dd78 : image ptrs 0x8013c5b8/bc, 0x8010dd10/34, 0x8013c5c0, 0x8010dd40/4c/60, 0x8013c5c4/c8/cc — all resolve to the Track*Speeds symbols in order */
    Track0Speeds, Track1Speeds, Track2Speeds, Track3Speeds, Track4Speeds,
    Track5Speeds, Track6Speeds, Track7Speeds, Track8Speeds, Track9Speeds, Track10Speeds
};
AISpeeds_tLeaderBoard leaderBoard;   /* @0x8010dda4  (bss(zero)) */
AISpeeds_tSlotInfo CaravanInfo[6];   /* @0x8010ddb4  (bss(zero)) */
int          *AISpeeds_WeatherMultFactors;   /* @0x8013c5b0  (bss(zero)) */
int          AISpeeds_trackAndNightMult;   /* @0x8013c5b4  (bss(zero)) */
speedData_t  Track0Speeds[1] = { {10000u, 7395u} };   /* @0x8013c5b8 */
speedData_t  Track1Speeds[1] = { {10000u, 7395u} };   /* @0x8013c5bc */
speedData_t  Track4Speeds[1] = { {10000u, 5688u} };   /* @0x8013c5c0 */
speedData_t  Track8Speeds[1] = { {10000u, 11377u} };   /* @0x8013c5c4 */
speedData_t  Track9Speeds[1] = { {10000u, 11377u} };   /* @0x8013c5c8 */
speedData_t  Track10Speeds[1] = { {10000u, 11377u} };   /* @0x8013c5cc */


/* ---- intra-TU forward declarations ---- */
void AISpeeds_StartUp(void);
void AISpeeds_ReadTuningInfo(void);
void AISpeeds_CleanUp(void);
int AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars(Car_tObj *carObj);
int AISpeeds_CalcOpponentTopSpeed(Car_tObj *carObj,int *unFetteredDesiredSpeed);
int AISpeeds_NeedToSlowDownForCurve(Car_tObj *carObj,int distanceMeters,int currentSpeed,int futureCurveSpeed);
int AISpeeds_CalcOpponentCurveSpeed(Car_tObj *carObj);
int AISpeeds_BTCGetGlueFactor(Car_tObj *carObj);
Car_tObj * AISpeeds_GetNextAICar(Car_tObj *carObj);
Car_tObj * AISpeeds_GetPrevAICar(Car_tObj *carObj);
int AISpeeds_GetCaravanFactor(Car_tObj *carObj);
int AISpeeds_GetGlueFactor(Car_tObj *carObj);
int AISpeeds_GetDamageFactor(Car_tObj *carObj);
int AISpeeds_LimitGlueMultiplier(Car_tObj *carObj,int f_final);
int AISpeeds_CalcCopTopSpeed(Car_tObj *carObj);
int AISpeeds_CalcTrafficTopSpeed(Car_tObj *carObj);
int AISpeeds_GetLegalSpeed(int slice);
int AISpeeds_RandomizeTrafficSpeed(Car_tObj *carObj,int oldsafe);
void AISpeeds_CalcDesiredSpeed(Car_tObj *carObj);
int AISpeeds_CalculateOncomingCarSpeed(Car_tObj *carObj);
void AISpeeds_SetTrafficSpeedRandomFactor(Car_tObj *carObj);
void AISpeeds_MaintainLeaderBoard(void);
int AISpeeds_GetScriptFactor(Car_tObj *carObj);
int AISpeeds_GetUpgradeAccMult(int carIndex);
int AISpeeds_GetUpgradeBrakeMult(int carIndex);
int AISpeeds_GetUpgradeHandlingMult(int carIndex);
int AISpeeds_GetUpgradeTopSpeedMult(int carIndex);


/* ---- AISpeeds_StartUp__Fv  [@0x8006d5b4] ---- */
void AISpeeds_StartUp(void)
{
  AISpeeds_WeatherMultFactors =
       reservememadr("aiwther",0x104,0);
  AISpeeds_ReadTuningInfo();
  return;
}

/* ---- AISpeeds_ReadTuningInfo__Fv  [@0x8006d5ec] ---- */
void AISpeeds_ReadTuningInfo(void)
{
  char filename[110];
  Udff_tInfo *handle;
  int weatherRamp;
  int iVar1;
  u_int uVar2;
  /* H58 (coordinator-directed correctness fix, wave-22): iVar3 was `u_int`, which compiles the
   * loop-bound compare `iVar3 < 0x41` as `sltiu` (unsigned). The oracle @0x8006D820ish uses
   * `slti` (SIGNED) for this exact compare -- a real sign bug, not a coloring artifact: iVar3
   * only ever counts 0..0x40 here so the two forms happen to behave the same at runtime for
   * every value this loop actually reaches, but the emitted comparison instruction itself must
   * match the oracle's signed semantics to be a faithful reconstruction. Retyping to `int` fixes
   * the sltiu/slti instruction-choice bug and is kept even though it COSTS diff count (12->21):
   * this project's priority is correctness over byte-match, and the verify-or-revert rule has an
   * explicit carve-out for provable correctness fixes. The extra ~9 diffs are a downstream
   * register-coloring CASCADE elsewhere in this same function triggered by the type change, not
   * a symptom of the fix itself -- investigated (see side_by_side), did not find a tractable
   * source-level lever to recover them in the time available. */
  int iVar3;
  int iVar4;
  int *piVar5;
  int slotLoop;
  int carType;
  int humanCarIndex;

  sprintf(filename,"%stuning.bin",DAT_80116470);   /* H34: 3rd arg (path prefix) was omitted; oracle 0x8006D5FC $a2=*(int*)&DAT_80116470 */
  handle = Udff_Opena(filename,(char *)0x0,1);
  Udff_GetInt(handle);
  slotLoop = 0;
  while (true) {
    if (6 <= slotLoop) break;
    iVar1 = Udff_GetInt(handle);
    CaravanInfo[slotLoop].distanceMaintainTime32 = iVar1 << 5;
    iVar1 = Udff_GetInt(handle);
    CaravanInfo[slotLoop].minDistanceMeters = iVar1;
    iVar1 = Udff_GetInt(handle);
    CaravanInfo[slotLoop].maxDistanceMeters = iVar1;
    iVar1 = Udff_GetInt(handle);
    uVar2 = fixeddiv(0x10000,iVar1 << 0x15);
    CaravanInfo[slotLoop].fallBackRandomTime_TickPercent = uVar2;
    slotLoop = slotLoop + 1;
  }
  carType = 0;
  if ((GameSetup_gData.raceType == 0) && (0 < Cars_gNumAIRaceCars)) {
    int skillMult[3];
    humanCarIndex = *(*(int **)((char *)Cars_gAIRaceCarList[0] + 0x288));  /* @0x5D6C8 disasm-v2 */
    carType = 0;
    do {
      skillMult[0] = Udff_GetInt(handle);
      skillMult[1] = Udff_GetInt(handle);
      skillMult[2] = Udff_GetInt(handle);
      if (carType == humanCarIndex) {
        GameSetup_gData.tournamentMultiplier = skillMult[GameSetup_gData.skill];
      }
      carType = carType + 1;
    } while (carType < 0x16);
  }
  else {
    int carModelLoop;
    carModelLoop = 0;
    do {
      Udff_GetInt(handle);
      Udff_GetInt(handle);
      Udff_GetInt(handle);
      carModelLoop = carModelLoop + 1;
    } while (carModelLoop < 0x16);
  }
  AISpeeds_trackAndNightMult = 0;
  {
    int trackLoop;
    for (trackLoop = 0; trackLoop < 0xc; trackLoop = trackLoop + 1) {
      int trackMult;
      int nightMult;
      Udff_GetInt(handle);
      trackMult = Udff_GetInt(handle);
      nightMult = Udff_GetInt(handle);
      if (GameSetup_gData.Time == 0) {
        nightMult = 0x10000;
      }
      if (trackLoop == GameSetup_gData.track) {
        AISpeeds_trackAndNightMult = fixedmult(trackMult,nightMult);
      }
    }
  }
  weatherRamp = Udff_GetInt(handle);
  iVar3 = 0;
  iVar1 = 0;
  piVar5 = AISpeeds_WeatherMultFactors;
  do {
    iVar4 = iVar1;
    if (iVar1 < 0) {
      iVar4 = iVar1 + 0x3f;
    }
    *piVar5 = 0x10000 - (iVar4 >> 6);
    piVar5 = piVar5 + 1;
    iVar3 = iVar3 + 1;
    iVar1 = iVar1 + weatherRamp;
  } while (iVar3 < 0x41);
  Udff_GetBuffer(handle,(char *)&engineUpgrade,0x10);
  Udff_GetBuffer(handle,(char *)&suspensionUpgrade,0x10);
  Udff_GetBuffer(handle,(char *)&aeroUpgrade,0x10);
  Udff_Close(handle);
  return;
}

/* ---- AISpeeds_CleanUp__Fv  [@0x8006d870] ---- */
void AISpeeds_CleanUp(void)
{
  if (AISpeeds_WeatherMultFactors != (int *)0x0) {
    purgememadr(AISpeeds_WeatherMultFactors);
    AISpeeds_WeatherMultFactors = (int *)0x0;
  }
  return;
}

/* ---- AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars__FP8Car_tObj  [@0x8006d89c] ---- */
int AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars(Car_tObj *carObj)
{
  int leadIndex;
  int f_crappyFrameRateCompensatingSpeedup;
  leadIndex = Cars_gNumAIRaceCars - carObj->AISlot;   /* H41: compute EARLY (oracle: subu right after loading Cars_gNumAIRaceCars, before the guard) */
  if ((((1 < Cars_gNumAIRaceCars) && (GameSetup_gData.raceType != 1)) &&
      (simGlobal.gameTicks < 0x780)) &&
     ((Cars_gNumHumanRaceCars == 1 && ((*(u_short *)((char *)Cars_gHumanRaceCarList[0] + 6)) < (carObj->N).totalSlice)))) {
    return leadIndex * 0x3333 + 0x10000;
  }
  return 0x10000;
}

/* ---- AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi  [@0x8006d938] ---- */
int AISpeeds_CalcOpponentTopSpeed(Car_tObj *carObj,int *unFetteredDesiredSpeed)
{
  int topSpeed;
  int newDesired;
  int f_glue;
  int f_script;
  int f_nitrous;
  int f_final;
  int f_damage;
  int f_unfettered;
  int f_crappyFrameRateCompensatingSpeedup;
  int f_caravan;
  int metersPastFinish;
  int latLeft;
  int latRight;
  int totalSortIndex;
  int iVar2;
  int iVar4;
  int iVar5;
  Car_tObj **ppCVar6;
  int iVar7;

  topSpeed = AISpeeds_CalcOpponentCurveSpeed(carObj);
  if (carObj->fallBehindCar != (Car_tObj *)0x0) {
    f_glue = 0x10000;
  }
  else if (((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&
     ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||
      ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) {
    f_glue = AISpeeds_BTCGetGlueFactor(carObj);
  }
  else {
    f_glue = AISpeeds_GetGlueFactor(carObj);
  }
  f_script = AISpeeds_GetScriptFactor(carObj);
  f_nitrous = carObj->speedNitrous;
  f_damage = AISpeeds_GetDamageFactor(carObj);
  if ((GameSetup_gData.raceType == 1) || (Cars_gNumAIRaceCars < 2)) {
    f_caravan = 0x10000;
  }
  else {
    f_caravan = AISpeeds_GetCaravanFactor(carObj);
  }
  if (f_nitrous < 0) {
    f_nitrous = f_nitrous + 0xff;
  }
  iVar7 = AISpeeds_trackAndNightMult;
  if (AISpeeds_trackAndNightMult < 0) {
    iVar7 = AISpeeds_trackAndNightMult + 0xff;
  }
  if (f_caravan < 0) {
    f_caravan = f_caravan + 0xff;
  }
  iVar5 = GameSetup_gData.tournamentMultiplier;
  if (GameSetup_gData.tournamentMultiplier < 0) {
    iVar5 = GameSetup_gData.tournamentMultiplier + 0xff;
  }
  if (f_glue < 0) {
    f_glue = f_glue + 0xff;
  }
  f_glue = (iVar5 >> 8) * (f_glue >> 8);
  if (f_glue < 0) {
    f_glue = f_glue + 0xff;
  }
  f_glue = (f_caravan >> 8) * (f_glue >> 8);
  if (f_glue < 0) {
    f_glue = f_glue + 0xff;
  }
  f_glue = (iVar7 >> 8) * (f_glue >> 8);
  if (f_glue < 0) {
    f_glue = f_glue + 0xff;
  }
  f_glue = (f_nitrous >> 8) * (f_glue >> 8);
  f_unfettered = f_glue;
  if (f_glue < 0) {
    f_unfettered = f_glue + 0xff;
  }
  if (f_damage < 0) {
    f_damage = f_damage + 0xff;
  }
  if (f_script < 0) {
    f_script = f_script + 0xff;
  }
  f_final = (f_damage >> 8) * (f_script >> 8);
  if (f_final < 0) {
    f_final = f_final + 0xff;
  }
  f_final = (f_unfettered >> 8) * (f_final >> 8);
  if ((GameSetup_gData.raceType != 1) && ((carObj->N).totalSlice < 0x96)) {
    f_glue = fixedmult((0x10000 - f_glue) * (u_int)(carObj->N).totalSlice,0x1b4);
    f_glue = 0x10000 - f_glue;
    if ((carObj->N).totalSlice < 0x96) {
      f_final = fixedmult((0x10000 - f_final) * (u_int)(carObj->N).totalSlice,0x1b4);
      f_final = 0x10000 - f_final;
    }
  }
  f_crappyFrameRateCompensatingSpeedup = AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars(carObj);
  if (f_crappyFrameRateCompensatingSpeedup != 0x10000) {
    if (f_glue < 0) {
      f_glue = f_glue + 0xff;
    }
    if (f_crappyFrameRateCompensatingSpeedup < 0) {
      f_crappyFrameRateCompensatingSpeedup = f_crappyFrameRateCompensatingSpeedup + 0xff;
    }
    f_glue = (f_glue >> 8) * (f_crappyFrameRateCompensatingSpeedup >> 8);
    if (f_final < 0) {
      f_final = f_final + 0xff;
    }
    f_final = (f_final >> 8) * (f_crappyFrameRateCompensatingSpeedup >> 8);
  }
  f_final = AISpeeds_LimitGlueMultiplier(carObj,f_final);
  carObj->aiGlue = f_final;
  f_glue = AISpeeds_LimitGlueMultiplier(carObj,f_glue);
  if (carObj->aiGlue < 0x10001) {
    (carObj->N).gravityMult = 0x10000;
  }
  else {
    (carObj->N).gravityMult = carObj->aiGlue;
  }
  if (topSpeed < 0) {
    topSpeed = topSpeed + 0xff;
  }
  newDesired = carObj->aiGlue;
  if (newDesired < 0) {
    newDesired = newDesired + 0xff;
  }
  newDesired = (topSpeed >> 8) * (newDesired >> 8);
  if (f_glue < 0) {
    f_glue = f_glue + 0xff;
  }
  *unFetteredDesiredSpeed = (topSpeed >> 8) * (f_glue >> 8);
  if ((((carObj->carFlags & 1U) != 0) && ((carObj->stats).finishType == 2)) &&
     (((GameSetup_gData.raceType != 1 && (GameSetup_gData.raceType != 5)) ||
      ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) == 0 &&
       ((Cars_gNumHumanRaceCars != 2 || (((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) == 0)))))))) {
    metersPastFinish = AIWorld_ApxSplineDistance(carObj,0);
    totalSortIndex = 0;
    if (metersPastFinish < 0) {
      metersPastFinish = -metersPastFinish;
    }
    latRight = (carObj->N).dimension.x;
    latLeft = carObj->roadPosition - latRight;
    latRight = carObj->roadPosition + latRight;
    if (0 < Cars_gNumCars) {
      ppCVar6 = Cars_gTotalSortedList;
      do {
        if (*ppCVar6 == carObj) break;
        totalSortIndex = totalSortIndex + 1;
        ppCVar6 = ppCVar6 + 1;
      } while (totalSortIndex < Cars_gNumCars);
    }
    if (totalSortIndex * 0x280000 <= metersPastFinish) {
      iVar2 = (carObj->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices;
      totalSortIndex = -((u_int)*(u_char *)(iVar2 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar2 + 0x1d) >> 4));
      if (totalSortIndex <= latLeft) {
        iVar4 = (u_int)*(u_char *)(iVar2 + 0x1f) * 0x8000 * (*(u_char *)(iVar2 + 0x1d) & 0xf);
        if ((latLeft <= iVar4) && (totalSortIndex <= latRight)) {
          newDesired = 0;
          if (iVar4 < latRight) goto LAB_8006de40;
          if (metersPastFinish < 0x1900001) {
            newDesired = 0x11c71c;
            goto LAB_8006de40;
          }
        }
      }
      newDesired = 0;
    }
  }
LAB_8006de40:
  *unFetteredDesiredSpeed = *unFetteredDesiredSpeed * carObj->direction;
  return newDesired * carObj->direction;
}

/* ---- AISpeeds_NeedToSlowDownForCurve__FP8Car_tObjiii  [@0x8006de90] ---- */
int AISpeeds_NeedToSlowDownForCurve(Car_tObj *carObj,int distanceMeters,int currentSpeed,int futureCurveSpeed)
{
  int neededDistance;
  int futureSpeed;
  int speed;
  int sIndex;
  AIPhysic_BrakeInfo *pAVar2;
  int iVar3;
  int iVar4;

  if (futureCurveSpeed <= currentSpeed) {
    pAVar2 = carObj->brakeInfo;
    if (currentSpeed < 0) {
      currentSpeed = currentSpeed + 0xffff;
    }
    iVar3 = currentSpeed >> 0x10;
    if (iVar3 < 0) {
      iVar3 = -iVar3;
    }
    /* H48: the "clamp to deceleration_" step is NOT a separate pointer -- the oracle just clamps
     * the INDEX to 0x80 and reads pAVar2->brakeTable_[idx] uniformly for BOTH accesses (a
     * pointer-switch to &deceleration_ was one extra load-bearing register the oracle never has;
     * deceleration_ is laid out immediately after brakeTable_[127], so index 0x80 lands on the
     * same byte). */
    if (0x7f < iVar3) {
      iVar3 = 0x80;
    }
    iVar4 = (u_int)(u_char)pAVar2->brakeTable_[iVar3] * 0x20000;
    if (futureCurveSpeed < 0) {
      futureCurveSpeed = futureCurveSpeed + 0xffff;
    }
    futureCurveSpeed = futureCurveSpeed >> 0x10;
    if (futureCurveSpeed < 0) {
      futureCurveSpeed = -futureCurveSpeed;
    }
    if (0x7f < futureCurveSpeed) {
      futureCurveSpeed = 0x80;
    }
    iVar3 = iVar4 - (u_int)(u_char)pAVar2->brakeTable_[futureCurveSpeed] * 0x20000;
    return iVar3 + (iVar3 >> 3) < distanceMeters ^ 1;
  }
  return 0;
}

/* ---- AISpeeds_CalcOpponentCurveSpeed__FP8Car_tObj  [@0x8006df34] ---- */
int AISpeeds_CalcOpponentCurveSpeed(Car_tObj *carObj)
{
  int speedHere;
  int scanMetersDistanceInt;
  int scanSlice;
  int curve;
  int curveSpeed;
  int iVar1;

  /* H51: SYM ground truth (dumpsym_src/nfs4-f-v3.txt @0x8006df34) names speedHere/
   * scanMetersDistanceInt at function scope and scanSlice/curve/curveSpeed in the nested loop-body
   * block ($8006df74) -- the recon previously routed everything through anonymous currentSpeed/
   * iVar1/iVar2/iVar3, and critically REUSED one iVar2 for BOTH the slice-scan index AND the
   * curveSpeedTable result. Those are two SEPARATE named locals (scanSlice vs curveSpeed) with
   * different live ranges (curveSpeed alone survives across the NeedToSlowDownForCurve call as its
   * arg) -- collapsing them into one variable forced them into the same register. */
  scanMetersDistanceInt = 200;
  speedHere = carObj->currentSpeed;
  if (speedHere < 0) {
    speedHere = -speedHere;
  }
  while( true ) {
    if (scanMetersDistanceInt < 0) {
      return 0;
    }
    scanSlice = (scanMetersDistanceInt / 6) * carObj->direction;
    if (scanSlice < 0) {
      scanSlice = (carObj->N).simRoadInfo.slice + scanSlice;
      if (scanSlice < 0) {
        scanSlice = scanSlice + gNumSlices;
      }
    }
    else {
      scanSlice = (carObj->N).simRoadInfo.slice + scanSlice;
      if (gNumSlices <= scanSlice) {
        scanSlice = scanSlice - gNumSlices;
      }
    }
    curve = AIDataRecord_TrackCurve->Get(scanSlice);
    curveSpeed = (carObj->curveSpeedTable)->Get(curve);
    if (GameSetup_gData.Weather != 0) {
      if (curve < 0) {
        curve = curve + 3;
      }
      curveSpeed = fixedmult(curveSpeed,AISpeeds_WeatherMultFactors[curve >> 2]);
    }
    if (scanMetersDistanceInt == 0) break;
    iVar1 = AISpeeds_NeedToSlowDownForCurve(carObj,scanMetersDistanceInt << 0x10,speedHere,curveSpeed)
    ;
    scanMetersDistanceInt = scanMetersDistanceInt + -0x19;
    if (iVar1 != 0) {
      return curveSpeed;
    }
  }
  return curveSpeed;
}

/* ---- AISpeeds_BTCGetGlueFactor__FP8Car_tObj  [@0x8006e09c] ---- */
int AISpeeds_BTCGetGlueFactor(Car_tObj *carObj)
{
  int closestHumanDistance;
  Car_tObj *closestHumanCarObj;
  int glueIndex;
  int glue;
  int iVar2;
  int iVar3;

  closestHumanDistance = 0x270f0000;
  closestHumanCarObj = (Car_tObj *)0x0;
  if ((carObj->carFlags & 0x20U) == 0) {
    /* H44 (wave-21, same class as GetPrevAICar's H43): the SYM has NO pointer-walk local here
     * (no ppCVarN entry) -- the oracle's $s1-incrementing walk over Cars_gHumanRaceCarList is
     * pure gcc strength-reduction from real array indexing. A hand-rolled pointer local forces
     * the walk into a NAMED register, backwards vs the oracle's synthetic-pointer/named-counter
     * split (§3.12 #1). Also: humanLoop/copCar/longMetersBetween are SYM-BLOCK-SCOPED (nested
     * blocks @0x8006e0d8/0x8006e0e4/0x8006e118), not function-scope -- reproduced as nested
     * declarations (SYM block scopes are load-bearing for gcc-2.8 pseudo-numbering). */
    int humanLoop;
    for (humanLoop = 0; humanLoop < Cars_gNumHumanRaceCars; humanLoop = humanLoop + 1) {
      Car_tObj *copCar;
      copCar = Cars_gHumanRaceCarList[humanLoop];
      if ((copCar->carFlags & 0x200U) != 0) {
        int longMetersBetween;
        longMetersBetween = AIWorld_ApxSplineDistance(carObj,copCar);
        iVar2 = longMetersBetween;
        if (longMetersBetween < 0) {
          iVar2 = -longMetersBetween;
        }
        iVar3 = closestHumanDistance;
        if (closestHumanDistance < 0) {
          iVar3 = -closestHumanDistance;
        }
        if (iVar2 < iVar3) {
          closestHumanDistance = longMetersBetween;
          closestHumanCarObj = copCar;
        }
      }
    }
    /* H57: the oracle computes closestHumanDistance*carObj->direction EARLY (scheduled into the
     * RSControl-check's delay slot), regardless of whether the early-return is taken -- a
     * dead-on-one-path speculative computation. Materializing it here (source-level) instead of
     * inline inside the later `/0x3c0000+10` expression reproduces that scheduling. */
    closestHumanDistance = closestHumanDistance * carObj->direction;
    if (closestHumanCarObj->RSControl != 0) {
      return 0x10000;
    }
    if (0x13fffe < closestHumanCarObj->currentSpeed + 0x9ffffU) {
      closestHumanDistance = closestHumanDistance / 0x3c0000 + 10;
      if (closestHumanDistance < 0) {
        glueIndex = 0;
      }
      else {
        glueIndex = 0x14;
        if (closestHumanDistance < 0x15) {
          glueIndex = closestHumanDistance;
        }
      }
      glue = AIPerson_glueTable[glueIndex];
      if (glue < 0x10000) {
        glue = fixedmult(0x10000 - glue,carObj->btcGlueModifier);
        glue = 0x10000 - glue;
      }
      if (glue < 0x6666) {
        glue = 0x6666;
      }
      glue = fixedmult(glue,carObj->speedFactor);
      return glue;
    }
  }
  return 0x10000;
}

/* ---- AISpeeds_GetNextAICar__FP8Car_tObj  [@0x8006e258] ---- */
Car_tObj * AISpeeds_GetNextAICar(Car_tObj *carObj)
{
  return carObj->nextAIRacer;
}

/* ---- AISpeeds_GetPrevAICar__FP8Car_tObj  [@0x8006e264] ---- */
Car_tObj * AISpeeds_GetPrevAICar(Car_tObj *carObj)
{
  /* H43: SYM-wired locals (prevCar $a3, testCar $v1, carLoop $a1 -- confirmed via
   * dumpsym_src/nfs4-f-v3.txt @0x8006e264 Block-start REG entries). The recon previously ran
   * through anonymous pCVar1/iVar2/ppCVar3/pCVar4 temps with a HAND-ROLLED pointer-walk
   * (ppCVar3++), which forced the walk pointer into $a1 and the real named counter into $a2 --
   * backwards vs the oracle. Real source used plain ARRAY INDEXING
   * (`Cars_gTotalSortedList[carLoop]`); gcc's own strength-reduction turns that into the
   * pointer-increment codegen the oracle shows, leaving the SYNTHETIC stride pointer to soak up
   * $a2 and the real named `carLoop` to keep $a1 (§3.12 #1 index-form vs pointer-walk). */
  Car_tObj *prevCar;
  Car_tObj *testCar;
  int zeroTrip;   /* H43b (PERMUTER, score 0 @iter353): a SEPARATE fresh-zero temp feeds the
                   * entry guard test AND initializes carLoop -- reusing carLoop directly for
                   * both the guard and the loop counter colors the a1/a2 pair backwards vs the
                   * oracle. Transcribed verbatim (decl scope/order load-bearing, §3.12 #15). */
  int carLoop;

  zeroTrip = 0;
  prevCar = (Car_tObj *)0x0;
  carLoop = zeroTrip;
  if (zeroTrip < Cars_gNumCars) {
    do {
      testCar = Cars_gTotalSortedList[carLoop];
      if (carObj == testCar) {
        return prevCar;
      }
      if ((testCar->carFlags & 8U) != 0) {
        prevCar = testCar;
      }
      carLoop = carLoop + 1;
    } while (carLoop < Cars_gNumCars);
  }
  return (Car_tObj *)0x0;
}

/* ---- AISpeeds_GetCaravanFactor__FP8Car_tObj  [@0x8006e2d0] ---- */
int AISpeeds_GetCaravanFactor(Car_tObj *carObj)
{
  Car_tObj*nextAICar;
  int f_caravan;
  u_int tempRandom;
  Car_tObj*prevAICar;
  Car_tObj *pCVar1;
  int desiredSpeedScaled;
  int desiredSpeedProduct;
  int followBehindDist;
  int halfMaintainTime;
  u_int slot;   /* SYM name: slot */

  slot = carObj->AISlot;
  nextAICar = AISpeeds_GetNextAICar(carObj);
  if (carObj->fallBehindCar != (Car_tObj *)0x0) {
    f_caravan = 0xe666;
    if (carObj->fallBehindCar->AISlot < (int)slot) {
      carObj->fallBehindCar = (Car_tObj *)0x0;
    }
    goto LAB_8006e444;
  }
  if (nextAICar != (Car_tObj *)0x0) {
    pCVar1 = nextAICar->fallBehindCar;
    if (pCVar1 == (Car_tObj *)0x0) {
      if (0xd6491 < nextAICar->speed) {
        /* H37 (wave-21 fix): this threshold scratch was aliased onto f_caravan (the
         * function's f_caravan/return-value accumulator, oracle $s3) -- but the oracle
         * keeps $s3 UNTOUCHED through this whole straight-line block (pure a0/a1/v0/v1
         * temps), so the aliasing was a register-identity bug that force-extended
         * f_caravan's live range and cascaded a whole-function coloring mismatch. */
        desiredSpeedScaled = nextAICar->originalDesiredSpeed * carObj->direction;
        desiredSpeedProduct = nextAICar->desiredSpeed * carObj->direction;
        if (desiredSpeedScaled < 0) {
          desiredSpeedScaled = desiredSpeedScaled + 0xff;
        }
        if ((desiredSpeedScaled >> 8) * 0xb3 <= desiredSpeedProduct) {
          /* H38 (wave-21 fix): the oracle reaches the odometer block via a FORWARD BRANCH
           * (beqz ...,.L8006E3C8) placed OUT OF LINE, with the reload merge code as the
           * straight-line fallthrough (the odometer block is much bigger -- 2 calls + more
           * branches -- and gcc-2.8 pushes it out; a plain nested-if put it inline instead,
           * flipping which side is the branch target). Transcribed as an explicit guard +
           * out-of-line label to reproduce the oracle's block order 1:1. */
          goto LAB_8006e3c8;
        }
      }
      goto LAB_8006e3b0;
    }
  }
  else {
LAB_8006e3b0:
    pCVar1 = nextAICar->fallBehindCar;
  }
  f_caravan = 0x10000;
  if (pCVar1 == carObj) {
    f_caravan = 0x11999;
  }
  goto LAB_8006e444;
LAB_8006e3c8:
  {
    int leaderIsThisManyMetersAhead;   /* SYM name, block-scoped @0x8006e3c8 line=61 */
    leaderIsThisManyMetersAhead = AIWorld_GameOdometer(nextAICar) - AIWorld_GameOdometer(carObj);
    followBehindDist = carObj->caravanFollowBehindDistanceMeters;
    if (followBehindDist + 0xa0000 < leaderIsThisManyMetersAhead) {
      f_caravan = 0x13333;
      if (followBehindDist + 0x3e80000 < leaderIsThisManyMetersAhead) {
        f_caravan = 0x18000;
      }
    }
    else if (leaderIsThisManyMetersAhead < followBehindDist + -0xa0000) {
      f_caravan = 0xcccc;
      if (leaderIsThisManyMetersAhead < followBehindDist + -0x3e80000) {
        f_caravan = 0x9999;
      }
    }
    else {
      f_caravan = 0x10000;
    }
  }
LAB_8006e444:
  if (CaravanInfo[slot].distanceMaintainTime32 != 0) {
    carObj->caravanTimer = carObj->caravanTimer - AI_elapsedTime;
  }
  if (carObj->caravanTimer < 0) {
    halfMaintainTime = CaravanInfo[slot].distanceMaintainTime32 / 2;
    randtemp = (fastRandom * randSeed & 0xffff) * randSeed;
    carObj->caravanTimer = halfMaintainTime + (halfMaintainTime * ((fastRandom * randSeed & 0xffff00) >> 8) >> 0x10);
    fastRandom = randtemp & 0xffff;
    carObj->caravanFollowBehindDistanceMeters =
         (CaravanInfo[slot].minDistanceMeters +
         ((CaravanInfo[slot].maxDistanceMeters - CaravanInfo[slot].minDistanceMeters) *
          ((randtemp & 0xffff00) >> 8) >> 0x10)) * 0x10000;
  }
  if (((((int)slot < Cars_gNumAIRaceCars + -1) && (carObj->fallBehindCar == (Car_tObj *)0x0)) &&
      ((int)(u_int)(carObj->N).totalSlice < GameSetup_gData.numLaps * gNumSlices + -0x14d)) &&
     ((1 < slot || (leaderBoard.leadRacer != (Car_tObj *)0x0)))) {
    /* H36 (wave-21 real bug): oracle @0x8006e5b4-0x8006e638 continues past the fastRandom
     * re-seed with a stochastic "pick up a fall-behind car" roll gated by
     * CaravanInfo[slot].fallBackRandomTime_TickPercent * AI_elapsedTime, then calls
     * AISpeeds_GetPrevAICar and (if found) writes it into carObj->fallBehindCar. This whole
     * tail was previously dropped -- carObj->fallBehindCar could never be (re)acquired via
     * this path, a real gameplay bug (SYM locals tempRandom/prevAICar, block lines 133-142). */
    tempRandom = fastRandom * randSeed;
    randtemp = tempRandom;
    fastRandom = tempRandom & 0xffff;
    tempRandom = (tempRandom >> 8) & 0xffff;
    if ((nextAICar == (Car_tObj *)0x0) || (nextAICar->fallBehindCar == (Car_tObj *)0x0)) {
      if (tempRandom < CaravanInfo[slot].fallBackRandomTime_TickPercent * (u_int)AI_elapsedTime) {
        prevAICar = AISpeeds_GetPrevAICar(carObj);
        if (prevAICar != (Car_tObj *)0x0) {
          carObj->fallBehindCar = prevAICar;
        }
      }
    }
  }
  if (((nextAICar != (Car_tObj *)0x0) && (nextAICar->damageMult < carObj->damageMult + -0x1999)) &&
     (nextAICar->fallBehindCar == (Car_tObj *)0x0)) {
    nextAICar->fallBehindCar = carObj;
  }
  return f_caravan;
}

/* ---- AISpeeds_GetGlueFactor__FP8Car_tObj  [@0x8006e68c] ---- */
int AISpeeds_GetGlueFactor(Car_tObj *carObj)
{
  int leadHumanRacerOdometer;
  int leadAIRacerOdometer;
  int lastAIRacerOdometer;
  int glue;
  int leadSpeed;
  int packPositionGlueModifier;
  int distance;
  int glueIndex;

  packPositionGlueModifier = 0x10000;
  leadHumanRacerOdometer = AIWorld_GameOdometer(leaderBoard.leadHumanRacer);
  leadAIRacerOdometer = AIWorld_GameOdometer(leaderBoard.leadAIRacer);
  lastAIRacerOdometer = AIWorld_GameOdometer(leaderBoard.lastAIRacer);
  leadSpeed = (leaderBoard.leadHumanRacer)->currentSpeed;
  if (leadSpeed < 0) {
    leadSpeed = -leadSpeed;
  }
  if (leadSpeed < 0xa0000) {
    glue = 0x10000;
    goto LAB_8006e818;
  }
  if (leadHumanRacerOdometer < lastAIRacerOdometer) {
    distance = (leadAIRacerOdometer - leadHumanRacerOdometer) / 0x3c0000 + 10;
    if (distance < 0) {
      glueIndex = 0;
    }
    else {
LAB_8006e77c:
      glueIndex = 0x14;
      if (distance < 0x15) {
        glueIndex = distance;
      }
    }
  }
  else {
    if (leadHumanRacerOdometer <= leadAIRacerOdometer) {
      distance = (leadAIRacerOdometer - leadHumanRacerOdometer) / 0x3c0000 + 10;
      if (distance < 0) {
        glueIndex = 0;
      }
      else {
        glueIndex = 0x14;
        if (distance < 0x15) {
          glueIndex = distance;
        }
      }
      glue = AIPerson_glueTable[glueIndex];
      packPositionGlueModifier = 0x8000;
      if (GameSetup_gData.raceType != 3) {
        packPositionGlueModifier = 0xe666;
      }
      goto LAB_8006e818;
    }
    distance = (leadAIRacerOdometer - leadHumanRacerOdometer) / 0x3c0000 + 10;
    if (-1 < distance) goto LAB_8006e77c;
    glueIndex = 0;
  }
  glue = AIPerson_glueTable[glueIndex];
  packPositionGlueModifier = 0x10000;
LAB_8006e818:
  leadAIRacerOdometer = AIWorld_GameOdometer(carObj);
  if ((leadAIRacerOdometer < leadHumanRacerOdometer + 0x3c0000) && (glue < 0x10000)) {
    glue = 0x10000;
  }
  if (glue < 0x10001) {
    glue = fixedmult(0x10000 - glue,packPositionGlueModifier);
    glue = -glue;
  }
  else {
    glue = fixedmult(glue + -0x10000,packPositionGlueModifier);
  }
  return glue + 0x10000;
}

/* ---- AISpeeds_GetDamageFactor__FP8Car_tObj  [@0x8006e898] ---- */
int AISpeeds_GetDamageFactor(Car_tObj *carObj)
{
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  
  carObj->damageMult = 0;   /* H45: plain sequential sum, no pre-loaded temps -- the oracle's
                             * odd dmg0,dmg1,dmg3-early,dmg2 load order + interleaved
                             * damageMult=0 store is pure DELAY-SLOT SCHEDULING of a single
                             * straight-line `d0+d1+d2+...+d7` expression, not a source hint. */
  iVar1 = (carObj->N).damage[0] + (carObj->N).damage[1] + (carObj->N).damage[2] +
          (carObj->N).damage[3] + (carObj->N).damage[4] + (carObj->N).damage[5] +
          (carObj->N).damage[6] + (carObj->N).damage[7];
  carObj->damageMult = iVar1;
  if (((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&
     ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||
      ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) {
    iVar2 = 0x147;
  }
  else {
    iVar1 = carObj->damageMult;
    iVar2 = 0x48;
  }
  iVar1 = fixedmult(iVar1,iVar2);
  carObj->damageMult = iVar1;
  /* H45b: `volatile` CODEGEN DEVICE (cf. H40) -- oracle genuinely reloads damageMult from memory
   * here (`sw`, then a fresh `lw`) instead of reusing the just-stored fixedmult result register;
   * a plain field re-read gets CSE'd back to iVar1 with no intervening call/aliasing hazard. */
  iVar4 = 0x10000 - *(volatile int *)&carObj->damageMult;
  carObj->damageMult = iVar4;
  iVar1 = 0x8000;
  if (0x7fff < iVar4) {
    iVar1 = iVar4;
  }
  carObj->damageMult = iVar1;
  return iVar1;
}

/* ---- AISpeeds_LimitGlueMultiplier__FP8Car_tObji  [@0x8006e9b0] ---- */
int AISpeeds_LimitGlueMultiplier(Car_tObj *carObj,int f_final)
{
  int bestDistanceAbsMeters;
  int playerLoop;
  int thisDistanceAbsMeters;
  int iVar1;
  Car_tObj **ppCVar2;
  int iVar3;
  int iVar4;
  
  if (0xcccb < f_final - 0x999aU) {
    iVar4 = 0x27100000;
    ppCVar2 = Cars_gHumanRaceCarList;
    for (iVar3 = 0; iVar3 < Cars_gNumHumanRaceCars; iVar3 = iVar3 + 1) {
      iVar1 = AIWorld_ApxSplineDistance(carObj,*ppCVar2);
      if (iVar1 < 0) {
        iVar1 = -iVar1;
      }
      if (iVar1 < iVar4) {
        iVar4 = iVar1;
      }
      ppCVar2 = ppCVar2 + 1;
    }
    if (iVar4 < 0x780001) {
      if (0x16666 < f_final) {
        f_final = 0x16666;
      }
      if (f_final < 0x9999) {
        f_final = 0x9999;
      }
    }
  }
  return f_final;
}

/* ---- AISpeeds_CalcCopTopSpeed__FP8Car_tObj  [@0x8006eaa4] ---- */
int AISpeeds_CalcCopTopSpeed(Car_tObj *carObj)
{
  int topSpeed;
  int newDesired;
  int f_nitrous;
  int iVar1;
  int iVar2;
  int iVar3;
  
  iVar1 = AISpeeds_CalcOpponentCurveSpeed(carObj);
  iVar3 = carObj->copTopSpeed;
  if (iVar1 < carObj->copTopSpeed) {
    iVar3 = iVar1;
  }
  iVar2 = carObj->speedNitrous;
  iVar1 = AISpeeds_trackAndNightMult;
  if (AISpeeds_trackAndNightMult < 0) {
    iVar1 = AISpeeds_trackAndNightMult + 0xff;
  }
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar1 = (iVar1 >> 8) * (iVar2 >> 8);
  carObj->aiGlue = iVar1;
  if (0x10000 < iVar1) {
    (carObj->N).gravityMult = iVar1;
  }
  else {
    (carObj->N).gravityMult = 0x10000;
  }
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar1 = carObj->aiGlue;
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  return (iVar3 >> 8) * (iVar1 >> 8) * carObj->direction;
}

/* ---- AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj  [@0x8006eb6c] ---- */
int AISpeeds_CalcTrafficTopSpeed(Car_tObj *carObj)
{
  /* H56: SYM names the single local "desired" ($s0) -- was routed through an anonymous iVar1
   * while desired sat declared-but-unused. */
  int desired;
  int iVar2;
  u_int uVar3;

  desired = AISpeeds_GetLegalSpeed((int)(carObj->N).simRoadInfo.slice);
  desired = fixedmult(desired,0xc000);
  if (((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&
     ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||
      ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) {
    if (carObj->direction == (*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x554))) goto LAB_8006ec80;
    iVar2 = AISpeeds_CalculateOncomingCarSpeed(carObj);
  }
  else {
    uVar3 = ~carObj->direction;
    if (GameSetup_gData.reverseTrack == 0) {
      uVar3 = carObj->direction ^ 1;
    }
    if (uVar3 == 0) goto LAB_8006ec80;
    iVar2 = AISpeeds_CalculateOncomingCarSpeed(carObj);
  }
  if (iVar2 <= desired) {
    desired = AISpeeds_CalculateOncomingCarSpeed(carObj);
  }
LAB_8006ec80:
  if ((carObj->carFlags & 0x10U) != 0) {
    desired = AISpeeds_RandomizeTrafficSpeed(carObj,desired);
    if (desired < 0) {
      desired = desired + 0xff;
    }
    iVar2 = carObj->speedFactor;
    if (iVar2 < 0) {
      iVar2 = iVar2 + 0xff;
    }
    desired = (desired >> 8) * (iVar2 >> 8);
  }
  if (desired < 0x8e38e) {
    desired = 0x8e38e;
  }
  return desired * carObj->direction;
}

/* ---- AISpeeds_GetLegalSpeed__Fi  [@0x8006ed0c] ---- */
int AISpeeds_GetLegalSpeed(int slice)
{
  speedData_t *speedData;   /* SYM-v3: single REG local 'speedData_t *speedData' -- no separate scratch */

  speedData = AISpeeds_TrackSpeeds[GameSetup_gData.track];
  do {
  } while (speedData++->endSlice < slice);
  speedData = speedData - 1;
  /* H40: `volatile` here is a CODEGEN DEVICE, not a semantic hardware/IRQ property (cf. the "^ zero"
   * runtime-zero idiom, §3.13) -- gcc otherwise re-associates the "-1" pointer correction straight
   * into this load's displacement (lhu v0,-2(v1), 1 insn) instead of emitting the oracle's genuine
   * `addiu v1,v1,-4` decrement + `lhu v0,2(v1)` (2 insns). DO NOT "clean up" by dropping the cast --
   * it silently regresses this fn to a 3-diff near-miss. */
  return (u_int)((volatile speedData_t *)speedData)->speedMPS << 8;
}

/* ---- AISpeeds_RandomizeTrafficSpeed__FP8Car_tObji  [@0x8006ed50] ---- */
int AISpeeds_RandomizeTrafficSpeed(Car_tObj *carObj,int oldsafe)
{
  /* H55: SYM names newsafe ($a1) and safeminus30 ($v1) -- was routed through an anonymous
   * iVar1, and safeminus30 was never materialized as its own variable (the raw oracle computes
   * `oldsafe + -0xd6666` ONCE, in the branch-entry delay slot, well before the comparison that
   * uses it -- not inline at each of the two use sites). */
  int newsafe;
  int safeminus30;

  if (0 < oldsafe) {
    safeminus30 = oldsafe + -0xd6666;
    newsafe = carObj->trafficSpeedRandomizingFactor;
    if (newsafe < 0) {
      newsafe = newsafe + 0xff;
    }
    newsafe = (oldsafe >> 8) * (newsafe >> 8);
    if (newsafe < safeminus30) {
      newsafe = safeminus30;
    }
    if (newsafe < 0x8e666) {
      newsafe = 0x8e666;
    }
  }
  else {
    if (oldsafe < 0) {
      oldsafe = oldsafe + 0xff;
    }
    newsafe = carObj->trafficSpeedRandomizingFactor;
    if (newsafe < 0) {
      newsafe = newsafe + 0xff;
    }
    newsafe = (oldsafe >> 8) * (newsafe >> 8);
  }
  return newsafe;
}

/* ---- AISpeeds_CalcDesiredSpeed__FP8Car_tObj  [@0x8006eddc] ---- */
void AISpeeds_CalcDesiredSpeed(Car_tObj *carObj)
{
  int iVar1;
  u_int uVar2;
  
  uVar2 = carObj->carFlags;
  carObj->desiredSpeed = 0;
  if ((uVar2 & 8) != 0) {   /* H44: if/else ARM ORDER controls beqz/bnez polarity -- oracle's
                             * `beqz` skips straight to the Opponent-case block (this is the
                             * FALL-THROUGH/true arm, not the else); the previous `==0`-first
                             * form emitted the inverted `bnez`. */
    iVar1 = AISpeeds_CalcOpponentTopSpeed(carObj,&carObj->originalDesiredSpeed);
    carObj->desiredSpeed = iVar1;
  }
  else if ((uVar2 & 0x20) != 0) {   /* H44 (cont.): same arm-order/polarity fix at the 2nd level */
    if ((carObj->AIFlags & 2U) != 0) {   /* Cop is the fall-through arm (oracle beqz-skips-to-Traffic) */
      iVar1 = AISpeeds_CalcCopTopSpeed(carObj);
      carObj->desiredSpeed = iVar1;
    }
    else {
      iVar1 = AISpeeds_CalcTrafficTopSpeed(carObj);
      carObj->desiredSpeed = iVar1;
    }
    carObj->originalDesiredSpeed = carObj->desiredSpeed;
  }
  else {
    if ((uVar2 & 0x10) != 0) {
      iVar1 = AISpeeds_CalcTrafficTopSpeed(carObj);
      carObj->desiredSpeed = iVar1;
      carObj->originalDesiredSpeed = iVar1;
    }
  }
  return;
}

/* ---- AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj  [@0x8006ee80] ---- */
int AISpeeds_CalculateOncomingCarSpeed(Car_tObj *carObj)
{
  /* H54: SYM names the single local playerSpeed (reg $a0) -- was routed through an anonymous
   * iVar1 while playerSpeed sat declared-but-unused. (Tried collapsing the four threshold
   * `return CONST;` arms into a single-exit if/elseif chain to match the oracle's one shared
   * epilogue -- measured WORSE (65->72 diffs), reverted; the multi-return shape below is closer.) */
  int playerSpeed;
  u_int uVar2;

  playerSpeed = carObj->basisCar->currentSpeed;
  if (playerSpeed < 0) {
    playerSpeed = -playerSpeed;
  }
  if (playerSpeed < 0xd5555) {
    uVar2 = 0x160000;
  }
  else {
    if (playerSpeed < 0x1aaaaa) {
      return 0xd5555;
    }
    if (playerSpeed < 0x280000) {
      return 0x8e38e;
    }
    if (playerSpeed < 0x378e38) {
      return 0x471c7;
    }
    if (0x471c70 < playerSpeed) {
      return 0x2c51e;
    }
    uVar2 = 0x20000;
  }
  return uVar2 | 0x38e3;
}

/* ---- AISpeeds_SetTrafficSpeedRandomFactor__FP8Car_tObj  [@0x8006ef28] ---- */
void AISpeeds_SetTrafficSpeedRandomFactor(Car_tObj *carObj)
{
  /* H53: SYM (nfs4-f-v3.txt @0x8006ef28, fsize=16) names exactly ONE 4-int array,
   * randomSpeedMultipliers -- the recon had a DUPLICATE unused array (dead, same bug class as
   * the "duplicate 112-byte Ghidra buffer" documented elsewhere in this file) inflating the
   * frame to 32 bytes. Removed the dead twin. The oracle ALSO loads the 4 constants from a
   * static .rodata template (D_800554E0) and copies them onto the stack -- an aggregate
   * initializer list reproduces that "template + copy" codegen; 4 separate assignment
   * statements do not. */
  int randomSpeedMultipliers[4] = {0x10000, 0xe666, 0xcccc, 0xb333};

  randtemp = randSeed * fastRandom;
  carObj->trafficSpeedRandomizingFactor = *(int *)((int)randomSpeedMultipliers + (randtemp >> 6 & 0xc));
  fastRandom = randtemp & 0xffff;
  return;
}

/* ---- AISpeeds_MaintainLeaderBoard__Fv  [@0x8006efa4] ---- */
void AISpeeds_MaintainLeaderBoard(void)
{
  /* H52: SYM ground truth (nfs4-f-v3.txt @0x8006efa4, mask=0 -- NO callee-saved regs at all)
   * names exactly 4 locals: slot=$a3, lastAI=$t0, carLoop=$a1, test=$a0. The recon routed
   * everything through anonymous iVar3/iVar4/ppCVar1/pCVar2/pCVar5 and a HAND-ROLLED
   * pointer-walk (ppCVar1) over Cars_gTotalSortedList instead of plain index-form array access
   * -- same index-vs-pointer-walk duality lever as GetPrevAICar/BTCGetGlueFactor elsewhere in
   * this file: gcc's own strength reduction produces the oracle's decrementing pointer AND
   * keeps the plain index (carLoop) alive for the loop-continue test. */
  int slot;
  Car_tObj *lastAI;
  int carLoop;
  Car_tObj *test;

  slot = 0;
  lastAI = (Car_tObj *)0x0;
  leaderBoard.leadRacer = (Car_tObj *)0x0;
  leaderBoard.leadHumanRacer = (Car_tObj *)0x0;
  leaderBoard.leadAIRacer = (Car_tObj *)0x0;
  leaderBoard.lastAIRacer = (Car_tObj *)0x0;
  for (carLoop = Cars_gNumCars - 1; -1 < carLoop; carLoop = carLoop - 1) {
    test = Cars_gTotalSortedList[carLoop];
    if ((((test->carFlags & 1U) != 0) && (leaderBoard.leadRacer == (Car_tObj *)0x0)) &&
       (test->fallBehindCar == (Car_tObj *)0x0)) {
      leaderBoard.leadRacer = test;
    }
    if ((test->carFlags & 8U) != 0) {
      test->nextAIRacer = lastAI;
      lastAI = test;
      test->AISlot = slot;
      if (leaderBoard.leadAIRacer == (Car_tObj *)0x0) {
        leaderBoard.leadAIRacer = test;
      }
      slot = slot + 1;
      leaderBoard.lastAIRacer = test;
    }
    if (((test->carFlags & 4U) != 0) && (leaderBoard.leadHumanRacer == (Car_tObj *)0x0)) {
      leaderBoard.leadHumanRacer = test;
    }
  }
  return;
}

/* ---- AISpeeds_GetScriptFactor__FP8Car_tObj  [@0x8006f0a4] ---- */
int AISpeeds_GetScriptFactor(Car_tObj *carObj)
{
  AIScript_t *scriptPtr;   /* H42: explicit &carObj->script local (was inlined at both call sites) --
                             * pins the base pointer to $s0 ahead of iVar1's call-result cache in $s1,
                             * matching the oracle's saved-reg roles. */
  int iVar1;
  int iVar2;
  scriptPtr = &carObj->script;
  iVar1 = AIScript_DoReAction(scriptPtr,4);
  if (iVar1 != -1) {
    return 0x18000;
  }
  iVar2 = AIScript_DoReAction(scriptPtr,0x10);
  if (iVar2 != iVar1) {
    return 0x8000;
  }
  return 0x10000;
}

/* ---- AISpeeds_GetUpgradeAccMult__Fi  [@0x8006f10c] ---- */
int AISpeeds_GetUpgradeAccMult(int carIndex)
{
  Car_tObj*carObj;
  int accMult;
  int a;
  Car_tObj *pCVar1;

  pCVar1 = Cars_gList[carIndex];
  a = 0x10000;
  if (pCVar1->carInfo->EngineMods == 1) {
    a = fixedmult(0x10000,engineUpgrade.accMult);   /* @0x8006F150 $a1=*(&engineUpgrade)[+0]=accMult (H36) */
  }
  if (pCVar1->carInfo->WeightTransfer == 1) {
    a = fixedmult(a,suspensionUpgrade.accMult);   /* @0x8006F178 $a1=*(&suspensionUpgrade)[+0] */
  }
  if (pCVar1->carInfo->GroundEffects == 1) {
    a = fixedmult(a,aeroUpgrade.accMult);   /* @0x8006F1A0 $a1=*(&aeroUpgrade)[+0] */
  }
  return a;
}

/* ---- AISpeeds_GetUpgradeBrakeMult__Fi  [@0x8006f1c8] ---- */
int AISpeeds_GetUpgradeBrakeMult(int carIndex)
{
  Car_tObj*carObj;
  int brakeMult;
  int a;
  Car_tObj *pCVar1;

  pCVar1 = Cars_gList[carIndex];
  a = 0x10000;
  if (pCVar1->carInfo->EngineMods == 1) {
    a = fixedmult(0x10000,engineUpgrade.brakeMult);   /* @0x8006F20C $a1=*(&lbl_8010DCE4)=engineUpgrade[+4]=brakeMult (H37) */
  }
  if (pCVar1->carInfo->WeightTransfer == 1) {
    a = fixedmult(a,suspensionUpgrade.brakeMult);   /* @0x8006F234 $a1=*(&lbl_8010DCF4)=suspensionUpgrade[+4] */
  }
  if (pCVar1->carInfo->GroundEffects == 1) {
    a = fixedmult(a,aeroUpgrade.brakeMult);   /* @0x8006F25C $a1=*(&lbl_8010DD04)=aeroUpgrade[+4] */
  }
  return a;
}

/* ---- AISpeeds_GetUpgradeHandlingMult__Fi  [@0x8006f284] ---- */
int AISpeeds_GetUpgradeHandlingMult(int carIndex)
{
  Car_tObj*carObj;
  int handlingMult;
  int a;
  Car_tObj *pCVar1;

  pCVar1 = Cars_gList[carIndex];
  a = 0x10000;
  if (pCVar1->carInfo->EngineMods == 1) {
    a = fixedmult(0x10000,engineUpgrade.handlingMult);   /* @0x8006F2C8 $a1=*(&lbl_8010DCE8)=engineUpgrade[+8]=handlingMult (H38) */
  }
  if (pCVar1->carInfo->WeightTransfer == 1) {
    a = fixedmult(a,suspensionUpgrade.handlingMult);   /* @0x8006F2F0 $a1=*(&lbl_8010DCF8)=suspensionUpgrade[+8] */
  }
  if (pCVar1->carInfo->GroundEffects == 1) {
    a = fixedmult(a,aeroUpgrade.handlingMult);   /* @0x8006F318 $a1=*(&lbl_8010DD08)=aeroUpgrade[+8] */
  }
  return a;
}

/* ---- AISpeeds_GetUpgradeTopSpeedMult__Fi  [@0x8006f340] ---- */
int AISpeeds_GetUpgradeTopSpeedMult(int carIndex)
{
  Car_tObj*carObj;
  int topSpeedMult;
  int a;
  Car_tObj *pCVar1;

  pCVar1 = Cars_gList[carIndex];
  a = 0x10000;
  if (pCVar1->carInfo->EngineMods == 1) {
    a = fixedmult(0x10000,engineUpgrade.topSpeedMult);   /* @0x8006F384 $a1=*(&lbl_8010DCEC)=engineUpgrade[+0xC]=topSpeedMult (H39) */
  }
  if (pCVar1->carInfo->WeightTransfer == 1) {
    a = fixedmult(a,suspensionUpgrade.topSpeedMult);   /* @0x8006F3AC $a1=*(&lbl_8010DCFC)=suspensionUpgrade[+0xC] */
  }
  if (pCVar1->carInfo->GroundEffects == 1) {
    a = fixedmult(a,aeroUpgrade.topSpeedMult);   /* @0x8006F3D4 $a1=*(&lbl_8010DD0C)=aeroUpgrade[+0xC] */
  }
  return a;
}

/* ---- AISpeeds_CalcHumanCurveSpeed__FP8Car_tObj  [@0x8006f3fc] ---- RECONSTRUCTED 2026-06-12
 *  (Ghidra @NFS4.EXE.c:49330). Skipped from the AISPEEDS pass. Looks ahead up to 5 slices in the
 *  car's direction, takes the max track-curve value, scales (0x1a666 in 16.16), clamps to 0xff,
 *  and maps through the car's curve-speed table. Unrolled exactly as in the binary. */
int AISpeeds_CalcHumanCurveSpeed(Car_tObj *carObj)
{
  int slice = (int)carObj->N.simRoadInfo.slice;
  int idx, off, c, best;

  idx = slice;
  if (gNumSlices <= idx) idx = slice - gNumSlices;
  best = AIDataRecord_TrackCurve->Get(idx);

  off = carObj->direction * 4;
  idx = slice + off;
  if (0 <= off) { if (gNumSlices <= idx) idx -= gNumSlices; }
  else if (idx < 0) idx += gNumSlices;
  c = AIDataRecord_TrackCurve->Get(idx); if (best < c) best = c;

  off = carObj->direction * 8;
  idx = slice + off;
  if (0 <= off) { if (gNumSlices <= idx) idx -= gNumSlices; }
  else if (idx < 0) idx += gNumSlices;
  c = AIDataRecord_TrackCurve->Get(idx); if (best < c) best = c;

  off = carObj->direction * 0xc;
  idx = slice + off;
  if (0 <= off) { if (gNumSlices <= idx) idx -= gNumSlices; }
  else if (idx < 0) idx += gNumSlices;
  c = AIDataRecord_TrackCurve->Get(idx); if (best < c) best = c;

  off = carObj->direction * 0x10;
  idx = slice + off;
  if (0 <= off) { if (gNumSlices <= idx) idx -= gNumSlices; }
  else if (idx < 0) idx += gNumSlices;
  c = AIDataRecord_TrackCurve->Get(idx); if (best < c) best = c;

  off = carObj->direction * 0x14;
  idx = slice + off;
  if (0 <= off) { if (gNumSlices <= idx) idx -= gNumSlices; }
  else if (idx < 0) idx += gNumSlices;
  c = AIDataRecord_TrackCurve->Get(idx); if (best < c) best = c;

  int scaled = best * 0x1a666;
  if (scaled < 0) scaled = scaled + 0xffff;
  scaled = scaled >> 0x10;
  if (0xff < scaled) scaled = 0xff;
  return carObj->curveSpeedTable->Get(scaled);
}

/* ---- AISpeeds_CalcHumanTopSpeed__FP8Car_tObj  [@0x8006f3f4] ---- RECONSTRUCTED 2026-06-12
 *  (Ghidra @NFS4.EXE.c:49318). Thin wrapper over CalcHumanCurveSpeed. */
int AISpeeds_CalcHumanTopSpeed(Car_tObj *carObj)
{
  return AISpeeds_CalcHumanCurveSpeed(carObj);
}
