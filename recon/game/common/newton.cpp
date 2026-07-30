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

static inline int Newton_GetSpikeBelt(int *slice,int *leftLatPos,int *rightLatPos)
{
  int active;

  active = AICop_spikeBelt.active_;
  if (active != 0) {
    *slice = AICop_spikeBelt.slice_;
    *leftLatPos = AICop_spikeBelt.leftLatPos_;
    *rightLatPos = AICop_spikeBelt.rightLatPos_;
  }
  return active;
}

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Newton_AddDamageZone(BO_tNewtonObj *newtonObj,int impulse,int zone,int type);
void Newton_FindClosestQuad(BO_tNewtonObj *n);
int Newton_CalculateSliceYaw(int slice);
void Newton_UpdateRoadGeometry(BO_tNewtonObj *n);
int Newton_FindGroundElevationGeneral(coorddef *point,coorddef *normal,coorddef *pointOnQuad);
int Newton_FindGroundElevationRough(coorddef *point,coorddef *normal,coorddef *pointOnQuad);
extern "C" int Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef(int newtonObj,coorddef *normal);
int Newton_FindGroundElevationAndNormal(BO_tNewtonObj *newtonObj,coorddef *normal);
void Newton_LimitCarsToDrivableDist(BO_tNewtonObj *newtonObj);
int Newton_CalcPerpenHeightOfLowestPointFromGround(BO_tNewtonObj *newtonObj,coorddef *normal,coorddef *samplePoint);
int Newton_CalcPerpenHeightOfCenterPointFromGround(BO_tNewtonObj *newtonObj,coorddef *normal,coorddef *samplePoint);
void Newton_CalcDistToClosestPlayerCar(BO_tNewtonObj *n);
void Newton_UpdateRoadInfo(BO_tNewtonObj *n);
void Newton_CopyRoadMatrixToOrientMat(BO_tNewtonObj *n,int backwards);
void Newton_CopyRoadMatrixToShadowMat(BO_tNewtonObj *n,int backwards);
void Newton_SetInitialSlicePositionOrientationEtc(BO_tNewtonObj *n,int slice,coorddef *offset,int direction);
extern "C" void Newton_QDUpdateVel__FP13BO_tNewtonObj(int newtonObj);
extern "C" void Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj(int newtonObj);
extern "C" void Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj(int newtonObj);
extern "C" void Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi(int newtonObj,int *normal,int orientToGround);
extern "C" void Newton_CalcRealShadowCoordinates__FP8Car_tObji(Car_tObj *carObj,int currentTick);
extern "C" void Newton_CheckForSpikeBelts__FP13BO_tNewtonObj(BO_tNewtonObj *newtonObj);
extern "C" void Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef(BO_tNewtonObj *newtonObj,coorddef normal);
extern "C" void Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos(int type,coorddef *vector,BWorldSm_Pos *testSimRoadInfo);
void Newton_TestForUndrivableSurfaces(BO_tNewtonObj *newtonObj);
extern "C" void Newton_LimitAngularVelocity__FP13BO_tNewtonObj(int newtonObj);
extern "C" void Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj(Car_tObj *newtonObj);
int Newton_CalculateRoadPositionFromSliceAndPosition(int slice,coorddef *position,matrixtdef *matrix);
int Newton_CalculateRoadPosition(BO_tNewtonObj *newtonObj);


/* ---- Newton_AddDamageZone__FP13BO_tNewtonObjiii  [NEWTON.CPP:50-216] SLD-VERIFIED ---- */
void Newton_AddDamageZone(BO_tNewtonObj *newtonObj,int impulse,int zone,int type)

{
  int temp;
  int iVar2;
  void *pvVar3;
  u_int uVar4;
  u_int uVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  u_int uVar10;
  u_int uVar11;
  u_int uVar12;
  
  if (Force_IsForceOn((Car_tObj *)newtonObj) != 0) {
    Force_HitWall((newtonObj->collision).impulse);
  }
  if (GameSetup_gData.Damage != 0) {
    int iVar1;

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
        int temp;

        temp = (newtonObj->damage[0] + newtonObj->damage[2]) / 2;
        if (temp < newtonObj->damage[1]) {
          temp = newtonObj->damage[1];
        }
        newtonObj->damage[1] = temp;
        temp = (newtonObj->damage[0] + newtonObj->damage[6]) / 2;
        if (temp < newtonObj->damage[7]) {
          temp = newtonObj->damage[7];
        }
        newtonObj->damage[7] = temp;
      }
      else if (zone == 1) {
        int temp;

        temp = (newtonObj->damage[7] + newtonObj->damage[1]) / 2;
        if (temp < newtonObj->damage[0]) {
          temp = newtonObj->damage[0];
        }
        newtonObj->damage[0] = temp;
        temp = (newtonObj->damage[1] + newtonObj->damage[3]) / 2;
        if (temp < newtonObj->damage[2]) {
          temp = newtonObj->damage[2];
        }
        newtonObj->damage[2] = temp;
      }
      else if (zone == 6) {
        int temp;

        temp = (newtonObj->damage[4] + newtonObj->damage[6]) / 2;
        if (temp < newtonObj->damage[5]) {
          temp = newtonObj->damage[5];
        }
        newtonObj->damage[5] = temp;
        temp = (newtonObj->damage[0] + newtonObj->damage[6]) / 2;
        if (temp < newtonObj->damage[7]) {
          temp = newtonObj->damage[7];
        }
        newtonObj->damage[7] = temp;
      }
      else if (zone == 7) {
        int temp;

        temp = (newtonObj->damage[7] + newtonObj->damage[1]) / 2;
        if (temp < newtonObj->damage[0]) {
          temp = newtonObj->damage[0];
        }
        newtonObj->damage[0] = temp;
        temp = (newtonObj->damage[5] + newtonObj->damage[7]) / 2;
        if (temp < newtonObj->damage[6]) {
          temp = newtonObj->damage[6];
        }
        newtonObj->damage[6] = temp;
      }
      else {
        int temp;

        temp = (iVar1 + newtonObj->damage[zone + 2]) / 2;
        if (temp < newtonObj->damage[zone + 1]) {
          temp = newtonObj->damage[zone + 1];
        }
        newtonObj->damage[zone + 1] = temp;
        temp = (newtonObj->damage[zone] + newtonObj->damage[zone - 2]) / 2;
        if (temp < newtonObj->damage[zone - 1]) {
          temp = newtonObj->damage[zone - 1];
        }
        newtonObj->damage[zone - 1] = temp;
      }
    }
  }
