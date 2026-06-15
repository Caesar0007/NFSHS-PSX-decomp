/* game/common/aiinit.cpp -- RECONSTRUCTED (NFS4 AI action/reaction scripting; 8 free AIScript_* fns).
 *   Player-action submission + reaction-table processing. SYM-v3 locals; vs disasm-v2.txt.
 *   NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "aiinit_externs.h"

static const int kAIInitNonStandardTable[50] = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };


/* ---- aiinit.obj-owned globals (.bss zero) ---- */
char         trafcfg[108] = { 4, 0, 0, 0, 12, 0, 0, 0, 30, 0, 0, 0, 51, -77, 0, 0, 0, 0, 11, 0, 0, 0, 8, 0, 0, 0, 32, 0, 0, 0, 8, 0, 0, 0, 24, 0, 0, 64, 1, 0, -52, -52, 0, 0, 0, 0, 5, 0, -52, -52, 0, 0, 0, 0, 20, 0, 71, 33, 0, 0, 83, 3, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 8, 0, 0, 0, 24, 0, 0, -96, 0, 0, -52, -52, 0, 0, 0, 0, 10, 0, -52, -52, 0, 0, 0, 0, 10, 0, -21, 81, 0, 0, 83, 3, 0, 0 };   /* @0x8010d560 */
void         *AITraffic_rawTriggers;   /* @0x8013c57c  (bss(zero)) */
int          AIInit_useSpreadForce;   /* @0x8013c580  (bss(zero)) */
int          AIInit_forceHumanHandBrake;   /* @0x8013c584  (bss(zero)) */


/* ---- intra-TU forward declarations ---- */
void AIInit_StartUp1(void);
void AIInit_StartUp2(void);
void AIInit_Reset1(void);
void AIInit_Reset2(void);
void AIInit_CleanUp1(void);
void AIInit_CleanUp2(void);
void AI_TrafficStartUp(void);
void AI_TrafficCleanUp(void);
void AIInit_LoadConfigs(void);
void AIInit_LoadPhysicsConfig(Udff_tInfo *handle);
void AIInit_ClearAICar(Car_tObj *carObj);
void AIInit_RestartAICar(Car_tObj *carObj);
void AIInit_InitAICar(Car_tObj *carObj,Udff_tInfo *handle);
void AIInit_DeInitAICar(Car_tObj *carObj);
void AIInit_InitAICar2(Car_tObj *carObj);
void AIInit_DeInitAICar2(Car_tObj *carObj);
int AIInit_IsNonStandardCarFile(int index);


/* ---- AIInit_StartUp1__Fv  [@0x80066bb0] ---- */
void AIInit_StartUp1(void)
{
  int i;
  int iVar1;
  int iVar2;
  int *piVar3;
  
  AI_TrafficStartUp();
  inverseLaneWidthTable[0] = 0;
  iVar2 = 1;
  piVar3 = inverseLaneWidthTable + 1;
  do {
    iVar1 = rdiv(0x10000,iVar2 << 0xe);
    *piVar3 = iVar1;
    piVar3 = piVar3 + 1;
    iVar2 = iVar2 + 1;
  } while (iVar2 < 0x50);
  AITune_StartUp1();
  AIDataRecord_t::StartUp1();
  AI_StartUp();
  return;
}

/* ---- AIInit_StartUp2__Fv  [@0x80066c24] ---- */
void AIInit_StartUp2(void)
{
  int carLoop;
  Car_tObj*carObj;
  bool bVar1;
  Car_tObj *pCVar2;
  int iVar3;
  Car_tObj **ppCVar4;
  
  AISpeeds_StartUp();
  iVar3 = 0;
  AIInit_LoadConfigs();
  if (0 < Cars_gNumCars) {
    ppCVar4 = Cars_gList;
    do {
      pCVar2 = *ppCVar4;
      ppCVar4 = ppCVar4 + 1;
      AIScript_Startup(&pCVar2->script);
      iVar3 = iVar3 + 1;
    } while (iVar3 < Cars_gNumCars);
  }
  iVar3 = 0;
  AIPerson_Startup();
  AIDataRecord_t::StartUp2();
  AIPhysic_StartUp();
  AITune_StartUp2();
  ppCVar4 = Cars_gList;
  while (bVar1 = iVar3 < Cars_gNumCars, iVar3 = iVar3 + 1, bVar1) {
    pCVar2 = *ppCVar4;
    ppCVar4 = ppCVar4 + 1;
    AIPhysic_InitCar(pCVar2);
    AIInit_InitAICar2(pCVar2);
  }
  return;
}

