/* game/common/newton.cpp -- RECONSTRUCTED (NFS4 PSX Newton physics integrator; C++ TU)
 *   32 fns: ground elevation/normal ray-cast, road geometry, slice orientation, rot/vel
 *   integration @32/64Hz, ground-shadow matrices, barrier/spike collision, gravity.
 *   GTE-free (fixed-point + eaclib math). Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "newton_externs.h"

/* ---- newton.obj file-statics (BSS; SYM STAT tu=newton.obj). dummy_124/dummy_133 are
 *   cfront struct-pass scratch temporaries (not in Globals; coorddef out-params). ---- */
static int          divTable[50];
static short        fudgeTable[32];
static int          swap[4];
static BWorldSm_Pos testSimRoadInfo;
static BWorldSm_Pos newtestSimRoadInfo;
static coorddef     dummy_124;
static coorddef     dummy_133;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Newton_AddDamageZone(BO_tNewtonObj *newtonObj,int impulse,int zone,int type);
void Newton_FindClosestQuad(BO_tNewtonObj *n);
int Newton_CalculateSliceYaw(int slice);
void Newton_UpdateRoadGeometry(BO_tNewtonObj *n);
int Newton_FindGroundElevationGeneral(coorddef *point,coorddef *normal,coorddef *pointOnQuad);
int Newton_FindGroundElevationRough(coorddef *point,coorddef *normal,coorddef *pointOnQuad);
int Newton_FindGroundElevationAndNormalFast(int newtonObj,coorddef *normal);
int Newton_FindGroundElevationAndNormal(BO_tNewtonObj *newtonObj,coorddef *normal);
void Newton_LimitCarsToDrivableDist(BO_tNewtonObj *newtonObj);
int Newton_CalcPerpenHeightOfLowestPointFromGround(BO_tNewtonObj *newtonObj,coorddef *normal,coorddef *samplePoint);
int Newton_CalcPerpenHeightOfCenterPointFromGround(BO_tNewtonObj *newtonObj,coorddef *normal,coorddef *samplePoint);
void Newton_CalcDistToClosestPlayerCar(BO_tNewtonObj *n);
void Newton_UpdateRoadInfo(BO_tNewtonObj *n);
void Newton_CopyRoadMatrixToOrientMat(BO_tNewtonObj *n,int backwards);
void Newton_CopyRoadMatrixToShadowMat(BO_tNewtonObj *n,int backwards);
void Newton_SetInitialSlicePositionOrientationEtc(BO_tNewtonObj *n,int slice,coorddef *offset,int direction);
void Newton_QDUpdateVel(int newtonObj);
void Newton_QDUpdateRot64Hz(int newtonObj);
void Newton_QDUpdateRot32Hz(int newtonObj);
void Newton_CalculateGroundShadowMatrix(int newtonObj,int *normal,int orientToGround);
void Newton_CalcRealShadowCoordinates(int carObj,int currentTick);
void Newton_CheckForSpikeBelts(int newtonObj);
void Newton_DoPostBarrierCollisionHandling(Car_tObj *newtonObj,coorddef normal);
void Newton_GenerateVector(int type,int *vector,int testSimRoadInfo);
void Newton_TestForUndrivableSurfaces(BO_tNewtonObj *newtonObj);
void Newton_LimitAngularVelocity(int newtonObj);
void Newton_ApplyTheLawOfGravity(Car_tObj *newtonObj);
int Newton_CalculateRoadPositionFromSliceAndPosition(int slice,coorddef *position,matrixtdef *matrix);
int Newton_CalculateRoadPosition(BO_tNewtonObj *newtonObj);


/* ---- Newton_AddDamageZone__FP13BO_tNewtonObjiii  [NEWTON.CPP:50-216] SLD-VERIFIED ---- */
void Newton_AddDamageZone(BO_tNewtonObj *newtonObj,int impulse,int zone,int type)

{
  int temp;
  int iVar1;
  int iVar2;
  void *pvVar3;
  u_int uVar4;
  u_int uVar5;
  int iVar6;
  int imp;
  int iVar7;
  int iVar8;
  int iVar9;
  u_int uVar10;
  int intensity;
  int zMult;
  u_int uVar11;
  int yMult;
  u_int b;
  int xMult;
  u_int uVar12;
  matrixtdef transposeMat;
  
  iVar1 = Force_IsForceOn((Car_tObj *)newtonObj);
  if (iVar1 != 0) {
    Force_HitWall((newtonObj->collision).impulse);
  }
  if (GameSetup_gData.Damage != 0) {
    iVar1 = 0x640000;
    if (impulse / 2 < 0x640001) {
      iVar1 = impulse / 2;
    }
    if ((newtonObj[1].simRoadInfo.quadPts[1].y & 0x200U) != 0) {
      iVar1 = iVar1 / 2;
    }
    if (iVar1 < newtonObj->damage[zone]) {
      iVar1 = newtonObj->damage[zone];
    }
    newtonObj->damage[zone] = iVar1;
    if (zone < 8) {
      if (zone == 0) {
        iVar1 = (newtonObj->damage[0] + newtonObj->damage[2]) / 2;
        if (iVar1 < newtonObj->damage[1]) {
          iVar1 = newtonObj->damage[1];
        }
        iVar2 = newtonObj->damage[0];
        iVar7 = newtonObj->damage[6];
        newtonObj->damage[1] = iVar1;
      }
      else {
        if (zone == 1) {
          iVar1 = (newtonObj->damage[7] + newtonObj->damage[1]) / 2;
          if (iVar1 < newtonObj->damage[0]) {
            iVar1 = newtonObj->damage[0];
          }
          iVar2 = newtonObj->damage[1];
          iVar7 = newtonObj->damage[3];
          newtonObj->damage[0] = iVar1;
          iVar1 = (iVar2 + iVar7) / 2;
          if (iVar1 < newtonObj->damage[2]) {
            iVar1 = newtonObj->damage[2];
          }
          newtonObj->damage[2] = iVar1;
          goto Newton_AddDmgZ_typeSet;
        }
        if (zone != 6) {
          if (zone == 7) {
            iVar1 = (newtonObj->damage[7] + newtonObj->damage[1]) / 2;
            if (iVar1 < newtonObj->damage[0]) {
              iVar1 = newtonObj->damage[0];
            }
            iVar2 = newtonObj->damage[5];
            iVar7 = newtonObj->damage[7];
            newtonObj->damage[0] = iVar1;
            iVar1 = (iVar2 + iVar7) / 2;
            if (iVar1 < newtonObj->damage[6]) {
              iVar1 = newtonObj->damage[6];
            }
            newtonObj->damage[6] = iVar1;
          }
          else {
            iVar1 = (iVar1 + newtonObj->damage[zone + 2]) / 2;
            if (iVar1 < newtonObj->damage[zone + 1]) {
              iVar1 = newtonObj->damage[zone + 1];
            }
            newtonObj->damage[zone + 1] = iVar1;
            iVar1 = (newtonObj->damage[zone] + newtonObj->damage[zone + -2]) / 2;
            if (iVar1 < newtonObj->damage[zone + -1]) {
              iVar1 = newtonObj->damage[zone + -1];
            }
            newtonObj->damage[zone + -1] = iVar1;
          }
          goto Newton_AddDmgZ_typeSet;
        }
        iVar1 = (newtonObj->damage[4] + newtonObj->damage[6]) / 2;
        if (iVar1 < newtonObj->damage[5]) {
          iVar1 = newtonObj->damage[5];
        }
        iVar2 = newtonObj->damage[0];
        iVar7 = newtonObj->damage[6];
        newtonObj->damage[5] = iVar1;
      }
      iVar1 = (iVar2 + iVar7) / 2;
      if (iVar1 < newtonObj->damage[7]) {
        iVar1 = newtonObj->damage[7];
      }
      newtonObj->damage[7] = iVar1;
    }
  }
Newton_AddDmgZ_typeSet:
  uVar12 = 0x20000;
  if (type != 0) {
    b = 0;
    uVar11 = 0x20000;
    if (impulse < 0x5a0001) {
      if (impulse < 0) {
        impulse = impulse + 0x3f;
      }
      iVar1 = impulse >> 6;
      if (0x8000 < iVar1) {
        iVar1 = 0x8000;
      }
    }
    else {
      if (impulse < 0) {
        impulse = impulse + 3;
      }
      iVar2 = impulse >> 2;
      iVar1 = newtonObj->objAltitude;
      newtonObj->flightTime = 1;
      (newtonObj->collision).lastCollision = 0;
      *(u_int *)&newtonObj[3].eIndexShadow = 1;
      if (iVar1 < 0x20000) {
        (newtonObj->position).y = (newtonObj->position).y + 0x10000;
      }
      iVar7 = (newtonObj->linearVel).y + iVar2 / 3;
      iVar1 = 0xc0000;
      if (iVar7 < 0xc0001) {
        iVar1 = iVar7;
      }
      (newtonObj->linearVel).y = iVar1;
      iVar1 = iVar2;
      if (iVar2 < 0) {
        iVar1 = iVar2 + 0x1f;
      }
      iVar1 = iVar1 >> 5;
      if (0x9999 < iVar1) {
        iVar1 = 0x9999;
      }
      pvVar3 = BWorldSm_TunnelFlagSm(&newtonObj->simRoadInfo);
      if ((pvVar3 != (void *)0x0) && (0x90000 < (newtonObj->linearVel).y)) {
        (newtonObj->linearVel).y = 0x90000;
      }
      if (0x140000 < iVar2) {
        uVar12 = (fastRandom * randSeed & 0xffff) * randSeed;
        uVar11 = (uVar12 & 0xffff) * randSeed;
        uVar10 = (fastRandom * randSeed & 0xffff00) >> 8;
        randtemp = (uVar11 & 0xffff) * randSeed;
        uVar4 = (uVar12 & 0xffff00) >> 8;
        b = uVar4 * 3;
        uVar5 = (uVar11 & 0xffff00) >> 8;
        uVar11 = uVar5 * 3;
        fastRandom = randtemp & 0xffff;
        uVar12 = uVar10 * 4;
        if ((randtemp & 0xffff00) >> 8 < 0x3333) {
          iVar1 = -iVar1;
        }
        if (uVar12 + b + uVar11 < 0x40000) {
          if (uVar12 < 0x10000) {
            uVar12 = uVar10 << 3;
          }
          if (b < 0x10000) {
            b = uVar4 * 6;
          }
          if (uVar11 < 0x10000) {
            uVar11 = uVar5 * 6;
          }
        }
      }
      if (type == 2) {
        uVar12 = uVar12 << 1;
        b = b << 1;
        uVar11 = uVar11 << 1;
      }
    }
    iVar2 = fixedmult((newtonObj->angularVel).x,(newtonObj->orientMat).m[0]);
    iVar7 = fixedmult((newtonObj->angularVel).y,(newtonObj->orientMat).m[1]);
    iVar6 = fixedmult((newtonObj->angularVel).z,(newtonObj->orientMat).m[2]);
    iVar8 = (newtonObj->angularVel).x;
    iVar9 = (newtonObj->orientMat).m[3];
    newtonObj[1].shadowMat.m[8] = iVar2 + iVar7 + iVar6;
    iVar2 = fixedmult(iVar8,iVar9);
    iVar7 = fixedmult((newtonObj->angularVel).y,(newtonObj->orientMat).m[4]);
    iVar6 = fixedmult((newtonObj->angularVel).z,(newtonObj->orientMat).m[5]);
    iVar8 = (newtonObj->angularVel).x;
    iVar9 = (newtonObj->orientMat).m[6];
    newtonObj[1].shadowCoord[0].x = iVar2 + iVar7 + iVar6;
    iVar2 = fixedmult(iVar8,iVar9);
    iVar7 = fixedmult((newtonObj->angularVel).y,(newtonObj->orientMat).m[7]);
    iVar6 = fixedmult((newtonObj->angularVel).z,(newtonObj->orientMat).m[8]);
    newtonObj[1].shadowCoord[0].y = iVar2 + iVar7 + iVar6;
    if ((u_int)zone < 3) {
      iVar2 = fixedmult(iVar1,uVar12);
      iVar2 = newtonObj[1].shadowMat.m[8] - iVar2 / 2;
    }
    else {
      iVar2 = fixedmult(iVar1,uVar12);
      iVar2 = newtonObj[1].shadowMat.m[8] + iVar2 / 2;
    }
    newtonObj[1].shadowMat.m[8] = iVar2;
    if (zone - 2U < 3) {
      iVar2 = fixedmult(iVar1,b);
      newtonObj[1].shadowCoord[0].x = newtonObj[1].shadowCoord[0].x + iVar2 / 2;
      iVar1 = fixedmult(iVar1,uVar11);
      iVar1 = newtonObj[1].shadowCoord[0].y + iVar1 / 2;
    }
    else {
      iVar2 = fixedmult(iVar1,b);
      newtonObj[1].shadowCoord[0].x = newtonObj[1].shadowCoord[0].x - iVar2 / 2;
      iVar1 = fixedmult(iVar1,uVar11);
      iVar1 = newtonObj[1].shadowCoord[0].y - iVar1 / 2;
    }
    newtonObj[1].shadowCoord[0].y = iVar1;
    transpose(&newtonObj->orientMat,&transposeMat);
    iVar1 = fixedmult(newtonObj[1].shadowMat.m[8],transposeMat.m[0]);
    iVar2 = fixedmult(newtonObj[1].shadowCoord[0].x,transposeMat.m[1]);
    iVar7 = fixedmult(newtonObj[1].shadowCoord[0].y,transposeMat.m[2]);
    iVar6 = newtonObj[1].shadowMat.m[8];
    (newtonObj->angularVel).x = iVar1 + iVar2 + iVar7;
    iVar1 = fixedmult(iVar6,transposeMat.m[3]);
    iVar2 = fixedmult(newtonObj[1].shadowCoord[0].x,transposeMat.m[4]);
    iVar7 = fixedmult(newtonObj[1].shadowCoord[0].y,transposeMat.m[5]);
    iVar6 = newtonObj[1].shadowMat.m[8];
    (newtonObj->angularVel).y = iVar1 + iVar2 + iVar7;
    iVar1 = fixedmult(iVar6,transposeMat.m[6]);
    iVar2 = fixedmult(newtonObj[1].shadowCoord[0].x,transposeMat.m[7]);
    iVar7 = fixedmult(newtonObj[1].shadowCoord[0].y,transposeMat.m[8]);
    (newtonObj->angularVel).z = iVar1 + iVar2 + iVar7;
  }
  return;
}

/* ---- Newton_FindClosestQuad__FP13BO_tNewtonObj  [NEWTON.CPP:221-227] SLD-VERIFIED ---- */
void Newton_FindClosestQuad(BO_tNewtonObj *n)

{
  BWorldSm_FindClosestQuadRez(&n->position,&n->simRoadInfo,1)
  ;
  return;
}

/* ---- Newton_CalculateSliceYaw__Fi  [NEWTON.CPP:235-244] SLD-VERIFIED ---- */
int Newton_CalculateSliceYaw(int slice)

{
  int z2;
  int x2;
  int iVar1;
  int x1;
  int z1;
  int s;
  
  iVar1 = slice + 1;
  if (gNumSlices <= iVar1) {
    iVar1 = slice - (gNumSlices + -1);
  }
  iVar1 = intatan(BWorldSm_slices[iVar1].center[0] - BWorldSm_slices[slice].center[0],
                     BWorldSm_slices[iVar1].center[2] - BWorldSm_slices[slice].center[2]);
  return iVar1;
}

/* ---- Newton_UpdateRoadGeometry__FP13BO_tNewtonObj  [NEWTON.CPP:248-354] SLD-VERIFIED ---- */
void Newton_UpdateRoadGeometry(BO_tNewtonObj *n)

