/* game/common/ailife.cpp -- RECONSTRUCTED (NFS4 AI action/reaction scripting; 8 free AIScript_* fns).
 *   Player-action submission + reaction-table processing. SYM-v3 locals; vs disasm-v2.txt.
 *   NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "ailife_externs.h"


/* ---- intra-TU forward declarations ---- */
int AILife_EvaluateLife(Car_tObj *carObj);
void AILife_RCSetSpeeds(Car_tObj *carObj);
void AILife_RCPickSliceAndDirection(Car_tObj *carObj);
void AILife_RCPickDesiredLatPosition(Car_tObj *carObj);
void AILife_SetInitialSlicePositionOrientationEtc(Car_tObj *carObj);
void AILife_PlaceCarAtLocation(Car_tObj *carObj,int rotation1024);
void AILife_ReencarnateTraffic(Car_tObj *carObj);
void AILife_ReencarnateCopBySlice(Car_tObj *carObj,int slice,int travelDirection,int roadSide,int moving);
void AILife_ReencarnateCopByPosition(Car_tObj *carObj,int slice,int travelDirection,coorddef *pos,matrixtdef *ori);
void AILife_ReencarnateTrafficByPosition(Car_tObj *carObj,int slice,int travelDirection,coorddef *pos,matrixtdef *ori);
void AILife_ReencarnateCopByLatPosAndRotation(Car_tObj *carObj,int slice,int travelDirection,int latPos,int rotation1024);
int AILife_IsCoordInThisLiveArea(coorddef *tPos,Car_tObj *racer);
Car_tObj * AILife_IsTrafficCarInAnyLiveArea(Car_tObj *traffic);
int AILife_IsCoordInThisVisibleArea(coorddef *tPos,Car_tObj *racer);
Car_tObj * AILife_IsCarInAnyVisibleArea(Car_tObj *carObj);
Car_tObj * AILife_IsSliceInAnyVisibleArea(int slice);
Car_tObj * AILife_IsSliceCloseToAnyCopCar(int slice);
Car_tObj * AILife_IsPositionInAnyVisibleArea(coorddef *pos);
void AILife_Debug(char *format, ...);


/* ---- AILife_EvaluateLife__FP8Car_tObj  [@0x80067650] ---- */
int AILife_EvaluateLife(Car_tObj *carObj)
{
  int iVar1;
  Car_tObj *pCVar2;
  
  if (((carObj->carFlags & 0x400U) == 0) &&
     (iVar1 = AILife_IsCoordInThisLiveArea(&(carObj->N).position,carObj->basisCar), iVar1 == 0)) {
    pCVar2 = AILife_IsTrafficCarInAnyLiveArea(carObj);
    carObj->basisCar = pCVar2;
    if (pCVar2 == (Car_tObj *)0x0) {
      return 1;
    }
  }
  return 0;
}

/* ---- AILife_RCSetSpeeds__FP8Car_tObj  [@0x800676b4] ---- */
void AILife_RCSetSpeeds(Car_tObj *carObj)
{
  AISpeeds_CalcDesiredSpeed(carObj);
  carObj->currentSpeed = carObj->desiredSpeed;
  return;
}

