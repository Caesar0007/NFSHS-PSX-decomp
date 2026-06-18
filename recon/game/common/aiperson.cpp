/* game/common/aiperson.cpp -- RECONSTRUCTED (NFS4 AI personality/script/glue loader; 8 free AIPerson_* fns).
 *   Per-car personality assignment + .bin table loaders. SYM-faithful, recompilable C++.
 *   NOT original source. Owned data externs -> func_va_data.cpp at data-mat time.
 */
#include "../../nfs4_types.h"
#include "aiperson_externs.h"


/* ---- intra-TU forward declarations ---- */
void AIPerson_LoadGridAndSetPersonalityIndexes(void);
void AIPerson_SetPersonality(Car_tObj *carObj,int personalityIndex);
void AIPerson_SetPersonalityPointers(void);
void AIPerson_LoadPersonalityData(Udff_tInfo *handle);
void AIPerson_LoadScriptData(Udff_tInfo *handle);
void AIPerson_LoadGlue(Udff_tInfo *handle);
void AIPerson_Startup(void);
void AIPerson_Cleanup(void);


/* ---- AIPerson_LoadGridAndSetPersonalityIndexes__Fv  [@0x800689e8] ---- */
void AIPerson_LoadGridAndSetPersonalityIndexes(void)
{
  int personality;
  int iVar2;
  register int iVar3 asm("$4");   /* a0 (matching aid #13): counter, also fills the blez delay slot */
  Car_tObj *carObj;
  Car_tObj **ppCVar4;
  GameSetup_tData *pGVar5;

  iVar2 = Cars_gNumCars;
  if (0 < Cars_gNumCars) {
    iVar3 = 0;
    pGVar5 = &GameSetup_gData;
    ppCVar4 = Cars_gList;
    do {
      personality = pGVar5->carInfo->Personality;
      pGVar5 = (GameSetup_tData *)((pGVar5->controllerData).shockImpact + 1);
      carObj = *ppCVar4;
      carObj->personalityIndex = personality;
      ppCVar4 = ppCVar4 + 1;
      iVar3 = iVar3 + 1;
    } while (iVar3 < iVar2);
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
  Car_tObj *carObj;
  Car_tObj **ppCVar1;
  int iVar2;

  iVar2 = 0;
  ppCVar1 = Cars_gList;
 loopTop:
  if (iVar2 < Cars_gNumCars) {
    carObj = *ppCVar1;
    ppCVar1 = ppCVar1 + 1;
    AIPerson_SetPersonality(carObj,carObj->personalityIndex);
    iVar2 = iVar2 + 1;
    goto loopTop;
  }
  return;
}

/* ---- AIPerson_LoadPersonalityData__FP10Udff_tInfo  [@0x80068b60] ---- */
void AIPerson_LoadPersonalityData(Udff_tInfo *handle)
{
  int local_40;
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
  int iVar11;
  int iVar12;
  int iVar13;
  Udff_GetInt(handle);

  local_40 = 0;
  while (1) {
    if (local_40 >= 9) {
      break;
    }
    iVar1 = Udff_GetInt(handle);
    iVar2 = Udff_GetInt(handle);
    iVar3 = Udff_GetInt(handle);
    iVar4 = Udff_GetInt(handle);
    iVar5 = Udff_GetInt(handle);
    iVar6 = Udff_GetInt(handle);
    iVar7 = Udff_GetInt(handle);
    Udff_GetInt(handle);
    iVar8 = Udff_GetInt(handle);
    iVar9 = Udff_GetInt(handle);
    iVar10 = Udff_GetInt(handle);
    iVar11 = Udff_GetInt(handle);
    iVar12 = Udff_GetInt(handle);
    iVar13 = Udff_GetInt(handle);
    AIPerson_PersonalityData[local_40].blockMaxDistance = AIPerson_blockMaxDistance[iVar1];
    AIPerson_PersonalityData[local_40].blockMinDistance = AIPerson_blockMinDistance[iVar2];
    AIPerson_PersonalityData[local_40].oncomingLookAhead = AIPerson_oncomingLookAhead[iVar3];
    AIPerson_PersonalityData[local_40].laneSwerve[0] = AIPerson_laneSwerve[iVar4][0];
    AIPerson_PersonalityData[local_40].laneSwerve[1] = AIPerson_laneSwerve[iVar4][1];
    AIPerson_PersonalityData[local_40].laneSwerve[2] = AIPerson_laneSwerve[iVar4][2];
    AIPerson_PersonalityData[local_40].laneSwerve[3] = AIPerson_laneSwerve[iVar4][3];
    AIPerson_PersonalityData[local_40].swerveChangeProb = AIPerson_swerveChangeProb[iVar4];
    AIPerson_PersonalityData[local_40].brakeMultiplier = AIPerson_brakeMultiplier[iVar5];
    AIPerson_PersonalityData[local_40].attackActivationHits = AIPerson_attackActivationHits[iVar6];
    AIPerson_PersonalityData[local_40].attackTime = AIPerson_attackTimes[iVar6];
    AIPerson_PersonalityData[local_40].fishtailAngle = AIPerson_fishtailAngles[iVar7];
    AIPerson_PersonalityData[local_40].minimumBetweenWipeoutTicks = AIPerson_minimumWipeOutTicks[iVar8 + GameSetup_gData.Weather];
    AIPerson_PersonalityData[local_40].randomBetweenWipeoutTicks = AIPerson_randomWipeOutTicks[iVar8 + GameSetup_gData.Weather];
    AIPerson_PersonalityData[local_40].gripLossProbPerSecond = AIPerson_gripLossProbPerSecond[iVar9];
    AIPerson_PersonalityData[local_40].gripLossMinFactor = AIPerson_gripLossMinFactor[iVar9];
    AIPerson_PersonalityData[local_40].gripLossRecoveryPerTick = AIPerson_gripLossRecoveryPerTick[iVar9];
    AIPerson_PersonalityData[local_40].bestLineAbility = AIPerson_bestLineAbilities[iVar10];
    AIPerson_PersonalityData[local_40].rearBumpProbMask = AIPerson_rearEndProbMask[iVar11];
    AIPerson_PersonalityData[local_40].smackProbMask = AIPerson_smackProbMask[iVar12];
    AIPerson_PersonalityData[local_40].copCollisionFirmness = iVar13;
    local_40++;
  }
  return;
}

/* ---- AIPerson_LoadScriptData__FP10Udff_tInfo  [@0x80068ea4] ---- */
void AIPerson_LoadScriptData(Udff_tInfo *handle)
{
  int perLoop;
  int actionLoop;
  int reactionLoop;
  int byteOffset;
  int actionMul;
  int byteOff2;
  int scriptBase;
  char *addr;
  int iVar1;

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
          iVar1 = Udff_GetInt(handle);
          addr = (char *)(reactionLoop + actionMul + byteOff2 + scriptBase);
          addr[0] = (char)iVar1;
          addr[4] = (char)Udff_GetInt(handle);
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
  int iVar1;
  int b;
  int *piVar2;
  int iVar3;
  int cmp;

  Udff_GetInt(handle);
  Udff_GetBuffer(handle,(char *)AIPerson_glueTable,0x54);
  if ((Cars_gNumCopCars != 0) &&
     (((GameSetup_gData.raceType != 1 && (GameSetup_gData.raceType != 5)) ||
      ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) == 0 &&
       ((Cars_gNumHumanRaceCars != 2 || (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) == 0)))))))) {
    iVar3 = 0;
    piVar2 = AIPerson_glueTable;
    do {
      iVar1 = *piVar2;
      cmp = 0x10000;
      if (cmp < iVar1) {
        b = 0x12666;
        goto LAB_8006905c;
      }
      cmp = 0xffff;
      if (cmp < iVar1) goto LAB_skip;
      b = 0xd999;
LAB_8006905c:
      iVar1 = fixedmult(iVar1,b);
      *piVar2 = iVar1;
LAB_skip:
      iVar3 = iVar3 + 1;
      piVar2 = piVar2 + 1;
    } while (iVar3 < 0x15);
  }
  return;
}

