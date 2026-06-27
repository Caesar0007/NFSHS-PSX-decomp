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
void AILife_Debug(char *format);


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
    if (Cars_gNumCars == 0) {
      trap(0x1c00);
    }
    if ((Cars_gNumCars == -1) && (iVar12 + Cars_gNumCars == -0x80000000)) {
      trap(0x1800);
    }
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
      piVar5 = (int *)(iVar7 * 0x20 + BWorldSm_slices);
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
  AILife_Debug(" psad checked group, basis now %d(s=%d) new slice=%d\n");
  return;
}

/* ---- AILife_RCPickDesiredLatPosition__FP8Car_tObj  [@0x80067b1c] ---- */
void AILife_RCPickDesiredLatPosition(Car_tObj *carObj)
{
  int randNumLanes;
  int newSlice;
  int width;
  int iVar1;
  u_int uVar2;
  
  iVar1 = (int)(carObj->N).simRoadInfo.slice;
  if (carObj->direction == AITune_driveSide) {
    iVar1 = iVar1 * 0x20 + BWorldSm_slices;
    uVar2 = (u_int)*(u_char *)(iVar1 + 0x1f) * 0x8000;
    iVar1 = uVar2 * (((*(u_char *)(iVar1 + 0x1d) & 0xf) * (fastRandom * randSeed >> 8 & 0xffff) >>
                     0x10) + 1) - (uVar2 >> 1);
  }
  else {
    iVar1 = iVar1 * 0x20 + BWorldSm_slices;
    uVar2 = (u_int)*(u_char *)(iVar1 + 0x1e);
    iVar1 = uVar2 * -0x8000 *
            (((u_int)(*(u_char *)(iVar1 + 0x1d) >> 4) * (fastRandom * randSeed >> 8 & 0xffff) >> 0x10)
            + 1) + (uVar2 * 0x8000 >> 1);
  }
  randtemp = fastRandom * randSeed;
  fastRandom = randtemp & 0xffff;
  carObj->desiredLatPos = iVar1;
  iVar1 = carObj->desiredLatPos + carObj->laneSlack;
  carObj->desiredLatPos = iVar1;
  carObj->rampDesiredLatPos = iVar1;
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
  coorddef offset;
  coorddef local_18;
  
  memset((u_char *)&local_18,'\0',0xc);
  local_18.x = carObj->desiredLatPos;
  local_18.y = 0x10000;
  Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,(int)(carObj->N).simRoadInfo.slice,&local_18,carObj->direction);
  return;
}