/* ---- AILife_RCPickSliceAndDirection__FP8Car_tObj  [@0x800676e4] ---- */
void AILife_RCPickSliceAndDirection(Car_tObj *carObj)
{
  int approachSide;
  int offset;
  int search;
  int count;
  Car_tObj*checkCar;
  coorddef basisOuterCoord;
  int basisOuterSlice;
  short sVar1;
  u_int uVar2;
  int iVar3;
  bool bVar4;
  int *piVar5;
  int iVar6;
  int iVar7;
  u_int uVar8;
  Car_tObj *pCVar9;
  short sVar10;
  int iVar11;
  int iVar12;
  coorddef local_38;
  
  uVar2 = fastRandom * randSeed;
  randtemp = (uVar2 & 0xffff) * randSeed;
  iVar11 = 1;
  fastRandom = randtemp & 0xffff;
  uVar8 = randtemp & 0xffff00;
  carObj->basisCar =
       Cars_gLifeBasisCarList[Cars_gNumLifeBasisCars * ((uVar2 & 0xffff00) >> 8) >> 0x10];
  if ((uVar8 >> 8) * 1000 >> 0x10 < 500) {
    iVar11 = -1;
  }
  pCVar9 = carObj->basisCar;
  iVar6 = pCVar9->currentSpeed;
  if (iVar6 < 0) {
    iVar6 = -iVar6;
  }
  if (0x1e0000 < iVar6) {
    iVar11 = pCVar9->direction;
  }
  iVar12 = pCVar9->sortIndex;
  for (iVar6 = 0; iVar6 < Cars_gNumCars; iVar6 = iVar6 + 1) {
    pCVar9 = Cars_gSortedList[(iVar12 + Cars_gNumCars) % Cars_gNumCars];
    if (((pCVar9 != carObj) && (pCVar9 != carObj->basisCar)) && ((pCVar9->carFlags & 0x100U) != 0))
    {
      iVar7 = (int)(carObj->basisCar->N).simRoadInfo.slice + iVar11 * 0x24;
      if (iVar11 * 0x24 < 0) {
        iVar3 = gNumSlices;
        if (iVar7 < 0) goto LAB_800678dc;
      }
      else if (gNumSlices <= iVar7) {
        iVar3 = -gNumSlices;
LAB_800678dc:
        iVar7 = iVar7 + iVar3;
      }
      bVar4 = false;
      piVar5 = (int *)(iVar7 * 0x20 + (int)BWorldSm_slices);
      local_38.x = *piVar5;
      local_38.y = piVar5[1];
      local_38.z = piVar5[2];
      iVar7 = AILife_IsCoordInThisVisibleArea(&local_38,pCVar9);
      if (iVar7 != 0) {
        iVar7 = AIWorld_ApxSplineDistance(pCVar9,carObj->basisCar);
        if (iVar7 < 0) {
          iVar7 = iVar7 + 0xffff;
        }
        if (0 < iVar11 * (iVar7 >> 0x10)) {
          bVar4 = true;
        }
      }
      if (!bVar4) break;
      carObj->basisCar = pCVar9;
    }
    iVar12 = iVar12 + iVar11;
  }
  uVar2 = fastRandom * randSeed;
  fastRandom = uVar2 & 0xffff;
  iVar6 = -1;
  if (499 < (uVar2 >> 8 & 0xffff) * 1000 >> 0x10) {
    iVar6 = 1;
  }
  carObj->direction = iVar6;
  if (AITune_oneWay != 0) {
    iVar6 = -1;
    if (GameSetup_gData.reverseTrack == 0) {
      iVar6 = 1;
    }
    carObj->direction = iVar6;
  }
  randtemp = fastRandom * randSeed;
  iVar11 = ((randtemp >> 0x15 & 7) + 0x1c) * iVar11;
  fastRandom = randtemp & 0xffff;
  carObj->desiredDirection = carObj->direction;
  if (iVar11 < 0) {
    sVar1 = (carObj->basisCar->N).simRoadInfo.slice;
    sVar10 = sVar1 + (short)iVar11;
    if (sVar1 + iVar11 < 0) {
      sVar10 = (short)gNumSlices + sVar10;
    }
    (carObj->N).simRoadInfo.slice = sVar10;
  }
  else {
    sVar1 = (carObj->basisCar->N).simRoadInfo.slice;
    sVar10 = sVar1 + (short)iVar11;
    if (gNumSlices <= sVar1 + iVar11) {
      sVar10 = sVar10 - (short)gNumSlices;
    }
    (carObj->N).simRoadInfo.slice = sVar10;
  }
  /* RAW @0x80067ad4-e8: a1=basisCar->carIndex(+0x254), a2=(basisCar->N).simRoadInfo.slice(+8),
   * a3=(carObj->N).simRoadInfo.slice(+8) -- the 3 dropped varargs, restored from the oracle. */
  AILife_Debug(" psad checked group, basis now %d(s=%d) new slice=%d\n",
               carObj->basisCar->carIndex,
               (carObj->basisCar->N).simRoadInfo.slice,
               (carObj->N).simRoadInfo.slice);
  return;
}

/* ---- AILife_RCPickDesiredLatPosition__FP8Car_tObj  [@0x80067b1c] ---- */
void AILife_RCPickDesiredLatPosition(Car_tObj *carObj)
{
  /* SYM @0x80067b1c (single fn-scope block, no per-branch nesting): REG randNumLanes($v1),
   * newSlice($a0, doubles as the byte-table base pointer AND the final result), width($a1)
   * -- and the RNG step (fastRandom*randSeed) is computed ONCE (oracle materializes it fresh
   * per branch, but from the SAME unconsumed fastRandom/randSeed -- the earlier recon called
   * it TWICE, a real duplicate-computation bug) (w18-a7). */
  int randNumLanes;
  int newSlice;
  int width;
  u_int uVar2;

  newSlice = (int)(carObj->N).simRoadInfo.slice;
  if (carObj->direction == AITune_driveSide) {
    newSlice = newSlice * 0x20 + (int)BWorldSm_slices;
    width = *(u_char *)(newSlice + 0x1f);
    randtemp = fastRandom * randSeed;
    randNumLanes = *(u_char *)(newSlice + 0x1d) & 0xf;
    uVar2 = (u_int)width * 0x8000;
    fastRandom = randtemp & 0xffff;
    newSlice = uVar2 * ((randNumLanes * (randtemp >> 8 & 0xffff) >> 0x10) + 1) - (uVar2 >> 1);
  }
  else {
    newSlice = newSlice * 0x20 + (int)BWorldSm_slices;
    width = *(u_char *)(newSlice + 0x1e);
    randtemp = fastRandom * randSeed;
    randNumLanes = *(u_char *)(newSlice + 0x1d) >> 4;
    fastRandom = randtemp & 0xffff;
    newSlice = (u_int)width * -0x8000 * ((randNumLanes * (randtemp >> 8 & 0xffff) >> 0x10) + 1) +
               ((u_int)width * 0x8000 >> 1);
  }
  carObj->desiredLatPos = newSlice;
  newSlice = carObj->desiredLatPos + carObj->laneSlack;
  carObj->desiredLatPos = newSlice;
  carObj->rampDesiredLatPos = newSlice;
  return;
}

