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
speedData_t  *AISpeeds_TrackSpeeds[11];   /* @0x8010dd78 */
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
  int weatherRamp;
  int slotLoop;
  int skillMult[3];
  int carType;
  int carModelLoop;
  int trackLoop;
  int trackMult;
  int nightMult;
  int curveLoop;
  Udff_tInfo *handle;
  int iVar1;
  u_int uVar2;
  int iVar3;
  int iVar4;
  int *piVar5;
  AISpeeds_tSlotInfo *pAVar6;
  int iVar7;
  char acStack_98 [112];
  int local_28 [4];
  
  sprintf(acStack_98,"%stuning.bin",DAT_80116470);   /* H34: 3rd arg (path prefix) was omitted; oracle 0x8006D5FC $a2=*(int*)&DAT_80116470 */
  handle = Udff_Opena(acStack_98,(char *)0x0,1);
  Udff_GetInt(handle);
  pAVar6 = CaravanInfo;
  for (iVar7 = 0; iVar7 < 6; iVar7 = iVar7 + 1) {
    iVar1 = Udff_GetInt(handle);
    pAVar6->distanceMaintainTime32 = iVar1 << 5;
    iVar1 = Udff_GetInt(handle);
    pAVar6->minDistanceMeters = iVar1;
    iVar1 = Udff_GetInt(handle);
    pAVar6->maxDistanceMeters = iVar1;
    iVar1 = Udff_GetInt(handle);
    uVar2 = fixeddiv(0x10000,iVar1 << 0x15);
    pAVar6->fallBackRandomTime_TickPercent = uVar2;
    pAVar6 = pAVar6 + 1;
  }
  iVar7 = 0;
  if ((GameSetup_gData.raceType == 0) && (0 < Cars_gNumAIRaceCars)) {
    iVar7 = 0;
    iVar1 = *(*(int **)((char *)Cars_gAIRaceCarList[0] + 0x288));  /* @0x5D6C8 disasm-v2 */
    do {
      local_28[0] = Udff_GetInt(handle);
      local_28[1] = Udff_GetInt(handle);
      local_28[2] = Udff_GetInt(handle);
      if (iVar7 == iVar1) {
        GameSetup_gData.tournamentMultiplier = local_28[GameSetup_gData.skill];
      }
      iVar7 = iVar7 + 1;
    } while (iVar7 < 0x16);
  }
  else {
    do {
      Udff_GetInt(handle);
      Udff_GetInt(handle);
      Udff_GetInt(handle);
      iVar7 = iVar7 + 1;
    } while (iVar7 < 0x16);
  }
  AISpeeds_trackAndNightMult = 0;
  for (iVar7 = 0; iVar7 < 0xc; iVar7 = iVar7 + 1) {
    Udff_GetInt(handle);
    iVar1 = Udff_GetInt(handle);
    iVar3 = Udff_GetInt(handle);
    if (GameSetup_gData.Time == 0) {
      iVar3 = 0x10000;
    }
    if (iVar7 == GameSetup_gData.track) {
      AISpeeds_trackAndNightMult = fixedmult(iVar1,iVar3);
    }
  }
  iVar7 = Udff_GetInt(handle);
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
    iVar1 = iVar1 + iVar7;
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
  if ((((1 < Cars_gNumAIRaceCars) && (GameSetup_gData.raceType != 1)) &&
      (simGlobal.gameTicks < 0x780)) &&
     ((Cars_gNumHumanRaceCars == 1 && ((*(u_short *)((char *)Cars_gHumanRaceCarList[0] + 6)) < (carObj->N).totalSlice)))) {
    return (Cars_gNumAIRaceCars - carObj->AISlot) * 0x3333 + 0x10000;
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
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  Car_tObj **ppCVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  
  iVar1 = AISpeeds_CalcOpponentCurveSpeed(carObj);
  if (carObj->fallBehindCar == (Car_tObj *)0x0) {
    if (((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&
       ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||
        ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) {
      iVar8 = AISpeeds_BTCGetGlueFactor(carObj);
    }
    else {
      iVar8 = AISpeeds_GetGlueFactor(carObj);
    }
  }
  else {
    iVar8 = 0x10000;
  }
  iVar2 = AISpeeds_GetScriptFactor(carObj);
  iVar9 = carObj->speedNitrous;
  iVar3 = AISpeeds_GetDamageFactor(carObj);
  if ((GameSetup_gData.raceType == 1) || (Cars_gNumAIRaceCars < 2)) {
    iVar4 = 0x10000;
  }
  else {
    iVar4 = AISpeeds_GetCaravanFactor(carObj);
  }
  if (iVar9 < 0) {
    iVar9 = iVar9 + 0xff;
  }
  iVar7 = AISpeeds_trackAndNightMult;
  if (AISpeeds_trackAndNightMult < 0) {
    iVar7 = AISpeeds_trackAndNightMult + 0xff;
  }
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar5 = GameSetup_gData.tournamentMultiplier;
  if (GameSetup_gData.tournamentMultiplier < 0) {
    iVar5 = GameSetup_gData.tournamentMultiplier + 0xff;
  }
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  iVar8 = (iVar5 >> 8) * (iVar8 >> 8);
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  iVar8 = (iVar4 >> 8) * (iVar8 >> 8);
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  iVar8 = (iVar7 >> 8) * (iVar8 >> 8);
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  iVar8 = (iVar9 >> 8) * (iVar8 >> 8);
  iVar9 = iVar8;
  if (iVar8 < 0) {
    iVar9 = iVar8 + 0xff;
  }
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar3 = (iVar3 >> 8) * (iVar2 >> 8);
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar3 = (iVar9 >> 8) * (iVar3 >> 8);
  if ((GameSetup_gData.raceType != 1) && ((carObj->N).totalSlice < 0x96)) {
    iVar8 = fixedmult((0x10000 - iVar8) * (u_int)(carObj->N).totalSlice,0x1b4);
    iVar8 = 0x10000 - iVar8;
    if ((carObj->N).totalSlice < 0x96) {
      iVar3 = fixedmult((0x10000 - iVar3) * (u_int)(carObj->N).totalSlice,0x1b4);
      iVar3 = 0x10000 - iVar3;
    }
  }
  iVar2 = AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars(carObj);
  if (iVar2 != 0x10000) {
    if (iVar8 < 0) {
      iVar8 = iVar8 + 0xff;
    }
    if (iVar2 < 0) {
      iVar2 = iVar2 + 0xff;
    }
    iVar8 = (iVar8 >> 8) * (iVar2 >> 8);
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xff;
    }
    iVar3 = (iVar3 >> 8) * (iVar2 >> 8);
  }
  iVar3 = AISpeeds_LimitGlueMultiplier(carObj,iVar3);
  carObj->aiGlue = iVar3;
  iVar8 = AISpeeds_LimitGlueMultiplier(carObj,iVar8);
  if (carObj->aiGlue < 0x10001) {
    (carObj->N).gravityMult = 0x10000;
  }
  else {
    (carObj->N).gravityMult = carObj->aiGlue;
  }
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar3 = carObj->aiGlue;
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar3 = (iVar1 >> 8) * (iVar3 >> 8);
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  *unFetteredDesiredSpeed = (iVar1 >> 8) * (iVar8 >> 8);
  if ((((carObj->carFlags & 1U) != 0) && ((carObj->stats).finishType == 2)) &&
     (((GameSetup_gData.raceType != 1 && (GameSetup_gData.raceType != 5)) ||
      ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) == 0 &&
       ((Cars_gNumHumanRaceCars != 2 || (((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) == 0)))))))) {
    iVar1 = AIWorld_ApxSplineDistance(carObj,0);
    iVar8 = 0;
    if (iVar1 < 0) {
      iVar1 = -iVar1;
    }
    iVar2 = (carObj->N).dimension.x;
    iVar9 = carObj->roadPosition - iVar2;
    iVar2 = carObj->roadPosition + iVar2;
    if (0 < Cars_gNumCars) {
      ppCVar6 = Cars_gTotalSortedList;
      do {
        if (*ppCVar6 == carObj) break;
        iVar8 = iVar8 + 1;
        ppCVar6 = ppCVar6 + 1;
      } while (iVar8 < Cars_gNumCars);
    }
    if (iVar8 * 0x280000 <= iVar1) {
      iVar3 = (carObj->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices;
      iVar8 = -((u_int)*(u_char *)(iVar3 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar3 + 0x1d) >> 4));
      if (iVar8 <= iVar9) {
        iVar4 = (u_int)*(u_char *)(iVar3 + 0x1f) * 0x8000 * (*(u_char *)(iVar3 + 0x1d) & 0xf);
        if ((iVar9 <= iVar4) && (iVar8 <= iVar2)) {
          iVar3 = 0;
          if (iVar4 < iVar2) goto LAB_8006de40;
          if (iVar1 < 0x1900001) {
            iVar3 = 0x11c71c;
            goto LAB_8006de40;
          }
        }
      }
      iVar3 = 0;
    }
  }