/* ---- AILife_PlaceCarAtLocation__FP8Car_tObji  [@0x80067ce0] ---- */
void AILife_PlaceCarAtLocation(Car_tObj *carObj,int rotation1024)
{
  coorddef targetDirection;
  int speed;
  coorddef zero;
  matrixtdef rotMatrix;
  u_long uVar1;
  matrixtdef *pmVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  matrixtdef *m1;
  int local_50;
  int local_4c;
  int local_48;
  matrixtdef mStack_40;
  
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
  if (carObj->currentSpeed == 0) {
    memset((u_char *)&local_50,'\0',0xc);
  }
  else {
    local_50 = (carObj->N).orientMat.m[6];
    local_4c = (carObj->N).orientMat.m[7];
    local_48 = (carObj->N).orientMat.m[8];
    iVar3 = carObj->currentSpeed;
    if (iVar3 < 0) {
      iVar3 = -iVar3;
    }
    local_50 = fixedmult(iVar3,local_50);
    local_4c = fixedmult(iVar3,local_4c);
    local_48 = fixedmult(iVar3,local_48);
  }
  (carObj->N).linearVel.x = local_50;
  (carObj->N).linearVel.y = local_4c;
  (carObj->N).linearVel.z = local_48;
  if ((carObj->carFlags & 4U) != 0) {
    Physics_ResetCar(carObj);
  }
  xformy(&mStack_40,(void *)rotation1024);
  m1 = &(carObj->N).orientMat;
  Math_fasttransmult(m1,&mStack_40,m1);
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
  randtemp = fastRandom * randSeed;
  fastRandom = randtemp & 0xffff;
  if ((carObj->carFlags & 0x10U) != 0) {
    R3DCar_ChangeTrafficColor(carObj,(randtemp >> 8 & 0xffff) * 3 >> 0x10);
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
  coorddef zero;
  coorddef offset;
  short sVar1;
  int *piVar2;
  matrixtdef *pmVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int local_40;
  int local_3c;
  int local_38;
  coorddef cStack_30;
  
  memset((u_char *)&local_40,'\0',0xc);
  memset((u_char *)&cStack_30,'\0',0xc);
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
  Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,(int)sVar1,&cStack_30,carObj->direction);
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
  (carObj->N).linearVel.x = local_40;
  (carObj->N).linearVel.y = local_3c;
  (carObj->N).linearVel.z = local_38;
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
  int width;
  int numLanes;
  int iVar1;
  u_int uVar2;
  u_int uVar3;
  
  iVar1 = AITune_oneWay;
  (carObj->N).simRoadInfo.slice = (short)slice;
  if ((iVar1 != 0) && (travelDirection = -1, GameSetup_gData.reverseTrack == 0)) {
    travelDirection = 1;
  }
  carObj->direction = travelDirection;
  carObj->desiredDirection = travelDirection;
  if (moving == 0) {
    if (roadSide == -1) {
      iVar1 = slice * 0x20 + BWorldSm_slices;
      iVar1 = -0x20000 -
              (u_int)*(u_char *)(iVar1 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar1 + 0x1d) >> 4);
      goto LAB_800682dc;
    }
    iVar1 = slice * 0x20 + BWorldSm_slices;
    iVar1 = (u_int)*(u_char *)(iVar1 + 0x1f) * 0x8000 * (*(u_char *)(iVar1 + 0x1d) & 0xf);
    uVar2 = 0x20000;
LAB_800682d4:
    iVar1 = iVar1 + uVar2;
  }
  else {
    if (carObj->direction != 1) {
      iVar1 = slice * 0x20 + BWorldSm_slices;
      uVar2 = (u_int)(*(u_char *)(iVar1 + 0x1d) >> 4);
      if (uVar2 != 0) {
        uVar3 = (u_int)*(u_char *)(iVar1 + 0x1e);
        iVar1 = uVar3 * -0x8000 * uVar2;
        uVar2 = uVar3 * 0x8000 >> 1;
        goto LAB_800682d4;
      }
    }
    iVar1 = slice * 0x20 + BWorldSm_slices;
    uVar2 = (u_int)*(u_char *)(iVar1 + 0x1f) * 0x8000;
    iVar1 = uVar2 * (*(u_char *)(iVar1 + 0x1d) & 0xf) - (uVar2 >> 1);
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
  coorddef zero;
  coorddef offset;
  bool bVar1;
  int *piVar2;
  matrixtdef *pmVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int local_38;
  int local_34;
  int local_30;
  coorddef cStack_28;
  
  memset((u_char *)&local_38,'\0',0xc);
  memset((u_char *)&cStack_28,'\0',0xc);
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
  Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,(int)(carObj->N).simRoadInfo.slice,&cStack_28,carObj->direction);
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
  (carObj->N).linearVel.x = local_38;
  (carObj->N).linearVel.y = local_34;
  (carObj->N).linearVel.z = local_30;
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
  coorddef zero;
  coorddef offset;
  matrixtdef rotMatrix;
  bool bVar1;
  matrixtdef *pmVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  matrixtdef *m1;
  int local_60;
  int local_5c;
  int local_58;
  coorddef local_50;
  matrixtdef mStack_40;
  
  memset((u_char *)&local_60,'\0',0xc);
  memset((u_char *)&local_50,'\0',0xc);
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
  local_50.x = latPos * carObj->direction;
  Newton_SetInitialSlicePositionOrientationEtc(&carObj->N,(int)(carObj->N).simRoadInfo.slice,&local_50,carObj->direction);
  xformy(&mStack_40,(void *)rotation1024);
  m1 = &(carObj->N).orientMat;
  Math_fasttransmult(m1,&mStack_40,m1);
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
  (carObj->N).linearVel.x = local_60;
  (carObj->N).linearVel.y = local_5c;
  (carObj->N).linearVel.z = local_58;
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
  int xD;
  int zD;
  int dist;
  int iVar1;
  int iVar2;
  
  iVar2 = tPos->z - (racer->N).position.z;
  if (iVar2 < 0) {
    iVar2 = -iVar2;
  }
  iVar1 = tPos->x - (racer->N).position.x;
  if (iVar1 < 0) {
    iVar1 = -iVar1;
  }
  if (iVar2 < iVar1) {
    iVar1 = iVar1 + (iVar2 >> 2);
  }
  else {
    iVar1 = iVar2 + (iVar1 >> 2);
  }
  if (0xd80000 < iVar1) {
    AILife_Debug((char *)(AIInit_forceHumanHandBrake + 1));
  }
  return (u_int)(0xd80000 >= iVar1);
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
  int xD;
  int zD;
  int dist;
  int iVar1;
  int iVar2;
  
  iVar2 = tPos->z - (racer->N).position.z;
  if (iVar2 < 0) {
    iVar2 = -iVar2;
  }
  iVar1 = tPos->x - (racer->N).position.x;
  if (iVar1 < 0) {
    iVar1 = -iVar1;
  }
  if (iVar2 < iVar1) {
    iVar1 = iVar1 + (iVar2 >> 2);
  }
  else {
    iVar1 = iVar2 + (iVar1 >> 2);
  }
  return 0xac0000 < iVar1 ^ 1;
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
void AILife_Debug(char *format)
{
  int sliceDist;
  int dist;
  int newSlice;
  int width;
  int zD;
  int speed;
  int copLoop;
  int count;
  int approachSide;
  int search;
  coorddef zero;
  matrixtdef rotMatrix;
  
  return;
}