{
  int hiRez;
  int i;
  char cVar1;
  char cVar2;
  bool bVar3;
  int z2;
  Trk_NewSlice *pTVar4;
  coorddef *pcVar5;
  int x2;
  BO_tNewtonObj *pBVar6;
  int iVar7;
  int z1;
  int iVar8;
  int s;
  int r3;
  int a;
  int r5;
  int b;
  int r1;
  int a_00;
  int r6;
  int b_00;
  int r4;
  int b_01;
  int r2;
  int a_01;
  int x1;
  int slice;
  int iVar9;
  coorddef temp;
  
  if (n->active != '\0') {
    iVar9 = (int)(n->simRoadInfo).slice;
    bVar3 = 1 < n->simOptz;
    iVar8 = 0;
    if (bVar3) {
      if ((n->simRoadInfo).simQuad == (Trk_NewSimQuad *)0x0) {
        pTVar4 = BWorldSm_slices + iVar9;
        iVar8 = pTVar4->center[1];
        iVar7 = pTVar4->center[2];
        (n->roadCenterPoint).x = pTVar4->center[0];
        (n->roadCenterPoint).y = iVar8;
        (n->roadCenterPoint).z = iVar7;
      }
      else {
        iVar8 = (n->simRoadInfo).quadPts[0].y;
        iVar7 = (n->simRoadInfo).quadPts[0].z;
        (n->roadCenterPoint).x = (n->simRoadInfo).quadPts[0].x;
        (n->roadCenterPoint).y = iVar8;
        (n->roadCenterPoint).z = iVar7;
      }
    }
    else {
      (n->roadCenterPoint).z = 0;
      (n->roadCenterPoint).y = 0;
      (n->roadCenterPoint).x = 0;
      pBVar6 = n;
      for (; iVar8 < 4; iVar8 = iVar8 + 1) {
        if ((n->simRoadInfo).simQuad == (Trk_NewSimQuad *)0x0) {
          pTVar4 = BWorldSm_slices + (n->simRoadInfo).slice;
          temp.x = pTVar4->center[0];
          temp.y = pTVar4->center[1];
          temp.z = pTVar4->center[2];
        }
        else {
          temp.x = (pBVar6->simRoadInfo).quadPts[0].x;
          temp.y = (pBVar6->simRoadInfo).quadPts[0].y;
          temp.z = (pBVar6->simRoadInfo).quadPts[0].z;
        }
        (n->roadCenterPoint).x = (n->roadCenterPoint).x + temp.x;
        pBVar6 = (BO_tNewtonObj *)&(pBVar6->simRoadInfo).simRotFlag;
        (n->roadCenterPoint).y = (n->roadCenterPoint).y + temp.y;
        (n->roadCenterPoint).z = (n->roadCenterPoint).z + temp.z;
      }
      iVar8 = (n->roadCenterPoint).x;
      if (iVar8 < 0) {
        iVar8 = iVar8 + 3;
      }
      iVar7 = (n->roadCenterPoint).y;
      (n->roadCenterPoint).x = iVar8 >> 2;
      if (iVar7 < 0) {
        iVar7 = iVar7 + 3;
      }
      iVar8 = (n->roadCenterPoint).z;
      (n->roadCenterPoint).y = iVar7 >> 2;
      if (iVar8 < 0) {
        iVar8 = iVar8 + 3;
      }
      (n->roadCenterPoint).z = iVar8 >> 2;
    }
    pTVar4 = BWorldSm_slices;
    if (bVar3) {
      cVar1 = BWorldSm_slices[iVar9].right[2];
      cVar2 = BWorldSm_slices[iVar9].right[1];
      (n->roadMatrix).m[0] = (int)BWorldSm_slices[iVar9].right[0] << 9;
      (n->roadMatrix).m[2] = (int)cVar1 << 9;
      (n->roadMatrix).m[1] = (int)cVar2 << 9;
      cVar1 = pTVar4[iVar9].normal[2];
      cVar2 = pTVar4[iVar9].normal[1];
      (n->roadMatrix).m[3] = (int)pTVar4[iVar9].normal[0] << 9;
      (n->roadMatrix).m[5] = (int)cVar1 << 9;
      (n->roadMatrix).m[4] = (int)cVar2 << 9;
      cVar1 = pTVar4[iVar9].forward[1];
      cVar2 = pTVar4[iVar9].forward[2];
      (n->roadMatrix).m[6] = (int)pTVar4[iVar9].forward[0] << 9;
      (n->roadMatrix).m[7] = (int)cVar1 << 9;
      (n->roadMatrix).m[8] = (int)cVar2 << 9;
    }
    else if ((n->simRoadInfo).quadChanged != '\0') {
      pcVar5 = BWorldSm_UNormal(&n->simRoadInfo);
      iVar8 = pcVar5->y;
      iVar7 = pcVar5->z;
      (n->roadMatrix).m[3] = pcVar5->x;
      (n->roadMatrix).m[4] = iVar8;
      (n->roadMatrix).m[5] = iVar7;
      pcVar5 = BWorldSm_UForward(&n->simRoadInfo);
      iVar8 = pcVar5->y;
      iVar7 = pcVar5->z;
      (n->roadMatrix).m[6] = pcVar5->x;
      (n->roadMatrix).m[7] = iVar8;
      (n->roadMatrix).m[8] = iVar7;
      a_01 = (n->roadMatrix).m[4];
      b_00 = (n->roadMatrix).m[8];
      a_00 = (n->roadMatrix).m[3];
      a = (n->roadMatrix).m[5];
      b_01 = (n->roadMatrix).m[6];
      b = (n->roadMatrix).m[7];
      iVar8 = fixedmult(a_01,b_00);
      iVar7 = fixedmult(a,b);
      (n->roadMatrix).m[0] = iVar8 - iVar7;
      iVar8 = fixedmult(a,b_01);
      iVar7 = fixedmult(a_00,b_00);
      (n->roadMatrix).m[1] = iVar8 - iVar7;
      iVar8 = fixedmult(a_00,b);
      iVar7 = fixedmult(a_01,b_01);
      (n->roadMatrix).m[2] = iVar8 - iVar7;
    }
    iVar8 = iVar9 + 1;
    if (gNumSlices <= iVar8) {
      iVar8 = iVar9 - (gNumSlices + -1);
    }
    iVar8 = intatan(BWorldSm_slices[iVar8].center[0] - BWorldSm_slices[iVar9].center[0],
                       BWorldSm_slices[iVar8].center[2] - BWorldSm_slices[iVar9].center[2]);
    n->roadYaw = iVar8;
  }
  return;
}

/* ---- Newton_FindGroundElevationGeneral__FP8coorddefN20  [NEWTON.CPP:445-463] SLD-VERIFIED ---- */
int Newton_FindGroundElevationGeneral(coorddef *point,coorddef *normal,coorddef *pointOnQuad)

{
  int result;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int index;
  
  iVar5 = normal->y;
  if (iVar5 < 0x9eb9) {
    iVar4 = normal->x;
    if (iVar4 < 0) {
      iVar4 = iVar4 + 0xff;
    }
    iVar1 = *((int *)point) - pointOnQuad->x;
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    iVar3 = normal->z;
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xff;
    }
    iVar2 = ((int *)point)[2] - pointOnQuad->z;
    if (iVar2 < 0) {
      iVar2 = iVar2 + 0xff;
    }
    iVar5 = fixeddiv(-((iVar3 >> 8) * (iVar2 >> 8)) - (iVar4 >> 8) * (iVar1 >> 8),iVar5);
  }
  else {
    iVar4 = normal->x;
    if (iVar4 < 0) {
      iVar4 = iVar4 + 0xff;
    }
    iVar1 = *((int *)point) - pointOnQuad->x;
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    iVar3 = normal->z;
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xff;
    }
    iVar2 = ((int *)point)[2] - pointOnQuad->z;
    if (iVar2 < 0) {
      iVar2 = iVar2 + 0xff;
    }
    iVar5 = fixedmult(-((iVar3 >> 8) * (iVar2 >> 8)) - (iVar4 >> 8) * (iVar1 >> 8),
                       divTable[0x10000 - iVar5 >> 9]);
  }
  return iVar5 + pointOnQuad->y;
}

/* ---- Newton_FindGroundElevationRough__FP8coorddefN20  [NEWTON.CPP:475-506] SLD-VERIFIED ---- */
int Newton_FindGroundElevationRough(coorddef *point,coorddef *normal,coorddef *pointOnQuad)

{
  int result;
  int fudgeIndex;
  int index;
  int iVar1;
  int iVar2;
  int fudgeDist;
  int iVar3;
  int iVar4;
  int i;
  int iVar5;
  int numerator;
  int fudgeHeight;
  int iVar6;
  
  iVar3 = normal->x;
  iVar6 = 0;
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar1 = point->x - pointOnQuad->x;
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar4 = normal->z;
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar2 = point->z - pointOnQuad->z;
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar5 = 0;
  iVar3 = -((iVar4 >> 8) * (iVar2 >> 8)) - (iVar3 >> 8) * (iVar1 >> 8);
  do {
    if (iVar5 == 0) {
      iVar1 = point->x;
      if (iVar1 < 0) {
        iVar1 = -iVar1;
      }
      iVar4 = point->z >> 1;
      if (iVar4 < 0) {
        iVar4 = -iVar4;
      }
      if (iVar4 < iVar1) goto FindGERough_iterReduceA;
FindGERough_iterReduceB:
      iVar4 = iVar4 + (iVar1 >> 2);
    }
    else {
      iVar4 = point->z;
      iVar1 = point->x >> 2;
      if (iVar1 < 0) {
        iVar1 = -iVar1;
      }
      if (iVar4 < 0) {
        iVar4 = -iVar4;
      }
      if (iVar1 <= iVar4) goto FindGERough_iterReduceB;
FindGERough_iterReduceA:
      iVar4 = iVar1 + (iVar4 >> 2);
    }
    iVar4 = iVar4 >> 0xf;
    if (iVar4 < 0) {
      iVar4 = -iVar4;
    }
    iVar1 = iVar4;
    if (iVar4 < 0) {
      iVar1 = iVar4 + 0x1f;
    }
    iVar5 = iVar5 + 1;
    iVar6 = iVar6 + fudgeTable[iVar4 + (iVar1 >> 5) * -0x20] * 0x80;
    if (1 < iVar5) {
      iVar1 = normal->y;
      if (iVar1 < 0x9eb9) {
        iVar3 = fixeddiv(iVar3,iVar1);
      }
      else {
        iVar3 = fixedmult(iVar3,divTable[0x10000 - iVar1 >> 9]);
      }
      return iVar3 + pointOnQuad->y + iVar6;
    }
  } while( true );
}

/* ---- Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef  [NEWTON.CPP:515-599] SLD-VERIFIED ---- */
int Newton_FindGroundElevationAndNormalFast(int newtonObj,coorddef *normal)

{
  int elevation;
  int r1;
  int r2;
  int r3;
  int surfaceType;
  int r4;
  int iVar1;
  int iVar2;
  int iVar3;
  u_int uVar4;
  u_int uVar5;
  int iVar6;
  
  iVar1 = *(int *)(newtonObj + 0x154);
  iVar2 = *(int *)(newtonObj + 0x150);
  iVar3 = *(int *)(newtonObj + 0x158);
  normal->y = iVar1;
  normal->x = iVar2;
  normal->z = iVar3;
  if (iVar1 < 0x199a) {
    iVar1 = -0x7d000000;
  }
  else {
    iVar1 = Newton_FindGroundElevationGeneral((coorddef *)(newtonObj + 0xa0),normal,(coorddef *)(newtonObj + 0x168));
    uVar4 = *(u_int *)(newtonObj + 0xa0);
    uVar5 = *(u_int *)(newtonObj + 0xa8);
    *(u_int *)(newtonObj + 0x2ac) = 0;
    *(u_int *)(newtonObj + 0x2dc) = 0;
    *(u_int *)(newtonObj + 0x30c) = 0;
    *(u_int *)(newtonObj + 0x33c) = 0;
    *(u_int *)(newtonObj + 0x2b0) = 0;
    *(u_int *)(newtonObj + 0x2e0) = 0;
    *(u_int *)(newtonObj + 0x310) = 0;
    *(u_int *)(newtonObj + 0x340) = 0;
    *(int *)(newtonObj + 0x290) = iVar1;
    *(int *)(newtonObj + 0x2c0) = iVar1;
    *(int *)(newtonObj + 0x2f0) = iVar1;
    *(int *)(newtonObj + 800) = iVar1;
    *(int *)(newtonObj + 0x2a4) = iVar1;
    *(int *)(newtonObj + 0x2d4) = iVar1;
    *(int *)(newtonObj + 0x304) = iVar1;
    *(int *)(newtonObj + 0x334) = iVar1;
    *(u_int *)(newtonObj + 0x28c) = uVar4;
    *(u_int *)(newtonObj + 700) = uVar4;
    *(u_int *)(newtonObj + 0x2ec) = uVar4;
    *(u_int *)(newtonObj + 0x31c) = uVar4;
    *(u_int *)(newtonObj + 0x294) = uVar5;
    *(u_int *)(newtonObj + 0x2c4) = uVar5;
    *(u_int *)(newtonObj + 0x2f4) = uVar5;
    *(u_int *)(newtonObj + 0x324) = uVar5;
    iVar3 = normal->x;
    iVar6 = normal->y;
    iVar2 = normal->z;
    *(u_int *)(newtonObj + 0x2b8) = 1;
    *(u_int *)(newtonObj + 0x2e8) = 1;
    *(u_int *)(newtonObj + 0x318) = 1;
    *(u_int *)(newtonObj + 0x348) = 1;
    *(int *)(newtonObj + 0x298) = iVar3;
    *(int *)(newtonObj + 0x2c8) = iVar3;
    *(int *)(newtonObj + 0x2f8) = iVar3;
    *(int *)(newtonObj + 0x328) = iVar3;
    *(int *)(newtonObj + 0x29c) = iVar6;
    *(int *)(newtonObj + 0x2cc) = iVar6;
    *(int *)(newtonObj + 0x2fc) = iVar6;
    *(int *)(newtonObj + 0x32c) = iVar6;
    *(int *)(newtonObj + 0x2a0) = iVar2;
    *(int *)(newtonObj + 0x2d0) = iVar2;
    *(int *)(newtonObj + 0x300) = iVar2;
    *(int *)(newtonObj + 0x330) = iVar2;
  }
  return iVar1;
}

/* ---- Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef  [NEWTON.CPP:610-1057] SLD-VERIFIED ---- */
int Newton_FindGroundElevationAndNormal(BO_tNewtonObj *newtonObj,coorddef *normal)