/* ---- AILife_PlaceCarAtLocation__FP8Car_tObjiiiii  [@0x80067c50] ---- */
void AILife_PlaceCarAtLocation(Car_tObj *carObj,int slice,int desiredLatPos,int direction,int currentSpeed,
               int rotation1024)
{
  carObj->desiredLatPos = desiredLatPos;
  carObj->direction = direction;
  carObj->desiredDirection = direction;
  (carObj->N).simRoadInfo.slice = (short)slice;
  carObj->currentSpeed = currentSpeed;
  AILife_PlaceCarAtLocation(carObj,rotation1024);
  return;
}

/* ---- AILife_SetInitialSlicePositionOrientationEtc__FP8Car_tObj  [@0x80067c8c] ---- */
void AILife_SetInitialSlicePositionOrientationEtc(Car_tObj *carObj)
{
  /* SYM @0x80067c8c block: ONE local `offset` (AUTO coorddef, fp-24) -- not two
   * (dropped a duplicate dead `coorddef local_18` the earlier pass left; w18-a7). */
  coorddef offset;

  memset((u_char *)&offset,'\0',0xc);
  offset.x = carObj->desiredLatPos;
  offset.y = 0x10000;
  Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,(int)(carObj->N).simRoadInfo.slice,&offset,carObj->direction);
  return;
}

/* ---- AILife_PlaceCarAtLocation__FP8Car_tObji  [@0x80067ce0] ---- */
void AILife_PlaceCarAtLocation(Car_tObj *carObj,int rotation1024)
{
  /* SYM @0x80067ce0 block: "targetDirection"(coorddef, currentSpeed!=0 branch) and
   * "zero"(coorddef, currentSpeed==0 branch) are TWO block-scoped locals sharing ONE
   * stack slot (fp-0x50) -- each branch writes its own coorddef and copies it into
   * linearVel INSIDE the branch; gcc TAIL-MERGES the byte-identical copy sequence into
   * one shared block (raw shows a single merge point + `j`) (w18-a7, §D tail-merge). */
  matrixtdef *pmVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  matrixtdef *m1;
  matrixtdef rotMatrix;
  matrixtdef *rotP;

  iVar3 = carObj->desiredLatPos;
  iVar4 = carObj->currentSpeed;
  (carObj->N).active = '\x01';
  carObj->rampDesiredLatPos = iVar3;
  carObj->desiredSpeed = iVar4;
  AIPhysic_ResetCar(carObj);
  if (stackSpeedUpEnbabledFlag == 0) {
    AILife_SetInitialSlicePositionOrientationEtc(carObj);
  }
  else {
    gWSavePtr = (u_long)SetSp((void *)gWSavePtr);  /* @0x57D38 disasm-v2: scratchpad sp swap */
    stackSpeedUpEnbabledFlag = 0;
    AILife_SetInitialSlicePositionOrientationEtc(carObj);
    gWSavePtr = (u_long)SetSp((void *)gWSavePtr);  /* @0x57D60 disasm-v2: restore sp */
    stackSpeedUpEnbabledFlag = 1;
  }
  if (carObj->currentSpeed != 0) {
    coorddef targetDirection;
    int speed;
    targetDirection.x = (carObj->N).orientMat.m[6];
    targetDirection.y = (carObj->N).orientMat.m[7];
    targetDirection.z = (carObj->N).orientMat.m[8];
    speed = carObj->currentSpeed;
    if (speed < 0) {
      speed = -speed;
    }
    targetDirection.x = fixedmult(speed,targetDirection.x);
    targetDirection.y = fixedmult(speed,targetDirection.y);
    targetDirection.z = fixedmult(speed,targetDirection.z);
    (carObj->N).linearVel.x = targetDirection.x;
    (carObj->N).linearVel.y = targetDirection.y;
    (carObj->N).linearVel.z = targetDirection.z;
  }
  else {
    coorddef zero;
    memset((u_char *)&zero,'\0',0xc);
    (carObj->N).linearVel.x = zero.x;
    (carObj->N).linearVel.y = zero.y;
    (carObj->N).linearVel.z = zero.z;
  }
  if ((carObj->carFlags & 4U) != 0) {
    Physics_ResetCar(carObj);
  }
  rotP = &rotMatrix;
  xformy(rotP,(void *)rotation1024);
  m1 = &(carObj->N).orientMat;
  Math_fasttransmult(m1,rotP,m1);
  pmVar2 = &(carObj->N).shadowMat;
  do {
    iVar3 = m1->m[1];
    iVar4 = m1->m[2];
    iVar5 = m1->m[3];
    pmVar2->m[0] = m1->m[0];
    pmVar2->m[1] = iVar3;
    pmVar2->m[2] = iVar4;
    pmVar2->m[3] = iVar5;
    m1 = (matrixtdef *)(m1->m + 4);
    pmVar2 = (matrixtdef *)(pmVar2->m + 4);
  } while (m1 != (matrixtdef *)((carObj->N).orientMat.m + 8));
  pmVar2->m[0] = m1->m[0];
  AIInit_ClearAICar(carObj);
  iVar3 = Cars_CalculateRoadPosition(carObj);
  carObj->rampDesiredLatPos = iVar3;
  carObj->desiredLatPos = iVar3;
  carObj->roadPosition = iVar3;
  iVar3 = Cars_CalculateRoadSpan(carObj);
  carObj->roadSpan = iVar3;
  AIWorld_CalculateLaneInfo(carObj);
  return;
}

