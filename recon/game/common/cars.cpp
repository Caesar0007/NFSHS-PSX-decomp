/* game/common/cars.cpp -- RECONSTRUCTED (NFS4 game clock: 128Hz EAC timer chain + master IRQ handler).
 *   3 fns: MasterInterruptHandler / SystemStartUp / SystemCleanUp. SYM-v3 locals; owns 4 globals.
 *   Verified vs disasm-v2.txt (addtimer/deltimer 1-arg = &Clock_MasterInterruptHandler). Self-contained.
 */
#include "../../nfs4_types.h"
#include "cars_externs.h"


/* ---- clock.obj-owned globals (.bss zero) ---- */
int          Cars_topSpeedCap[22] = { 4107141, 3932160, 4653056, 4587520, 4660264, 4631429, 4805754, 4514775, 4543610, 5097390, 5388369, 5417861, 5796003, 6087639, 5825495, 6552944, 7274496, 7274496, 7274496, 7274496, 7274496, 7274496 };   /* @0x8010f828 */
int          Cars_kSmokingSurface[16] = { 0, 0, 655360, 0, 0, 1310720, 0, 0, 0, 655360, 0, 0, 1310720, 1310720, 0, 655360 };   /* @0x8010f880 */
int          Cars_kSkidMarkSurface[16] = { 0, 1, 2, 2, 1, 2, 0, 1, 0, 2, 1, 1, 1, 2, 0, 2 };   /* @0x8010f8c0 */
int          Cars_kConvertFromRoadToSfxType[16] = { 0, 1, 7, 8, 1, 6, 0, 1, 0, 9, 1, 1, 1, 6, 0, 9 };   /* @0x8010f900 */
int          Cars_kAudioRoadSurfaceInterface[16] = { 0, 0, 3, 12, 0, 3, 0, 0, 11, 11, 0, 0, 3, 3, 3, 11 };   /* @0x8010f940 */
int          Cars_kSFXWallSurfaceInterface[8] = { 0, 4, 4, 6, 4, 8, 0, 6 };   /* @0x8010f980 */
int          Cars_kAudioWallSurfaceInterface[8] = { 4, 4, 4, 13, 4, 14, 13, 13 };   /* @0x8010f9a0 */
int          Cars_kAudioCollisoinTypeInterface[7] = { 1, 2, 2, 2, 1, 1, 1 };   /* @0x8010f9c0 */
Car_tObj     *Cars_gList[9];   /* @0x8010f9dc  (bss(zero)) */
Car_tObj     *Cars_gRaceCarList[9];   /* @0x8010fa00  (bss(zero)) */
Car_tObj     *Cars_gAICarList[9];   /* @0x8010fa24  (bss(zero)) */
Car_tObj     *Cars_gHumanRaceCarList[9];   /* @0x8010fa48  (bss(zero)) */
Car_tObj     *Cars_gAIRaceCarList[9];   /* @0x8010fa6c  (bss(zero)) */
Car_tObj     *Cars_gTrafficCarList[9];   /* @0x8010fa90  (bss(zero)) */
Car_tObj     *Cars_gCopCarList[9];   /* @0x8010fab4  (bss(zero)) */
Car_tObj     *Cars_gLifeBasisCarList[9];   /* @0x8010fad8  (bss(zero)) */
Car_tObj     *Cars_gSortedList[9];   /* @0x8010fafc  (bss(zero)) */
Car_tObj     *Cars_gTotalSortedList[9];   /* @0x8010fb20  (bss(zero)) */
Car_tStats   Cars_gNewCarStatsList[9];   /* @0x8010fb44  (bss(zero)) */
BO_tNewtonObj InfiniteMassNewton[5];   /* @0x801100e4  (bss(zero)) */
int          frontLimit = 32768;   /* @0x8013c7e4 */
int          rearLimit = 65536;   /* @0x8013c7e8 */
int          Cars_gNumCars;   /* @0x8013c7f4  (bss(zero)) */
int          Cars_gNumRaceCars;   /* @0x8013c7f8  (bss(zero)) */
int          Cars_gNumAICars;   /* @0x8013c7fc  (bss(zero)) */
int          Cars_gNumHumanRaceCars;   /* @0x8013c800  (bss(zero)) */
int          Cars_gNumAIRaceCars;   /* @0x8013c804  (bss(zero)) */
int          Cars_gNumTrafficCars;   /* @0x8013c808  (bss(zero)) */
int          Cars_gNumCopCars;   /* @0x8013c80c  (bss(zero)) */
int          Cars_gNumLifeBasisCars;   /* @0x8013c810  (bss(zero)) */
int          accidentSlice;   /* @0x8013c814  (bss(zero)) */


/* ---- intra-TU forward declarations ---- */
void Cars_DoGravityEffectsOnAcc(Car_tObj *carObj,int arcade);
void Cars_GetDashData(Car_tObj *carObj,int *rpm,int *gear,int *speed);
void Cars_QDUpdateVelGlue(Car_tObj *carObj);
void Cars_InitDashData(Car_tObj *carObj,int *redline,int *topspeed);
void Cars_SetAudioCalls(Car_tObj *carObj,int type,int chan,int s1,int s2,int force,int pan);
void Cars_ResetCarCounters(void);
void Cars_InitStats(Car_tObj *carObj);
void Cars_InitializeCarTablesFlagsAndCounters(Car_tObj *carObj);
void Cars_ResetVariablesAfterACollision(Car_tObj *carObj);
void Cars_ResetCollidedCars(Car_tObj *carObj,int forceReset,int forceParkAtSide);
void Cars_SetCarUpForHiRezSim(Car_tObj *carObj);
void Cars_DoExtraCarCollisionProcessing(Car_tObj *carObj);
void Car_TireSkiddingStuff(Car_tObj *carObj);
void Cars_FindTotalSlice(Car_tObj *carObj);
void Car_DoSkiddingStuff(Car_tObj *carObj);
void Car_DoPostCollisionStuff(Car_tObj *carObj);
void Cars_CalculateStartingGridOffset(Car_tObj *carObj,int *slice,coorddef *offset);
void Cars_IniCarObjects(Car_tObj *carObj,int index);
void Cars_InitCar(Car_tObj *carObj,int index);
void Cars_DeInitCar(Car_tObj *carObj);
void Cars_Restart(void);
void Cars_Initialize(char *mem,int size);
void Cars_StartUp(void);
void Cars_CleanUp(void);
void Cars_FindCurrentLap(Car_tObj *carObj);
int Cars_CalculateRoadSpan(Car_tObj *carObj);
int Cars_CalculateRoadPosition(Car_tObj *carObj);
int Cars_CalcVelDownRoad(Car_tObj *carObj);
void Cars_Randomize(void);
void Cars_CheckForAccidentScenes(void);


/* ---- Cars_DoGravityEffectsOnAcc__FP8Car_tObji  [@0x80085d84] ---- */
void Cars_DoGravityEffectsOnAcc(Car_tObj *carObj,int arcade)
{
  coorddef gravity_ch;
  int iVar1;
  int iVar2;
  int iVar3;
  
  if ((carObj->carFlags & 0x10U) != 0) {
    return;
  }
  iVar1 = fixedmult(0x10000,(carObj->N).orientMat.m[4]);
  if (iVar1 < 0xb5c2) {
    iVar1 = fixedmult(-0xa0000,(carObj->N).orientMat.m[1]);
    iVar2 = fixedmult(-0xa0000,(carObj->N).orientMat.m[4]);
    iVar3 = fixedmult(-0xa0000,(carObj->N).orientMat.m[7]);
    (carObj->linearAcc_ch).x = (carObj->linearAcc_ch).x + iVar1;
    (carObj->linearAcc_ch).y = (carObj->linearAcc_ch).y + iVar2;
    iVar3 = (carObj->linearAcc_ch).z + iVar3;
  }
  else {
    if (0x3f < (u_char)(carObj->control).brakeLevel) {
      return;
    }
    iVar1 = fixedmult(-0xa0000,(carObj->N).orientMat.m[7]);
    iVar2 = fixedmult(iVar1,(carObj->N).gravityMult);
    iVar1 = iVar2;
    if (iVar2 < 0) {
      iVar1 = -iVar2;
    }
    if (iVar1 < 0xccd) {
      return;
    }
    if (iVar2 < 1) {
      iVar3 = (carObj->linearAcc_ch).z;
      iVar1 = iVar2 >> 3;
      if (iVar3 < 1) {
        iVar1 = iVar2 >> 1;
      }
    }
    else {
      iVar3 = (carObj->linearAcc_ch).z;
      iVar1 = iVar2 >> 1;
      if (iVar3 < 1) {
        iVar1 = iVar2 >> 3;
      }
    }
    iVar3 = iVar3 + iVar1;
  }
  (carObj->linearAcc_ch).z = iVar3;
  return;
}

/* ---- Cars_GetDashData__FP8Car_tObjPiN21  [@0x80085ec4] ---- */
void Cars_GetDashData(Car_tObj *carObj,int *rpm,int *gear,int *speed)
{
  *rpm = carObj->flywheelRpm;
  *gear = (u_int)(u_char)(carObj->control).gear;
  *speed = (carObj->linearVel_ch).z;
  return;
}

/* ---- Cars_QDUpdateVelGlue__FP8Car_tObj  [@0x80085ee8] ---- */
void Cars_QDUpdateVelGlue(Car_tObj *carObj)
{
  /* MATCH: SYM shows the fn is 8 source lines, ONE named local "glue" (REG $a2), spanning
     the whole body -- so glue is the only real C variable; linearVel.x/z corrections are
     plain `/256` divisions on ANONYMOUS temps (compiler mutates them in place), while
     glue/256 is a plain division too but gcc keeps glue itself (a2) pristine + live for its
     own sign test, materializing the /256 quotient into a FRESH reg -- and CSEs the shared
     `glue/256` subexpression across both position.x and position.z updates (computed once). */
  int glue;

  glue = carObj->glue;
  (carObj->N).position.x = (carObj->N).position.x + (((carObj->N).linearVel.x / 256) * (glue / 256) >> 6);
  (carObj->N).position.y = (carObj->N).position.y + ((carObj->N).linearVel.y >> 6);
  (carObj->N).position.z = (carObj->N).position.z + (((carObj->N).linearVel.z / 256) * (glue / 256) >> 6);
  return;
}

/* ---- Cars_InitDashData__FP8Car_tObjPiT1  [@0x80085f64] ---- */
void Cars_InitDashData(Car_tObj *carObj,int *redline,int *topspeed)
{
  *redline = carObj->specs->redline;
  *topspeed = carObj->specs->maxSpeed;
  return;
}

/* ---- Cars_SetAudioCalls__FP8Car_tObjiiiiii  [@0x80085f8c] ---- */
void Cars_SetAudioCalls(Car_tObj *carObj,int type,int chan,int s1,int s2,int force,int pan)
{
  carObj->audio[carObj->audioCount].type = type;
  carObj->audio[carObj->audioCount].channel = chan;
  carObj->audio[carObj->audioCount].surface1 = s1;
  carObj->audio[carObj->audioCount].surface2 = s2;
  carObj->audio[carObj->audioCount].force = force;
  carObj->audio[carObj->audioCount].panangle = pan;
  carObj->audioCount = carObj->audioCount + 1;
  return;
}

/* ---- Cars_ResetCarCounters__Fv  [@0x80086054] ---- */
void Cars_ResetCarCounters(void)
{
  Cars_gNumCars = 0;
  Cars_gNumRaceCars = 0;
  Cars_gNumAICars = 0;
  Cars_gNumHumanRaceCars = 0;
  Cars_gNumAIRaceCars = 0;
  Cars_gNumTrafficCars = 0;
  Cars_gNumCopCars = 0;
  Cars_gNumLifeBasisCars = 0;
  return;
}

/* ---- Cars_InitStats__FP8Car_tObj  [@0x8008607c] ---- */
void Cars_InitStats(Car_tObj *carObj)
{
  /* MATCH: EVERY field access shares ONE base pointer `stats = &carObj->stats` (oracle
     materializes `a0 = carObj+0x34C` ONCE, reused for all offsets incl. the loop) --
     the prior `(carObj->stats).xxx` form re-derived carObj+K per access (raw big
     offsets, no shared base). The time[]/topSpeed[] loop is array-indexed (not a
     pointer-walk pCVar1) -- a pointer-walk gave pCVar1 its own independent anchor. */
  Car_tStats *stats;
  int iVar2;

  iVar2 = 0;
  stats = &carObj->stats;
  stats->sliceTotal = 0;
  stats->sliceTime = 0;
  stats->slice = 0;
  stats->lastSlice = 0;
  stats->lap = 0;
  stats->lapTime = 0x200;
  do {
    stats->time[iVar2] = 0;
    stats->topSpeed[iVar2] = 0;
    iVar2 = iVar2 + 1;
  } while (iVar2 < 4);
  stats->position = 0;
  stats->fatalCrashes = 0;
  stats->finishType = 0;
  stats->checkpointUpdate = 0;
  stats->checkpointDifference = 0;
  stats->checkpointDisplay = 0;
  stats->numWarnings = 0;
  stats->numFines = 0;
  stats->numArrests = 0;
  return;
}