Newton_AddDmgZ_typeSet:
  if (type != 0) {
    int iVar1;
    int intensity;
    int xMult;
    int yMult;
    int zMult;
    matrixtdef transposeMat;

    xMult = 0x20000;
    yMult = 0;
    zMult = 0x20000;
    if (impulse < 0x5a0001) {
      if (impulse < 0) {
        impulse = impulse + 0x3f;
      }
      intensity = impulse >> 6;
      if (0x8000 < intensity) {
        intensity = 0x8000;
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
      intensity = iVar2;
      if (iVar2 < 0) {
        intensity = iVar2 + 0x1f;
      }
      intensity = intensity >> 5;
      if (0x9999 < intensity) {
        intensity = 0x9999;
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
        yMult = uVar4 * 3;
        uVar5 = (uVar11 & 0xffff00) >> 8;
        zMult = uVar5 * 3;
        fastRandom = randtemp & 0xffff;
        xMult = uVar10 * 4;
        if ((randtemp & 0xffff00) >> 8 < 0x3333) {
          intensity = -intensity;
        }
        if (xMult + yMult + zMult < 0x40000) {
          if (xMult < 0x10000) {
            xMult = uVar10 << 3;
          }
          if (yMult < 0x10000) {
            yMult = uVar4 * 6;
          }
          if (zMult < 0x10000) {
            zMult = uVar5 * 6;
          }
        }
      }
      if (type == 2) {
        xMult = xMult << 1;
        yMult = yMult << 1;
        zMult = zMult << 1;
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
      iVar2 = fixedmult(intensity,xMult);
      iVar2 = newtonObj[1].shadowMat.m[8] - iVar2 / 2;
    }
    else {
      iVar2 = fixedmult(intensity,xMult);
      iVar2 = newtonObj[1].shadowMat.m[8] + iVar2 / 2;
    }
    newtonObj[1].shadowMat.m[8] = iVar2;
    if (zone - 2U < 3) {
      iVar2 = fixedmult(intensity,yMult);
      newtonObj[1].shadowCoord[0].x = newtonObj[1].shadowCoord[0].x + iVar2 / 2;
      iVar1 = fixedmult(intensity,zMult);
      iVar1 = newtonObj[1].shadowCoord[0].y + iVar1 / 2;
    }
    else {
      iVar2 = fixedmult(intensity,yMult);
      newtonObj[1].shadowCoord[0].x = newtonObj[1].shadowCoord[0].x - iVar2 / 2;
      iVar1 = fixedmult(intensity,zMult);
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
  int s;
  int x1;
  int z1;
  int x2;
  int z2;

  s = slice + 1 >= gNumSlices ?
      slice + 1 - gNumSlices : slice + 1;
  x1 = BWorldSm_slices[slice].center[0];
  z1 = BWorldSm_slices[slice].center[2];
  x2 = BWorldSm_slices[s].center[0];
  z2 = BWorldSm_slices[s].center[2];
  x1 = x2 - x1;
  z1 = z2 - z1;
  return intatan(x1,z1);
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
  if (0x9eb8 < normal->y) {
    int index;

    index = (0x10000 - normal->y) >> 9;
    result = fixedmult(
                 -((normal->x / 256) * ((point->x - pointOnQuad->x) / 256)) -
                  (normal->z / 256) * ((point->z - pointOnQuad->z) / 256),
                 divTable[index]) +
             pointOnQuad->y;
  } else {
    result = fixeddiv(
                 -((normal->x / 256) * ((point->x - pointOnQuad->x) / 256)) -
                  (normal->z / 256) * ((point->z - pointOnQuad->z) / 256),
                 normal->y) +
             pointOnQuad->y;
  }
  return result;
}

/* ---- Newton_FindGroundElevationRough__FP8coorddefN20  [NEWTON.CPP:475-506] SLD-VERIFIED ---- */
int Newton_FindGroundElevationRough(coorddef *point,coorddef *normal,coorddef *pointOnQuad)

{
  int result;
  int fudgeIndex;
  int fudgeHeight;
  int fudgeDist;
  int numerator;

  fudgeHeight = 0;
  numerator =
      -((normal->x / 256) * ((point->x - pointOnQuad->x) / 256)) -
       (normal->z / 256) * ((point->z - pointOnQuad->z) / 256);
  {
    int i;
    i = 0;
    do {
      if (i == 0) {
        fudgeDist =
            (__builtin_abs(point->x) > __builtin_abs(point->z >> 1))
                ? __builtin_abs(point->x) +
                      (__builtin_abs(point->z >> 1) >> 2)
                : __builtin_abs(point->z >> 1) +
                      (__builtin_abs(point->x) >> 2);
      }
      else {
        fudgeDist =
            (__builtin_abs(point->x >> 2) > __builtin_abs(point->z))
                ? __builtin_abs(point->x >> 2) +
                      (__builtin_abs(point->z) >> 2)
                : __builtin_abs(point->z) +
                      (__builtin_abs(point->x >> 2) >> 2);
      }
      fudgeIndex = fudgeDist >> 15;
      fudgeDist = __builtin_abs(fudgeIndex);
      fudgeIndex = fudgeDist % 32;
      fudgeHeight += fudgeTable[fudgeIndex] << 7;
      i++;
    } while (i < 2);
  }
  if (0x9eb8 < normal->y) {
    int index = (0x10000 - normal->y) >> 9;
    result = fixedmult(numerator,divTable[index]) +
             pointOnQuad->y + fudgeHeight;
  }
  else {
    result = fixeddiv(numerator,normal->y) +
             pointOnQuad->y + fudgeHeight;
  }
  return result;
}

/* ---- Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef  [NEWTON.CPP:515-599] SLD-VERIFIED ---- */
extern "C" int Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef(int newtonObj,coorddef *normal)

{
  int elevation;

  {
    int r1;
    int r2;
    int r3;

    r2 = *(int *)(newtonObj + 0x154);
    r1 = *(int *)(newtonObj + 0x150);
    r3 = *(int *)(newtonObj + 0x158);
    normal->y = r2;
    normal->x = r1;
    normal->z = r3;
    if (0x199a <= r2) {
      int surfaceType;
      elevation = Newton_FindGroundElevationGeneral(
          (coorddef *)(newtonObj + 0xa0),normal,
          (coorddef *)(newtonObj + 0x168));
      surfaceType = 0;
      {
        int r2;
        int r3;
        int r4;

        r2 = *(int *)(newtonObj + 0xa0);
        r3 = *(int *)(newtonObj + 0xa8);
        r4 = elevation;
    *(u_int *)(newtonObj + 0x2ac) = 0;
    *(u_int *)(newtonObj + 0x2dc) = 0;
    *(u_int *)(newtonObj + 0x30c) = 0;
    *(u_int *)(newtonObj + 0x33c) = 0;
    *(u_int *)(newtonObj + 0x2b0) = 0;
    *(u_int *)(newtonObj + 0x2e0) = 0;
    *(u_int *)(newtonObj + 0x310) = 0;
    *(u_int *)(newtonObj + 0x340) = 0;
        *(int *)(newtonObj + 0x290) = r4;
        *(int *)(newtonObj + 0x2c0) = r4;
        *(int *)(newtonObj + 0x2f0) = r4;
        *(int *)(newtonObj + 800) = r4;
        *(int *)(newtonObj + 0x2a4) = r4;
        *(int *)(newtonObj + 0x2d4) = r4;
        *(int *)(newtonObj + 0x304) = r4;
        *(int *)(newtonObj + 0x334) = r4;
        *(int *)(newtonObj + 0x28c) = r2;
        *(int *)(newtonObj + 700) = r2;
        *(int *)(newtonObj + 0x2ec) = r2;
        *(int *)(newtonObj + 0x31c) = r2;
        *(int *)(newtonObj + 0x294) = r3;
        *(int *)(newtonObj + 0x2c4) = r3;
        *(int *)(newtonObj + 0x2f4) = r3;
        *(int *)(newtonObj + 0x324) = r3;
        r2 = normal->x;
        r3 = normal->y;
        r4 = normal->z;
    *(u_int *)(newtonObj + 0x2b8) = 1;
    *(u_int *)(newtonObj + 0x2e8) = 1;
    *(u_int *)(newtonObj + 0x318) = 1;
    *(u_int *)(newtonObj + 0x348) = 1;
        *(int *)(newtonObj + 0x298) = r2;
        *(int *)(newtonObj + 0x2c8) = r2;
        *(int *)(newtonObj + 0x2f8) = r2;
        *(int *)(newtonObj + 0x328) = r2;
        *(int *)(newtonObj + 0x29c) = r3;
        *(int *)(newtonObj + 0x2cc) = r3;
        *(int *)(newtonObj + 0x2fc) = r3;
        *(int *)(newtonObj + 0x32c) = r3;
        *(int *)(newtonObj + 0x2a0) = r4;
        *(int *)(newtonObj + 0x2d0) = r4;
        *(int *)(newtonObj + 0x300) = r4;
        *(int *)(newtonObj + 0x330) = r4;
      }
      (void)surfaceType;
    }
    else {
      elevation = -0x7d000000;
    }
  }
  return elevation;
}

/* ---- Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef  [NEWTON.CPP:610-1057] SLD-VERIFIED ---- */
int Newton_FindGroundElevationAndNormal(BO_tNewtonObj *newtonObj,coorddef *normal)

{
  int r2;
  int r3;
  int r4;
  int v1;
  int r1;
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
  int iVar20;
  u_int tu21;
  int rightGroundY;
  u_int uVar1;
  u_int uVar2;
  int iVar3;
  BO_tNewtonObj *pBVar4;
  int iVar5;
  int tstr9;
  coorddef *point;
  int iVar24;
  int rearGroundY;
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
  int wheel_idx;
  int ti17;
  int wheelsInAir;
  int ti15;
  int ti18;
  int ti16;
  coorddef elevation;
  coorddef tireCoord [4];
  coorddef carNormal;
  
  carNormal.x = (newtonObj->orientMat).m[3];
  carNormal.y = (newtonObj->orientMat).m[4];
  carNormal.z = (newtonObj->orientMat).m[5];
  elevation.x = 0;
  elevation.y = 0;
  elevation.z = 0;
  {
    coorddef lengthVector;
    coorddef widthVector;
    coorddef carGroundCoord;
    coorddef vecOffset;
    int length = (newtonObj->dimension).z * 0xd >> 0xc;
    int width = (newtonObj->dimension).x * 7 >> 0xb;
    int height = -(newtonObj->dimension).y >> 8;

    lengthVector.x = length * ((newtonObj->orientMat).m[6] >> 8);
    lengthVector.y = length * ((newtonObj->orientMat).m[7] >> 8);
    lengthVector.z = length * ((newtonObj->orientMat).m[8] >> 8);
    widthVector.x = width * ((newtonObj->orientMat).m[0] >> 8);
    widthVector.y = width * ((newtonObj->orientMat).m[1] >> 8);
    widthVector.z = width * ((newtonObj->orientMat).m[2] >> 8);
    vecOffset.x = height * (carNormal.x >> 8);
    vecOffset.y = height * (carNormal.y >> 8);
    vecOffset.z = height * (carNormal.z >> 8);
    carGroundCoord.x = (newtonObj->position).x + vecOffset.x;
    carGroundCoord.y = (newtonObj->position).y + vecOffset.y;
    carGroundCoord.z = (newtonObj->position).z + vecOffset.z;

    tireCoord[0].x = carGroundCoord.x + lengthVector.x - widthVector.x;
    tireCoord[0].y = carGroundCoord.y + lengthVector.y - widthVector.y;
    tireCoord[0].z = carGroundCoord.z + lengthVector.z - widthVector.z;
    tireCoord[1].x = carGroundCoord.x + lengthVector.x + widthVector.x;
    tireCoord[1].y = carGroundCoord.y + lengthVector.y + widthVector.y;
    tireCoord[1].z = carGroundCoord.z + lengthVector.z + widthVector.z;
    tireCoord[2].x = carGroundCoord.x - lengthVector.x - widthVector.x;
    tireCoord[2].y = carGroundCoord.y - lengthVector.y - widthVector.y;
    tireCoord[2].z = carGroundCoord.z - lengthVector.z - widthVector.z;
    tireCoord[3].x = carGroundCoord.x - lengthVector.x + widthVector.x;
    tireCoord[3].y = carGroundCoord.y - lengthVector.y + widthVector.y;
    tireCoord[3].z = carGroundCoord.z - lengthVector.z + widthVector.z;
  }
  coorddef wheelHeight [4];
  BWorldSm_Pos testSimRoadInfo;

  wheelsInAir = 0;
  bounce = 0;
  testSimRoadInfo = newtonObj->simRoadInfo;
  tpi12 = (int)wheelHeight;
  pt = (int)tireCoord;
  coorddef roadNormal;
  coorddef roadCenterPoint;
  int roadSurfaceType;

  for (wheelInst_p = (int)newtonObj; wheelInst_p < (int)&newtonObj->speedXZ;
      wheelInst_p = wheelInst_p + 0x30) {
    *(coorddef *)tpi12 = *(coorddef *)pt;
    *(u_int *)(wheelInst_p + 0x2a4) = *(u_int *)(pt + 4);
    BWorldSm_FindClosestTriangleRez((coorddef *)pt,&testSimRoadInfo,1);
    roadNormal = *(coorddef *)BWorldSm_UNormal(&testSimRoadInfo);
    roadSurfaceType = 0xe;
    if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0x0) {
      roadSurfaceType = (u_int)(testSimRoadInfo.simQuad)->surface;
    }
    *(u_int *)(wheelInst_p + 0x2b8) = roadSurfaceType;
    roadSurfaceType = roadSurfaceType & 0xf;
    if (((roadNormal.y < 0x1999) || (roadSurfaceType == 0xe)) || (roadSurfaceType == 0)) {
      roadNormal.y = 0x10000;
      roadNormal.x = 0;
      roadNormal.z = 0;
      elevation.x = elevation.x + *(int *)pt;
      iVar20 = *(int *)(pt + 4) - newtonObj->objAltitude;
accumGroundElev: /* @0x800a0398 */
      elevation.y = elevation.y + iVar20;
      elevation.z = elevation.z + *(int *)(pt + 8);
    }
    else {
      if (testSimRoadInfo.simQuad == (Trk_NewSimQuad *)0x0) {
        tpi4 = (int)(BWorldSm_slices + testSimRoadInfo.slice);
        roadCenterPoint = *(coorddef *)tpi4;
      }
      else {
        roadCenterPoint = testSimRoadInfo.quadPts[0];
      }
      if ((u_int)(roadSurfaceType - 2) < 2) {
        iVar20 = Newton_FindGroundElevationRough((coorddef *)pt,&roadNormal,&roadCenterPoint)
        ;
        *(int *)(tpi12 + 4) = iVar20;
      }
      else {
        iVar20 = Newton_FindGroundElevationGeneral((coorddef *)pt,&roadNormal,&roadCenterPoint);
        *(int *)(tpi12 + 4) = iVar20;
      }
      *(u_int *)(wheelInst_p + 0x2a4) = *(u_int *)(tpi12 + 4);
      if (0x20000 < *(int *)(tpi12 + 4) - *(int *)(pt + 4)) {
        roadNormal.x = 0;
        roadNormal.y = 0x10000;
        roadNormal.z = 0;
        *(u_int *)(tpi12 + 4) = *(u_int *)(pt + 4);
        elevation.x = elevation.x + *(int *)pt;
        iVar20 = *(int *)(pt + 4);
        goto accumGroundElev;
      }
      elevation.x = elevation.x + *(int *)tpi12;
      elevation.y = elevation.y + *(int *)(tpi12 + 4);
      elevation.z = elevation.z + *(int *)(tpi12 + 8);
    }
    *(coorddef *)(wheelInst_p + 0x28c) = *(coorddef *)tpi12;
    tpi12 = tpi12 + 0xc;
    pt = pt + 0xc;
    *(coorddef *)(wheelInst_p + 0x298) = roadNormal;
  }
  {
  coorddef wheelVec;
  int compressionValue [4];
  int count;
  int i;

  count = 0;
  wheelVec.x = 0;
  wheelVec.z = 0;
  pBVar4 = newtonObj;
  for (i = 0; i < 4; i = i + 1) {
    int limit;

    wheelVec.y = (*(int *)(pBVar4[1].simRoadInfo.quadPts16 + 2) -
                 tireCoord[i].y) / 2;
    pBVar4[1].simRoadInfo.forward.x = 0;
    if (wheelVec.y < -0x2665) {
      pBVar4[1].simRoadInfo.normal.z = 1;
      wheelsInAir = wheelsInAir + 1;
    }
    else if (pBVar4[1].simRoadInfo.normal.z == 1) {
      if (wheelVec.y < 1) {
        if (((newtonObj->objAltitude < 0x3333) && (-0x1999 < (newtonObj->linearVel).y)) &&
           (0xf333 < (newtonObj->orientationToGround).y)) {
          pBVar4[1].simRoadInfo.normal.z = 0;
        }
      }
      else {
        bounce = bounce + 1;
        pBVar4[1].simRoadInfo.normal.z = 0;
        pBVar4[1].simRoadInfo.forward.x = 1;
      }
    }
    limit = -0x3333;
    if (0x358000 < newtonObj->speedXZ) {
      limit = -0x2666;
    }
    if (wheelVec.y < limit) {
      wheelVec.y = limit;
    }
    iVar3 = wheelVec.y;
    if (wheelVec.y < 0) {
      iVar3 = wheelVec.y + 0xff;
    }
    ti5 = carNormal.y;
    if (carNormal.y < 0) {
      ti5 = carNormal.y + 0xff;
    }
    iVar3 = (iVar3 >> 8) * (ti5 >> 8);
    compressionValue[i] = iVar3;
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
  }
  {
    int i;
    char *wheelData;

    if (bounce != 0) {
      count = newtonObj[1].simRoadInfo.forward.x + newtonObj[1].position.x +
              newtonObj[1].wheelRot[0] + newtonObj[1].orientMat.m[4];
    }
    wheelData = (char *)newtonObj;
    for (i = 0; i < 4; i = i + 1) {
      int wheelBounce;

      wheelBounce = *(int *)(wheelData + 0x2a8);
      if (bounce == 0) {
        if ((wheelBounce < 0) && (0xdc28 < (newtonObj->orientationToGround).y)) {
          wheelBounce = wheelBounce >> 1;
          *(int *)(wheelData + 0x2a8) = wheelBounce;
        }
      }
      else if ((*(int *)(wheelData + 0x2b0) != 0) && ((newtonObj->linearVel).y < 0)) {
        int speed;

        speed = (newtonObj->linearVel).y;
        if (speed < 0) {
          speed = -speed;
        }
        speed = speed + newtonObj->groundVel;
        if (-1 < speed) {
          wheelBounce = speed / count >> 1;
          if (speed < 0x100000) {
            int ratio;

            ratio = fixedmult(speed,0x1000);
            if (ratio < 0x4ccd) {
              speed = 0x4ccc;
            }
            else {
              speed = fixedmult(speed,0x1000);
            }
            wheelBounce = fixedmult(speed,wheelBounce);
          }
          *(int *)(wheelData + 0x2a8) =
              *(int *)(wheelData + 0x2a8) + wheelBounce;
        }
      }
      wheelData = wheelData + 0x30;
    }
  }
  {
    int i;

    for (i = 0; i < 4; i = i + 1) {
      int desiredCompression;
      int compressionLimit;

      desiredCompression =
          fixedmult((tireCoord[i].y - wheelHeight[i].y) >> 1,(newtonObj->orientMat).m[4]);
      if (desiredCompression < 1) {
        compressionLimit = -*(int *)(newtonObj[1].damage[3] + 0x150);
        if (desiredCompression < compressionLimit) {
          desiredCompression = compressionLimit;
        }
      }
      else {
        compressionLimit = *(int *)(newtonObj[1].damage[3] + 0x150);
        if (compressionLimit <= desiredCompression) {
          desiredCompression = compressionLimit;
        }
      }
      newtonObj[1].wheelRot[swap[i] * 0xc + -0x17] = desiredCompression;
    }
  }
  }
  coorddef tempVecX;
  coorddef tempVecY;
  coorddef tempVecZ;

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
        wheelsInAir = 4;
        normal->x = 0;
        normal->y = 0x10000;
        normal->z = 0;
      }
      else {
        normal->x = tempVecY.x;
        normal->y = tempVecY.y;
        normal->z = tempVecY.z;
        if (tempVecY.y < 0x8000) {
          wheelsInAir = 4;
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
      else if (wheelsInAir < 4) {
        matrixtdef transposeMat;

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
  coorddef basisDots;
  int xDir;
  int yDir;
  int zDir;
  coorddef relativePos;
  int relativeDot;

  basisDots.x =
      ((normal->x / 0x100) * (newtonObj->orientMat.m[0] / 0x100) +
       (normal->y / 0x100) * (newtonObj->orientMat.m[1] / 0x100) +
       (normal->z / 0x100) * (newtonObj->orientMat.m[2] / 0x100)) /
      0x100 * (newtonObj->dimension.x / 0x100);
  basisDots.y =
      ((normal->x / 0x100) * (newtonObj->orientMat.m[3] / 0x100) +
       (normal->y / 0x100) * (newtonObj->orientMat.m[4] / 0x100) +
       (normal->z / 0x100) * (newtonObj->orientMat.m[5] / 0x100)) /
      0x100 * (newtonObj->dimension.y / 0x100);
  basisDots.z =
      ((normal->x / 0x100) * (newtonObj->orientMat.m[6] / 0x100) +
       (normal->y / 0x100) * (newtonObj->orientMat.m[7] / 0x100) +
       (normal->z / 0x100) * (newtonObj->orientMat.m[8] / 0x100)) /
      0x100 * (newtonObj->dimension.z / 0x100);
  xDir = -1;
  if (basisDots.x < 0) {
    xDir = 1;
  }
  yDir = -1;
  if (basisDots.y < 0) {
    yDir = 1;
  }
  zDir = -1;
  if (basisDots.z < 0) {
    zDir = 1;
  }
  relativePos.x = newtonObj->position.x - samplePoint->x;
  relativePos.y = newtonObj->position.y - samplePoint->y;
  relativePos.z = newtonObj->position.z - samplePoint->z;
  relativeDot =
      (normal->x / 0x100) * (relativePos.x / 0x100) +
      (normal->y / 0x100) * (relativePos.y / 0x100) +
      (normal->z / 0x100) * (relativePos.z / 0x100);
  return xDir * basisDots.x + yDir * basisDots.y +
         zDir * basisDots.z + relativeDot;
}

/* ---- Newton_CalcPerpenHeightOfCenterPointFromGround__FP13BO_tNewtonObjP8coorddefT1  [NEWTON.CPP:1110-1118] SLD-VERIFIED ---- */
int Newton_CalcPerpenHeightOfCenterPointFromGround(BO_tNewtonObj *newtonObj,coorddef *normal,coorddef *samplePoint)

{
  int iVar1;
  int relativeDot;
  coorddef relativePos;

  relativePos.x = (newtonObj->position).x - samplePoint->x;
  relativePos.y = (newtonObj->position).y - samplePoint->y;
  relativePos.z = (newtonObj->position).z - samplePoint->z;
  relativeDot = fixedmult(normal->x,relativePos.x) + fixedmult(normal->y,relativePos.y) +
                fixedmult(normal->z,relativePos.z);
  iVar1 = __builtin_abs((newtonObj->orientationToGround).y);
  if (0xb334 <= iVar1) {
    return relativeDot - (newtonObj->dimension).y; /* MATCH: direct return per-arm, not via a shared iVar1 temp -- verify_asm 2026-07-11 */
  }
  return relativeDot - (newtonObj->dimension).x;
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
  if (backwards == 0) {
    n->orientMat = n->roadMatrix;
    return;
  }
  {
    matrixtdef *ori;
    matrixtdef *road;

    ori = &n->orientMat;
    road = &n->roadMatrix;
    ori->m[0] = -road->m[0];
    ori->m[1] = -road->m[1];
    ori->m[2] = -road->m[2];
    ori->m[3] = road->m[3];
    ori->m[4] = road->m[4];
    ori->m[5] = road->m[5];
    ori->m[6] = -road->m[6];
    ori->m[7] = -road->m[7];
    ori->m[8] = -road->m[8];
  }
  return;
}

/* ---- Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji  [NEWTON.CPP:1285-1302] SLD-VERIFIED ---- */
void Newton_CopyRoadMatrixToShadowMat(BO_tNewtonObj *n,int backwards)

{
  if (backwards == 0) {
    n->shadowMat = n->roadMatrix;
    return;
  }
  {
    matrixtdef *shad;
    matrixtdef *road;

    shad = &n->shadowMat;
    road = &n->roadMatrix;
    shad->m[0] = -road->m[0];
    shad->m[1] = -road->m[1];
    shad->m[2] = -road->m[2];
    shad->m[3] = road->m[3];
    shad->m[4] = road->m[4];
    shad->m[5] = road->m[5];
    shad->m[6] = -road->m[6];
    shad->m[7] = -road->m[7];
    shad->m[8] = -road->m[8];
  }
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
extern "C" void Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii(
    BO_tNewtonObj *newtonObj,int index,int mass,int moInertia,
    int dimX,int dimY,int dimZ)
{
  int i;

  newtonObj->objID = index;
  ((int *)newtonObj)[0x22] = 0;
  newtonObj->simOptz = 0;
  newtonObj->position.x = 0;
  newtonObj->position.y = 0;
  newtonObj->position.z = 0;
  newtonObj->linearVel.x = 0;
  newtonObj->linearVel.y = 0;
  newtonObj->linearVel.z = 0;
  newtonObj->mass = mass;
  if (((GameSetup_gData.sgge & 2U) != 0) &&
      ((((Car_tObj *)newtonObj)->carFlags & 4) != 0)) {
    newtonObj->mass = mass * 5;
  }
  if ((((Car_tObj *)newtonObj)->carFlags & 0x20) != 0) {
    if ((GameSetup_gData.commMode == 1) &&
        ((Cars_gHumanRaceCarList[0]->carInfo->carType < 0x16 ||
          Cars_gHumanRaceCarList[1]->carInfo->carType < 0x16))) {
      newtonObj->mass = newtonObj->mass << 1;
    }
    else {
      newtonObj->mass = (newtonObj->mass * 3) / 2;
    }
  }
  newtonObj->massInv = fixeddiv(0x10000,newtonObj->mass);
  newtonObj->moInertia = newtonObj->mass << 3;
  newtonObj->moInertiaInv = fixeddiv(0x10000,newtonObj->moInertia);
  newtonObj->angularVel.x = 0;
  newtonObj->angularVel.y = 0;
  newtonObj->angularVel.z = 0;
  newtonObj->orientationToGround.x = 0;
  newtonObj->orientationToGround.y = 0x10000;
  newtonObj->orientationToGround.z = 0;
  newtonObj->dimension.x = dimX;
  newtonObj->dimension.y = dimY;
  newtonObj->dimension.z = dimZ;
  newtonObj->dimensionRadius =
      fixedsqrt((dimX / 0x100) * (dimX / 0x100) +
                (dimY / 0x100) * (dimY / 0x100));
  newtonObj->dimensionRadius =
      fixedsqrt((newtonObj->dimensionRadius / 0x100) *
                    (newtonObj->dimensionRadius / 0x100) +
                (dimZ / 0x100) * (dimZ / 0x100));
  newtonObj->flightTime = 0;
  newtonObj->groundSurfaceType = 1;
  newtonObj->driveSurfaceType = 1;
  newtonObj->groundVel = 0;
  newtonObj->objAltitude = 0;
  newtonObj->gravityMult = 0x10000;
  newtonObj->xRelRoadCenter = 0;
  newtonObj->roadGravityModifier = 0;
  newtonObj->collision.collided = 0;
  newtonObj->collision.impulse = 0;
  newtonObj->collision.otherObj = 0;
  newtonObj->collision.sfxType = 0;
  newtonObj->collision.disableCollisionTimer = 0;
  newtonObj->collision.lastOtherObj = 0;
  newtonObj->collision.lastImpulse = 0;
  newtonObj->collision.lastTime = 0;
  i = 9;
  do {
    newtonObj->damage[i] = 0;
    i--;
  } while (i >= 0);
  newtonObj->reOrthoCounter = 0;
  newtonObj->deadTimer = 0;
  newtonObj->active = 1;
  newtonObj->cumulatedRot = 0;
}

/* ---- Newton_QDUpdateVel__FP13BO_tNewtonObj  [NEWTON.CPP:1516-1558] SLD-VERIFIED ---- */
extern "C" void Newton_QDUpdateVel__FP13BO_tNewtonObj(int newtonObj)

{
  int t1;
  int t2;
  int t3;
  int iVar1;
  int iVar2;
  int iVar3;
  
  if (*(char *)(newtonObj + 0x91) != '\0') {
    if ((GameSetup_gData.sgge & 4U) != 0) {
      t1 = *(int *)(newtonObj + 0xac) >> 6;
      t2 = *(int *)(newtonObj + 0xb0) >> 6;
      t3 = *(int *)(newtonObj + 0xb4) >> 6;
      iVar1 = fixedmult(t1,0xcccc);
      iVar2 = fixedmult(t3,0xcccc);
      *(int *)(newtonObj + 0xa0) = *(int *)(newtonObj + 0xa0) + iVar1;
      *(int *)(newtonObj + 0xa4) = *(int *)(newtonObj + 0xa4) + t2;
      *(int *)(newtonObj + 0xa8) = *(int *)(newtonObj + 0xa8) + iVar2;
    }
    else {
      *(int *)(newtonObj + 0xa0) = *(int *)(newtonObj + 0xa0) + (*(int *)(newtonObj + 0xac) >> 6);
      *(int *)(newtonObj + 0xa4) = *(int *)(newtonObj + 0xa4) + (*(int *)(newtonObj + 0xb0) >> 6);
      *(int *)(newtonObj + 0xa8) = *(int *)(newtonObj + 0xa8) + (*(int *)(newtonObj + 0xb4) >> 6);
    }
  }
  return;
}

/* ---- Newton_OptzRotxform__FP10matrixtdefiiiPiiT4  [NEWTON.CPP:1569-1617] SLD-VERIFIED ---- */
extern "C" bool Newton_OptzRotxform__FP10matrixtdefiiiPiiT4(int *m,int ax,int ay,int az,u_int *reOrthoNeeded,
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
extern "C" void Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj(int newtonObj)

{
  char cVar1;
  int iVar2;
  int iVar3;
  matrixtdef *m1;
  matrixtdef mStack_50;
  coorddef angularVel;
  int aiStack_18 [2];

  if (*(char *)(newtonObj + 0x91) != '\0') {
    iVar3 = *(int *)(newtonObj + 0x114);
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0x3f;
    }
    angularVel.x = iVar3 >> 6;
    iVar3 = *(int *)(newtonObj + 0x118);
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0x3f;
    }
    angularVel.y = iVar3 >> 6;
    iVar3 = *(int *)(newtonObj + 0x11c);
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0x3f;
    }
    angularVel.z = iVar3 >> 6;
    iVar2 = Newton_OptzRotxform__FP10matrixtdefiiiPiiT4((int *)&mStack_50,angularVel.x,angularVel.y,angularVel.z,aiStack_18,0x1000,newtonObj + 0x98);
    m1 = (matrixtdef *)(newtonObj + 0xf0);
    if (iVar2 != 0) {
      Math_fasttransmult(m1,&mStack_50,m1);
      cVar1 = *(char *)(newtonObj + 0x92) - 1;
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
extern "C" void Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj(int newtonObj)

{
  matrixtdef mStack_50;
  coorddef angularVel;
  int aiStack_18 [2];
  char cVar1;
  int iVar2;
  int iVar3;
  matrixtdef *m1;

  if ((*(char *)(newtonObj + 0x91) != '\0') && (*(char *)(newtonObj + 0x90) == '\0')) {
    iVar3 = *(int *)(newtonObj + 0x114);
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xf;
    }
    angularVel.x = iVar3 >> 4;
    iVar3 = *(int *)(newtonObj + 0x118);
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xf;
    }
    angularVel.y = iVar3 >> 4;
    iVar3 = *(int *)(newtonObj + 0x11c);
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xf;
    }
    angularVel.z = iVar3 >> 4;
    iVar2 = Newton_OptzRotxform__FP10matrixtdefiiiPiiT4((int *)&mStack_50,angularVel.x,angularVel.y,angularVel.z,aiStack_18,0x2000,newtonObj + 0x98);
    m1 = (matrixtdef *)(newtonObj + 0xf0);
    if (iVar2 != 0) {
      Math_fasttransmult(m1,&mStack_50,m1);
      if ((aiStack_18[0] != 0) ||
         (cVar1 = *(char *)(newtonObj + 0x92) - 1, *(char *)(newtonObj + 0x92) = cVar1, cVar1 == '\0')) {
        reorthogonalize(m1);
        *(u_char *)(newtonObj + 0x92) = 0x40;
        *(u_int *)(newtonObj + 0x98) = 0;
      }
    }
  }
  return;
}

/* ---- Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi  [NEWTON.CPP:1730-1807] SLD-VERIFIED ---- */
extern "C" void Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi(int newtonObj,int *normal,int orientToGround)

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
extern "C" void Newton_CalcRealShadowCoordinates__FP8Car_tObji(Car_tObj *carObj,int currentTick)

{
  coorddef lengthVector;
  coorddef widthVector;
  coorddef frontWidthVector;
  coorddef carGroundCoord;
  coorddef temp;
  coorddef vecOffset;
  int diff;
  coorddef dimension;
  int i;

  diff = currentTick - carObj->N.lastUpdated;
  dimension = carObj->N.dimension;
  dimension.x += 0xccc;
  dimension.z += 0xccc;

  lengthVector.x = fixedmult(dimension.z,carObj->N.orientMat.m[6]);
  lengthVector.y = fixedmult(dimension.z,carObj->N.orientMat.m[7]);
  lengthVector.z = fixedmult(dimension.z,carObj->N.orientMat.m[8]);
  widthVector.x = fixedmult(dimension.x,carObj->N.orientMat.m[0]);
  widthVector.y = fixedmult(dimension.x,carObj->N.orientMat.m[1]);
  widthVector.z = fixedmult(dimension.x,carObj->N.orientMat.m[2]);

  if (carObj->render.currentCarType == 20) {
    int front;
    front = dimension.x * 0xc0 >> 8;
    frontWidthVector.x = fixedmult(front,carObj->N.orientMat.m[0]);
    frontWidthVector.y = fixedmult(front,carObj->N.orientMat.m[1]);
    frontWidthVector.z = fixedmult(front,carObj->N.orientMat.m[2]);
  } else {
    frontWidthVector.z = widthVector.z;
    frontWidthVector.x = widthVector.x;
    frontWidthVector.y = widthVector.y;
  }

  if (carObj->N.orientationToGround.y > 0xe666) {
    vecOffset.x =
        fixedmult(-dimension.y - carObj->N.objAltitude,carObj->N.roadMatrix.m[3]);
    vecOffset.y =
        fixedmult(-dimension.y - carObj->N.objAltitude,carObj->N.roadMatrix.m[4]);
    vecOffset.z =
        fixedmult(-dimension.y - carObj->N.objAltitude,carObj->N.roadMatrix.m[5]);
    carGroundCoord.x = carObj->N.position.x + vecOffset.x;
    carGroundCoord.y = carObj->N.position.y + vecOffset.y;
    carGroundCoord.z = carObj->N.position.z + vecOffset.z;
  } else {
    carGroundCoord = carObj->N.position;
    carGroundCoord.y = carObj->N.groundElevation;
  }

  temp.x = carGroundCoord.x + lengthVector.x;
  temp.y = carGroundCoord.y + lengthVector.y;
  temp.z = carGroundCoord.z + lengthVector.z;
  carObj->N.shadowCoord[0].x = temp.x - frontWidthVector.x;
  carObj->N.shadowCoord[0].y = temp.y - frontWidthVector.y;
  carObj->N.shadowCoord[0].z = temp.z - frontWidthVector.z;
  carObj->N.shadowCoord[1].x = temp.x + frontWidthVector.x;
  carObj->N.shadowCoord[1].y = temp.y + frontWidthVector.y;
  carObj->N.shadowCoord[1].z = temp.z + frontWidthVector.z;

  temp.x = carGroundCoord.x - lengthVector.x;
  temp.y = carGroundCoord.y - lengthVector.y;
  temp.z = carGroundCoord.z - lengthVector.z;
  carObj->N.shadowCoord[2].x = temp.x - widthVector.x;
  carObj->N.shadowCoord[2].y = temp.y - widthVector.y;
  carObj->N.shadowCoord[2].z = temp.z - widthVector.z;
  carObj->N.shadowCoord[3].x = temp.x + widthVector.x;
  carObj->N.shadowCoord[3].y = temp.y + widthVector.y;
  carObj->N.shadowCoord[3].z = temp.z + widthVector.z;

  for (i = 0; i < 4; i++) {
    carObj->N.shadowCoord[i].y = carObj->wheel[i].currentPos.y;
    carObj->N.shadowCoord[i].y +=
        (carObj->N.linearVel.y / 64) * diff;
    }
  return;
}

/* ---- Newton_CheckForSpikeBelts__FP13BO_tNewtonObj  [NEWTON.CPP:1885-1916] SLD-VERIFIED ---- */
extern "C" void Newton_CheckForSpikeBelts__FP13BO_tNewtonObj(BO_tNewtonObj *newtonObj)

{
  int slice;
  int leftLatPos;
  int rightLatPos;
  int latPos;

  if (Newton_GetSpikeBelt(&slice,&leftLatPos,&rightLatPos) != 0) {
    if ((AICop_spikeBelt.active_ != 0) &&
        (newtonObj->simRoadInfo.slice == slice)) {
      latPos = ((Car_tObj *)newtonObj)->roadPosition;
      if (((((Car_tObj *)newtonObj)->carFlags & 0x230) == 0) &&
          (leftLatPos < latPos) && (latPos < rightLatPos) &&
          (++((Car_tObj *)newtonObj)->blowout == 1)) {
        newtonObj->collision.impulse = 0xf0000;
        newtonObj->collision.sfxType = 0x50007;
        newtonObj->collision.collisionPoint = newtonObj->position;
      }
    }
  }
}

/* ---- Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef  [NEWTON.CPP:1922-1956] SLD-VERIFIED ---- */
extern "C" void Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef(BO_tNewtonObj *newtonObj,coorddef normal)

{
  coorddef barrierVec;
  int impactVel;
  int distRetreat;
  coorddef upVec;
  matrixtdef islandMatrix;

  upVec.x = 0;
  upVec.y = 0x10000;
  upVec.z = 0;
  barrierVec.x = -(normal.z / 0x100 * 0x100);
  barrierVec.y = 0;
  barrierVec.z = normal.x / 0x100 * 0x100;
  distRetreat = (normal.x / 0x100) * (newtonObj->linearVel.x / 0x100) +
                (normal.y / 0x100) * (newtonObj->linearVel.y / 0x100) +
                (normal.z / 0x100) * (newtonObj->linearVel.z / 0x100);
  if (distRetreat < 0) {
    distRetreat = -distRetreat;
  }
  distRetreat = -distRetreat;
  if (distRetreat < 0) {
    distRetreat = distRetreat + 0xf;
  }
  distRetreat = distRetreat >> 4;
  if (-0x7ad <= distRetreat) {
    distRetreat = -0x7ae;
  }
  islandMatrix.m[0] = normal.x;
  islandMatrix.m[1] = normal.y;
  islandMatrix.m[2] = normal.z;
  islandMatrix.m[3] = upVec.x;
  islandMatrix.m[4] = upVec.y;
  islandMatrix.m[5] = upVec.z;
  islandMatrix.m[6] = barrierVec.x;
  islandMatrix.m[7] = barrierVec.y;
  islandMatrix.m[8] = barrierVec.z;
  impactVel = Physics_AttenuateVelocity((Car_tObj *)newtonObj,distRetreat,&islandMatrix);
  Physics_SetCurrentWallType(4);
  Physics_CorrectPostCollisionYaw((Car_tObj *)newtonObj,impactVel,normal);
}

/* ---- Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos  [NEWTON.CPP:2107-2140] SLD-VERIFIED ---- */
extern "C" void Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos(int type,coorddef *vector,BWorldSm_Pos *testSimRoadInfo)

{
  coorddef fwdVec;
  coorddef upVec;
  coorddef result;

  upVec.y = 0x10000;
  upVec.z = 0;
  upVec.x = 0;
  fwdVec.y = 0;
  if (type == 1) {
    fwdVec.z = testSimRoadInfo->quadPts[3].z - testSimRoadInfo->quadPts[2].z;
    fwdVec.x = testSimRoadInfo->quadPts[3].x - testSimRoadInfo->quadPts[2].x;
  }
  else if (type == 4) {
    fwdVec.z = testSimRoadInfo->quadPts[2].z - testSimRoadInfo->quadPts[1].z;
    fwdVec.x = testSimRoadInfo->quadPts[2].x - testSimRoadInfo->quadPts[1].x;
  }
  else if (type == 2) {
    fwdVec.z = testSimRoadInfo->quadPts[1].z - testSimRoadInfo->quadPts[0].z;
    fwdVec.x = testSimRoadInfo->quadPts[1].x - testSimRoadInfo->quadPts[0].x;
  }
  else if (type == 8) {
    fwdVec.z = testSimRoadInfo->quadPts[0].z - testSimRoadInfo->quadPts[3].z;
    fwdVec.x = testSimRoadInfo->quadPts[0].x - testSimRoadInfo->quadPts[3].x;
  }
  Math_NormalizeShortVector(&fwdVec);
  result.x = fixedmult(fwdVec.y,upVec.z) -
             fixedmult(fwdVec.z,upVec.y);
  result.y = fixedmult(fwdVec.z,upVec.x) -
             fixedmult(fwdVec.x,upVec.z);
  result.z = fixedmult(fwdVec.x,upVec.y) -
             fixedmult(fwdVec.y,upVec.x);
  vector->x = result.x;
  vector->y = result.y;
  vector->z = result.z;
}

/* ---- Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi  [NEWTON.CPP:2144-2157] SLD-VERIFIED ---- */
extern "C" u_int
Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi(int newtonObj,int testSimRoadInfo,int wheel)

{
  int bad;
  int height;
  u_int uVar1;
  
  int *quad;

  uVar1 = 0;
  if (((*(u_char **)(testSimRoadInfo + 0x78) != (u_char *)0x0) && ((**(u_char **)(testSimRoadInfo + 0x78) & 0xf) == 0)) ||
     (quad = (int *)(newtonObj + wheel * 0x30),
      0x20000 < quad[0xa9] - quad[0xa4])) {
    uVar1 = 1;
  }
  return uVar1;
}

/* ---- Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj  [NEWTON.CPP:2161-2361] SLD-VERIFIED ---- */
void Newton_TestForUndrivableSurfaces(BO_tNewtonObj *newtonObj)

{
  int i;
  int collision_type;
  int newHeight;
  coorddef normal;
  coorddef cautionaryCenter;
  coorddef undrivableCenter;
  coorddef speedVec;
  int iVar12;
  BO_tNewtonObj *pBVar13;
  int local_2c;
  
  collision_type = 0;
  newHeight = 0;
  cautionaryCenter.x = (newtonObj->roadCenterPoint).x;
  cautionaryCenter.y = (newtonObj->roadCenterPoint).y;
  cautionaryCenter.z = (newtonObj->roadCenterPoint).z;
  memset((u_char *)&speedVec,'\0',0xc);
  testSimRoadInfo = newtonObj->simRoadInfo;
  if (0x280000 < newtonObj->speedXZ) {
    speedVec.x = (newtonObj->linearVel).x * 5 / 0x100;
    speedVec.y = (newtonObj->linearVel).y * 5 / 0x100;
    speedVec.z = (newtonObj->linearVel).z * 5 / 0x100;
  }
  i = 0;
  local_2c = 0;
  pBVar13 = newtonObj;
  do {
    coorddef testPoint;

    if (3 < i) {
      return;
    }
    testPoint = *(coorddef *)((char *)pBVar13 + 0x28c);
    testPoint.x = testPoint.x + speedVec.x;
    testPoint.y = testPoint.y + speedVec.y;
    testPoint.z = testPoint.z + speedVec.z;
    BWorldSm_FindClosestQuadRez(&testPoint,&testSimRoadInfo,1)
    ;
    if ((signed char)testSimRoadInfo.offEdge != 0) {
      Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos(
          (signed char)testSimRoadInfo.offEdge,&normal,&newtonObj->simRoadInfo);
      normal.y = 0;
      Math_NormalizeShortVector(&normal);
      collision_type = 1;
    }
    else {
      iVar12 = Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi(newtonObj,&testSimRoadInfo,i);
      if (iVar12 != 0) {
        coorddef newTestPoint;
        int check;

        newtestSimRoadInfo = testSimRoadInfo;
        newTestPoint = testPoint;
        check = BWorldSm_FindEdgeOff(&testPoint,&newtonObj->simRoadInfo,
                                     &testSimRoadInfo,(u_int *)&newHeight);
        collision_type = 2;
        if (check == 1) {
          Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos(
              1,&normal,&newtonObj->simRoadInfo);
        }
        else if (check == 2) {
          Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos(
              2,&normal,&newtonObj->simRoadInfo);
        }
        else if (check == 4) {
          Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos(
              4,&normal,&newtonObj->simRoadInfo);
        }
        else if (check == 8) {
          Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos(
              8,&normal,&newtonObj->simRoadInfo);
        }
        if ((check & 3) != 0) {
          if ((check & 1) != 0) {
            Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos(
                1,&normal,&newtonObj->simRoadInfo);
          }
          else if ((check & 2) != 0) {
            Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos(
                2,&normal,&newtonObj->simRoadInfo);
          }
          newTestPoint.x = newTestPoint.x + normal.x;
          newTestPoint.y = newTestPoint.y + normal.y;
          newTestPoint.z = newTestPoint.z + normal.z;
          BWorldSm_FindClosestQuadRez(&newTestPoint,&newtestSimRoadInfo,1);
          iVar12 = Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi(newtonObj,&newtestSimRoadInfo,i);
          if (iVar12 != 0) {
            if ((check & 0xc) != 0) {
              if ((check & 4) != 0) {
                Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos(
                    4,&normal,&newtonObj->simRoadInfo);
              }
              else if ((check & 8) != 0) {
                Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos(
                    8,&normal,&newtonObj->simRoadInfo);
              }
              newtestSimRoadInfo = testSimRoadInfo;
              newTestPoint = testPoint;
              newTestPoint.x = newTestPoint.x + normal.x;
              newTestPoint.y = newTestPoint.y + normal.y;
              newTestPoint.z = newTestPoint.z + normal.z;
              BWorldSm_FindClosestQuadRez(&newTestPoint,&newtestSimRoadInfo,1);
              iVar12 = Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi(newtonObj,&newtestSimRoadInfo,i);
              if (iVar12 != 0) {
                int j;
                coorddef temp;

                undrivableCenter.z = 0;
                undrivableCenter.y = 0;
                undrivableCenter.x = 0;
                j = 0;
NewtonTestUndrv_loop1:
                if (j < 4) {
                  if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0x0) {
                    temp = testSimRoadInfo.quadPts[j];
                  }
                  else {
                    temp.x = BWorldSm_slices[testSimRoadInfo.slice].center[0];
                    temp.y = BWorldSm_slices[testSimRoadInfo.slice].center[1];
                    temp.z = BWorldSm_slices[testSimRoadInfo.slice].center[2];
                  }
                  undrivableCenter.x = undrivableCenter.x + temp.x;
                  undrivableCenter.y = undrivableCenter.y + temp.y;
                  undrivableCenter.z = undrivableCenter.z + temp.z;
                  j = j + 1;
                  goto NewtonTestUndrv_loop1;
                }
                undrivableCenter.x /= 4;
                undrivableCenter.y /= 4;
                undrivableCenter.z /= 4;
                normal.x = cautionaryCenter.x - undrivableCenter.x;
                normal.z = cautionaryCenter.z - undrivableCenter.z;
              }
            }
            else {
              int j;
              coorddef temp;

              undrivableCenter.z = 0;
              undrivableCenter.y = 0;
              undrivableCenter.x = 0;
              j = 0;
NewtonTestUndrv_loop2:
              if (j < 4) {
                if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0x0) {
                  temp = testSimRoadInfo.quadPts[j];
                }
                else {
                  temp.x = BWorldSm_slices[testSimRoadInfo.slice].center[0];
                  temp.y = BWorldSm_slices[testSimRoadInfo.slice].center[1];
                  temp.z = BWorldSm_slices[testSimRoadInfo.slice].center[2];
                }
                undrivableCenter.x = undrivableCenter.x + temp.x;
                undrivableCenter.y = undrivableCenter.y + temp.y;
                undrivableCenter.z = undrivableCenter.z + temp.z;
                j = j + 1;
                goto NewtonTestUndrv_loop2;
              }
              undrivableCenter.x /= 4;
              undrivableCenter.y /= 4;
              undrivableCenter.z /= 4;
              normal.x = (newtonObj->position).x - undrivableCenter.x;
              normal.z = (newtonObj->position).z - undrivableCenter.z;
            }
          }
        }
        normal.y = 0;
        Math_NormalizeShortVector(&normal);
      }
    }
    if (collision_type != 0) {
      int impulse;
      int zone;
      Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef(newtonObj,normal);
      (newtonObj->collision).collisionPoint =
          *(coorddef *)((char *)pBVar13 + 0x28c);
      AIPhysic_ProcessBarrierCollision((Car_tObj *)newtonObj);
      if ((newtonObj[1].simRoadInfo.quadPts[1].y & 4U) != 0) {
        Physics_FixEngineRpm((Car_tObj *)newtonObj);
      }
      impulse = (newtonObj->collision).impulse;
      if (impulse < 0xa0001) {
        return;
      }
      zone = 6;
      if (i != 2) {
        zone = local_2c;
        if (i == 3) {
          zone = 4;
        }
      }
      Newton_AddDamageZone(newtonObj,impulse,zone,1);
      return;
    }
    pBVar13 = (BO_tNewtonObj *)((char *)pBVar13 + 0x30);
    i = i + 1;
    local_2c = local_2c + 2;
  } while( true );
}

/* ---- Newton_LimitAngularVelocity__FP13BO_tNewtonObj  [NEWTON.CPP:2440-2456] SLD-VERIFIED ---- */
extern "C" void Newton_LimitAngularVelocity__FP13BO_tNewtonObj(int newtonObj)

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
extern "C" void Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj(Car_tObj *newtonObj)

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
      Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi((int)newtonObj,(int *)&iStack_50,(newtonObj->N).orientationToGround.y);
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
          Newton_CheckForSpikeBelts__FP13BO_tNewtonObj((BO_tNewtonObj *)newtonObj);
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
          Newton_LimitAngularVelocity__FP13BO_tNewtonObj(newtonObj);
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
      iVar1 = Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef(newtonObj,&cStack_60);
      (newtonObj->N).position.y = iVar1 + (newtonObj->N).dimension.y;
    }
  }
  return;
}

