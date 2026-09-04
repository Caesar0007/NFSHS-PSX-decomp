/* game/common/aiinit.cpp -- RECONSTRUCTED (NFS4 AI action/reaction scripting; 8 free AIScript_* fns).
 *   Player-action submission + reaction-table processing. SYM-v3 locals; vs disasm-v2.txt.
 *   NOT original source; SYM-faithful, recompilable C++.
 */
#include "aiinit_types.h"
#include "aiinit_externs.h"

extern int D_8005523C[];   /* nonstandard-car table @0x8005523C (shared rodata) */


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
  
  AI_TrafficStartUp();
  inverseLaneWidthTable[0] = 0;
  for (i = 1; i < 0x50; i++) {
    inverseLaneWidthTable[i] = rdiv(0x10000,i << 0xe);
  }
  AITune_StartUp1();
  AIDataRecord_t::StartUp1();
  AI_StartUp();
  return;
}

/* ---- AIInit_StartUp2__Fv  [@0x80066c24] ---- */
void AIInit_StartUp2(void)
{
  {
    int carLoop;
    AISpeeds_StartUp();
    AIInit_LoadConfigs();
    for (carLoop = 0; carLoop < Cars_gNumCars; carLoop = carLoop + 1) {
      AIScript_Startup(&Cars_gList[carLoop]->script);
    }
  }
  {
    int carLoop;
    AIPerson_Startup();
    AIDataRecord_t::StartUp2();
    AIPhysic_StartUp();
    AITune_StartUp2();
    for (carLoop = 0; carLoop < Cars_gNumCars; carLoop = carLoop + 1) {
      Car_tObj *carObj = Cars_gList[carLoop];
      AIPhysic_InitCar(carObj);
      AIInit_InitAICar2(carObj);
    }
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
  if (GameSetup_gData.raceType != RaceType_Id3) {
    AIInit_useSpreadForce = 1;
  }
  else {
    AIInit_useSpreadForce = 0;
  }
  {
    int carLoop;
    for (carLoop = 0; carLoop < Cars_gNumCars; carLoop = carLoop + 1) {
      AIScript_Startup(&Cars_gList[carLoop]->script);
    }
  }
  AIInit_leaderBoardCars[1] = Cars_gHumanRaceCarList[0];
  AIInit_leaderBoardCars[0] = Cars_gHumanRaceCarList[0];
  AIInit_leaderBoardCars[3] = Cars_gAIRaceCarList[0];
  AIInit_leaderBoardCars[2] = Cars_gAIRaceCarList[0];
  AIPhysic_Reset();
  AI_Info.blockingCars[2] = 0;
  AI_Info.blockingCars[1] = 0;
  AI_Info.blockingCars[0] = 0;
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
  {
    int carLoop;
    for (carLoop = 0; carLoop < Cars_gNumCars; carLoop++) {
      AIInit_DeInitAICar2(Cars_gList[carLoop]);
      AIPhysic_DeInitCar(Cars_gList[carLoop]);
    }
  }
  AITune_CleanUp2();
  AIPhysic_CleanUp();
  AIDataRecord_t::CleanUp2();
  AIPerson_Cleanup();
  {
    int carLoop;
    for (carLoop = 0; carLoop < Cars_gNumCars; carLoop++) {
      AIScript_Cleanup();
    }
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

  if (GameSetup_gData.trafficDensity != 0) {
    triggerManagerTraffic = new AITrigger_TriggerManager;
    sprintf(filename,D_8005521C,D_801164B0[0],GameSetup_gData.track);
    AITraffic_rawTriggers = (u_char *)loadfileadrz(filename,(void *)0x0);
    if (AITraffic_rawTriggers != (u_char *)0x0) {
      triggerManagerTraffic->Init((char *)AITraffic_rawTriggers);
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
    delete triggerManagerTraffic;
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
  
  AIPhysicConfig.latvelcalc_lookahead = Udff_GetInt(handle);
  AIPhysicConfig.min_lookahead = Udff_GetInt(handle);
  AIPhysicConfig.max_lookahead = Udff_GetInt(handle);
  AIPhysicConfig.look_ahead_factor = Udff_GetInt(handle);
  AIPhysicConfig.skid_value = Udff_GetInt(handle);
  loop = 0;
  do {
    if (loop == 0) {
      model = &AIPhysicConfig.ICModel;
    }
    else {
      model = &AIPhysicConfig.OOCModel;
    }
    model->dlpos_to_dlvel = Udff_GetInt(handle);
    model->max_dlvel = Udff_GetInt(handle);
    model->dlvel_to_clacc = Udff_GetInt(handle);
    model->max_clacc = Udff_GetInt(handle);
    model->dangle_to_dav = Udff_GetInt(handle);
    model->max_dav = Udff_GetInt(handle);
    model->dav_to_aa = Udff_GetInt(handle);
    model->max_aa = Udff_GetInt(handle);
    model->vel_limit_range = Udff_GetInt(handle);
    model->lat_vel_limit_factor = Udff_GetInt(handle);
    model->ang_vel_limit_factor = Udff_GetInt(handle);
    loop = loop + 1;
  } while (loop < 2);
  return;
}

/* ---- AIInit_ClearAICar__FP8Car_tObj  [@0x80067174] ---- */
void AIInit_ClearAICar(Car_tObj *carObj)
{
  coorddef zero;

  memset((u_char *)&zero,'\0',0xc);
  (carObj->N).angularVel = zero;
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
/* The chained direction assignment preserves the retail shared value without
 * introducing a source local absent from SYM; copTopSpeed-before-copAccMult
 * preserves the observed store schedule. */

void AIInit_RestartAICar(Car_tObj *carObj)
{
  carObj->desiredDirection = carObj->direction =
      (GameSetup_gData.reverseTrack == 0) ? 1 : -1;
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
  carObj->copTopSpeed = 0x640000;
  carObj->copAccMult = 0x10000;
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
  carObj->damageMult = 0x10000;
  carObj->extraWallCollisionAllowance = 0;
  return;
}

/* ---- AIInit_InitAICar__FP8Car_tObjP10Udff_tInfo  [@0x80067314] ---- */
void AIInit_InitAICar(Car_tObj *carObj,Udff_tInfo *handle)
{
  int gearLoop;
  int accelerationScale;
  
  accelerationScale = 0x10000;
  carObj->redLine = Udff_GetInt(handle);
  Udff_GetBuffer(handle,(char *)carObj->topSpeeds,0x1c);
  for (gearLoop = 0; gearLoop < 7; gearLoop = gearLoop + 1) {
    if (gearLoop == 0) {
      carObj->invTopSpeeds[0] = rdiv(0x10000,carObj->topSpeeds[0]);
    }
    else if (carObj->topSpeeds[gearLoop] == 0) {
      carObj->invTopSpeeds[gearLoop] = 0;
    }
    else {
      carObj->invTopSpeeds[gearLoop] = rdiv(0x10000,carObj->topSpeeds[gearLoop] - carObj->topSpeeds[gearLoop - 1]);
    }
  }
  Udff_GetBuffer(handle,(char *)carObj->accTable,0xe0);
  carObj->aiShiftDuration = Udff_GetInt(handle);
  carObj->max_clacc = Udff_GetInt(handle);
  carObj->max_aa = Udff_GetInt(handle);
  if ((carObj->carFlags & 8U) != 0) {
    int carType;

    carType = carObj->carInfo->carType;
    accelerationScale = AITune_accelerationScale[carType].scale;
  }
  carObj->accelerationRecord = new AIDataRecord_AccTable_t((char *)carObj->accTable,accelerationScale,3);  /* enum body is not emitted in aiinit.obj; ABI name retained by the owner declaration */
  if (AIInit_IsNonStandardCarFile(carObj->carInfo->carType) != 0) {
    carObj->curveSpeedTable = new AIDataRecord_CurveSpeedTable_t(carObj->carName,7);  /* enum body is not emitted in aiinit.obj; ABI name retained by the owner declaration */
  }
  else {
    carObj->curveSpeedTable = (AIDataRecord_CurveSpeedTable_t *)0x0;
  }
  carObj->max_clacc = fixedmult(carObj->max_clacc,0x13333);
  carObj->speedFactor = Udff_GetInt(handle);
  carObj->slackProb = Udff_GetInt(handle);
  carObj->gripFactor = 0x10000;
  carObj->topSpeedUpgradeMult = 0;
  carObj->accUpgradeMult = 0;
  carObj->damageMult = 0x10000;
  return;
}

/* ---- AIInit_DeInitAICar__FP8Car_tObj  [@0x800674e8] ---- */
void AIInit_DeInitAICar(Car_tObj *carObj)
{
  if (carObj->curveSpeedTable != (AIDataRecord_CurveSpeedTable_t *)0x0) {
    delete carObj->curveSpeedTable;
    carObj->curveSpeedTable = (AIDataRecord_CurveSpeedTable_t *)0x0;
  }
  if (carObj->accelerationRecord != (AIDataRecord_AccTable_t *)0x0) {
    delete carObj->accelerationRecord;
    carObj->accelerationRecord = (AIDataRecord_AccTable_t *)0x0;
  }
  return;
}

/* ---- AIInit_InitAICar2__FP8Car_tObj  [@0x80067568] ---- */
void AIInit_InitAICar2(Car_tObj *carObj)
{
  if ((carObj->carFlags & 8U) != 0) {
    (carObj->curveSpeedTable)->Upgrade(AISpeeds_GetUpgradeHandlingMult(carObj->carIndex));
  }
  carObj->accUpgradeMult = AISpeeds_GetUpgradeAccMult(carObj->carIndex);
  carObj->topSpeedUpgradeMult = AISpeeds_GetUpgradeTopSpeedMult(carObj->carIndex);
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
  int nonStandardList [50];

  __builtin_memcpy(nonStandardList,D_8005523C,sizeof nonStandardList);
  return index < 0x32 ? nonStandardList[index] : 0;
}