/* ---- AILife_ReencarnateTraffic__FP8Car_tObj  [@0x80067ee4] ---- */
void AILife_ReencarnateTraffic(Car_tObj *carObj)
{
  /* PERMUTER (score 0 @iter224): compute the color-index UNCONDITIONALLY into a named
   * local before the flag test -- matches the oracle materializing it regardless of
   * the branch (w18-a7). */
  u_int colorIdx;

  randtemp = fastRandom * randSeed;
  fastRandom = randtemp & 0xffff;
  colorIdx = (randtemp >> 8 & 0xffff) * 3 >> 0x10;
  if ((carObj->carFlags & 0x10U) != 0) {
    R3DCar_ChangeTrafficColor(carObj,colorIdx);
  }
  AI_ChooseNewLaneSlack(carObj);
  AISpeeds_SetTrafficSpeedRandomFactor(carObj);
  AILife_RCPickSliceAndDirection(carObj);
  AILife_RCPickDesiredLatPosition(carObj);
  AILife_RCSetSpeeds(carObj);
  AILife_PlaceCarAtLocation(carObj,0);
  return;
}

/* ---- AILife_ReencarnateTrafficByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef  [@0x80067f94] ---- */
/* @0x80067F94: mangled __FP8Car_tObjiiP8coorddefP10matrixtdef -> returns void; the recon omitted the
 * return-type token (ill-formed in C++; gcc-2.7.2 fell back to implicit-int) and dropped the forward
 * decl. Added `void` + the intra-TU forward declaration (sibling of AILife_ReencarnateCopByPosition) (M19). */