{
  coorddef roadCenterPoint;
  int r2;
  int r3;
  int r4;
  coorddef lengthVector;
  coorddef widthVector;
  coorddef carGroundCoord;
  int v1;
  int r1;
  coorddef roadNormal;
  int roadSurfaceType;
  coorddef wheelVec;
  int limit;
  int wheelBounce;
  int speed;
  int ratio;
  int groundY_ratio;
  int tstr3;
  int tpi4;
  u_int tu1;
  int ti5;
  int ti1;
  int ti4;
  int frontGroundY;
  int wheelGround_y;
  int compressDelta;
  int iVar20;
  u_int tu21;
  int rightGroundY;
  u_int uVar1;
  u_int uVar2;
  int iVar3;
  int desiredCompression;
  BO_tNewtonObj *pBVar4;
  int iVar5;
  int ti8;
  int tstr9;
  int i;
  int ti9;
  coorddef *point;
  int iVar24;
  int rearGroundY;
  int tireMagic;
  int tireMagic2;
  int leftGroundY;
  int roll;
  int wheelData_p;
  int pitch;
  int pt;
  int tpi11;
  int newtonData_p;
  int tpi12;
  int tB13;
  int wheelInst_p;
  int bounce;
  int bounce_iter;
  int wheel_idx;
  int ti17;
  int wheelsInAir;
  int wheelsInAir_n;
  int ti15;
  int ti18;
  int ti16;
  coorddef elevation;
  coorddef tireCoord [4];
  coorddef carNormal;
  coorddef wheelHeight [4];
  coorddef vecOffset;
  BWorldSm_Pos testSimRoadInfo;
  coorddef tempVecX;
  coorddef tempVecY;
  int compressionValue [4];
  coorddef tempVecZ;
  matrixtdef transposeMat;
  int count;
  
  wheelGround_y = (newtonObj->orientMat).m[4];
  elevation.x = 0;
  elevation.y = 0;
  elevation.z = 0;
  tireMagic = (newtonObj->dimension).z * 0xd >> 0xc;
  wheelHeight[0].x = tireMagic * ((newtonObj->orientMat).m[6] >> 8);
  wheelHeight[0].y = tireMagic * ((newtonObj->orientMat).m[7] >> 8);
  wheelHeight[0].z = tireMagic * ((newtonObj->orientMat).m[8] >> 8);
  tireMagic2 = (newtonObj->dimension).x * 7 >> 0xb;
  wheelHeight[1].y = tireMagic2 * ((newtonObj->orientMat).m[0] >> 8);
  wheelHeight[1].z = tireMagic2 * ((newtonObj->orientMat).m[1] >> 8);
  wheelHeight[2].x = tireMagic2 * ((newtonObj->orientMat).m[2] >> 8);
  desiredCompression = (newtonObj->orientMat).m[3];
  compressDelta = -(newtonObj->dimension).y >> 8;
  wheelsInAir_n = 0;
  bounce_iter = 0;
  wheelData_p = (int)&testSimRoadInfo;
  newtonData_p = (int)&newtonObj->simRoadInfo;
  ti8 = (newtonObj->position).x + compressDelta * (desiredCompression >> 8);
  ti9 = (newtonObj->position).y + compressDelta * ((newtonObj->orientMat).m[4] >> 8);
  wheelHeight[3].y = (newtonObj->position).z + compressDelta * ((newtonObj->orientMat).m[5] >> 8);
  wheelHeight[2].z = ti8;
  tireCoord[0].x = (ti8 + wheelHeight[0].x) - wheelHeight[1].y;
  tireCoord[0].y = (ti9 + wheelHeight[0].y) - wheelHeight[1].z;
  tireCoord[0].z = (wheelHeight[3].y + wheelHeight[0].z) - wheelHeight[2].x;
  wheelHeight[3].x = ti9;
  tireCoord[2].x = (ti8 - wheelHeight[0].x) - wheelHeight[1].y;
  tireCoord[2].y = (ti9 - wheelHeight[0].y) - wheelHeight[1].z;
  point = (coorddef *)((wheelHeight[3].y - wheelHeight[0].z) + wheelHeight[2].x);
  tireCoord[1].x = ti8 + wheelHeight[0].x + wheelHeight[1].y;
  tireCoord[1].y = ti9 + wheelHeight[0].y + wheelHeight[1].z;
  tireCoord[1].z = wheelHeight[3].y + wheelHeight[0].z + wheelHeight[2].x;
  tireCoord[2].z = (wheelHeight[3].y - wheelHeight[0].z) - wheelHeight[2].x;
  tireCoord[3].x = (ti8 - wheelHeight[0].x) + wheelHeight[1].y;
  tireCoord[3].y = (ti9 - wheelHeight[0].y) + wheelHeight[1].z;
  tireCoord[3].z = (int)point;
  do {
    wheel_idx = *(int *)(newtonData_p + 4);
    ti15 = *(int *)(newtonData_p + 8);
    ti16 = *(int *)(newtonData_p + 0xc);
    *(u_int *)wheelData_p = *(u_int *)newtonData_p;
    *(int *)(wheelData_p + 4) = wheel_idx;
    *(int *)(wheelData_p + 8) = ti15;
    *(int *)(wheelData_p + 0xc) = ti16;
    newtonData_p = newtonData_p + 0x10;
    wheelData_p = wheelData_p + 0x10;
  } while ((Trk_NewSimSlice **)newtonData_p != &(newtonObj->simRoadInfo).simSlice);
  *(u_int *)wheelData_p = *(u_int *)newtonData_p;
  tpi12 = (int)wheelHeight;
  pt = (int)tireCoord;
  for (wheelInst_p = (int)newtonObj; wheelInst_p < (int)&newtonObj->speedXZ;
      wheelInst_p = wheelInst_p + 0x30) {
    ti17 = *(int *)(pt + 4);
    ti18 = *(int *)(pt + 8);
    *(u_int *)tpi12 = *(u_int *)pt;
    *(int *)(tpi12 + 4) = ti17;
    *(int *)(tpi12 + 8) = ti18;
    *(u_int *)(wheelInst_p + 0x2a4) = *(u_int *)(pt + 4);
    BWorldSm_FindClosestTriangleRez((coorddef *)pt,&testSimRoadInfo,1);
    tstr3 = (int)BWorldSm_UNormal(&testSimRoadInfo);
    tempVecX.x = *(int *)tstr3;
    tempVecX.y = *(int *)(tstr3 + 4);
    tempVecX.z = *(int *)(tstr3 + 8);
    uVar1 = 0xe;
    if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0x0) {
      uVar1 = (u_int)(testSimRoadInfo.simQuad)->surface;
    }
    *(u_int *)(wheelInst_p + 0x2b8) = uVar1;
    uVar1 = uVar1 & 0xf;
    if (((tempVecX.y < 0x1999) || (uVar1 == 0xe)) || (uVar1 == 0)) {
      tempVecX.y = 0x10000;
      tempVecX.x = 0;
      tempVecX.z = 0;
      elevation.x = elevation.x + *(int *)pt;
      iVar20 = *(int *)(pt + 4) - newtonObj->objAltitude;
accumGroundElev: /* @0x800a0398 */
      elevation.y = elevation.y + iVar20;
      elevation.z = elevation.z + *(int *)(pt + 8);
    }
    else {
      if (testSimRoadInfo.simQuad == (Trk_NewSimQuad *)0x0) {
        tpi4 = (int)(BWorldSm_slices + testSimRoadInfo.slice);
        tempVecY.x = *(int *)tpi4;
        tempVecY.y = *(int *)(tpi4 + 4);
        tempVecY.z = *(int *)(tpi4 + 8);
      }
      else {
        tempVecY.x = testSimRoadInfo.quadPts[0].x;
        tempVecY.y = testSimRoadInfo.quadPts[0].y;
        tempVecY.z = testSimRoadInfo.quadPts[0].z;
      }
      if (uVar1 - 2 < 2) {
        iVar20 = Newton_FindGroundElevationRough((coorddef *)pt,&tempVecX,&tempVecY)
        ;
        *(int *)(tpi12 + 4) = iVar20;
      }
      else {
        iVar20 = Newton_FindGroundElevationGeneral(point,&tempVecX,&tempVecY);
        *(int *)(tpi12 + 4) = iVar20;
      }
      *(u_int *)(wheelInst_p + 0x2a4) = *(u_int *)(tpi12 + 4);
      if (0x20000 < *(int *)(tpi12 + 4) - *(int *)(pt + 4)) {
        tempVecX.x = 0;
        tempVecX.y = 0x10000;
        tempVecX.z = 0;
        *(u_int *)(tpi12 + 4) = *(u_int *)(pt + 4);
        elevation.x = elevation.x + *(int *)pt;
        iVar20 = *(int *)(pt + 4);
        goto accumGroundElev;
      }
      elevation.x = elevation.x + *(int *)tpi12;
      elevation.y = elevation.y + *(int *)(tpi12 + 4);
      elevation.z = elevation.z + *(int *)(tpi12 + 8);
    }
    tu1 = *(u_int *)tpi12;
    tu21 = *(u_int *)(tpi12 + 4);
    uVar2 = *(u_int *)(tpi12 + 8);
    tpi12 = tpi12 + 0xc;
    *(u_int *)(wheelInst_p + 0x28c) = tu1;
    *(u_int *)(wheelInst_p + 0x290) = tu21;
    *(u_int *)(wheelInst_p + 0x294) = uVar2;
    pt = pt + 0xc;
    *(int *)(wheelInst_p + 0x298) = tempVecX.x;
    *(int *)(wheelInst_p + 0x29c) = tempVecX.y;
    *(int *)(wheelInst_p + 0x2a0) = tempVecX.z;
  }
  iVar24 = 0;
  count = 0;
  tempVecX.x = 0;
  tempVecX.z = 0;
  pBVar4 = newtonObj;
  for (iVar20 = 0; iVar20 < 4; iVar20 = iVar20 + 1) {
    tempVecX.y = (*(int *)(pBVar4[1].simRoadInfo.quadPts16 + 2) -
                 *(int *)((int)&tireCoord[0].y + iVar24)) / 2;
    pBVar4[1].simRoadInfo.forward.x = 0;
    if (tempVecX.y < -0x2665) {
      pBVar4[1].simRoadInfo.normal.z = 1;
      wheelsInAir_n = wheelsInAir_n + 1;
    }
    else if (pBVar4[1].simRoadInfo.normal.z == 1) {
      if (tempVecX.y < 1) {
        if (((newtonObj->objAltitude < 0x3333) && (-0x1999 < (newtonObj->linearVel).y)) &&
           (0xf333 < (newtonObj->orientationToGround).y)) {
          pBVar4[1].simRoadInfo.normal.z = 0;
        }
      }
      else {
        bounce_iter = bounce_iter + 1;
        pBVar4[1].simRoadInfo.normal.z = 0;
        pBVar4[1].simRoadInfo.forward.x = 1;
      }
    }
    iVar3 = -0x3333;
    if (0x358000 < newtonObj->speedXZ) {
      iVar3 = -0x2666;
    }
    if (tempVecX.y < iVar3) {
      tempVecX.y = iVar3;
    }
    iVar3 = tempVecX.y;
    if (tempVecX.y < 0) {
      iVar3 = tempVecX.y + 0xff;
    }
    ti5 = wheelGround_y;
    if (wheelGround_y < 0) {
      ti5 = wheelGround_y + 0xff;
    }
    iVar3 = (iVar3 >> 8) * (ti5 >> 8);
    compressionValue[iVar20] = iVar3;
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xff;
    }
    ti1 = *(int *)(newtonObj[1].damage[3] + 0x138);
    if (ti1 < 0) {
      ti1 = ti1 + 0xff;
    }
    iVar3 = (iVar3 >> 8) * (ti1 >> 8);
    pBVar4[1].simRoadInfo.normal.y = iVar3;
    if (*(int *)(*(int *)(newtonObj[1].simRoadInfo.quadPts16 + 1) + 0x40) == 1) {
      pBVar4[1].simRoadInfo.normal.y = iVar3 * 2;
    }
    pBVar4 = (BO_tNewtonObj *)&(pBVar4->simRoadInfo).quadPts[2].z;
    iVar24 = iVar24 + 0xc;
  }
  iVar20 = 0;
  tB13 = (int)newtonObj;
  if (bounce_iter != 0) {
    count = newtonObj[1].simRoadInfo.forward.x + newtonObj[1].position.x + newtonObj[1].wheelRot[0]
            + newtonObj[1].orientMat.m[4];
  }
  for (; iVar20 < 4; iVar20 = iVar20 + 1) {
    if (bounce_iter == 0) {
      if ((*(int *)(tB13 + 0x2a8) < 0) &&
         (iVar3 = *(int *)(tB13 + 0x2a8) >> 1, 0xdc28 < (newtonObj->orientationToGround).y)) {
Newton_FindGE_bounceFirst:
        *(int *)(tB13 + 0x2a8) = iVar3;
      }
    }
    else if ((*(int *)(tB13 + 0x2b0) != 0) && (iVar24 = (newtonObj->linearVel).y, iVar24 < 0)) {
      if (iVar24 < 0) {
        iVar24 = -iVar24;
      }
      iVar24 = iVar24 + newtonObj->groundVel;
      if (-1 < iVar24) {
        if (count == 0) {
          trap(0x1c00);
        }
        if ((count == -1) && (iVar24 == -0x80000000)) {
          trap(0x1800);
        }
        iVar3 = iVar24 / count >> 1;
        if (iVar24 < 0x100000) {
          ti4 = fixedmult(iVar24,0x1000);
          if (ti4 < 0x4ccd) {
            iVar24 = 0x4ccc;
          }
          else {
            iVar24 = fixedmult(iVar24,0x1000);
          }
          iVar3 = fixedmult(iVar24,iVar3);
        }
        iVar3 = *(int *)(tB13 + 0x2a8) + iVar3;
        goto Newton_FindGE_bounceFirst;
      }
    }
    tB13 = tB13 + 0x30;
  }
  iVar24 = 0;
  tpi11 = (int)swap;
  iVar20 = 0;
  do {
    if (3 < iVar24) {
      elevation.x = elevation.x >> 2;
      elevation.z = elevation.z >> 2;
      elevation.y = elevation.y >> 2;
      tempVecZ.x = (wheelHeight[0].x + wheelHeight[1].x) - (wheelHeight[2].x + wheelHeight[3].x) >>
                   1;
      tempVecZ.y = (wheelHeight[0].y + wheelHeight[1].y) - (wheelHeight[2].y + wheelHeight[3].y) >>
                   1;
      tempVecZ.z = (wheelHeight[0].z + wheelHeight[1].z) - (wheelHeight[2].z + wheelHeight[3].z) >>
                   1;
      Math_NormalizeShortVector(&tempVecZ);
      tempVecX.x = (wheelHeight[1].x + wheelHeight[3].x) - (wheelHeight[0].x + wheelHeight[2].x) >>
                   1;
      tempVecX.y = (wheelHeight[1].y + wheelHeight[3].y) - (wheelHeight[0].y + wheelHeight[2].y) >>
                   1;
      tempVecX.z = (wheelHeight[1].z + wheelHeight[3].z) - (wheelHeight[0].z + wheelHeight[2].z) >>
                   1;
      Math_NormalizeShortVector(&tempVecX);
      iVar20 = fixedmult(tempVecZ.y,tempVecX.z);
      iVar24 = fixedmult(tempVecZ.z,tempVecX.y);
      tempVecY.x = iVar20 - iVar24;
      iVar20 = fixedmult(tempVecZ.z,tempVecX.x);
      iVar24 = fixedmult(tempVecZ.x,tempVecX.z);
      tempVecY.y = iVar20 - iVar24;
      iVar20 = fixedmult(tempVecZ.x,tempVecX.y);
      iVar24 = fixedmult(tempVecZ.y,tempVecX.x);
      tempVecY.z = iVar20 - iVar24;
      Math_NormalizeShortVector(&tempVecY);
      if (tempVecY.y < 0) {
        wheelsInAir_n = 4;
        normal->x = 0;
        normal->y = 0x10000;
        normal->z = 0;
      }
      else {
        normal->x = tempVecY.x;
        normal->y = tempVecY.y;
        normal->z = tempVecY.z;
        if (tempVecY.y < 0x8000) {
          wheelsInAir_n = 4;
        }
      }
      if ((newtonObj->orientationToGround).y < -0xe666) {
        iVar20 = (newtonObj->angularVel).x * 0xfd;
        if (iVar20 < 0) {
          iVar20 = iVar20 + 0xff;
        }
        (newtonObj->angularVel).x = iVar20 >> 8;
        iVar20 = (newtonObj->angularVel).y * 0xfd;
        if (iVar20 < 0) {
          iVar20 = iVar20 + 0xff;
        }
        (newtonObj->angularVel).y = iVar20 >> 8;
        iVar20 = (newtonObj->angularVel).z * 0xfd;
        if (iVar20 < 0) {
          iVar20 = iVar20 + 0xff;
        }
        (newtonObj->angularVel).z = iVar20 >> 8;
      }
      else if (wheelsInAir_n < 4) {
        iVar20 = fixedmult((newtonObj->angularVel).x,(newtonObj->orientMat).m[0]);
        iVar24 = fixedmult((newtonObj->angularVel).y,(newtonObj->orientMat).m[1]);
        iVar3 = fixedmult((newtonObj->angularVel).z,(newtonObj->orientMat).m[2]);
        ti4 = (newtonObj->angularVel).x;
        iVar5 = (newtonObj->orientMat).m[3];
        newtonObj[1].shadowMat.m[8] = iVar20 + iVar24 + iVar3;
        iVar20 = fixedmult(ti4,iVar5);
        iVar24 = fixedmult((newtonObj->angularVel).y,(newtonObj->orientMat).m[4]);
        iVar3 = fixedmult((newtonObj->angularVel).z,(newtonObj->orientMat).m[5]);
        ti4 = (newtonObj->angularVel).x;
        iVar5 = (newtonObj->orientMat).m[6];
        newtonObj[1].shadowCoord[0].x = iVar20 + iVar24 + iVar3;
        iVar20 = fixedmult(ti4,iVar5);
        iVar24 = fixedmult((newtonObj->angularVel).y,(newtonObj->orientMat).m[7]);
        iVar3 = fixedmult((newtonObj->angularVel).z,(newtonObj->orientMat).m[8]);
        ti4 = (*(int *)&newtonObj[1].positionXZ + newtonObj[1].orientMat.m[2]) -
              (newtonObj[1].simRoadInfo.normal.y + newtonObj[1].cumulatedRot) >> 2;
        newtonObj[1].shadowCoord[0].y = iVar20 + iVar24 + iVar3;
        if (ti4 < 1) {
          iVar20 = -*(int *)(newtonObj[1].damage[3] + 0x13c);
          if (iVar20 < ti4) {
            iVar20 = ti4;
          }
        }
        else {
          iVar20 = *(int *)(newtonObj[1].damage[3] + 0x13c);
          if (ti4 <= iVar20) {
            iVar20 = ti4;
          }
        }
        iVar24 = (newtonObj[1].simRoadInfo.normal.y + *(int *)&newtonObj[1].positionXZ) -
                 (newtonObj[1].cumulatedRot + newtonObj[1].orientMat.m[2]) >> 2;
        if (iVar24 < 1) {
          iVar3 = -*(int *)(newtonObj[1].damage[3] + 0x140);
          if (iVar3 < iVar24) {
            iVar3 = iVar24;
          }
        }
        else {
          iVar3 = *(int *)(newtonObj[1].damage[3] + 0x140);
          if (iVar24 <= iVar3) {
            iVar3 = iVar24;
          }
        }
        ti4 = newtonObj[1].shadowMat.m[8];
        iVar24 = ti4;
        if (ti4 < 0) {
          iVar24 = -ti4;
        }
        iVar5 = 0xd999;
        if (iVar24 < 0x13333) {
          iVar5 = *(int *)(newtonObj[1].damage[3] + 0x130);
        }
        iVar24 = fixedmult(ti4,iVar5);
        newtonObj[1].shadowMat.m[8] = iVar24;
        iVar24 = newtonObj[1].shadowCoord[0].y;
        newtonObj[1].shadowMat.m[8] = newtonObj[1].shadowMat.m[8] + iVar20;
        iVar20 = iVar24;
        if (iVar24 < 0) {
          iVar20 = -iVar24;
        }
        ti4 = 0xd999;
        if (iVar20 < 0x13333) {
          ti4 = *(int *)(newtonObj[1].damage[3] + 0x134);
        }
        iVar20 = fixedmult(iVar24,ti4);
        newtonObj[1].shadowCoord[0].y = iVar20;
        newtonObj[1].shadowCoord[0].y = newtonObj[1].shadowCoord[0].y - iVar3;
        transpose(&newtonObj->orientMat,&transposeMat);
        iVar20 = fixedmult(newtonObj[1].shadowMat.m[8],transposeMat.m[0])
        ;
        iVar24 = fixedmult(newtonObj[1].shadowCoord[0].x,transposeMat.m[1]);
        iVar3 = fixedmult(newtonObj[1].shadowCoord[0].y,transposeMat.m[2]);
        ti4 = newtonObj[1].shadowMat.m[8];
        (newtonObj->angularVel).x = iVar20 + iVar24 + iVar3;
        iVar20 = fixedmult(ti4,transposeMat.m[3]);
        iVar24 = fixedmult(newtonObj[1].shadowCoord[0].x,transposeMat.m[4]);
        iVar3 = fixedmult(newtonObj[1].shadowCoord[0].y,transposeMat.m[5]);
        ti4 = newtonObj[1].shadowMat.m[8];
        (newtonObj->angularVel).y = iVar20 + iVar24 + iVar3;
        iVar20 = fixedmult(ti4,transposeMat.m[6]);
        iVar24 = fixedmult(newtonObj[1].shadowCoord[0].x,transposeMat.m[7]);
        iVar3 = fixedmult(newtonObj[1].shadowCoord[0].y,transposeMat.m[8]);
        (newtonObj->angularVel).z = iVar20 + iVar24 + iVar3;
      }
      if (simGlobal.gameTicks < 0x40) {
        tstr9 = (int)&newtonObj->roadCenterPoint;
      }
      else {
        tstr9 = (int)&elevation;
      }
      iVar20 = Newton_CalcPerpenHeightOfCenterPointFromGround(newtonObj,normal,(coorddef *)tstr9);
      newtonObj->objAltitude = iVar20;
      return elevation.y;
    }
    iVar3 = fixedmult(*(int *)((int)&tireCoord[0].y + iVar20) -
                       *(int *)((int)&wheelHeight[0].y + iVar20) >> 1,(newtonObj->orientMat).m[4]);
    if (iVar3 < 1) {
      ti4 = -*(int *)(newtonObj[1].damage[3] + 0x150);
      if (iVar3 < ti4) goto Newton_FindGE_minTangent;
    }
    else {
      ti4 = *(int *)(newtonObj[1].damage[3] + 0x150);
      if (ti4 <= iVar3) {
Newton_FindGE_minTangent:
        iVar3 = ti4;
      }
    }
    ti4 = *(int *)tpi11;
    tpi11 = tpi11 + 4;
    iVar20 = iVar20 + 0xc;
    iVar24 = iVar24 + 1;
    newtonObj[1].wheelRot[ti4 * 0xc + -0x17] = iVar3;
  } while( true );
}

