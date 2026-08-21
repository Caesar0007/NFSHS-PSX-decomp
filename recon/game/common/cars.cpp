/* game/common/cars.cpp -- RECONSTRUCTED (NFS4 game clock: 128Hz EAC timer chain + master IRQ handler).
 *   3 fns: MasterInterruptHandler / SystemStartUp / SystemCleanUp. SYM-v3 locals; owns 4 globals.
 *   Verified vs disasm-v2.txt (addtimer/deltimer 1-arg = &Clock_MasterInterruptHandler). Self-contained.
 */
#include "../../nfs4_types.h"
#include "cars_externs.h"

/* w64-a19 LINK FIX: these four cross-module helpers + the file-local Cars_SortCars were
 * used BEFORE any declaration was in scope (the prototypes sat below their call sites at
 * old lines 2304-2308), so cc1plus fell back to an IMPLICIT declaration and emitted the
 * calls with UNMANGLED C names -- 5 unresolvable symbols at link (`Cars_SortCars` was even
 * undefined in the very object that defines `Cars_SortCars__Fv`).  Declaring them here,
 * ahead of every use, is the fix; the prototypes are unchanged. */
void AIWorld_CalculateLaneInfo(Car_tObj *carObj);
int  AIPhysics_UseCoolPhysics(Car_tObj *carObj);
void AISpeeds_MaintainLeaderBoard(void);
void DrawW_DoObjectAnimations(void);
void Cars_SortCars(void);

#define WRAP_SLICE(a,b) (((a) >= 0) \
    ? ((((b) + (a)) >= gNumSlices) ? ((b) + (a)) - gNumSlices : ((b) + (a))) \
    : ((((b) + (a)) < 0) ? ((b) + (a)) + gNumSlices : ((b) + (a))))


/* ---- clock.obj-owned globals (.bss zero) ---- */
int          Cars_topSpeedCap[22] = { 4107141, 3932160, 4653056, 4587520, 4660264, 4631429, 4805754, 4514775, 4543610, 5097390, 5388369, 5417861, 5796003, 6087639, 5825495, 6552944, 7274496, 7274496, 7274496, 7274496, 7274496, 7274496 };   /* @0x8010f828 */
static int   Cars_kSmokingSurface[16] = { 0, 0, 655360, 0, 0, 1310720, 0, 0, 0, 655360, 0, 0, 1310720, 1310720, 0, 655360 };   /* @0x8010f880; SYM STAT */
int          Cars_kSkidMarkSurface[16] = { 0, 1, 2, 2, 1, 2, 0, 1, 0, 2, 1, 1, 1, 2, 0, 2 };   /* @0x8010f8c0 */
static int   Cars_kConvertFromRoadToSfxType[16] = { 0, 1, 7, 8, 1, 6, 0, 1, 0, 9, 1, 1, 1, 6, 0, 9 };   /* @0x8010f900; SYM STAT */
static int   Cars_kAudioRoadSurfaceInterface[16] = { 0, 0, 3, 12, 0, 3, 0, 0, 11, 11, 0, 0, 3, 3, 3, 11 };   /* @0x8010f940; SYM STAT */
static int   Cars_kSFXWallSurfaceInterface[8] = { 0, 4, 4, 6, 4, 8, 0, 6 };   /* @0x8010f980; SYM STAT */
static int   Cars_kAudioWallSurfaceInterface[8] = { 4, 4, 4, 13, 4, 14, 13, 13 };   /* @0x8010f9a0; SYM STAT */
static int   Cars_kAudioCollisoinTypeInterface[7] = { 1, 2, 2, 2, 1, 1, 1 };   /* @0x8010f9c0; SYM STAT */
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

  if ((carObj->carFlags & 0x10U) != 0) {
    return;
  }
  iVar1 = fixedmult(0x10000,(carObj->N).orientMat.m[4]);
  if (iVar1 < 0xb5c2) {
    gravity_ch.x = fixedmult(-0xa0000,(carObj->N).orientMat.m[1]);
    gravity_ch.y = fixedmult(-0xa0000,(carObj->N).orientMat.m[4]);
    gravity_ch.z = fixedmult(-0xa0000,(carObj->N).orientMat.m[7]);
    (carObj->linearAcc_ch).x = (carObj->linearAcc_ch).x + gravity_ch.x;
    (carObj->linearAcc_ch).y = (carObj->linearAcc_ch).y + gravity_ch.y;
    (carObj->linearAcc_ch).z = (carObj->linearAcc_ch).z + gravity_ch.z;
  }
  else {
    if (0x3f < (u_char)(carObj->control).brakeLevel) {
      return;
    }
    gravity_ch.z = fixedmult(-0xa0000,(carObj->N).orientMat.m[7]);
    gravity_ch.z = fixedmult(gravity_ch.z,(carObj->N).gravityMult);
    iVar1 = __builtin_abs(gravity_ch.z);
    if (iVar1 < 0xccd) {
      return;
    }
    if (0 < gravity_ch.z) {
      iVar2 = (carObj->linearAcc_ch).z;
      iVar1 = gravity_ch.z >> 1;
      if (iVar2 < 1) {
        iVar1 = gravity_ch.z >> 3;
      }
    }
    else {
      iVar2 = (carObj->linearAcc_ch).z;
      iVar1 = gravity_ch.z >> 3;
      if (iVar2 < 1) {
        iVar1 = gravity_ch.z >> 1;
      }
    }
    (carObj->linearAcc_ch).z = iVar2 + iVar1;
  }
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
  int lapLoop;

  lapLoop = 0;
  stats = &carObj->stats;
  stats->sliceTotal = 0;
  stats->sliceTime = 0;
  stats->slice = 0;
  stats->lastSlice = 0;
  stats->lap = 0;
  stats->lapTime = 0x200;
  do {
    stats->time[lapLoop] = 0;
    stats->topSpeed[lapLoop] = 0;
    lapLoop = lapLoop + 1;
  } while (lapLoop < 4);
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
  int carType;
  char *pcVar1;
  void *pvVar2;
  u_int uVar4;
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
  carType = carObj->carInfo->carType;
  if (carType < 0x1d) {
    pcVar1 = TextSys_Word(carType + 0x4e);
    strcpy(carObj->carNameLocalized,pcVar1);
  }
  else {
    sprintf(carObj->carNameLocalized,"");
  }
  if ((uVar7 & 1) == 0) goto LAB_80086300;
  pvVar2 = PlayerNameExist(Cars_gNumHumanRaceCars);
  if (pvVar2 != (void *)0x0) {
    pcVar1 = PlayerNameMixedCase(Cars_gNumHumanRaceCars);
  }
  else {
    if (frontEnd.gameMode == '\x01') {
      pcVar1 = TextSys_Word(0x2f);
      sprintf(carObj->carInfo->driver,pcVar1,Cars_gNumHumanRaceCars + 1);
      goto LAB_80086248;
    }
    pcVar1 = TextSys_Word(0x2e);
  }
LAB_80086234:
  sprintf(carObj->carInfo->driver,pcVar1);