/* ---- AIInit_Reset1__Fv  [@0x80066cfc] ---- */
void AIInit_Reset1(void)
{
  AIInit_forceHumanHandBrake = 0;
  return;
}

/* ---- AIInit_Reset2__Fv  [@0x80066d08] ---- */
void AIInit_Reset2(void)
{
  int carLoop;
  Car_tObj *pCVar1;
  int iVar2;
  Car_tObj **ppCVar3;
  
  AIInit_useSpreadForce = (int)(GameSetup_gData.raceType != 3);
  iVar2 = 0;
  if (0 < Cars_gNumCars) {
    ppCVar3 = Cars_gList;
    do {
      pCVar1 = *ppCVar3;
      ppCVar3 = ppCVar3 + 1;
      AIScript_Startup(&pCVar1->script);
      iVar2 = iVar2 + 1;
    } while (iVar2 < Cars_gNumCars);
  }
  leaderBoard.leadHumanRacer = (Car_tObj *)0x0;
  leaderBoard.leadRacer = (Car_tObj *)0x0;
  leaderBoard.lastAIRacer = (Car_tObj *)0x0;
  leaderBoard.leadAIRacer = (Car_tObj *)0x0;
  AIPhysic_Reset();
  AI_Info.blockingCars[2] = (Car_tObj *)0x0;
  AI_Info.blockingCars[1] = (Car_tObj *)0x0;
  AI_Info.blockingCars[0] = (Car_tObj *)0x0;
  AI_Info.blockingCarsDist[2] = 0;
  AI_Info.blockingCarsDist[1] = 0;
  AI_Info.blockingCarsDist[0] = 0;
  AI_Info.laneSpeeds[2] = 0;
  AI_Info.laneSpeeds[1] = 0;
  AI_Info.laneSpeeds[0] = 0;
  AI_Info.laneSpeedsAhead[2] = 0;
  AI_Info.laneSpeedsAhead[1] = 0;
  AI_Info.laneSpeedsAhead[0] = 0;
  AI_Info.laneWeights[2] = 0;
  AI_Info.laneWeights[1] = 0;
  AI_Info.laneWeights[0] = 0;
  AI_Info.desiredLane = 0;
  AI_Info.deltaYaw = 0;
  return;
}

/* ---- AIInit_CleanUp1__Fv  [@0x80066e0c] ---- */
void AIInit_CleanUp1(void)
{
  AI_CleanUp();
  AIDataRecord_t::CleanUp1();
  AITune_CleanUp1();
  AI_TrafficCleanUp();
  return;
}

/* ---- AIInit_CleanUp2__Fv  [@0x80066e44] ---- */
void AIInit_CleanUp2(void)
{
  int carLoop;
  Car_tObj *carObj;
  Car_tObj **ppCVar1;
  int iVar2;
  
  iVar2 = 0;
  if (0 < Cars_gNumCars) {
    ppCVar1 = Cars_gList;
    do {
      iVar2 = iVar2 + 1;
      AIInit_DeInitAICar2(*ppCVar1);
      carObj = *ppCVar1;
      ppCVar1 = ppCVar1 + 1;
      AIPhysic_DeInitCar(carObj);
    } while (iVar2 < Cars_gNumCars);
  }
  carLoop = 0;
  AITune_CleanUp2();
  AIPhysic_CleanUp();
  AIDataRecord_t::CleanUp2();
  AIPerson_Cleanup();
  if (0 < Cars_gNumCars) {
    do {
      carLoop = carLoop + 1;
      AIScript_Cleanup();
    } while (carLoop < Cars_gNumCars);
  }
  AISpeeds_CleanUp();
  return;
}