/* ---- AIPerson_Startup__Fv  [@0x8006908c] ---- */
void AIPerson_Startup(void)
{
  char **pathBase;
  Udff_tInfo *pUVar1;
  char acStack_80 [112];

  AIPerson_LoadGridAndSetPersonalityIndexes();
  pathBase = Paths_Paths;
  sprintf(acStack_80,D_80055354,pathBase[2]);
  pUVar1 = Udff_Opena(acStack_80,(char *)0x0,1);
  AIPerson_LoadPersonalityData(pUVar1);
  Udff_Close(pUVar1);
  sprintf(acStack_80,D_80055364,pathBase[2]);
  pUVar1 = Udff_Opena(acStack_80,(char *)0x0,1);
  AIPerson_LoadScriptData(pUVar1);
  Udff_Close(pUVar1);
  if (((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&
     ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||
      ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) {
    sprintf(acStack_80,D_80055374,pathBase[2]);
  }
  else if (((u_int)GameSetup_gData.raceType < 2) && (Cars_gNumAIRaceCars == 1)) {
    sprintf(acStack_80,D_80055384,D_80116470[0]);
  }
  else {
    sprintf(acStack_80,D_80055394,D_80116470[0]);
  }
  pUVar1 = Udff_Opena(acStack_80,(char *)0x0,1);
  AIPerson_LoadGlue(pUVar1);
  Udff_Close(pUVar1);
  AIPerson_SetPersonalityPointers();
  return;
}

/* ---- AIPerson_Cleanup__Fv  [@0x80069230] ---- */
void AIPerson_Cleanup(void)
{
  return;
}