LAB_8006de40:
  *unFetteredDesiredSpeed = *unFetteredDesiredSpeed * carObj->direction;
  return iVar3 * carObj->direction;
}

/* ---- AISpeeds_NeedToSlowDownForCurve__FP8Car_tObjiii  [@0x8006de90] ---- */
int AISpeeds_NeedToSlowDownForCurve(Car_tObj *carObj,int distanceMeters,int currentSpeed,int futureCurveSpeed)
{
  int neededDistance;
  int futureSpeed;
  int speed;
  int sIndex;
  int *piVar1;
  AIPhysic_BrakeInfo *pAVar2;
  int iVar3;
  
  if (futureCurveSpeed <= currentSpeed) {
    pAVar2 = carObj->brakeInfo;
    if (currentSpeed < 0) {
      currentSpeed = currentSpeed + 0xffff;
    }
    iVar3 = currentSpeed >> 0x10;
    if (iVar3 < 0) {
      iVar3 = -iVar3;
    }
    piVar1 = (int *)(pAVar2->brakeTable_ + iVar3);
    if (0x7f < iVar3) {
      piVar1 = &pAVar2->deceleration_;
    }
    if (futureCurveSpeed < 0) {
      futureCurveSpeed = futureCurveSpeed + 0xffff;
    }
    iVar3 = futureCurveSpeed >> 0x10;
    if (iVar3 < 0) {
      iVar3 = -iVar3;
    }
    if (0x7f < iVar3) {
      iVar3 = 0x80;
    }
    iVar3 = (u_int)(u_char)*piVar1 * 0x20000 + (u_int)pAVar2->brakeTable_[iVar3] * -0x20000;
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
  int currentSpeed;
  int iVar2;
  int iVar3;
  
  iVar3 = 200;
  currentSpeed = carObj->currentSpeed;
  if (currentSpeed < 0) {
    currentSpeed = -currentSpeed;
  }
  while( true ) {
    if (iVar3 < 0) {
      return 0;
    }
    iVar2 = (iVar3 / 6) * carObj->direction;
    if (iVar2 < 0) {
      iVar2 = (carObj->N).simRoadInfo.slice + iVar2;
      if (iVar2 < 0) {
        iVar2 = iVar2 + gNumSlices;
      }
    }
    else {
      iVar2 = (carObj->N).simRoadInfo.slice + iVar2;
      if (gNumSlices <= iVar2) {
        iVar2 = iVar2 - gNumSlices;
      }
    }
    iVar1 = AIDataRecord_TrackCurve->Get(iVar2);
    iVar2 = (carObj->curveSpeedTable)->Get(iVar1);
    if (GameSetup_gData.Weather != 0) {
      if (iVar1 < 0) {
        iVar1 = iVar1 + 3;
      }
      iVar2 = fixedmult(iVar2,AISpeeds_WeatherMultFactors[iVar1 >> 2]);
    }
    if (iVar3 == 0) break;
    iVar1 = AISpeeds_NeedToSlowDownForCurve(carObj,iVar3 << 0x10,currentSpeed,iVar2)
    ;
    iVar3 = iVar3 + -0x19;
    if (iVar1 != 0) {
      return iVar2;
    }
  }
  return iVar2;
}

/* ---- AISpeeds_BTCGetGlueFactor__FP8Car_tObj  [@0x8006e09c] ---- */
int AISpeeds_BTCGetGlueFactor(Car_tObj *carObj)
{
  int closestHumanDistance;
  Car_tObj*closestHumanCarObj;
  int humanLoop;
  Car_tObj*copCar;
  int longMetersBetween;
  int glueIndex;
  int glue;
  int iVar1;
  int iVar2;
  int iVar3;
  Car_tObj *otherCarObj;
  Car_tObj **ppCVar4;
  int iVar5;
  int iVar6;
  Car_tObj *pCVar7;
  
  iVar5 = 0x270f0000;
  pCVar7 = (Car_tObj *)0x0;
  if ((carObj->carFlags & 0x20U) == 0) {
    ppCVar4 = Cars_gHumanRaceCarList;
    for (iVar6 = 0; iVar6 < Cars_gNumHumanRaceCars; iVar6 = iVar6 + 1) {
      otherCarObj = *ppCVar4;
      if ((otherCarObj->carFlags & 0x200U) != 0) {
        iVar1 = AIWorld_ApxSplineDistance(carObj,otherCarObj);
        iVar2 = iVar1;
        if (iVar1 < 0) {
          iVar2 = -iVar1;
        }
        iVar3 = iVar5;
        if (iVar5 < 0) {
          iVar3 = -iVar5;
        }
        if (iVar2 < iVar3) {
          iVar5 = iVar1;
          pCVar7 = otherCarObj;
        }
      }
      ppCVar4 = ppCVar4 + 1;
    }
    if (pCVar7->RSControl != 0) {
      return 0x10000;
    }
    if (0x13fffe < pCVar7->currentSpeed + 0x9ffffU) {
      iVar5 = (iVar5 * carObj->direction) / 0x3c0000 + 10;
      if (iVar5 < 0) {
        iVar6 = 0;
      }
      else {
        iVar6 = 0x14;
        if (iVar5 < 0x15) {
          iVar6 = iVar5;
        }
      }
      iVar5 = AIPerson_glueTable[iVar6];
      if (iVar5 < 0x10000) {
        iVar5 = fixedmult(0x10000 - iVar5,carObj->btcGlueModifier);
        iVar5 = 0x10000 - iVar5;
      }
      if (iVar5 < 0x6666) {
        iVar5 = 0x6666;
      }
      iVar5 = fixedmult(iVar5,carObj->speedFactor);
      return iVar5;
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
  Car_tObj*prevCar;
  Car_tObj*testCar;
  int carLoop;
  Car_tObj *pCVar1;
  int iVar2;
  Car_tObj **ppCVar3;
  Car_tObj *pCVar4;
  
  pCVar4 = (Car_tObj *)0x0;
  iVar2 = 0;
  if (0 < Cars_gNumCars) {
    ppCVar3 = Cars_gTotalSortedList;
    do {
      pCVar1 = *ppCVar3;
      if (carObj == pCVar1) {
        return pCVar4;
      }
      if ((pCVar1->carFlags & 8U) != 0) {
        pCVar4 = pCVar1;
      }
      iVar2 = iVar2 + 1;
      ppCVar3 = ppCVar3 + 1;
    } while (iVar2 < Cars_gNumCars);
  }
  return (Car_tObj *)0x0;
}

/* ---- AISpeeds_GetCaravanFactor__FP8Car_tObj  [@0x8006e2d0] ---- */
int AISpeeds_GetCaravanFactor(Car_tObj *carObj)
{
  int slot;
  Car_tObj*nextAICar;
  int f_caravan;
  int leaderIsThisManyMetersAhead;
  u_int tempRandom;
  Car_tObj*prevAICar;
  Car_tObj *carObj_00;
  Car_tObj *pCVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  u_int uVar5;
  
  uVar5 = carObj->AISlot;
  carObj_00 = AISpeeds_GetNextAICar(carObj);
  if (carObj->fallBehindCar != (Car_tObj *)0x0) {
    iVar4 = 0xe666;
    if (carObj->fallBehindCar->AISlot < (int)uVar5) {
      carObj->fallBehindCar = (Car_tObj *)0x0;
    }
    goto LAB_8006e444;
  }
  if (carObj_00 == (Car_tObj *)0x0) {
LAB_8006e3b0:
    pCVar1 = carObj_00->fallBehindCar;
  }
  else {
    pCVar1 = carObj_00->fallBehindCar;
    if (pCVar1 == (Car_tObj *)0x0) {
      if (0xd6491 < carObj_00->speed) {
        iVar4 = carObj_00->originalDesiredSpeed * carObj->direction;
        if (iVar4 < 0) {
          iVar4 = iVar4 + 0xff;
        }
        if ((iVar4 >> 8) * 0xb3 <= carObj_00->desiredSpeed * carObj->direction) {
          iVar3 = AIWorld_GameOdometer(carObj_00);
          iVar4 = AIWorld_GameOdometer(carObj);
          iVar3 = iVar3 - iVar4;
          iVar2 = carObj->caravanFollowBehindDistanceMeters;
          if (iVar2 + 0xa0000 < iVar3) {
            iVar4 = 0x13333;
            if (iVar2 + 0x3e80000 < iVar3) {
              iVar4 = 0x18000;
            }
          }
          else if (iVar3 < iVar2 + -0xa0000) {
            iVar4 = 0xcccc;
            if (iVar3 < iVar2 + -0x3e80000) {
              iVar4 = 0x9999;
            }
          }
          else {
            iVar4 = 0x10000;
          }
          goto LAB_8006e444;
        }
      }
      goto LAB_8006e3b0;
    }
  }
  iVar4 = 0x10000;
  if (pCVar1 == carObj) {
    iVar4 = 0x11999;
  }
LAB_8006e444:
  if (CaravanInfo[uVar5].distanceMaintainTime32 != 0) {
    carObj->caravanTimer = carObj->caravanTimer - AI_elapsedTime;
  }
  if (carObj->caravanTimer < 0) {
    iVar3 = CaravanInfo[uVar5].distanceMaintainTime32 / 2;
    randtemp = (fastRandom * randSeed & 0xffff) * randSeed;
    carObj->caravanTimer = iVar3 + (iVar3 * ((fastRandom * randSeed & 0xffff00) >> 8) >> 0x10);
    fastRandom = randtemp & 0xffff;
    carObj->caravanFollowBehindDistanceMeters =
         (CaravanInfo[uVar5].minDistanceMeters +
         ((CaravanInfo[uVar5].maxDistanceMeters - CaravanInfo[uVar5].minDistanceMeters) *
          ((randtemp & 0xffff00) >> 8) >> 0x10)) * 0x10000;
  }
  if (((((int)uVar5 < Cars_gNumAIRaceCars + -1) && (carObj->fallBehindCar == (Car_tObj *)0x0)) &&
      ((int)(u_int)(carObj->N).totalSlice < GameSetup_gData.numLaps * gNumSlices + -0x14d)) &&
     ((1 < uVar5 || (leaderBoard.leadRacer != (Car_tObj *)0x0)))) {
    randtemp = fastRandom * randSeed;
    fastRandom = randtemp & 0xffff;
  }
  if (((carObj_00 != (Car_tObj *)0x0) && (carObj_00->damageMult < carObj->damageMult + -0x1999)) &&
     (carObj_00->fallBehindCar == (Car_tObj *)0x0)) {
    carObj_00->fallBehindCar = carObj;
  }
  return iVar4;
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
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int b;
  
  b = 0x10000;
  iVar1 = AIWorld_GameOdometer(leaderBoard.leadHumanRacer);
  iVar2 = AIWorld_GameOdometer(leaderBoard.leadAIRacer);
  iVar3 = AIWorld_GameOdometer(leaderBoard.lastAIRacer);
  iVar4 = (leaderBoard.leadHumanRacer)->currentSpeed;
  if (iVar4 < 0) {
    iVar4 = -iVar4;
  }
  if (iVar4 < 0xa0000) {
    iVar4 = 0x10000;
    goto LAB_8006e818;
  }
  if (iVar1 < iVar3) {
    iVar4 = (iVar2 - iVar1) / 0x3c0000 + 10;
    if (iVar4 < 0) {
      iVar2 = 0;
    }
    else {
LAB_8006e77c:
      iVar2 = 0x14;
      if (iVar4 < 0x15) {
        iVar2 = iVar4;
      }
    }
  }
  else {
    if (iVar1 <= iVar2) {
      iVar4 = (iVar2 - iVar1) / 0x3c0000 + 10;
      if (iVar4 < 0) {
        iVar2 = 0;
      }
      else {
        iVar2 = 0x14;
        if (iVar4 < 0x15) {
          iVar2 = iVar4;
        }
      }
      iVar4 = AIPerson_glueTable[iVar2];
      b = 0x8000;
      if (GameSetup_gData.raceType != 3) {
        b = 0xe666;
      }
      goto LAB_8006e818;
    }
    iVar4 = (iVar2 - iVar1) / 0x3c0000 + 10;
    if (-1 < iVar4) goto LAB_8006e77c;
    iVar2 = 0;
  }
  iVar4 = AIPerson_glueTable[iVar2];
  b = 0x10000;
LAB_8006e818:
  iVar2 = AIWorld_GameOdometer(carObj);
  if ((iVar2 < iVar1 + 0x3c0000) && (iVar4 < 0x10000)) {
    iVar4 = 0x10000;
  }
  if (iVar4 < 0x10001) {
    iVar4 = fixedmult(0x10000 - iVar4,b);
    iVar4 = -iVar4;
  }
  else {
    iVar4 = fixedmult(iVar4 + -0x10000,b);
  }
  return iVar4 + 0x10000;
}

/* ---- AISpeeds_GetDamageFactor__FP8Car_tObj  [@0x8006e898] ---- */
int AISpeeds_GetDamageFactor(Car_tObj *carObj)
{
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  
  iVar1 = (carObj->N).damage[0];
  iVar2 = (carObj->N).damage[1];
  iVar4 = (carObj->N).damage[3];
  iVar3 = (carObj->N).damage[2];
  carObj->damageMult = 0;
  iVar1 = iVar1 + iVar2 + iVar3 + iVar4 + (carObj->N).damage[4] + (carObj->N).damage[5] +
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
  iVar2 = 0x10000 - carObj->damageMult;
  carObj->damageMult = iVar2;
  iVar1 = 0x8000;
  if (0x7fff < iVar2) {
    iVar1 = iVar2;
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
  if (iVar1 < 0x10001) {
    (carObj->N).gravityMult = 0x10000;
  }
  else {
    (carObj->N).gravityMult = iVar1;
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
  int desired;
  int iVar1;
  int iVar2;
  u_int uVar3;
  
  iVar1 = AISpeeds_GetLegalSpeed((int)(carObj->N).simRoadInfo.slice);
  iVar1 = fixedmult(iVar1,0xc000);
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
  if (iVar2 <= iVar1) {
    iVar1 = AISpeeds_CalculateOncomingCarSpeed(carObj);
  }
LAB_8006ec80:
  if ((carObj->carFlags & 0x10U) != 0) {
    iVar1 = AISpeeds_RandomizeTrafficSpeed(carObj,iVar1);
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    iVar2 = carObj->speedFactor;
    if (iVar2 < 0) {
      iVar2 = iVar2 + 0xff;
    }
    iVar1 = (iVar1 >> 8) * (iVar2 >> 8);
  }
  if (iVar1 < 0x8e38e) {
    iVar1 = 0x8e38e;
  }
  return iVar1 * carObj->direction;
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
  int newsafe;
  int safeminus30;
  int iVar1;
  
  if (oldsafe < 1) {
    if (oldsafe < 0) {
      oldsafe = oldsafe + 0xff;
    }
    iVar1 = carObj->trafficSpeedRandomizingFactor;
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    iVar1 = (oldsafe >> 8) * (iVar1 >> 8);
  }
  else {
    iVar1 = carObj->trafficSpeedRandomizingFactor;
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    iVar1 = (oldsafe >> 8) * (iVar1 >> 8);
    if (iVar1 < oldsafe + -0xd6666) {
      iVar1 = oldsafe + -0xd6666;
    }
    if (iVar1 < 0x8e666) {
      iVar1 = 0x8e666;
    }
  }
  return iVar1;
}

/* ---- AISpeeds_CalcDesiredSpeed__FP8Car_tObj  [@0x8006eddc] ---- */
void AISpeeds_CalcDesiredSpeed(Car_tObj *carObj)
{
  int iVar1;
  u_int uVar2;
  
  uVar2 = carObj->carFlags;
  carObj->desiredSpeed = 0;
  if ((uVar2 & 8) == 0) {
    if ((uVar2 & 0x20) == 0) {
      if ((uVar2 & 0x10) != 0) {
        iVar1 = AISpeeds_CalcTrafficTopSpeed(carObj);
        carObj->desiredSpeed = iVar1;
        carObj->originalDesiredSpeed = iVar1;
      }
    }
    else {
      if ((carObj->AIFlags & 2U) == 0) {
        iVar1 = AISpeeds_CalcTrafficTopSpeed(carObj);
        carObj->desiredSpeed = iVar1;
      }
      else {
        iVar1 = AISpeeds_CalcCopTopSpeed(carObj);
        carObj->desiredSpeed = iVar1;
      }
      carObj->originalDesiredSpeed = carObj->desiredSpeed;
    }
  }
  else {
    iVar1 = AISpeeds_CalcOpponentTopSpeed(carObj,&carObj->originalDesiredSpeed);
    carObj->desiredSpeed = iVar1;
  }
  return;
}

/* ---- AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj  [@0x8006ee80] ---- */
int AISpeeds_CalculateOncomingCarSpeed(Car_tObj *carObj)
{
  int playerSpeed;
  int iVar1;
  u_int uVar2;
  
  iVar1 = carObj->basisCar->currentSpeed;
  if (iVar1 < 0) {
    iVar1 = -iVar1;
  }
  if (iVar1 < 0xd5555) {
    uVar2 = 0x160000;
  }
  else {
    if (iVar1 < 0x1aaaaa) {
      return 0xd5555;
    }
    if (iVar1 < 0x280000) {
      return 0x8e38e;
    }
    if (iVar1 < 0x378e38) {
      return 0x471c7;
    }
    if (0x471c70 < iVar1) {
      return 0x2c51e;
    }
    uVar2 = 0x20000;
  }
  return uVar2 | 0x38e3;
}

/* ---- AISpeeds_SetTrafficSpeedRandomFactor__FP8Car_tObj  [@0x8006ef28] ---- */
void AISpeeds_SetTrafficSpeedRandomFactor(Car_tObj *carObj)
{
  int randomSpeedMultipliers[4];
  int local_10 [4];
  
  randtemp = fastRandom * randSeed;
  local_10[0] = 0x10000;
  local_10[1] = 0xe666;
  local_10[2] = 0xcccc;
  local_10[3] = 0xb333;
  fastRandom = randtemp & 0xffff;
  carObj->trafficSpeedRandomizingFactor = *(int *)((int)local_10 + (randtemp >> 6 & 0xc));
  return;
}

/* ---- AISpeeds_MaintainLeaderBoard__Fv  [@0x8006efa4] ---- */
void AISpeeds_MaintainLeaderBoard(void)
{
  int slot;
  Car_tObj*lastAI;
  int carLoop;
  Car_tObj*test;
  Car_tObj **ppCVar1;
  Car_tObj *pCVar2;
  int iVar3;
  int iVar4;
  Car_tObj *pCVar5;
  
  iVar4 = 0;
  pCVar5 = (Car_tObj *)0x0;
  leaderBoard.leadRacer = (Car_tObj *)0x0;
  leaderBoard.leadHumanRacer = (Car_tObj *)0x0;
  leaderBoard.leadAIRacer = (Car_tObj *)0x0;
  leaderBoard.lastAIRacer = (Car_tObj *)0x0;
  iVar3 = Cars_gNumCars + -1;
  ppCVar1 = Cars_gTotalSortedList + iVar3;
  for (; -1 < iVar3; iVar3 = iVar3 + -1) {
    pCVar2 = *ppCVar1;
    if ((((pCVar2->carFlags & 1U) != 0) && (leaderBoard.leadRacer == (Car_tObj *)0x0)) &&
       (pCVar2->fallBehindCar == (Car_tObj *)0x0)) {
      leaderBoard.leadRacer = pCVar2;
    }
    if ((pCVar2->carFlags & 8U) != 0) {
      pCVar2->nextAIRacer = pCVar5;
      pCVar2->AISlot = iVar4;
      iVar4 = iVar4 + 1;
      pCVar5 = pCVar2;
      leaderBoard.lastAIRacer = pCVar2;
      if (leaderBoard.leadAIRacer == (Car_tObj *)0x0) {
        leaderBoard.leadAIRacer = pCVar2;
      }
    }
    if (((pCVar2->carFlags & 4U) != 0) && (leaderBoard.leadHumanRacer == (Car_tObj *)0x0)) {
      leaderBoard.leadHumanRacer = pCVar2;
    }
    ppCVar1 = ppCVar1 + -1;
  }
  return;
}

/* ---- AISpeeds_GetScriptFactor__FP8Car_tObj  [@0x8006f0a4] ---- */
int AISpeeds_GetScriptFactor(Car_tObj *carObj)
{
  int iVar1;
  int iVar2;
  
  iVar1 = AIScript_DoReAction(&carObj->script,4);
  if (iVar1 == -1) {
    iVar2 = AIScript_DoReAction(&carObj->script,0x10);
    iVar1 = 0x8000;
    if (iVar2 == -1) {
      iVar1 = 0x10000;
    }
  }
  else {
    iVar1 = 0x18000;
  }
  return iVar1;
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
  if (off < 0) { if (idx < 0) idx += gNumSlices; }
  else if (gNumSlices <= idx) idx -= gNumSlices;
  c = AIDataRecord_TrackCurve->Get(idx); if (best < c) best = c;

  off = carObj->direction * 8;
  idx = slice + off;
  if (off < 0) { if (idx < 0) idx += gNumSlices; }
  else if (gNumSlices <= idx) idx -= gNumSlices;
  c = AIDataRecord_TrackCurve->Get(idx); if (best < c) best = c;

  off = carObj->direction * 0xc;
  idx = slice + off;
  if (off < 0) { if (idx < 0) idx += gNumSlices; }
  else if (gNumSlices <= idx) idx -= gNumSlices;
  c = AIDataRecord_TrackCurve->Get(idx); if (best < c) best = c;

  off = carObj->direction * 0x10;
  idx = slice + off;
  if (off < 0) { if (idx < 0) idx += gNumSlices; }
  else if (gNumSlices <= idx) idx -= gNumSlices;
  c = AIDataRecord_TrackCurve->Get(idx); if (best < c) best = c;

  off = carObj->direction * 0x14;
  idx = slice + off;
  if (off < 0) { if (idx < 0) idx += gNumSlices; }
  else if (gNumSlices <= idx) idx -= gNumSlices;
  c = AIDataRecord_TrackCurve->Get(idx); if (best < c) best = c;

  best = best * 0x1a666;
  if (best < 0) best = best + 0xffff;
  best = best >> 0x10;
  if (0xff < best) best = 0xff;
  return carObj->curveSpeedTable->Get(best);
}

/* ---- AISpeeds_CalcHumanTopSpeed__FP8Car_tObj  [@0x8006f3f4] ---- RECONSTRUCTED 2026-06-12
 *  (Ghidra @NFS4.EXE.c:49318). Thin wrapper over CalcHumanCurveSpeed. */
int AISpeeds_CalcHumanTopSpeed(Car_tObj *carObj)
{
  return AISpeeds_CalcHumanCurveSpeed(carObj);
}