/* ---- Newton_LimitCarsToDrivableDist__FP13BO_tNewtonObj  [NEWTON.CPP:1062-1068] SLD-VERIFIED ---- */
void Newton_LimitCarsToDrivableDist(BO_tNewtonObj *newtonObj)

{
  int iVar1;
  
  iVar1 = Physics_DoBarrierCheck((Car_tObj *)newtonObj);
  if (iVar1 != 0) {
    (newtonObj->collision).impulse = 0;
    (newtonObj->collision).otherObj = (BO_tNewtonObj *)0x0;
    Newton_FindClosestQuad(newtonObj);
    Newton_UpdateRoadGeometry(newtonObj);
  }
  return;
}

/* ---- Newton_CalcPerpenHeightOfLowestPointFromGround__FP13BO_tNewtonObjP8coorddefT1  [NEWTON.CPP:1079-1102] SLD-VERIFIED ---- */
int Newton_CalcPerpenHeightOfLowestPointFromGround(BO_tNewtonObj *newtonObj,coorddef *normal,coorddef *samplePoint)

{
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int relativeDot;
  int iVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  int iVar10;
  int iVar11;
  int iVar12;
  int zDir;
  int yDir;
  int xDir;
  coorddef basisDots;
  coorddef relativePos;
  
  relativeDot = normal->x;
  if (relativeDot < 0) {
    relativeDot = relativeDot + 0xff;
  }
  iVar1 = (newtonObj->orientMat).m[0];
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar6 = normal->y;
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar2 = (newtonObj->orientMat).m[1];
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar7 = normal->z;
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  iVar3 = (newtonObj->orientMat).m[2];
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar1 = (relativeDot >> 8) * (iVar1 >> 8) + (iVar6 >> 8) * (iVar2 >> 8) +
          (iVar7 >> 8) * (iVar3 >> 8);
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar6 = (newtonObj->dimension).x;
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar1 = (iVar1 >> 8) * (iVar6 >> 8);
  iVar6 = normal->x;
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar2 = (newtonObj->orientMat).m[3];
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar7 = normal->y;
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  iVar3 = (newtonObj->orientMat).m[4];
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar8 = normal->z;
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  iVar4 = (newtonObj->orientMat).m[5];
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar6 = (iVar6 >> 8) * (iVar2 >> 8) + (iVar7 >> 8) * (iVar3 >> 8) + (iVar8 >> 8) * (iVar4 >> 8);
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar2 = (newtonObj->dimension).y;
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar6 = (iVar6 >> 8) * (iVar2 >> 8);
  iVar2 = normal->x;
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar7 = (newtonObj->orientMat).m[6];
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  iVar3 = normal->y;
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar8 = (newtonObj->orientMat).m[7];
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  iVar4 = normal->z;
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar5 = (newtonObj->orientMat).m[8];
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  iVar2 = (iVar2 >> 8) * (iVar7 >> 8) + (iVar3 >> 8) * (iVar8 >> 8) + (iVar4 >> 8) * (iVar5 >> 8);
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar7 = (newtonObj->dimension).z;
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  iVar2 = (iVar2 >> 8) * (iVar7 >> 8);
  iVar7 = -1;
  if (iVar1 < 0) {
    iVar7 = 1;
  }
  iVar3 = -1;
  if (iVar6 < 0) {
    iVar3 = 1;
  }
  iVar8 = -1;
  if (iVar2 < 0) {
    iVar8 = 1;
  }
  iVar4 = (newtonObj->position).x - samplePoint->x;
  iVar5 = (newtonObj->position).y - samplePoint->y;
  iVar12 = (newtonObj->position).z - samplePoint->z;
  iVar9 = normal->x;
  if (iVar9 < 0) {
    iVar9 = iVar9 + 0xff;
  }
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar10 = normal->y;
  if (iVar10 < 0) {
    iVar10 = iVar10 + 0xff;
  }
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  iVar11 = normal->z;
  if (iVar11 < 0) {
    iVar11 = iVar11 + 0xff;
  }
  if (iVar12 < 0) {
    iVar12 = iVar12 + 0xff;
  }
  return iVar7 * iVar1 + iVar3 * iVar6 + iVar8 * iVar2 +
         (iVar9 >> 8) * (iVar4 >> 8) + (iVar10 >> 8) * (iVar5 >> 8) + (iVar11 >> 8) * (iVar12 >> 8);
}

/* ---- Newton_CalcPerpenHeightOfCenterPointFromGround__FP13BO_tNewtonObjP8coorddefT1  [NEWTON.CPP:1110-1118] SLD-VERIFIED ---- */
int Newton_CalcPerpenHeightOfCenterPointFromGround(BO_tNewtonObj *newtonObj,coorddef *normal,coorddef *samplePoint)

{
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int relativeDot;
  coorddef relativePos;
  
  iVar1 = (newtonObj->position).y;
  iVar4 = samplePoint->y;
  iVar2 = (newtonObj->position).z;
  iVar5 = samplePoint->z;
  iVar3 = fixedmult(normal->x,(newtonObj->position).x - samplePoint->x);
  iVar4 = fixedmult(normal->y,iVar1 - iVar4);
  iVar2 = fixedmult(normal->z,iVar2 - iVar5);
  iVar1 = (newtonObj->orientationToGround).y;
  if (iVar1 < 0) {
    iVar1 = -iVar1;
  }
  if (iVar1 < 0xb334) {
    iVar1 = (newtonObj->dimension).x;
  }
  else {
    iVar1 = (newtonObj->dimension).y;
  }
  return (iVar3 + iVar4 + iVar2) - iVar1;
}

/* ---- Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj  [NEWTON.CPP:1123-1215] SLD-VERIFIED ---- */
void Newton_CalcDistToClosestPlayerCar(BO_tNewtonObj *n)

{
  int x;
  static coorddef dummy;
  int dist;
  u_char bVar1;
  u_long uVar2;
  int z;
  int iVar3;
  int oldOptz;
  int iVar4;
  int iVar5;
  int iVar6;
  int whichPlayer;
  int forcedSimOptz;
  
  whichPlayer = 0;
  iVar4 = (n->position).x;
  iVar3 = (Cars_gHumanRaceCarList[GameSetup_gData.localCar]->N).position.x;
  oldOptz = iVar4 - iVar3;
  if (oldOptz < 1) {
    oldOptz = iVar3 - iVar4;
  }
  iVar5 = (n->position).z;
  iVar3 = (Cars_gHumanRaceCarList[GameSetup_gData.localCar]->N).position.z;
  iVar4 = iVar5 - iVar3;
  if (iVar4 < 1) {
    iVar4 = iVar3 - iVar5;
  }
  if (iVar4 < oldOptz) {
    iVar4 = oldOptz + (iVar4 >> 2);
  }
  else {
    iVar4 = iVar4 + (oldOptz >> 2);
  }
  n->distToPlayer = iVar4;
  if (Cars_gNumHumanRaceCars == 2) {
    iVar5 = (n->position).x;
    iVar3 = (Cars_gHumanRaceCarList[1 - GameSetup_gData.localCar]->N).position.x;
    iVar4 = iVar5 - iVar3;
    if (iVar4 < 1) {
      iVar4 = iVar3 - iVar5;
    }
    iVar6 = (n->position).z;
    iVar3 = (Cars_gHumanRaceCarList[1 - GameSetup_gData.localCar]->N).position.z;
    iVar5 = iVar6 - iVar3;
    if (iVar5 < 1) {
      iVar5 = iVar3 - iVar6;
    }
    if (iVar5 < iVar4) {
      iVar4 = iVar4 + (iVar5 >> 2);
    }
    else {
      iVar4 = iVar5 + (iVar4 >> 2);
    }
    if (iVar4 < n->distToPlayer) {
      whichPlayer = 1;
      n->distToPlayer = iVar4;
    }
  }
  if (n->distToPlayer < 0x600001) {
    iVar3 = BWorld_CheckChunkVisible(&(Cars_gHumanRaceCarList[whichPlayer]->N).simRoadInfo,&n->simRoadInfo);
    if ((n->distToPlayer < 0x600001) && (iVar3 != 0)) goto NewtonClosestPlr_simOptz;
  }
  if ((n[3].lastUpdated == 0) || (simGlobal.gameTicks < 3)) {
    if (n->simOptz != '\x02') {
      n->groundSurfaceType = 1;
      n->driveSurfaceType = 1;
    }
    n->simOptz = '\x02';
    (n->angularVel).x = 0;
    (n->angularVel).z = 0;
    return;
  }
NewtonClosestPlr_simOptz:
  bVar1 = n->simOptz;
  if (((n[1].simRoadInfo.quadPts[1].y & 0x30U) == 0) &&
     (((n[3].lastUpdated == 0 || (simGlobal.gameTicks < 3)) && (0x480000 < n->distToPlayer)))) {
    n->simOptz = '\x01';
  }
  else {
    n->simOptz = '\0';
  }
  if (1 < bVar1) {
    Cars_SetCarUpForHiRezSim((Car_tObj *)n);
    Newton_FindClosestQuad(n);
    Newton_UpdateRoadGeometry(n);
    Newton_LimitCarsToDrivableDist(n);
    if (stackSpeedUpEnbabledFlag == 0) {
      iVar3 = Newton_FindGroundElevationAndNormal(n,&dummy_124);
      n->groundElevation = iVar3;
    }
    else {
      gWSavePtr = SetSp(gWSavePtr);
      stackSpeedUpEnbabledFlag = 0;
      iVar3 = Newton_FindGroundElevationAndNormal(n,&dummy_124);
      uVar2 = gWSavePtr;
      n->groundElevation = iVar3;
      gWSavePtr = SetSp(uVar2);
      stackSpeedUpEnbabledFlag = 1;
    }
    iVar3 = n->groundElevation;
    iVar4 = (n->dimension).y;
    n->groundSurfaceType = 1;
    n->driveSurfaceType = 1;
    n->groundVel = 0;
    (n->collision).impulse = 0;
    (n->collision).otherObj = (BO_tNewtonObj *)0x0;
    n->objAltitude = 0;
    (n->position).y = iVar3 + iVar4;
  }
  return;
}

/* ---- Newton_UpdateRoadInfo__FP13BO_tNewtonObj  [NEWTON.CPP:1227-1261] SLD-VERIFIED ---- */
void Newton_UpdateRoadInfo(BO_tNewtonObj *n)

{
  u_int uVar1;
  Trk_NewSimQuad *pTVar2;
  
  if (n->active != '\0') {
    Newton_CalcDistToClosestPlayerCar(n);
    Newton_FindClosestQuad(n);
    if (*(signed char *)&(n->simRoadInfo).quadChanged != '\0') {
      Newton_UpdateRoadGeometry(n);
    }
    if (n->simOptz == '\0') {
      pTVar2 = (n->simRoadInfo).simQuad;
      uVar1 = 0xe;
      if (pTVar2 != (Trk_NewSimQuad *)0x0) {
        uVar1 = (u_int)pTVar2->surface;
      }
      n->groundSurfaceType = uVar1;
      n->driveSurfaceType = uVar1 & 0xf;
    }
  }
  return;
}

/* ---- Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji  [NEWTON.CPP:1264-1281] SLD-VERIFIED ---- */
void Newton_CopyRoadMatrixToOrientMat(BO_tNewtonObj *n,int backwards)