LAB_80086248:
  strcpy(carObj->carInfo->license,frontEnd.licensePlate[Cars_gNumHumanRaceCars]);
  carObj->humanIndex = Cars_gNumHumanRaceCars;
  Cars_gHumanRaceCarList[Cars_gNumHumanRaceCars] = carObj;
  Cars_gNumHumanRaceCars = Cars_gNumHumanRaceCars + 1;
  carObj->carFlags = carObj->carFlags | 4;
  Cars_gRaceCarList[Cars_gNumRaceCars] = carObj;
  Cars_gNumRaceCars = Cars_gNumRaceCars + 1;
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
    personality = GameSetup_gData.carInfo[carObj->carIndex].Personality;
    strcpy(carObj->carInfo->driver,GameSetup_gPersonalityNames[0] + personality * 8);
    if (((GameSetup_gData.raceType == RaceType_HotPursuit) || (GameSetup_gData.raceType == RaceType_Id5)) &&
       (((Cars_gHumanRaceCarList[0]->carFlags & 0x200) != 0) ||
        ((Cars_gNumHumanRaceCars == 2) && ((Cars_gHumanRaceCarList[1]->carFlags & 0x200) != 0)))) {
      strcpy(carObj->carInfo->license,TextSys_Word(0x32));
    }
    else {
      strcpy(carObj->carInfo->license,
             GameSetup_gPersonalityNames[0] + personality * 8);
    }
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
       (((GameSetup_gData.raceType != RaceType_HotPursuit && (GameSetup_gData.raceType != RaceType_Id5)) ||
        (((Cars_gHumanRaceCarList[0]->carFlags & 0x200) == 0) &&
         ((Cars_gNumHumanRaceCars != 2) || ((Cars_gHumanRaceCarList[1]->carFlags & 0x200) == 0)))))) {
      Cars_gLifeBasisCarList[Cars_gNumLifeBasisCars] = carObj;
      Cars_gNumLifeBasisCars = Cars_gNumLifeBasisCars + 1;
      carObj->carFlags = carObj->carFlags | 0x100;
    }
  }
  if ((uVar7 & 4) != 0) {
    Cars_gAICarList[Cars_gNumAICars] = carObj;
    Cars_gNumAICars = Cars_gNumAICars + 1;
    carObj->carFlags = carObj->carFlags | 2;
    Cars_gTrafficCarList[Cars_gNumTrafficCars] = carObj;
    Cars_gNumTrafficCars = Cars_gNumTrafficCars + 1;
    carObj->carFlags = carObj->carFlags | 0x10;
  }
  if ((uVar7 & 0x18) != 0) {
    Cars_gAICarList[Cars_gNumAICars] = carObj;
    Cars_gNumAICars = Cars_gNumAICars + 1;
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

/* The empty format literal above occupies .sdata @0x8013c7e0; alignment then
   places these two initialized limits at their retail addresses. */
int frontLimit = 32768;   /* @0x8013c7e4 */
int rearLimit = 65536;    /* @0x8013c7e8 */

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
  int direction;

  memset((u_char *)&offset,'\0',0xc);
  direction = carObj->desiredDirection;
  (carObj->collision).smoking = 0;
  /* MATCH (w64-a15, DUAL-LANE: gate PASS 280/280 + psyqproof REAL=0): the blowout early-return
   * REPEATS `smoking = 0` even though the store two lines up already did it.  That duplicate is
   * what makes cross_jump merge this arm's `sw $zero,0x78C($s2); j <epilogue>` tail with the
   * SAME tail of the big early-return arm below, and -- crucially -- the merged block's LABEL
   * lands BEFORE the store, so the `bnez $v0` guard targets `.L800867D0` (dist 75) exactly like
   * retail.  Without the duplicate our arm is a bare `j <epilogue>`, jump.c's follow_jumps
   * forwards the guard straight to the epilogue (dist 256), and the resulting wrong branch WORD
   * is invisible to verify_asm (04Q: targets normalise to T) -- gate PASS, psyqproof REAL=1
   * word 15.  Count is unchanged (280) because the two tails merge back to one copy. */
  if (carObj->blowout != 0) {
    (carObj->collision).smoking = 0;
    return;
  }
  if (forceReset == 0) {
    if (((0xc000 < (carObj->N).roadMatrix.m[3] / 256 * ((carObj->N).orientMat.m[3] / 256) +
                   (carObj->N).roadMatrix.m[4] / 256 * ((carObj->N).orientMat.m[4] / 256) +
                   (carObj->N).roadMatrix.m[5] / 256 * ((carObj->N).orientMat.m[5] / 256)) &&
         ((carObj->N).angularVel.x < 0x10000)) &&
        ((carObj->N).angularVel.z < 0x10000) &&
        ((((carObj->N).driveSurfaceType != 0xe &&
          ((carObj->N).driveSurfaceType != 0)) &&
         (((carObj->N).simRoadInfo.simQuad != (Trk_NewSimQuad *)0x0 &&
          (((carObj->N).flightTime < 6 && ((carObj->N).objAltitude < 0x10000)))))))) {
      (carObj->collision).smoking = 0;
      return;
    }
  }
  newSlice = (carObj->N).simRoadInfo.slice;
  newSlice = WRAP_SLICE(direction * 4,newSlice);
  if (forceReset == 2) {
    newSlice = (int)(carObj->N).simRoadInfo.slice;
  }
  if (0 < accidentSlice) {
    if ((newSlice < WRAP_SLICE(5,accidentSlice)) &&
        (WRAP_SLICE(-5,accidentSlice) < newSlice)) {
      newSlice = WRAP_SLICE(direction * 5,newSlice);
    }
  }
  {
    int side;   /* SYM block-62 side (s4): stays 0 -- the loop's `offset.x += side << 14`
                   nudge is a REAL EA BUG (inner block-63 `side` SHADOWS this one, so the
                   computed side never reaches the loop; oracle sll $s4,14 with s4==0). */
    side = 0;
    {
      int side;   /* SYM block-63 side (v1) -- shadows the outer one */
      side = carObj->carIndex / 2 * 2 != carObj->carIndex;
      if (direction == -1) {
        side = 1 - side;
      }
      if (AITune_driveSide == -1) {
        side = 1 - side;
      }
      if (side != 0) {
        offset.x =
            -(((u_int)BWorldSm_slices[newSlice].avgPavedWidthLf << 15) *
              (BWorldSm_slices[newSlice].laneCount >> 4)) +
            (carObj->N).dimension.x / 256 * 0x180;
      }
      else {
        offset.x = ((u_int)BWorldSm_slices[newSlice].avgPavedWidthRt << 15) *
                       (BWorldSm_slices[newSlice].laneCount & 0xf) -
                   (carObj->N).dimension.x / 256 * 0x180;
      }
    }
    Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,newSlice,&offset,direction);
    resetCounter = 0;
    while (((carObj->N).driveSurfaceType == 0 || ((carObj->N).driveSurfaceType == 0xe)) ||
           ((carObj->N).simRoadInfo.simQuad == (Trk_NewSimQuad *)0x0)) {
      offset.x = offset.x + (side << 14);
      Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,newSlice,&offset,direction);
      resetCounter = resetCounter + 1;
      if (0x28 < resetCounter) {
        offset.x = 0;
        Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,newSlice,&offset,direction);
        break;
      }
    }
  }
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

  if ((carObj->carFlags & 0x400U) != 0) {
    return;
  }
  y = carObj->blowout;
  if (y != 0) {
    if ((carObj->linearVel_ch.z < 0 ? -carObj->linearVel_ch.z :
         carObj->linearVel_ch.z) < 0x1999) {
      if ((carObj->linearVel_ch.x < 0 ? -carObj->linearVel_ch.x :
           carObj->linearVel_ch.x) < 0x1999) {
        carObj->blowout = y + 1;
      }
    }
    if (carObj->blowout > 0x140) {
      carObj->blowout = 0;
      Cars_ResetCollidedCars(carObj,1,0);
    }
    /* MATCH (w64-a15, DUAL-LANE: gate PASS 597/597 + psyqproof REAL=0): the blowout RE-TEST lives
     * INSIDE the `y != 0` arm, spelled as an inverted `goto` over the pull-over block -- NOT as a
     * following `if (carObj->blowout == 0) { ... }` wrapper.  Retail's entry guard is
     * `beqz $v1,.L80086BF0` (dist 31) = straight to the pullOver `lw 0x278`, skipping the re-read
     * of blowout entirely; the wrapper form makes that guard target the re-read block instead
     * (dist 27).  Both spellings emit the SAME 597 words, so verify_asm cannot tell them apart
     * (04Q) -- psyqproof word 14 is the only witness. */
    if (carObj->blowout != 0) goto afterPullOver;
  }
  if (carObj->pullOver == 0) {
      if (carObj->control.abort) {
        if (carObj->stats.finishType == 0) {
          if (simGlobal.gameTicks > 0x340) {
            if (carObj->stats.fatalCrashes == 0) {
              if (carObj->N.speedXZ <= 0x1b9998) {
                int player;

                Cars_ResetCollidedCars(carObj,2,0);
                carObj->stats.fatalCrashes = 0xa0;
                player = carObj == Cars_gHumanRaceCarList[0];
                Camera_gInfo[player].relpos.x = -carObj->N.orientMat.m[6] * 2;
                Camera_gInfo[player].relpos.y = -carObj->N.orientMat.m[7] * 2;
                Camera_gInfo[player].relpos.z = -carObj->N.orientMat.m[8] * 2;
              }
            }
          }
        }
      }
    }
