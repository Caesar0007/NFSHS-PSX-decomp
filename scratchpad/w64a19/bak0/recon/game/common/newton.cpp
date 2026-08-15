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
extern "C" void Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj(BO_tNewtonObj *newtonObj);
int Newton_CalculateRoadPositionFromSliceAndPosition(int slice,coorddef *position,matrixtdef *matrix);
int Newton_CalculateRoadPosition(BO_tNewtonObj *newtonObj);


/* ---- Newton_AddDamageZone__FP13BO_tNewtonObjiii  [NEWTON.CPP:50-216] SLD-VERIFIED ---- */
void Newton_AddDamageZone(BO_tNewtonObj *newtonObj,int impulse,int zone,int type)

{
  if (Force_IsForceOn((Car_tObj *)newtonObj) != 0) {
    Force_HitWall((newtonObj->collision).impulse);
  }
  if (GameSetup_gData.Damage != 0) {
    int imp;

    if (0x640000 < impulse / 2) {
      imp = 0x640000;
    }
    else {
      imp = impulse / 2;
    }
    if ((newtonObj[1].simRoadInfo.quadPts[1].y & 0x200U) != 0) {
      imp = imp / 2;
    }
    if (imp < newtonObj->damage[zone]) {
      imp = newtonObj->damage[zone];
    }
    newtonObj->damage[zone] = imp;
    if (zone < 8) {
      if (zone == 0) {
        int temp = (newtonObj->damage[0] + newtonObj->damage[2]) / 2;

        newtonObj->damage[1] = temp < newtonObj->damage[1] ?
            newtonObj->damage[1] : temp;
        {
          int secondTemp =
              (newtonObj->damage[0] + newtonObj->damage[6]) / 2;

          if (secondTemp < newtonObj->damage[7]) {
            secondTemp = newtonObj->damage[7];
          }
          newtonObj->damage[7] = secondTemp;
        }
      }
      else if (zone == 1) {
        int temp;

        temp = (newtonObj->damage[7] + newtonObj->damage[1]) / 2;
        newtonObj->damage[0] = temp < newtonObj->damage[0] ?
            newtonObj->damage[0] : temp;
        {
          int secondTemp =
              (newtonObj->damage[1] + newtonObj->damage[3]) / 2;

          if (secondTemp < newtonObj->damage[2]) {
            secondTemp = newtonObj->damage[2];
          }
          newtonObj->damage[2] = secondTemp;
        }
      }
      else if (zone == 6) {
        int temp;

        temp = (newtonObj->damage[4] + newtonObj->damage[6]) / 2;
        newtonObj->damage[5] = temp < newtonObj->damage[5] ?
            newtonObj->damage[5] : temp;
        {
          int secondTemp =
              (newtonObj->damage[0] + newtonObj->damage[6]) / 2;

          if (secondTemp < newtonObj->damage[7]) {
            secondTemp = newtonObj->damage[7];
          }
          newtonObj->damage[7] = secondTemp;
        }
      }
      else if (zone == 7) {
        int temp;

        temp = (newtonObj->damage[7] + newtonObj->damage[1]) / 2;
        newtonObj->damage[0] = temp < newtonObj->damage[0] ?
            newtonObj->damage[0] : temp;
        {
          int secondTemp =
              (newtonObj->damage[5] + newtonObj->damage[7]) / 2;

          if (secondTemp < newtonObj->damage[6]) {
            secondTemp = newtonObj->damage[6];
          }
          newtonObj->damage[6] = secondTemp;
        }
      }
      else {
        /* MATCH: keep the average and the two-arm maximum in separate webs.
         * This preserves retail's v0 pre-divide sum and v1 temp/result flow. */
        int temp;
        int result;

        temp = (imp + newtonObj->damage[zone + 2]) / 2;
        if (temp < newtonObj->damage[zone + 1]) {
          result = newtonObj->damage[zone + 1];
        }
        else {
          result = temp;
        }
        newtonObj->damage[zone + 1] = result;
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
    int intensity;
    int zMult;
    int yMult;
    int xMult;
    matrixtdef transposeMat;

    xMult = 0x20000;
    yMult = 0;
    zMult = 0x20000;
    if (impulse > 0x5a0000) {
      int newYVel;
      int cappedYVel;

      impulse /= 4;
      newtonObj->flightTime = 1;
      (newtonObj->collision).lastCollision = 0;
      *(u_int *)&newtonObj[3].eIndexShadow = 1;
      if (newtonObj->objAltitude < 0x20000) {
        (newtonObj->position).y = (newtonObj->position).y + 0x10000;
      }
      newYVel = newtonObj->linearVel.y + impulse / 3;
      if (newYVel <= 0xc0000) {
        cappedYVel = newYVel;
      }
      else {
        cappedYVel = 0xc0000;
      }
      newtonObj->linearVel.y = cappedYVel;
      intensity = impulse / 32;
      if (0x9999 < intensity) {
        intensity = 0x9999;
      }
      if ((BWorldSm_TunnelFlagSm(&newtonObj->simRoadInfo) != 0) &&
          (0x90000 < (newtonObj->linearVel).y)) {
        (newtonObj->linearVel).y = 0x90000;
      }
      if (0x140000 < impulse) {
        u_int randomX;
        u_int randomY;
        u_int randomZ;

        randtemp = fastRandom * randSeed;
        randomX = (randtemp & 0xffff00) >> 8;
        fastRandom = randtemp & 0xffff;
        randtemp = fastRandom * randSeed;
        randomY = (randtemp & 0xffff00) >> 8;
        fastRandom = randtemp & 0xffff;
        randtemp = fastRandom * randSeed;
        randomZ = (randtemp & 0xffff00) >> 8;
        fastRandom = randtemp & 0xffff;
        yMult = randomY * 3;
        zMult = randomZ * 3;
        randtemp = fastRandom * randSeed;
        fastRandom = randtemp & 0xffff;
        xMult = randomX * 4;
        if ((randtemp & 0xffff00) >> 8 < 0x3333) {
          intensity = -intensity;
        }
        if (xMult + yMult + zMult < 0x40000) {
          if (xMult < 0x10000) {
            xMult = randomX << 3;
          }
          if (yMult < 0x10000) {
            yMult = randomY * 6;
          }
          if (zMult < 0x10000) {
            zMult = randomZ * 6;
          }
        }
      }
      if (type == 2) {
        xMult = xMult << 1;
        yMult = yMult << 1;
        zMult = zMult << 1;
      }
    }
    else {
      intensity = impulse / 64;
      if (0x8000 < intensity) {
        intensity = 0x8000;
      }
    }
    newtonObj[1].shadowMat.m[8] =
        fixedmult(newtonObj->angularVel.x,newtonObj->orientMat.m[0]) +
        fixedmult(newtonObj->angularVel.y,newtonObj->orientMat.m[1]) +
        fixedmult(newtonObj->angularVel.z,newtonObj->orientMat.m[2]);
    newtonObj[1].shadowCoord[0].x =
        fixedmult(newtonObj->angularVel.x,newtonObj->orientMat.m[3]) +
        fixedmult(newtonObj->angularVel.y,newtonObj->orientMat.m[4]) +
        fixedmult(newtonObj->angularVel.z,newtonObj->orientMat.m[5]);
    newtonObj[1].shadowCoord[0].y =
        fixedmult(newtonObj->angularVel.x,newtonObj->orientMat.m[6]) +
        fixedmult(newtonObj->angularVel.y,newtonObj->orientMat.m[7]) +
        fixedmult(newtonObj->angularVel.z,newtonObj->orientMat.m[8]);
    if ((u_int)zone < 3) {
      newtonObj[1].shadowMat.m[8] -= fixedmult(intensity,xMult) / 2;
    }
    else {
      newtonObj[1].shadowMat.m[8] += fixedmult(intensity,xMult) / 2;
    }
    if (zone - 2U < 3) {
      newtonObj[1].shadowCoord[0].x += fixedmult(intensity,yMult) / 2;
      newtonObj[1].shadowCoord[0].y += fixedmult(intensity,zMult) / 2;
    }
    else {
      newtonObj[1].shadowCoord[0].x -= fixedmult(intensity,yMult) / 2;
      newtonObj[1].shadowCoord[0].y -= fixedmult(intensity,zMult) / 2;
    }
    transpose(&newtonObj->orientMat,&transposeMat);
    newtonObj->angularVel.x =
        fixedmult(newtonObj[1].shadowMat.m[8],transposeMat.m[0]) +
        fixedmult(newtonObj[1].shadowCoord[0].x,transposeMat.m[1]) +
        fixedmult(newtonObj[1].shadowCoord[0].y,transposeMat.m[2]);
    newtonObj->angularVel.y =
        fixedmult(newtonObj[1].shadowMat.m[8],transposeMat.m[3]) +
        fixedmult(newtonObj[1].shadowCoord[0].x,transposeMat.m[4]) +
        fixedmult(newtonObj[1].shadowCoord[0].y,transposeMat.m[5]);
    newtonObj->angularVel.z =
        fixedmult(newtonObj[1].shadowMat.m[8],transposeMat.m[6]) +
        fixedmult(newtonObj[1].shadowCoord[0].x,transposeMat.m[7]) +
        fixedmult(newtonObj[1].shadowCoord[0].y,transposeMat.m[8]);
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
  int slice;

  if (n->active) {
    slice = n->simRoadInfo.slice;
    hiRez = n->simOptz < 2;

    if (hiRez) {
      int i;

      n->roadCenterPoint.z = 0;
      n->roadCenterPoint.y = 0;
      n->roadCenterPoint.x = 0;
      for (i = 0; i < 4; i++) {
        coorddef temp;

        if (n->simRoadInfo.simQuad) {
          temp = n->simRoadInfo.quadPts[i];
        }
        else {
          temp = *(coorddef *)BWorldSm_slices[n->simRoadInfo.slice].center;
        }
        n->roadCenterPoint.x += temp.x;
        n->roadCenterPoint.y += temp.y;
        n->roadCenterPoint.z += temp.z;
      }
      n->roadCenterPoint.x /= 4;
      n->roadCenterPoint.y /= 4;
      n->roadCenterPoint.z /= 4;
    }
    else {
      if (n->simRoadInfo.simQuad) {
        n->roadCenterPoint = n->simRoadInfo.quadPts[0];
      }
      else {
        n->roadCenterPoint = *(coorddef *)BWorldSm_slices[slice].center;
      }
    }

    if (hiRez) {
      if (*(signed char *)&n->simRoadInfo.quadChanged) {
        int r1;
        int r2;
        int r3;
        int r4;
        int r5;
        int r6;
        int x1;

        *(coorddef *)&n->roadMatrix.m[3] =
            *(coorddef *)BWorldSm_UNormal(&n->simRoadInfo);
        *(coorddef *)&n->roadMatrix.m[6] =
            *(coorddef *)BWorldSm_UForward(&n->simRoadInfo);
        r1 = n->roadMatrix.m[3];
        r2 = n->roadMatrix.m[4];
        r3 = n->roadMatrix.m[5];
        r4 = n->roadMatrix.m[6];
        r5 = n->roadMatrix.m[7];
        r6 = n->roadMatrix.m[8];
        x1 = fixedmult(r2,r6);
        n->roadMatrix.m[0] = x1 - fixedmult(r3,r5);
        x1 = fixedmult(r3,r4);
        n->roadMatrix.m[1] = x1 - fixedmult(r1,r6);
        x1 = fixedmult(r1,r5);
        n->roadMatrix.m[2] = x1 - fixedmult(r2,r4);
      }
    }
    else {
      int r1;
      int r2;
      int r3;

      r1 = (int)(signed char)BWorldSm_slices[slice].right[0] << 9;
      r2 = (int)(signed char)BWorldSm_slices[slice].right[1] << 9;
      r3 = (int)(signed char)BWorldSm_slices[slice].right[2] << 9;
      n->roadMatrix.m[0] = r1;
      n->roadMatrix.m[1] = r2;
      n->roadMatrix.m[2] = r3;
      r1 = (int)(signed char)BWorldSm_slices[slice].normal[0] << 9;
      r2 = (int)(signed char)BWorldSm_slices[slice].normal[1] << 9;
      r3 = (int)(signed char)BWorldSm_slices[slice].normal[2] << 9;
      n->roadMatrix.m[3] = r1;
      n->roadMatrix.m[4] = r2;
      n->roadMatrix.m[5] = r3;
      r1 = (int)(signed char)BWorldSm_slices[slice].forward[0] << 9;
      r2 = (int)(signed char)BWorldSm_slices[slice].forward[1] << 9;
      r3 = (int)(signed char)BWorldSm_slices[slice].forward[2] << 9;
      n->roadMatrix.m[6] = r1;
      n->roadMatrix.m[7] = r2;
      n->roadMatrix.m[8] = r3;
    }
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
      n->roadYaw = intatan(x1,z1);
    }
  }
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
  int wheelsInAir;
  int bounce;
  int ti5;
  int ti1;
  int ti4;
  int iVar20;
  int iVar3;
  BO_tNewtonObj *pBVar4;
  int iVar5;
  int tstr9;
  int iVar24;
  coorddef elevation;
  coorddef tireCoord [4];
  coorddef carNormal;
  
  {
    int r2 = ((coorddef *)&(newtonObj->orientMat).m[3])->x;
    int r3 = ((coorddef *)&(newtonObj->orientMat).m[3])->y;
    int r4 = ((coorddef *)&(newtonObj->orientMat).m[3])->z;
    carNormal.x = r2;
    carNormal.y = r3;
    carNormal.z = r4;
  }
  elevation.x = 0;
  elevation.y = 0;
  elevation.z = 0;
  {
    coorddef lengthVector;
    coorddef widthVector;
    coorddef carGroundCoord;
    coorddef vecOffset;
    {
      int v1 = (newtonObj->dimension).z * 0xd >> 0xc;
      int r1 = v1 * ((newtonObj->orientMat).m[6] >> 8);
      int r2 = v1 * ((newtonObj->orientMat).m[7] >> 8);
      int r3 = v1 * ((newtonObj->orientMat).m[8] >> 8);
      lengthVector.x = r1;
      lengthVector.y = r2;
      lengthVector.z = r3;
      {
        int v1 = (newtonObj->dimension).x * 7 >> 0xb;
        int r1 = v1 * ((newtonObj->orientMat).m[0] >> 8);
        int r2 = v1 * ((newtonObj->orientMat).m[1] >> 8);
        int r3 = v1 * ((newtonObj->orientMat).m[2] >> 8);
        widthVector.x = r1;
        widthVector.y = r2;
        widthVector.z = r3;
        {
          int v1 = -(newtonObj->dimension).y >> 8;
          int r1 = v1 * ((newtonObj->orientMat).m[3] >> 8);
          int r2 = v1 * ((newtonObj->orientMat).m[4] >> 8);
          int r3 = v1 * ((newtonObj->orientMat).m[5] >> 8);
          vecOffset.x = r1;
          vecOffset.y = r2;
          vecOffset.z = r3;
          {
            int r1 = (newtonObj->position).x + vecOffset.x;
            int r2 = (newtonObj->position).y + vecOffset.y;
            int r3 = (newtonObj->position).z + vecOffset.z;
            carGroundCoord.x = r1;
            carGroundCoord.y = r2;
            carGroundCoord.z = r3;
            {
              int r1 = carGroundCoord.x + lengthVector.x;
              int r2 = carGroundCoord.y + lengthVector.y;
              int r3 = carGroundCoord.z + lengthVector.z;
              tireCoord[0].x = r1 - widthVector.x;
              tireCoord[0].y = r2 - widthVector.y;
              tireCoord[0].z = r3 - widthVector.z;
              tireCoord[1].x = r1 + widthVector.x;
              tireCoord[1].y = r2 + widthVector.y;
              tireCoord[1].z = r3 + widthVector.z;
              {
                int r1 = carGroundCoord.x - lengthVector.x;
                int r2 = carGroundCoord.y - lengthVector.y;
                int r3 = carGroundCoord.z - lengthVector.z;
                tireCoord[2].x = r1 - widthVector.x;
                tireCoord[2].y = r2 - widthVector.y;
                tireCoord[2].z = r3 - widthVector.z;
                tireCoord[3].x = r1 + widthVector.x;
                tireCoord[3].y = r2 + widthVector.y;
                tireCoord[3].z = r3 + widthVector.z;
              }
            }
          }
        }
      }
    }
  }
  coorddef wheelHeight [4];
  BWorldSm_Pos testSimRoadInfo;

  wheelsInAir = 0;
  bounce = 0;
  testSimRoadInfo = newtonObj->simRoadInfo;
  {
  coorddef roadNormal;
  coorddef roadCenterPoint;
  int roadSurfaceType;
  int wheelIndex;

  for (wheelIndex = 0;
       (int)((char *)newtonObj + wheelIndex * 0x30) < (int)((char *)newtonObj + 0xc0);
       wheelIndex = wheelIndex + 1) {
    wheelHeight[wheelIndex] = tireCoord[wheelIndex];
    ((Car_tObj *)newtonObj)->wheel[wheelIndex].actualHeight = tireCoord[wheelIndex].y;
    BWorldSm_FindClosestTriangleRez(&tireCoord[wheelIndex],&testSimRoadInfo,1);
    roadNormal = *(coorddef *)BWorldSm_UNormal(&testSimRoadInfo);
    roadSurfaceType = 0xe;
    if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0x0) {
      roadSurfaceType = (u_int)(testSimRoadInfo.simQuad)->surface;
    }
    ((Car_tObj *)newtonObj)->wheel[wheelIndex].roadSurfaceType = roadSurfaceType;
    roadSurfaceType = roadSurfaceType & 0xf;
    if (((roadNormal.y < 0x1999) || (roadSurfaceType == 0xe)) || (roadSurfaceType == 0)) {
      roadNormal.y = 0x10000;
      roadNormal.x = 0;
      roadNormal.z = 0;
      elevation.x = elevation.x + tireCoord[wheelIndex].x;
      elevation.y = elevation.y + (tireCoord[wheelIndex].y - newtonObj->objAltitude);
      elevation.z = elevation.z + tireCoord[wheelIndex].z;
    }
    else {
      if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0x0) {
        roadCenterPoint = testSimRoadInfo.quadPts[0];
      }
      else {
        roadCenterPoint = *(coorddef *)(BWorldSm_slices + testSimRoadInfo.slice);
      }
      if ((u_int)(roadSurfaceType - 2) < 2) {
        iVar20 = Newton_FindGroundElevationRough(&tireCoord[wheelIndex],&roadNormal,&roadCenterPoint)
        ;
        wheelHeight[wheelIndex].y = iVar20;
      }
      else {
        iVar20 = Newton_FindGroundElevationGeneral(&tireCoord[wheelIndex],&roadNormal,&roadCenterPoint);
        wheelHeight[wheelIndex].y = iVar20;
      }
      ((Car_tObj *)newtonObj)->wheel[wheelIndex].actualHeight = wheelHeight[wheelIndex].y;
      int wheelY = wheelHeight[wheelIndex].y;
      if (0x20000 < wheelY - tireCoord[wheelIndex].y) {
        roadNormal.x = 0;
        roadNormal.y = 0x10000;
        roadNormal.z = 0;
        wheelHeight[wheelIndex].y = tireCoord[wheelIndex].y;
        elevation.x = elevation.x + tireCoord[wheelIndex].x;
        elevation.y = elevation.y + tireCoord[wheelIndex].y;
        elevation.z = elevation.z + tireCoord[wheelIndex].z;
      }
      else {
        int r1 = wheelHeight[wheelIndex].x;
        int r3 = wheelHeight[wheelIndex].z;
        elevation.x = elevation.x + r1;
        elevation.y = elevation.y + wheelY;
        elevation.z = elevation.z + r3;
      }
    }
    {
      int r1 = wheelHeight[wheelIndex].x;
      int r2 = wheelHeight[wheelIndex].y;
      int r3 = wheelHeight[wheelIndex].z;
      ((Car_tObj *)newtonObj)->wheel[wheelIndex].currentPos.x = r1;
      ((Car_tObj *)newtonObj)->wheel[wheelIndex].currentPos.y = r2;
      ((Car_tObj *)newtonObj)->wheel[wheelIndex].currentPos.z = r3;
    }
    {
      int r1 = roadNormal.x;
      int r2 = roadNormal.y;
      int r3 = roadNormal.z;
      ((Car_tObj *)newtonObj)->wheel[wheelIndex].roadNormal.x = r1;
      ((Car_tObj *)newtonObj)->wheel[wheelIndex].roadNormal.y = r2;
      ((Car_tObj *)newtonObj)->wheel[wheelIndex].roadNormal.z = r3;
    }
  }
  }
  {
  coorddef wheelVec;
  int compressionValue [4];
  int count;
  int i;

  count = 0;
  wheelVec.x = 0;
  wheelVec.z = 0;
  for (i = 0; i < 4; i = i + 1) {
    int limit;

    wheelVec.y = (((Car_tObj *)newtonObj)->wheel[i].currentPos.y - tireCoord[i].y) / 2;
    ((Car_tObj *)newtonObj)->wheel[i].rebound = 0;
    if (wheelVec.y < -0x2665) {
      ((Car_tObj *)newtonObj)->wheel[i].wheelInAir = 1;
      wheelsInAir = wheelsInAir + 1;
    }
    else if (((Car_tObj *)newtonObj)->wheel[i].wheelInAir == 1) {
      if (wheelVec.y > 0) {
        bounce = bounce + 1;
        ((Car_tObj *)newtonObj)->wheel[i].wheelInAir = 0;
        ((Car_tObj *)newtonObj)->wheel[i].rebound = 1;
      }
      else if (((newtonObj->objAltitude < 0x3333) && (-0x1999 < (newtonObj->linearVel).y)) &&
               (0xf333 < (newtonObj->orientationToGround).y)) {
        ((Car_tObj *)newtonObj)->wheel[i].wheelInAir = 0;
      }
    }
    limit = -0x3333;
    if (0x358000 < newtonObj->speedXZ) {
      limit = -0x2666;
    }
    if (wheelVec.y < limit) {
      wheelVec.y = limit;
    }
    compressionValue[i] = (wheelVec.y / 0x100) * (carNormal.y / 0x100);
    ((Car_tObj *)newtonObj)->wheel[i].wheelAcc =
        (compressionValue[i] / 0x100) *
        (((Car_tObj *)newtonObj)->specs->suspensionStiffness / 0x100);
    if (*(int *)(*(int *)(newtonObj[1].simRoadInfo.quadPts16 + 1) + 0x40) == 1) {
      ((Car_tObj *)newtonObj)->wheel[i].wheelAcc =
          ((Car_tObj *)newtonObj)->wheel[i].wheelAcc * 2;
    }
  }
  {
    int i;

    if (bounce != 0) {
      count = newtonObj[1].simRoadInfo.forward.x + newtonObj[1].position.x +
              newtonObj[1].wheelRot[0] + newtonObj[1].orientMat.m[4];
    }
    for (i = 0; i < 4; i = i + 1) {
      int newWheelAcc;
      int wheelBounce;

      if (bounce == 0) {
        if ((((Car_tObj *)newtonObj)->wheel[i].wheelAcc < 0) &&
            (0xdc28 < (newtonObj->orientationToGround).y)) {
          newWheelAcc = ((Car_tObj *)newtonObj)->wheel[i].wheelAcc >> 1;
          goto storeWheelAcc;
        }
      }
      if ((bounce != 0) && (((Car_tObj *)newtonObj)->wheel[i].rebound != 0) &&
          ((newtonObj->linearVel).y < 0)) {
        int speed;

        speed = __builtin_abs((newtonObj->linearVel).y) + newtonObj->groundVel;
        if (-1 < speed) {
          wheelBounce = speed / count >> 1;
          if (speed < 0x100000) {
            int ratio;

            ratio = fixedmult(speed,0x1000);
            if (ratio >= 0x4ccd) {
              ratio = fixedmult(speed,0x1000);
            }
            else {
              ratio = 0x4ccc;
            }
            wheelBounce = fixedmult(ratio,wheelBounce);
          }
          newWheelAcc = ((Car_tObj *)newtonObj)->wheel[i].wheelAcc + wheelBounce;
          goto storeWheelAcc;
        }
      }
      goto nextWheel;
storeWheelAcc:
      ((Car_tObj *)newtonObj)->wheel[i].wheelAcc = newWheelAcc;
nextWheel:;
    }
  }
  {
    int i;

    for (i = 0; i < 4; i = i + 1) {
      int desiredCompression;

      desiredCompression =
          fixedmult((tireCoord[i].y - wheelHeight[i].y) >> 1,(newtonObj->orientMat).m[4]);
      if (desiredCompression > 0) {
        int limit = desiredCompression;
        if (limit >= ((Car_tObj *)newtonObj)->specs->tireRange) {
          limit = ((Car_tObj *)newtonObj)->specs->tireRange;
        }
        desiredCompression = limit;
      }
      else {
        if (desiredCompression < -((Car_tObj *)newtonObj)->specs->tireRange) {
          desiredCompression = -((Car_tObj *)newtonObj)->specs->tireRange;
        }
      }
      ((Car_tObj *)newtonObj)->wheel[swap[i]].impactCompression = desiredCompression;
    }
  }
  }
  coorddef tempVecX;
  coorddef tempVecY;
  coorddef tempVecZ;

      elevation.x = elevation.x >> 2;
      elevation.y = elevation.y >> 2;
      elevation.z = elevation.z >> 2;
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
      iVar20 = iVar20 - iVar24;
      tempVecY.x = iVar20;
      iVar20 = fixedmult(tempVecZ.z,tempVecX.x);
      iVar24 = fixedmult(tempVecZ.x,tempVecX.z);
      iVar20 = iVar20 - iVar24;
      tempVecY.y = iVar20;
      tempVecY.z = fixedmult(tempVecZ.x,tempVecX.y) -
                   fixedmult(tempVecZ.y,tempVecX.x);
      Math_NormalizeShortVector(&tempVecY);
      if (tempVecY.y >= 0) {
        normal->x = tempVecY.x;
        normal->y = tempVecY.y;
        normal->z = tempVecY.z;
        if (tempVecY.y <= 0x7fff) {
          wheelsInAir = 4;
        }
      }
      else {
        wheelsInAir = 4;
        normal->x = 0;
        normal->y = 0x10000;
        normal->z = 0;
      }
      if ((newtonObj->orientationToGround).y < -0xe666) {
        (newtonObj->angularVel).x = (newtonObj->angularVel).x * 0xfd / 0x100;
        (newtonObj->angularVel).y = (newtonObj->angularVel).y * 0xfd / 0x100;
        (newtonObj->angularVel).z = (newtonObj->angularVel).z * 0xfd / 0x100;
      }
      else if (wheelsInAir < 4) {
        matrixtdef transposeMat;
        int pitch;
        int roll;
        int temp;

        newtonObj[1].shadowMat.m[8] =
            fixedmult((newtonObj->angularVel).x,(newtonObj->orientMat).m[0]) +
            fixedmult((newtonObj->angularVel).y,(newtonObj->orientMat).m[1]) +
            fixedmult((newtonObj->angularVel).z,(newtonObj->orientMat).m[2]);
        newtonObj[1].shadowCoord[0].x =
            fixedmult((newtonObj->angularVel).x,(newtonObj->orientMat).m[3]) +
            fixedmult((newtonObj->angularVel).y,(newtonObj->orientMat).m[4]) +
            fixedmult((newtonObj->angularVel).z,(newtonObj->orientMat).m[5]);
        newtonObj[1].shadowCoord[0].y =
            fixedmult((newtonObj->angularVel).x,(newtonObj->orientMat).m[6]) +
            fixedmult((newtonObj->angularVel).y,(newtonObj->orientMat).m[7]) +
            fixedmult((newtonObj->angularVel).z,(newtonObj->orientMat).m[8]);

        pitch = (((Car_tObj *)newtonObj)->wheel[2].wheelAcc +
                 ((Car_tObj *)newtonObj)->wheel[3].wheelAcc -
                 (((Car_tObj *)newtonObj)->wheel[0].wheelAcc +
                  ((Car_tObj *)newtonObj)->wheel[1].wheelAcc)) >> 2;
        /* HISTORICAL RECEIPT (w55-a11): this fn was at 10 diffs / ours 903 vs oracle 905, and BOTH
           missing insns are the same NON-PROPAGATED REG-REG COPY: oracle loads the cap
           into $v0 and then `addu v1,v0,zero` into the clamp variable (here and again
           at the rollAngularVelCap site, 800A0B30 / 800A0BA8); ours loads straight into
           the clamp variable.  FALSIFIED IN THIS BASIN (each gated, all 10 except where
           noted): separate `cap` local copied into `limit`; opacity fence
           `asm("":"=r"(limit):"0"(limit))`; read-only fence `asm("":: "r"(limit))`;
           `limit` hoisted to the enclosing block so it spans both arms (05D global-
           allocno promotion); same with the `pitch = limit` tail hoisted out; ternary
           clamp (18, worse).  Same class as Physics_CalcWheelLockAcc/RampCarControlValues
        -- see the 06E "non-propagated reg-reg copy" instrument gap.
           RESOLVED: NFSU2 mobile exposes the original uninitialized two-arm
           result shape below; it preserves the v0-to-v1 copies naturally.
           Detailed gate: PASS, 905/905. */
        if (pitch > 0) {
          int limit;
          if (pitch <=
              ((Car_tObj *)newtonObj)->specs->pitchAngularVelCap) {
            limit = pitch;
          }
          else {
            limit = ((Car_tObj *)newtonObj)->specs->pitchAngularVelCap;
          }
          pitch = limit;
        }
        else {
          int limit = -((Car_tObj *)newtonObj)->specs->pitchAngularVelCap;
          if (limit < pitch) {
            limit = pitch;
          }
          pitch = limit;
        }

        roll = (((Car_tObj *)newtonObj)->wheel[0].wheelAcc +
                ((Car_tObj *)newtonObj)->wheel[2].wheelAcc -
                (((Car_tObj *)newtonObj)->wheel[1].wheelAcc +
                 ((Car_tObj *)newtonObj)->wheel[3].wheelAcc)) >> 2;
        if (roll > 0) {
          int limit;
          if (roll <=
              ((Car_tObj *)newtonObj)->specs->rollAngularVelCap) {
            limit = roll;
          }
          else {
            limit = ((Car_tObj *)newtonObj)->specs->rollAngularVelCap;
          }
          roll = limit;
        }
        else {
          int limit = -((Car_tObj *)newtonObj)->specs->rollAngularVelCap;
          if (limit < roll) {
            limit = roll;
          }
          roll = limit;
        }

        if (__builtin_abs(newtonObj[1].shadowMat.m[8]) < 0x13333) {
          newtonObj[1].shadowMat.m[8] =
              fixedmult(newtonObj[1].shadowMat.m[8],*(int *)(newtonObj[1].damage[3] + 0x130));
        }
        else {
          newtonObj[1].shadowMat.m[8] = fixedmult(newtonObj[1].shadowMat.m[8],0xd999);
        }
        newtonObj[1].shadowMat.m[8] = newtonObj[1].shadowMat.m[8] + pitch;

        temp = newtonObj[1].shadowCoord[0].y;
        if (__builtin_abs(temp) < 0x13333) {
          newtonObj[1].shadowCoord[0].y =
              fixedmult(temp,*(int *)(newtonObj[1].damage[3] + 0x134));
        }
        else {
          newtonObj[1].shadowCoord[0].y = fixedmult(temp,0xd999);
        }
        newtonObj[1].shadowCoord[0].y = newtonObj[1].shadowCoord[0].y - roll;

        transpose(&newtonObj->orientMat,&transposeMat);
        (newtonObj->angularVel).x =
            fixedmult(newtonObj[1].shadowMat.m[8],transposeMat.m[0]) +
            fixedmult(newtonObj[1].shadowCoord[0].x,transposeMat.m[1]) +
            fixedmult(newtonObj[1].shadowCoord[0].y,transposeMat.m[2]);
        (newtonObj->angularVel).y =
            fixedmult(newtonObj[1].shadowMat.m[8],transposeMat.m[3]) +
            fixedmult(newtonObj[1].shadowCoord[0].x,transposeMat.m[4]) +
            fixedmult(newtonObj[1].shadowCoord[0].y,transposeMat.m[5]);
        (newtonObj->angularVel).z =
            fixedmult(newtonObj[1].shadowMat.m[8],transposeMat.m[6]) +
            fixedmult(newtonObj[1].shadowCoord[0].x,transposeMat.m[7]) +
            fixedmult(newtonObj[1].shadowCoord[0].y,transposeMat.m[8]);
      }
      if (simGlobal.gameTicks < 0x40) {
        newtonObj->objAltitude = Newton_CalcPerpenHeightOfCenterPointFromGround
                                   (newtonObj,normal,&newtonObj->roadCenterPoint);
      }
      else {
        newtonObj->objAltitude = Newton_CalcPerpenHeightOfCenterPointFromGround
                                   (newtonObj,normal,&elevation);
      }
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
  int dist;
  int x;
  int z;
  int whichPlayer;
  int forcedSimOptz;

  whichPlayer = 0;
  forcedSimOptz = 0;
  x = (n->position).x - (Cars_gHumanRaceCarList[GameSetup_gData.localCar]->N).position.x;
  if (x < 1) { x = (Cars_gHumanRaceCarList[GameSetup_gData.localCar]->N).position.x - (n->position).x; }
  z = (n->position).z - (Cars_gHumanRaceCarList[GameSetup_gData.localCar]->N).position.z;
  if (z < 1) { z = (Cars_gHumanRaceCarList[GameSetup_gData.localCar]->N).position.z - (n->position).z; }
  if (z < x) {
    n->distToPlayer = x + (z >> 2);
  }
  else {
    n->distToPlayer = z + (x >> 2);
  }
  if (Cars_gNumHumanRaceCars == 2) {
    x = (n->position).x - (Cars_gHumanRaceCarList[1 - GameSetup_gData.localCar]->N).position.x;
    if (x < 1) { x = (Cars_gHumanRaceCarList[1 - GameSetup_gData.localCar]->N).position.x - (n->position).x; }
    z = (n->position).z - (Cars_gHumanRaceCarList[1 - GameSetup_gData.localCar]->N).position.z;
    if (z < 1) { z = (Cars_gHumanRaceCarList[1 - GameSetup_gData.localCar]->N).position.z - (n->position).z; }
    if (z < x) {
      dist = x + (z >> 2);
    }
    else {
      dist = z + (x >> 2);
    }
    if (dist < n->distToPlayer) {
      whichPlayer = 1;
      n->distToPlayer = dist;
    }
  }
  if (n->distToPlayer < 0x600001) {
    if (BWorld_CheckChunkVisible(&(Cars_gHumanRaceCarList[whichPlayer]->N).simRoadInfo,&n->simRoadInfo)
        == 0) {
      forcedSimOptz = 1;
    }
  }
  if ((0x600000 < n->distToPlayer) || (forcedSimOptz != 0)) {
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
  }
  {
    int oldOptz;

    oldOptz = n->simOptz;
    if (((n[1].simRoadInfo.quadPts[1].y & 0x30U) == 0) &&
       (((n[3].lastUpdated == 0 || (simGlobal.gameTicks < 3)) && (0x480000 < n->distToPlayer)))) {
      n->simOptz = '\x01';
    }
    else {
      n->simOptz = '\0';
    }
    if (1 < oldOptz) {
      Cars_SetCarUpForHiRezSim((Car_tObj *)n);
      Newton_FindClosestQuad(n);
      Newton_UpdateRoadGeometry(n);
      Newton_LimitCarsToDrivableDist(n);
      if (stackSpeedUpEnbabledFlag != 0) {
        gWSavePtr = SetSp(gWSavePtr);
        stackSpeedUpEnbabledFlag = 0;
        n->groundElevation = Newton_FindGroundElevationAndNormal(n,&dummy_124);
        gWSavePtr = SetSp(gWSavePtr);
        stackSpeedUpEnbabledFlag = 1;
      }
      else {
        n->groundElevation = Newton_FindGroundElevationAndNormal(n,&dummy_124);
      }
      n->groundSurfaceType = 1;
      n->driveSurfaceType = 1;
      n->groundVel = 0;
      (n->collision).impulse = 0;
      (n->collision).otherObj = (BO_tNewtonObj *)0x0;
      n->objAltitude = 0;
      (n->position).y = n->groundElevation + (n->dimension).y;
    }
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
  int backwards;
  coorddef rOffset;
  matrixtdef transposeMat;

  backwards = direction != 1;
  BWorldSm_SetSlice(slice,&n->simRoadInfo);
  n->totalSlice = (u_short)slice;
  n->roadMatrix.m[0] = (signed char)BWorldSm_slices[slice].right[0] << 9;
  n->roadMatrix.m[1] = (signed char)BWorldSm_slices[slice].right[1] << 9;
  n->roadMatrix.m[2] = (signed char)BWorldSm_slices[slice].right[2] << 9;
  n->roadMatrix.m[3] = (signed char)BWorldSm_slices[slice].normal[0] << 9;
  n->roadMatrix.m[4] = (signed char)BWorldSm_slices[slice].normal[1] << 9;
  n->roadMatrix.m[5] = (signed char)BWorldSm_slices[slice].normal[2] << 9;
  n->roadMatrix.m[6] = (signed char)BWorldSm_slices[slice].forward[0] << 9;
  n->roadMatrix.m[7] = (signed char)BWorldSm_slices[slice].forward[1] << 9;
  n->roadMatrix.m[8] = (signed char)BWorldSm_slices[slice].forward[2] << 9;
  Math_NormalizeShortVector((coorddef *)&n->roadMatrix);
  Math_NormalizeShortVector((coorddef *)(n->roadMatrix.m + 3));
  Math_NormalizeShortVector((coorddef *)(n->roadMatrix.m + 6));
  transpose(&n->roadMatrix,&transposeMat);
  Newton_CopyRoadMatrixToOrientMat(n,backwards);
  Newton_CopyRoadMatrixToShadowMat(n,backwards);

  rOffset.x = fixedmult(offset->x,transposeMat.m[0]) +
              fixedmult(offset->y,transposeMat.m[1]) +
              fixedmult(offset->z,transposeMat.m[2]);
  rOffset.y = fixedmult(offset->x,transposeMat.m[3]) +
              fixedmult(offset->y,transposeMat.m[4]) +
              fixedmult(offset->z,transposeMat.m[5]);
  rOffset.z = fixedmult(offset->x,transposeMat.m[6]) +
              fixedmult(offset->y,transposeMat.m[7]) +
              fixedmult(offset->z,transposeMat.m[8]);

  n->position.x = rOffset.x + BWorldSm_slices[slice].center[0];
  n->position.y = rOffset.y + BWorldSm_slices[slice].center[1];
  n->position.z = rOffset.z + BWorldSm_slices[slice].center[2];
  if (((Car_tObj *)n)->carFlags & 4) {
    n->simOptz = 0;
  } else {
    n->simOptz = 2;
  }
  Newton_FindClosestQuad(n);
  Newton_UpdateRoadInfo(n);
  Newton_UpdateRoadGeometry(n);
  Newton_CopyRoadMatrixToOrientMat(n,backwards);
  Newton_CopyRoadMatrixToShadowMat(n,backwards);
  if (n->simOptz == 2) {
    n->groundElevation = BWorldSm_slices[slice].center[1];
  } else if (n->simOptz == 1) {
    int i;
    int quadCenterY = 0;

    for (i = 0; i < 4; i++) {
      coorddef temp;

      if (n->simRoadInfo.simQuad != (Trk_NewSimQuad *)0) {
        temp = n->simRoadInfo.quadPts[i];
      } else {
        temp = *(coorddef *)BWorldSm_slices[n->simRoadInfo.slice].center;
      }
      quadCenterY += temp.y;
    }
    quadCenterY /= 4;
    n->groundElevation = quadCenterY;
  } else {
    if (stackSpeedUpEnbabledFlag != 0) {
      gWSavePtr = SetSp(gWSavePtr);
      stackSpeedUpEnbabledFlag = 0;
      n->groundElevation = Newton_FindGroundElevationAndNormal(n,&dummy_133);
      gWSavePtr = SetSp(gWSavePtr);
      stackSpeedUpEnbabledFlag = 1;
    } else {
      n->groundElevation = Newton_FindGroundElevationAndNormal(n,&dummy_133);
    }
    n->position.y = n->groundElevation + n->dimension.y;
  }
  int altitude;

  altitude = Newton_CalcPerpenHeightOfLowestPointFromGround(
      n,(coorddef *)(n->roadMatrix.m + 3),&n->roadCenterPoint);
  *(volatile int *)&n->objAltitude = altitude;
  n->objAltitude = 0;
  n->position.y -= altitude;
  int surfaceType;

  if (n->simOptz == 0) {
    surfaceType = 0xe;
    if (n->simRoadInfo.simQuad != (Trk_NewSimQuad *)0) {
      n->groundSurfaceType = n->simRoadInfo.simQuad->surface;
      goto NewtonSetInitSlice_setDriveSurf;
    }
  } else {
    surfaceType = 1;
  }
  n->groundSurfaceType = surfaceType;
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
extern "C" int Newton_OptzRotxform__FP10matrixtdefiiiPiiT4(
    matrixtdef *m,int ax,int ay,int az,int *reOrthoNeeded,
    int reOrthoLimit,int *cumulatedRot)

{
  matrixtdef mx;
  matrixtdef my;
  matrixtdef mz;
  matrixtdef mt;
  int changed;
  int absx;
  int absy;
  int absz;

  absx = __builtin_abs(ax);
  absy = __builtin_abs(ay);
  absz = __builtin_abs(az);
  *reOrthoNeeded = 0;
  *cumulatedRot += absx + absy + absz;
  fixedxformy(&my,ay);
  changed = absy > 19;
  if (absx > 13) {
    fixedxformx(&mx,ax);
    Math_fasttransmult(&mx,&my,&mt);
    changed = 1;
  }
  else {
    mt = my;
  }
  if (absz > 13) {
    fixedxformz(&mz,az);
    Math_fasttransmult(&mt,&mz,m);
    changed = 1;
  }
  else {
    *m = mt;
  }
  return changed;
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
    iVar2 = Newton_OptzRotxform__FP10matrixtdefiiiPiiT4(&mStack_50,angularVel.x,angularVel.y,angularVel.z,aiStack_18,0x1000,newtonObj + 0x98);
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
    iVar2 = Newton_OptzRotxform__FP10matrixtdefiiiPiiT4(&mStack_50,angularVel.x,angularVel.y,angularVel.z,aiStack_18,0x2000,newtonObj + 0x98);
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
  if (((*(u_int *)(newtonObj + 0x260) & 4) == 0) && (0xe666 < orientToGround)) {
    *(matrixtdef *)(newtonObj + 0x1c4) = *(matrixtdef *)(newtonObj + 0xf0);
    {
      int r1;
      int r2;
      int r3;

      r1 = *normal;
      r2 = normal[1];
      r3 = normal[2];
      *(int *)(newtonObj + 0x1d0) = r1;
      *(int *)(newtonObj + 0x1d4) = r2;
      *(int *)(newtonObj + 0x1d8) = r3;
    }
    return;
  }
  {
    int r1;
    int r2;
    int r3;

    r1 = *normal;
    r2 = normal[1];
    r3 = normal[2];
    *(int *)(newtonObj + 0x1d0) = r1;
    *(int *)(newtonObj + 0x1d4) = r2;
    *(int *)(newtonObj + 0x1d8) = r3;
  }
  if (orientToGround < 0x8000) {
    int dot;

    dot = *(int *)(newtonObj + 0xf0) / 256 * (*normal / 256) +
          *(int *)(newtonObj + 0xf4) / 256 * (normal[1] / 256) +
          *(int *)(newtonObj + 0xf8) / 256 * (normal[2] / 256);
    if (dot < 0) {
      dot = -dot;
    }
    if (0.5 < (double)dot) {
      *(int *)(newtonObj + 0x1c4) =
           fixedmult(*(int *)(newtonObj + 0x1d4),*(int *)(newtonObj + 0x110)) -
           fixedmult(*(int *)(newtonObj + 0x1d8),*(int *)(newtonObj + 0x10c));
      *(int *)(newtonObj + 0x1c8) =
           fixedmult(*(int *)(newtonObj + 0x1d8),*(int *)(newtonObj + 0x108)) -
           fixedmult(*(int *)(newtonObj + 0x1d0),*(int *)(newtonObj + 0x110));
      *(int *)(newtonObj + 0x1cc) =
           fixedmult(*(int *)(newtonObj + 0x1d0),*(int *)(newtonObj + 0x10c)) -
           fixedmult(*(int *)(newtonObj + 0x1d4),*(int *)(newtonObj + 0x108));
      Math_NormalizeShortVector((coorddef *)(newtonObj + 0x1c4));
      *(int *)(newtonObj + 0x1dc) =
           fixedmult(*(int *)(newtonObj + 0x1c8),*(int *)(newtonObj + 0x1d8)) -
           fixedmult(*(int *)(newtonObj + 0x1cc),*(int *)(newtonObj + 0x1d4));
      *(int *)(newtonObj + 0x1e0) =
           fixedmult(*(int *)(newtonObj + 0x1cc),*(int *)(newtonObj + 0x1d0)) -
           fixedmult(*(int *)(newtonObj + 0x1c4),*(int *)(newtonObj + 0x1d8));
      *(int *)(newtonObj + 0x1e4) =
           fixedmult(*(int *)(newtonObj + 0x1c4),*(int *)(newtonObj + 0x1d4)) -
           fixedmult(*(int *)(newtonObj + 0x1c8),*(int *)(newtonObj + 0x1d0));
      Math_NormalizeShortVector((coorddef *)(newtonObj + 0x1dc));
      return;
    }
  }
  *(int *)(newtonObj + 0x1dc) =
       fixedmult(*(int *)(newtonObj + 0xf4),*(int *)(newtonObj + 0x1d8)) -
       fixedmult(*(int *)(newtonObj + 0xf8),*(int *)(newtonObj + 0x1d4));
  *(int *)(newtonObj + 0x1e0) =
       fixedmult(*(int *)(newtonObj + 0xf8),*(int *)(newtonObj + 0x1d0)) -
       fixedmult(*(int *)(newtonObj + 0xf0),*(int *)(newtonObj + 0x1d8));
  *(int *)(newtonObj + 0x1e4) =
       fixedmult(*(int *)(newtonObj + 0xf0),*(int *)(newtonObj + 0x1d4)) -
       fixedmult(*(int *)(newtonObj + 0xf4),*(int *)(newtonObj + 0x1d0));
  Math_NormalizeShortVector((coorddef *)(newtonObj + 0x1dc));
  *(int *)(newtonObj + 0x1c4) =
       fixedmult(*(int *)(newtonObj + 0x1d4),*(int *)(newtonObj + 0x1e4)) -
       fixedmult(*(int *)(newtonObj + 0x1d8),*(int *)(newtonObj + 0x1e0));
  *(int *)(newtonObj + 0x1c8) =
       fixedmult(*(int *)(newtonObj + 0x1d8),*(int *)(newtonObj + 0x1dc)) -
       fixedmult(*(int *)(newtonObj + 0x1d0),*(int *)(newtonObj + 0x1e4));
  *(int *)(newtonObj + 0x1cc) =
       fixedmult(*(int *)(newtonObj + 0x1d0),*(int *)(newtonObj + 0x1e0)) -
       fixedmult(*(int *)(newtonObj + 0x1d4),*(int *)(newtonObj + 0x1dc));
  Math_NormalizeShortVector((coorddef *)(newtonObj + 0x1c4));
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
  __asm__("" : : "i"(0));   /* w62-a11 reorg slot-steal barrier, see receipt */
  barrierVec.x = -(normal.z / 0x100 * 0x100);
  __asm__("" : : "i"(0));   /* w62-a11 reorg slot-steal barrier, see receipt */
  barrierVec.y = 0;
  barrierVec.z = normal.x / 0x100 * 0x100;
  distRetreat = normal.x / 0x100 * (newtonObj->linearVel.x / 0x100) +
                normal.y / 0x100 * (newtonObj->linearVel.y / 0x100) +
                *(volatile int *)&normal.z / 0x100 * (newtonObj->linearVel.z / 0x100);
  if (distRetreat < 0) {
    distRetreat = -distRetreat;
  }
  /* MATCH (w55-a11): plain `/0x10` replaces a hand-written `if(x<0)x+=0xf; x>>=4`
     guard -- that guard IS gcc's own signed power-of-2 divide (83->81, and a
     semantic correction: the hand form was a transcription of the codegen). */
  distRetreat = -distRetreat / 0x10;
  if (-0x7ad <= distRetreat) {
    distRetreat = -0x7ae;
  }
  /* RECEIPT (w55-a11): residual 81, ours 101 vs oracle 106 -- the 5-insn gap is the
     PARM-SPILL + non-propagated-copy pair.  SYM decode (VA 800A2AF0): the by-value
     coorddef param has NO SYM record; AUTO -0x58 = the local `barrierVec` @sp+0x18,
     upVec -0x48 @sp+0x28, islandMatrix -0x38 @sp+0x38, impactVel REG $16,
     distRetreat REG $3; the incoming struct is spilled by assign_parms to
     0x74/0x78/0x7C(sp) and RE-LOADED for normal.z (0x7C) inside the dot product,
     while normal.x is kept live in $a3 (`addu a3,a1,zero`) all the way to
     islandMatrix.m[0].  Every /256 in the oracle carries the extra
     `addu vN,src,zero` copy because its dividend stays live; ours mutates in place.
     MEASURED: div16+clamp-if 81 | div16+clamp-ternary 81 | neg-as-own-statement 83
     (both clamp forms).
     w59-a2 CLOSED BOTH "NEXT ANGLES" -- BOTH FALSIFIED, do not retry:
       (a) 06B parm-spill fence `__asm__("" : : "i"(0));` before the first statement: 83.
       (b) `int normalX = normal.x;` held across the body and used for barrierVec.z /
           the dot product / islandMatrix.m[0]: 95 @ 99 insns (gcc coalesces it and
           DROPS two more insns -- exactly the wrong direction).
       (c) pressure fences `__asm__("" : : "r"(normal.x))` / `+ "r"(normal.z)` after
           barrierVec.z: 82 @ 102 and 83 @ 103 (they add insns, but not retail's).
     RE-DIAGNOSIS (w59-a2): the 5-insn gap is NOT parm-spill placement -- it is that
     retail SPILLS the `normal.z` pseudo and RE-READS it (`lw t2,124(sp)`) for the dot
     product, then RECOMPUTES `normal.z / 0x100` there (`addu v1,t2,zero; addiu
     v1,t2,255; sra v1,v1,8`), i.e. retail does NOT cse `normal.z / 0x100` between
     `barrierVec.x` and the dot; ours keeps it in a register across.  Same story for
     `addu a3,a1,zero` (retail parks normal.x in a3 for the whole body).  This is a
     register-PRESSURE basin, so the reachable instrument is allocsim/reqdelta on the
     three parm pseudos, not another fence guess.
     w59-a2 ROUND 2 -- the W59-A11 mobile twin (sub_4FDB9E, brief at
     scratchpad/w59a11/Newton_DoPostBarrierCollisionHandling_twin.md) predicts the
     dot product was a LIVE EXPRESSION inside nested PHY_ABS/MIN macros (emitted
     TWICE).  MEASURED ON PSX -- ALL FALSIFIED, do not retry:
       - full PHY_ABS macro with the dot expression re-emitted per arm:
         139 @ 119 insns (the PSX oracle is 106 -- retail's gcc CSE'd the second
         copy, so the x86 double-emission is a mobile-compiler artifact);
       - `<= 0` instead of `< 0` on the abs test: 81 (neutral);
       - MIN macro form `(-d/0x10 <= -0x7ae) ? -d/0x10 : -0x7ae`: 81 (neutral),
         with or without the `<= 0` abs;
       - `distRetreat > -0x7ae` clamp polarity: 81 (neutral);
       - twin B2 `-0x100 * (normal.z / 0x100)` + `(normal.x / 0x100) << 8`:
         81 (neutral);
       - twin B3 dot term order z + y + x: 89;
       - twin B1 upVec constants written straight into islandMatrix.m[3..5] (dropping
         the upVec local): 97 @ 95 insns (the SYM's upVec AUTO is real -- keep it).
     W60-A9 LANDED (81 -> 76 @ 104/106): the w59-a2 re-diagnosis was RIGHT and its
     named instrument (allocsim) was not needed -- the VOLATILE-VIEW RE-READ is the
     device.  `*(volatile int *)&normal.z` on the DOT-PRODUCT term only defeats cse's
     substitution of the live `normal.z` pseudo, so gcc re-loads the parm spill slot
     and RECOMPUTES `normal.z / 0x100` there, exactly as retail does (+3 insns of the
     right kind).  MEASURED this wave, all WORSE, do not retry: volatile on ALL three
     dot terms 87 @109 | volatile on x+z only 84 @108 | ": : : memory" before the
     dot 90 @108 | volatile also on normal.y in the dot 81 @105 | volatile also on
     the barrierVec.x read 87 @105 | on the barrierVec.z read 88 @108 | hoisting
     "normal.y / 0x100" into a local before the dot (volatile 92 @106 COUNT-EXACT,
     plain 88 @102) | hoisting x+y both 88 @102.
     RESIDUAL SHAPE (76): retail's three /256 expansions each carry TWO copies --
     a survivor copy (addu a3,a1,zero) AND expand_divmod's own fresh temp
     (addu v0,a3,zero in the bgez delay slot) -- and retail hoists normal.y/0x100
     ahead of the first mult.  Ours mutates the source register in place for two of
     the three.  Per the w44 rule gcc-2.8 cannot emit a source-level survivor copy of
     a divide's dividend (expand_divmod copies, cse copy-props the survivor away), so
     the survivor must come from a DISTINCT 1-insn computation.
     W61-A11 -- a fence-POSITION sweep (the HeliCam lesson: position is a dial of
     its own) found the COUNT-EXACT basin this receipt was missing.  All measured
     against the shipped 76 @104/106:
       "r"(normal.x) before barrierVec.x 75 @105 | between barrierVec.x and .z
       75 @105 | after the dot 77 @105 | before the dot only 77 @105 |
       "r"(normal.y) before all 75 @105 | "r"(normal.z) before all 75 @105 |
       "r"(normal.x) with TWO operands before all 76 @ 106/106 |
       "r"(normal.x) + "r"(normal.y) before all 76 @ 106/106.
     => two extra refs on the parm pseudos buy retail's TWO missing insns exactly
     (they are the survivor/temp copies named above), at the SAME diff count.
     NOT LANDED (hard-floor-basin rule: equal, not better).  NEXT ANGLE = enter the
     N7 basin (two read-only fences on normal.x/normal.y as the first statements)
     and dial the residual THERE -- a count-exact register rotation is a far better
     base than the shipped 2-insn-short form.  The instrumented cc1plus IS available
     for this fn (byte-identical; scratchpad/w61a11/newb.trace.txt, produced by
     scratchpad/w61a11/icefix.py which blanks the five bodies that ICE it).
     W62-A11 LANDED 76 -> 73 (@105/106).  The N7 fence basin was RE-PRICED and is
     WRONG: `"r"(normal.x)`-style read-only fences on the by-value parm components
     are NOT zero-insn here (each emits a real `addu t4,aN,zero`), so the w61-a11
     "count-exact 106/106" was 104 good insns + 2 junk copies; re-measured this wave
     it scores 80, not 76.  Do not re-enter it.  THE DEVICE IS THE VOID FENCE:
     `__asm__("" : : "i"(0))` between `upVec.z = 0;` and `barrierVec.x`, and a second
     one between `barrierVec.x` and `barrierVec.y`.  Mechanism: reorg was STEALING the
     `sw zero,48(sp)` (upVec.z) backwards into the first `bgez a3` delay slot; retail
     emits that store BEFORE the branch and fills the slot with the divide's own
     dividend copy.  The barrier restores retail's prologue block EXACTLY (insns 0-12
     now align 1:1) and gives the normal.x divide its `addu v0,a1,zero` survivor.
     POSITION SWEEP (all gated this wave, single void fence): before upVec.x 78 |
     after upVec.y 76 | after upVec.z 74 | after barrierVec.x 74 | after barrierVec.y
     74 | after barrierVec.z 76.  PAIRS: P2+P3 73 @105 | P2+P4 73 @105 | P2+P4+P5 73 |
     P2+P3+P4 73 | P3+P4 74.  `__volatile__` flavour is NEUTRAL (74 either way).
     RESIDUAL 73 SHAPE: the z- and y-divides still mutate the dividend in place
     (`addiu a3,a3,255`) where retail copies it to a fresh temp first
     (`addu v0,a3,zero; addiu v0,a3,255; sra v0,v0,8`) -- but the INSN COUNT per
     divide already matches (reorg duplicates the `sra` into the slot instead), so
     this is a pure allocation question: retail's divide temp did not coalesce with
     the dividend pseudo, ours did (delete_noop_moves).  FALSIFIED ON THIS BASE
     (04Z re-price, do not retry): `int nz` shared bvx+m2 83 | nz laundered 78 |
     nz feeding the dot instead of the volatile view 73 @101 | `int ny` shared
     dot+m1 77 | ny laundered 82 | `int nx` survivor to m[0] 88, laundered 90 |
     read-only fence on normal.x 76 / .y 76 / .z 75 | m[1] or m[2] read through a
     volatile view 73 (neutral) | a 3rd void fence before/after the dot or before
     the abs 73 (neutral).  13B identity-launder is FALSIFIED here in every
     placement; the remaining lever class is the qty STRUCTURE of the two divides. */
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
/* RECEIPT (w57-a9): 113 -> 75.  The two `temp.x/.y/.z = BWorldSm_slices[..].center[k]`
   triples are a STRUCT COPY in retail (oracle loads all 3 into t1/t2/t3 THEN stores
   all 3 -- the gcc block-move shape), not field-by-field (ours interleaved
   lw/nop/sw x3).  Written as `temp = *(coorddef *)....center;`.
   RESIDUAL 75 = (a) `temp = testSimRoadInfo.quadPts[j]` -- retail STRENGTH-REDUCES to
   an incrementing pointer (`addiu a2,a2,12` + a separate `addiu a3,a3,1` counter,
   loads at 0/4/8(a2)); ours emits the index form (`sll v0,v0,2; addu v0,v0,s3`).
   (b) the pBVar13+0x28c coorddef copy.  FALSIFIED: converting the two
   `label: if (j<4) {...goto label;}` loops to `while (j < 4) {...}` -- 73 -> 163,
   gcc rotates and re-colors the whole body.  The goto shape IS retail's; the
   pointer-walk must come from the SOURCE (a real `coorddef *` cursor), not from
   letting gcc's loop optimizer see a structured loop. */
/* RECEIPT (w59-a2): 75 -> 73, count 467 (oracle 470).  The w57-a9 prediction was
   RIGHT: a real `coorddef *quadPt` cursor (fn-scope, `quadPt =
   testSimRoadInfo.quadPts;` at each loop's j=0, `temp = *quadPt;`, `quadPt =
   quadPt + 1;`) makes BOTH loop bodies BYTE-EXACT vs retail -- `lw t2,0(a2); lw
   t3,4(a2); lw t4,8(a2); ... j T; addiu a2,a2,12` with the separate `addiu a3,a3,1`
   counter (SYM $7 = $a3 for `j`, confirmed).  COST: dropping the
   `testSimRoadInfo.quadPts[j]` reference removes refs from the hoisted
   `&testSimRoadInfo` allocno, which rotated the whole callee-saved band by one
   (75 -> 83).  CURE = a 4-operand read-only fence on `collision_type` right after its
   init (dial swept: n=1 85, n=2 77, n=3 77, n=4..7 73, n=8..10 93, n>=12 ICE) --
   restores the giv to $s5 and the prologue save order, 83 -> 73.
   FALSIFIED (each gated): two BLOCK-scope quadPt decls instead of one fn-scope 83
   (identical -- the rotation is ref-count driven, not pseudo-count driven);
   `__asm__("" : : "r"(&testSimRoadInfo))` xN in the loops to buy the lost refs
   137/141/125/149 (an `&global` fence is NOT zero-insn -- it emits lui/addiu);
   swapping the `local_2c = 0;` / `pBVar13 = newtonObj;` init order 75.
   RESIDUAL 73 = a clean 2-way $s3<->$s6 swap (ours collision_type=$s3 and
   &testSimRoadInfo=$s6; retail $s6 / $s3 per SYM $0x16 for collision_type) plus the
   `lui v0,0; addiu a2,v0,0` self-vs-separate-temp and two `sw zero,20(sp)` sched
   positions.  Next angle = allocsim/reqdelta priced dial on the &testSimRoadInfo
   allocno (raise ITS priority rather than lowering collision_type's -- the fence can
   only add refs, and n=0 already puts collision_type one rank too high at $s5).
   W61-A11 TOOL NOTE: the instrumented cc1plus (scratch/gccbuild-ecoff) ICEs on THIS
   function's body, so the tools/qtytrace.py local-alloc route is CLOSED here (the
   ICE also truncates the whole-TU trace -- scratchpad/w61a11/icefix.py blanks it and
   the four other ICE-ing newton bodies so the rest of the TU still traces).  The
   global layer (tools/allocsim.py / reqdelta.py off the real CC1PLPSX -dg dump) is
   unaffected and remains the named instrument.
   W62-A11 -- NEW NAMED ANGLE, and it CONTRADICTS the '2-way seat swap only'
   reading above: a BRANCH CENSUS (scratchpad/w62a11/brdist.py, which compares the
   per-branch instruction DISTANCE ours-vs-oracle -- the one thing verify_asm is
   blind to, since it normalises branch targets) says ours emits 47 branches and
   retail 48.  A whole conditional is MISSING or fused in our source, so the seat
   swap is downstream of a control-flow difference and NO allocator dial can close
   this fn until the 48th branch is found.  Run brdist.py first, localise the arm,
   then re-price.  (Same census found the arm-1 funnel that took
   Physics_CalculateTireForces 55 -> 49 in this wave.)
   W63-A11 -- THE 48th BRANCH IS LOCALISED AND FULLY CHARACTERISED (73 -> 70; the
   two per-arm `normal.y = 0;` tails landed, the branch itself is still open):
     oracle @0x800A34F0  beqz $s6, .L800A3594     <- collision_type == 0 -> NEXT i
     oracle @0x800A34F4   addu $t3,$zero,$zero    <- [delay slot] SLD 2321
     oracle @0x800A34F8  bnez $t3, .L800A35AC     <- SLD 2327 -> the EPILOGUE
   The two targets DIFFER (loop-continue vs return), so it is NOT an `&&` on the
   collision_type test: retail has a SECOND, NESTED guard `if (<x>) return;` as the
   first statement of the `if (collision_type != 0)` block, on a value its compiler
   const-propagated to a register 0 but did not fold away.  SYM confirms two Block
   starts at that very VA (rel line 162 and 167 off base 2161).
   WHAT IT IS NOT: `newHeight`.  The SYM classes it `AUTO -48 sp+128`, i.e. memory
   (our recon takes its address for BWorldSm_FindEdgeOff, and so did retail), so a
   test on it emits `lw`+`nop`+`bnez` = +4 insns: measured 74 @472.  The tested
   lvalue is therefore SYM-invisible (an expression, not a listed local).
   PROOF THAT THE SHAPE IS REACHABLE AND IS THE WHOLE COUNT GAP: a laundered zero
   (`int p = 0; __asm__("" : "=r"(p) : "0"(p)); if (p != 0) return;`) emits exactly
   `addu $tN,$zero,$zero` + `bnez` and gates COUNT-EXACT 470/470 (72 diffs -- LCS is
   non-monotone, 09K).  NOT LANDED: that is scaffolding nobody would write, and the
   residual after it is the pure $s3<->$s6 + $t3/$t4/$t5/$t1 seat rotation.  Naming
   the real lvalue is the one remaining question on this fn. */
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
  coorddef *quadPt;
  
  collision_type = 0;
  /* w59-a2: 4-operand read-only fence = allocno priority dial (SYM $0x16 = $s6). */
  __asm__("" : : "r"(collision_type), "r"(collision_type), "r"(collision_type), "r"(collision_type));
  newHeight = 0;
  cautionaryCenter = newtonObj->roadCenterPoint;
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
                quadPt = testSimRoadInfo.quadPts;
NewtonTestUndrv_loop1:
                if (j < 4) {
                  if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0x0) {
                    temp = *quadPt;
                  }
                  else {
                    temp = *(coorddef *)BWorldSm_slices[testSimRoadInfo.slice].center;   /* w57-a9: struct-copy (load3/store3 block), NOT field-by-field */
                  }
                  undrivableCenter.x = undrivableCenter.x + temp.x;
                  undrivableCenter.y = undrivableCenter.y + temp.y;
                  undrivableCenter.z = undrivableCenter.z + temp.z;
                  quadPt = quadPt + 1;
                  j = j + 1;
                  goto NewtonTestUndrv_loop1;
                }
                undrivableCenter.x /= 4;
                undrivableCenter.y /= 4;
                undrivableCenter.z /= 4;
                normal.x = cautionaryCenter.x - undrivableCenter.x;
                normal.z = cautionaryCenter.z - undrivableCenter.z;
                /* MATCH (w63-a11, 09J each-arm-carries-its-own-tail): retail
                   writes `normal.y = 0;` at the END OF EACH ARM as well as at the
                   join -- the SLD attributes an extra `sw zero,20(sp)` to 2290
                   (this arm) and 2313 (the else arm), on top of the joined one at
                   2317.  Ours had it only at the join.  Both arms 73->70; arm1
                   alone 72@468, arm2 alone 71@467, y-between-x-and-z 88. */
                normal.y = 0;
              }
            }
            else {
              int j;
              coorddef temp;

              undrivableCenter.z = 0;
              undrivableCenter.y = 0;
              undrivableCenter.x = 0;
              j = 0;
              quadPt = testSimRoadInfo.quadPts;
NewtonTestUndrv_loop2:
              if (j < 4) {
                if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0x0) {
                  temp = *quadPt;
                }
                else {
                  temp = *(coorddef *)BWorldSm_slices[testSimRoadInfo.slice].center;   /* w57-a9: struct-copy (load3/store3 block), NOT field-by-field */
                }
                undrivableCenter.x = undrivableCenter.x + temp.x;
                undrivableCenter.y = undrivableCenter.y + temp.y;
                undrivableCenter.z = undrivableCenter.z + temp.z;
                quadPt = quadPt + 1;
                j = j + 1;
                goto NewtonTestUndrv_loop2;
              }
              undrivableCenter.x /= 4;
              undrivableCenter.y /= 4;
              undrivableCenter.z /= 4;
              normal.x = (newtonObj->position).x - undrivableCenter.x;
              normal.z = (newtonObj->position).z - undrivableCenter.z;
              normal.y = 0;   /* MATCH: per-arm tail, see the arm-1 receipt above */
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
extern "C" void Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj(BO_tNewtonObj *newtonObj)
{
  int elevationOfGround;
  int objAltitude;
  int groundVel;
  int relativeClosingVelocity;
  coorddef normal;
  coorddef shadowNormal;
  int timeCount;
  int elapsedTime;
  int iTimeCount;
  int modifiedGravity;

  modifiedGravity = 0x4800;
  if (newtonObj->active &&
      Sched_ExecuteCheck(1,3,newtonObj->distToPlayer,newtonObj->objID,
                         &timeCount,&elapsedTime,&iTimeCount,
                         ((Car_tObj *)newtonObj)->forceNoSimOptz)) {
    if (newtonObj->simOptz >= 2) {
      newtonObj->linearVel.y = 0;
      newtonObj->flightTime = 0;
      elevationOfGround =
          Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef(
              (int)newtonObj,&normal);
      newtonObj->position.y = elevationOfGround + newtonObj->dimension.y;
    } else {
      elevationOfGround = Newton_FindGroundElevationAndNormal(newtonObj,&normal);
      shadowNormal = normal;
      relativeClosingVelocity = newtonObj->groundElevation;
      newtonObj->groundElevation = elevationOfGround;
      groundVel = (elevationOfGround - relativeClosingVelocity) * timeCount;
      objAltitude = newtonObj->objAltitude;
      newtonObj->linearVel.y -=
          fixedmult(elapsedTime * modifiedGravity,newtonObj->gravityMult);
      newtonObj->orientationToGround.y =
          fixedmult(newtonObj->orientMat.m[3],normal.x) +
          fixedmult(newtonObj->orientMat.m[4],normal.y) +
          fixedmult(newtonObj->orientMat.m[5],normal.z);
      Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi(
          (int)newtonObj,(int *)&shadowNormal,newtonObj->orientationToGround.y);

      newtonObj->speedXZ =
          Math_BetterDist(__builtin_abs(newtonObj->linearVel.x),
                          __builtin_abs(newtonObj->linearVel.z));

      newtonObj->roadGravityModifier =
          (newtonObj->roadGravityModifier * 7 +
           (groundVel - newtonObj->groundVel)) / 8;
      newtonObj->groundVel = groundVel;

      if (objAltitude >= 0x3333) {
        newtonObj->roadGravityModifier = 0;
        newtonObj->flightTime += elapsedTime;
        newtonObj->linearVel.y -=
            fixedmult(elapsedTime * modifiedGravity,newtonObj->gravityMult);
      } else {
        if (newtonObj->flightTime != 0) {
          if ((((Car_tObj *)newtonObj)->carFlags & 4) != 0) {
            Physics_FixEngineRpm((Car_tObj *)newtonObj);
          }

          relativeClosingVelocity = groundVel - newtonObj->linearVel.y;
          if (newtonObj->orientationToGround.y < 0xb334) {
            coorddef collisionPoint;
            collisionPoint = newtonObj->roadCenterPoint;
            collisionPoint.y -= 0x1999;
            Collide_TestWithPlane(newtonObj,&normal,&collisionPoint);
            if (newtonObj->collision.impulse > 0x50000) {
              int maxImpulse = 0x140000;
              if (newtonObj->collision.impulse > 0x13ffff) {
                maxImpulse = newtonObj->collision.impulse;
              }
              newtonObj->collision.impulse = maxImpulse;
            }
            if (newtonObj->orientationToGround.y < 0x3333) {
              ((Car_tObj *)newtonObj)->collision.smoking = 1;
            }
          } else {
            int bounceVel = 0;
            int k;
            for (k = 0; k < 4; k++) {
              bounceVel += ((Car_tObj *)newtonObj)->wheel[k].wheelAcc;
            }
            if (bounceVel > 0) {
              newtonObj->linearVel.y = groundVel + bounceVel * 3 / 4;
              newtonObj->collision.impulse = relativeClosingVelocity * 2;
              newtonObj->flightTime = 0;
              newtonObj->position.y -= objAltitude;
              objAltitude = 0xccc;
              newtonObj->objAltitude = objAltitude;
              if (newtonObj->collision.impulse > 0x140000) {
                newtonObj->collision.sfxType = 0x10000;
                newtonObj->collision.otherObj = 0;
                newtonObj->collision.collisionPoint = newtonObj->position;
                Newton_AddDamageZone(newtonObj,newtonObj->collision.impulse,9,0);
              }
              if (Force_IsForceOn((Car_tObj *)newtonObj)) {
                Force_HitWall(newtonObj->collision.impulse);
              }
            }
          }
          Newton_LimitAngularVelocity__FP13BO_tNewtonObj((int)newtonObj);
        } else {
          Newton_CheckForSpikeBelts__FP13BO_tNewtonObj(newtonObj);
        }

        if (objAltitude < 0xa3d) {
          int scale;
          newtonObj->position.y -= objAltitude;
          newtonObj->objAltitude = 0;
          if (((((Car_tObj *)newtonObj)->carFlags & 0x400) == 0) &&
              newtonObj->orientationToGround.y > 0xe666) {
            newtonObj->flightTime = 0;
          }
          if (groundVel > 0x5ffff) {
            scale = 0xffdf;
            if (groundVel > 0xc0000) {
              scale = 0xffbe;
            }
            newtonObj->linearVel.x = fixedmult(newtonObj->linearVel.x,scale);
            newtonObj->linearVel.z = fixedmult(newtonObj->linearVel.z,scale);
          }
          if (newtonObj->speedXZ < 0x50000) {
            newtonObj->linearVel.y = groundVel / 4;
          } else if (newtonObj->speedXZ < 0xa0000) {
            newtonObj->linearVel.y = groundVel / 2;
          } else {
            newtonObj->linearVel.y = groundVel;
          }
        }
      }

      newtonObj->lastUpdated = simGlobal.gameTicks;
      if (BWorldSm_TunnelFlagSm(&newtonObj->simRoadInfo) &&
          newtonObj->linearVel.y > 0 &&
          newtonObj->position.y - newtonObj->roadCenterPoint.y > 0x80000) {
        newtonObj->linearVel.y = -newtonObj->linearVel.y;
      }
    }
  }
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