{
  matrixtdef *pmVar1;
  matrixtdef *road;
  matrixtdef *ori;
  matrixtdef *pmVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  
  if (backwards == 0) {
    pmVar2 = &n->orientMat;
    pmVar1 = &n->roadMatrix;
    do {
      iVar3 = pmVar1->m[1];
      iVar4 = pmVar1->m[2];
      iVar5 = pmVar1->m[3];
      pmVar2->m[0] = pmVar1->m[0];
      pmVar2->m[1] = iVar3;
      pmVar2->m[2] = iVar4;
      pmVar2->m[3] = iVar5;
      pmVar1 = (matrixtdef *)(pmVar1->m + 4);
      pmVar2 = (matrixtdef *)(pmVar2->m + 4);
    } while (pmVar1 != (matrixtdef *)((n->roadMatrix).m + 8));
    pmVar2->m[0] = pmVar1->m[0];
    return;
  }
  (n->orientMat).m[0] = -(n->roadMatrix).m[0];
  (n->orientMat).m[1] = -(n->roadMatrix).m[1];
  (n->orientMat).m[2] = -(n->roadMatrix).m[2];
  (n->orientMat).m[3] = (n->roadMatrix).m[3];
  (n->orientMat).m[4] = (n->roadMatrix).m[4];
  (n->orientMat).m[5] = (n->roadMatrix).m[5];
  (n->orientMat).m[6] = -(n->roadMatrix).m[6];
  (n->orientMat).m[7] = -(n->roadMatrix).m[7];
  (n->orientMat).m[8] = -(n->roadMatrix).m[8];
  return;
}

/* ---- Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji  [NEWTON.CPP:1285-1302] SLD-VERIFIED ---- */
void Newton_CopyRoadMatrixToShadowMat(BO_tNewtonObj *n,int backwards)

{
  matrixtdef *pmVar1;
  matrixtdef *road;
  matrixtdef *shad;
  matrixtdef *pmVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  
  if (backwards == 0) {
    pmVar2 = &n->shadowMat;
    pmVar1 = &n->roadMatrix;
    do {
      iVar3 = pmVar1->m[1];
      iVar4 = pmVar1->m[2];
      iVar5 = pmVar1->m[3];
      pmVar2->m[0] = pmVar1->m[0];
      pmVar2->m[1] = iVar3;
      pmVar2->m[2] = iVar4;
      pmVar2->m[3] = iVar5;
      pmVar1 = (matrixtdef *)(pmVar1->m + 4);
      pmVar2 = (matrixtdef *)(pmVar2->m + 4);
    } while (pmVar1 != (matrixtdef *)((n->roadMatrix).m + 8));
    pmVar2->m[0] = pmVar1->m[0];
    return;
  }
  (n->shadowMat).m[0] = -(n->roadMatrix).m[0];
  (n->shadowMat).m[1] = -(n->roadMatrix).m[1];
  (n->shadowMat).m[2] = -(n->roadMatrix).m[2];
  (n->shadowMat).m[3] = (n->roadMatrix).m[3];
  (n->shadowMat).m[4] = (n->roadMatrix).m[4];
  (n->shadowMat).m[5] = (n->roadMatrix).m[5];
  (n->shadowMat).m[6] = -(n->roadMatrix).m[6];
  (n->shadowMat).m[7] = -(n->roadMatrix).m[7];
  (n->shadowMat).m[8] = -(n->roadMatrix).m[8];
  return;
}

/* ---- Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi  [NEWTON.CPP:1307-1415] SLD-VERIFIED ---- */
void Newton_SetInitialSlicePositionOrientationEtc(BO_tNewtonObj *n,int slice,coorddef *offset,int direction)

{
  static coorddef dummy;
  u_char uVar1;
  u_long uVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  int iVar10;
  int iVar11;
  u_int uVar12;
  Trk_NewSimQuad *pTVar13;
  int quadCenterY;
  BO_tNewtonObj *pBVar14;
  int i;
  Trk_NewSlice *pTVar15;
  int backwards;
  u_int backwards_00;
  coorddef rOffset;
  matrixtdef transposeMat;
  coorddef temp;
  
  backwards_00 = (u_int)(direction != 1);
  BWorldSm_SetSlice(slice,&n->simRoadInfo);
  pTVar15 = BWorldSm_slices;
  n->totalSlice = (u_short)slice;
  (n->roadMatrix).m[0] = (int)pTVar15[slice].right[0] << 9;
  (n->roadMatrix).m[1] = (int)pTVar15[slice].right[1] << 9;
  (n->roadMatrix).m[2] = (int)pTVar15[slice].right[2] << 9;
  (n->roadMatrix).m[3] = (int)pTVar15[slice].normal[0] << 9;
  (n->roadMatrix).m[4] = (int)pTVar15[slice].normal[1] << 9;
  (n->roadMatrix).m[5] = (int)pTVar15[slice].normal[2] << 9;
  (n->roadMatrix).m[6] = (int)pTVar15[slice].forward[0] << 9;
  (n->roadMatrix).m[7] = (int)pTVar15[slice].forward[1] << 9;
  (n->roadMatrix).m[8] = (int)pTVar15[slice].forward[2] << 9;
  Math_NormalizeShortVector((coorddef *)&n->roadMatrix);
  Math_NormalizeShortVector((coorddef *)((n->roadMatrix).m + 3));
  Math_NormalizeShortVector((coorddef *)((n->roadMatrix).m + 6));
  transpose(&n->roadMatrix,&transposeMat);
  Newton_CopyRoadMatrixToOrientMat(n,backwards_00);
  Newton_CopyRoadMatrixToShadowMat(n,backwards_00);
  iVar3 = fixedmult(offset->x,transposeMat.m[0]);
  iVar4 = fixedmult(offset->y,transposeMat.m[1]);
  iVar5 = fixedmult(offset->z,transposeMat.m[2]);
  iVar6 = fixedmult(offset->x,transposeMat.m[3]);
  iVar7 = fixedmult(offset->y,transposeMat.m[4]);
  iVar8 = fixedmult(offset->z,transposeMat.m[5]);
  iVar9 = fixedmult(offset->x,transposeMat.m[6]);
  iVar10 = fixedmult(offset->y,transposeMat.m[7]);
  iVar11 = fixedmult(offset->z,transposeMat.m[8]);
  pTVar15 = BWorldSm_slices + slice;
  (n->position).x = iVar3 + iVar4 + iVar5 + pTVar15->center[0];
  (n->position).y = iVar6 + iVar7 + iVar8 + pTVar15->center[1];
  uVar12 = n[1].simRoadInfo.quadPts[1].y;
  (n->position).z = iVar9 + iVar10 + iVar11 + pTVar15->center[2];
  if ((uVar12 & 4) == 0) {
    n->simOptz = '\x02';
  }
  else {
    n->simOptz = '\0';
  }
  Newton_FindClosestQuad(n);
  Newton_UpdateRoadInfo(n);
  Newton_UpdateRoadGeometry(n);
  Newton_CopyRoadMatrixToOrientMat(n,backwards_00);
  Newton_CopyRoadMatrixToShadowMat(n,backwards_00);
  if (n->simOptz == '\x02') {
    n->groundElevation = BWorldSm_slices[slice].center[1];
  }
  else {
    iVar3 = 0;
    if (n->simOptz == '\x01') {
      pBVar14 = n;
      for (i = 0; i < 4; i = i + 1) {
        if ((n->simRoadInfo).simQuad == (Trk_NewSimQuad *)0x0) {
          temp.y = BWorldSm_slices[(n->simRoadInfo).slice].center[1];
        }
        else {
          temp.y = (pBVar14->simRoadInfo).quadPts[0].y;
        }
        pBVar14 = (BO_tNewtonObj *)&(pBVar14->simRoadInfo).simRotFlag;
        iVar3 = iVar3 + temp.y;
      }
      if (iVar3 < 0) {
        iVar3 = iVar3 + 3;
      }
      n->groundElevation = iVar3 >> 2;
    }
    else {
      if (stackSpeedUpEnbabledFlag == 0) {
        iVar3 = Newton_FindGroundElevationAndNormal(n,&dummy_133);
        n->groundElevation = iVar3;
      }
      else {
        gWSavePtr = SetSp(gWSavePtr);
        stackSpeedUpEnbabledFlag = 0;
        iVar3 = Newton_FindGroundElevationAndNormal(n,&dummy_133);
        uVar2 = gWSavePtr;
        n->groundElevation = iVar3;
        gWSavePtr = SetSp(uVar2);
        stackSpeedUpEnbabledFlag = 1;
      }
      (n->position).y = n->groundElevation + (n->dimension).y;
    }
  }
  iVar3 = Newton_CalcPerpenHeightOfLowestPointFromGround(n,(coorddef *)((n->roadMatrix).m + 3),&n->roadCenterPoint);
  iVar4 = (n->position).y;
  uVar1 = n->simOptz;
  n->objAltitude = iVar3;
  n->objAltitude = 0;
  (n->position).y = iVar4 - iVar3;
  if (uVar1 == '\0') {
    pTVar13 = (n->simRoadInfo).simQuad;
    iVar3 = 0xe;
    if (pTVar13 != (Trk_NewSimQuad *)0x0) {
      n->groundSurfaceType = (u_int)pTVar13->surface;
      goto NewtonSetInitSlice_setDriveSurf;
    }
  }
  else {
    iVar3 = 1;
  }
  n->groundSurfaceType = iVar3;
NewtonSetInitSlice_setDriveSurf:
  n->driveSurfaceType = n->groundSurfaceType & 0xf;
  return;
}

/* ---- Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii  [NEWTON.CPP:1420-1512] SLD-VERIFIED ---- */
void Newton_InitBaseNewtonObj(u_int *newtonObj,u_int index,int mass,u_int moInertia,int dimX,
               int dimY,int dimZ)

{
  int i;
  int iVar1;
  u_int *puVar2;
  int iVar3;
  
  *newtonObj = index;
  newtonObj[0x22] = 0;
  *(u_char *)(newtonObj + 0x24) = 0;
  newtonObj[0x28] = 0;
  newtonObj[0x29] = 0;
  newtonObj[0x2a] = 0;
  newtonObj[0x2b] = 0;
  newtonObj[0x2c] = 0;
  newtonObj[0x2d] = 0;
  newtonObj[0x2e] = mass;
  if (((GameSetup_gData.sgge & 2U) != 0) && ((newtonObj[0x98] & 4) != 0)) {
    newtonObj[0x2e] = mass * 5;
  }
  if ((newtonObj[0x98] & 0x20) != 0) {
    if ((GameSetup_gData.commMode == 1) &&
       ((Cars_gHumanRaceCarList[0]->carInfo->carType < 0x16 ||
        (Cars_gHumanRaceCarList[1]->carInfo->carType < 0x16)))) {
      newtonObj[0x2e] = newtonObj[0x2e] << 1;
    }
    else {
      newtonObj[0x2e] = (newtonObj[0x2e] * 3) / 2;
    }
  }
  iVar1 = fixeddiv(0x10000,newtonObj[0x2e]);
  newtonObj[0x2f] = iVar1;
  newtonObj[0x48] = newtonObj[0x2e] << 3;
  iVar1 = fixeddiv(0x10000,newtonObj[0x2e] << 3);
  newtonObj[0x49] = iVar1;
  newtonObj[0x45] = 0;
  newtonObj[0x46] = 0;
  newtonObj[0x47] = 0;
  newtonObj[0x4a] = 0;
  newtonObj[0x4b] = 0x10000;
  newtonObj[0x4c] = 0;
  newtonObj[0x4d] = dimX;
  newtonObj[0x4e] = dimY;
  newtonObj[0x4f] = dimZ;
  if (dimX < 0) {
    dimX = dimX + 0xff;
  }
  if (dimY < 0) {
    dimY = dimY + 0xff;
  }
  iVar1 = fixedsqrt((dimX >> 8) * (dimX >> 8) + (dimY >> 8) * (dimY >> 8));
  newtonObj[0x50] = iVar1;
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  if (dimZ < 0) {
    dimZ = dimZ + 0xff;
  }
  iVar1 = fixedsqrt((iVar1 >> 8) * (iVar1 >> 8) + (dimZ >> 8) * (dimZ >> 8));
  iVar3 = 9;
  puVar2 = newtonObj + 9;
  newtonObj[0x50] = iVar1;
  *(u_short *)(newtonObj + 0x5f) = 0;
  newtonObj[0x6f] = 1;
  newtonObj[0x70] = 1;
  newtonObj[0x61] = 0;
  newtonObj[0x62] = 0;
  newtonObj[0x25] = 0x10000;
  newtonObj[0x31] = 0;
  newtonObj[0x5d] = 0;
  newtonObj[99] = 0;
  newtonObj[100] = 0;
  newtonObj[0x65] = 0;
  newtonObj[0x66] = 0;
  newtonObj[0x67] = 0;
  newtonObj[0x6c] = 0;
  newtonObj[0x6d] = 0;
  newtonObj[0x6e] = 0;
  do {
    puVar2[0x86] = 0;
    iVar3 = iVar3 + -1;
    puVar2 = puVar2 + -1;
  } while (-1 < iVar3);
  *(u_char *)((int)newtonObj + 0x92) = 0;
  *(u_short *)((int)newtonObj + 0x17e) = 0;
  *(u_char *)((int)newtonObj + 0x91) = 1;
  newtonObj[0x26] = 0;
  return;
}

/* ---- Newton_QDUpdateVel__FP13BO_tNewtonObj  [NEWTON.CPP:1516-1558] SLD-VERIFIED ---- */
void Newton_QDUpdateVel(int newtonObj)

{
  int t1;
  int t2;
  int t3;
  int iVar1;
  int iVar2;
  int iVar3;
  
  if (*(char *)(newtonObj + 0x91) != '\0') {
    if ((GameSetup_gData.sgge & 4U) == 0) {
      *(int *)(newtonObj + 0xa0) = *(int *)(newtonObj + 0xa0) + (*(int *)(newtonObj + 0xac) >> 6);
      *(int *)(newtonObj + 0xa4) = *(int *)(newtonObj + 0xa4) + (*(int *)(newtonObj + 0xb0) >> 6);
      *(int *)(newtonObj + 0xa8) = *(int *)(newtonObj + 0xa8) + (*(int *)(newtonObj + 0xb4) >> 6);
    }
    else {
      iVar3 = *(int *)(newtonObj + 0xb0);
      iVar2 = *(int *)(newtonObj + 0xb4);
      iVar1 = fixedmult(*(int *)(newtonObj + 0xac) >> 6,0xcccc);
      iVar2 = fixedmult(iVar2 >> 6,0xcccc);
      *(int *)(newtonObj + 0xa0) = *(int *)(newtonObj + 0xa0) + iVar1;
      *(int *)(newtonObj + 0xa8) = *(int *)(newtonObj + 0xa8) + iVar2;
      *(int *)(newtonObj + 0xa4) = *(int *)(newtonObj + 0xa4) + (iVar3 >> 6);
    }
  }
  return;
}

/* ---- Newton_OptzRotxform__FP10matrixtdefiiiPiiT4  [NEWTON.CPP:1569-1617] SLD-VERIFIED ---- */
bool Newton_OptzRotxform(int *m,int ax,int ay,int az,u_int *reOrthoNeeded,
               u_int reOrthoLimit,int *cumulatedRot)