/* ---- Cars_InitializeCarTablesFlagsAndCounters__FP8Car_tObj  [@0x800860e4] ---- */
void Cars_InitializeCarTablesFlagsAndCounters(Car_tObj *carObj)
{
  int carClass;
  int personality;
  char *pcVar1;
  void *pvVar2;
  Car_tObj **ppCVar3;
  u_int uVar4;
  int iVar5;
  GameSetup_tCarData *pGVar6;
  u_int uVar7;
  
  uVar7 = carObj->carInfo->carClass;
  Cars_gList[Cars_gNumCars] = carObj;
  Cars_gSortedList[Cars_gNumCars] = carObj;
  Cars_gTotalSortedList[Cars_gNumCars] = carObj;
  carObj->carIndex = Cars_gNumCars;
  Cars_gNumCars = Cars_gNumCars + 1;
  carObj->carFlags = 0;
  carObj->humanIndex = -1;
  strcpy(carObj->carName,GameSetup_gCarNames[0] + carObj->carInfo->carType * 5)
  ;
  iVar5 = carObj->carInfo->carType;
  if (iVar5 < 0x1d) {
    pcVar1 = TextSys_Word(iVar5 + 0x4e);
    strcpy(carObj->carNameLocalized,pcVar1);
  }
  else {
    sprintf(carObj->carNameLocalized,(char *)(Camera_gGeomScreen + 2));
  }
  if ((uVar7 & 1) == 0) goto LAB_80086300;
  pvVar2 = PlayerNameExist(Cars_gNumHumanRaceCars);
  if (pvVar2 == (void *)0x0) {
    if (frontEnd.gameMode != '\x01') {
      pcVar1 = TextSys_Word(0x2e);
      goto LAB_80086234;
    }
    pcVar1 = TextSys_Word(0x2f);
    sprintf(carObj->carInfo->driver,pcVar1);
  }
  else {
    pcVar1 = PlayerNameMixedCase(Cars_gNumHumanRaceCars);
LAB_80086234:
    sprintf(carObj->carInfo->driver,pcVar1);
  }
  strcpy(carObj->carInfo->license,frontEnd.licensePlate[Cars_gNumHumanRaceCars * 4]);
  ppCVar3 = Cars_gHumanRaceCarList + Cars_gNumHumanRaceCars;
  carObj->humanIndex = Cars_gNumHumanRaceCars;
  Cars_gNumHumanRaceCars = Cars_gNumHumanRaceCars + 1;
  *ppCVar3 = carObj;
  carObj->carFlags = carObj->carFlags | 4;
  ppCVar3 = Cars_gRaceCarList + Cars_gNumRaceCars;
  Cars_gNumRaceCars = Cars_gNumRaceCars + 1;
  *ppCVar3 = carObj;
  carObj->carFlags = carObj->carFlags | 1;
  Cars_gLifeBasisCarList[Cars_gNumLifeBasisCars] = carObj;
  uVar4 = carObj->carFlags;
  Cars_gNumLifeBasisCars = Cars_gNumLifeBasisCars + 1;
  carObj->carFlags = uVar4 | 0x100;
  if ((uVar7 & 0x40) != 0) {
    carObj->carFlags = uVar4 | 0x300;
  }
LAB_80086300:
  if ((uVar7 & 2) != 0) {
    iVar5 = GameSetup_gData.carInfo[carObj->carIndex].Personality;
    strcpy(carObj->carInfo->driver,GameSetup_gPersonalityNames[0] + iVar5 * 8);
    if (((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&
       ((((*(int *)((char *)carObj + 0x260)) & 0x200) != 0 ||
        ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)carObj + 0x260)) & 0x200) != 0)))))) {
      pcVar1 = TextSys_Word(0x32);
      pGVar6 = carObj->carInfo;
    }
    else {
      pGVar6 = carObj->carInfo;
      pcVar1 = GameSetup_gPersonalityNames[0] + iVar5 * 8;
    }
    strcpy(pGVar6->license,pcVar1);
    s_lower(carObj->carInfo->license);
    Cars_gAICarList[Cars_gNumAICars] = carObj;
    Cars_gNumAICars = Cars_gNumAICars + 1;
    carObj->carFlags = carObj->carFlags | 2;
    Cars_gAIRaceCarList[Cars_gNumAIRaceCars] = carObj;
    Cars_gNumAIRaceCars = Cars_gNumAIRaceCars + 1;
    carObj->carFlags = carObj->carFlags | 8;
    Cars_gRaceCarList[Cars_gNumRaceCars] = carObj;
    carObj->carFlags = carObj->carFlags | 1;
    Cars_gNumRaceCars = Cars_gNumRaceCars + 1;
    if ((GameSetup_gData.cops != 0) &&
       (((GameSetup_gData.raceType != 1 && (GameSetup_gData.raceType != 5)) ||
        ((((*(int *)((char *)carObj + 0x260)) & 0x200) == 0 &&
         ((Cars_gNumHumanRaceCars != 2 || (((*(int *)((char *)carObj + 0x260)) & 0x200) == 0)))))))) {
      Cars_gLifeBasisCarList[Cars_gNumLifeBasisCars] = carObj;
      Cars_gNumLifeBasisCars = Cars_gNumLifeBasisCars + 1;
      carObj->carFlags = carObj->carFlags | 0x100;
    }
  }
  if ((uVar7 & 4) != 0) {
    ppCVar3 = Cars_gAICarList + Cars_gNumAICars;
    Cars_gNumAICars = Cars_gNumAICars + 1;
    *ppCVar3 = carObj;
    carObj->carFlags = carObj->carFlags | 2;
    Cars_gTrafficCarList[Cars_gNumTrafficCars] = carObj;
    Cars_gNumTrafficCars = Cars_gNumTrafficCars + 1;
    carObj->carFlags = carObj->carFlags | 0x10;
  }
  if ((uVar7 & 0x18) != 0) {
    ppCVar3 = Cars_gAICarList + Cars_gNumAICars;
    Cars_gNumAICars = Cars_gNumAICars + 1;
    *ppCVar3 = carObj;
    carObj->carFlags = carObj->carFlags | 2;
    Cars_gCopCarList[Cars_gNumCopCars] = carObj;
    uVar4 = carObj->carFlags;
    Cars_gNumCopCars = Cars_gNumCopCars + 1;
    carObj->carFlags = uVar4 | 0x20;
    if ((uVar7 & 0x10) != 0) {
      carObj->carFlags = uVar4 | 0x60;
    }
  }
  return;
}

/* ---- Cars_ResetVariablesAfterACollision__FP8Car_tObj  [@0x800865fc] ---- */
void Cars_ResetVariablesAfterACollision(Car_tObj *carObj)
{
  (carObj->N).angularVel.x = 0;
  (carObj->N).angularVel.y = 0;
  (carObj->N).angularVel.z = 0;
  (carObj->angularVel_ch).x = 0;
  (carObj->angularVel_ch).y = 0;
  (carObj->angularVel_ch).z = 0;
  (carObj->linearAcc_ch).x = 0;
  (carObj->linearAcc_ch).y = 0;
  (carObj->linearAcc_ch).z = 0;
  (carObj->N).flightTime = 0;
  (carObj->N).collision.collided = 0;
  (carObj->N).collision.lastCollision = 0;
  (carObj->N).collision.impulse = 0;
  (carObj->N).collision.otherObj = (BO_tNewtonObj *)0x0;
  (carObj->N).collision.disableCollisionTimer = 0;
  (carObj->N).groundVel = 0;
  (carObj->N).speedXZ = 0;
  (carObj->collision).smoking = 0;
  (carObj->N).roadGravityModifier = 0;
  Physics_ResetCar(carObj);
  return;
}

/* ---- Cars_ResetCollidedCars__FP8Car_tObjii  [@0x80086664] ---- */
void Cars_ResetCollidedCars(Car_tObj *carObj,int forceReset,int forceParkAtSide)
{
  int y;
  int newSlice;
  coorddef offset;
  int resetCounter;
  int side;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  u_int uVar6;
  int iVar7;
  int direction;
  coorddef local_28;
  
  memset((u_char *)&local_28,'\0',0xc);
  iVar1 = carObj->blowout;
  direction = carObj->desiredDirection;
  (carObj->collision).smoking = 0;
  if (iVar1 != 0) {
LAB_800867d0:
    (carObj->collision).smoking = 0;
    return;
  }
  if (forceReset == 0) {
    iVar1 = (carObj->N).roadMatrix.m[3];
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    iVar2 = (carObj->N).orientMat.m[3];
    if (iVar2 < 0) {
      iVar2 = iVar2 + 0xff;
    }
    iVar5 = (carObj->N).roadMatrix.m[4];
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    iVar3 = (carObj->N).orientMat.m[4];
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xff;
    }
    iVar7 = (carObj->N).roadMatrix.m[5];
    if (iVar7 < 0) {
      iVar7 = iVar7 + 0xff;
    }
    iVar4 = (carObj->N).orientMat.m[5];
    if (iVar4 < 0) {
      iVar4 = iVar4 + 0xff;
    }
    if ((((0xc000 < (iVar1 >> 8) * (iVar2 >> 8) + (iVar5 >> 8) * (iVar3 >> 8) +
                    (iVar7 >> 8) * (iVar4 >> 8)) && ((carObj->N).angularVel.x < 0x10000)) &&
        ((carObj->N).angularVel.z < 0x10000)) &&
       (((iVar1 = (carObj->N).driveSurfaceType, iVar1 != 0xe && (iVar1 != 0)) &&
        (((carObj->N).simRoadInfo.simQuad != (Trk_NewSimQuad *)0x0 &&
         (((carObj->N).flightTime < 6 && ((carObj->N).objAltitude < 0x10000))))))))
    goto LAB_800867d0;
  }
  iVar1 = (int)(carObj->N).simRoadInfo.slice + direction * 4;
  if (direction * 4 < 0) {
    if (iVar1 < 0) {
      iVar1 = iVar1 + gNumSlices;
    }
  }
  else if (gNumSlices <= iVar1) {
    iVar1 = iVar1 - gNumSlices;
  }
  if (forceReset == 2) {
    iVar1 = (int)(carObj->N).simRoadInfo.slice;
  }
  iVar2 = accidentSlice + 5;
  if (0 < accidentSlice) {
    if (gNumSlices <= iVar2) {
      iVar2 = accidentSlice - (gNumSlices + -5);
    }
    if (iVar1 < iVar2) {
      iVar2 = accidentSlice + -5;
      if (iVar2 < 0) {
        iVar2 = accidentSlice + gNumSlices + -5;
      }
      if (iVar2 < iVar1) {
        iVar1 = iVar1 + direction * 5;
        if (direction * 5 < 0) {
          iVar2 = gNumSlices;
          if (-1 < iVar1) goto LAB_80086908;
        }
        else {
          if (iVar1 < gNumSlices) goto LAB_80086908;
          iVar2 = -gNumSlices;
        }
        iVar1 = iVar1 + iVar2;
      }
    }
  }
LAB_80086908:
  uVar6 = (u_int)(carObj->carIndex / 2 << 1 != carObj->carIndex);
  if (direction == -1) {
    uVar6 = 1 - uVar6;
  }
  if (AITune_driveSide == -1) {
    uVar6 = 1 - uVar6;
  }
  if (uVar6 == 0) {
    iVar2 = iVar1 * 0x20 + BWorldSm_slices;
    iVar5 = (carObj->N).dimension.x;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_28.x = (u_int)*(u_char *)(iVar2 + 0x1f) * 0x8000 * (*(u_char *)(iVar2 + 0x1d) & 0xf) +
                 (iVar5 >> 8) * -0x180;
  }
  else {
    iVar2 = iVar1 * 0x20 + BWorldSm_slices;
    iVar5 = (carObj->N).dimension.x;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_28.x = (iVar5 >> 8) * 0x180 -
                 (u_int)*(u_char *)(iVar2 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar2 + 0x1d) >> 4);
  }
  Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,iVar1,&local_28,direction);
  iVar2 = (carObj->N).driveSurfaceType;
  iVar5 = 0;
  while( true ) {
    if (((iVar2 != 0) && (iVar2 != 0xe)) &&
       ((carObj->N).simRoadInfo.simQuad != (Trk_NewSimQuad *)0x0)) goto LAB_80086a94;
    iVar5 = iVar5 + 1;
    Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,iVar1,&local_28,direction);
    if (0x28 < iVar5) break;
    iVar2 = (carObj->N).driveSurfaceType;
  }
  local_28.x = 0;
  Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,iVar1,&local_28,direction);
LAB_80086a94:
  (carObj->N).linearVel.z = 0;
  (carObj->N).linearVel.y = 0;
  (carObj->N).linearVel.x = 0;
  Cars_ResetVariablesAfterACollision(carObj);
  return;
}

/* ---- Cars_SetCarUpForHiRezSim__FP8Car_tObj  [@0x80086ac4] ---- */
void Cars_SetCarUpForHiRezSim(Car_tObj *carObj)
{
  u_int bVar1;
  Trk_NewSimQuad *pTVar2;

  bVar1 = (carObj->N).simOptz;
  (carObj->collision).smoking = 0;
  if (bVar1 < 2) {
    BWorldSm_FindClosestQuadRez(&(carObj->N).position,&(carObj->N).simRoadInfo,1);
    pTVar2 = (carObj->N).simRoadInfo.simQuad;
    if ((pTVar2 != (Trk_NewSimQuad *)0x0) && ((pTVar2->surface & 0xf) == 0)) {
      Cars_ResetCollidedCars(carObj,1,0);
    }
  }
  return;
}