afterPullOver:
  if (carObj->stats.fatalCrashes > 0) {
    carObj->stats.fatalCrashes--;
  }
  if (carObj->collision.smoking) {
    TrgSfx_CrashCar(&carObj->N.position);
    if (carObj->N.flightTime == 0) {
      carObj->collision.smoking = 0;
    }
  }
  if (carObj->audioDamageScrape && !carObj->N.simOptz) {
    int wheel;
    int roadSurfaceWheel;
    int surfaceType;

    wheel = 2;
    if (carObj->render.currentRoll < 0) {
      wheel = 3;
    }
    roadSurfaceWheel = carObj->wheel[wheel].roadSurfaceType;
    surfaceType = Cars_kSkidMarkSurface[roadSurfaceWheel & 0xf];
    if (surfaceType == 1) {
      if ((random() & 3) == 0) {
        coorddef position;
        coorddef point;
        coorddef sideX;
        coorddef sideZ;

        sideX.x = carObj->N.wheelBackX / 0x100 * carObj->N.orientMat.m[0] / 0x100;
        sideX.y = carObj->N.wheelBackX / 0x100 * carObj->N.orientMat.m[1] / 0x100;
        sideX.z = carObj->N.wheelBackX / 0x100 * carObj->N.orientMat.m[2] / 0x100;
        sideZ.x = 0;
        sideZ.y = 0;
        sideZ.z = 0;
        position.x = carObj->N.position.x;
        position.y = carObj->N.position.y;
        position.z = carObj->N.position.z;
        position.y = carObj->N.groundElevation;
        if ((wheel & 1) == 0) {
          point.x = position.x - sideX.x;
          point.y = position.y - sideX.y;
          point.z = position.z - sideX.z;
        }
        else {
          point.x = position.x + sideX.x;
          point.y = position.y + sideX.y;
          point.z = position.z + sideX.z;
        }
        point.x -= sideZ.x;
        point.y -= sideZ.y;
        point.z -= sideZ.z;
        TrgSfx_AddCarSfx(carObj->N.objID,&point,4,&carObj->N.linearVel);
      }
    }
    carObj->audioDamageScrape = 0;
  }
  if (carObj->N.collision.impulse) {
    int surface1;
    int surface2;
    int collisionType;
    int debris;

    debris = 0;
    collisionType = carObj->N.collision.sfxType & 0xefff0000;
    if (carObj->carInfo->carType < 0x1c) {
      if ((carObj->render.damageParts & 1) == 0) {
        if (carObj->N.damage[7] > 0x1e0000) {
          carObj->render.damageParts |= 1;
          debris = 1;
        }
      }
      if ((carObj->render.damageParts & 2) == 0) {
        if (carObj->N.damage[3] > 0x1e0000) {
          carObj->render.damageParts |= 2;
          debris = 1;
        }
      }
      if ((carObj->render.damageParts & 4) == 0) {
        if (carObj->N.damage[8] > 0x30000) {
          carObj->render.damageParts |= 4;
          debris = 1;
        }
      }
      if ((carObj->render.damageParts & 8) == 0) {
        if (carObj->N.damage[0] > 0x1e0000) {
          carObj->render.damageParts |= 8;
          debris = 1;
        }
      }
      if ((carObj->render.damageParts & 0x10) == 0) {
        if (carObj->N.damage[2] > 0x1e0000) {
          carObj->render.damageParts |= 0x10;
          debris = 1;
        }
      }
      if ((carObj->render.damageParts & 0x20) == 0) {
        if (carObj->N.damage[6] > 0x1e0000) {
          carObj->render.damageParts |= 0x20;
          debris = 1;
        }
      }
      if ((carObj->render.damageParts & 0x40) == 0) {
        if (carObj->N.damage[4] > 0x1e0000) {
          carObj->render.damageParts |= 0x40;
          debris = 1;
        }
      }
    }
    if ((carObj->N.collision.otherObj == 0) &&
        (carObj->N.collision.impulse > 0x4b0000)) {
      if (carObj->carFlags & 4) {
        Physics_FixEngineRpm(carObj);
      }
      TrgSfx_CrashCar(&carObj->N.position);
      carObj->collision.smoking = 1;
      carObj->frontSkid = 0;
      carObj->rearSkid = 0;
      if (carObj->collision.resetTimer <= 0) {
        carObj->collision.resetTimer = 0x140;
      }
    }
    if (collisionType == 0x40000) {
      coorddef impactPoint;

      impactPoint = carObj->N.collision.collisionPoint;
      impactPoint.y += 0x8000;
      if (carObj->N.speedXZ > 0x180000) {
        if (carObj->N.objAltitude < 0x9999) {
          TrgSfx_AddCarSfx(carObj->N.objID,&impactPoint,
              Cars_kSFXWallSurfaceInterface[(u_char)carObj->N.collision.sfxType],
              &carObj->N.linearVel);
          if (Cars_kSFXWallSurfaceInterface[(u_char)carObj->N.collision.sfxType] == 4) {
            Cars_SetAudioCalls(carObj,1,-1,1,0xf,0,0);
          }
        }
        else {
          TrgSfx_AddCarSfx(carObj->N.objID,&impactPoint,6,&carObj->N.linearVel);
        }
      }
      else {
        if ((carObj->N.speedXZ > 0xf0000) ||
            (carObj->N.collision.impulse > 0xf0000) || debris) {
          TrgSfx_AddCarSfx(carObj->N.objID,&impactPoint,1,&carObj->N.linearVel);
        }
      }
    }
    if (carObj->N.collision.impulse > 0xa0000) {
      surface1 = Cars_kAudioCollisoinTypeInterface[collisionType >> 16];
      if (collisionType == 0x40000) {
        surface2 = Cars_kAudioWallSurfaceInterface[(u_char)carObj->N.collision.sfxType];
      }
      else if (collisionType <= 0x30000) {
        surface2 = Cars_kAudioRoadSurfaceInterface[(u_char)carObj->N.collision.sfxType];
        if (collisionType == 0x30000) {
          if (carObj->N.orientationToGround.y < 0xe666) {
            surface1 = 1;
          }
          TrgSfx_CrashCar(&carObj->N.collision.collisionPoint);
        }
      }
      else {
        surface2 = (u_char)carObj->N.collision.sfxType;
        if (collisionType == 0x50000) {
          coorddef impactPoint;

          impactPoint = carObj->N.collision.collisionPoint;
          impactPoint.y += 0x8000;
          TrgSfx_AddCarSfx(carObj->N.objID,&impactPoint,4,&carObj->N.linearVel);
        }
      }
      Cars_SetAudioCalls(carObj,1,-1,surface1,surface2,
          carObj->N.collision.impulse / 8,0);
    }
    carObj->N.collision.impulse = 0;
    carObj->N.collision.otherObj = 0;
    carObj->N.collision.sfxType = 0;
  }
  if ((carObj->collision.resetTimer > 0) && (carObj->pullOver == 0)) {
    carObj->collision.resetTimer--;
    if ((carObj->N.speedXZ +
         (carObj->N.linearVel.y >= 0 ? carObj->N.linearVel.y :
          -carObj->N.linearVel.y) < 0x10000) ||
        (carObj->N.driveSurfaceType == 0) ||
        (carObj->N.driveSurfaceType == 0xe)) {
      carObj->collision.resetTimer -= 8;
    }
    if (carObj->collision.resetTimer <= 0) {
      Cars_ResetCollidedCars(carObj,0,0);
      carObj->collision.resetTimer = 0;
    }
  }
  y = carObj->N.roadMatrix.m[3] / 0x100 * (carObj->N.orientMat.m[3] / 0x100) +
      carObj->N.roadMatrix.m[4] / 0x100 * (carObj->N.orientMat.m[4] / 0x100) +
      carObj->N.roadMatrix.m[5] / 0x100 * (carObj->N.orientMat.m[5] / 0x100);
  if ((carObj->collision.resetTimer <= 0) &&
      ((y < 0x1999) || (carObj->N.driveSurfaceType == 0) ||
       (carObj->N.driveSurfaceType == 0xe))) {
    carObj->collision.resetTimer = 0x140;
  }
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

  objID = carObj->N.objID;
  sfxType = Cars_kConvertFromRoadToSfxType[roadSurface & 0xf];
  stateBit = 1 << wheel;
  smoking = Cars_kSmokingSurface[roadSurface & 0xf];
  if (surfaceType == 3) {
    smoking = 0;
  }
  /* MATCH (W55-A10, sealed 272/272 PASS) -- the W54-A13 retail SHAPE + the REF-STEP fix.
     W54-A13 proved the SLD statement order below makes the instruction stream EXACT but left
     a 5-way callee-saved permutation (98 diffs) because `sfxDelay` carried NINE refs where
     retail's carries SEVEN (floor_log2 REF-STEP 3->2, reqdelta receipt).  THE MISSING 2 REFS
     were the DUPLICATED tail call in each arm: the source wrote
        if (smoking-cond) { AddCarWheelSfx(..,sfxDelay); return; }
        if (skid > 0x40000) { AddCarWheelSfx(..,sfxDelay); }
     = 2 sfxDelay refs per arm.  Since both blocks END the function, they are semantically ONE
     guarded call -- merging them into `if (smoking-cond || skid > 0x40000) { AddCarWheelSfx(); }`
     emits the IDENTICAL code (gcc cross-jumps the duplicate anyway, count stays 272) but
     flow.c now counts ONE ref per arm => 9 -> 7 => the whole permutation lands.
     (Catalog: cross-jumped duplicates still cost REG_N_REFS -- used here in the DELETE
     direction; do NOT re-split these two ifs.)
     SLD (nfs4-f-v3, VA 0x800874FC..) says retail is:
        1169  traffic  = 0;
        1170  sfxDelay = gTAddCarWheelDelay;
        1171  if (carObj->render.currentCarType > 0x1c) {
        1173      traffic   = 1;
        1174      sfxDelay <<= traffic;        <- sllv INSIDE the if (bnez target = .L80087528)
              }
        1176  if (... == 0x1c) return;
     and the head statement order is objID(1160) / sfxType(1162) / stateBit(1164) /
     smoking(1166) / `if (surfaceType==3) smoking=0` (1167).  Transcribing all of that makes
     the INSTRUCTION STREAM EXACT (272/272, every mnemonic+operand-shape aligned); the 5-way
     callee-saved PERMUTATION it left (ours {sfxDelay s3, skidpt s4, stateBit s5, smoking s6,
     sfxType s7} vs retail {skidpt s3, stateBit s4, sfxDelay s5, smoking s6, sfxType s7} = 98
     gate diffs) is exactly what the ref-step edit above dissolves.  Falsified on the way:
     every branch-free spelling of
     `traffic` (`x>0x1c`, `?:`, default+override, if/else-both-assign) folds to slti+xori --
     only the `traffic=1` INSIDE the if survives; `traffic=0` must sit BEFORE
     `sfxDelay = gTAddCarWheelDelay;` (it is the bnez delay slot). */
  traffic = 0;
  sfxDelay = gTAddCarWheelDelay;
  if (carObj->render.currentCarType > 0x1c) {
    traffic = 1;
    sfxDelay <<= traffic;
  }
  if (carObj->render.currentCarType == 0x1c) {
    return;
  }
  if (wheel >= 2) {
    if (drawSkid && surfaceType && !traffic) {
      if ((skidpt->x != carObj->oldSkidPoint[wheel].x) ||
          (skidpt->z != carObj->oldSkidPoint[wheel].z)) {
        int skid;

        if (wheel == 2) {
          skid = carObj->rearSkid - carObj->gTransferRight;
        }
        else {
          skid = carObj->rearSkid + carObj->gTransferRight;
        }
        skid = (skid - 0x10000 < 0 ? 0 : skid - 0x10000) > 0x60000 ?
            0x60000 : (skid - 0x10000 < 0 ? 0 : skid - 0x10000);
        TrgSfx_AddSkidmark(objID,wheel,skidpt,0,skid,carObj,surfaceType - 1);
        carObj->oldSkidPoint[wheel] = *skidpt;
        carObj->oldSkidState |= stateBit;
      }
    }
    else {
      if (carObj->oldSkidState & stateBit) {
        TrgSfx_AddSkidmark(objID,wheel,&carObj->oldSkidPoint[wheel],1,
            carObj->rearSkid,carObj,0);
        carObj->oldSkidState -= stateBit;
      }
    }
    if (sfxType == 8) {
      TrgSfx_AddCarSplash(objID,wheel,skidpt,8,&carObj->N.linearVel,
          sfxDelay,carObj->N.speedXZ);
      return;
    }
    if (((smoking < carObj->N.speedXZ) && (smoking > 0)) ||
        (carObj->rearSkid > 0x40000)) {
      TrgSfx_AddCarWheelSfx(objID,wheel,skidpt,sfxType,&carObj->N.linearVel,sfxDelay);
    }
  }
  else {
    if (drawSkid && surfaceType && !traffic) {
      if ((skidpt->x != carObj->oldSkidPoint[wheel].x) ||
          (skidpt->z != carObj->oldSkidPoint[wheel].z)) {
        int skid;

        if (wheel == 0) {
          skid = carObj->frontSkid - carObj->gTransferRight;
        }
        else {
          skid = carObj->frontSkid + carObj->gTransferRight;
        }
        skid = (skid - 0x18000 < 0 ? 0 : skid - 0x18000) > 0x60000 ?
            0x60000 : (skid - 0x18000 < 0 ? 0 : skid - 0x18000);
        TrgSfx_AddSkidmark(objID,wheel,skidpt,0,skid,carObj,surfaceType - 1);
        carObj->oldSkidPoint[wheel] = *skidpt;
        carObj->oldSkidState |= stateBit;
      }
    }
    else {
      if (carObj->oldSkidState & stateBit) {
        TrgSfx_AddSkidmark(objID,wheel,&carObj->oldSkidPoint[wheel],1,
            carObj->frontSkid,carObj,0);
        carObj->oldSkidState -= stateBit;
      }
    }
    if (sfxType == 8) {
      TrgSfx_AddCarSplash(objID,wheel,skidpt,8,&carObj->N.linearVel,
          sfxDelay,carObj->N.speedXZ);
      return;
    }
    if (((smoking < carObj->N.speedXZ) && (smoking > 0)) ||
        (carObj->frontSkid > 0x40000)) {
      TrgSfx_AddCarWheelSfx(objID,wheel,skidpt,sfxType,&carObj->N.linearVel,sfxDelay);
    }
  }
}