{
  matrixtdef mx;
  matrixtdef my;
  matrixtdef mz;
  matrixtdef mt;
  int changed;
  int absx;
  int absy;
  int absz;
  int *piVar1;
  int *piVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  bool bVar7;
  matrixtdef mStack_c0;
  int local_98 [8];
  u_int auStack_78 [2];
  matrixtdef mStack_70;
  matrixtdef local_48;
  
  piVar2 = local_98;
  iVar3 = ax;
  if (ax < 0) {
    iVar3 = -ax;
  }
  iVar4 = ay;
  if (ay < 0) {
    iVar4 = -ay;
  }
  iVar6 = az;
  if (az < 0) {
    iVar6 = -az;
  }
  *reOrthoNeeded = 0;
  *cumulatedRot = *cumulatedRot + iVar3 + iVar4 + iVar6;
  fixedxformy(piVar2,ay);
  bVar7 = 0x13 < iVar4;
  if (iVar3 < 0xe) {
    piVar1 = local_48.m;
    do {
      iVar3 = piVar2[1];
      iVar4 = piVar2[2];
      iVar5 = piVar2[3];
      *piVar1 = *piVar2;
      piVar1[1] = iVar3;
      piVar1[2] = iVar4;
      piVar1[3] = iVar5;
      piVar2 = piVar2 + 4;
      piVar1 = piVar1 + 4;
    } while (piVar2 != auStack_78);
    *piVar1 = *piVar2;
  }
  else {
    fixedxformx(&mStack_c0,ax);
    Math_fasttransmult(&mStack_c0,(matrixtdef *)piVar2,&local_48);
    bVar7 = true;
  }
  if (iVar6 < 0xe) {
    piVar2 = local_48.m;
    do {
      iVar3 = piVar2[1];
      iVar4 = piVar2[2];
      iVar6 = piVar2[3];
      *m = *piVar2;
      m[1] = iVar3;
      m[2] = iVar4;
      m[3] = iVar6;
      piVar2 = piVar2 + 4;
      m = m + 4;
    } while (piVar2 != local_48.m + 8);
    *m = *piVar2;
  }
  else {
    fixedxformz(&mStack_70,az);
    Math_fasttransmult(&local_48,&mStack_70,(matrixtdef *)m);
    bVar7 = true;
  }
  return bVar7;
}

/* ---- Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj  [NEWTON.CPP:1621-1667] SLD-VERIFIED ---- */
void Newton_QDUpdateRot64Hz(int newtonObj)

{
  matrixtdef m;
  int reOrthoNeeded;
  coorddef angularVel;
  char cVar1;
  int iVar2;
  matrixtdef *m1;
  matrixtdef mStack_50;
  int iStack_28;
  int iStack_24;
  int iStack_20;
  int aiStack_18 [2];
  
  if (*(char *)(newtonObj + 0x91) != '\0') {
    iStack_28 = *(int *)(newtonObj + 0x114);
    if (iStack_28 < 0) {
      iStack_28 = iStack_28 + 0x3f;
    }
    iStack_28 = iStack_28 >> 6;
    iStack_24 = *(int *)(newtonObj + 0x118);
    if (iStack_24 < 0) {
      iStack_24 = iStack_24 + 0x3f;
    }
    iStack_24 = iStack_24 >> 6;
    iStack_20 = *(int *)(newtonObj + 0x11c);
    if (iStack_20 < 0) {
      iStack_20 = iStack_20 + 0x3f;
    }
    iStack_20 = iStack_20 >> 6;
    iVar2 = Newton_OptzRotxform((int *)&mStack_50,iStack_28,iStack_24,iStack_20,aiStack_18,0x1000,newtonObj + 0x98);
    m1 = (matrixtdef *)(newtonObj + 0xf0);
    if (iVar2 != 0) {
      Math_fasttransmult(m1,&mStack_50,m1);
      cVar1 = *(char *)(newtonObj + 0x92) + -1;
      *(char *)(newtonObj + 0x92) = cVar1;
      if ((cVar1 == '\0') || (aiStack_18[0] != 0)) {
        reorthogonalize(m1);
        *(u_char *)(newtonObj + 0x92) = 0x20;
        *(u_int *)(newtonObj + 0x98) = 0;
      }
    }
  }
  return;
}

/* ---- Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj  [NEWTON.CPP:1670-1722] SLD-VERIFIED ---- */
void Newton_QDUpdateRot32Hz(int newtonObj)

{
  matrixtdef m;
  int reOrthoNeeded;
  coorddef angularVel;
  char cVar1;
  int iVar2;
  matrixtdef *m1;
  matrixtdef mStack_50;
  int iStack_28;
  int iStack_24;
  int iStack_20;
  int aiStack_18 [2];
  
  if ((*(char *)(newtonObj + 0x91) != '\0') && (*(char *)(newtonObj + 0x90) == '\0')) {
    iStack_28 = *(int *)(newtonObj + 0x114);
    if (iStack_28 < 0) {
      iStack_28 = iStack_28 + 0xf;
    }
    iStack_28 = iStack_28 >> 4;
    iStack_24 = *(int *)(newtonObj + 0x118);
    if (iStack_24 < 0) {
      iStack_24 = iStack_24 + 0xf;
    }
    iStack_24 = iStack_24 >> 4;
    iStack_20 = *(int *)(newtonObj + 0x11c);
    if (iStack_20 < 0) {
      iStack_20 = iStack_20 + 0xf;
    }
    iStack_20 = iStack_20 >> 4;
    iVar2 = Newton_OptzRotxform((int *)&mStack_50,iStack_28,iStack_24,iStack_20,aiStack_18,0x2000,newtonObj + 0x98);
    m1 = (matrixtdef *)(newtonObj + 0xf0);
    if ((iVar2 != 0) &&
       ((Math_fasttransmult(m1,&mStack_50,m1), aiStack_18[0] != 0 ||
        (cVar1 = *(char *)(newtonObj + 0x92) + -1, *(char *)(newtonObj + 0x92) = cVar1, cVar1 == '\0')))
       ) {
      reorthogonalize(m1);
      *(u_char *)(newtonObj + 0x92) = 0x40;
      *(u_int *)(newtonObj + 0x98) = 0;
    }
  }
  return;
}

/* ---- Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi  [NEWTON.CPP:1730-1807] SLD-VERIFIED ---- */
void Newton_CalculateGroundShadowMatrix(int newtonObj,int *normal,int orientToGround)

{
  int r1;
  int r2;
  int r3;
  u_int *puVar1;
  int iVar2;
  int iVar3;
  u_int *puVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  coorddef *v;
  u_int uVar9;
  u_int uVar10;
  u_int uVar11;
  
  if (((*(u_int *)(newtonObj + 0x260) & 4) == 0) &&
     (puVar4 = (u_int *)(newtonObj + 0x1c4), 0xe666 < orientToGround)) {
    puVar1 = (u_int *)(newtonObj + 0xf0);
    do {
      uVar9 = puVar1[1];
      uVar10 = puVar1[2];
      uVar11 = puVar1[3];
      *puVar4 = *puVar1;
      puVar4[1] = uVar9;
      puVar4[2] = uVar10;
      puVar4[3] = uVar11;
      puVar1 = puVar1 + 4;
      puVar4 = puVar4 + 4;
    } while (puVar1 != (u_int *)(newtonObj + 0x110));
    *puVar4 = *puVar1;
    iVar5 = normal[1];
    iVar8 = normal[2];
    *(int *)(newtonObj + 0x1d0) = *normal;
    *(int *)(newtonObj + 0x1d4) = iVar5;
    *(int *)(newtonObj + 0x1d8) = iVar8;
    return;
  }
  iVar5 = normal[1];
  iVar8 = normal[2];
  *(int *)(newtonObj + 0x1d0) = *normal;
  *(int *)(newtonObj + 0x1d4) = iVar5;
  *(int *)(newtonObj + 0x1d8) = iVar8;
  if (orientToGround < 0x8000) {
    iVar5 = *(int *)(newtonObj + 0xf0);
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    iVar8 = *normal;
    if (iVar8 < 0) {
      iVar8 = iVar8 + 0xff;
    }
    iVar6 = *(int *)(newtonObj + 0xf4);
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    iVar2 = normal[1];
    if (iVar2 < 0) {
      iVar2 = iVar2 + 0xff;
    }
    iVar7 = *(int *)(newtonObj + 0xf8);
    if (iVar7 < 0) {
      iVar7 = iVar7 + 0xff;
    }
    iVar3 = normal[2];
    iVar7 = iVar7 >> 8;
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xff;
    }
    iVar3 = iVar3 >> 8;
    iVar5 = (iVar5 >> 8) * (iVar8 >> 8) + (iVar6 >> 8) * (iVar2 >> 8) + iVar7 * iVar3;
    if (iVar5 < 0) {
      iVar5 = -iVar5;
    }
    if (0.5 < (double)iVar5) {
      iVar5 = fixedmult(*(int *)(newtonObj + 0x1d4),*(int *)(newtonObj + 0x110));
      iVar8 = fixedmult(*(int *)(newtonObj + 0x1d8),*(int *)(newtonObj + 0x10c));
      *(int *)(newtonObj + 0x1c4) = iVar5 - iVar8;
      iVar5 = fixedmult(*(int *)(newtonObj + 0x1d8),*(int *)(newtonObj + 0x108));
      iVar8 = fixedmult(*(int *)(newtonObj + 0x1d0),*(int *)(newtonObj + 0x110));
      *(int *)(newtonObj + 0x1c8) = iVar5 - iVar8;
      iVar5 = fixedmult(*(int *)(newtonObj + 0x1d0),*(int *)(newtonObj + 0x10c));
      iVar8 = fixedmult(*(int *)(newtonObj + 0x1d4),*(int *)(newtonObj + 0x108));
      *(int *)(newtonObj + 0x1cc) = iVar5 - iVar8;
      Math_NormalizeShortVector((coorddef *)(newtonObj + 0x1c4));
      iVar5 = fixedmult(*(int *)(newtonObj + 0x1c8),*(int *)(newtonObj + 0x1d8));
      iVar8 = fixedmult(*(int *)(newtonObj + 0x1cc),*(int *)(newtonObj + 0x1d4));
      *(int *)(newtonObj + 0x1dc) = iVar5 - iVar8;
      iVar5 = fixedmult(*(int *)(newtonObj + 0x1cc),*(int *)(newtonObj + 0x1d0));
      iVar8 = fixedmult(*(int *)(newtonObj + 0x1c4),*(int *)(newtonObj + 0x1d8));
      *(int *)(newtonObj + 0x1e0) = iVar5 - iVar8;
      iVar5 = fixedmult(*(int *)(newtonObj + 0x1c4),*(int *)(newtonObj + 0x1d4));
      iVar8 = fixedmult(*(int *)(newtonObj + 0x1c8),*(int *)(newtonObj + 0x1d0));
      v = (coorddef *)(newtonObj + 0x1dc);
      *(int *)(newtonObj + 0x1e4) = iVar5 - iVar8;
      goto NewtonGroundShadow_normalizeV;
    }
  }
  iVar5 = fixedmult(*(int *)(newtonObj + 0xf4),*(int *)(newtonObj + 0x1d8));
  iVar8 = fixedmult(*(int *)(newtonObj + 0xf8),*(int *)(newtonObj + 0x1d4));
  *(int *)(newtonObj + 0x1dc) = iVar5 - iVar8;
  iVar5 = fixedmult(*(int *)(newtonObj + 0xf8),*(int *)(newtonObj + 0x1d0));
  iVar8 = fixedmult(*(int *)(newtonObj + 0xf0),*(int *)(newtonObj + 0x1d8));
  *(int *)(newtonObj + 0x1e0) = iVar5 - iVar8;
  iVar5 = fixedmult(*(int *)(newtonObj + 0xf0),*(int *)(newtonObj + 0x1d4));
  iVar8 = fixedmult(*(int *)(newtonObj + 0xf4),*(int *)(newtonObj + 0x1d0));
  *(int *)(newtonObj + 0x1e4) = iVar5 - iVar8;
  Math_NormalizeShortVector((coorddef *)(newtonObj + 0x1dc));
  iVar5 = fixedmult(*(int *)(newtonObj + 0x1d4),*(int *)(newtonObj + 0x1e4));
  iVar8 = fixedmult(*(int *)(newtonObj + 0x1d8),*(int *)(newtonObj + 0x1e0));
  *(int *)(newtonObj + 0x1c4) = iVar5 - iVar8;
  iVar5 = fixedmult(*(int *)(newtonObj + 0x1d8),*(int *)(newtonObj + 0x1dc));
  iVar8 = fixedmult(*(int *)(newtonObj + 0x1d0),*(int *)(newtonObj + 0x1e4));
  *(int *)(newtonObj + 0x1c8) = iVar5 - iVar8;
  iVar5 = fixedmult(*(int *)(newtonObj + 0x1d0),*(int *)(newtonObj + 0x1e0));
  iVar8 = fixedmult(*(int *)(newtonObj + 0x1d4),*(int *)(newtonObj + 0x1dc));
  v = (coorddef *)(newtonObj + 0x1c4);
  *(int *)(newtonObj + 0x1cc) = iVar5 - iVar8;
NewtonGroundShadow_normalizeV:
  Math_NormalizeShortVector(v);
  return;
}

/* ---- Newton_CalcRealShadowCoordinates__FP8Car_tObji  [NEWTON.CPP:1830-1880] SLD-VERIFIED ---- */
void Newton_CalcRealShadowCoordinates(int carObj,int currentTick)

{
  coorddef lengthVector;
  coorddef widthVector;
  coorddef frontWidthVector;
  coorddef carGroundCoord;
  coorddef temp;
  coorddef vecOffset;
  int diff;
  coorddef dimension;
  int front;
  int i;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  int local_60;
  int local_5c;
  int local_58;
  int local_50;
  int local_4c;
  int local_48;
  
  iVar7 = *(int *)(carObj + 0x9c);
  iVar9 = *(int *)(carObj + 0x138);
  iVar1 = *(int *)(carObj + 0x134) + 0xccc;
  iVar8 = *(int *)(carObj + 0x13c) + 0xccc;
  iVar2 = fixedmult(iVar8,*(int *)(carObj + 0x108));
  iVar3 = fixedmult(iVar8,*(int *)(carObj + 0x10c));
  iVar8 = fixedmult(iVar8,*(int *)(carObj + 0x110));
  iVar4 = fixedmult(iVar1,*(int *)(carObj + 0xf0));
  iVar5 = fixedmult(iVar1,*(int *)(carObj + 0xf4));
  iVar6 = fixedmult(iVar1,*(int *)(carObj + 0xf8));
  local_60 = iVar4;
  local_5c = iVar5;
  local_58 = iVar6;
  if (*(short *)(carObj + 0x8bc) == 0x14) {
    iVar1 = iVar1 * 0xc0 >> 8;
    local_60 = fixedmult(iVar1,*(int *)(carObj + 0xf0));
    local_5c = fixedmult(iVar1,*(int *)(carObj + 0xf4));
    local_58 = fixedmult(iVar1,*(int *)(carObj + 0xf8));
  }
  if (*(int *)(carObj + 300) < 0xe667) {
    local_50 = *(int *)(carObj + 0xa0);
    local_48 = *(int *)(carObj + 0xa8);
    local_4c = *(int *)(carObj + 0x180);
  }
  else {
    local_50 = fixedmult(-*(int *)(carObj + 0x188) - iVar9,*(int *)(carObj + 0x150));
    local_4c = fixedmult(-*(int *)(carObj + 0x188) - iVar9,*(int *)(carObj + 0x154));
    local_48 = fixedmult(-*(int *)(carObj + 0x188) - iVar9,*(int *)(carObj + 0x158));
    local_50 = *(int *)(carObj + 0xa0) + local_50;
    local_4c = *(int *)(carObj + 0xa4) + local_4c;
    local_48 = *(int *)(carObj + 0xa8) + local_48;
  }
  *(int *)(carObj + 0x1e8) = (local_50 + iVar2) - local_60;
  *(int *)(carObj + 0x1ec) = (local_4c + iVar3) - local_5c;
  *(int *)(carObj + 0x1f0) = (local_48 + iVar8) - local_58;
  *(int *)(carObj + 500) = local_50 + iVar2 + local_60;
  *(int *)(carObj + 0x1f8) = local_4c + iVar3 + local_5c;
  *(int *)(carObj + 0x1fc) = local_48 + iVar8 + local_58;
  *(int *)(carObj + 0x200) = (local_50 - iVar2) - iVar4;
  *(int *)(carObj + 0x204) = (local_4c - iVar3) - iVar5;
  *(int *)(carObj + 0x208) = (local_48 - iVar8) - iVar6;
  iVar9 = 0;
  *(int *)(carObj + 0x20c) = (local_50 - iVar2) + iVar4;
  *(int *)(carObj + 0x210) = (local_4c - iVar3) + iVar5;
  *(int *)(carObj + 0x214) = (local_48 - iVar8) + iVar6;
  iVar1 = carObj;
  iVar2 = carObj;
  do {
    iVar8 = *(int *)(iVar2 + 0x290);
    *(int *)(iVar1 + 0x1ec) = iVar8;
    iVar3 = *(int *)(carObj + 0xb0);
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0x3f;
    }
    iVar2 = iVar2 + 0x30;
    iVar9 = iVar9 + 1;
    *(int *)(iVar1 + 0x1ec) = iVar8 + (iVar3 >> 6) * (currentTick - iVar7);
    iVar1 = iVar1 + 0xc;
  } while (iVar9 < 4);
  return;
}