/* ---- Cars_DoExtraCarCollisionProcessing__FP8Car_tObj  [@0x80086b38] ---- */
void Cars_DoExtraCarCollisionProcessing(Car_tObj *carObj)
{
  int y;
  int wheel;
  int roadSurfaceWheel;
  int surfaceType;
  coorddef position;
  coorddef point;
  coorddef sideX;
  coorddef sideZ;
  int surface1;
  int surface2;
  int collisionType;
  int debris;
  coorddef impactPoint;
  bool bVar1;
  int iVar2;
  u_int uVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  u_short uVar9;
  u_int uVar10;
  coorddef local_58;
  coorddef local_48;
  int local_38;
  int local_34;
  int local_30;
  u_int local_28;
  u_int local_24;
  u_int local_20;
  
  if ((carObj->carFlags & 0x400U) != 0) {
    return;
  }
  if (carObj->blowout == 0) {
LAB_80086bf0:
    if ((((carObj->pullOver != 0) || ((carObj->control).abort == '\0')) ||
        ((carObj->stats).finishType != 0)) || (simGlobal.gameTicks < 0x341)) goto LAB_80086cd0;
    iVar2 = (carObj->stats).fatalCrashes;
    if (iVar2 == 0) {
      if ((carObj->N).speedXZ < 0x1b9999) {
        Cars_ResetCollidedCars(carObj,2,0);
        (carObj->stats).fatalCrashes = 0xa0;
        bVar1 = carObj == (Car_tObj *)0x0;
        Camera_gInfo[bVar1].relpos.x = (carObj->N).orientMat.m[6] * -2;
        Camera_gInfo[bVar1].relpos.y = (carObj->N).orientMat.m[7] * -2;
        Camera_gInfo[bVar1].relpos.z = (carObj->N).orientMat.m[8] * -2;
      }
      goto LAB_80086cd0;
    }
  }
  else {
    iVar2 = (carObj->linearVel_ch).z;
    if (iVar2 < 0) {
      iVar2 = -iVar2;
    }
    if (iVar2 < 0x1999) {
      iVar2 = (carObj->linearVel_ch).x;
      if (iVar2 < 0) {
        iVar2 = -iVar2;
      }
      if (iVar2 < 0x1999) {
        carObj->blowout = carObj->blowout + 1;
      }
    }
    if (0x140 < carObj->blowout) {
      carObj->blowout = 0;
      Cars_ResetCollidedCars(carObj,1,0);
    }
    if (carObj->blowout == 0) goto LAB_80086bf0;
LAB_80086cd0:
    iVar2 = (carObj->stats).fatalCrashes;
  }
  if (0 < iVar2) {
    (carObj->stats).fatalCrashes = iVar2 + -1;
  }
  if (((carObj->collision).smoking != 0) &&
     (TrgSfx_CrashCar(&(carObj->N).position),
     (carObj->N).flightTime == 0)) {
    (carObj->collision).smoking = 0;
  }
  if ((carObj->audioDamageScrape != 0) && ((carObj->N).simOptz == '\0')) {
    uVar10 = 2;
    if ((carObj->render).currentRoll < 0) {
      uVar10 = 3;
    }
    if ((Cars_kSkidMarkSurface[carObj->wheel[uVar10].roadSurfaceType & 0xf] == 1) &&
       (uVar3 = random(), (uVar3 & 3) == 0)) {
      iVar2 = (carObj->N).wheelBackX;
      if (iVar2 < 0) {
        iVar2 = iVar2 + 0xff;
      }
      local_38 = (iVar2 >> 8) * (carObj->N).orientMat.m[0];
      if (local_38 < 0) {
        local_38 = local_38 + 0xff;
      }
      local_38 = local_38 >> 8;
      iVar2 = (carObj->N).wheelBackX;
      if (iVar2 < 0) {
        iVar2 = iVar2 + 0xff;
      }
      local_34 = (iVar2 >> 8) * (carObj->N).orientMat.m[1];
      if (local_34 < 0) {
        local_34 = local_34 + 0xff;
      }
      local_34 = local_34 >> 8;
      iVar2 = (carObj->N).wheelBackX;
      if (iVar2 < 0) {
        iVar2 = iVar2 + 0xff;
      }
      local_30 = (iVar2 >> 8) * (carObj->N).orientMat.m[2];
      if (local_30 < 0) {
        local_30 = local_30 + 0xff;
      }
      local_30 = local_30 >> 8;
      local_28 = 0;
      local_24 = 0;
      local_20 = 0;
      local_58.x = (carObj->N).position.x;
      local_58.z = (carObj->N).position.z;
      local_58.y = (carObj->N).groundElevation;
      local_48.z = local_30;
      local_48.x = local_38;
      local_48.y = local_34;
      if ((uVar10 & 1) == 0) {
        local_48.z = -local_30;
        local_48.x = -local_38;
        local_48.y = -local_34;
      }
      local_48.y = local_58.y + local_48.y;
      local_48.x = local_58.x + local_48.x;
      local_48.z = local_58.z + local_48.z;
      TrgSfx_AddCarSfx((carObj->N).objID,&local_48,4,&(carObj->N).linearVel);
    }
    carObj->audioDamageScrape = 0;
  }
  bVar1 = false;
  if ((carObj->N).collision.impulse == 0) goto LAB_80087310;
  uVar10 = (carObj->N).collision.sfxType & 0xefff0000;
  if (carObj->carInfo->carType < 0x1c) {
    uVar9 = (carObj->render).damageParts;
    if ((uVar9 & 1) == 0) {
      bVar1 = 0x1e0000 < (carObj->N).damage[7];
      if (bVar1) {
        (carObj->render).damageParts = uVar9 | 1;
        uVar9 = (carObj->render).damageParts;
      }
    }
    if (((uVar9 & 2) == 0) && (0x1e0000 < (carObj->N).damage[3])) {
      (carObj->render).damageParts = uVar9 | 2;
      bVar1 = true;
    }
    uVar9 = (carObj->render).damageParts;
    if (((uVar9 & 4) == 0) && (0x30000 < (carObj->N).damage[8])) {
      (carObj->render).damageParts = uVar9 | 4;
      bVar1 = true;
      uVar9 = (carObj->render).damageParts;
    }
    if (((uVar9 & 8) == 0) && (0x1e0000 < (carObj->N).damage[0])) {
      (carObj->render).damageParts = uVar9 | 8;
      bVar1 = true;
    }
    uVar9 = (carObj->render).damageParts;
    if (((uVar9 & 0x10) == 0) && (0x1e0000 < (carObj->N).damage[2])) {
      (carObj->render).damageParts = uVar9 | 0x10;
      bVar1 = true;
      uVar9 = (carObj->render).damageParts;
    }
    if (((uVar9 & 0x20) == 0) && (0x1e0000 < (carObj->N).damage[6])) {
      (carObj->render).damageParts = uVar9 | 0x20;
      bVar1 = true;
    }
    uVar9 = (carObj->render).damageParts;
    if (((uVar9 & 0x40) == 0) && (0x1e0000 < (carObj->N).damage[4])) {
      (carObj->render).damageParts = uVar9 | 0x40;
      bVar1 = true;
    }
  }
  if (((carObj->N).collision.otherObj == (BO_tNewtonObj *)0x0) &&
     (0x4b0000 < (carObj->N).collision.impulse)) {
    if ((carObj->carFlags & 4U) != 0) {
      Physics_FixEngineRpm(carObj);
    }
    TrgSfx_CrashCar(&(carObj->N).position);
    iVar2 = (carObj->collision).resetTimer;
    (carObj->collision).smoking = 1;
    carObj->frontSkid = 0;
    carObj->rearSkid = 0;
    if (iVar2 < 1) {
      (carObj->collision).resetTimer = 0x140;
    }
  }
  if (uVar10 == 0x40000) {
    local_58.x = (carObj->N).collision.collisionPoint.x;
    local_58.z = (carObj->N).collision.collisionPoint.z;
    local_58.y = (carObj->N).collision.collisionPoint.y + 0x8000;
    iVar2 = (carObj->N).speedXZ;
    if (iVar2 < 0x180001) {
      if (((0xf0000 < iVar2) || (0xf0000 < (carObj->N).collision.impulse)) || (bVar1)) {
        iVar2 = (carObj->N).objID;
        iVar4 = 1;
        goto LAB_800871e0;
      }
    }
    else if ((carObj->N).objAltitude < 0x9999) {
      TrgSfx_AddCarSfx((carObj->N).objID,&local_58,
                 Cars_kSFXWallSurfaceInterface[(u_char)(carObj->N).collision.sfxType],
                 &(carObj->N).linearVel);
      if (Cars_kSFXWallSurfaceInterface[(u_char)(carObj->N).collision.sfxType] == 4) {
        Cars_SetAudioCalls(carObj,1,-1,1,0xf,0,0);
      }
    }
    else {
      iVar2 = (carObj->N).objID;
      iVar4 = 6;
LAB_800871e0:
      TrgSfx_AddCarSfx(iVar2,&local_58,iVar4,&(carObj->N).linearVel);
    }
  }
  if (0xa0000 < (carObj->N).collision.impulse) {
    iVar2 = *(int *)((int)Cars_kAudioCollisoinTypeInterface + ((int)uVar10 >> 0xe));
    if (uVar10 == 0x40000) {
      uVar3 = Cars_kAudioWallSurfaceInterface[(u_char)(carObj->N).collision.sfxType];
    }
    else if ((int)uVar10 < 0x30001) {
      uVar3 = Cars_kAudioRoadSurfaceInterface[(u_char)(carObj->N).collision.sfxType];
      if (uVar10 == 0x30000) {
        if ((carObj->N).orientationToGround.y < 0xe666) {
          iVar2 = 1;
        }
        TrgSfx_CrashCar(&(carObj->N).collision.collisionPoint)
        ;
      }
    }
    else {
      uVar3 = (u_int)(u_char)(carObj->N).collision.sfxType;
      if (uVar10 == 0x50000) {
        local_58.x = (carObj->N).collision.collisionPoint.x;
        local_58.z = (carObj->N).collision.collisionPoint.z;
        local_58.y = (carObj->N).collision.collisionPoint.y + 0x8000;
        TrgSfx_AddCarSfx((carObj->N).objID,&local_58,4,&(carObj->N).linearVel);
      }
    }
    iVar4 = (carObj->N).collision.impulse;
    if (iVar4 < 0) {
      iVar4 = iVar4 + 7;
    }
    Cars_SetAudioCalls(carObj,1,-1,iVar2,uVar3,iVar4 >> 3,0);
  }
  (carObj->N).collision.impulse = 0;
  (carObj->N).collision.otherObj = (BO_tNewtonObj *)0x0;
  (carObj->N).collision.sfxType = 0;
LAB_80087310:
  iVar2 = (carObj->collision).resetTimer;
  if ((0 < iVar2) && (carObj->pullOver == 0)) {
    (carObj->collision).resetTimer = iVar2 + -1;
    iVar2 = (carObj->N).linearVel.y;
    if (iVar2 < 0) {
      iVar2 = -iVar2;
    }
    if ((((carObj->N).speedXZ + iVar2 < 0x10000) ||
        (iVar2 = (carObj->N).driveSurfaceType, iVar2 == 0)) || (iVar2 == 0xe)) {
      (carObj->collision).resetTimer = (carObj->collision).resetTimer + -8;
    }
    if ((carObj->collision).resetTimer < 1) {
      Cars_ResetCollidedCars(carObj,0,0);
      (carObj->collision).resetTimer = 0;
    }
  }
  iVar2 = (carObj->N).roadMatrix.m[3];
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar4 = (carObj->N).orientMat.m[3];
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar7 = (carObj->N).roadMatrix.m[4];
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  iVar5 = (carObj->N).orientMat.m[4];
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  iVar8 = (carObj->N).roadMatrix.m[5];
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  iVar6 = (carObj->N).orientMat.m[5];
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  if (((carObj->collision).resetTimer < 1) &&
     ((((iVar2 >> 8) * (iVar4 >> 8) + (iVar7 >> 8) * (iVar5 >> 8) + (iVar8 >> 8) * (iVar6 >> 8) <
        0x1999 || (iVar2 = (carObj->N).driveSurfaceType, iVar2 == 0)) || (iVar2 == 0xe)))) {
    (carObj->collision).resetTimer = 0x140;
  }
  return;
}

/* ---- Cars_AddCarSfx__FP8Car_tObjiP8coorddefiii  [@0x8008748c] ---- */
void Cars_AddCarSfx(Car_tObj *carObj,int wheel,coorddef *skidpt,int roadSurface,int surfaceType,
               int drawSkid)
{
  int objID;
  int sfxType;
  int stateBit;
  int smoking;
  int traffic;
  int sfxDelay;
  int skid;
  short sVar1;
  bool bVar2;
  int iVar3;
  int iVar4;
  int car;
  u_int uVar5;
  int delay;
  int iVar6;
  int type;
  
  iVar6 = Cars_kSmokingSurface[roadSurface & 0xfU];
  uVar5 = 1 << (wheel);
  car = (carObj->N).objID;
  type = Cars_kConvertFromRoadToSfxType[roadSurface & 0xfU];
  if (surfaceType == 3) {
    iVar6 = 0;
  }
  sVar1 = (carObj->render).currentCarType;
  bVar2 = 0x1c < sVar1;
  delay = gTAddCarWheelDelay;
  if (bVar2) {
    delay = gTAddCarWheelDelay << 1;
  }
  if (sVar1 == 0x1c) {
    return;
  }
  if (wheel < 2) {
    if (((drawSkid == 0) || (surfaceType == 0)) || (bVar2)) {
      if ((carObj->oldSkidState & uVar5) != 0) {
        TrgSfx_AddSkidmark(car,wheel,carObj->oldSkidPoint + wheel,1,carObj->frontSkid,carObj,0);
        uVar5 = carObj->oldSkidState - uVar5;
        goto LAB_80087818;
      }
    }
    else if ((skidpt->x != carObj->oldSkidPoint[wheel].x) ||
            (skidpt->z != carObj->oldSkidPoint[wheel].z)) {
      if (wheel == 0) {
        iVar3 = carObj->frontSkid - carObj->gTransferRight;
      }
      else {
        iVar3 = carObj->frontSkid + carObj->gTransferRight;
      }
      iVar4 = iVar3 + -0x18000;
      if (iVar4 < 0) {
        iVar4 = 0;
      }
      iVar3 = iVar3 + -0x18000;
      if (iVar4 < 0x60001) {
        if (iVar3 < 0) {
          iVar3 = 0;
        }
      }
      else {
        iVar3 = 0x60000;
      }
      TrgSfx_AddSkidmark(car,wheel,skidpt,0,iVar3,carObj,surfaceType + -1);
      iVar3 = skidpt->y;
      iVar4 = skidpt->z;
      carObj->oldSkidPoint[wheel].x = skidpt->x;
      carObj->oldSkidPoint[wheel].y = iVar3;
      carObj->oldSkidPoint[wheel].z = iVar4;
      uVar5 = carObj->oldSkidState | uVar5;
LAB_80087818:
      carObj->oldSkidState = uVar5;
    }
    if (type == 8) goto LAB_80087828;
    if ((iVar6 < (carObj->N).speedXZ) && (0 < iVar6)) goto LAB_80087888;
    iVar6 = carObj->frontSkid;
  }
  else {
    if (((drawSkid == 0) || (surfaceType == 0)) || (bVar2)) {
      if ((carObj->oldSkidState & uVar5) != 0) {
        TrgSfx_AddSkidmark(car,wheel,carObj->oldSkidPoint + wheel,1,carObj->rearSkid,carObj,0);
        uVar5 = carObj->oldSkidState - uVar5;
        goto LAB_8008768c;
      }
    }
    else if ((skidpt->x != carObj->oldSkidPoint[wheel].x) ||
            (skidpt->z != carObj->oldSkidPoint[wheel].z)) {
      if (wheel == 2) {
        iVar3 = carObj->rearSkid - carObj->gTransferRight;
      }
      else {
        iVar3 = carObj->rearSkid + carObj->gTransferRight;
      }
      iVar4 = iVar3 + -0x10000;
      if (iVar4 < 0) {
        iVar4 = 0;
      }
      iVar3 = iVar3 + -0x10000;
      if (iVar4 < 0x60001) {
        if (iVar3 < 0) {
          iVar3 = 0;
        }
      }
      else {
        iVar3 = 0x60000;
      }
      TrgSfx_AddSkidmark(car,wheel,skidpt,0,iVar3,carObj,surfaceType + -1);
      iVar3 = skidpt->y;
      iVar4 = skidpt->z;
      carObj->oldSkidPoint[wheel].x = skidpt->x;
      carObj->oldSkidPoint[wheel].y = iVar3;
      carObj->oldSkidPoint[wheel].z = iVar4;
      uVar5 = carObj->oldSkidState | uVar5;
LAB_8008768c:
      carObj->oldSkidState = uVar5;
    }
    if (type == 8) {
LAB_80087828:
      TrgSfx_AddCarSplash(car,wheel,skidpt,8,&(carObj->N).linearVel,delay,(carObj->N).speedXZ);
      return;
    }
    if ((iVar6 < (carObj->N).speedXZ) && (0 < iVar6)) goto LAB_80087888;
    iVar6 = carObj->rearSkid;
  }
  if (iVar6 < 0x40001) {
    return;
  }
LAB_80087888:
  TrgSfx_AddCarWheelSfx(car,wheel,skidpt,type,&(carObj->N).linearVel,delay);
  return;
}