void AILife_ReencarnateTrafficByPosition(Car_tObj *carObj,int slice,int travelDirection,coorddef *pos,matrixtdef *ori)
{
  /* SYM @0x80067f94 (fn-scope): AUTO coorddef "zero"(fp-0x40, memset'd linearVel temp),
   * AUTO coorddef "offset"(fp-0x30, Newton_Set.. coorddef) -- dropped the dead duplicate
   * decls the earlier pass left unused (w18-a7). */
  coorddef zero;
  coorddef offset;
  short sVar1;
  int *piVar2;
  matrixtdef *pmVar3;
  int iVar4;
  int iVar5;
  int iVar6;

  memset((u_char *)&zero,'\0',0xc);
  memset((u_char *)&offset,'\0',0xc);
  randtemp = fastRandom * randSeed;
  fastRandom = randtemp & 0xffff;
  if ((carObj->carFlags & 0x10U) != 0) {
    R3DCar_ChangeTrafficColor(carObj,(randtemp >> 8 & 0xffff) * 3 >> 0x10);
  }
  AI_ChooseNewLaneSlack(carObj);
  AISpeeds_SetTrafficSpeedRandomFactor(carObj);
  carObj->basisCar = (Car_tObj *)0x0;
  carObj->direction = travelDirection;
  carObj->desiredDirection = travelDirection;
  (carObj->N).simRoadInfo.slice = (short)slice;
  AILife_RCSetSpeeds(carObj);
  sVar1 = (carObj->N).simRoadInfo.slice;
  carObj->currentSpeed = 0;
  Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,(int)sVar1,&offset,carObj->direction);
  pmVar3 = &(carObj->N).orientMat;
  iVar4 = pos->y;
  iVar5 = pos->z;
  (carObj->N).position.x = pos->x;
  (carObj->N).position.y = iVar4;
  (carObj->N).position.z = iVar5;
  piVar2 = ori->m;
  do {
    iVar4 = piVar2[1];
    iVar5 = piVar2[2];
    iVar6 = piVar2[3];
    pmVar3->m[0] = *piVar2;
    pmVar3->m[1] = iVar4;
    pmVar3->m[2] = iVar5;
    pmVar3->m[3] = iVar6;
    piVar2 = piVar2 + 4;
    pmVar3 = (matrixtdef *)(pmVar3->m + 4);
  } while (piVar2 != ori->m + 8);
  pmVar3->m[0] = *piVar2;
  pmVar3 = &(carObj->N).shadowMat;
  piVar2 = ori->m;
  do {
    iVar4 = *(int *)((int)ori + 4);
    iVar5 = *(int *)((int)ori + 8);
    iVar6 = *(int *)((int)ori + 0xc);
    pmVar3->m[0] = ori->m[0];
    pmVar3->m[1] = iVar4;
    pmVar3->m[2] = iVar5;
    pmVar3->m[3] = iVar6;
    ori = (matrixtdef *)((int)ori + 0x10);
    pmVar3 = (matrixtdef *)(pmVar3->m + 4);
  } while (ori != (matrixtdef *)(piVar2 + 8));
  pmVar3->m[0] = *(int *)ori;
  (carObj->N).linearVel.x = zero.x;
  (carObj->N).linearVel.y = zero.y;
  (carObj->N).linearVel.z = zero.z;
  (carObj->N).speedXZ = 0;
  AIInit_ClearAICar(carObj);
  iVar4 = Cars_CalculateRoadPosition(carObj);
  carObj->rampDesiredLatPos = iVar4;
  carObj->desiredLatPos = iVar4;
  carObj->roadPosition = iVar4;
  iVar4 = Cars_CalculateRoadSpan(carObj);
  carObj->roadSpan = iVar4;
  AIWorld_CalculateLaneInfo(carObj);
  AILife_RCPickDesiredLatPosition(carObj);
  return;
}

/* ---- AILife_ReencarnateCopBySlice__FP8Car_tObjiiii  [@0x800681a0] ---- */
void AILife_ReencarnateCopBySlice(Car_tObj *carObj,int slice,int travelDirection,int roadSide,int moving)
{
  /* SYM @0x800681a0: "width"($v0)/"numLanes"($v1) are BLOCK-SCOPED locals inside each
   * of the 3 lane-metric sub-branches (line23 block, line29 block) -- not function-scope
   * generic uVar2/uVar3 (w18-a7). */
  int iVar1;
  u_int uVar2;

  iVar1 = AITune_oneWay;
  (carObj->N).simRoadInfo.slice = (short)slice;
  if ((iVar1 != 0) && (travelDirection = -1, GameSetup_gData.reverseTrack == 0)) {
    travelDirection = 1;
  }
  carObj->direction = travelDirection;
  carObj->desiredDirection = travelDirection;
  if (moving == 0) {
    if (roadSide == -1) {
      int width;
      int numLanes;
      iVar1 = slice * 0x20 + (int)BWorldSm_slices;
      width = *(u_char *)(iVar1 + 0x1e);
      numLanes = *(u_char *)(iVar1 + 0x1d) >> 4;
      iVar1 = -0x20000 - (u_int)width * 0x8000 * (u_int)numLanes;
      goto LAB_800682dc;
    }
    {
      int width;
      int numLanes;
      iVar1 = slice * 0x20 + (int)BWorldSm_slices;
      width = *(u_char *)(iVar1 + 0x1f);
      numLanes = *(u_char *)(iVar1 + 0x1d) & 0xf;
      iVar1 = (u_int)width * 0x8000 * numLanes;
    }
    uVar2 = 0x20000;
LAB_800682d4:
    iVar1 = iVar1 + uVar2;
  }
  else {
    if (carObj->direction != 1) {
      int numLanes;
      iVar1 = slice * 0x20 + (int)BWorldSm_slices;
      numLanes = (u_int)(*(u_char *)(iVar1 + 0x1d) >> 4);
      if (numLanes != 0) {
        int width;
        width = (u_int)*(u_char *)(iVar1 + 0x1e);
        iVar1 = width * -0x8000 * numLanes;
        uVar2 = width * 0x8000 >> 1;
        goto LAB_800682d4;
      }
    }
    {
      int width;
      int numLanes;
      iVar1 = slice * 0x20 + (int)BWorldSm_slices;
      width = *(u_char *)(iVar1 + 0x1f);
      uVar2 = (u_int)width * 0x8000;
      numLanes = *(u_char *)(iVar1 + 0x1d) & 0xf;
      iVar1 = uVar2 * numLanes - (uVar2 >> 1);
    }
  }
LAB_800682dc:
  carObj->desiredLatPos = iVar1;
  if (moving == 0) {
    carObj->desiredSpeed = 0;
    carObj->currentSpeed = 0;
  }
  else {
    AILife_RCSetSpeeds(carObj);
  }
  carObj->rampDesiredLatPos = carObj->desiredLatPos;
  carObj->roadPosition = carObj->desiredLatPos;
  AILife_PlaceCarAtLocation(carObj,0);
  return;
}