/* ---- AI_TrafficStartUp__Fv  [@0x80066f0c] ---- */
extern char  D_8005521C[];   /* "%sTr%02d.trf" format @0x8005521C */
extern char *D_801164B0[];   /* path-table @0x801164B0 (Paths_Paths+0x48) */

void AI_TrafficStartUp(void)
{
  char filename[100];
  char *rawTriggers;

  if (GameSetup_gData.trafficDensity != 0) {
    triggerManagerTraffic = __builtin_new(0x34c);
    sprintf(filename,D_8005521C,D_801164B0[0],GameSetup_gData.track);
    rawTriggers = (char *)loadfileadrz(filename,(void *)0x0);
    AITraffic_rawTriggers = (u_char *)rawTriggers;
    if (rawTriggers != (char *)0x0) {
      triggerManagerTraffic->Init(rawTriggers);
    }
    else {
      triggerManagerTraffic->Init((char *)0x0);
    }
  }
  return;
}

/* ---- AI_TrafficCleanUp__Fv  [@0x80066fa8] ---- */
void AI_TrafficCleanUp(void)
{
  if (triggerManagerTraffic != (AITrigger_TriggerManager *)0x0) {
    __builtin_delete(triggerManagerTraffic);
    triggerManagerTraffic = (AITrigger_TriggerManager *)0x0;
  }
  if (AITraffic_rawTriggers != (u_char *)0x0) {
    purgememadr(AITraffic_rawTriggers);
    AITraffic_rawTriggers = (u_char *)0x0;
  }
  return;
}

/* ---- AIInit_LoadConfigs__Fv  [@0x80066ff8] ---- */
extern char  D_8005522C[];   /* sprintf format string @0x8005522C (shared rodata) */
extern char *D_80116470[];   /* path-table @0x80116470 (Paths_Paths+8) */

void AIInit_LoadConfigs(void)
{
  char pathname[100];
  Udff_tInfo *handle;

  sprintf(pathname,D_8005522C,D_80116470[0]);
  handle = Udff_Opena((char *)0x0,trafcfg,1);
  AIInit_LoadPhysicsConfig(handle);
  Udff_Close(handle);
  return;
}

/* ---- AIInit_LoadPhysicsConfig__FP10Udff_tInfo  [@0x80067054] ---- */
void AIInit_LoadPhysicsConfig(Udff_tInfo *handle)
{
  AIPhysic_ModelConfig_t*model;
  int loop;
  int iVar1;
  AIPhysic_ModelConfig_t *pAVar2;
  int iVar3;
  
  AIPhysicConfig.latvelcalc_lookahead = Udff_GetInt(handle);
  AIPhysicConfig.min_lookahead = Udff_GetInt(handle);
  AIPhysicConfig.max_lookahead = Udff_GetInt(handle);
  AIPhysicConfig.look_ahead_factor = Udff_GetInt(handle);
  AIPhysicConfig.skid_value = Udff_GetInt(handle);
  iVar3 = 0;
  do {
    if (iVar3 == 0) {
      pAVar2 = &AIPhysicConfig.ICModel;
    }
    else {
      pAVar2 = &AIPhysicConfig.OOCModel;
    }
    iVar1 = Udff_GetInt(handle);
    pAVar2->dlpos_to_dlvel = iVar1;
    iVar1 = Udff_GetInt(handle);
    pAVar2->max_dlvel = iVar1;
    iVar1 = Udff_GetInt(handle);
    pAVar2->dlvel_to_clacc = iVar1;
    iVar1 = Udff_GetInt(handle);
    pAVar2->max_clacc = iVar1;
    iVar1 = Udff_GetInt(handle);
    pAVar2->dangle_to_dav = iVar1;
    iVar1 = Udff_GetInt(handle);
    pAVar2->max_dav = iVar1;
    iVar1 = Udff_GetInt(handle);
    pAVar2->dav_to_aa = iVar1;
    iVar1 = Udff_GetInt(handle);
    pAVar2->max_aa = iVar1;
    iVar1 = Udff_GetInt(handle);
    pAVar2->vel_limit_range = iVar1;
    iVar1 = Udff_GetInt(handle);
    pAVar2->lat_vel_limit_factor = iVar1;
    iVar1 = Udff_GetInt(handle);
    iVar3 = iVar3 + 1;
    pAVar2->ang_vel_limit_factor = iVar1;
  } while (iVar3 < 2);
  return;
}