/* ---- Car_TireSkiddingStuff__FP8Car_tObj  [@0x800878cc] ---- */
void Car_TireSkiddingStuff(Car_tObj *carObj)
{
  coorddef position;
  coorddef point;
  int visible;
  int audioSurface;
  int front;
  int rear;
  int skidFront;
  int originalFront;
  int originalRear;
  int roadSurface;
  int roadSurfaceWheel;
  int surfaceType;
  int speed;
  int wetRoad;
  coorddef wheelFrontX;
  coorddef wheelFrontZ;
  int rndOffset;
  coorddef wheelBackX;
  coorddef wheelBackZ;
  short sVar1;
  bool bVar2;
  bool bVar3;
  void *pvVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  u_int uVar10;
  int local_88;
  int local_84;
  int local_80;
  coorddef local_78;
  int local_68;
  int local_64;
  int local_60;
  int local_58;
  int local_54;
  int local_50;
  int local_48;
  int local_44;
  int local_40;
  int local_38;
  int local_34;
  int local_30;
  
  bVar3 = false;
  sVar1 = *(short *)((int)&(carObj->N).speedXZ + 2);
  bVar2 = false;
  if (GameSetup_gData.Weather != 0) {
    pvVar4 = BWorldSm_TunnelFlagSm(&(carObj->N).simRoadInfo);
    bVar2 = pvVar4 != (void *)0x1;
  }
  iVar9 = (carObj->N).driveSurfaceType;
  if (((carObj->N).distToPlayer < 0x3c0000) && ((carObj->N).objAltitude < 0x6666)) {
    bVar3 = true;
  }
  if (bVar3) {
    local_88 = (carObj->N).position.x;
    local_80 = (carObj->N).position.z;
    local_84 = (carObj->N).groundElevation;
    iVar6 = carObj->frontSkid;
    if (iVar6 < 1) {
      local_34 = 0;
      iVar6 = local_34;
    }
    else {
      local_34 = 0xa0000;
      if (iVar6 < 0xa0001) {
        local_34 = iVar6;
      }
      iVar8 = (carObj->linearVel_ch).z;
      iVar7 = iVar8;
      if (iVar8 < 0) {
        iVar7 = -iVar8;
      }
      carObj->frontSkid = local_34;
      iVar6 = local_34;
      if (0x140000 < iVar7) {
        if (iVar8 < 0) {
          iVar8 = iVar8 + 7;
        }
        iVar8 = iVar8 >> 3;
        if (iVar8 < 0) {
          iVar8 = -iVar8;
        }
        iVar6 = local_34 - iVar8;
      }
    }
    iVar7 = carObj->rearSkid;
    if (iVar7 < 1) goto LAB_80087a54;
    local_30 = 0xa0000;
    if (iVar7 < 0xa0001) {
      local_30 = iVar7;
    }
    carObj->rearSkid = local_30;
  }
  else {
    iVar6 = 0;
    local_34 = 0;
LAB_80087a54:
    local_30 = 0;
  }
  iVar8 = local_30;
  iVar7 = local_34;
  local_38 = Cars_kAudioRoadSurfaceInterface[iVar9];
  if (GameSetup_gData.Weather < 1) {
    if (local_38 == 0) {
      iVar9 = carObj->carInfo->TireType;
      if (iVar9 == 0) {
        local_38 = 0x12;
      }
      else if (iVar9 == 2) {
        local_38 = 0x11;
      }
    }
  }
  else if ((local_38 == 0) &&
          (pvVar4 = BWorldSm_TunnelFlagSm(&(carObj->N).simRoadInfo), pvVar4 != (void *)0x1)) {
    local_38 = 0x10;
  }
  uVar10 = carObj->wheel[0].roadSurfaceType;
  iVar9 = Cars_kSkidMarkSurface[uVar10 & 0xf];
  if (carObj->wheel[0].wheelInAir != 0) {
    iVar9 = 0;
  }
  if ((((iVar7 == 0) || (bVar2)) && ((iVar9 < 2 || (sVar1 == 0)))) || (!bVar3)) {
    if ((carObj->oldSkidState & 1U) != 0) {
      carObj->oldSkidState = carObj->oldSkidState - 1;
      TrgSfx_AddSkidmark((carObj->N).objID,0,carObj->oldSkidPoint,1,carObj->frontSkid,carObj,0);
    }
  }
  else {
    iVar5 = (carObj->N).wheelFrontX;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_68 = (iVar5 >> 8) * (carObj->N).orientMat.m[0];
    if (local_68 < 0) {
      local_68 = local_68 + 0xff;
    }
    local_68 = local_68 >> 8;
    iVar5 = (carObj->N).wheelFrontX;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_64 = (iVar5 >> 8) * (carObj->N).orientMat.m[1];
    if (local_64 < 0) {
      local_64 = local_64 + 0xff;
    }
    local_64 = local_64 >> 8;
    iVar5 = (carObj->N).wheelFrontX;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_60 = (iVar5 >> 8) * (carObj->N).orientMat.m[2];
    if (local_60 < 0) {
      local_60 = local_60 + 0xff;
    }
    local_60 = local_60 >> 8;
    iVar5 = (carObj->N).wheelFrontZ;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_58 = (iVar5 >> 8) * (carObj->N).orientMat.m[6];
    if (local_58 < 0) {
      local_58 = local_58 + 0xff;
    }
    local_58 = local_58 >> 8;
    iVar5 = (carObj->N).wheelFrontZ;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_54 = (iVar5 >> 8) * (carObj->N).orientMat.m[7];
    if (local_54 < 0) {
      local_54 = local_54 + 0xff;
    }
    local_54 = local_54 >> 8;
    iVar5 = (carObj->N).wheelFrontZ;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_50 = (iVar5 >> 8) * (carObj->N).orientMat.m[8];
    if (local_50 < 0) {
      local_50 = local_50 + 0xff;
    }
    local_50 = local_50 >> 8;
    local_78.x = (local_88 - local_68) + local_58;
    local_78.z = (local_80 - local_60) + local_50;
    local_78.y = (local_84 - local_64) + local_54;
    if ((1 < iVar9) && (0x8000 < iVar6)) {
      iVar9 = 3;
    }
    if (iVar9 == 0) {
      Cars_AddCarSfx(carObj,0,&local_78,uVar10,0,0);
    }
    else {
      Cars_AddCarSfx(carObj,0,&local_78,uVar10,iVar9,1);
    }
  }
  if ((((bVar2) && (iVar9 == 1)) && (sVar1 != 0)) && (bVar3)) {
    iVar9 = (carObj->N).wheelFrontX;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_68 = (iVar9 >> 8) * (carObj->N).orientMat.m[0];
    if (local_68 < 0) {
      local_68 = local_68 + 0xff;
    }
    local_68 = local_68 >> 8;
    iVar9 = (carObj->N).wheelFrontX;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_64 = (iVar9 >> 8) * (carObj->N).orientMat.m[1];
    if (local_64 < 0) {
      local_64 = local_64 + 0xff;
    }
    local_64 = local_64 >> 8;
    iVar9 = (carObj->N).wheelFrontX;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_60 = (iVar9 >> 8) * (carObj->N).orientMat.m[2];
    if (local_60 < 0) {
      local_60 = local_60 + 0xff;
    }
    local_60 = local_60 >> 8;
    iVar9 = (carObj->N).wheelFrontZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_48 = (iVar9 >> 8) * (carObj->N).orientMat.m[6];
    if (local_48 < 0) {
      local_48 = local_48 + 0xff;
    }
    local_48 = local_48 >> 8;
    iVar9 = (carObj->N).wheelFrontZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_44 = (iVar9 >> 8) * (carObj->N).orientMat.m[7];
    if (local_44 < 0) {
      local_44 = local_44 + 0xff;
    }
    local_44 = local_44 >> 8;
    iVar9 = (carObj->N).wheelFrontZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_40 = (iVar9 >> 8) * (carObj->N).orientMat.m[8];
    if (local_40 < 0) {
      local_40 = local_40 + 0xff;
    }
    local_40 = local_40 >> 8;
    local_78.x = (local_88 - local_68) + local_48;
    local_78.z = (local_80 - local_60) + local_40;
    local_78.y = (local_84 - local_64) + local_44;
    TrgSfx_AddCarSplash((carObj->N).objID,0,&local_78,10,&(carObj->N).linearVel,0,(carObj->N).speedXZ);
    if (iVar7 < 1) {
      iVar7 = 1;
    }
  }
  if ((((uVar10 & 0x20) != 0) && (gLeafPixmap != (Draw_tPixMap *)0x0)) &&
     ((0xa0000 < (carObj->N).speedXZ &&
      (pvVar4 = TrgSfx_AddCarExtraCheck((carObj->N).objID,0),
      pvVar4 != (void *)0x0)))) {
    uVar10 = random();
    iVar9 = ((uVar10 & 7) - 4) * 0x3333;
    iVar5 = (carObj->N).wheelFrontX + iVar9;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_68 = (iVar5 >> 8) * (carObj->N).orientMat.m[0];
    if (local_68 < 0) {
      local_68 = local_68 + 0xff;
    }
    local_68 = local_68 >> 8;
    iVar5 = (carObj->N).wheelFrontX + iVar9;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_64 = (iVar5 >> 8) * (carObj->N).orientMat.m[1];
    if (local_64 < 0) {
      local_64 = local_64 + 0xff;
    }
    local_64 = local_64 >> 8;
    iVar9 = (carObj->N).wheelFrontX + iVar9;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_60 = (iVar9 >> 8) * (carObj->N).orientMat.m[2];
    if (local_60 < 0) {
      local_60 = local_60 + 0xff;
    }
    local_60 = local_60 >> 8;
    iVar9 = (carObj->N).wheelFrontZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_58 = (iVar9 >> 8) * (carObj->N).orientMat.m[6];
    if (local_58 < 0) {
      local_58 = local_58 + 0xff;
    }
    local_58 = local_58 >> 8;
    iVar9 = (carObj->N).wheelFrontZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_54 = (iVar9 >> 8) * (carObj->N).orientMat.m[7];
    if (local_54 < 0) {
      local_54 = local_54 + 0xff;
    }
    local_54 = local_54 >> 8;
    iVar9 = (carObj->N).wheelFrontZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_50 = (iVar9 >> 8) * (carObj->N).orientMat.m[8];
    if (local_50 < 0) {
      local_50 = local_50 + 0xff;
    }
    local_50 = local_50 >> 8;
    local_78.x = (local_88 - local_68) + local_58;
    local_78.z = (local_80 - local_60) + local_50;
    local_78.y = (local_84 - local_64) + local_54;
    TrgSfx_AddCarExtraSfx((carObj->N).objID,0,&local_78,0xd,&(carObj->N).linearVel,(carObj->N).speedXZ,
               local_78.y,(carObj->render).light);
  }
  uVar10 = carObj->wheel[1].roadSurfaceType;
  iVar9 = Cars_kSkidMarkSurface[uVar10 & 0xf];
  if (carObj->wheel[1].wheelInAir != 0) {
    iVar9 = 0;
  }
  if ((((iVar7 == 0) || (bVar2)) && ((iVar9 < 2 || (sVar1 == 0)))) || (!bVar3)) {
    if ((carObj->oldSkidState & 2U) != 0) {
      carObj->oldSkidState = carObj->oldSkidState - 2;
      TrgSfx_AddSkidmark((carObj->N).objID,1,carObj->oldSkidPoint + 1,1,carObj->frontSkid,carObj,0);
    }
  }
  else {
    iVar5 = (carObj->N).wheelFrontX;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_68 = (iVar5 >> 8) * (carObj->N).orientMat.m[0];
    if (local_68 < 0) {
      local_68 = local_68 + 0xff;
    }
    local_68 = local_68 >> 8;
    iVar5 = (carObj->N).wheelFrontX;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_64 = (iVar5 >> 8) * (carObj->N).orientMat.m[1];
    if (local_64 < 0) {
      local_64 = local_64 + 0xff;
    }
    local_64 = local_64 >> 8;
    iVar5 = (carObj->N).wheelFrontX;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_60 = (iVar5 >> 8) * (carObj->N).orientMat.m[2];
    if (local_60 < 0) {
      local_60 = local_60 + 0xff;
    }
    local_60 = local_60 >> 8;
    iVar5 = (carObj->N).wheelFrontZ;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_58 = (iVar5 >> 8) * (carObj->N).orientMat.m[6];
    if (local_58 < 0) {
      local_58 = local_58 + 0xff;
    }
    local_58 = local_58 >> 8;
    iVar5 = (carObj->N).wheelFrontZ;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_54 = (iVar5 >> 8) * (carObj->N).orientMat.m[7];
    if (local_54 < 0) {
      local_54 = local_54 + 0xff;
    }
    local_54 = local_54 >> 8;
    iVar5 = (carObj->N).wheelFrontZ;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    local_50 = (iVar5 >> 8) * (carObj->N).orientMat.m[8];
    if (local_50 < 0) {
      local_50 = local_50 + 0xff;
    }
    local_50 = local_50 >> 8;
    local_78.x = local_88 + local_68 + local_58;
    local_78.z = local_80 + local_60 + local_50;
    local_78.y = local_84 + local_64 + local_54;
    if ((1 < iVar9) && (0x8000 < iVar6)) {
      iVar9 = 3;
    }
    if (iVar9 == 0) {
      Cars_AddCarSfx(carObj,1,&local_78,uVar10,0,0);
    }
    else {
      Cars_AddCarSfx(carObj,1,&local_78,uVar10,iVar9,1);
    }
  }
  if ((((bVar2) && (iVar9 == 1)) && (sVar1 != 0)) && (bVar3)) {
    iVar9 = (carObj->N).wheelFrontX;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_68 = (iVar9 >> 8) * (carObj->N).orientMat.m[0];
    if (local_68 < 0) {
      local_68 = local_68 + 0xff;
    }
    local_68 = local_68 >> 8;
    iVar9 = (carObj->N).wheelFrontX;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_64 = (iVar9 >> 8) * (carObj->N).orientMat.m[1];
    if (local_64 < 0) {
      local_64 = local_64 + 0xff;
    }
    local_64 = local_64 >> 8;
    iVar9 = (carObj->N).wheelFrontX;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_60 = (iVar9 >> 8) * (carObj->N).orientMat.m[2];
    if (local_60 < 0) {
      local_60 = local_60 + 0xff;
    }
    local_60 = local_60 >> 8;
    iVar9 = (carObj->N).wheelFrontZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_58 = (iVar9 >> 8) * (carObj->N).orientMat.m[6];
    if (local_58 < 0) {
      local_58 = local_58 + 0xff;
    }
    local_58 = local_58 >> 8;
    iVar9 = (carObj->N).wheelFrontZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_54 = (iVar9 >> 8) * (carObj->N).orientMat.m[7];
    if (local_54 < 0) {
      local_54 = local_54 + 0xff;
    }
    local_54 = local_54 >> 8;
    iVar9 = (carObj->N).wheelFrontZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_50 = (iVar9 >> 8) * (carObj->N).orientMat.m[8];
    if (local_50 < 0) {
      local_50 = local_50 + 0xff;
    }
    local_50 = local_50 >> 8;
    local_78.x = local_88 + local_68 + local_58;
    local_78.z = local_80 + local_60 + local_50;
    local_78.y = local_84 + local_64 + local_54;
    TrgSfx_AddCarSplash((carObj->N).objID,1,&local_78,10,&(carObj->N).linearVel,0,(carObj->N).speedXZ);
    if (iVar7 < 1) {
      iVar7 = 1;
    }
  }
  if ((((uVar10 & 0x20) != 0) && (gLeafPixmap != (Draw_tPixMap *)0x0)) &&
     ((0xa0000 < (carObj->N).speedXZ &&
      (pvVar4 = TrgSfx_AddCarExtraCheck((carObj->N).objID,1),
      pvVar4 != (void *)0x0)))) {
    uVar10 = random();
    iVar9 = ((uVar10 & 7) - 4) * 0x3333;
    iVar6 = (carObj->N).wheelFrontX + iVar9;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_68 = (iVar6 >> 8) * (carObj->N).orientMat.m[0];
    if (local_68 < 0) {
      local_68 = local_68 + 0xff;
    }
    local_68 = local_68 >> 8;
    iVar6 = (carObj->N).wheelFrontX + iVar9;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_64 = (iVar6 >> 8) * (carObj->N).orientMat.m[1];
    if (local_64 < 0) {
      local_64 = local_64 + 0xff;
    }
    local_64 = local_64 >> 8;
    iVar9 = (carObj->N).wheelFrontX + iVar9;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_60 = (iVar9 >> 8) * (carObj->N).orientMat.m[2];
    if (local_60 < 0) {
      local_60 = local_60 + 0xff;
    }
    local_60 = local_60 >> 8;
    iVar9 = (carObj->N).wheelFrontZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_58 = (iVar9 >> 8) * (carObj->N).orientMat.m[6];
    if (local_58 < 0) {
      local_58 = local_58 + 0xff;
    }
    local_58 = local_58 >> 8;
    iVar9 = (carObj->N).wheelFrontZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_54 = (iVar9 >> 8) * (carObj->N).orientMat.m[7];
    if (local_54 < 0) {
      local_54 = local_54 + 0xff;
    }
    local_54 = local_54 >> 8;
    iVar9 = (carObj->N).wheelFrontZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_50 = (iVar9 >> 8) * (carObj->N).orientMat.m[8];
    if (local_50 < 0) {
      local_50 = local_50 + 0xff;
    }
    local_50 = local_50 >> 8;
    local_78.x = local_88 + local_68 + local_58;
    local_78.z = local_80 + local_60 + local_50;
    local_78.y = local_84 + local_64 + local_54;
    TrgSfx_AddCarExtraSfx((carObj->N).objID,1,&local_78,0xd,&(carObj->N).linearVel,(carObj->N).speedXZ,
               local_78.y,(carObj->render).light);
  }
  uVar10 = carObj->wheel[2].roadSurfaceType;
  iVar9 = Cars_kSkidMarkSurface[uVar10 & 0xf];
  if (carObj->wheel[2].wheelInAir != 0) {
    iVar9 = 0;
  }
  if ((((iVar8 == 0) || (bVar2)) && ((iVar9 < 2 || (sVar1 == 0)))) || (!bVar3)) {
    if ((carObj->oldSkidState & 4U) != 0) {
      TrgSfx_AddSkidmark((carObj->N).objID,2,carObj->oldSkidPoint + 2,1,carObj->rearSkid,carObj,0);
      carObj->oldSkidState = carObj->oldSkidState + -4;
    }
  }
  else {
    iVar6 = (carObj->N).wheelBackX;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_68 = (iVar6 >> 8) * (carObj->N).orientMat.m[0];
    if (local_68 < 0) {
      local_68 = local_68 + 0xff;
    }
    local_68 = local_68 >> 8;
    iVar6 = (carObj->N).wheelBackX;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_64 = (iVar6 >> 8) * (carObj->N).orientMat.m[1];
    if (local_64 < 0) {
      local_64 = local_64 + 0xff;
    }
    local_64 = local_64 >> 8;
    iVar6 = (carObj->N).wheelBackX;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_60 = (iVar6 >> 8) * (carObj->N).orientMat.m[2];
    if (local_60 < 0) {
      local_60 = local_60 + 0xff;
    }
    local_60 = local_60 >> 8;
    iVar6 = (carObj->N).wheelBackZ;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_58 = (iVar6 >> 8) * (carObj->N).orientMat.m[6];
    if (local_58 < 0) {
      local_58 = local_58 + 0xff;
    }
    local_58 = local_58 >> 8;
    iVar6 = (carObj->N).wheelBackZ;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_54 = (iVar6 >> 8) * (carObj->N).orientMat.m[7];
    if (local_54 < 0) {
      local_54 = local_54 + 0xff;
    }
    local_54 = local_54 >> 8;
    iVar6 = (carObj->N).wheelBackZ;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_50 = (iVar6 >> 8) * (carObj->N).orientMat.m[8];
    if (local_50 < 0) {
      local_50 = local_50 + 0xff;
    }
    local_50 = local_50 >> 8;
    local_78.x = (local_88 - local_68) - local_58;
    local_78.z = (local_80 - local_60) - local_50;
    local_78.y = (local_84 - local_64) - local_54;
    if ((1 < iVar9) && (0x10000 < iVar8)) {
      iVar9 = 3;
    }
    if (iVar9 == 0) {
      Cars_AddCarSfx(carObj,2,&local_78,uVar10,0,0);
    }
    else {
      Cars_AddCarSfx(carObj,2,&local_78,uVar10,iVar9,1);
    }
  }
  if ((((bVar2) && (iVar9 == 1)) && (sVar1 != 0)) && (bVar3)) {
    iVar9 = (carObj->N).wheelBackX;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_68 = (iVar9 >> 8) * (carObj->N).orientMat.m[0];
    if (local_68 < 0) {
      local_68 = local_68 + 0xff;
    }
    local_68 = local_68 >> 8;
    iVar9 = (carObj->N).wheelBackX;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_64 = (iVar9 >> 8) * (carObj->N).orientMat.m[1];
    if (local_64 < 0) {
      local_64 = local_64 + 0xff;
    }
    local_64 = local_64 >> 8;
    iVar9 = (carObj->N).wheelBackX;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_60 = (iVar9 >> 8) * (carObj->N).orientMat.m[2];
    if (local_60 < 0) {
      local_60 = local_60 + 0xff;
    }
    local_60 = local_60 >> 8;
    iVar9 = (carObj->N).wheelBackZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_58 = (iVar9 >> 8) * (carObj->N).orientMat.m[6];
    if (local_58 < 0) {
      local_58 = local_58 + 0xff;
    }
    local_58 = local_58 >> 8;
    iVar9 = (carObj->N).wheelBackZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_54 = (iVar9 >> 8) * (carObj->N).orientMat.m[7];
    if (local_54 < 0) {
      local_54 = local_54 + 0xff;
    }
    local_54 = local_54 >> 8;
    iVar9 = (carObj->N).wheelBackZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_50 = (iVar9 >> 8) * (carObj->N).orientMat.m[8];
    if (local_50 < 0) {
      local_50 = local_50 + 0xff;
    }
    local_50 = local_50 >> 8;
    local_78.x = (local_88 - local_68) - local_58;
    local_78.z = (local_80 - local_60) - local_50;
    local_78.y = (local_84 - local_64) - local_54;
    TrgSfx_AddCarSplash((carObj->N).objID,2,&local_78,10,&(carObj->N).linearVel,0,(carObj->N).speedXZ);
    if (iVar8 < 1) {
      iVar8 = 1;
    }
  }
  if ((((uVar10 & 0x20) != 0) && (gLeafPixmap != (Draw_tPixMap *)0x0)) &&
     ((0xa0000 < (carObj->N).speedXZ &&
      (pvVar4 = TrgSfx_AddCarExtraCheck((carObj->N).objID,2),
      pvVar4 != (void *)0x0)))) {
    uVar10 = random();
    iVar9 = ((uVar10 & 7) - 4) * 0x3333;
    iVar6 = (carObj->N).wheelBackX + iVar9;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_68 = (iVar6 >> 8) * (carObj->N).orientMat.m[0];
    if (local_68 < 0) {
      local_68 = local_68 + 0xff;
    }
    local_68 = local_68 >> 8;
    iVar6 = (carObj->N).wheelBackX + iVar9;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_64 = (iVar6 >> 8) * (carObj->N).orientMat.m[1];
    if (local_64 < 0) {
      local_64 = local_64 + 0xff;
    }
    local_64 = local_64 >> 8;
    iVar9 = (carObj->N).wheelBackX + iVar9;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_60 = (iVar9 >> 8) * (carObj->N).orientMat.m[2];
    if (local_60 < 0) {
      local_60 = local_60 + 0xff;
    }
    local_60 = local_60 >> 8;
    iVar9 = (carObj->N).wheelBackZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_58 = (iVar9 >> 8) * (carObj->N).orientMat.m[6];
    if (local_58 < 0) {
      local_58 = local_58 + 0xff;
    }
    local_58 = local_58 >> 8;
    iVar9 = (carObj->N).wheelBackZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_54 = (iVar9 >> 8) * (carObj->N).orientMat.m[7];
    if (local_54 < 0) {
      local_54 = local_54 + 0xff;
    }
    local_54 = local_54 >> 8;
    iVar9 = (carObj->N).wheelBackZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_50 = (iVar9 >> 8) * (carObj->N).orientMat.m[8];
    if (local_50 < 0) {
      local_50 = local_50 + 0xff;
    }
    local_50 = local_50 >> 8;
    local_78.x = (local_88 - local_68) - local_58;
    local_78.z = (local_80 - local_60) - local_50;
    local_78.y = (local_84 - local_64) - local_54;
    TrgSfx_AddCarExtraSfx((carObj->N).objID,2,&local_78,0xd,&(carObj->N).linearVel,(carObj->N).speedXZ,
               local_78.y,(carObj->render).light);
  }
  uVar10 = carObj->wheel[3].roadSurfaceType;
  iVar9 = Cars_kSkidMarkSurface[uVar10 & 0xf];
  if (carObj->wheel[3].wheelInAir != 0) {
    iVar9 = 0;
  }
  if ((((iVar8 == 0) || (bVar2)) && ((iVar9 < 2 || (sVar1 == 0)))) || (!bVar3)) {
    if ((carObj->oldSkidState & 8U) != 0) {
      TrgSfx_AddSkidmark((carObj->N).objID,3,carObj->oldSkidPoint + 3,1,carObj->rearSkid,carObj,0);
      carObj->oldSkidState = carObj->oldSkidState + -8;
    }
  }
  else {
    iVar6 = (carObj->N).wheelBackX;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_68 = (iVar6 >> 8) * (carObj->N).orientMat.m[0];
    if (local_68 < 0) {
      local_68 = local_68 + 0xff;
    }
    local_68 = local_68 >> 8;
    iVar6 = (carObj->N).wheelBackX;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_64 = (iVar6 >> 8) * (carObj->N).orientMat.m[1];
    if (local_64 < 0) {
      local_64 = local_64 + 0xff;
    }
    local_64 = local_64 >> 8;
    iVar6 = (carObj->N).wheelBackX;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_60 = (iVar6 >> 8) * (carObj->N).orientMat.m[2];
    if (local_60 < 0) {
      local_60 = local_60 + 0xff;
    }
    local_60 = local_60 >> 8;
    iVar6 = (carObj->N).wheelBackZ;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_58 = (iVar6 >> 8) * (carObj->N).orientMat.m[6];
    if (local_58 < 0) {
      local_58 = local_58 + 0xff;
    }
    local_58 = local_58 >> 8;
    iVar6 = (carObj->N).wheelBackZ;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_54 = (iVar6 >> 8) * (carObj->N).orientMat.m[7];
    if (local_54 < 0) {
      local_54 = local_54 + 0xff;
    }
    local_54 = local_54 >> 8;
    iVar6 = (carObj->N).wheelBackZ;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_50 = (iVar6 >> 8) * (carObj->N).orientMat.m[8];
    if (local_50 < 0) {
      local_50 = local_50 + 0xff;
    }
    local_50 = local_50 >> 8;
    local_78.x = (local_88 + local_68) - local_58;
    local_78.z = (local_80 + local_60) - local_50;
    local_78.y = (local_84 + local_64) - local_54;
    if ((1 < iVar9) && (0x10000 < iVar8)) {
      iVar9 = 3;
    }
    if (iVar9 == 0) {
      Cars_AddCarSfx(carObj,3,&local_78,uVar10,0,0);
    }
    else {
      Cars_AddCarSfx(carObj,3,&local_78,uVar10,iVar9,1);
    }
  }
  if ((((bVar2) && (iVar9 == 1)) && (sVar1 != 0)) && (bVar3)) {
    iVar9 = (carObj->N).wheelBackX;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_68 = (iVar9 >> 8) * (carObj->N).orientMat.m[0];
    if (local_68 < 0) {
      local_68 = local_68 + 0xff;
    }
    local_68 = local_68 >> 8;
    iVar9 = (carObj->N).wheelBackX;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_64 = (iVar9 >> 8) * (carObj->N).orientMat.m[1];
    if (local_64 < 0) {
      local_64 = local_64 + 0xff;
    }
    local_64 = local_64 >> 8;
    iVar9 = (carObj->N).wheelBackX;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_60 = (iVar9 >> 8) * (carObj->N).orientMat.m[2];
    if (local_60 < 0) {
      local_60 = local_60 + 0xff;
    }
    local_60 = local_60 >> 8;
    iVar9 = (carObj->N).wheelBackZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_58 = (iVar9 >> 8) * (carObj->N).orientMat.m[6];
    if (local_58 < 0) {
      local_58 = local_58 + 0xff;
    }
    local_58 = local_58 >> 8;
    iVar9 = (carObj->N).wheelBackZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_54 = (iVar9 >> 8) * (carObj->N).orientMat.m[7];
    if (local_54 < 0) {
      local_54 = local_54 + 0xff;
    }
    local_54 = local_54 >> 8;
    iVar9 = (carObj->N).wheelBackZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_50 = (iVar9 >> 8) * (carObj->N).orientMat.m[8];
    if (local_50 < 0) {
      local_50 = local_50 + 0xff;
    }
    local_50 = local_50 >> 8;
    local_78.x = (local_88 + local_68) - local_58;
    local_78.z = (local_80 + local_60) - local_50;
    local_78.y = (local_84 + local_64) - local_54;
    TrgSfx_AddCarSplash((carObj->N).objID,3,&local_78,10,&(carObj->N).linearVel,0,(carObj->N).speedXZ);
    if (iVar8 < 1) {
      iVar8 = 1;
    }
  }
  if ((((uVar10 & 0x20) != 0) && (gLeafPixmap != (Draw_tPixMap *)0x0)) &&
     ((0xa0000 < (carObj->N).speedXZ &&
      (pvVar4 = TrgSfx_AddCarExtraCheck((carObj->N).objID,3),
      pvVar4 != (void *)0x0)))) {
    uVar10 = random();
    iVar9 = ((uVar10 & 7) - 4) * 0x3333;
    iVar6 = (carObj->N).wheelBackX + iVar9;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_68 = (iVar6 >> 8) * (carObj->N).orientMat.m[0];
    if (local_68 < 0) {
      local_68 = local_68 + 0xff;
    }
    local_68 = local_68 >> 8;
    iVar6 = (carObj->N).wheelBackX + iVar9;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    local_64 = (iVar6 >> 8) * (carObj->N).orientMat.m[1];
    if (local_64 < 0) {
      local_64 = local_64 + 0xff;
    }
    local_64 = local_64 >> 8;
    iVar9 = (carObj->N).wheelBackX + iVar9;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_60 = (iVar9 >> 8) * (carObj->N).orientMat.m[2];
    if (local_60 < 0) {
      local_60 = local_60 + 0xff;
    }
    local_60 = local_60 >> 8;
    iVar9 = (carObj->N).wheelBackZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_58 = (iVar9 >> 8) * (carObj->N).orientMat.m[6];
    if (local_58 < 0) {
      local_58 = local_58 + 0xff;
    }
    local_58 = local_58 >> 8;
    iVar9 = (carObj->N).wheelBackZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_54 = (iVar9 >> 8) * (carObj->N).orientMat.m[7];
    if (local_54 < 0) {
      local_54 = local_54 + 0xff;
    }
    local_54 = local_54 >> 8;
    iVar9 = (carObj->N).wheelBackZ;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    local_50 = (iVar9 >> 8) * (carObj->N).orientMat.m[8];
    if (local_50 < 0) {
      local_50 = local_50 + 0xff;
    }
    local_50 = local_50 >> 8;
    local_78.x = (local_88 + local_68) - local_58;
    local_78.z = (local_80 + local_60) - local_50;
    local_78.y = (local_84 + local_64) - local_54;
    TrgSfx_AddCarExtraSfx((carObj->N).objID,3,&local_78,0xd,&(carObj->N).linearVel,(carObj->N).speedXZ,
               local_78.y,(carObj->render).light);
  }
  if (iVar7 == 0) {
    if ((carObj->oldAudioSkidState & 1U) == 0) goto LAB_80089674;
    Cars_SetAudioCalls(carObj,3,0x12,2,local_38,0,0);
    uVar10 = carObj->oldAudioSkidState - 1;
  }
  else {
    if (local_34 < 0) {
      local_34 = 0;
    }
    if ((local_34 == 0) && ((carObj->carFlags & 4U) == 0)) goto LAB_80089674;
    Cars_SetAudioCalls(carObj,2,0x12,2,local_38,iVar7,0);
    uVar10 = carObj->oldAudioSkidState | 1;
  }
  carObj->oldAudioSkidState = uVar10;
LAB_80089674:
  if (iVar8 == 0) {
    if ((carObj->oldAudioSkidState & 2U) == 0) {
      return;
    }
    Cars_SetAudioCalls(carObj,5,0x14,2,local_38,0,0);
    uVar10 = carObj->oldAudioSkidState - 2;
  }
  else {
    if (local_30 < 0) {
      local_30 = 0;
    }
    if ((local_30 == 0) && ((carObj->carFlags & 4U) == 0)) {
      return;
    }
    Cars_SetAudioCalls(carObj,4,0x14,2,local_38,iVar8 / 2,0);
    uVar10 = carObj->oldAudioSkidState | 2;
  }
  carObj->oldAudioSkidState = uVar10;
  return;
}

