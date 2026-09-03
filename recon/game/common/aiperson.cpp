/* game/common/aiperson.cpp -- RECONSTRUCTED (NFS4 AI personality/script/glue loader; 8 free AIPerson_* fns).
 *   Per-car personality assignment + .bin table loaders. SYM-faithful, recompilable C++.
 *   NOT original source. SYM-owned globals are defined in this TU.
 */
#include "aiperson_types.h"
#include "aiperson_externs.h"

/* ---- aiperson.obj-owned globals ----
 * SYM records these 20 definitions in aiperson.obj.  Their order and bytes
 * reproduce the retail 0x8010D5CC..0x8010DC54 data run; the final three
 * tables are runtime-filled but CC1PLPSX emits tentative aggregates as
 * zero-filled .data in this configuration. */
int          AIPerson_blockMaxDistance[4]        = { 2293760, 3276800, 5242880, 7864320 };
int          AIPerson_blockMinDistance[4]        = { 2293760, 1310720, 655360, 0 };
int          AIPerson_oncomingLookAhead[4]       = { 5898240, 10485760, 13762560, 16384000 };
int          AIPerson_laneSwerve[4][4]           = { {0,0,0,0}, {-65536,-32768,0,65536}, {-131072,0,65536,131072}, {-196608,-98304,98304,196608} };
int          AIPerson_swerveChangeProb[4]        = { 400, 100, 40, 10 };
int          AIPerson_brakeMultiplier[4]         = { 55705, 65536, 78643, 88473 };
int          AIPerson_attackActivationHits[4]    = { 10000, 15, 40, 40 };
int          AIPerson_attackTimes[4]             = { 0, 96, 320, 1280 };
int          AIPerson_fishtailAngles[4]          = { 35, 40, 45, 50 };
int          AIPerson_gripLossProbPerSecond[4]   = { 32768, 32768, 32768, 0 };
int          AIPerson_gripLossMinFactor[4]       = { 19660, 26214, 32768, 64880 };
int          AIPerson_gripLossRecoveryPerTick[4] = { 71, 61, 40, 65536 };
int          AIPerson_minimumWipeOutTicks[5]     = { 65536, 4096, 2048, 1024, 1024 };
int          AIPerson_randomWipeOutTicks[5]      = { 65535, 8191, 4095, 2047, 2047 };
u_int        AIPerson_rearEndProbMask[4]         = { 65535u, 768u, 1792u, 512u };
u_int        AIPerson_smackProbMask[4]           = { 65535u, 768u, 1792u, 1536u };
int          AIPerson_bestLineAbilities[4]       = { 19660, 32768, 52428, 65536 };
int          AIPerson_glueTable[21];                       /* @0x8010D714 */
AIPerson_t   AIPerson_PersonalityData[9];                  /* @0x8010D768 */
AIScript_tReactionDetails AIPerson_ScriptData[9][7];       /* @0x8010DA5C */


/* ---- intra-TU forward declarations ---- */
void AIPerson_LoadGridAndSetPersonalityIndexes(void);
void AIPerson_SetPersonality(Car_tObj *carObj,int personalityIndex);
void AIPerson_SetPersonalityPointers(void);
void AIPerson_LoadPersonalityData(Udff_tInfo *handle);
void AIPerson_LoadScriptData(Udff_tInfo *handle);
void AIPerson_LoadGlue(Udff_tInfo *handle);
void AIPerson_Startup(void);
void AIPerson_Cleanup(void);


/* ---- AIPerson_LoadGridAndSetPersonalityIndexes__Fv  [@0x800689e8] — PIN-FREE 100% ----
 * SYM is authoritative here: FCN VOID and the sole named local is `int carLoop`.
 * The direct indexed `for` loop is also the split-m2c data-flow shape.  GCC strength-
 * reduces the two indexed arrays to the retail $a1/$a2 cursors and schedules the $a0
 * counter initialization into the entry `blez` delay slot.  The former pointer-carrier
 * reconstruction needed a false `int` return type to obtain that schedule. */
void AIPerson_LoadGridAndSetPersonalityIndexes(void)
{
  int carLoop;

  for (carLoop = 0; carLoop < Cars_gNumCars; carLoop++) {
    Cars_gList[carLoop]->personalityIndex =
        AIPERSON_PERSONALITY_AT(carLoop);
  }
  return;
}

/* ---- AIPerson_SetPersonality__FP8Car_tObji  [@0x80068a34] ---- */
void AIPerson_SetPersonality(Car_tObj *carObj,int personalityIndex)
{
  if ((carObj->carFlags & 4U) == 0) {
    strcpy(carObj->carInfo->driver,GameSetup_gPersonalityNames[0] + personalityIndex * 8);
  }
  personalityIndex = personalityIndex % 5;
  carObj->personalityIndex = personalityIndex;
  carObj->personality = AIPerson_PersonalityData + personalityIndex;
  AIScript_Assign(&carObj->script,AIPerson_ScriptData + personalityIndex);
  return;
}