/* ---- AIInit_ClearAICar__FP8Car_tObj  [@0x80067174] ---- */
void AIInit_ClearAICar(Car_tObj *carObj)
{
  coorddef zero;
  int local_18;
  int local_14;
  int local_10;
  
  memset((u_char *)&local_18,'\0',0xc);
  (carObj->N).angularVel.x = local_18;
  (carObj->N).angularVel.y = local_14;
  (carObj->N).angularVel.z = local_10;
  (carObj->N).flightTime = 0;
  carObj->frontSkid = 0;
  carObj->rearSkid = 0;
  carObj->tailgateTimer = 0;
  carObj->aiShiftTimer = 0;
  carObj->driveDirection = 1;
  carObj->driveDirectionTimer = 0;
  carObj->driveDirectionReverseTime = 0;
  carObj->wipeOutEndTick = 0;
  carObj->wipeOutStartTick = 0;
  carObj->AIFishtailEndTick = 0;
  return;
}

/* ---- AIInit_RestartAICar__FP8Car_tObj  [@0x800671ec] ---- */
extern int D_8011321C;   /* standalone global @0x8011321C (== GameSetup_gData+0x30) */

void AIInit_RestartAICar(Car_tObj *carObj)
{
  int iVar1;

  iVar1 = -1;
  if (D_8011321C == 0) {
    iVar1 = 1;
  }
  carObj->direction = iVar1;
  carObj->desiredDirection = iVar1;
  carObj->targetLatPos = 0;
  (carObj->targetPos).z = 0;
  (carObj->targetPos).y = 0;
  (carObj->targetPos).x = 0;
  carObj->preferredLateralPosition = 0;
  carObj->preferredLateralPositionPower = 0;
  carObj->carInLane = 0;
  carObj->driveDirection = 1;
  carObj->driveDirectionTimer = 0;
  carObj->driveDirectionReverseTime = 0;
  carObj->barrierThinkHarder = 0;
  carObj->desiredLatPos = 0;
  carObj->desiredSpeed = 0;
  carObj->originalDesiredSpeed = 0;
  carObj->currentSpeed = 0;
  carObj->speed = 0;
  carObj->laneSlack = 0;
  carObj->roadPosition = 0;
  carObj->AIFlags = 0;
  carObj->roadSpan = 0;
  carObj->basisCar = carObj;
  carObj->aiShiftTimer = 0;
  carObj->tailgateTimer = 0;
  carObj->physicsModelTimer = 0;
  carObj->trafficSpeedRandomizingFactor = 0;
  carObj->laneChangeSpeed = 0;
  carObj->timeOffRoad = 0;
  carObj->rampDesiredLatPos = 0;
  carObj->accNitrous = 0x10000;
  carObj->speedNitrous = 0x10000;
  (carObj->speechInfo).speechMode = 0;
  carObj->wipeOutEndTick = 0;
  carObj->btcGlueModifier = 0x10000;
  carObj->copAccMult = 0x10000;
  carObj->copTopSpeed = 0x640000;
  carObj->donutMode = 0;
  carObj->laneIndex = 7;
  carObj->AIFishtailEndTick = 0;
  carObj->lookAheadSlice = 0;
  if ((carObj->carFlags & 2U) != 0) {
    carObj->forceNoSimOptz = 0;
  }
  else {
    carObj->forceNoSimOptz = 1;
  }
  carObj->wipeOutStartTick = 0;
  if ((carObj->carFlags & 10U) == 2) {
    (carObj->N).active = '\0';
  }
  carObj->caravanTimer = -1;
  carObj->fallBehindCar = (Car_tObj *)0x0;
  carObj->nextAIRacer = (Car_tObj *)0x0;
  carObj->caravanFollowBehindDistanceMeters = 0;
  carObj->AISlot = 0;
  carObj->gripFactor = 0x10000;
  carObj->damageMult = iVar1;
  carObj->extraWallCollisionAllowance = 0;
  return;
}