/* ---- Cars_FindTotalSlice__FP8Car_tObj  [@0x80089760] ---- */
void Cars_FindTotalSlice(Car_tObj *carObj)
{
  /* MATCH: oracle loads lap (0x264) and gNumSlices via full-word lw + mult (never
     truncated) -- the (short) casts previously forced spurious LHU narrow-loads.
     simRoadInfo.slice is read unsigned in BOTH arms. */
  /* MATCH: oracle loads lap (0x264) and gNumSlices via full-word lw + mult (never
     truncated) -- prior (short) casts forced spurious LHU narrow-loads (a genuine
     correctness bug: lap/gNumSlices are 32-bit ints, only simRoadInfo.slice is a real
     short field). Count now EXACT (27/27); residual 28 diffs = reg-coloring/gNumSlices-
     reload-vs-shared floor (tried: shared `slices` local -> 23/27 worse; per-branch
     duplicated store -> 32/27 worse; both reverted). */
  int lap;
  u_int roadSlice;

  if (0 < carObj->unlap) {
    (carObj->N).totalSlice = 0;
    return;
  }
  if (GameSetup_gData.reverseTrack != 0) {
    lap = carObj->lap;
    roadSlice = (gNumSlices - (u_short)(carObj->N).simRoadInfo.slice) - 1;
  }
  else {
    lap = carObj->lap;
    roadSlice = (u_short)(carObj->N).simRoadInfo.slice;
  }
  (carObj->N).totalSlice = roadSlice + lap * gNumSlices;
  return;
}