/* ---- AIPerson_SetPersonalityPointers__Fv  [@0x80068afc] ---- */
void AIPerson_SetPersonalityPointers(void)
{
  int carLoop;

  for (carLoop = 0; carLoop < Cars_gNumCars; carLoop++) {
    Car_tObj *carObj;

    carObj = Cars_gList[carLoop];
    AIPerson_SetPersonality(carObj,carObj->personalityIndex);
  }
  return;
}

/* ---- AIPerson_LoadPersonalityData__FP10Udff_tInfo  [@0x80068b60] ---- */
void AIPerson_LoadPersonalityData(Udff_tInfo *handle)
{
  int perLoop;
  int blockingDistance;
  int cutOffDistance;
  int lookAhead;
  int swervyness;
  int braking;
  int roadRage;
  int fishtailControl;
  int wipeOutFreq;
  int corneringAbility;
  int bestLineAbility;
  int rearEndingTendency;
  int aggression;
  /* SYM-CODEGEN-CARRIER: copCollisionFirmness -- no retail debug name survives for this final read,
   * but keeping it distinct reproduces the 80-byte frame and saved-register
   * allocation; assigning Udff_GetInt directly removes three instructions. */
  int copCollisionFirmness;
  Udff_GetInt(handle);

  perLoop = 0;
  while (1) {
    if (perLoop >= 9) {
      break;
    }
    blockingDistance = Udff_GetInt(handle);
    cutOffDistance = Udff_GetInt(handle);
    lookAhead = Udff_GetInt(handle);
    swervyness = Udff_GetInt(handle);
    braking = Udff_GetInt(handle);
    roadRage = Udff_GetInt(handle);
    fishtailControl = Udff_GetInt(handle);
    Udff_GetInt(handle);
    wipeOutFreq = Udff_GetInt(handle);
    corneringAbility = Udff_GetInt(handle);
    bestLineAbility = Udff_GetInt(handle);
    rearEndingTendency = Udff_GetInt(handle);
    aggression = Udff_GetInt(handle);
    copCollisionFirmness = Udff_GetInt(handle);
    AIPerson_PersonalityData[perLoop].blockMaxDistance = AIPerson_blockMaxDistance[blockingDistance];
    AIPerson_PersonalityData[perLoop].blockMinDistance = AIPerson_blockMinDistance[cutOffDistance];
    AIPerson_PersonalityData[perLoop].oncomingLookAhead = AIPerson_oncomingLookAhead[lookAhead];
    AIPerson_PersonalityData[perLoop].laneSwerve[0] = AIPerson_laneSwerve[swervyness][0];
    AIPerson_PersonalityData[perLoop].laneSwerve[1] = AIPerson_laneSwerve[swervyness][1];
    AIPerson_PersonalityData[perLoop].laneSwerve[2] = AIPerson_laneSwerve[swervyness][2];
    AIPerson_PersonalityData[perLoop].laneSwerve[3] = AIPerson_laneSwerve[swervyness][3];
    AIPerson_PersonalityData[perLoop].swerveChangeProb = AIPerson_swerveChangeProb[swervyness];
    AIPerson_PersonalityData[perLoop].brakeMultiplier = AIPerson_brakeMultiplier[braking];
    AIPerson_PersonalityData[perLoop].attackActivationHits = AIPerson_attackActivationHits[roadRage];
    AIPerson_PersonalityData[perLoop].attackTime = AIPerson_attackTimes[roadRage];
    AIPerson_PersonalityData[perLoop].fishtailAngle = AIPerson_fishtailAngles[fishtailControl];
    AIPerson_PersonalityData[perLoop].minimumBetweenWipeoutTicks = AIPerson_minimumWipeOutTicks[wipeOutFreq + AIPERSON_WEATHER];
    AIPerson_PersonalityData[perLoop].randomBetweenWipeoutTicks = AIPerson_randomWipeOutTicks[wipeOutFreq + AIPERSON_WEATHER];
    AIPerson_PersonalityData[perLoop].gripLossProbPerSecond = AIPerson_gripLossProbPerSecond[corneringAbility];
    AIPerson_PersonalityData[perLoop].gripLossMinFactor = AIPerson_gripLossMinFactor[corneringAbility];
    AIPerson_PersonalityData[perLoop].gripLossRecoveryPerTick = AIPerson_gripLossRecoveryPerTick[corneringAbility];
    AIPerson_PersonalityData[perLoop].bestLineAbility = AIPerson_bestLineAbilities[bestLineAbility];
    AIPerson_PersonalityData[perLoop].rearBumpProbMask = AIPerson_rearEndProbMask[rearEndingTendency];
    AIPerson_PersonalityData[perLoop].smackProbMask = AIPerson_smackProbMask[aggression];
    AIPerson_PersonalityData[perLoop].copCollisionFirmness = copCollisionFirmness;
    perLoop++;
  }
  return;
}