/* ---- AIInit_InitAICar__FP8Car_tObjP10Udff_tInfo  [@0x80067314] ---- */
void AIInit_InitAICar(Car_tObj *carObj,Udff_tInfo *handle)
{
  int gearLoop;
  int accelerationScale;
  int carType;
  int iVar1;
  int iVar2;
  AIDataRecord_AccTable_t *pAVar3;
  AIDataRecord_CurveSpeedTable_t *pAVar4;
  Car_tObj *pCVar5;
  int iVar6;
  int scale;
  
  scale = 0x10000;
  iVar1 = Udff_GetInt(handle);
  carObj->redLine = iVar1;
  Udff_GetBuffer(handle,(char *)carObj->topSpeeds,0x1c);
  iVar1 = 0;
  iVar6 = -4;
  pCVar5 = carObj;
  do {
    if (iVar1 == 0) {
      iVar2 = rdiv(0x10000,carObj->topSpeeds[0]);
      carObj->invTopSpeeds[0] = iVar2;
    }
    else if (pCVar5->topSpeeds[0] == 0) {
      pCVar5->invTopSpeeds[0] = 0;
    }
    else {
      iVar2 = rdiv(0x10000,pCVar5->topSpeeds[0] - *(int *)((int)carObj->topSpeeds + iVar6));
      pCVar5->invTopSpeeds[0] = iVar2;
    }
    iVar6 = iVar6 + 4;
    iVar1 = iVar1 + 1;
    pCVar5 = (Car_tObj *)&(pCVar5->N).oldSlice;
  } while (iVar1 < 7);
  Udff_GetBuffer(handle,(char *)carObj->accTable,0xe0);
  iVar1 = Udff_GetInt(handle);
  carObj->aiShiftDuration = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->max_clacc = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->max_aa = iVar1;
  if ((carObj->carFlags & 8U) != 0) {
    scale = AITune_accelerationScale[carObj->carInfo->carType].scale;
  }
  pAVar3 = new AIDataRecord_AccTable_t((char *)carObj->accTable,scale,(AIDataRecord_WhichRecord_t)3);  /* @was __builtin_new(0x5c)+flat ctor __23AIDataRecord_AccTable_t... */
  carObj->accelerationRecord = pAVar3;
  iVar1 = AIInit_IsNonStandardCarFile(carObj->carInfo->carType);
  if (iVar1 == 0) {
    carObj->curveSpeedTable = (AIDataRecord_CurveSpeedTable_t *)0x0;
  }
  else {
    pAVar4 = new AIDataRecord_CurveSpeedTable_t(carObj->carName,(AIDataRecord_WhichRecord_t)7);  /* @was __builtin_new(0x58)+flat ctor __30AIDataRecord_CurveSpeedTable_t... */
    carObj->curveSpeedTable = pAVar4;
  }
  iVar1 = fixedmult(carObj->max_clacc,0x13333);
  carObj->max_clacc = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->speedFactor = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->slackProb = iVar1;
  carObj->gripFactor = 0x10000;
  carObj->topSpeedUpgradeMult = 0;
  carObj->accUpgradeMult = 0;
  carObj->damageMult = 0x10000;
  return;
}