/* ---- Car_DoSkiddingStuff__FP8Car_tObj  [@0x800897cc] ---- */
void Car_DoSkiddingStuff(Car_tObj *carObj)
{
  /* MATCH: oracle places the >=0x3334 (skid-check + Car_TireSkiddingStuff) block as the
     FALLTHROUGH and jumps AWAY to the <0x3334 (altitude/speed) block -- negate the
     guard + swap the branches to reproduce that layout (same lever as
     Cars_CheckForAccidentScenes/Cars_FindTotalSlice). */
  u_int uVar1;

  if (0x3334 <= (carObj->N).orientationToGround.y) {
    if ((carObj->oldAudioSkidState & 4U) != 0) {
      Cars_SetAudioCalls(carObj,5,0x14,1,0,0,0);
      carObj->oldAudioSkidState = carObj->oldAudioSkidState + -4;
    }
    Car_TireSkiddingStuff(carObj);
  }
  else {
    int audioSurface = Cars_kAudioRoadSurfaceInterface[(carObj->N).driveSurfaceType];
    if (((carObj->N).objAltitude < 0x3333) && (0x20000 < (carObj->N).speedXZ)) {
      Cars_SetAudioCalls(carObj,4,0x14,1,audioSurface,0xa0000,0);
      uVar1 = carObj->oldAudioSkidState | 4;
    }
    else {
      Cars_SetAudioCalls(carObj,5,0x14,1,0,0,0);
      uVar1 = carObj->oldAudioSkidState - 4;
    }
    carObj->oldAudioSkidState = uVar1;
  }
  return;
}

/* ---- Car_DoPostCollisionStuff__FP8Car_tObj  [@0x800898dc] ---- */
void Car_DoPostCollisionStuff(Car_tObj *carObj)
{
  int Yoffset;
  int iVar1;
  Car_tSpecs *pCVar2;
  int iVar3;
  BO_tNewtonObj *pBVar4;
  GameSetup_tCarData *pGVar5;
  int a;
  int iVar6;
  
  iVar1 = (carObj->N).collision.impulse;
  carObj->audioCount = 0;
  if (iVar1 != 0) {
    (carObj->N).collision.lastImpulse = iVar1;
    pBVar4 = (carObj->N).collision.otherObj;
    (carObj->N).collision.lastTime = simGlobal.gameTicks;
    if (pBVar4 == (BO_tNewtonObj *)0x0) {
      (carObj->N).collision.lastOtherObj = (BO_tNewtonObj *)0x0;
    }
    else {
      (carObj->N).collision.lastOtherObj = pBVar4;
    }
  }
  if (((carObj->N).simOptz == '\0') && ((carObj->N).active != '\0')) {
    AIPhysic_ProcessCollision(carObj);
    Cars_DoExtraCarCollisionProcessing(carObj);
    Car_DoSkiddingStuff(carObj);
    if (((carObj->carFlags & 4U) == 0) || ((carObj->N).flightTime != 0)) {
      iVar1 = (carObj->linearAcc_ch).x;
      (carObj->render).currentPitch =
           (carObj->render).currentPitch * 0xf + (carObj->linearAcc_ch).z >> 4;
      iVar1 = (carObj->render).currentRoll * 0xf + iVar1 >> 4;
    }
    else {
      iVar1 = (carObj->linearAcc_ch).x;
      (carObj->render).currentPitch =
           (carObj->render).currentPitch * 7 + (carObj->linearAcc_ch).z >> 3;
      iVar1 = (carObj->render).currentRoll * 7 + iVar1 >> 3;
    }
    (carObj->render).currentRoll = iVar1;
    iVar1 = -(carObj->N).groundVel;
    iVar3 = iVar1;
    if (iVar1 < 0) {
      iVar3 = iVar1 + 0x1f;
    }
    iVar6 = -0xa3d;
    if (-0xa3d < iVar3 >> 5) {
      if (iVar1 < 0) {
        iVar1 = iVar1 + 0x1f;
      }
      iVar6 = 0x51e;
      if (iVar1 >> 5 < 0x51f) {
        iVar6 = iVar1 >> 5;
      }
    }
    iVar1 = fixedmult(((carObj->render).currentRoll * 3) / 2,carObj->specs->bodyRollFactor);
    if (iVar1 < 0) {
      iVar1 = -iVar1;
    }
    a = (carObj->render).currentRoll;
    iVar3 = carObj->specs->rideOffset;
    (carObj->render).bodyRoll = a;
    (carObj->render).currentHeight = (iVar6 - iVar1) - iVar3;
    iVar1 = fixedmult(a,(carObj->render).rollFactor);
    (carObj->render).bodyRoll = iVar1;
    iVar1 = -(carObj->render).currentPitch;
    (carObj->render).bodyPitch = iVar1;
    iVar1 = fixedmult(iVar1,(carObj->render).pitchFactor);
    pGVar5 = carObj->carInfo;
    (carObj->render).bodyPitch = iVar1;
    if ((pGVar5->WeightTransfer == 1) || ((carObj->carFlags & 4U) == 0)) {
      (carObj->render).bodyPitch = iVar1 / 2;
      (carObj->render).bodyRoll = (carObj->render).bodyRoll / 2;
    }
  }
  else {
    pCVar2 = carObj->specs;
    (carObj->render).bodyPitch = 0;
    (carObj->render).bodyRoll = 0;
    (carObj->render).currentHeight = -pCVar2->rideOffset;
    Cars_DoExtraCarCollisionProcessing(carObj);
  }
  return;
}

/* ---- Cars_CalculateStartingGridOffset__FP8Car_tObjPiP8coorddef  [@0x80089b44] ---- */
void Cars_CalculateStartingGridOffset(Car_tObj *carObj,int *slice,coorddef *offset)
{
  int startingPosition;
  int carOnRight;
  int negDir;
  int center;
  int totalWidth;
  int iVar1;
  int iVar2;
  u_int uVar3;
  u_int uVar4;
  u_int uVar5;
  
  iVar2 = -1;
  if (GameSetup_gData.reverseTrack != 0) {
    iVar2 = 1;
  }
  uVar5 = GameSetup_gData.carInfo[carObj->carIndex].StartingPos;
  if (Cars_gNumRaceCars < 3) {
    if (-1 < iVar2) {
      if (gNumSlices <= iVar2) {
        iVar2 = iVar2 - gNumSlices;
      }
      *slice = iVar2;
      goto LAB_80089c40;
    }
  }
  else {
    iVar2 = iVar2 + iVar2 * 10 * uVar5;
    if (-1 < iVar2) {
      if (gNumSlices <= iVar2) {
        iVar2 = iVar2 - gNumSlices;
      }
      *slice = iVar2;
      goto LAB_80089c40;
    }
  }
  *slice = iVar2 + gNumSlices;
LAB_80089c40:
  uVar5 = uVar5 & 1;
  if (carObj->desiredDirection * AITune_driveSide == -1) {
    uVar5 = 1 - uVar5;
  }
  iVar2 = AITune_GetOneWay();
  if (iVar2 == 0) {
    if (uVar5 == 0) {
      iVar2 = (int)((u_int)*(u_char *)(*slice * 0x20 + BWorldSm_slices + 0x1e) * -0x8000) / 2;
    }
    else {
      iVar2 = (u_int)*(u_char *)(*slice * 0x20 + BWorldSm_slices + 0x1f) << 0xe;
    }
  }
  else {
    iVar2 = *slice * 0x20 + BWorldSm_slices;
    uVar3 = (u_int)(*(u_char *)(iVar2 + 0x1d) >> 4);
    iVar1 = (u_int)*(u_char *)(iVar2 + 0x1e) * 0x8000 * uVar3;
    uVar4 = *(u_char *)(iVar2 + 0x1d) & 0xf;
    uVar3 = uVar3 + uVar4;
    uVar4 = iVar1 + (u_int)*(u_char *)(iVar2 + 0x1f) * 0x8000 * uVar4;
    iVar1 = (uVar4 >> 1) - iVar1;
    iVar2 = iVar1 + uVar4 / uVar3;
    if (uVar5 == 0) {
      iVar2 = iVar1 - uVar4 / uVar3;
    }
  }
  offset->x = iVar2;
  offset->y = 0x8000;
  offset->z = 0;
  return;
}

/* ---- Cars_IniCarObjects__FP8Car_tObji  [@0x80089d88] ---- */
void Cars_IniCarObjects(Car_tObj *carObj,int index)
{
  int startSlice;
  coorddef offset;
  int carMass;
  int k;
  u_short uVar1;
  GameSetup_tCarData *pGVar2;
  int iVar3;
  Car_tObj *pCVar4;
  Car_tSpecs *pCVar5;
  coorddef cStack_28;
  int local_18 [2];
  
  Cars_InitStats(carObj);
  carObj->swapCar = (Car_tObj *)0x0;
  carObj->swapTime = 0;
  if (index < GameSetup_gData.numCars) {
    iVar3 = carObj->carInfo->carType;
    if (((((iVar3 == 0x21) || (iVar3 == 0x24)) || (iVar3 == 0x26)) ||
        ((iVar3 == 0x27 || (iVar3 == 0x2f)))) || ((iVar3 == 0x30 || (iVar3 == 0x31)))) {
      iVar3 = 0x190000;
    }
    else if ((((iVar3 == 0x22) || (iVar3 == 0x25)) || (iVar3 == 0x29)) ||
            ((iVar3 == 0x2b || (iVar3 == 0x2c)))) {
      iVar3 = 0x110000;
    }
    else {
      iVar3 = carObj->specs->mass;
      if (iVar3 < 0) {
        iVar3 = iVar3 + 0x7f;
      }
      iVar3 = iVar3 >> 7;
    }
    Newton_InitBaseNewtonObj((u_int *)&carObj->N,index | 0x100,iVar3,iVar3,(carObj->N).dimension.x,(carObj->N).dimension.y,
               (carObj->N).dimension.z);
  }
  Cars_CalculateStartingGridOffset(carObj,local_18,&cStack_28);
  if (gNumSlices / 2 < local_18[0]) {
    (carObj->stats).extractSlice = gNumSlices - local_18[0];
  }
  else {
    (carObj->stats).extractSlice = local_18[0];
  }
  if (GameSetup_gData.reverseTrack == 0) {
    iVar3 = 1;
  }
  else {
    iVar3 = -1;
  }
  Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,local_18[0],&cStack_28,iVar3);
  carObj->unlap = 1;
  carObj->lap = 0;
  if (GameSetup_gData.reverseTrack == 0) {
    uVar1 = (carObj->N).simRoadInfo.slice;
  }
  else {
    uVar1 = ((short)gNumSlices - (carObj->N).simRoadInfo.slice) - 1;
  }
  (carObj->N).oldSlice = uVar1;
  Cars_FindTotalSlice(carObj);
  iVar3 = 0;
  carObj->RSControl = 0;
  carObj->RSSteering = 0;
  carObj->RSGasLevel = '\0';
  carObj->RSBrakeLevel = '\0';
  carObj->glue = 0x10000;
  carObj->aiGlue = 0x10000;
  carObj->drag = 0;
  carObj->crash = 0;
  carObj->blowout = 0;
  carObj->pullOver = 0;
  (carObj->linearAcc).x = 0;
  (carObj->linearAcc).y = 0;
  (carObj->linearAcc).z = 0;
  (carObj->angularAcc).x = 0;
  (carObj->angularAcc).y = 0;
  (carObj->angularAcc).z = 0;
  (carObj->linearAcc_ch).x = 0;
  (carObj->linearAcc_ch).y = 0;
  (carObj->linearAcc_ch).z = 0;
  (carObj->linearAcc_rh).x = 0;
  (carObj->linearAcc_rh).y = 0;
  (carObj->linearAcc_rh).z = 0;
  (carObj->linearVel_ch).x = 0;
  (carObj->linearVel_ch).y = 0;
  (carObj->linearVel_ch).z = 0;
  (carObj->angularVel_ch).x = 0;
  (carObj->angularVel_ch).y = 0;
  (carObj->angularVel_ch).z = 0;
  pCVar4 = carObj;
  do {
    pCVar4->wheel[0].actualHeight = 0;
    pCVar4->wheel[0].currentPos.x = 0;
    pCVar4->wheel[0].currentPos.y = 0;
    pCVar4->wheel[0].currentPos.z = 0;
    pCVar4->wheel[0].roadNormal.x = 0;
    pCVar4->wheel[0].roadNormal.y = 0x10000;
    pCVar4->wheel[0].roadNormal.z = 0;
    pCVar4->wheel[0].wheelAcc = 0;
    pCVar4->wheel[0].wheelInAir = 0;
    pCVar4->wheel[0].rebound = 0;
    pCVar4->wheel[0].impactCompression = 0;
    pCVar4->wheel[0].roadSurfaceType = 1;
    iVar3 = iVar3 + 1;
    pCVar4 = (Car_tObj *)&(pCVar4->N).simRoadInfo.quadPts[2].z;
  } while (iVar3 < 4);
  (carObj->control).desiredGear = '\x01';
  (carObj->control).gear = '\x01';
  (carObj->control).lastGear = '\x01';
  carObj->flywheelRpm = 0;
  carObj->wheelSpin = 0;
  carObj->frontWheelSpin = 0;
  carObj->wheelLock = 0;
  carObj->slide = 0;
  carObj->frontSkid = 0;
  carObj->rearSkid = 0;
  (carObj->control).desiredGasLevel = '\0';
  (carObj->control).desiredBrakeLevel = '\0';
  (carObj->control).desiredSteering = 0;
  (carObj->control).downShifting = '\0';
  (carObj->control).gearShiftTimer = '\0';
  (carObj->control).gasLevel = '\0';
  (carObj->control).brakeLevel = '\0';
  (carObj->control).steering = 0;
  (carObj->control).handBrake = '\0';
  (carObj->control).horn = '\0';
  if (GameSetup_gData.Time == 0) {
    (carObj->control).lights = '\0';
  }
  else {
    (carObj->control).lights = '\x03';
  }
  (carObj->control).abort = '\0';
  (carObj->control).lookBehind = '\0';
  (carObj->control).hanno = 0;
  (carObj->control).event = '\0';
  (carObj->control).queuedEvent = '\0';
  carObj->gTransferFront = 0;
  carObj->oldSkidState = 0;
  carObj->oldAudioSkidState = 0;
  carObj->frontSkid = 0;
  carObj->rearSkid = 0;
  AIInit_RestartAICar(carObj);
  pGVar2 = carObj->carInfo;
  carObj->audioCount = 0;
  carObj->audioDamageScrape = 0;
  (carObj->collision).resetTimer = 0;
  (carObj->collision).smoking = 0;
  (carObj->N).flightTime = 0;
  (carObj->N).collision.collided = 0;
  (carObj->N).collision.lastCollision = 0;
  (carObj->N).collision.impulse = 0;
  (carObj->N).collision.otherObj = (BO_tNewtonObj *)0x0;
  (carObj->N).collision.disableCollisionTimer = 0;
  (carObj->N).groundVel = 0;
  (carObj->N).roadGravityModifier = 0;
  (carObj->N).speedXZ = 0;
  (carObj->render).bodyPitch = 0;
  (carObj->render).bodyRoll = 0;
  (carObj->render).currentPitch = 0;
  (carObj->render).currentRoll = 0;
  (carObj->render).currentHeight = 0;
  if (pGVar2->carType < 0x1d) {
    iVar3 = fixeddiv(carObj->specs->bodyPitchFactor,carObj->specs->suspensionStiffness * 3);
    pCVar5 = carObj->specs;
    (carObj->render).pitchFactor = iVar3;
    iVar3 = fixeddiv(pCVar5->bodyRollFactor,pCVar5->suspensionStiffness << 1);
    (carObj->render).rollFactor = iVar3;
  }
  else {
    (carObj->render).pitchFactor = 0;
    (carObj->render).rollFactor = 0;
  }
  return;
}