/* ---- Car_TireSkiddingStuff__FP8Car_tObj  [@0x800878cc] ---- */
void Car_TireSkiddingStuff(Car_tObj *carObj)
{
  /* SYM 8c @0x800878cc: fsize=168 mask=$c0ff0000; REGs: visible=s5 front=s3 rear=s4
     skidFront=s6 roadSurface=a1 roadSurfaceWheel=s2 surfaceType=s1 speed=fp wetRoad=s7;
     AUTOs: position@-136 point@-120 audioSurface@-56 originalFront@-52 originalRear@-48;
     12 wheel blocks each redeclare block-local coorddef wheelFrontX/Z (or Back). */
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

  visible = 0;
  speed = *(short *)((int)&(carObj->N).speedXZ + 2);
  wetRoad = 0;
  if (GameSetup_gData.Weather != 0) {
    wetRoad = BWorldSm_TunnelFlagSm(&(carObj->N).simRoadInfo) != 1;
  }
  roadSurface = (carObj->N).driveSurfaceType;
  if (((carObj->N).distToPlayer < 0x3c0000) && ((carObj->N).objAltitude < 0x6666)) {
    do {
      do {
        visible = 1;
      } while (0);
    } while (0);
  }
  if (visible != 0) {
    front = 0;
    position.x = (carObj->N).position.x;
    position.y = (carObj->N).position.y;
    position.z = (carObj->N).position.z;
    position.y = (carObj->N).groundElevation;
    do {
      if (carObj->frontSkid > 0) {
        int cappedFront =
            (0xa0000 < carObj->frontSkid) ? 0xa0000 : carObj->frontSkid;
        int skidVelocity;
        front = cappedFront;
        originalFront = front;
        skidVelocity = (carObj->linearVel_ch).z;
        carObj->frontSkid = front;
        if (__builtin_abs(skidVelocity) > 0x140000) {
          skidFront = front - __builtin_abs(skidVelocity / 8);
          break;
        }
      }
      else {
        originalFront = 0;
      }
      skidFront = front;
    } while (0);
    if (carObj->rearSkid > 0) {
      rear = carObj->rearSkid =
          (0xa0000 < carObj->rearSkid) ? 0xa0000 : carObj->rearSkid;
      originalRear = rear;
    }
    else {
      rear = 0;
      originalRear = 0;
    }
  }
  else {
    front = 0;
    skidFront = front;
    rear = front;
    originalFront = 0;
    originalRear = 0;
  }
  audioSurface = Cars_kAudioRoadSurfaceInterface[roadSurface];
  if (0 < GameSetup_gData.Weather) {
    if (audioSurface == 0) {
      if (((int)BWorldSm_TunnelFlagSm(&(carObj->N).simRoadInfo) ^ 1) != 0) {
        audioSurface = 0x10;
      }
    }
  }
  else if (audioSurface == 0) {
    if (carObj->carInfo->TireType == 0) {
      audioSurface = 0x12;
    }
    else if (carObj->carInfo->TireType == 2) {
      audioSurface = 0x11;
    }
  }
  /* ---- wheel 0 (front) ---- */
  roadSurfaceWheel = carObj->wheel[0].roadSurfaceType;
  surfaceType = Cars_kSkidMarkSurface[roadSurfaceWheel & 0xf];
  if (carObj->wheel[0].wheelInAir != 0) {
    surfaceType = 0;
  }
  if (((front != 0 && wetRoad == 0) || (surfaceType >= 2 && speed != 0)) && visible != 0) {
    {
      coorddef wheelFrontX;
      coorddef wheelFrontZ;

      wheelFrontX.x = (carObj->N).wheelFrontX / 256 * (carObj->N).orientMat.m[0] / 256;
      wheelFrontX.y = (carObj->N).wheelFrontX / 256 * (carObj->N).orientMat.m[1] / 256;
      wheelFrontX.z = (carObj->N).wheelFrontX / 256 * (carObj->N).orientMat.m[2] / 256;
      wheelFrontZ.x = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[6] / 256;
      wheelFrontZ.y = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[7] / 256;
      wheelFrontZ.z = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[8] / 256;
      point.x = position.x - wheelFrontX.x;
      point.y = position.y - wheelFrontX.y;
      point.z = position.z - wheelFrontX.z;
      point.x += wheelFrontZ.x;
      point.y += wheelFrontZ.y;
      point.z += wheelFrontZ.z;
    }
    if (surfaceType >= 2 && frontLimit < skidFront) {
      surfaceType = 3;
    }
    if (surfaceType != 0) {
      Cars_AddCarSfx(carObj,0,&point,roadSurfaceWheel,surfaceType,1);
    }
    else {
      Cars_AddCarSfx(carObj,0,&point,roadSurfaceWheel,0,0);
    }
  }
  else if ((carObj->oldSkidState & 1) != 0) {
    carObj->oldSkidState = carObj->oldSkidState - 1;
    TrgSfx_AddSkidmark((carObj->N).objID,0,carObj->oldSkidPoint,1,carObj->frontSkid,carObj,0);
  }
  if (wetRoad != 0) {
    if (surfaceType == 1 && speed != 0 && visible != 0) {
      {
        coorddef wheelFrontX;
        coorddef wheelFrontZ;

        wheelFrontX.x = (carObj->N).wheelFrontX / 256 * (carObj->N).orientMat.m[0] / 256;
        wheelFrontX.y = (carObj->N).wheelFrontX / 256 * (carObj->N).orientMat.m[1] / 256;
        wheelFrontX.z = (carObj->N).wheelFrontX / 256 * (carObj->N).orientMat.m[2] / 256;
        wheelFrontZ.x = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[6] / 256;
        wheelFrontZ.y = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[7] / 256;
        wheelFrontZ.z = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[8] / 256;
        point.x = position.x - wheelFrontX.x;
        point.y = position.y - wheelFrontX.y;
        point.z = position.z - wheelFrontX.z;
        point.x += wheelFrontZ.x;
        point.y += wheelFrontZ.y;
        point.z += wheelFrontZ.z;
      }
      TrgSfx_AddCarSplash((carObj->N).objID,0,&point,10,&(carObj->N).linearVel,0,(carObj->N).speedXZ);
      {
        int splashFront;

        splashFront = front;
        if (splashFront <= 0) {
          splashFront = 1;
        }
        front = splashFront;
      }
    }
  }
  if ((roadSurfaceWheel & 0x20) != 0 && gLeafPixmap != (Draw_tPixMap *)0x0 &&
      0xA0000 < (carObj->N).speedXZ && TrgSfx_AddCarExtraCheck((carObj->N).objID,0) != 0) {
    {
      int rndOffset;
      rndOffset = ((random() & 7) - 4) * 0x3333;
      {
        coorddef wheelFrontX;
        coorddef wheelFrontZ;

        wheelFrontX.x = ((carObj->N).wheelFrontX + rndOffset) / 256 * (carObj->N).orientMat.m[0] / 256;
        wheelFrontX.y = ((carObj->N).wheelFrontX + rndOffset) / 256 * (carObj->N).orientMat.m[1] / 256;
        wheelFrontX.z = ((carObj->N).wheelFrontX + rndOffset) / 256 * (carObj->N).orientMat.m[2] / 256;
        wheelFrontZ.x = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[6] / 256;
        wheelFrontZ.y = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[7] / 256;
        wheelFrontZ.z = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[8] / 256;
        point.x = position.x - wheelFrontX.x;
        point.y = position.y - wheelFrontX.y;
        point.z = position.z - wheelFrontX.z;
        point.x += wheelFrontZ.x;
        point.y += wheelFrontZ.y;
        point.z += wheelFrontZ.z;
      }
      TrgSfx_AddCarExtraSfx((carObj->N).objID,0,&point,0xd,&(carObj->N).linearVel,(carObj->N).speedXZ,
                 *(volatile int *)&point.y,(carObj->render).light);
    }
  }

  /* ---- wheel 1 (front) ---- */
  roadSurfaceWheel = carObj->wheel[1].roadSurfaceType;
  surfaceType = Cars_kSkidMarkSurface[roadSurfaceWheel & 0xf];
  if (carObj->wheel[1].wheelInAir != 0) {
    surfaceType = 0;
  }
  if (((front != 0 && wetRoad == 0) || (surfaceType >= 2 && speed != 0)) && visible != 0) {
    {
      coorddef wheelFrontX;
      coorddef wheelFrontZ;

      wheelFrontX.x = (carObj->N).wheelFrontX / 256 * (carObj->N).orientMat.m[0] / 256;
      wheelFrontX.y = (carObj->N).wheelFrontX / 256 * (carObj->N).orientMat.m[1] / 256;
      wheelFrontX.z = (carObj->N).wheelFrontX / 256 * (carObj->N).orientMat.m[2] / 256;
      wheelFrontZ.x = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[6] / 256;
      wheelFrontZ.y = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[7] / 256;
      wheelFrontZ.z = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[8] / 256;
      point.x = position.x + wheelFrontX.x;
      point.y = position.y + wheelFrontX.y;
      point.z = position.z + wheelFrontX.z;
      point.x += wheelFrontZ.x;
      point.y += wheelFrontZ.y;
      point.z += wheelFrontZ.z;
    }
    if (surfaceType >= 2 && frontLimit < skidFront) {
      surfaceType = 3;
    }
    if (surfaceType != 0) {
      Cars_AddCarSfx(carObj,1,&point,roadSurfaceWheel,surfaceType,1);
    }
    else {
      Cars_AddCarSfx(carObj,1,&point,roadSurfaceWheel,0,0);
    }
  }
  else if ((carObj->oldSkidState & 2) != 0) {
    carObj->oldSkidState = carObj->oldSkidState - 2;
    TrgSfx_AddSkidmark((carObj->N).objID,1,carObj->oldSkidPoint + 1,1,carObj->frontSkid,carObj,0);
  }
  if (wetRoad != 0) {
    if (surfaceType == 1 && speed != 0 && visible != 0) {
      {
        coorddef wheelFrontX;
        coorddef wheelFrontZ;

        wheelFrontX.x = (carObj->N).wheelFrontX / 256 * (carObj->N).orientMat.m[0] / 256;
        wheelFrontX.y = (carObj->N).wheelFrontX / 256 * (carObj->N).orientMat.m[1] / 256;
        wheelFrontX.z = (carObj->N).wheelFrontX / 256 * (carObj->N).orientMat.m[2] / 256;
        wheelFrontZ.x = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[6] / 256;
        wheelFrontZ.y = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[7] / 256;
        wheelFrontZ.z = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[8] / 256;
        point.x = position.x + wheelFrontX.x;
        point.y = position.y + wheelFrontX.y;
        point.z = position.z + wheelFrontX.z;
        point.x += wheelFrontZ.x;
        point.y += wheelFrontZ.y;
        point.z += wheelFrontZ.z;
      }
      TrgSfx_AddCarSplash((carObj->N).objID,1,&point,10,&(carObj->N).linearVel,0,(carObj->N).speedXZ);
      {
        int splashFront;

        splashFront = front;
        if (splashFront <= 0) {
          splashFront = 1;
        }
        front = splashFront;
      }
    }
  }
  if ((roadSurfaceWheel & 0x20) != 0 && gLeafPixmap != (Draw_tPixMap *)0x0 &&
      0xA0000 < (carObj->N).speedXZ && TrgSfx_AddCarExtraCheck((carObj->N).objID,1) != 0) {
    {
      int rndOffset;
      rndOffset = ((random() & 7) - 4) * 0x3333;
      {
        coorddef wheelFrontX;
        coorddef wheelFrontZ;

        wheelFrontX.x = ((carObj->N).wheelFrontX + rndOffset) / 256 * (carObj->N).orientMat.m[0] / 256;
        wheelFrontX.y = ((carObj->N).wheelFrontX + rndOffset) / 256 * (carObj->N).orientMat.m[1] / 256;
        wheelFrontX.z = ((carObj->N).wheelFrontX + rndOffset) / 256 * (carObj->N).orientMat.m[2] / 256;
        wheelFrontZ.x = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[6] / 256;
        wheelFrontZ.y = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[7] / 256;
        wheelFrontZ.z = (carObj->N).wheelFrontZ / 256 * (carObj->N).orientMat.m[8] / 256;
        point.x = position.x + wheelFrontX.x;
        point.y = position.y + wheelFrontX.y;
        point.z = position.z + wheelFrontX.z;
        point.x += wheelFrontZ.x;
        point.y += wheelFrontZ.y;
        point.z += wheelFrontZ.z;
      }
      TrgSfx_AddCarExtraSfx((carObj->N).objID,1,&point,0xd,&(carObj->N).linearVel,(carObj->N).speedXZ,
                 *(volatile int *)&point.y,(carObj->render).light);
    }
  }

  /* ---- wheel 2 (back) ---- */
  roadSurfaceWheel = carObj->wheel[2].roadSurfaceType;
  surfaceType = Cars_kSkidMarkSurface[roadSurfaceWheel & 0xf];
  if (carObj->wheel[2].wheelInAir != 0) {
    surfaceType = 0;
  }
  if (((rear != 0 && wetRoad == 0) || (surfaceType >= 2 && speed != 0)) && visible != 0) {
    {
      coorddef wheelBackX;
      coorddef wheelBackZ;

      wheelBackX.x = (carObj->N).wheelBackX / 256 * (carObj->N).orientMat.m[0] / 256;
      wheelBackX.y = (carObj->N).wheelBackX / 256 * (carObj->N).orientMat.m[1] / 256;
      wheelBackX.z = (carObj->N).wheelBackX / 256 * (carObj->N).orientMat.m[2] / 256;
      wheelBackZ.x = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[6] / 256;
      wheelBackZ.y = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[7] / 256;
      wheelBackZ.z = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[8] / 256;
      point.x = position.x - wheelBackX.x;
      point.y = position.y - wheelBackX.y;
      point.z = position.z - wheelBackX.z;
      point.x -= wheelBackZ.x;
      point.y -= wheelBackZ.y;
      point.z -= wheelBackZ.z;
    }
    if (surfaceType >= 2 && rearLimit < rear) {
      surfaceType = 3;
    }
    if (surfaceType != 0) {
      Cars_AddCarSfx(carObj,2,&point,roadSurfaceWheel,surfaceType,1);
    }
    else {
      Cars_AddCarSfx(carObj,2,&point,roadSurfaceWheel,0,0);
    }
  }
  else if ((carObj->oldSkidState & 4) != 0) {
    TrgSfx_AddSkidmark((carObj->N).objID,2,carObj->oldSkidPoint + 2,1,carObj->rearSkid,carObj,0);
    carObj->oldSkidState = carObj->oldSkidState - 4;
  }
  if (wetRoad != 0) {
    if (surfaceType == 1 && speed != 0 && visible != 0) {
      {
        coorddef wheelBackX;
        coorddef wheelBackZ;

        wheelBackX.x = (carObj->N).wheelBackX / 256 * (carObj->N).orientMat.m[0] / 256;
        wheelBackX.y = (carObj->N).wheelBackX / 256 * (carObj->N).orientMat.m[1] / 256;
        wheelBackX.z = (carObj->N).wheelBackX / 256 * (carObj->N).orientMat.m[2] / 256;
        wheelBackZ.x = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[6] / 256;
        wheelBackZ.y = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[7] / 256;
        wheelBackZ.z = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[8] / 256;
        point.x = position.x - wheelBackX.x;
        point.y = position.y - wheelBackX.y;
        point.z = position.z - wheelBackX.z;
        point.x -= wheelBackZ.x;
        point.y -= wheelBackZ.y;
        point.z -= wheelBackZ.z;
      }
      TrgSfx_AddCarSplash((carObj->N).objID,2,&point,10,&(carObj->N).linearVel,0,(carObj->N).speedXZ);
      {
        int splashRear;

        splashRear = rear;
        if (splashRear <= 0) {
          splashRear = 1;
        }
        rear = splashRear;
      }
    }
  }
  if ((roadSurfaceWheel & 0x20) != 0 && gLeafPixmap != (Draw_tPixMap *)0x0 &&
      0xA0000 < (carObj->N).speedXZ && TrgSfx_AddCarExtraCheck((carObj->N).objID,2) != 0) {
    {
      int rndOffset;
      rndOffset = ((random() & 7) - 4) * 0x3333;
      {
        coorddef wheelBackX;
        coorddef wheelBackZ;

        wheelBackX.x = ((carObj->N).wheelBackX + rndOffset) / 256 * (carObj->N).orientMat.m[0] / 256;
        wheelBackX.y = ((carObj->N).wheelBackX + rndOffset) / 256 * (carObj->N).orientMat.m[1] / 256;
        wheelBackX.z = ((carObj->N).wheelBackX + rndOffset) / 256 * (carObj->N).orientMat.m[2] / 256;
        wheelBackZ.x = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[6] / 256;
        wheelBackZ.y = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[7] / 256;
        wheelBackZ.z = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[8] / 256;
        point.x = position.x - wheelBackX.x;
        point.y = position.y - wheelBackX.y;
        point.z = position.z - wheelBackX.z;
        point.x -= wheelBackZ.x;
        point.y -= wheelBackZ.y;
        point.z -= wheelBackZ.z;
      }
      TrgSfx_AddCarExtraSfx((carObj->N).objID,2,&point,0xd,&(carObj->N).linearVel,(carObj->N).speedXZ,
                 *(volatile int *)&point.y,(carObj->render).light);
    }
  }

  /* ---- wheel 3 (back) ---- */
  roadSurfaceWheel = carObj->wheel[3].roadSurfaceType;
  surfaceType = Cars_kSkidMarkSurface[roadSurfaceWheel & 0xf];
  if (carObj->wheel[3].wheelInAir != 0) {
    surfaceType = 0;
  }
  if (((rear != 0 && wetRoad == 0) || (surfaceType >= 2 && speed != 0)) && visible != 0) {
    {
      coorddef wheelBackX;
      coorddef wheelBackZ;

      wheelBackX.x = (carObj->N).wheelBackX / 256 * (carObj->N).orientMat.m[0] / 256;
      wheelBackX.y = (carObj->N).wheelBackX / 256 * (carObj->N).orientMat.m[1] / 256;
      wheelBackX.z = (carObj->N).wheelBackX / 256 * (carObj->N).orientMat.m[2] / 256;
      wheelBackZ.x = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[6] / 256;
      wheelBackZ.y = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[7] / 256;
      wheelBackZ.z = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[8] / 256;
      point.x = position.x + wheelBackX.x;
      point.y = position.y + wheelBackX.y;
      point.z = position.z + wheelBackX.z;
      point.x -= wheelBackZ.x;
      point.y -= wheelBackZ.y;
      point.z -= wheelBackZ.z;
    }
    if (surfaceType >= 2 && rearLimit < rear) {
      surfaceType = 3;
    }
    if (surfaceType != 0) {
      Cars_AddCarSfx(carObj,3,&point,roadSurfaceWheel,surfaceType,1);
    }
    else {
      Cars_AddCarSfx(carObj,3,&point,roadSurfaceWheel,0,0);
    }
  }
  else if ((carObj->oldSkidState & 8) != 0) {
    TrgSfx_AddSkidmark((carObj->N).objID,3,carObj->oldSkidPoint + 3,1,carObj->rearSkid,carObj,0);
    carObj->oldSkidState = carObj->oldSkidState - 8;
  }
  if (wetRoad != 0) {
    if (surfaceType == 1 && speed != 0 && visible != 0) {
      {
        coorddef wheelBackX;
        coorddef wheelBackZ;

        wheelBackX.x = (carObj->N).wheelBackX / 256 * (carObj->N).orientMat.m[0] / 256;
        wheelBackX.y = (carObj->N).wheelBackX / 256 * (carObj->N).orientMat.m[1] / 256;
        wheelBackX.z = (carObj->N).wheelBackX / 256 * (carObj->N).orientMat.m[2] / 256;
        wheelBackZ.x = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[6] / 256;
        wheelBackZ.y = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[7] / 256;
        wheelBackZ.z = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[8] / 256;
        point.x = position.x + wheelBackX.x;
        point.y = position.y + wheelBackX.y;
        point.z = position.z + wheelBackX.z;
        point.x -= wheelBackZ.x;
        point.y -= wheelBackZ.y;
        point.z -= wheelBackZ.z;
      }
      TrgSfx_AddCarSplash((carObj->N).objID,3,&point,10,&(carObj->N).linearVel,0,(carObj->N).speedXZ);
      {
        int splashRear;

        splashRear = rear;
        if (splashRear <= 0) {
          splashRear = 1;
        }
        rear = splashRear;
      }
    }
  }
  if ((roadSurfaceWheel & 0x20) != 0 && gLeafPixmap != (Draw_tPixMap *)0x0 &&
      0xA0000 < (carObj->N).speedXZ && TrgSfx_AddCarExtraCheck((carObj->N).objID,3) != 0) {
    {
      int rndOffset;
      rndOffset = ((random() & 7) - 4) * 0x3333;
      {
        coorddef wheelBackX;
        coorddef wheelBackZ;

        wheelBackX.x = ((carObj->N).wheelBackX + rndOffset) / 256 * (carObj->N).orientMat.m[0] / 256;
        wheelBackX.y = ((carObj->N).wheelBackX + rndOffset) / 256 * (carObj->N).orientMat.m[1] / 256;
        wheelBackX.z = ((carObj->N).wheelBackX + rndOffset) / 256 * (carObj->N).orientMat.m[2] / 256;
        wheelBackZ.x = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[6] / 256;
        wheelBackZ.y = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[7] / 256;
        wheelBackZ.z = (carObj->N).wheelBackZ / 256 * (carObj->N).orientMat.m[8] / 256;
        point.x = position.x + wheelBackX.x;
        point.y = position.y + wheelBackX.y;
        point.z = position.z + wheelBackX.z;
        point.x -= wheelBackZ.x;
        point.y -= wheelBackZ.y;
        point.z -= wheelBackZ.z;
      }
      TrgSfx_AddCarExtraSfx((carObj->N).objID,3,&point,0xd,&(carObj->N).linearVel,(carObj->N).speedXZ,
                 *(volatile int *)&point.y,(carObj->render).light);
    }
  }
  if (front != 0) {
    if (originalFront < 0) {
      originalFront = 0;
    }
    if (originalFront != 0 || (carObj->carFlags & 4) != 0) {
      Cars_SetAudioCalls(carObj,2,0x12,2,audioSurface,front,0);
      carObj->oldAudioSkidState = carObj->oldAudioSkidState | 1;
    }
  }
  else if ((carObj->oldAudioSkidState & 1) != 0) {
    Cars_SetAudioCalls(carObj,3,0x12,2,audioSurface,0,0);
    carObj->oldAudioSkidState = carObj->oldAudioSkidState - 1;
  }
  if (rear != 0) {
    if (originalRear < 0) {
      originalRear = 0;
    }
    if (originalRear != 0 || (carObj->carFlags & 4) != 0) {
      Cars_SetAudioCalls(carObj,4,0x14,2,audioSurface,rear / 2,0);
      carObj->oldAudioSkidState = carObj->oldAudioSkidState | 2;
    }
  }
  else if ((carObj->oldAudioSkidState & 2) != 0) {
    Cars_SetAudioCalls(carObj,5,0x14,2,audioSurface,0,0);
    carObj->oldAudioSkidState = carObj->oldAudioSkidState - 2;
  }
}