/* ---- Newton_CheckForSpikeBelts__FP13BO_tNewtonObj  [NEWTON.CPP:1885-1916] SLD-VERIFIED ---- */
void Newton_CheckForSpikeBelts(int newtonObj)

{
  int slice;
  int leftLatPos;
  int rightLatPos;
  int latPos;
  int iVar1;
  
  if (AICop_spikeBelt.active_ != 0) {
    if ((((AICop_spikeBelt.active_ != 0) && (*(short *)(newtonObj + 8) == AICop_spikeBelt.slice_)) &&
        ((*(u_int *)(newtonObj + 0x260) & 0x230) == 0)) &&
       (((AICop_spikeBelt.leftLatPos_ < *(int *)(newtonObj + 0x574) &&
         (*(int *)(newtonObj + 0x574) < AICop_spikeBelt.rightLatPos_)) &&
        (iVar1 = *(int *)(newtonObj + 0x274) + 1, *(int *)(newtonObj + 0x274) = iVar1, iVar1 == 1)))) {
      *(u_int *)(newtonObj + 400) = 0xf0000;
      *(u_int *)(newtonObj + 0x198) = 0x50007;
      *(u_int *)(newtonObj + 0x1a0) = *(u_int *)(newtonObj + 0xa0);
      *(u_int *)(newtonObj + 0x1a4) = *(u_int *)(newtonObj + 0xa4);
      *(u_int *)(newtonObj + 0x1a8) = *(u_int *)(newtonObj + 0xa8);
    }
  }
  return;
}

/* ---- Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef  [NEWTON.CPP:1922-1956] SLD-VERIFIED ---- */
void Newton_DoPostBarrierCollisionHandling(Car_tObj *newtonObj,coorddef normal)

{
  coorddef barrierVec;
  int impactVel;
  int distRetreat;
  coorddef upVec;
  matrixtdef islandMatrix;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  matrixtdef local_38;
  
  iVar1 = normal.z;
  if (normal.z < 0) {
    iVar1 = normal.z + 0xff;
  }
  local_38.m[6] = (iVar1 >> 8) * -0x100;
  iVar1 = normal.x;
  if (normal.x < 0) {
    iVar1 = normal.x + 0xff;
  }
  local_38.m[8] = (iVar1 >> 8) << 8;
  iVar2 = normal.y;
  if (normal.y < 0) {
    iVar2 = normal.y + 0xff;
  }
  iVar3 = (newtonObj->N).linearVel.x;
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar4 = (newtonObj->N).linearVel.y;
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar6 = normal.z;
  if (normal.z < 0) {
    iVar6 = normal.z + 0xff;
  }
  iVar5 = (newtonObj->N).linearVel.z;
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  iVar1 = (iVar1 >> 8) * (iVar3 >> 8) + (iVar2 >> 8) * (iVar4 >> 8) + (iVar6 >> 8) * (iVar5 >> 8);
  if (iVar1 < 0) {
    iVar1 = -iVar1;
  }
  iVar1 = -iVar1;
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xf;
  }
  iVar2 = -0x7ae;
  if (iVar1 >> 4 < -0x7ad) {
    iVar2 = iVar1 >> 4;
  }
  local_38.m[3] = 0;
  local_38.m[4] = 0x10000;
  local_38.m[5] = 0;
  local_38.m[7] = 0;
  local_38.m[0] = normal.x;
  local_38.m[1] = normal.y;
  local_38.m[2] = normal.z;
  iVar1 = Physics_AttenuateVelocity(newtonObj,iVar2,&local_38);
  Physics_SetCurrentWallType(4);
  Physics_CorrectPostCollisionYaw(newtonObj,iVar1,normal);
  return;
}

/* ---- Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos  [NEWTON.CPP:2107-2140] SLD-VERIFIED ---- */
void Newton_GenerateVector(int type,int *vector,int testSimRoadInfo)

{
  coorddef fwdVec;
  coorddef upVec;
  coorddef result;
  int iVar1;
  int iVar2;
  coorddef local_40;
  int local_30;
  int local_2c;
  int local_28;
  int local_20;
  int local_1c;
  
  local_2c = 0x10000;
  local_28 = 0;
  local_30 = 0;
  local_40.y = 0;
  if (type == 1) {
    local_40.z = *(int *)(testSimRoadInfo + 0x34) - *(int *)(testSimRoadInfo + 0x28);
    local_40.x = *(int *)(testSimRoadInfo + 0x2c) - *(int *)(testSimRoadInfo + 0x20);
  }
  else if (type == 4) {
    local_40.z = *(int *)(testSimRoadInfo + 0x28) - *(int *)(testSimRoadInfo + 0x1c);
    local_40.x = *(int *)(testSimRoadInfo + 0x20) - *(int *)(testSimRoadInfo + 0x14);
  }
  else if (type == 2) {
    local_40.z = *(int *)(testSimRoadInfo + 0x1c) - *(int *)(testSimRoadInfo + 0x10);
    local_40.x = *(int *)(testSimRoadInfo + 0x14) - *(int *)(testSimRoadInfo + 8);
  }
  else if (type == 8) {
    local_40.z = *(int *)(testSimRoadInfo + 0x10) - *(int *)(testSimRoadInfo + 0x34);
    local_40.x = *(int *)(testSimRoadInfo + 8) - *(int *)(testSimRoadInfo + 0x2c);
  }
  Math_NormalizeShortVector(&local_40);
  iVar1 = fixedmult(local_40.y,local_28);
  local_20 = fixedmult(local_40.z,local_2c);
  local_20 = iVar1 - local_20;
  iVar1 = fixedmult(local_40.z,local_30);
  local_1c = fixedmult(local_40.x,local_28);
  local_1c = iVar1 - local_1c;
  iVar1 = fixedmult(local_40.x,local_2c);
  iVar2 = fixedmult(local_40.y,local_30);
  *vector = local_20;
  vector[1] = local_1c;
  vector[2] = iVar1 - iVar2;
  return;
}

/* ---- Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi  [NEWTON.CPP:2144-2157] SLD-VERIFIED ---- */
u_int
Netwon_CheckForBadQuad(int newtonObj,int testSimRoadInfo,int wheel)

{
  int bad;
  int height;
  u_int uVar1;
  
  uVar1 = 0;
  if (((*(u_char **)(testSimRoadInfo + 0x78) != (u_char *)0x0) && ((**(u_char **)(testSimRoadInfo + 0x78) & 0xf) == 0)) ||
     (newtonObj = newtonObj + wheel * 0x30,
     0x20000 < *(int *)(newtonObj + 0x2a4) - *(int *)(newtonObj + 0x290))) {
    uVar1 = 1;
  }
  return uVar1;
}

/* ---- Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj  [NEWTON.CPP:2161-2361] SLD-VERIFIED ---- */
void Newton_TestForUndrivableSurfaces(BO_tNewtonObj *newtonObj)

{
  int impulse;
  int i;
  int collision_type;
  int newHeight;
  coorddef normal;
  coorddef cautionaryCenter;
  coorddef undrivableCenter;
  coorddef speedVec;
  coorddef testPoint;
  coorddef newTestPoint;
  int check;
  int j;
  coorddef temp;
  int zone;
  short sVar1;
  short sVar2;
  u_short uVar3;
  BWorldSm_Pos *pBVar4;
  u_int uVar5;
  u_int uVar6;
  Trk_NewSlice *pTVar7;
  BWorldSm_Pos *pBVar8;
  coorddef *pcVar9;
  int iVar10;
  int iVar11;
  int iVar12;
  BO_tNewtonObj *pBVar13;
  int iVar14;
  coorddef local_a0;
  int local_90;
  int local_8c;
  int local_88;
  int local_80;
  int local_7c;
  int local_78;
  int local_70;
  int local_6c;
  int local_68;
  coorddef local_60;
  coorddef local_50;
  int local_40;
  int local_3c;
  int local_38;
  u_int local_30;
  int local_2c;
  
  iVar14 = 0;
  local_30 = 0;
  local_90 = (newtonObj->roadCenterPoint).x;
  local_8c = (newtonObj->roadCenterPoint).y;
  local_88 = (newtonObj->roadCenterPoint).z;
  memset((u_char *)&local_70,'\0',0xc);
  pBVar4 = &testSimRoadInfo;
  pBVar8 = &newtonObj->simRoadInfo;
  do {
    sVar1 = pBVar8->stripQuadInd;
    sVar2 = pBVar8->simRotFlag;
    uVar3 = *(u_short *)((char *)(pBVar8) + 0x6);
    iVar10 = pBVar8->quadPts[0].x;
    iVar12 = pBVar8->quadPts[0].y;
    pBVar4->slice = pBVar8->slice;
    pBVar4->stripQuadInd = sVar1;
    pBVar4->simRotFlag = sVar2;
    *(u_short *)((char *)(pBVar4) + 0x6) = uVar3;
    pBVar4->quadPts[0].x = iVar10;
    pBVar4->quadPts[0].y = iVar12;
    pBVar8 = (BWorldSm_Pos *)&pBVar8->quadPts[0].z;
    pBVar4 = (BWorldSm_Pos *)&pBVar4->quadPts[0].z;
  } while (pBVar8 != (BWorldSm_Pos *)&(newtonObj->simRoadInfo).simSlice);
  *(int *)pBVar4 = *(int *)pBVar8;
  if (0x280000 < newtonObj->speedXZ) {
    local_70 = (newtonObj->linearVel).x * 5;
    if (local_70 < 0) {
      local_70 = local_70 + 0xff;
    }
    local_70 = local_70 >> 8;
    local_6c = (newtonObj->linearVel).y * 5;
    if (local_6c < 0) {
      local_6c = local_6c + 0xff;
    }
    local_6c = local_6c >> 8;
    local_68 = (newtonObj->linearVel).z * 5;
    if (local_68 < 0) {
      local_68 = local_68 + 0xff;
    }
    local_68 = local_68 >> 8;
  }
  iVar10 = 0;
  local_2c = 0;
  pBVar13 = newtonObj;
  do {
    if (3 < iVar10) {
      return;
    }
    local_60.x = *(int *)&pBVar13[1].simRoadInfo.quadPts16[1].z + local_70;
    local_60.y = *(int *)(pBVar13[1].simRoadInfo.quadPts16 + 2) + local_6c;
    local_60.z = *(int *)&pBVar13[1].simRoadInfo.quadPts16[2].z + local_68;
    BWorldSm_FindClosestQuadRez(&local_60,&testSimRoadInfo,1)
    ;
    if (testSimRoadInfo.offEdge == 0) {
      iVar12 = Netwon_CheckForBadQuad(newtonObj,&testSimRoadInfo,iVar10);
      if (iVar12 != 0) {
        pBVar8 = &newtestSimRoadInfo;
        pBVar4 = &testSimRoadInfo;
        do {
          sVar1 = pBVar4->stripQuadInd;
          sVar2 = pBVar4->simRotFlag;
          uVar3 = *(u_short *)((char *)(pBVar4) + 0x6);
          iVar14 = pBVar4->quadPts[0].x;
          iVar12 = pBVar4->quadPts[0].y;
          pBVar8->slice = pBVar4->slice;
          pBVar8->stripQuadInd = sVar1;
          pBVar8->simRotFlag = sVar2;
          *(u_short *)((char *)(pBVar8) + 0x6) = uVar3;
          pBVar8->quadPts[0].x = iVar14;
          pBVar8->quadPts[0].y = iVar12;
          pBVar4 = (BWorldSm_Pos *)&pBVar4->quadPts[0].z;
          pBVar8 = (BWorldSm_Pos *)&pBVar8->quadPts[0].z;
        } while (pBVar4 != (BWorldSm_Pos *)&testSimRoadInfo.simSlice);
        *(Trk_NewSimSlice **)pBVar8 = testSimRoadInfo.simSlice;
        local_50.x = local_60.x;
        local_50.y = local_60.y;
        local_50.z = local_60.z;
        uVar5 = BWorldSm_FindEdgeOff(&local_60,&newtonObj->simRoadInfo,&testSimRoadInfo,&local_30);
        uVar6 = 1;
        iVar14 = 2;
        if (uVar5 == 1) {
NewtonTestUndrv_genVecRay1:
          Newton_GenerateVector(uVar6,(int *)&local_a0,(int)&newtonObj->simRoadInfo);
        }
        else {
          if (uVar5 == 2) {
            uVar6 = 2;
            goto NewtonTestUndrv_genVecRay1;
          }
          uVar6 = 4;
          if ((uVar5 == 4) || (uVar6 = 8, uVar5 == 8)) goto NewtonTestUndrv_genVecRay1;
        }
        if ((uVar5 & 3) != 0) {
          uVar6 = 1;
          if (((uVar5 & 1) != 0) || (uVar6 = 2, (uVar5 & 2) != 0)) {
            Newton_GenerateVector(uVar6,(int *)&local_a0,(int)&newtonObj->simRoadInfo);
          }
          local_50.x = local_50.x + local_a0.x;
          local_50.y = local_50.y + local_a0.y;
          local_50.z = local_50.z + local_a0.z;
          BWorldSm_FindClosestQuadRez(&local_50,&newtestSimRoadInfo,1);
          iVar12 = Netwon_CheckForBadQuad(newtonObj,&newtestSimRoadInfo,iVar10);
          if (iVar12 != 0) {
            if ((uVar5 & 0xc) == 0) {
              pcVar9 = testSimRoadInfo.quadPts;
              local_78 = 0;
              local_7c = 0;
              local_80 = 0;
              for (iVar12 = 0; iVar12 < 4; iVar12 = iVar12 + 1) {
                if (testSimRoadInfo.simQuad == (Trk_NewSimQuad *)0x0) {
                  pTVar7 = BWorldSm_slices + testSimRoadInfo.slice;
                  local_40 = pTVar7->center[0];
                  local_3c = pTVar7->center[1];
                  local_38 = pTVar7->center[2];
                }
                else {
                  local_40 = pcVar9->x;
                  local_3c = pcVar9->y;
                  local_38 = pcVar9->z;
                }
                pcVar9 = pcVar9 + 1;
                local_80 = local_80 + local_40;
                local_7c = local_7c + local_3c;
                local_78 = local_78 + local_38;
              }
              if (local_80 < 0) {
                local_80 = local_80 + 3;
              }
              local_80 = local_80 >> 2;
              if (local_7c < 0) {
                local_7c = local_7c + 3;
              }
              local_7c = local_7c >> 2;
              if (local_78 < 0) {
                local_78 = local_78 + 3;
              }
              local_78 = local_78 >> 2;
              local_a0.x = (newtonObj->position).x - local_80;
              local_a0.z = (newtonObj->position).z - local_78;
            }
            else {
              uVar6 = 4;
              if (((uVar5 & 4) != 0) || (uVar6 = 8, (uVar5 & 8) != 0)) {
                Newton_GenerateVector(uVar6,(int *)&local_a0,(int)&newtonObj->simRoadInfo);
              }
              pBVar8 = &newtestSimRoadInfo;
              pBVar4 = &testSimRoadInfo;
              do {
                sVar1 = pBVar4->stripQuadInd;
                sVar2 = pBVar4->simRotFlag;
                uVar3 = *(u_short *)((char *)(pBVar4) + 0x6);
                iVar12 = pBVar4->quadPts[0].x;
                iVar11 = pBVar4->quadPts[0].y;
                pBVar8->slice = pBVar4->slice;
                pBVar8->stripQuadInd = sVar1;
                pBVar8->simRotFlag = sVar2;
                *(u_short *)((char *)(pBVar8) + 0x6) = uVar3;
                pBVar8->quadPts[0].x = iVar12;
                pBVar8->quadPts[0].y = iVar11;
                pBVar4 = (BWorldSm_Pos *)&pBVar4->quadPts[0].z;
                pBVar8 = (BWorldSm_Pos *)&pBVar8->quadPts[0].z;
              } while (pBVar4 != (BWorldSm_Pos *)&testSimRoadInfo.simSlice);
              *(Trk_NewSimSlice **)pBVar8 = testSimRoadInfo.simSlice;
              local_50.x = local_60.x + local_a0.x;
              local_50.y = local_60.y + local_a0.y;
              local_50.z = local_60.z + local_a0.z;
              BWorldSm_FindClosestQuadRez(&local_50,&newtestSimRoadInfo,1);
              iVar12 = Netwon_CheckForBadQuad(newtonObj,&newtestSimRoadInfo,iVar10);
              iVar11 = 0;
              if (iVar12 != 0) {
                pcVar9 = testSimRoadInfo.quadPts;
                local_78 = 0;
                local_7c = 0;
                local_80 = 0;
                for (; iVar11 < 4; iVar11 = iVar11 + 1) {
                  if (testSimRoadInfo.simQuad == (Trk_NewSimQuad *)0x0) {
                    pTVar7 = BWorldSm_slices + testSimRoadInfo.slice;
                    local_40 = pTVar7->center[0];
                    local_3c = pTVar7->center[1];
                    local_38 = pTVar7->center[2];
                  }
                  else {
                    local_40 = pcVar9->x;
                    local_3c = pcVar9->y;
                    local_38 = pcVar9->z;
                  }
                  pcVar9 = pcVar9 + 1;
                  local_80 = local_80 + local_40;
                  local_7c = local_7c + local_3c;
                  local_78 = local_78 + local_38;
                }
                if (local_80 < 0) {
                  local_80 = local_80 + 3;
                }
                local_80 = local_80 >> 2;
                if (local_7c < 0) {
                  local_7c = local_7c + 3;
                }
                local_7c = local_7c >> 2;
                if (local_78 < 0) {
                  local_78 = local_78 + 3;
                }
                local_78 = local_78 >> 2;
                local_a0.x = local_90 - local_80;
                local_a0.z = local_88 - local_78;
              }
            }
          }
        }
        local_a0.y = 0;
        Math_NormalizeShortVector(&local_a0);
      }
    }
    else {
      Newton_GenerateVector((int)testSimRoadInfo.offEdge,(int *)&local_a0,(int)&newtonObj->simRoadInfo);
      local_a0.y = 0;
      Math_NormalizeShortVector(&local_a0);
      iVar14 = 1;
    }
    if (iVar14 != 0) {
      Newton_DoPostBarrierCollisionHandling((Car_tObj *)newtonObj,local_a0);
      iVar12 = *(int *)(pBVar13[1].simRoadInfo.quadPts16 + 2);
      iVar14 = *(int *)&pBVar13[1].simRoadInfo.quadPts16[2].z;
      (newtonObj->collision).collisionPoint.x = *(int *)&pBVar13[1].simRoadInfo.quadPts16[1].z;
      (newtonObj->collision).collisionPoint.y = iVar12;
      (newtonObj->collision).collisionPoint.z = iVar14;
      AIPhysic_ProcessBarrierCollision((Car_tObj *)newtonObj);
      if ((newtonObj[1].simRoadInfo.quadPts[1].y & 4U) != 0) {
        Physics_FixEngineRpm((Car_tObj *)newtonObj);
      }
      iVar14 = (newtonObj->collision).impulse;
      if (iVar14 < 0xa0001) {
        return;
      }
      iVar12 = 6;
      if ((iVar10 != 2) && (iVar12 = local_2c, iVar10 == 3)) {
        iVar12 = 4;
      }
      Newton_AddDamageZone(newtonObj,iVar14,iVar12,1);
      return;
    }
    pBVar13 = (BO_tNewtonObj *)&(pBVar13->simRoadInfo).quadPts[2].z;
    iVar10 = iVar10 + 1;
    local_2c = local_2c + 2;
  } while( true );
}