/* ---- AILife_ReencarnateCopByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef  [@0x80068324] ---- */
void AILife_ReencarnateCopByPosition(Car_tObj *carObj,int slice,int travelDirection,coorddef *pos,matrixtdef *ori)
{
  /* SYM @0x80068324 (fn-scope): AUTO coorddef "zero"(fp-0x38, memset'd linearVel temp),
   * AUTO coorddef "offset"(fp-0x28, Newton_Set.. coorddef) -- dropped the dead duplicate
   * decls the earlier pass left unused (w18-a7). */
  coorddef zero;
  coorddef offset;
  bool bVar1;
  int *piVar2;
  matrixtdef *pmVar3;
  int iVar4;
  int iVar5;
  int iVar6;

  memset((u_char *)&zero,'\0',0xc);
  memset((u_char *)&offset,'\0',0xc);
  bVar1 = AITune_oneWay != 0;
  (carObj->N).simRoadInfo.slice = (short)slice;
  if ((bVar1) && (travelDirection = -1, GameSetup_gData.reverseTrack == 0)) {
    travelDirection = 1;
  }
  carObj->direction = travelDirection;
  carObj->desiredDirection = travelDirection;
  carObj->desiredSpeed = 0;
  carObj->currentSpeed = 0;
  AIPhysic_ResetCar(carObj);
  Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,(int)(carObj->N).simRoadInfo.slice,&offset,carObj->direction);
  pmVar3 = &(carObj->N).orientMat;
  iVar4 = pos->y;
  iVar5 = pos->z;
  (carObj->N).position.x = pos->x;
  (carObj->N).position.y = iVar4;
  (carObj->N).position.z = iVar5;
  piVar2 = ori->m;
  do {
    iVar4 = piVar2[1];
    iVar5 = piVar2[2];
    iVar6 = piVar2[3];
    pmVar3->m[0] = *piVar2;
    pmVar3->m[1] = iVar4;
    pmVar3->m[2] = iVar5;
    pmVar3->m[3] = iVar6;
    piVar2 = piVar2 + 4;
    pmVar3 = (matrixtdef *)(pmVar3->m + 4);
  } while (piVar2 != ori->m + 8);
  pmVar3->m[0] = *piVar2;
  pmVar3 = &(carObj->N).shadowMat;
  piVar2 = ori->m;
  do {
    iVar4 = *(int *)((int)ori + 4);
    iVar5 = *(int *)((int)ori + 8);
    iVar6 = *(int *)((int)ori + 0xc);
    pmVar3->m[0] = ori->m[0];
    pmVar3->m[1] = iVar4;
    pmVar3->m[2] = iVar5;
    pmVar3->m[3] = iVar6;
    ori = (matrixtdef *)((int)ori + 0x10);
    pmVar3 = (matrixtdef *)(pmVar3->m + 4);
  } while (ori != (matrixtdef *)(piVar2 + 8));
  pmVar3->m[0] = *(int *)ori;
  (carObj->N).linearVel.x = zero.x;
  (carObj->N).linearVel.y = zero.y;
  (carObj->N).linearVel.z = zero.z;
  AIInit_ClearAICar(carObj);
  iVar4 = Cars_CalculateRoadPosition(carObj);
  carObj->rampDesiredLatPos = iVar4;
  carObj->desiredLatPos = iVar4;
  carObj->roadPosition = iVar4;
  iVar4 = Cars_CalculateRoadSpan(carObj);
  carObj->roadSpan = iVar4;
  AIWorld_CalculateLaneInfo(carObj);
  return;
}