/* ---- AIInit_DeInitAICar__FP8Car_tObj  [@0x800674e8] ---- */
void AIInit_DeInitAICar(Car_tObj *carObj)
{
  /* Ghidra typed `_vf` as a pointer to a 1-byte-stride array, so the raw
     `pa_Var1 + 4` / `pa_Var1[2] + 2` byte arithmetic lands the dispatch pfn at
     +12 and the this-adjust delta at +8 (vtable entry[1]). Using the real
     8-byte __vtbl_ptr_type stride here would scale those to +96/+64. */
  char (*pa_Var1) [3];
  AIDataRecord_CurveSpeedTable_t *pAVar2;
  AIDataRecord_AccTable_t *pAVar3;
  char *nm;

  pAVar2 = carObj->curveSpeedTable;
  if (pAVar2 != (AIDataRecord_CurveSpeedTable_t *)0x0) {
    nm = (pAVar2->_base_AIDataRecord_t).name_;
    pa_Var1 = (char (*)[3])(pAVar2->_base_AIDataRecord_t)._vf;
    (**(int (**)(...))(pa_Var1 + 4))(nm + *(short *)(pa_Var1[2] + 2) + -8,3);
    carObj->curveSpeedTable = (AIDataRecord_CurveSpeedTable_t *)0x0;
  }
  pAVar3 = carObj->accelerationRecord;
  if (pAVar3 != (AIDataRecord_AccTable_t *)0x0) {
    nm = (pAVar3->_base_AIDataRecord_t).name_;
    pa_Var1 = (char (*)[3])(pAVar3->_base_AIDataRecord_t)._vf;
    (**(int (**)(...))(pa_Var1 + 4))(nm + *(short *)(pa_Var1[2] + 2) + -8,3);
    carObj->accelerationRecord = (AIDataRecord_AccTable_t *)0x0;
  }
  return;
}

/* ---- AIInit_InitAICar2__FP8Car_tObj  [@0x80067568] ---- */
void AIInit_InitAICar2(Car_tObj *carObj)
{
  int iVar1;
  
  if ((carObj->carFlags & 8U) != 0) {
    iVar1 = AISpeeds_GetUpgradeHandlingMult(carObj->carIndex);
    (carObj->curveSpeedTable)->Upgrade(iVar1);
  }
  iVar1 = AISpeeds_GetUpgradeAccMult(carObj->carIndex);
  carObj->accUpgradeMult = iVar1;
  iVar1 = AISpeeds_GetUpgradeTopSpeedMult(carObj->carIndex);
  carObj->topSpeedUpgradeMult = iVar1;
  return;
}

/* ---- AIInit_DeInitAICar2__FP8Car_tObj  [@0x800675d0] ---- */
void AIInit_DeInitAICar2(Car_tObj *carObj)
{
  return;
}

/* ---- AIInit_IsNonStandardCarFile__Fi  [@0x800675d8] ---- */
int AIInit_IsNonStandardCarFile(int index)
{
  u_int *puVar1;
  int *piVar2;
  int carType;
  u_int *puVar3;
  int iVar4;
  u_int *puVar5;
  u_int uVar6;
  u_int uVar7;
  u_int uVar8;
  AIPhysic_ModelConfig_t *model;
  int gearLoop;
  int loop;
  int accelerationScale;
  int nonStandardList [50];
  
  puVar1 = (u_int *)kAIInitNonStandardTable;
  piVar2 = nonStandardList;
  do {
    puVar5 = piVar2;
    puVar3 = puVar1;
    uVar6 = puVar3[1];
    uVar7 = puVar3[2];
    uVar8 = puVar3[3];
    *puVar5 = *puVar3;
    puVar5[1] = uVar6;
    puVar5[2] = uVar7;
    puVar5[3] = uVar8;
    puVar1 = puVar3 + 4;
    piVar2 = puVar5 + 4;
  } while (puVar3 + 4 != (u_int *)(u_int *)(kAIInitNonStandardTable + 48));
  uVar6 = puVar3[5];
  puVar5[4] = 0;
  puVar5[5] = uVar6;
  if (index < 0x32) {
    iVar4 = nonStandardList[index];
  }
  else {
    iVar4 = 0;
  }
  return iVar4;
}