/* ---- Cars_InitCar__FP8Car_tObji  [@0x8008a174] ---- */
void Cars_InitCar(Car_tObj *carObj,int index)
{
  char carFile[100];
  char specsFile[100];
  char name[20];
  char*file2;
  char*file1;
  Udff_tInfo*handle2;
  int iVar1;
  char *mem;
  Car_tSpecs *pCVar2;
  Udff_tInfo *handle;
  void *pThis;
  char *mem_00;
  Udff_tInfo *handle_00;
  char acStack_108 [104];
  char acStack_a0 [104];
  char acStack_38 [24];
  
  pThis = 0x0;
  mem_00 = (char *)0x0;
  handle_00 = (Udff_tInfo *)0x0;
  handle = (Udff_tInfo *)0x0;
  if (index < GameSetup_gData.numCars) {
    iVar1 = AIInit_IsNonStandardCarFile(carObj->carInfo->carType);
    if (iVar1 == 0) {
      sprintf(acStack_108,"%sSTDR.qda",Paths_Paths[4]);
    }
    else {
      sprintf(acStack_108,"%s%s.qda",Paths_Paths[4],(char *)carObj + 0x240);
    }
    mem_00 = (char *)loadpackadr(acStack_108,(void *)0x10);
    handle_00 = Udff_Opena((char *)0x0,mem_00,1);
    if (carObj->carInfo->carType < 0x1d) {
      sprintf(acStack_38,"p%s.dat",GameSetup_gCarNames[0] + carObj->carInfo->carType * 5);
    }
    else {
      sprintf(acStack_38,"ptram.dat");
    }
    sprintf(acStack_a0,"%sdusty.viv",Paths_Paths[3]);
    pThis = loadfileadrz(acStack_a0,(void *)0x10);
    mem = (char *)locatebig(pThis, acStack_38, 0) /* @0x7Axxx: $a2 dropped by Ghidra; 0=locate-from-start, verify #148 */;
    handle = Udff_Opena((char *)0x0,mem,0);
    if (index < GameSetup_gData.numCars) {
      AIInit_InitAICar(carObj,handle_00);
      AIInit_RestartAICar(carObj);
      pCVar2 = reservememadr("carSpecs",0x1d0,0);
      carObj->specs = pCVar2;
      Physics_InitCarSpecs(carObj,handle);
      if ((carObj->carFlags & 4U) != 0) {
        Physics_CalculateDerivedCarSpecs(carObj);
      }
    }
  }
  carObj->funcUpdateRoadInfo =
       (u_char **)Newton_UpdateRoadInfo;
  carObj->funcReplay = (u_char **)Replay_DoReplay;
  carObj->funcControl = (u_char **)Control_Human;
  carObj->funcStats = (u_char **)Stats_TrackStats;
  carObj->funcHandlingPhysics = (u_char **)Physics_SimCar;
  carObj->funcGravityPhysics =
       (u_char **)Newton_ApplyTheLawOfGravity;
  carObj->funcQDPhysicsUpdateVel =
       (u_char **)Newton_QDUpdateVel;
  carObj->funcQDPhysicsUpdateRot =
       (u_char **)Newton_QDUpdateRot64Hz;
  carObj->funcTestMeForCollisions =
       (u_char **)Collide_CheckMeForCollisions;
  carObj->funcDoPostCollisionStuff = (u_char **)Car_DoPostCollisionStuff;
  if ((carObj->carFlags & 2U) != 0) {
    carObj->funcControl = (u_char **)Control_AI;
    carObj->funcHandlingPhysics =
         (u_char **)AIPhysic_Main;
    carObj->funcReplay = (u_char **)0x0;
    carObj->funcQDPhysicsUpdateRot =
         (u_char **)Newton_QDUpdateRot32Hz;
  }
  if ((((carObj->carFlags & 4U) != 0) && (GameSetup_gData.catchupLogic != 0)) &&
     (0 < GameSetup_gData.commMode)) {
    carObj->funcQDPhysicsUpdateVel = (u_char **)Cars_QDUpdateVelGlue;
  }
  R3DCar_Instantiate3DCar(carObj,index);
  if (index < GameSetup_gData.numCars) {
    Udff_Close(handle_00);
    Udff_Close(handle);
    purgememadr(pThis);
    purgememadr(mem_00);
  }
  return;
}

/* ---- Cars_DeInitCar__FP8Car_tObj  [@0x8008a484] ---- */
void Cars_DeInitCar(Car_tObj *carObj)
{
  AIInit_DeInitAICar(carObj);
  if (carObj->specs != (Car_tSpecs *)0x0) {
    purgememadr(carObj->specs);
    carObj->specs = (Car_tSpecs *)0x0;
  }
  R3DCar_DeInstantiate3DCar(carObj);
  return;
}

/* ---- Cars_Restart__Fv  [@0x8008a4cc] ---- */
void Cars_Restart(void)
{
  /* MATCH: the first do-while's gNumCars cache is a SEPARATE short-lived variable from
     the second for-loop's counter -- reusing one "iVar7"/"ppCVar3" name for both
     extended their live ranges across the whole fn, forcing callee-saved regs where
     the oracle keeps loop-1 entirely in caller-saved regs (no calls in its body) and
     freshly re-reads the global each iteration of loop 2 (no cache at all there).
     63->41 diffs; residual = exact caller-saved reg PICK (a2/a1/a0 vs our t0/a3/a2) --
     a coloring floor, not source-shapable further without a permuter. */
  int i;
  Object_tIMassObjInfo *pOVar1;
  Car_tObj *pCVar2;
  Car_tObj **ppCVar3;
  Car_tObj **ppCVar4;
  Car_tObj **ppCVar5;
  Car_tObj **ppCVar6;
  int iVar6;
  int iVar7;
  int numCars;

  numCars = Cars_gNumCars;
  iVar6 = 0;
  if (0 < numCars) {
    ppCVar5 = Cars_gTotalSortedList;
    ppCVar3 = Cars_gList;
    ppCVar4 = Cars_gSortedList;
    do {
      iVar6 = iVar6 + 1;
      *ppCVar4 = *ppCVar3;
      pCVar2 = *ppCVar3;
      ppCVar3 = ppCVar3 + 1;
      ppCVar4 = ppCVar4 + 1;
      *ppCVar5 = pCVar2;
      ppCVar5 = ppCVar5 + 1;
    } while (iVar6 < numCars);
  }
  ppCVar6 = Cars_gList;
  for (iVar7 = 0; iVar7 < Cars_gNumCars; iVar7 = iVar7 + 1) {
    pCVar2 = *ppCVar6;
    ppCVar6 = ppCVar6 + 1;
    Cars_IniCarObjects(pCVar2,iVar7);
  }
  iVar7 = 0;
  while( true ) {
    iVar6 = Object_GetNumIMassObjects();
    pOVar1 = Object_IMassObjInst;
    if (iVar6 <= iVar7) break;
    Object_IMassObjInst[iVar7].lastPos.x = 0;
    pOVar1[iVar7].lastPos.y = 0;
    pOVar1[iVar7].lastPos.z = 0;
    pOVar1[iVar7].lastTick = 0;
    iVar7 = iVar7 + 1;
  }
  accidentSlice = 0;
  return;
}

/* ---- Cars_Initialize__FPci  [@0x8008a5b4] ---- */
void Cars_Initialize(char *mem,int size)
{
  int i;
  int iVar1;
  
  iVar1 = 0;
  if (0 < size) {
    do {
      *mem = '\0';
      iVar1 = iVar1 + 1;
      mem = mem + 1;
    } while (iVar1 < size);
  }
  return;
}

/* ---- Cars_StartUp__Fv  [@0x8008a5d8] ---- */
void Cars_StartUp(void)
{
  int i;
  Car_tObj*newCar;
  coorddef dim;
  Car_tObj*carObj;
  Car_tObj *pCVar1;
  Sched_tSchedule *schedule32Hz;
  BO_tNewtonObj *newtonObj;
  int iVar2;
  int iVar3;
  Car_tObj **ppCVar4;
  coorddef local_28;
  
  Cars_ResetCarCounters();
  iVar2 = 0;
  if (0 < GameSetup_gData.numCars) {
    iVar3 = 0;
    do {
      pCVar1 = reservememadr("Car_tObj",0x8dc,0);
      Cars_Initialize((char *)pCVar1,0x8dc);
      if (iVar2 < GameSetup_gData.numCars) {
        pCVar1->carInfo = (GameSetup_tCarData *)(GameSetup_gData.carInfo[0].driver + iVar3 + -0x5c);
      }
      Cars_InitializeCarTablesFlagsAndCounters(pCVar1);
      iVar2 = iVar2 + 1;
      iVar3 = iVar3 + 0xb4;
    } while (iVar2 < GameSetup_gData.numCars);
  }
  newtonObj = InfiniteMassNewton;
  for (iVar2 = 0; iVar3 = Object_GetNumIMassObjects(), iVar2 < iVar3;
      iVar2 = iVar2 + 1) {
    Object_GetIMassObjectDimensions(iVar2,&local_28);
    Newton_InitBaseNewtonObj((u_int *)newtonObj,0x201,0x280000,0x1400000,local_28.x,local_28.y,local_28.z + 0x10000);
    newtonObj = newtonObj + 1;
  }
  ppCVar4 = Cars_gList;
  for (iVar2 = 0; iVar2 < GameSetup_gData.numCars; iVar2 = iVar2 + 1) {
    pCVar1 = *ppCVar4;
    ppCVar4 = ppCVar4 + 1;
    Cars_InitCar(pCVar1,iVar2);
    Sched_AddFunction(simGlobal.schedule32Hz,pCVar1->funcUpdateRoadInfo,pCVar1,6);
  }
  if (R3DCar_LicenseShapeFile != (char *)0x0) {
    purgememadr(R3DCar_LicenseShapeFile);
  }
  R3DCar_LicenseShapeFile = (char *)0x0;
  ppCVar4 = Cars_gList;
  for (iVar2 = 0; iVar2 < GameSetup_gData.numCars; iVar2 = iVar2 + 1) {
    pCVar1 = *ppCVar4;
    ppCVar4 = ppCVar4 + 1;
    Sched_AddFunction(simGlobal.schedule32Hz,pCVar1->funcControl,pCVar1,0x15);
  }
  ppCVar4 = Cars_gList;
  for (iVar2 = 0; iVar2 < GameSetup_gData.numCars; iVar2 = iVar2 + 1) {
    pCVar1 = *ppCVar4;
    ppCVar4 = ppCVar4 + 1;
    Sched_AddFunction(simGlobal.schedule32Hz,pCVar1->funcHandlingPhysics,pCVar1,0x1e);
  }
  ppCVar4 = Cars_gList;
  for (iVar2 = 0; iVar2 < GameSetup_gData.numCars; iVar2 = iVar2 + 1) {
    pCVar1 = *ppCVar4;
    ppCVar4 = ppCVar4 + 1;
    Sched_AddFunction(simGlobal.schedule32Hz,pCVar1->funcGravityPhysics,pCVar1,0x1e);
  }
  ppCVar4 = Cars_gList;
  for (iVar2 = 0; iVar2 < GameSetup_gData.numCars; iVar2 = iVar2 + 1) {
    pCVar1 = *ppCVar4;
    ppCVar4 = ppCVar4 + 1;
    Sched_AddFunction(simGlobal.schedule32Hz,pCVar1->funcTestMeForCollisions,pCVar1,0x28);
  }
  ppCVar4 = Cars_gList;
  for (iVar2 = 0; iVar2 < GameSetup_gData.numCars; iVar2 = iVar2 + 1) {
    pCVar1 = *ppCVar4;
    ppCVar4 = ppCVar4 + 1;
    Sched_AddFunction(simGlobal.schedule32Hz,pCVar1->funcDoPostCollisionStuff,pCVar1,0x32);
  }
  Force_StartUp();
  ppCVar4 = Cars_gList;
  for (iVar2 = 0; iVar2 < GameSetup_gData.numCars; iVar2 = iVar2 + 1) {
    pCVar1 = *ppCVar4;
    if ((pCVar1->carFlags & 1U) != 0) {
      Sched_AddFunction(simGlobal.schedule64Hz,pCVar1->funcStats,pCVar1,0x19);
    }
    ppCVar4 = ppCVar4 + 1;
  }
  ppCVar4 = Cars_gList;
  for (iVar2 = 0; iVar2 < GameSetup_gData.numCars; iVar2 = iVar2 + 1) {
    pCVar1 = *ppCVar4;
    ppCVar4 = ppCVar4 + 1;
    Sched_AddFunction(simGlobal.schedule64Hz,pCVar1->funcQDPhysicsUpdateVel,pCVar1,0x1e);
  }
  ppCVar4 = Cars_gList;
  for (iVar2 = 0; iVar2 < GameSetup_gData.numCars; iVar2 = iVar2 + 1) {
    pCVar1 = *ppCVar4;
    schedule32Hz = simGlobal.schedule32Hz2;
    if ((pCVar1->carFlags & 4U) != 0) {
      schedule32Hz = simGlobal.schedule64Hz;
    }
    Sched_AddFunction(schedule32Hz,pCVar1->funcQDPhysicsUpdateRot,pCVar1,0x1e);
    ppCVar4 = ppCVar4 + 1;
  }
  return;
}