/* ---- AILife_ReencarnateCopByLatPosAndRotation__FP8Car_tObjiiii  [@0x800684d4] ---- */
void AILife_ReencarnateCopByLatPosAndRotation(Car_tObj *carObj,int slice,int travelDirection,int latPos,int rotation1024)
{
  /* SYM @0x800684d4 (single fn-scope block): AUTO coorddef "zero"(fp-0x60, memset'd
   * linearVel temp), AUTO coorddef "offset"(fp-0x50, Newton_Set.. coorddef), AUTO
   * matrixtdef "rotMatrix"(fp-0x40, xformy target) -- dropped the dead duplicate
   * zero/offset/rotMatrix decls the earlier pass left unused (w18-a7). */
  coorddef zero;
  coorddef offset;
  matrixtdef rotMatrix;
  bool bVar1;
  matrixtdef *pmVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  matrixtdef *m1;

  memset((u_char *)&zero,'\0',0xc);
  memset((u_char *)&offset,'\0',0xc);
  (carObj->N).active = '\x01';
  bVar1 = AITune_oneWay != 0;
  (carObj->N).simRoadInfo.slice = (short)slice;
  if ((bVar1) && (travelDirection = -1, GameSetup_gData.reverseTrack == 0)) {
    travelDirection = 1;
  }
  carObj->direction = travelDirection;
  carObj->desiredDirection = travelDirection;
  carObj->desiredSpeed = 0;
  carObj->currentSpeed = 0;
  AIPhysic_ResetCar(carObj);
  offset.x = latPos * carObj->direction;
  Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,(int)(carObj->N).simRoadInfo.slice,&offset,carObj->direction);
  xformy(&rotMatrix,(void *)rotation1024);
  m1 = &(carObj->N).orientMat;
  Math_fasttransmult(m1,&rotMatrix,m1);
  pmVar2 = &(carObj->N).shadowMat;
  do {
    iVar4 = m1->m[1];
    iVar5 = m1->m[2];
    iVar3 = m1->m[3];
    pmVar2->m[0] = m1->m[0];
    pmVar2->m[1] = iVar4;
    pmVar2->m[2] = iVar5;
    pmVar2->m[3] = iVar3;
    m1 = (matrixtdef *)(m1->m + 4);
    pmVar2 = (matrixtdef *)(pmVar2->m + 4);
  } while (m1 != (matrixtdef *)((carObj->N).orientMat.m + 8));
  pmVar2->m[0] = m1->m[0];
  (carObj->N).linearVel.x = zero.x;
  (carObj->N).linearVel.y = zero.y;
  (carObj->N).linearVel.z = zero.z;
  AIInit_ClearAICar(carObj);
  iVar3 = Cars_CalculateRoadPosition(carObj);
  carObj->rampDesiredLatPos = iVar3;
  carObj->desiredLatPos = iVar3;
  carObj->roadPosition = iVar3;
  iVar3 = Cars_CalculateRoadSpan(carObj);
  carObj->roadSpan = iVar3;
  AIWorld_CalculateLaneInfo(carObj);
  return;
}

/* ---- AILife_IsCoordInThisLiveArea__FP8coorddefP8Car_tObj  [@0x80068658] ---- */
int AILife_IsCoordInThisLiveArea(coorddef *tPos,Car_tObj *racer)
{
  /* SYM @0x80068658 block: REG xD($v1)/zD($a2)/dist($v1, reuses xD's reg) -- 3 named
   * locals, not 2 generic iVar temps (w18-a7). */
  int xD;
  int zD;
  int dist;

  zD = tPos->z - (racer->N).position.z;
  if (zD < 0) {
    zD = -zD;
  }
  xD = tPos->x - (racer->N).position.x;
  if (xD < 0) {
    xD = -xD;
  }
  if (zD < xD) {
    dist = xD + (zD >> 2);
  }
  else {
    dist = zD + (xD >> 2);
  }
  if (0xd80000 < dist) {
    /* RAW @0x800686b8-800686f0: nullsub arg materialize -- $a0=&"dist=%d",
     * $a1 = dist/0xffff (magic-mult div, M=0x80008001 shift=15, restored per §3.14).
     * literal 0/1 returns (not `!cond`) -- oracle recomputes the return value AFTER
     * the call rather than keeping the compare flag live across it in a saved reg. */
    AILife_Debug("dist=%d", dist / 0xffff);
    return 0;
  }
  return 1;
}

/* ---- AILife_IsTrafficCarInAnyLiveArea__FP8Car_tObj  [@0x80068704] ---- */
Car_tObj * AILife_IsTrafficCarInAnyLiveArea(Car_tObj *traffic)
{
  int iVar1;
  Car_tObj **ppCVar2;
  int iVar3;
  coorddef *tPos;
  
  iVar3 = 0;
  tPos = &(traffic->N).position;
  if (0 < Cars_gNumLifeBasisCars) {
    ppCVar2 = Cars_gLifeBasisCarList;
    do {
      iVar1 = AILife_IsCoordInThisLiveArea(tPos,*ppCVar2);
      if (iVar1 != 0) {
        return *ppCVar2;
      }
      iVar3 = iVar3 + 1;
      ppCVar2 = ppCVar2 + 1;
    } while (iVar3 < Cars_gNumLifeBasisCars);
  }
  return (Car_tObj *)0x0;
}