/* ---- Newton_CalculateRoadPositionFromSliceAndPosition__FiP8coorddefP10matrixtdef  [NEWTON.CPP:2736-2745] SLD-VERIFIED ---- */
int Newton_CalculateRoadPositionFromSliceAndPosition(int slice,coorddef *position,matrixtdef *matrix)

{
  coorddef centerBack;
  coorddef carRelative;

  centerBack = *(coorddef *)BWorldSm_slices[slice].center;
  carRelative.x = position->x - centerBack.x;
  carRelative.y = position->y - centerBack.y;
  carRelative.z = position->z - centerBack.z;
  return (matrix->m[0] / 256) * (carRelative.x / 256) +
         (matrix->m[1] / 256) * (carRelative.y / 256) +
         (matrix->m[2] / 256) * (carRelative.z / 256);
}

/* ---- Newton_CalculateRoadPosition__FP13BO_tNewtonObj  [NEWTON.CPP:2762-2773] SLD-VERIFIED ---- */
int Newton_CalculateRoadPosition(BO_tNewtonObj *newtonObj)

{
  coorddef centerBack;
  coorddef carRelative;
  coorddef carPos;

  centerBack =
      *(coorddef *)BWorldSm_slices[newtonObj->simRoadInfo.slice].center;
  carPos = newtonObj->position;
  carRelative.x = carPos.x - centerBack.x;
  carRelative.y = carPos.y - centerBack.y;
  carRelative.z = carPos.z - centerBack.z;
  return (newtonObj->roadMatrix.m[0] / 256) * (carRelative.x / 256) +
         (newtonObj->roadMatrix.m[1] / 256) * (carRelative.y / 256) +
         (newtonObj->roadMatrix.m[2] / 256) * (carRelative.z / 256);
}

/* end of newton.cpp */