/* ---- Cars_CleanUp__Fv  [@0x8008aa40] ---- */
void Cars_CleanUp(void)
{
  int i;
  int iVar1;
  Sched_tSchedule *schedule32Hz;
  Car_tObj *pCVar2;
  Car_tObj **ppCVar3;
  int iVar4;

  iVar4 = 0;
  if (0 < Cars_gNumCars) {
    /* MATCH: residual 4-diff s0/s1 preheader-order swap (both loop-invariant addr
       materializations for Cars_gList/simGlobal land in the right regs throughout the body;
       only the ORDER the two independent lui/addiu pairs are emitted differs). Tried: dead
       early simGlobal touch; array-index Cars_gList[i] form (99 insns, +1 reg, WORSE -- the
       SYM's "i"-only local list does NOT mean array-index source; pointer-walk is correct).
       Genuine LICM/scheduling tie-break floor (§E/§F class), no pin. */
    ppCVar3 = Cars_gList;
    do {
      Sched_DeleteFunction(simGlobal.schedule32Hz,(*ppCVar3)->funcUpdateRoadInfo,*ppCVar3);
      Sched_DeleteFunction(simGlobal.schedule32Hz,(*ppCVar3)->funcControl,*ppCVar3);
      pCVar2 = *ppCVar3;
      if ((pCVar2->carFlags & 1U) != 0) {
        Sched_DeleteFunction(simGlobal.schedule64Hz,pCVar2->funcStats,pCVar2);
        pCVar2 = *ppCVar3;
      }
      Sched_DeleteFunction(simGlobal.schedule32Hz,pCVar2->funcHandlingPhysics,pCVar2);
      Sched_DeleteFunction(simGlobal.schedule32Hz,(*ppCVar3)->funcGravityPhysics,*ppCVar3);
      Sched_DeleteFunction(simGlobal.schedule64Hz,(*ppCVar3)->funcQDPhysicsUpdateVel,*ppCVar3);
      Sched_DeleteFunction(simGlobal.schedule32Hz,(*ppCVar3)->funcTestMeForCollisions,*ppCVar3);
      Sched_DeleteFunction(simGlobal.schedule32Hz,(*ppCVar3)->funcDoPostCollisionStuff,*ppCVar3);
      iVar1 = Force_IsForceOn(*ppCVar3);
      if (iVar1 != 0) {
        Sched_DeleteFunction(simGlobal.schedule32Hz,Force_Update,*ppCVar3);
      }
      pCVar2 = *ppCVar3;
      if ((pCVar2->carFlags & 4U) != 0) {
        schedule32Hz = simGlobal.schedule64Hz;
      }
      else {
        schedule32Hz = simGlobal.schedule32Hz2;
      }
      iVar4 = iVar4 + 1;
      Sched_DeleteFunction(schedule32Hz,pCVar2->funcQDPhysicsUpdateRot,pCVar2);
      Cars_DeInitCar(*ppCVar3);
      purgememadr(*ppCVar3);
      ppCVar3 = ppCVar3 + 1;
    } while (iVar4 < Cars_gNumCars);
  }
  return;
}

/* ---- Cars_FindCurrentLap__FP8Car_tObj  [@0x8008abc8] ---- */
void Cars_FindCurrentLap(Car_tObj *carObj)
{
  int roadSlice;
  u_int uVar1;
  u_int uVar2;
  
  if (GameSetup_gData.reverseTrack != 0) {
    uVar2 = (gNumSlices - (carObj->N).simRoadInfo.slice) - 1;
  }
  else {
    uVar2 = (u_int)(carObj->N).simRoadInfo.slice;
  }
  uVar1 = (u_int)(carObj->N).oldSlice;
  if (uVar1 != uVar2) {
    /* MATCH: guard-clause (negated-early) form -- the oracle branches to a SHARED merge
       point whether uVar2<0x1F5 is true OR uVar1!=0 is true, then falls into the inner
       if; the original if/else duplicated the inner-if test as a separate branch
       (+4/+5 insns short). DeMorgan the OR into the negated guard + else-if. */
    if ((0x1f5 <= (int)uVar2) && (uVar1 == 0)) {
      carObj->unlap = carObj->unlap + 1;
    }
    else if ((uVar2 < 0x33) && (500 < (carObj->N).oldSlice)) {
      if (1 <= carObj->unlap) {
        carObj->unlap = carObj->unlap + -1;
      }
      else {
        carObj->lap = carObj->lap + 1;
      }
    }
    (carObj->N).oldSlice = (u_short)uVar2;
  }
  return;
}

/* ---- Cars_CalculateRoadSpan__FP8Car_tObj  [@0x8008ac80] ---- */
int Cars_CalculateRoadSpan(Car_tObj *carObj)
{
  int span;
  int tempSpan;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  int iVar10;
  
  iVar10 = (carObj->N).roadMatrix.m[0];
  if (iVar10 < 0) {
    iVar10 = iVar10 + 0xff;
  }
  iVar1 = (carObj->N).orientMat.m[0];
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar9 = (carObj->N).roadMatrix.m[1];
  if (iVar9 < 0) {
    iVar9 = iVar9 + 0xff;
  }
  iVar2 = (carObj->N).orientMat.m[1];
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar8 = (carObj->N).roadMatrix.m[2];
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  iVar3 = (carObj->N).orientMat.m[2];
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar1 = (iVar10 >> 8) * (iVar1 >> 8) + (iVar9 >> 8) * (iVar2 >> 8) + (iVar8 >> 8) * (iVar3 >> 8);
  if (iVar1 < 0) {
    iVar1 = -iVar1;
  }
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar2 = (carObj->N).dimension.x;
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar3 = (carObj->N).orientMat.m[3];
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar4 = (carObj->N).orientMat.m[4];
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar5 = (carObj->N).orientMat.m[5];
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  iVar10 = (iVar10 >> 8) * (iVar3 >> 8) + (iVar9 >> 8) * (iVar4 >> 8) + (iVar8 >> 8) * (iVar5 >> 8);
  if (iVar10 < 0) {
    iVar10 = -iVar10;
  }
  if (iVar10 < 0) {
    iVar10 = iVar10 + 0xff;
  }
  iVar9 = (carObj->N).dimension.y;
  if (iVar9 < 0) {
    iVar9 = iVar9 + 0xff;
  }
  iVar8 = (carObj->N).roadMatrix.m[0];
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  iVar3 = (carObj->N).orientMat.m[6];
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar4 = (carObj->N).roadMatrix.m[1];
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar5 = (carObj->N).orientMat.m[7];
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  iVar7 = (carObj->N).roadMatrix.m[2];
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  iVar6 = (carObj->N).orientMat.m[8];
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar8 = (iVar8 >> 8) * (iVar3 >> 8) + (iVar4 >> 8) * (iVar5 >> 8) + (iVar7 >> 8) * (iVar6 >> 8);
  if (iVar8 < 0) {
    iVar8 = -iVar8;
  }
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  iVar3 = (carObj->N).dimension.z;
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  return (iVar1 >> 8) * (iVar2 >> 8) + (iVar10 >> 8) * (iVar9 >> 8) + (iVar8 >> 8) * (iVar3 >> 8);
}

/* ---- Cars_CalculateRoadPosition__FP8Car_tObj  [@0x8008aec8] ---- */
int Cars_CalculateRoadPosition(Car_tObj *carObj)
{
  int iVar1;
  
  iVar1 = Newton_CalculateRoadPosition(&carObj->N);
  return iVar1;
}

/* ---- Cars_CalcVelDownRoad__FP8Car_tObj  [@0x8008aee8] ---- */
int Cars_CalcVelDownRoad(Car_tObj *carObj)
{
  /* MATCH: oracle INTERLEAVES each (linearVel,roadMatrix) pair -- correct both terms,
     multiply+mflo immediately, accumulate -- rather than computing all 6 corrections
     up front then all 3 mults at the end. Residual 30-diff floor: oracle fills the
     2nd branch's delay slot (per pair) with `sra $aN,$vN,8` (the just-corrected value's
     shift, scheduled early); ours nops it for the 1st/3rd pair (only the 2nd/middle
     pair's delay slot gets filled, apparently reg-pressure/ILP dependent on the
     preceding pending mflo) -- genuine scheduling floor (§F class), not source-shapable. */
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int result;

  iVar4 = (carObj->N).linearVel.x;
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar1 = (carObj->N).roadMatrix.m[6];
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  result = (iVar4 >> 8) * (iVar1 >> 8);

  iVar5 = (carObj->N).linearVel.y;
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  iVar2 = (carObj->N).roadMatrix.m[7];
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  result = result + (iVar5 >> 8) * (iVar2 >> 8);

  iVar6 = (carObj->N).linearVel.z;
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar3 = (carObj->N).roadMatrix.m[8];
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  return result + (iVar6 >> 8) * (iVar3 >> 8);
}

/* ---- Cars_Randomize__Fv  [@0x8008af84] ---- */
void Cars_Randomize(void)
{
  int count;
  int rLoop;
  int iVar1;
  int iVar2;
  
  if (Cars_gNumAICars != 0) {
    iVar2 = (int)((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x574)) & 0x300) >> 8;
    iVar1 = 0;
    if (iVar2 != 0) {
      do {
        randtemp = fastRandom * randSeed;
        iVar1 = iVar1 + 1;
        fastRandom = randtemp & 0xffff;
      } while (iVar1 < iVar2);
    }
  }
  return;
}

/* ---- Cars_CheckForAccidentScenes__Fv  [@0x8008b1c4] ---- */
void Cars_CheckForAccidentScenes(void)
{
  if (((GameSetup_gData.commMode != 1) && (GameSetup_gData.raceType != 1)) &&
     (GameSetup_gData.raceType != 5)) {
    if (SceneLoaded != 0) {
      if ((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x360)) == GameSetup_gData.SceneEndLap) {
        Object_ClearCustomObjects();
        SceneLoaded = 0;
        accidentSlice = 0;
      }
    }
    else if ((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x360)) == GameSetup_gData.SceneStartLap) {
      accidentSlice = Scene_BuildCustomSceneList();
      SceneLoaded = 1;
    }
  }
  return;
}

/* externs for cross-module helpers (not already in cars.cpp scope) */
void AIWorld_CalculateLaneInfo(Car_tObj *carObj);
int  AIPhysics_UseCoolPhysics(Car_tObj *carObj);
void AISpeeds_MaintainLeaderBoard(void);
void DrawW_DoObjectAnimations(void);

/* ---- Cars_SortCars__Fv  [@0x8008b1f8] ---- RECONSTRUCTED 2026-06-13 (Ghidra @NFS4.EXE.c:65838).
 *  Skipped from the cars.obj pass. Two bubble-sorts: Cars_gSortedList ascending by
 *  N.simRoadInfo.slice (then assigns sortIndex), and Cars_gTotalSortedList ascending by
 *  N.totalSlice with swapCar/swapTime bookkeeping. Ghidra byte-offset ptr-arith de-garbled. */
void Cars_SortCars(void)
{
  Car_tObj *prev, *cur;
  int j, swapped;

  do {
    swapped = 0;
    for (j = 1; j < Cars_gNumCars; j++) {
      prev = Cars_gSortedList[j - 1];
      cur  = Cars_gSortedList[j];
      if (cur->N.simRoadInfo.slice < prev->N.simRoadInfo.slice) {
        swapped = 1;
        Cars_gSortedList[j - 1] = cur;
        Cars_gSortedList[j]     = prev;
      }
    }
  } while (swapped != 0);

  for (j = 0; j < Cars_gNumCars; j++) {
    Cars_gSortedList[j]->sortIndex = j;
  }

  do {
    swapped = 0;
    for (j = 1; j < Cars_gNumCars; j++) {
      prev = Cars_gTotalSortedList[j - 1];
      cur  = Cars_gTotalSortedList[j];
      if (cur->N.totalSlice < prev->N.totalSlice) {
        prev->swapCar  = cur;
        cur->swapCar   = prev;
        cur->swapTime  = simGlobal.gameTicks;
        prev->swapTime = simGlobal.gameTicks;
        Cars_gTotalSortedList[j - 1] = cur;
        Cars_gTotalSortedList[j]     = prev;
        swapped = 1;
      }
    }
  } while (swapped != 0);
}

/* ---- Cars_ManageBureaucracy__Fv  [@0x8008affc] ---- RECONSTRUCTED 2026-06-13 (Ghidra @NFS4.EXE.c:65747).
 *  Skipped from the cars.obj pass. Per active car: recompute road span/position + lane info,
 *  (cool physics) velocity-down-road, (carFlags&4) direction sign from orientMat.row . slice
 *  forward vector, (sliceChanged) lap/total-slice; then sort, randomize, leaderboard, anims. */
void Cars_ManageBureaucracy(void)
{
  Car_tObj **ppCar;
  Car_tObj *carObj;
  int i, dir, d0, d1, d2, slice;

  ppCar = Cars_gList;
  for (i = 0; i < Cars_gNumCars; i++) {
    carObj = *ppCar;
    if (carObj->N.active != '\0') {
      carObj->roadSpan = Cars_CalculateRoadSpan(carObj);
      carObj->roadPosition = Cars_CalculateRoadPosition(carObj);
      AIWorld_CalculateLaneInfo(carObj);
      if (AIPhysics_UseCoolPhysics(carObj) != 0) {
        carObj->currentSpeed = Cars_CalcVelDownRoad(carObj);
      }
      if ((carObj->carFlags & 4U) != 0) {
        carObj->speed = carObj->N.speedXZ;
        if ((unsigned)(carObj->currentSpeed + 0x2ffff) < 0x5ffff) {
          slice = carObj->N.simRoadInfo.slice;
          d0 = fixedmult(carObj->N.orientMat.m[6], (int)BWorldSm_slices[slice].forward[0]);
          d1 = fixedmult(carObj->N.orientMat.m[7], (int)BWorldSm_slices[slice].forward[1]);
          d2 = fixedmult(carObj->N.orientMat.m[8], (int)BWorldSm_slices[slice].forward[2]);
          dir = 1;
          if (d0 + d1 + d2 < 1) {
            dir = -1;
          }
        } else {
          dir = -1;
          if (-1 < carObj->currentSpeed) {
            dir = 1;
          }
        }
        carObj->direction = dir;
      }
      if (carObj->N.simRoadInfo.sliceChanged != '\0') {
        Cars_FindCurrentLap(carObj);
        Cars_FindTotalSlice(carObj);
      }
    }
    ppCar = ppCar + 1;
  }
  Cars_SortCars();
  Cars_Randomize();
  AISpeeds_MaintainLeaderBoard();
  DrawW_DoObjectAnimations();
}