/* ---- AILife_IsCoordInThisVisibleArea__FP8coorddefP8Car_tObj  [@0x80068788] ---- */
int AILife_IsCoordInThisVisibleArea(coorddef *tPos,Car_tObj *racer)
{
  /* SYM @0x80068788 block: same REG layout as IsCoordInThisLiveArea -- xD($v1)/
   * zD($a2)/dist($v1, reuses xD's reg) (w18-a7). */
  int xD;
  int zD;
  int dist;

  zD = tPos->z - (racer->N).position.z;
  if (zD < 0) {
    zD = -zD;
  }
  xD = tPos->x - (racer->N).position.x;
  if (xD < 0) {
    xD = -xD;
  }
  if (zD < xD) {
    dist = xD + (zD >> 2);
  }
  else {
    dist = zD + (xD >> 2);
  }
  return 0xac0000 < dist ^ 1;
}

/* ---- AILife_IsCarInAnyVisibleArea__FP8Car_tObj  [@0x800687ec] ---- */
Car_tObj * AILife_IsCarInAnyVisibleArea(Car_tObj *carObj)
{
  Car_tObj *pCVar1;
  
  pCVar1 = AILife_IsPositionInAnyVisibleArea(&(carObj->N).position);
  return pCVar1;
}

/* ---- AILife_IsSliceInAnyVisibleArea__Fi  [@0x8006880c] ---- */
Car_tObj * AILife_IsSliceInAnyVisibleArea(int slice)
{
  int racerLoop;
  int sliceDist;
  int iVar1;
  Car_tObj **ppCVar2;
  int iVar3;
  
  iVar3 = 0;
  ppCVar2 = Cars_gHumanRaceCarList;
  while( true ) {
    if (Cars_gNumHumanRaceCars <= iVar3) {
      return (Car_tObj *)0x0;
    }
    iVar1 = AIWorld_ApxSplineDistance((int)((*ppCVar2)->N).simRoadInfo.slice,slice);
    if (iVar1 < 0) {
      iVar1 = -iVar1;
    }
    if (iVar1 < 0xac0000) break;
    ppCVar2 = ppCVar2 + 1;
    iVar3 = iVar3 + 1;
  }
  return *ppCVar2;
}

/* ---- AILife_IsSliceCloseToAnyCopCar__Fi  [@0x800688ac] ---- */
Car_tObj * AILife_IsSliceCloseToAnyCopCar(int slice)
{
  int copLoop;
  int sliceDist;
  int iVar1;
  Car_tObj **ppCVar2;
  int iVar3;
  
  iVar3 = 0;
  ppCVar2 = Cars_gCopCarList;
  while( true ) {
    if (Cars_gNumCopCars <= iVar3) {
      return (Car_tObj *)0x0;
    }
    iVar1 = AIWorld_ApxSplineDistance((int)((*ppCVar2)->N).simRoadInfo.slice,slice);
    if (iVar1 < 0) {
      iVar1 = -iVar1;
    }
    if (iVar1 < 0x320000) break;
    ppCVar2 = ppCVar2 + 1;
    iVar3 = iVar3 + 1;
  }
  return *ppCVar2;
}

/* ---- AILife_IsPositionInAnyVisibleArea__FP8coorddef  [@0x8006894c] ---- */
Car_tObj * AILife_IsPositionInAnyVisibleArea(coorddef *pos)
{
  int iVar1;
  Car_tObj **ppCVar2;
  int iVar3;

  iVar3 = 0;
  if (0 < Cars_gNumHumanRaceCars) {
    ppCVar2 = Cars_gHumanRaceCarList;
    do {
      iVar1 = AILife_IsCoordInThisVisibleArea(pos,*ppCVar2);
      if (iVar1 != 0) {
        return *ppCVar2;
      }
      iVar3 = iVar3 + 1;
      ppCVar2 = ppCVar2 + 1;
    } while (iVar3 < Cars_gNumHumanRaceCars);
  }
  return (Car_tObj *)0x0;
}

/* ---- AILife_Debug__FPce  [@0x800689d0] ---- */
/* HIDDEN-PHANTOM FIX (w14-a2): oracle mangles __FPce (char*,...) -- was __FPc (char*) with no
 * varargs, a NAME MISMATCH invisible to the gate ("NOT IN OBJECT" forever). Raw demangle
 * @0x800689d0 confirms "AILife_Debug(char *, ...)". Nullsub body (§3.2 compiled-out debug fn)
 * but callers still set up the real varargs (§3.2 nullsub-still-takes-its-real-args). */
void AILife_Debug(char *format, ...)
{
  /* SYM fsize=0, no locals besides REGPARM format -- the Ghidra-decompiled dead locals this
   * used to carry (sliceDist/dist/newSlice/... /rotMatrix) were leftover decompiler noise from
   * a larger un-optimized debug body; dropped per SYM (w14-a2, matches oracle's zero-size frame). */
  return;
}