/* ---- Cars_FindTotalSlice__FP8Car_tObj  [@0x80089760] ---- */
void Cars_FindTotalSlice(Car_tObj *carObj)
{
  /* MATCH: the sole SYM local `lapSlices` is $v1 and caches gNumSlices before the
     reverseTrack branch.  Each arm multiplies lap by that cached value; the shared
     mflo/add/store merge is exactly the retail dependency graph. */
  int lapSlices;

  if (0 < carObj->unlap) {
    (carObj->N).totalSlice = 0;
    return;
  }
  lapSlices = gNumSlices;
  if (GameSetup_gData.reverseTrack != 0) {
    (carObj->N).totalSlice =
        (lapSlices - (u_short)(carObj->N).simRoadInfo.slice) - 1 +
        carObj->lap * lapSlices;
  }
  else {
    (carObj->N).totalSlice =
        (u_short)(carObj->N).simRoadInfo.slice + carObj->lap * lapSlices;
  }
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
    int speed = (carObj->N).speedXZ;
    if (((carObj->N).objAltitude < 0x3333) && (0x20000 < speed)) {
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
  /* MATCH: 34->16 via restoring the already-SYM-declared-but-dead `gvClamp`/`clampCond`
     locals to their real shape: the oracle computes `clampCond = MIN(roundedGV>>5, 1310)`
     FIRST (a real 2-branch min-clamp, `slti v0,v1,1311; ... li v1,1310;`), THEN tests
     `clampCond < -2620` -- NOT the single `-2621 < roundedGV>>5` test the prior recon had.
     Both are logically equivalent when roundedGV>>5 < -2620 (since -2620<1310 the MIN never
     fires there) but the oracle's ACTUAL codegen needs the min-clamp-first shape to byte-match
     (a<1311 && a<-2620 folds to a<-2620 logically, but NOT in codegen). Using
     `__builtin_abs(fixedmult(...))` for the roll term keeps the result in v0 like retail and
     reduces 16->5. Removing the named second quotient temporary and writing its upper clamp
     as a real if/else reproduces retail's direct-a0 signed `/32` expansion and schedules the
     `Yoffset = 0x51e` default into the comparison branch delay slot (5->PASS154). */
  int Yoffset;
  int iVar1;
  Car_tSpecs *pCVar2;
  BO_tNewtonObj *pBVar4;

  iVar1 = (carObj->N).collision.impulse;
  carObj->audioCount = 0;
  if (iVar1 != 0) {
    (carObj->N).collision.lastImpulse = iVar1;
    (carObj->N).collision.lastTime = simGlobal.gameTicks;
    pBVar4 = (carObj->N).collision.otherObj;
    if (pBVar4 != (BO_tNewtonObj *)0x0) {
      (carObj->N).collision.lastOtherObj = pBVar4;
    }
    else {
      (carObj->N).collision.lastOtherObj = (BO_tNewtonObj *)0x0;
    }
  }
  if ((carObj->N).simOptz != '\0') goto SHORT;
  if ((carObj->N).active != '\0') goto LONG;
SHORT:
  pCVar2 = carObj->specs;
  (carObj->render).bodyPitch = 0;
  (carObj->render).bodyRoll = 0;
  (carObj->render).currentHeight = -pCVar2->rideOffset;
  Cars_DoExtraCarCollisionProcessing(carObj);
  return;
LONG:
  {
    int negGroundVel, roundedGV, gvClamp, clampCond;
    int absRoll, currentRollVal, rideOffsetVal, negPitch, bodyPitchVal;

    AIPhysic_ProcessCollision(carObj);
    Cars_DoExtraCarCollisionProcessing(carObj);
    Car_DoSkiddingStuff(carObj);
    if (((carObj->carFlags & 4U) == 0) || ((carObj->N).flightTime != 0)) {
      (carObj->render).currentPitch =
           (carObj->render).currentPitch * 0xf + (carObj->linearAcc_ch).z >> 4;
      (carObj->render).currentRoll =
           (carObj->render).currentRoll * 0xf + (carObj->linearAcc_ch).x >> 4;
    }
    else {
      (carObj->render).currentPitch =
           (carObj->render).currentPitch * 7 + (carObj->linearAcc_ch).z >> 3;
      (carObj->render).currentRoll =
           (carObj->render).currentRoll * 7 + (carObj->linearAcc_ch).x >> 3;
    }
    negGroundVel = -(carObj->N).groundVel;
    roundedGV = negGroundVel;
    if (negGroundVel < 0) {
      roundedGV = negGroundVel + 0x1f;
    }
    gvClamp = roundedGV >> 5;
    clampCond = gvClamp;
    if (0x51e < gvClamp) {
      clampCond = 0x51e;
    }
    if (clampCond < -0xa3c) {
      Yoffset = -0xa3d;
    }
    else {
      if (negGroundVel / 0x20 < 0x51f) {
        Yoffset = negGroundVel / 0x20;
      }
      else {
        Yoffset = 0x51e;
      }
    }
    absRoll = __builtin_abs(fixedmult(((carObj->render).currentRoll * 3) / 2,
                                     carObj->specs->bodyRollFactor));
    currentRollVal = (carObj->render).currentRoll;
    rideOffsetVal = carObj->specs->rideOffset;
    (carObj->render).bodyRoll = currentRollVal;
    (carObj->render).currentHeight = (Yoffset - absRoll) - rideOffsetVal;
    (carObj->render).bodyRoll = fixedmult(currentRollVal,(carObj->render).rollFactor);
    negPitch = -(carObj->render).currentPitch;
    (carObj->render).bodyPitch = negPitch;
    bodyPitchVal = fixedmult(negPitch,(carObj->render).pitchFactor);
    (carObj->render).bodyPitch = bodyPitchVal;
    if ((carObj->carInfo->WeightTransfer == 1) || ((carObj->carFlags & 4U) == 0)) {
      (carObj->render).bodyPitch = bodyPitchVal / 2;
      (carObj->render).bodyRoll = (carObj->render).bodyRoll / 2;
    }
  }
  return;
}

/* ---- Cars_CalculateStartingGridOffset__FP8Car_tObjPiP8coorddef  [@0x80089b44] ---- */
void Cars_CalculateStartingGridOffset(Car_tObj *carObj,int *slice,coorddef *offset)
{
  int startingPosition;
  int carOnRight;
  int negDir;

  negDir = -1;
  if (GameSetup_gData.reverseTrack != 0) {
    negDir = 1;
  }
  startingPosition = GameSetup_gData.carInfo[carObj->carIndex].StartingPos;
  /* Retail keeps separate slice-normalization paths for the multi-car and
     two-car grids; spelling both paths out prevents an incorrect cross-jump. */
  if (3 <= Cars_gNumRaceCars) {
    if (-1 < negDir + ((negDir * 5) << 1) * startingPosition) {
      *slice = negDir + ((negDir * 5) << 1) * startingPosition < gNumSlices ?
                   negDir + ((negDir * 5) << 1) * startingPosition :
                   negDir + ((negDir * 5) << 1) * startingPosition - gNumSlices;
      goto LAB_80089c40;
    }
    *slice = negDir + ((negDir * 5) << 1) * startingPosition + gNumSlices;
    goto LAB_80089c40;
  }
  else {
    if (-1 < negDir) {
      *slice = negDir < gNumSlices ? negDir : negDir - gNumSlices;
      goto LAB_80089c40;
    }
  }
  *slice = negDir + gNumSlices;
LAB_80089c40:
  carOnRight = startingPosition & 1;
  if (carObj->desiredDirection * AITune_driveSide == -1) {
    carOnRight = 1 - carOnRight;
  }
  if (AITune_GetOneWay() != 0) {
    int center;
    int totalWidth;
    int laneWidth;
    totalWidth =
        ((u_int)BWorldSm_slices[*slice].avgPavedWidthLf << 15) *
            (BWorldSm_slices[*slice].laneCount >> 4) +
        ((u_int)BWorldSm_slices[*slice].avgPavedWidthRt << 15) *
            (BWorldSm_slices[*slice].laneCount & 0xf);
    center = totalWidth / 2 -
             ((u_int)BWorldSm_slices[*slice].avgPavedWidthLf << 15) *
                 (BWorldSm_slices[*slice].laneCount >> 4);
    laneWidth = totalWidth / ((BWorldSm_slices[*slice].laneCount >> 4) +
                              (BWorldSm_slices[*slice].laneCount & 0xf));
    if (carOnRight) {
      offset->x = center + laneWidth;
    }
    else {
      offset->x = center - laneWidth;
    }
  }
  else {
    if (carOnRight) {
      offset->x = (u_int)BWorldSm_slices[*slice].avgPavedWidthRt << 14;
    }
    else {
      offset->x =
          -((int)((u_int)BWorldSm_slices[*slice].avgPavedWidthLf << 15)) / 2;
    }
  }
  offset->y = 0x8000;
  offset->z = 0;
  return;
}

/* ---- Cars_IniCarObjects__FP8Car_tObji  [@0x80089d88] ---- */
void Cars_IniCarObjects(Car_tObj *carObj,int index)
{
  int k;
  int carType;
  int carMass;
  coorddef offset;
  int startSlice;

  Cars_InitStats(carObj);
  carObj->swapCar = (Car_tObj *)0x0;
  carObj->swapTime = 0;
  if (index < GameSetup_gData.numCars) {
    carType = carObj->carInfo->carType;
    if (carType == 0x21) goto MASS_HEAVY;
    if (carType == 0x24) goto MASS_HEAVY;
    if (carType == 0x26) goto MASS_HEAVY;
    if (carType == 0x27) goto MASS_HEAVY;
    if (carType == 0x2f) goto MASS_HEAVY;
    if (carType == 0x30) goto MASS_HEAVY;
    if (carType != 0x31) goto MASS_CHECK2;
MASS_HEAVY:
    carMass = 0x190000;
    goto MASS_DONE;
MASS_CHECK2:
    if (carType == 0x22) goto MASS_LIGHT;
    if (carType == 0x25) goto MASS_LIGHT;
    if (carType == 0x29) goto MASS_LIGHT;
    if (carType == 0x2b) goto MASS_LIGHT;
    if (carType != 0x2c) goto MASS_CALC;
MASS_LIGHT:
    carMass = 0x110000;
    goto MASS_DONE;
MASS_CALC:
    carMass = carObj->specs->mass / 0x80;
MASS_DONE:
    Newton_InitBaseNewtonObj((u_int *)&carObj->N,index | 0x100,carMass,carMass,(carObj->N).dimension.x,(carObj->N).dimension.y,
               (carObj->N).dimension.z);
  }
  Cars_CalculateStartingGridOffset(carObj,&startSlice,&offset);
  if (gNumSlices / 2 < startSlice) {
    (carObj->stats).extractSlice = gNumSlices - startSlice;
  }
  else {
    (carObj->stats).extractSlice = startSlice;
  }
  if (GameSetup_gData.reverseTrack) {
    Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,startSlice,&offset,-1);
  }
  else {
    Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,startSlice,&offset,1);
  }
  carObj->unlap = 1;
  carObj->lap = 0;
  if (GameSetup_gData.reverseTrack) {
    (carObj->N).oldSlice = ((short)gNumSlices - (carObj->N).simRoadInfo.slice) - 1;
  }
  else {
    (carObj->N).oldSlice = (carObj->N).simRoadInfo.slice;
  }
  Cars_FindTotalSlice(carObj);
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
  for (k = 0; k < 4; k++) {
    carObj->wheel[k].actualHeight = 0;
    carObj->wheel[k].currentPos.x = 0;
    carObj->wheel[k].currentPos.y = 0;
    carObj->wheel[k].currentPos.z = 0;
    carObj->wheel[k].roadNormal.x = 0;
    carObj->wheel[k].roadNormal.y = 0x10000;
    carObj->wheel[k].roadNormal.z = 0;
    carObj->wheel[k].wheelAcc = 0;
    carObj->wheel[k].wheelInAir = 0;
    carObj->wheel[k].rebound = 0;
    carObj->wheel[k].impactCompression = 0;
    carObj->wheel[k].roadSurfaceType = 1;
  }
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
  if (GameSetup_gData.Time) {
    (carObj->control).lights = '\x03';
  }
  else {
    (carObj->control).lights = '\0';
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
  if (carObj->carInfo->carType < 0x1d) {
    (carObj->render).pitchFactor =
        fixeddiv(carObj->specs->bodyPitchFactor,carObj->specs->suspensionStiffness * 3);
    (carObj->render).rollFactor =
        fixeddiv(carObj->specs->bodyRollFactor,carObj->specs->suspensionStiffness << 1);
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
  /* MATCH: 19->16 via a real correctness bug: locatebig() genuinely takes only 2 args
     (locatbig.cpp:178 `char *locatebig(void*,char*)`; oracle 0x8008A2AC sets up ONLY a0/a1
     before the jal, no a2) -- dropped the bogus 3rd "0" arg (was a stale/wrong "$a2 dropped
     by Ghidra" comment; the SAME bug exists in anim.cpp:81's locatebig call, out of scope
     here). The ex-"genuine allocator floor" (12 diffs, file1/handle swapped between
     $s3/$s4) is SOLVED (W54-A13) and was never a floor -- it is a pure allocno-PRIORITY
     tie, readable straight off allocsim/reqdelta:
        p87(file1) refs=4 live=141 -> pri 0.0567   (got $s4)
        p88(handle) refs=4 live=129 -> pri 0.0620 (got $s3)
     file1 spans handle's whole range, so NO live-length dial can flip it (reqdelta's
     other two candidates both need a 12-insn swing that the fixed call order forbids).
     The only 1-step dial is refs 4->5 on file1: a zero-insn READ-ONLY fence (05C) below.
     floor_log2(5)*5/141 = 0.0709 > 0.0620 -> file1 takes $s3, handle $s4 = retail.
     With the regs corrected the two `= 0` prologue inits then had to swap back to
     source order file1-then-handle (the emission order of the `addu sN,s2,zero`
     copies IS the source statement order).  196/196 PASS.
     Falsified: identity fence `"+r"(file1)` (22 diffs -- it also moves the def). */
  int iVar1;
  char *mem;
  Car_tSpecs *pCVar2;
  Udff_tInfo *handle;
  Udff_tInfo *handle2;
  char *file2;
  char *file1;
  char carFile[100];
  char specsFile[100];
  char name[20];

  file2 = (char *)0x0;
  file1 = (char *)0x0;
  handle = (Udff_tInfo *)0x0;
  handle2 = (Udff_tInfo *)0x0;
  if (index < GameSetup_gData.numCars) {
    iVar1 = AIInit_IsNonStandardCarFile(carObj->carInfo->carType);
    if (iVar1 != 0) {
      sprintf(carFile,"%s%s.qda",Paths_Paths[4],(char *)carObj + 0x240);
    }
    else {
      sprintf(carFile,"%sSTDR.qda",Paths_Paths[4]);
    }
    file1 = (char *)loadpackadr(carFile,(void *)0x10);
    /* MATCH: zero-insn read-only fence = +1 REF on file1 (allocno-priority dial, see the
       header note) -> file1 wins $s3 over handle.  Do NOT delete: it emits no code. */
    __asm__("" : : "r"(file1));
    handle = Udff_Opena((char *)0x0,file1,1);
    if (carObj->carInfo->carType < 0x1d) {
      sprintf(name,"p%s.dat",GameSetup_gCarNames[0] + carObj->carInfo->carType * 5);
    }
    else {
      sprintf(name,"ptram.dat");
    }
    sprintf(specsFile,"%sdusty.viv",Paths_Paths[3]);
    file2 = (char *)loadfileadrz(specsFile,(void *)0x10);
    /* BUG FIX: locatebig is the REAL 2-arg fn (locatbig.cpp:178, char *locatebig(void*,char*));
       oracle 0x8008A2AC `jal locatebig` sets up ONLY a0/a1 (no a2) -- the old 3rd "0" arg + its
       "$a2 dropped by Ghidra" comment was wrong (Ghidra didn't drop anything; there IS no 3rd
       arg). Confirmed by other correctly-2-arg call sites (r3dcar.cpp locatebig(bigfile,name)). */
    mem = (char *)locatebig(file2,name);
    handle2 = Udff_Opena((char *)0x0,mem,0);
    if (index < GameSetup_gData.numCars) {
      AIInit_InitAICar(carObj,handle);
      AIInit_RestartAICar(carObj);
      pCVar2 = reservememadr("carSpecs",0x1d0,0);
      carObj->specs = pCVar2;
      Physics_InitCarSpecs(carObj,handle2);
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
    Udff_Close(handle);
    Udff_Close(handle2);
    purgememadr(file2);
    purgememadr(file1);
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
  /* SLD exposes only i=$s0. The first loop's three pointers and final loop's
     object address are retail strength-reduction temporaries, so keep their
     source as direct array indexing instead of named pointer locals. */
  int i;
  int numCars;
  Car_tObj *pCVar2;
  Car_tObj **ppCVar6;

  numCars = Cars_gNumCars;
  i = 0;
  if (0 < numCars) {
    do {
      Cars_gSortedList[i] = Cars_gList[i];
      Cars_gTotalSortedList[i] = Cars_gList[i];
      i = i + 1;
    } while (i < numCars);
  }
  i = 0;
  ppCVar6 = Cars_gList;
LAB_ini:
  if (i < Cars_gNumCars) {
    pCVar2 = *ppCVar6;
    ppCVar6 = ppCVar6 + 1;
    Cars_IniCarObjects(pCVar2,i);
    i = i + 1;
    goto LAB_ini;
  }
  i = 0;
  while( true ) {
    if (Object_GetNumIMassObjects() <= i) break;
    Object_IMassObjInst[i].lastPos.x = 0;
    Object_IMassObjInst[i].lastPos.y = 0;
    Object_IMassObjInst[i].lastPos.z = 0;
    Object_IMassObjInst[i].lastTick = 0;
    i = i + 1;
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
  Car_tObj *newCar;

  Cars_ResetCarCounters();

  for (i = 0; i < GameSetup_gData.numCars; i++) {
    newCar = (Car_tObj *)reservememadr("Car_tObj",0x8dc,0);
    Cars_Initialize((char *)newCar,0x8dc);
    if (i < GameSetup_gData.numCars) {
      newCar->carInfo = &GameSetup_gData.carInfo[i];
    }
    Cars_InitializeCarTablesFlagsAndCounters(newCar);
  }

  for (i = 0; i < Object_GetNumIMassObjects(); i++) {
    coorddef dim;

    Object_GetIMassObjectDimensions(i,&dim);
    Newton_InitBaseNewtonObj(
        (u_int *)&InfiniteMassNewton[i],0x201,0x280000,0x1400000,
        dim.x,dim.y,dim.z + 0x10000);
  }

  for (i = 0; i < GameSetup_gData.numCars; i++) {
    Car_tObj *carObj = Cars_gList[i];
    Cars_InitCar(carObj,i);
    Sched_AddFunction(
        simGlobal.schedule32Hz,carObj->funcUpdateRoadInfo,carObj,6);
  }

  if (R3DCar_LicenseShapeFile != (char *)0x0) {
    purgememadr(R3DCar_LicenseShapeFile);
  }
  R3DCar_LicenseShapeFile = (char *)0x0;

  for (i = 0; i < GameSetup_gData.numCars; i++) {
    Car_tObj *carObj = Cars_gList[i];
    Sched_AddFunction(
        simGlobal.schedule32Hz,carObj->funcControl,carObj,0x15);
  }

  for (i = 0; i < GameSetup_gData.numCars; i++) {
    Car_tObj *carObj = Cars_gList[i];
    Sched_AddFunction(
        simGlobal.schedule32Hz,carObj->funcHandlingPhysics,carObj,0x1e);
  }

  for (i = 0; i < GameSetup_gData.numCars; i++) {
    Car_tObj *carObj = Cars_gList[i];
    Sched_AddFunction(
        simGlobal.schedule32Hz,carObj->funcGravityPhysics,carObj,0x1e);
  }

  for (i = 0; i < GameSetup_gData.numCars; i++) {
    Car_tObj *carObj = Cars_gList[i];
    Sched_AddFunction(
        simGlobal.schedule32Hz,carObj->funcTestMeForCollisions,carObj,0x28);
  }

  for (i = 0; i < GameSetup_gData.numCars; i++) {
    Car_tObj *carObj = Cars_gList[i];
    Sched_AddFunction(
        simGlobal.schedule32Hz,carObj->funcDoPostCollisionStuff,carObj,0x32);
  }

  Force_StartUp();

  for (i = 0; i < GameSetup_gData.numCars; i++) {
    Car_tObj *carObj = Cars_gList[i];
    if ((carObj->carFlags & 1U) != 0) {
      Sched_AddFunction(
          simGlobal.schedule64Hz,carObj->funcStats,carObj,0x19);
    }
  }

  for (i = 0; i < GameSetup_gData.numCars; i++) {
    Car_tObj *carObj = Cars_gList[i];
    Sched_AddFunction(
        simGlobal.schedule64Hz,carObj->funcQDPhysicsUpdateVel,carObj,0x1e);
  }

  for (i = 0; i < GameSetup_gData.numCars; i++) {
    Car_tObj *carObj = Cars_gList[i];
    Sched_AddFunction(
        ((carObj->carFlags & 4U) != 0)
            ? simGlobal.schedule64Hz
            : simGlobal.schedule32Hz2,
        carObj->funcQDPhysicsUpdateRot,carObj,0x1e);
    /* MATCH (W54-A13, 05C/05H fence class): the ONLY residual was reorg's eager-steal --
       with the call and the loop latch in ONE basic block (the schedule select is a
       ternary, so both arms reach the call) sched1 hoists the giv bump `s0+=4` ABOVE the
       jal, which leaves `li a3,0x1e` out of the jal's delay slot and hands the slot to
       `i++` instead (=> an unfilled `j` slot, ours 283 vs oracle 282).  The sibling
       `carFlags & 1` loop matches for free because its call sits in a CONDITIONAL block,
       so the latch is a separate BB and reorg cannot steal from it.  A zero-insn
       operand-less asm barrier here restores exactly that boundary: jal slot = li a3,30,
       j slot = i++.  282/282 PASS.  Falsified first: if/else-with-named-`sched` variable
       (11 diffs, unchanged), arg-per-line spelling. */
    __asm__("");
  }
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
    /* MATCH (W54-A13): the ex-"preheader-order floor" is SOLVED -- it was the INDEX-vs-POINTER
       shape.  Oracle materializes &simGlobal (LICM invariant) BEFORE the Cars_gList base;
       loop.c emits LICM invariants first and strength-reduction GIV inits after, so a source
       `p = Cars_gList;` statement (a real preheader insn) can never come second.  Writing the
       body as `Cars_gList[i]` makes the walk a GIV -> exact preheader order.  The counter
       increment must sit at the LOOP END (moving it earlier costs 2 diffs).  98/98 PASS. */
    do {
      Sched_DeleteFunction(simGlobal.schedule32Hz,Cars_gList[iVar4]->funcUpdateRoadInfo,Cars_gList[iVar4]);
      Sched_DeleteFunction(simGlobal.schedule32Hz,Cars_gList[iVar4]->funcControl,Cars_gList[iVar4]);
      pCVar2 = Cars_gList[iVar4];
      if ((pCVar2->carFlags & 1U) != 0) {
        Sched_DeleteFunction(simGlobal.schedule64Hz,pCVar2->funcStats,pCVar2);
        pCVar2 = Cars_gList[iVar4];
      }
      Sched_DeleteFunction(simGlobal.schedule32Hz,pCVar2->funcHandlingPhysics,pCVar2);
      Sched_DeleteFunction(simGlobal.schedule32Hz,Cars_gList[iVar4]->funcGravityPhysics,Cars_gList[iVar4]);
      Sched_DeleteFunction(simGlobal.schedule64Hz,Cars_gList[iVar4]->funcQDPhysicsUpdateVel,Cars_gList[iVar4]);
      Sched_DeleteFunction(simGlobal.schedule32Hz,Cars_gList[iVar4]->funcTestMeForCollisions,Cars_gList[iVar4]);
      Sched_DeleteFunction(simGlobal.schedule32Hz,Cars_gList[iVar4]->funcDoPostCollisionStuff,Cars_gList[iVar4]);
      iVar1 = Force_IsForceOn(Cars_gList[iVar4]);
      if (iVar1 != 0) {
        Sched_DeleteFunction(simGlobal.schedule32Hz,Force_Update,Cars_gList[iVar4]);
      }
      pCVar2 = Cars_gList[iVar4];
      if ((pCVar2->carFlags & 4U) != 0) {
        schedule32Hz = simGlobal.schedule64Hz;
      }
      else {
        schedule32Hz = simGlobal.schedule32Hz2;
      }
      Sched_DeleteFunction(schedule32Hz,pCVar2->funcQDPhysicsUpdateRot,pCVar2);
      Cars_DeInitCar(Cars_gList[iVar4]);
      purgememadr(Cars_gList[iVar4]);
      iVar4 = iVar4 + 1;
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
  int absSpan;

  span = ((carObj->N).roadMatrix.m[0] / 256) *
             ((carObj->N).orientMat.m[0] / 256) +
         ((carObj->N).roadMatrix.m[1] / 256) *
             ((carObj->N).orientMat.m[1] / 256) +
         ((carObj->N).roadMatrix.m[2] / 256) *
             ((carObj->N).orientMat.m[2] / 256);
  /* MATCH (W54-A13): TWO cooperating devices, both zero-insn.
     (1) the abs result needs its OWN variable.  `span = __builtin_abs(span)` makes gcc
         negate IN PLACE (`bgez a1; nop; negu a1,a1`) and then spend a fresh reg + the
         guard's delay slot on the /256 copy; retail is the other way round -- abs into a
         fresh reg (`bgez a1; addu v0,a1,zero; negu v0,v0`) and the /256 IN PLACE on it
         (`bgez v0; nop; addiu v0,v0,255; sra a1,v0,8`).  Splitting the destination
         reproduces the oracle exactly.  Keep the THREE statements: folding them into one
         expression (any association) costs 62-90 diffs.
     (2) the fresh pseudo then re-colors `span` a2<-a1 (uniform a1<->a2 swap, count exact).
         allocsim/reqdelta: span = p81 refs=8 live=76 pri .3157 loses a1 to p139
         (refs=2 live=6 pri .3333); the minimal single dial is span refs 8->9, i.e. one
         zero-insn read-only fence -> floor_log2(9)*9/76 = .355 wins a1.  Fence POSITION is
         load-bearing (after the *dim.x = PASS; after the /256 = +1 insn/13 diffs; after the
         dim.y term = +2 insns/6 diffs).  146/146 PASS. */
  absSpan = __builtin_abs(span);
  span = absSpan / 256;
  span *= (carObj->N).dimension.x / 256;
  __asm__("" : : "r"(span));
  tempSpan = ((carObj->N).roadMatrix.m[0] / 256) *
                 ((carObj->N).orientMat.m[3] / 256) +
             ((carObj->N).roadMatrix.m[1] / 256) *
                 ((carObj->N).orientMat.m[4] / 256) +
             ((carObj->N).roadMatrix.m[2] / 256) *
                 ((carObj->N).orientMat.m[5] / 256);
  span += (__builtin_abs(tempSpan) / 256) *
          ((carObj->N).dimension.y / 256);
  tempSpan = ((carObj->N).roadMatrix.m[0] / 256) *
                 ((carObj->N).orientMat.m[6] / 256) +
             ((carObj->N).roadMatrix.m[1] / 256) *
                 ((carObj->N).orientMat.m[7] / 256) +
             ((carObj->N).roadMatrix.m[2] / 256) *
                 ((carObj->N).orientMat.m[8] / 256);
  return span + (__builtin_abs(tempSpan) / 256) *
                ((carObj->N).dimension.z / 256);
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
  /* MATCH: SYM exposes one real local, `temp` in $a1. Keeping the dot product
     as three direct /256 terms lets the compiler interleave each velocity/matrix
     pair and fill the signed-division branch delay slots exactly like retail. */
  int temp;

  temp = ((carObj->N).linearVel.x / 256) * ((carObj->N).roadMatrix.m[6] / 256);
  temp += ((carObj->N).linearVel.y / 256) * ((carObj->N).roadMatrix.m[7] / 256);
  temp += ((carObj->N).linearVel.z / 256) * ((carObj->N).roadMatrix.m[8] / 256);
  return temp;
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

/* ---- Cars_ManageBureaucracy__Fv  [@0x8008affc] ---- RECONSTRUCTED 2026-06-13 (Ghidra @NFS4.EXE.c:65747).
 *  Skipped from the cars.obj pass. Per active car: recompute road span/position + lane info,
 *  (cool physics) velocity-down-road, (carFlags&4) direction sign from orientMat.row . slice
 *  forward vector, (sliceChanged) lap/total-slice; then sort, randomize, leaderboard, anims. */
void Cars_ManageBureaucracy(void)
{
  int carLoop;

  for (carLoop = 0; carLoop < Cars_gNumCars; carLoop++) {
    Car_tObj *carObj = Cars_gList[carLoop];
    if (carObj->N.active != '\0') {
      carObj->roadSpan = Cars_CalculateRoadSpan(carObj);
      carObj->roadPosition = Cars_CalculateRoadPosition(carObj);
      AIWorld_CalculateLaneInfo(carObj);
      if (AIPhysics_UseCoolPhysics(carObj) != 0) {
        carObj->currentSpeed = Cars_CalcVelDownRoad(carObj);
      }
      if ((carObj->carFlags & 4U) != 0) {
        int facing;

        carObj->speed = carObj->N.speedXZ;
        if ((unsigned)(carObj->currentSpeed + 0x2ffff) < 0x5ffff) {
          facing =
              fixedmult(carObj->N.orientMat.m[6], (int)(signed char)BWorldSm_slices[carObj->N.simRoadInfo.slice].forward[0]) +
              fixedmult(carObj->N.orientMat.m[7], (int)(signed char)BWorldSm_slices[carObj->N.simRoadInfo.slice].forward[1]) +
              fixedmult(carObj->N.orientMat.m[8], (int)(signed char)BWorldSm_slices[carObj->N.simRoadInfo.slice].forward[2]);
          carObj->direction = (0 < facing) ? 1 : -1;
        } else {
          carObj->direction = (-1 < carObj->currentSpeed) ? 1 : -1;
        }
      }
      if ((signed char)carObj->N.simRoadInfo.sliceChanged != '\0') {
        Cars_FindCurrentLap(carObj);
        Cars_FindTotalSlice(carObj);
      }
    }
  }
  Cars_SortCars();
  Cars_Randomize();
  AISpeeds_MaintainLeaderBoard();
  DrawW_DoObjectAnimations();
}

/* ---- Cars_CheckForAccidentScenes__Fv  [@0x8008b1c4] ---- */
void Cars_CheckForAccidentScenes(void)
{
  if (((GameSetup_gData.commMode != 1) && (GameSetup_gData.raceType != RaceType_HotPursuit)) &&
     (GameSetup_gData.raceType != RaceType_Id5)) {
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


/* ---- Cars_SortCars__Fv  [@0x8008b1f8] ---- RECONSTRUCTED 2026-06-13 (Ghidra @NFS4.EXE.c:65838).
 *  Skipped from the cars.obj pass. Two bubble-sorts: Cars_gSortedList ascending by
 *  N.simRoadInfo.slice (then assigns sortIndex), and Cars_gTotalSortedList ascending by
 *  N.totalSlice with swapCar/swapTime bookkeeping. Ghidra byte-offset ptr-arith de-garbled. */
void Cars_SortCars(void)
{
  int swapped;
  int i;
  Car_tObj *temp;

  do {
    swapped = 0;
    for (i = 0; i < Cars_gNumCars - 1; i++) {
      if (Cars_gSortedList[i]->N.simRoadInfo.slice >
          Cars_gSortedList[i + 1]->N.simRoadInfo.slice) {
        temp = Cars_gSortedList[i];
        Cars_gSortedList[i] = Cars_gSortedList[i + 1];
        Cars_gSortedList[i + 1] = temp;
        swapped = 1;
      }
    }
  } while (swapped != 0);

  for (i = 0; i < Cars_gNumCars; i++) {
    Cars_gSortedList[i]->sortIndex = i;
  }

  do {
    swapped = 0;
    for (i = 0; i < Cars_gNumCars - 1; i++) {
      if (Cars_gTotalSortedList[i]->N.totalSlice >
          Cars_gTotalSortedList[i + 1]->N.totalSlice) {
        Cars_gTotalSortedList[i]->swapCar = Cars_gTotalSortedList[i + 1];
        Cars_gTotalSortedList[i + 1]->swapCar = Cars_gTotalSortedList[i];
        Cars_gTotalSortedList[i]->swapTime =
            Cars_gTotalSortedList[i + 1]->swapTime = simGlobal.gameTicks;
        temp = Cars_gTotalSortedList[i];
        Cars_gTotalSortedList[i] = Cars_gTotalSortedList[i + 1];
        Cars_gTotalSortedList[i + 1] = temp;
        swapped = 1;
      }
    }
  } while (swapped != 0);
}