/* ---- Newton_LimitAngularVelocity__FP13BO_tNewtonObj  [NEWTON.CPP:2440-2456] SLD-VERIFIED ---- */
void Newton_LimitAngularVelocity(int newtonObj)

{
  u_int uVar1;
  
  uVar1 = 0x18000;
  if ((0x18000 < *(int *)(newtonObj + 0x114)) ||
     (uVar1 = 0xfffe8000, *(int *)(newtonObj + 0x114) < -0x18000)) {
    *(u_int *)(newtonObj + 0x114) = uVar1;
  }
  uVar1 = 0x18000;
  if ((0x18000 < *(int *)(newtonObj + 0x118)) ||
     (uVar1 = 0xfffe8000, *(int *)(newtonObj + 0x118) < -0x18000)) {
    *(u_int *)(newtonObj + 0x118) = uVar1;
  }
  uVar1 = 0x18000;
  if ((0x18000 < *(int *)(newtonObj + 0x11c)) ||
     (uVar1 = 0xfffe8000, *(int *)(newtonObj + 0x11c) < -0x18000)) {
    *(u_int *)(newtonObj + 0x11c) = uVar1;
  }
  return;
}

/* ---- Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj  [NEWTON.CPP:2466-2733] SLD-VERIFIED ---- */
void Newton_ApplyTheLawOfGravity(Car_tObj *newtonObj)

{
  int objAltitude;
  int groundVel;
  coorddef collisionPoint;
  int elevationOfGround;
  int relativeClosingVelocity;
  coorddef normal;
  coorddef shadowNormal;
  int timeCount;
  int elapsedTime;
  int iTimeCount;
  int modifiedGravity;
  int bounceVel;
  int k;
  int scale;
  int iVar1;
  int iVar2;
  void *pvVar3;
  u_int uVar4;
  int iVar5;
  Car_tObj *pCVar6;
  int iVar7;
  int iVar8;
  coorddef cStack_60;
  int iStack_50;
  int iStack_4c;
  int iStack_48;
  coorddef cStack_40;
  int iStack_30;
  int iStack_2c;
  u_char auStack_28 [8];
  
  if (((newtonObj->N).active != '\0') &&
     (iVar1 = Sched_ExecuteCheck(1,3,(newtonObj->N).distToPlayer,(newtonObj->N).objID,&iStack_30,&iStack_2c,
                         auStack_28,newtonObj->forceNoSimOptz), iVar1 != 0)) {
    if ((newtonObj->N).simOptz < 2) {
      iVar1 = Newton_FindGroundElevationAndNormal(&newtonObj->N,&cStack_60);
      iStack_50 = cStack_60.x;
      iStack_4c = cStack_60.y;
      iStack_48 = cStack_60.z;
      iVar7 = (newtonObj->N).groundElevation;
      (newtonObj->N).groundElevation = iVar1;
      iVar1 = (iVar1 - iVar7) * iStack_30;
      iVar8 = (newtonObj->N).objAltitude;
      iVar7 = fixedmult(iStack_2c * 0x4800,(newtonObj->N).gravityMult);
      iVar5 = (newtonObj->N).orientMat.m[3];
      (newtonObj->N).linearVel.y = (newtonObj->N).linearVel.y - iVar7;
      iVar7 = fixedmult(iVar5,cStack_60.x);
      iVar5 = fixedmult((newtonObj->N).orientMat.m[4],cStack_60.y);
      iVar2 = fixedmult((newtonObj->N).orientMat.m[5],cStack_60.z);
      (newtonObj->N).orientationToGround.y = iVar7 + iVar5 + iVar2;
      Newton_CalculateGroundShadowMatrix((int)newtonObj,(int *)&iStack_50,(newtonObj->N).orientationToGround.y);
      iVar7 = (newtonObj->N).linearVel.x;
      iVar5 = (newtonObj->N).linearVel.z;
      if (iVar7 < 0) {
        iVar7 = -iVar7;
      }
      if (iVar5 < 0) {
        iVar5 = -iVar5;
      }
      iVar7 = Math_BetterDist(iVar7,iVar5);
      (newtonObj->N).speedXZ = iVar7;
      iVar7 = (newtonObj->N).roadGravityModifier * 7 + (iVar1 - (newtonObj->N).groundVel);
      if (iVar7 < 0) {
        iVar7 = iVar7 + 7;
      }
      (newtonObj->N).roadGravityModifier = iVar7 >> 3;
      (newtonObj->N).groundVel = iVar1;
      if (iVar8 < 0x3333) {
        if ((newtonObj->N).flightTime == 0) {
          Newton_CheckForSpikeBelts(newtonObj);
        }
        else {
          if ((newtonObj->carFlags & 4U) != 0) {
            Physics_FixEngineRpm(newtonObj);
          }
          iVar5 = (newtonObj->N).linearVel.y;
          iVar7 = 0;
          if ((newtonObj->N).orientationToGround.y < 0xb334) {
            cStack_40.x = (newtonObj->N).roadCenterPoint.x;
            cStack_40.z = (newtonObj->N).roadCenterPoint.z;
            cStack_40.y = (newtonObj->N).roadCenterPoint.y + -0x1999;
            Collide_TestWithPlane(&newtonObj->N,&cStack_60,&cStack_40);
            iVar7 = (newtonObj->N).collision.impulse;
            if (0x50000 < iVar7) {
              iVar5 = 0x140000;
              if (0x13ffff < iVar7) {
                iVar5 = iVar7;
              }
              (newtonObj->N).collision.impulse = iVar5;
            }
            if ((newtonObj->N).orientationToGround.y < 0x3333) {
              (newtonObj->collision).smoking = 1;
            }
          }
          else {
            iVar2 = 0;
            pCVar6 = newtonObj;
            do {
              iVar2 = iVar2 + 1;
              iVar7 = iVar7 + pCVar6->wheel[0].wheelAcc;
              pCVar6 = (Car_tObj *)&(pCVar6->N).simRoadInfo.quadPts[2].z;
            } while (iVar2 < 4);
            if (0 < iVar7) {
              iVar7 = iVar7 * 3;
              if (iVar7 < 0) {
                iVar7 = iVar7 + 3;
              }
              iVar2 = (newtonObj->N).position.y;
              (newtonObj->N).linearVel.y = iVar1 + (iVar7 >> 2);
              iVar7 = (iVar1 - iVar5) * 2;
              (newtonObj->N).collision.impulse = iVar7;
              (newtonObj->N).flightTime = 0;
              iVar2 = iVar2 - iVar8;
              iVar8 = 0xccc;
              (newtonObj->N).position.y = iVar2;
              (newtonObj->N).objAltitude = 0xccc;
              if (0x140000 < iVar7) {
                (newtonObj->N).collision.sfxType = 0x10000;
                (newtonObj->N).collision.otherObj = (BO_tNewtonObj *)0x0;
                iVar7 = (newtonObj->N).position.y;
                iVar5 = (newtonObj->N).position.z;
                (newtonObj->N).collision.collisionPoint.x = (newtonObj->N).position.x;
                (newtonObj->N).collision.collisionPoint.y = iVar7;
                (newtonObj->N).collision.collisionPoint.z = iVar5;
                Newton_AddDamageZone(&newtonObj->N,(newtonObj->N).collision.impulse,9,0);
              }
              iVar7 = Force_IsForceOn(newtonObj);
              if (iVar7 != 0) {
                Force_HitWall((newtonObj->N).collision.impulse);
              }
            }
          }
          Newton_LimitAngularVelocity(newtonObj);
        }
        if (iVar8 < 0xa3d) {
          iVar7 = (newtonObj->N).position.y;
          uVar4 = newtonObj->carFlags;
          (newtonObj->N).objAltitude = 0;
          (newtonObj->N).position.y = iVar7 - iVar8;
          if (((uVar4 & 0x400) == 0) && (0xe666 < (newtonObj->N).orientationToGround.y)) {
            (newtonObj->N).flightTime = 0;
          }
          if (0x5ffff < iVar1) {
            iVar7 = 0xffdf;
            if (0xc0000 < iVar1) {
              iVar7 = 0xffbe;
            }
            iVar5 = fixedmult((newtonObj->N).linearVel.x,iVar7);
            iVar2 = (newtonObj->N).linearVel.z;
            (newtonObj->N).linearVel.x = iVar5;
            iVar7 = fixedmult(iVar2,iVar7);
            (newtonObj->N).linearVel.z = iVar7;
          }
          iVar7 = (newtonObj->N).speedXZ;
          if (iVar7 < 0x50000) {
            if (iVar1 < 0) {
              iVar1 = iVar1 + 3;
            }
            (newtonObj->N).linearVel.y = iVar1 >> 2;
          }
          else if (iVar7 < 0xa0000) {
            (newtonObj->N).linearVel.y = iVar1 / 2;
          }
          else {
            (newtonObj->N).linearVel.y = iVar1;
          }
        }
      }
      else {
        (newtonObj->N).roadGravityModifier = 0;
        (newtonObj->N).flightTime = (newtonObj->N).flightTime + (short)iStack_2c;
        iVar1 = fixedmult(iStack_2c * 0x4800,(newtonObj->N).gravityMult);
        (newtonObj->N).linearVel.y = (newtonObj->N).linearVel.y - iVar1;
      }
      (newtonObj->N).lastUpdated = simGlobal.gameTicks;
      pvVar3 = BWorldSm_TunnelFlagSm(&(newtonObj->N).simRoadInfo);
      if (((pvVar3 != (void *)0x0) && (iVar1 = (newtonObj->N).linearVel.y, 0 < iVar1)) &&
         (0x80000 < (newtonObj->N).position.y - (newtonObj->N).roadCenterPoint.y)) {
        (newtonObj->N).linearVel.y = -iVar1;
      }
    }
    else {
      (newtonObj->N).linearVel.y = 0;
      (newtonObj->N).flightTime = 0;
      iVar1 = Newton_FindGroundElevationAndNormalFast(newtonObj,&cStack_60);
      (newtonObj->N).position.y = iVar1 + (newtonObj->N).dimension.y;
    }
  }
  return;
}

/* ---- Newton_CalculateRoadPositionFromSliceAndPosition__FiP8coorddefP10matrixtdef  [NEWTON.CPP:2736-2745] SLD-VERIFIED ---- */
int Newton_CalculateRoadPositionFromSliceAndPosition(int slice,coorddef *position,matrixtdef *matrix)

{
  int iVar1;
  Trk_NewSlice *pTVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  coorddef centerBack;
  coorddef carRelative;
  
  pTVar2 = BWorldSm_slices + slice;
  iVar6 = position->x - pTVar2->center[0];
  iVar7 = position->y - pTVar2->center[1];
  iVar1 = position->z - pTVar2->center[2];
  iVar3 = matrix->m[0];
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar4 = matrix->m[1];
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  iVar5 = matrix->m[2];
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  return (iVar3 >> 8) * (iVar6 >> 8) + (iVar4 >> 8) * (iVar7 >> 8) + (iVar5 >> 8) * (iVar1 >> 8);
}

/* ---- Newton_CalculateRoadPosition__FP13BO_tNewtonObj  [NEWTON.CPP:2762-2773] SLD-VERIFIED ---- */
int Newton_CalculateRoadPosition(BO_tNewtonObj *newtonObj)

{
  int ratio;
  Trk_NewSlice *pTVar1;
  int z;
  int iVar2;
  int oldOptz;
  int iVar3;
  int iVar4;
  int desiredCompression;
  int iVar5;
  int whichPlayer;
  int iVar6;
  int index;
  int iVar7;
  int v1;
  int zDir;
  int yDir;
  int xDir;
  int roll;
  int pitch;
  int forcedSimOptz;
  int r6;
  int r4;
  int bounce;
  int xMult;
  int wheelsInAir;
  coorddef tireCoord [4];
  coorddef carNormal;
  coorddef wheelHeight [4];
  coorddef vecOffset;
  BWorldSm_Pos testSimRoadInfo;
  coorddef tempVecX;
  coorddef tempVecY;
  int compressionValue [4];
  coorddef tempVecZ;
  coorddef centerBack;
  coorddef carRelative;
  coorddef carPos;
  
  pTVar1 = BWorldSm_slices + *(short *)((int)newtonObj + 8);
  iVar7 = *(int *)((int)newtonObj + 0xa0) - pTVar1->center[0];
  iVar3 = *(int *)((int)newtonObj + 0xa4) - pTVar1->center[1];
  iVar5 = *(int *)((int)newtonObj + 0xa8) - pTVar1->center[2];
  iVar6 = *(int *)((int)newtonObj + 0x144);
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  iVar2 = *(int *)((int)newtonObj + 0x148);
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar4 = *(int *)((int)newtonObj + 0x14c);
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  return (iVar6 >> 8) * (iVar7 >> 8) + (iVar2 >> 8) * (iVar3 >> 8) + (iVar4 >> 8) * (iVar5 >> 8);
}

/* end of newton.cpp */