/* ---- AIPerson_LoadScriptData__FP10Udff_tInfo  [@0x80068ea4] ---- */
void AIPerson_LoadScriptData(Udff_tInfo *handle)
{
  int perLoop;
  int actionLoop;
  int reactionLoop;
  /* SYM-CODEGEN-CARRIER: byteOffset -- deriving perLoop * 0x38 directly keeps
     55 instructions but changes induction/allocation at 12 positions. */
  int byteOffset;
  /* SYM-CODEGEN-CARRIER: actionMul -- spelling actionLoop * 8 directly keeps
     55 instructions but swaps the two address terms at eight positions. */
  int actionMul;
  /* SYM-CODEGEN-CARRIER: byteOff2 -- using byteOffset directly removes three
     instructions and changes frame/register allocation to 31 diffs. */
  int byteOff2;
  /* SYM-CODEGEN-CARRIER: scriptBase -- spelling AIPerson_ScriptData directly
     adds three instructions and changes address formation to 13 diffs. */
  int scriptBase;

  Udff_GetInt(handle);
  perLoop = 0;
  scriptBase = (int)AIPerson_ScriptData;
  byteOffset = 0;
 loop_1:
  actionLoop = 0;
  if (perLoop < 9) {
    do {                              /* permuter-found while(0) scope: pin-free 100% */
     loop_2:
      reactionLoop = 0;
      if (actionLoop < 7) {
        actionMul = actionLoop * 8;
        byteOff2 = byteOffset;
        do {
          *(char *)(reactionLoop + actionMul + byteOff2 + scriptBase) =
              (char)Udff_GetInt(handle);
          *(char *)(reactionLoop + actionMul + byteOff2 + scriptBase + 4) =
              (char)Udff_GetInt(handle);
          reactionLoop = reactionLoop + 1;
        } while (reactionLoop < 4);
        actionLoop = actionLoop + 1;
        goto loop_2;
      }
      byteOffset = byteOffset + 0x38;
    } while (0);
    perLoop = perLoop + 1;
    goto loop_1;
  }
  return;
}

/* ---- AIPerson_LoadGlue__FP10Udff_tInfo  [@0x80068f80] ---- */
void AIPerson_LoadGlue(Udff_tInfo *handle)
{
  int glueLoop;

  Udff_GetInt(handle);
  Udff_GetBuffer(handle,(char *)AIPerson_glueTable,0x54);
  if ((Cars_gNumCopCars != 0) &&
     (((AIPERSON_RACE_TYPE != RaceType_HotPursuit && (AIPERSON_RACE_TYPE != RaceType_Id5)) ||
      ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) == 0 &&
       ((Cars_gNumHumanRaceCars != 2 || (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) == 0)))))))) {
    for (glueLoop = 0; glueLoop < 0x15; glueLoop++) {
      if (0x10000 < AIPerson_glueTable[glueLoop]) {
        AIPerson_glueTable[glueLoop] =
            fixedmult(AIPerson_glueTable[glueLoop],0x12666);
      }
      else if (AIPerson_glueTable[glueLoop] < 0x10000) {
        AIPerson_glueTable[glueLoop] =
            fixedmult(AIPerson_glueTable[glueLoop],0xd999);
      }
    }
  }
  return;
}

/* ---- AIPerson_Startup__Fv  [@0x8006908c] ---- */
void AIPerson_Startup(void)
{
  Udff_tInfo *handle;
  char filename[110];

  AIPerson_LoadGridAndSetPersonalityIndexes();
  sprintf(filename,D_80055354,Paths_Paths[2]);
  handle = Udff_Opena(filename,(char *)0x0,1);
  AIPerson_LoadPersonalityData(handle);
  Udff_Close(handle);
  sprintf(filename,D_80055364,Paths_Paths[2]);
  handle = Udff_Opena(filename,(char *)0x0,1);
  AIPerson_LoadScriptData(handle);
  Udff_Close(handle);
  if (((AIPERSON_RACE_TYPE == RaceType_HotPursuit) || (AIPERSON_RACE_TYPE == RaceType_Id5)) &&
     ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||
      ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) {
    sprintf(filename,D_80055374,Paths_Paths[2]);
  }
  else if (((u_int)AIPERSON_RACE_TYPE < RaceType_Tournament) && (Cars_gNumAIRaceCars == 1)) {
    sprintf(filename,D_80055384,D_80116470[0]);
  }
  else {
    sprintf(filename,D_80055394,D_80116470[0]);
  }
  handle = Udff_Opena(filename,(char *)0x0,1);
  AIPerson_LoadGlue(handle);
  Udff_Close(handle);
  AIPerson_SetPersonalityPointers();
  return;
}

/* ---- AIPerson_Cleanup__Fv  [@0x80069230] ---- */
void AIPerson_Cleanup(void)
{
  return;
}
