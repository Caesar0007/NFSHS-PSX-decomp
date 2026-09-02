/* game/common/newton.cpp -- RECONSTRUCTED (NFS4 PSX Newton physics integrator; C++ TU)
 *   32 fns: ground elevation/normal ray-cast, road geometry, slice orientation, rot/vel
 *   integration @32/64Hz, ground-shadow matrices, barrier/spike collision, gravity.
 *   GTE-free (fixed-point + eaclib math). Full SYM-locals applied.
 */
#include "newton_types.h"
#include "newton_externs.h"

#define NEWTON_SLICE_INT(slice, offset) \
    (*(int *)(Newton_BWorldSmSlices + (slice) * 0x20 + (offset)))
#define NEWTON_SLICE_CHAR(slice, offset) \
    (*(signed char *)(Newton_BWorldSmSlices + (slice) * 0x20 + (offset)))

/* ---- newton.obj-owned BSS. SYM records the five named tables/road records as EXT;
 * the two coorddef out-parameter scratch objects are function-local statics below. ---- */
int          divTable[50];
short        fudgeTable[32];
int          swap[4];
BWorldSm_Pos testSimRoadInfo;
BWorldSm_Pos newtestSimRoadInfo;

static inline int Newton_GetSpikeBelt(int *slice,int *leftLatPos,int *rightLatPos)
{
  int active;

  active = Newton_SpikeBeltWords[0];
  if (active != 0) {
    *slice = Newton_SpikeBeltWords[1];
    *leftLatPos = Newton_SpikeBeltWords[2];
    *rightLatPos = Newton_SpikeBeltWords[3];
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
extern "C" int Newton_FindGroundElevationAndNormalFast(BO_tNewtonObj *newtonObj,coorddef *normal)
  asm("Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef");
int Newton_FindGroundElevationAndNormal(BO_tNewtonObj *newtonObj,coorddef *normal);
void Newton_LimitCarsToDrivableDist(BO_tNewtonObj *newtonObj);
int Newton_CalcPerpenHeightOfLowestPointFromGround(BO_tNewtonObj *newtonObj,coorddef *normal,coorddef *samplePoint);
int Newton_CalcPerpenHeightOfCenterPointFromGround(BO_tNewtonObj *newtonObj,coorddef *normal,coorddef *samplePoint);
void Newton_CalcDistToClosestPlayerCar(BO_tNewtonObj *n);
void Newton_UpdateRoadInfo(BO_tNewtonObj *n);
void Newton_CopyRoadMatrixToOrientMat(BO_tNewtonObj *n,int backwards);
void Newton_CopyRoadMatrixToShadowMat(BO_tNewtonObj *n,int backwards);
void Newton_SetInitialSlicePositionOrientationEtc(BO_tNewtonObj *n,int slice,coorddef *offset,int direction);
extern "C" void Newton_InitBaseNewtonObj(BO_tNewtonObj *newtonObj,int index,int mass,int moInertia,int dimX,int dimY,int dimZ)
  asm("Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii");
extern "C" void Newton_QDUpdateVel(BO_tNewtonObj *newtonObj)
  asm("Newton_QDUpdateVel__FP13BO_tNewtonObj");
extern "C" int Newton_OptzRotxform(matrixtdef *m,int ax,int ay,int az,int *reOrthoNeeded,int reOrthoLimit,int *cumulatedRot)
  asm("Newton_OptzRotxform__FP10matrixtdefiiiPiiT4");
extern "C" void Newton_QDUpdateRot64Hz(BO_tNewtonObj *newtonObj)
  asm("Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj");
extern "C" void Newton_QDUpdateRot32Hz(BO_tNewtonObj *newtonObj)
  asm("Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj");
extern "C" void Newton_CalculateGroundShadowMatrix(BO_tNewtonObj *newtonObj,coorddef *normal,int orientToGround)
  asm("Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi");
extern "C" void Newton_CalcRealShadowCoordinates(Car_tObj *carObj,int currentTick)
  asm("Newton_CalcRealShadowCoordinates__FP8Car_tObji");
extern "C" void Newton_CheckForSpikeBelts(BO_tNewtonObj *newtonObj)
  asm("Newton_CheckForSpikeBelts__FP13BO_tNewtonObj");
extern "C" void Newton_DoPostBarrierCollisionHandling(BO_tNewtonObj *newtonObj,coorddef normal)
  asm("Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef");
extern "C" void Newton_GenerateVector(int type,coorddef *vector,BWorldSm_Pos *testSimRoadInfo)
  asm("Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos");
extern "C" int Netwon_CheckForBadQuad(BO_tNewtonObj *newtonObj,BWorldSm_Pos *testSimRoadInfo,int wheel)
  asm("Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi");
void Newton_TestForUndrivableSurfaces(BO_tNewtonObj *newtonObj);
extern "C" void Newton_LimitAngularVelocity(BO_tNewtonObj *newtonObj)
  asm("Newton_LimitAngularVelocity__FP13BO_tNewtonObj");
extern "C" void Newton_ApplyTheLawOfGravity(BO_tNewtonObj *newtonObj)
  asm("Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj");
int Newton_CalculateRoadPositionFromSliceAndPosition(int slice,coorddef *position,matrixtdef *matrix);
int Newton_CalculateRoadPosition(BO_tNewtonObj *newtonObj);


/* ---- Newton_AddDamageZone__FP13BO_tNewtonObjiii  [NEWTON.CPP:50-216] SLD-VERIFIED ---- */
void Newton_AddDamageZone(BO_tNewtonObj *newtonObj,int impulse,int zone,int type)

{
  if (Force_IsForceOn((Car_tObj *)newtonObj) != 0) {
    Force_HitWall((newtonObj->collision).impulse);
  }
  if (Newton_GameSetupWords[20] != 0) {
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
          int temp = (newtonObj->damage[0] + newtonObj->damage[6]) / 2;

          if (temp < newtonObj->damage[7]) {
            temp = newtonObj->damage[7];
          }
          newtonObj->damage[7] = temp;
        }
      }
      else if (zone == 1) {
        int temp;

        temp = (newtonObj->damage[7] + newtonObj->damage[1]) / 2;
        newtonObj->damage[0] = temp < newtonObj->damage[0] ?
            newtonObj->damage[0] : temp;
        {
          int temp = (newtonObj->damage[1] + newtonObj->damage[3]) / 2;

          if (temp < newtonObj->damage[2]) {
            temp = newtonObj->damage[2];
          }
          newtonObj->damage[2] = temp;
        }
      }
      else if (zone == 6) {
        int temp;

        temp = (newtonObj->damage[4] + newtonObj->damage[6]) / 2;
        newtonObj->damage[5] = temp < newtonObj->damage[5] ?
            newtonObj->damage[5] : temp;
        {
          int temp = (newtonObj->damage[0] + newtonObj->damage[6]) / 2;

          if (temp < newtonObj->damage[7]) {
            temp = newtonObj->damage[7];
          }
          newtonObj->damage[7] = temp;
        }
      }
      else if (zone == 7) {
        int temp;

        temp = (newtonObj->damage[7] + newtonObj->damage[1]) / 2;
        newtonObj->damage[0] = temp < newtonObj->damage[0] ?
            newtonObj->damage[0] : temp;
        {
          int temp = (newtonObj->damage[5] + newtonObj->damage[7]) / 2;

          if (temp < newtonObj->damage[6]) {
            temp = newtonObj->damage[6];
          }
          newtonObj->damage[6] = temp;
        }
      }
      else {
        /* SYM-CODEGEN-CARRIER: result -- SYM retains only the average `temp`.
           Retail nevertheless has a distinct joined maximum-result web; the
           direct conditional member assignment is count-exact at 502 but
           rotates 60 instructions.  Keeping the two branch assignments in
           this eliminated result local reproduces retail's v0-to-v1 flow. */
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
      /* SYM-CODEGEN-CARRIER: newYVel -- the optimized debug block retains no
         clamp temporaries.  This pre-clamp value must remain a separate web
         from the selected result; a single in-place local and a direct
         conditional are both 501/502 with the same 11 retail diffs. */
      int newYVel;
      /* SYM-CODEGEN-CARRIER: cappedYVel -- the joined clamp result supplies
         retail's distinct `$a0` web, branch orientation, and unconditional
         member store.  It is required jointly with `newYVel` for 502/502. */
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
        randtemp = fastRandom * randSeed;
        xMult = ((randtemp & 0xffff00) >> 8) * 4;
        fastRandom = randtemp & 0xffff;
        randtemp = fastRandom * randSeed;
        yMult = ((randtemp & 0xffff00) >> 8) * 3;
        fastRandom = randtemp & 0xffff;
        randtemp = fastRandom * randSeed;
        zMult = ((randtemp & 0xffff00) >> 8) * 3;
        fastRandom = randtemp & 0xffff;
        randtemp = fastRandom * randSeed;
        fastRandom = randtemp & 0xffff;
        if ((randtemp & 0xffff00) >> 8 < 0x3333) {
          intensity = -intensity;
        }
        if (xMult + yMult + zMult < 0x40000) {
          if (xMult < 0x10000) {
            xMult *= 2;
          }
          if (yMult < 0x10000) {
            yMult *= 2;
          }
          if (zMult < 0x10000) {
            zMult *= 2;
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
  x1 = NEWTON_SLICE_INT(slice,0);
  z1 = NEWTON_SLICE_INT(slice,8);
  x2 = NEWTON_SLICE_INT(s,0);
  z2 = NEWTON_SLICE_INT(s,8);
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
          temp = *(coorddef *)(Newton_BWorldSmSlices + n->simRoadInfo.slice * 0x20);
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
        n->roadCenterPoint = *(coorddef *)(Newton_BWorldSmSlices + slice * 0x20);
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

      r1 = (int)NEWTON_SLICE_CHAR(slice,0x12) << 9;
      r2 = (int)NEWTON_SLICE_CHAR(slice,0x13) << 9;
      r3 = (int)NEWTON_SLICE_CHAR(slice,0x14) << 9;
      n->roadMatrix.m[0] = r1;
      n->roadMatrix.m[1] = r2;
      n->roadMatrix.m[2] = r3;
      r1 = (int)NEWTON_SLICE_CHAR(slice,0x0c) << 9;
      r2 = (int)NEWTON_SLICE_CHAR(slice,0x0d) << 9;
      r3 = (int)NEWTON_SLICE_CHAR(slice,0x0e) << 9;
      n->roadMatrix.m[3] = r1;
      n->roadMatrix.m[4] = r2;
      n->roadMatrix.m[5] = r3;
      r1 = (int)NEWTON_SLICE_CHAR(slice,0x0f) << 9;
      r2 = (int)NEWTON_SLICE_CHAR(slice,0x10) << 9;
      r3 = (int)NEWTON_SLICE_CHAR(slice,0x11) << 9;
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
      x1 = NEWTON_SLICE_INT(slice,0);
      z1 = NEWTON_SLICE_INT(slice,8);
      x2 = NEWTON_SLICE_INT(s,0);
      z2 = NEWTON_SLICE_INT(s,8);
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
extern "C" int Newton_FindGroundElevationAndNormalFast(BO_tNewtonObj *newtonObj,coorddef *normal)

{
  int elevation;

  {
    int r1;
    int r2;
    int r3;

    r2 = *(int *)((int)newtonObj + 0x154);
    r1 = *(int *)((int)newtonObj + 0x150);
    r3 = *(int *)((int)newtonObj + 0x158);
    normal->y = r2;
    normal->x = r1;
    normal->z = r3;
    if (0x199a <= r2) {
      int surfaceType;
      elevation = Newton_FindGroundElevationGeneral(
          (coorddef *)((int)newtonObj + 0xa0),normal,
          (coorddef *)((int)newtonObj + 0x168));
      surfaceType = 0;
      {
        int r2;
        int r3;
        int r4;

        r2 = *(int *)((int)newtonObj + 0xa0);
        r3 = *(int *)((int)newtonObj + 0xa8);
        r4 = elevation;
    *(u_int *)((int)newtonObj + 0x2ac) = 0;
    *(u_int *)((int)newtonObj + 0x2dc) = 0;
    *(u_int *)((int)newtonObj + 0x30c) = 0;
    *(u_int *)((int)newtonObj + 0x33c) = 0;
    *(u_int *)((int)newtonObj + 0x2b0) = 0;
    *(u_int *)((int)newtonObj + 0x2e0) = 0;
    *(u_int *)((int)newtonObj + 0x310) = 0;
    *(u_int *)((int)newtonObj + 0x340) = 0;
        *(int *)((int)newtonObj + 0x290) = r4;
        *(int *)((int)newtonObj + 0x2c0) = r4;
        *(int *)((int)newtonObj + 0x2f0) = r4;
        *(int *)((int)newtonObj + 800) = r4;
        *(int *)((int)newtonObj + 0x2a4) = r4;
        *(int *)((int)newtonObj + 0x2d4) = r4;
        *(int *)((int)newtonObj + 0x304) = r4;
        *(int *)((int)newtonObj + 0x334) = r4;
        *(int *)((int)newtonObj + 0x28c) = r2;
        *(int *)((int)newtonObj + 700) = r2;
        *(int *)((int)newtonObj + 0x2ec) = r2;
        *(int *)((int)newtonObj + 0x31c) = r2;
        *(int *)((int)newtonObj + 0x294) = r3;
        *(int *)((int)newtonObj + 0x2c4) = r3;
        *(int *)((int)newtonObj + 0x2f4) = r3;
        *(int *)((int)newtonObj + 0x324) = r3;
        r2 = normal->x;
        r3 = normal->y;
        r4 = normal->z;
    *(u_int *)((int)newtonObj + 0x2b8) = 1;
    *(u_int *)((int)newtonObj + 0x2e8) = 1;
    *(u_int *)((int)newtonObj + 0x318) = 1;
    *(u_int *)((int)newtonObj + 0x348) = 1;
        *(int *)((int)newtonObj + 0x298) = r2;
        *(int *)((int)newtonObj + 0x2c8) = r2;
        *(int *)((int)newtonObj + 0x2f8) = r2;
        *(int *)((int)newtonObj + 0x328) = r2;
        *(int *)((int)newtonObj + 0x29c) = r3;
        *(int *)((int)newtonObj + 0x2cc) = r3;
        *(int *)((int)newtonObj + 0x2fc) = r3;
        *(int *)((int)newtonObj + 0x32c) = r3;
        *(int *)((int)newtonObj + 0x2a0) = r4;
        *(int *)((int)newtonObj + 0x2d0) = r4;
        *(int *)((int)newtonObj + 0x300) = r4;
        *(int *)((int)newtonObj + 0x330) = r4;
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
  int i;

  for (i = 0;
       (int)((char *)newtonObj + i * 0x30) < (int)((char *)newtonObj + 0xc0);
       i = i + 1) {
    wheelHeight[i] = tireCoord[i];
    ((Car_tObj *)newtonObj)->wheel[i].actualHeight = tireCoord[i].y;
    BWorldSm_FindClosestTriangleRez(&tireCoord[i],&testSimRoadInfo,1);
    roadNormal = *(coorddef *)BWorldSm_UNormal(&testSimRoadInfo);
    roadSurfaceType = 0xe;
    if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0x0) {
      roadSurfaceType = (u_int)(testSimRoadInfo.simQuad)->surface;
    }
    ((Car_tObj *)newtonObj)->wheel[i].roadSurfaceType = roadSurfaceType;
    roadSurfaceType = roadSurfaceType & 0xf;
    if (((roadNormal.y < 0x1999) || (roadSurfaceType == 0xe)) || (roadSurfaceType == 0)) {
      roadNormal.y = 0x10000;
      roadNormal.x = 0;
      roadNormal.z = 0;
      elevation.x = elevation.x + tireCoord[i].x;
      elevation.y = elevation.y + (tireCoord[i].y - newtonObj->objAltitude);
      elevation.z = elevation.z + tireCoord[i].z;
    }
    else {
      if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0x0) {
        roadCenterPoint = testSimRoadInfo.quadPts[0];
      }
      else {
        roadCenterPoint = *(coorddef *)(Newton_BWorldSmSlices + testSimRoadInfo.slice * 0x20);
      }
      if ((u_int)(roadSurfaceType - 2) < 2) {
        wheelHeight[i].y =
            Newton_FindGroundElevationRough(&tireCoord[i],&roadNormal,&roadCenterPoint);
      }
      else {
        wheelHeight[i].y =
            Newton_FindGroundElevationGeneral(&tireCoord[i],&roadNormal,&roadCenterPoint);
      }
      ((Car_tObj *)newtonObj)->wheel[i].actualHeight = wheelHeight[i].y;
      /* SYM-CODEGEN-CARRIER: wheelY -- eliminated snapshot of the solved wheel
         height shared by the rejection test and elevation accumulation.  Direct
         member reads emit 907/905 with 20 diffs; this web preserves retail's
         load reuse and keeps the function byte-exact. */
      int wheelY = wheelHeight[i].y;
      if (0x20000 < wheelY - tireCoord[i].y) {
        roadNormal.x = 0;
        roadNormal.y = 0x10000;
        roadNormal.z = 0;
        wheelHeight[i].y = tireCoord[i].y;
        elevation.x = elevation.x + tireCoord[i].x;
        elevation.y = elevation.y + tireCoord[i].y;
        elevation.z = elevation.z + tireCoord[i].z;
      }
      else {
        int r1 = wheelHeight[i].x;
        int r3 = wheelHeight[i].z;
        elevation.x = elevation.x + r1;
        elevation.y = elevation.y + wheelY;
        elevation.z = elevation.z + r3;
      }
    }
    {
      int r1 = wheelHeight[i].x;
      int r2 = wheelHeight[i].y;
      int r3 = wheelHeight[i].z;
      ((Car_tObj *)newtonObj)->wheel[i].currentPos.x = r1;
      ((Car_tObj *)newtonObj)->wheel[i].currentPos.y = r2;
      ((Car_tObj *)newtonObj)->wheel[i].currentPos.z = r3;
    }
    {
      int r1 = roadNormal.x;
      int r2 = roadNormal.y;
      int r3 = roadNormal.z;
      ((Car_tObj *)newtonObj)->wheel[i].roadNormal.x = r1;
      ((Car_tObj *)newtonObj)->wheel[i].roadNormal.y = r2;
      ((Car_tObj *)newtonObj)->wheel[i].roadNormal.z = r3;
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
      /* SYM-CODEGEN-CARRIER: newWheelAcc -- joined result web for the two
         suspension-update arms.  Direct member updates are count-exact at
         905/905 but rotate 34 instructions; the explicit joined store retains
         retail's saved-register allocation. */
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
      tempVecY.x = fixedmult(tempVecZ.y,tempVecX.z) -
                   fixedmult(tempVecZ.z,tempVecX.y);
      tempVecY.y = fixedmult(tempVecZ.z,tempVecX.x) -
                   fixedmult(tempVecZ.x,tempVecX.z);
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

        if (__builtin_abs(newtonObj[1].shadowCoord[0].y) < 0x13333) {
          newtonObj[1].shadowCoord[0].y =
              fixedmult(newtonObj[1].shadowCoord[0].y,
                        *(int *)(newtonObj[1].damage[3] + 0x134));
        }
        else {
          newtonObj[1].shadowCoord[0].y =
              fixedmult(newtonObj[1].shadowCoord[0].y,0xd999);
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
      if (Newton_SimGlobalWords[1] < 0x40) {
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
  if (Physics_DoBarrierCheck((Car_tObj *)newtonObj) != 0) {
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
  int relativeDot;
  coorddef relativePos;

  relativePos.x = (newtonObj->position).x - samplePoint->x;
  relativePos.y = (newtonObj->position).y - samplePoint->y;
  relativePos.z = (newtonObj->position).z - samplePoint->z;
  relativeDot = fixedmult(normal->x,relativePos.x) + fixedmult(normal->y,relativePos.y) +
                fixedmult(normal->z,relativePos.z);
  if (0xb334 <= __builtin_abs((newtonObj->orientationToGround).y)) {
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
  x = (n->position).x - (Cars_gHumanRaceCarList[Newton_GameSetupWords[7]]->N).position.x;
  if (x < 1) { x = (Cars_gHumanRaceCarList[Newton_GameSetupWords[7]]->N).position.x - (n->position).x; }
  z = (n->position).z - (Cars_gHumanRaceCarList[Newton_GameSetupWords[7]]->N).position.z;
  if (z < 1) { z = (Cars_gHumanRaceCarList[Newton_GameSetupWords[7]]->N).position.z - (n->position).z; }
  if (z < x) {
    n->distToPlayer = x + (z >> 2);
  }
  else {
    n->distToPlayer = z + (x >> 2);
  }
  if (Cars_gNumHumanRaceCars == 2) {
    x = (n->position).x - (Cars_gHumanRaceCarList[1 - Newton_GameSetupWords[7]]->N).position.x;
    if (x < 1) { x = (Cars_gHumanRaceCarList[1 - Newton_GameSetupWords[7]]->N).position.x - (n->position).x; }
    z = (n->position).z - (Cars_gHumanRaceCarList[1 - Newton_GameSetupWords[7]]->N).position.z;
    if (z < 1) { z = (Cars_gHumanRaceCarList[1 - Newton_GameSetupWords[7]]->N).position.z - (n->position).z; }
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
    if ((n[3].lastUpdated == 0) || (Newton_SimGlobalWords[1] < 3)) {
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
       (((n[3].lastUpdated == 0 || (Newton_SimGlobalWords[1] < 3)) && (0x480000 < n->distToPlayer)))) {
      n->simOptz = '\x01';
    }
    else {
      n->simOptz = '\0';
    }
    if (1 < oldOptz) {
      /* SYM's `dummy.124` is GCC's generated object spelling.  The original
       * source declaration is the ordinary function-local static below; its
       * numeric suffix is compiler state, not part of the C++ identifier. */
      static coorddef dummy
        __attribute__((section(".bss.newton_dummy_124")));

      Cars_SetCarUpForHiRezSim((Car_tObj *)n);
      Newton_FindClosestQuad(n);
      Newton_UpdateRoadGeometry(n);
      Newton_LimitCarsToDrivableDist(n);
      if (stackSpeedUpEnbabledFlag != 0) {
        gWSavePtr = SetSp(gWSavePtr);
        stackSpeedUpEnbabledFlag = 0;
        n->groundElevation = Newton_FindGroundElevationAndNormal(n,&dummy);
        gWSavePtr = SetSp(gWSavePtr);
        stackSpeedUpEnbabledFlag = 1;
      }
      else {
        n->groundElevation = Newton_FindGroundElevationAndNormal(n,&dummy);
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
  if (n->active != '\0') {
    Newton_CalcDistToClosestPlayerCar(n);
    Newton_FindClosestQuad(n);
    if (*(signed char *)&(n->simRoadInfo).quadChanged != '\0') {
      Newton_UpdateRoadGeometry(n);
    }
    if (n->simOptz == '\0') {
      n->groundSurfaceType = n->simRoadInfo.simQuad == (Trk_NewSimQuad *)0
                                 ? 0xe : n->simRoadInfo.simQuad->surface;
      n->driveSurfaceType = n->groundSurfaceType & 0xf;
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
  n->roadMatrix.m[0] = NEWTON_SLICE_CHAR(slice,0x12) << 9;
  n->roadMatrix.m[1] = NEWTON_SLICE_CHAR(slice,0x13) << 9;
  n->roadMatrix.m[2] = NEWTON_SLICE_CHAR(slice,0x14) << 9;
  n->roadMatrix.m[3] = NEWTON_SLICE_CHAR(slice,0x0c) << 9;
  n->roadMatrix.m[4] = NEWTON_SLICE_CHAR(slice,0x0d) << 9;
  n->roadMatrix.m[5] = NEWTON_SLICE_CHAR(slice,0x0e) << 9;
  n->roadMatrix.m[6] = NEWTON_SLICE_CHAR(slice,0x0f) << 9;
  n->roadMatrix.m[7] = NEWTON_SLICE_CHAR(slice,0x10) << 9;
  n->roadMatrix.m[8] = NEWTON_SLICE_CHAR(slice,0x11) << 9;
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

  n->position.x = rOffset.x + NEWTON_SLICE_INT(slice,0);
  n->position.y = rOffset.y + NEWTON_SLICE_INT(slice,4);
  n->position.z = rOffset.z + NEWTON_SLICE_INT(slice,8);
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
    n->groundElevation = NEWTON_SLICE_INT(slice,4);
  } else if (n->simOptz == 1) {
    int i;
    int quadCenterY = 0;

    for (i = 0; i < 4; i++) {
      coorddef temp;

      if (n->simRoadInfo.simQuad != (Trk_NewSimQuad *)0) {
        temp = n->simRoadInfo.quadPts[i];
      } else {
        temp = *(coorddef *)(Newton_BWorldSmSlices + n->simRoadInfo.slice * 0x20);
      }
      quadCenterY += temp.y;
    }
    quadCenterY /= 4;
    n->groundElevation = quadCenterY;
  } else {
    /* SYM's `dummy.133` is GCC's generated object spelling.  Keep the source
     * identifier and scope; do not encode the generated suffix in source. */
    static coorddef dummy
      __attribute__((section(".bss.newton_dummy_133")));

    if (stackSpeedUpEnbabledFlag != 0) {
      gWSavePtr = SetSp(gWSavePtr);
      stackSpeedUpEnbabledFlag = 0;
      n->groundElevation = Newton_FindGroundElevationAndNormal(n,&dummy);
      gWSavePtr = SetSp(gWSavePtr);
      stackSpeedUpEnbabledFlag = 1;
    } else {
      n->groundElevation = Newton_FindGroundElevationAndNormal(n,&dummy);
    }
    n->position.y = n->groundElevation + n->dimension.y;
  }
  n->objAltitude = Newton_CalcPerpenHeightOfLowestPointFromGround(
      n,(coorddef *)(n->roadMatrix.m + 3),&n->roadCenterPoint);
  n->position.y -= n->objAltitude;
  n->objAltitude = 0;
  if (n->simOptz == 0) {
    n->groundSurfaceType = n->simRoadInfo.simQuad == (Trk_NewSimQuad *)0
                               ? 0xe : n->simRoadInfo.simQuad->surface;
  } else {
    n->groundSurfaceType = 1;
  }
  n->driveSurfaceType = n->groundSurfaceType & 0xf;
  return;
}

/* ---- Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii  [NEWTON.CPP:1420-1512] SLD-VERIFIED ---- */
extern "C" void Newton_InitBaseNewtonObj(
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
  if (((Newton_GameSetupWords[14] & 2U) != 0) &&
      ((((Car_tObj *)newtonObj)->carFlags & 4) != 0)) {
    newtonObj->mass = mass * 5;
  }
  if ((((Car_tObj *)newtonObj)->carFlags & 0x20) != 0) {
    if ((Newton_GameSetupWords[3] == 1) &&
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
extern "C" void Newton_QDUpdateVel(BO_tNewtonObj *newtonObj)

{
  int t1;
  int t2;
  int t3;

  if (newtonObj->active != '\0') {
    if ((Newton_GameSetupWords[14] & 4U) != 0) {
      t1 = newtonObj->linearVel.x >> 6;
      t2 = newtonObj->linearVel.y >> 6;
      t3 = newtonObj->linearVel.z >> 6;
      t1 = fixedmult(t1,0xcccc);
      t3 = fixedmult(t3,0xcccc);
      newtonObj->position.x = newtonObj->position.x + t1;
      newtonObj->position.y = newtonObj->position.y + t2;
      newtonObj->position.z = newtonObj->position.z + t3;
    }
    else {
      newtonObj->position.x = newtonObj->position.x + (newtonObj->linearVel.x >> 6);
      newtonObj->position.y = newtonObj->position.y + (newtonObj->linearVel.y >> 6);
      newtonObj->position.z = newtonObj->position.z + (newtonObj->linearVel.z >> 6);
    }
  }
  return;
}

/* ---- Newton_OptzRotxform__FP10matrixtdefiiiPiiT4  [NEWTON.CPP:1569-1617] SLD-VERIFIED ---- */
extern "C" int Newton_OptzRotxform(
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
extern "C" void Newton_QDUpdateRot64Hz(BO_tNewtonObj *newtonObj)

{
  matrixtdef m;
  coorddef angularVel;
  int reOrthoNeeded;

  if (newtonObj->active != 0) {
    angularVel.x = newtonObj->angularVel.x / 64;
    angularVel.y = newtonObj->angularVel.y / 64;
    angularVel.z = newtonObj->angularVel.z / 64;
    if (Newton_OptzRotxform(&m,angularVel.x,angularVel.y,angularVel.z,
                            &reOrthoNeeded,0x1000,&newtonObj->cumulatedRot)) {
      Math_fasttransmult(&newtonObj->orientMat,&m,&newtonObj->orientMat);
      newtonObj->reOrthoCounter--;
      if ((newtonObj->reOrthoCounter == 0) || (reOrthoNeeded != 0)) {
        reorthogonalize(&newtonObj->orientMat);
        newtonObj->reOrthoCounter = 0x20;
        newtonObj->cumulatedRot = 0;
      }
    }
  }
  return;
}

/* ---- Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj  [NEWTON.CPP:1670-1722] SLD-VERIFIED ---- */
extern "C" void Newton_QDUpdateRot32Hz(BO_tNewtonObj *newtonObj)

{
  matrixtdef m;
  coorddef angularVel;
  int reOrthoNeeded;

  if ((newtonObj->active != 0) && (newtonObj->simOptz == 0)) {
    angularVel.x = newtonObj->angularVel.x / 16;
    angularVel.y = newtonObj->angularVel.y / 16;
    angularVel.z = newtonObj->angularVel.z / 16;
    if (Newton_OptzRotxform(&m,angularVel.x,angularVel.y,angularVel.z,
                            &reOrthoNeeded,0x2000,&newtonObj->cumulatedRot)) {
      Math_fasttransmult(&newtonObj->orientMat,&m,&newtonObj->orientMat);
      if ((reOrthoNeeded != 0) || (--newtonObj->reOrthoCounter == 0)) {
        reorthogonalize(&newtonObj->orientMat);
        newtonObj->reOrthoCounter = 0x40;
        newtonObj->cumulatedRot = 0;
      }
    }
  }
  return;
}

/* ---- Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi  [NEWTON.CPP:1730-1807] SLD-VERIFIED ---- */
extern "C" void Newton_CalculateGroundShadowMatrix(BO_tNewtonObj *newtonObj,coorddef *normal,int orientToGround)

{
  if (((((Car_tObj *)newtonObj)->carFlags & 4U) == 0) &&
      (0xe666 < orientToGround)) {
    newtonObj->shadowMat = newtonObj->orientMat;
    {
      int r1;
      int r2;
      int r3;

      r1 = normal->x;
      r2 = normal->y;
      r3 = normal->z;
      newtonObj->shadowMat.m[3] = r1;
      newtonObj->shadowMat.m[4] = r2;
      newtonObj->shadowMat.m[5] = r3;
    }
    return;
  }
  {
    int r1;
    int r2;
    int r3;

    r1 = normal->x;
    r2 = normal->y;
    r3 = normal->z;
    newtonObj->shadowMat.m[3] = r1;
    newtonObj->shadowMat.m[4] = r2;
    newtonObj->shadowMat.m[5] = r3;
  }
  if (orientToGround < 0x8000) {
    if (0.5 < (double)__builtin_abs(
          newtonObj->orientMat.m[0] / 256 * (normal->x / 256) +
          newtonObj->orientMat.m[1] / 256 * (normal->y / 256) +
          newtonObj->orientMat.m[2] / 256 * (normal->z / 256))) {
      newtonObj->shadowMat.m[0] =
           fixedmult(newtonObj->shadowMat.m[4],newtonObj->orientMat.m[8]) -
           fixedmult(newtonObj->shadowMat.m[5],newtonObj->orientMat.m[7]);
      newtonObj->shadowMat.m[1] =
           fixedmult(newtonObj->shadowMat.m[5],newtonObj->orientMat.m[6]) -
           fixedmult(newtonObj->shadowMat.m[3],newtonObj->orientMat.m[8]);
      newtonObj->shadowMat.m[2] =
           fixedmult(newtonObj->shadowMat.m[3],newtonObj->orientMat.m[7]) -
           fixedmult(newtonObj->shadowMat.m[4],newtonObj->orientMat.m[6]);
      Math_NormalizeShortVector((coorddef *)&newtonObj->shadowMat.m[0]);
      newtonObj->shadowMat.m[6] =
           fixedmult(newtonObj->shadowMat.m[1],newtonObj->shadowMat.m[5]) -
           fixedmult(newtonObj->shadowMat.m[2],newtonObj->shadowMat.m[4]);
      newtonObj->shadowMat.m[7] =
           fixedmult(newtonObj->shadowMat.m[2],newtonObj->shadowMat.m[3]) -
           fixedmult(newtonObj->shadowMat.m[0],newtonObj->shadowMat.m[5]);
      newtonObj->shadowMat.m[8] =
           fixedmult(newtonObj->shadowMat.m[0],newtonObj->shadowMat.m[4]) -
           fixedmult(newtonObj->shadowMat.m[1],newtonObj->shadowMat.m[3]);
      Math_NormalizeShortVector((coorddef *)&newtonObj->shadowMat.m[6]);
      return;
    }
  }
  newtonObj->shadowMat.m[6] =
       fixedmult(newtonObj->orientMat.m[1],newtonObj->shadowMat.m[5]) -
       fixedmult(newtonObj->orientMat.m[2],newtonObj->shadowMat.m[4]);
  newtonObj->shadowMat.m[7] =
       fixedmult(newtonObj->orientMat.m[2],newtonObj->shadowMat.m[3]) -
       fixedmult(newtonObj->orientMat.m[0],newtonObj->shadowMat.m[5]);
  newtonObj->shadowMat.m[8] =
       fixedmult(newtonObj->orientMat.m[0],newtonObj->shadowMat.m[4]) -
       fixedmult(newtonObj->orientMat.m[1],newtonObj->shadowMat.m[3]);
  Math_NormalizeShortVector((coorddef *)&newtonObj->shadowMat.m[6]);
  newtonObj->shadowMat.m[0] =
       fixedmult(newtonObj->shadowMat.m[4],newtonObj->shadowMat.m[8]) -
       fixedmult(newtonObj->shadowMat.m[5],newtonObj->shadowMat.m[7]);
  newtonObj->shadowMat.m[1] =
       fixedmult(newtonObj->shadowMat.m[5],newtonObj->shadowMat.m[6]) -
       fixedmult(newtonObj->shadowMat.m[3],newtonObj->shadowMat.m[8]);
  newtonObj->shadowMat.m[2] =
       fixedmult(newtonObj->shadowMat.m[3],newtonObj->shadowMat.m[7]) -
       fixedmult(newtonObj->shadowMat.m[4],newtonObj->shadowMat.m[6]);
  Math_NormalizeShortVector((coorddef *)&newtonObj->shadowMat.m[0]);
  return;
}

/* ---- Newton_CalcRealShadowCoordinates__FP8Car_tObji  [NEWTON.CPP:1830-1880] SLD-VERIFIED ---- */
extern "C" void Newton_CalcRealShadowCoordinates(Car_tObj *carObj,int currentTick)

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
extern "C" void Newton_CheckForSpikeBelts(BO_tNewtonObj *newtonObj)

{
  int slice;
  int leftLatPos;
  int rightLatPos;
  int latPos;

  if (Newton_GetSpikeBelt(&slice,&leftLatPos,&rightLatPos) != 0) {
    if ((Newton_SpikeBeltWords[0] != 0) &&
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
extern "C" void Newton_DoPostBarrierCollisionHandling(BO_tNewtonObj *newtonObj,coorddef normal)

{
  /* MATCH (W77-root): PASS 106/106 from the count-exact 2-diff baseline.
     The last residual was the y-divide join's store/sra swap.  Spelling the
     signed adjustment in C, storing barrierVec.z at the join, and expressing
     only the final shift as a one-instruction source ASM prevents sched2 from
     reversing the pair without changing any register allocation. */
  coorddef barrierVec;
  int impactVel;
  int distRetreat;
  /* SYM-CODEGEN-CARRIER: retreat -- pre-clamp signed quotient web.  Keeping it
     distinct from SYM's `$v1` `distRetreat` reproduces retail's two-pseudo
     branch select; the single-variable and ternary forms lose that copy and
     measure ten diffs worse on the final allocation basin. */
  int retreat;
  /* SYM-CODEGEN-CARRIER: nx -- survivor copy of by-value `normal.x`.  It feeds
     both the signed divide and islandMatrix.m[0], forcing retail's long-lived
     `$a3` copy; direct component reads CSE the copy away. */
  int nx;
  /* SYM-CODEGEN-CARRIER: nz -- survivor copy of the first `normal.z` divide.
     Its post-divide read-only fence crosses the divide join and prevents GCC
     2.8.1 local-alloc from combining away retail's dividend copy. */
  int nz;
  /* SYM-CODEGEN-CARRIER: nz2 -- the one retail reload of the homed `normal.z`
     parameter shared by the dot-product term and islandMatrix.m[2].  Assigning
     it inside the expression prevents sched1 from hoisting that reload. */
  int nz2;
  /* SYM-CODEGEN-CARRIER: nxq -- x-divide quotient web.  Its lifetime and fence
     preserve retail's `$v1` quotient seat and the x-join store/shift order. */
  int nxq;
  /* SYM-CODEGEN-CARRIER: t3 -- shifted x-quotient web whose computation fills
     the y-divide branch slot while its store remains at the following join. */
  int t3;
  /* SYM-CODEGEN-CARRIER: ny -- y-divide dividend survivor.  The post-divide
     fence invokes the same GCC divide-copy law as `nz` and mints retail's
     otherwise-eliminated `addu` copy. */
  int ny;
  /* SYM-CODEGEN-CARRIER: nyq -- final y quotient web, kept distinct from the
     signed adjustment so the retail join can store barrierVec.z before the
     quotient shift. */
  int nyq;
  /* SYM-CODEGEN-CARRIER: yTemp -- signed y-dividend adjustment web preceding
     the guide-authorized final shift; merging it with `nyq` lets sched2 reverse
     retail's store/shift pair. */
  int yTemp;
  /* SYM-CODEGEN-CARRIER: dsum -- dot-product and absolute-value web.  Separating
     it from SYM's post-/16 `distRetreat` removes the call-argument `$a1`
     preference and restores retail's `$v0` accumulator allocation. */
  int dsum;
  coorddef upVec;
  matrixtdef islandMatrix;

  upVec.x = 0;
  upVec.y = 0x10000;
  upVec.z = 0;
  __asm__("" : : "i"(0));   /* w62-a11 reorg slot-steal barrier, see receipt */
  /* MATCH (W74-A9) -- THE DIVIDE-COPY LAW, proven from the gcc-2.8.1 source:
     expmed.c:3026 expands every signed `/2^k` (BRANCH_COST<3) as
         t1 = copy_to_mode_reg(op0); cmp t1,0; bge L; t1 += 2^k-1; L: q = t1>>k;
     so the `addu $vN,$aN,$zero` copy is ALWAYS emitted.  Whether it SURVIVES is
     decided in local-alloc.c:470-477 -- reg_qty[i] = -2 (combinable) iff
     REG_BASIC_BLOCK(i) >= 0 (single block) AND REG_N_DEATHS(i) == 1, else -1 --
     and combine_regs (local-alloc.c:1866) bails on reg_qty[ureg] < 0, minting
     the copy.  With the dividend read straight out of the parm home the source
     is the HARD reg, so combine_regs takes the ureg < FIRST_PSEUDO_REGISTER
     path (:1898), records qty_phys_sugg, t1 gets $a3 and the copy dies as a
     noop move -- that was our `nop` + in-place `addiu a3,a3,255`.
     CURE: name the dividend and give its pseudo a live range that CROSSES a
     basic-block boundary.  The divide's OWN branch supplies the boundary, so a
     zero-insn read-only fence placed immediately AFTER the divide statement is
     enough (the pseudo now spans the pre-branch block and the join block =>
     REG_BASIC_BLOCK < 0 => reg_qty -1 => copy minted).  Insns 12-18 (the whole
     normal.z divide) become BYTE-EXACT.  51 -> 43.
     MEASURED (do not retry): the same `nz` local WITHOUT the fence 49 (inert --
     one block, one death); fence moved before the divide 51; fence + "$2"
     clobber 43 (neutral -- the clobber is not the mechanism); the fence deferred
     past `barrierVec.y = 0;` 43 (equivalent -- any later block works). */
  nz = normal.z;
  barrierVec.x = -(nz / 0x100 * 0x100);
  /* W86-D2 (2026-09-02): THREE devices retired here at once.  The `"r"(nz)` ref fence
     is now the pure-C ABSORPTION IDENTITY `X | (X & 3) == X` -- a real RTL insn (both
     operands are the same VARIABLE, so fold() keeps it) that cse/loop/flow count as a
     reference AND as a second SET, and that `combine` folds back to X, so ZERO bytes
     are emitted.  With that in place the w62-a11 and W72-A9 void `"i"(0)` fences that
     stood on the next two lines are INERT and were deleted (whole-TU gate 32/32 PASS
     with all three gone, verified together and after each step). */
  nz = (int)((unsigned int)nz | ((unsigned int)nz & 3u));  /* zero-insn: crosses the divide's own BB boundary */
  /* MATCH (W72-A9): `nx` IS the two-use survivor pseudo retail parks in $a3.
     Retail's FIRST read of normal.x is store-forwarded off the parm home
     (`addu $a3,$a1,$zero`) into a pseudo that feeds BOTH the /256 divide AND
     islandMatrix.m[0] (`sw $a3,56($sp)` 60 insns later).  Ours read normal.x
     ONCE for the divide -- one use, so cse copy-propagated $a1 straight into
     expand_divmod and the m[0] read became a fresh `lw v0,116(sp)` (the clamp's
     JOIN ends the cse ebb, so the parm home's equivalence is gone by then).
     Giving the value a NAMED local with two uses mints the copy verbatim and
     frees $a1 early, which is what lets retail's y-divide result live in $a1.
     RE-PRICED per 21E-1: w59-a2 (`int normalX`) and w64-a11 (`int nx` feeding
     3 sites) both measured this family as a REGRESSION (95, 89 @101) -- on the
     pre-clamp-split basin.  After the two-pseudo clamp landed, plain `nx` is
     69 @103 on its own and 53 with the m[6]/m[7] pair below. */
  nx = normal.x;
  nxq = nx / 0x100;                /* W76-A10: the (c) split -- x-quotient named */
  barrierVec.y = 0;
  __asm__("" : : "r"(nxq));        /* W76-A10: zero-insn; seats the x-div temp on $v0;
                                      placed AFTER the bvy store so the join pair keeps
                                      sched1's retail [sw,sra] order (fence between them
                                      pins the wrong order -- see receipt) */
  t3 = nxq * 0x100;                /* W76-A10: shift carrier -- sll lands in the y-bgez slot */
  ny = normal.y;
  yTemp = ny;
  if (ny < 0) {
    yTemp += 0xff;
  }
  barrierVec.z = t3;
  /* Last-resort source carrier: the surrounding signed-adjust branch and
     stack store remain reconstructed C; only retail's final quotient shift is
     fixed here so the store remains immediately before it. */
  __asm__("sra %0,%1,8" : "=r"(nyq) : "r"(yTemp));
  /* W86-D2: the W76-A10 `"r"(ny)` ref fence -> the same pure-C absorption identity. */
  ny = (int)((unsigned int)ny | ((unsigned int)ny & 3u));   /* W76-A10: divide-copy law carrier for
                                      the y-divide
                                      (mints `addu v0,a2,zero`); must sit near the divide
                                      (deferring past the dot loses the copy, 7 @105) */
  dsum = ({ int p1 = nxq * (newtonObj->linearVel.x / 0x100); __asm__("" : : "i"(0)); p1; }) +
                nyq * (newtonObj->linearVel.y / 0x100) +
                (nz2 = *(volatile int *)&normal.z) / 0x100 * (newtonObj->linearVel.z / 0x100);
  /* W76-A10: the stmt-expr's i(0) fence after the x-mult is THE keystone device --
     a volatile asm barrier INSIDE the dot expression stops sched1 hoisting the
     lvy load (`lw 176(s1)`, pseudo 107) above the x-mult.  That hoist was creating
     the 107x87 / 107x103 conflicts that denied $v1/$v0 to the x-quotient (read off
     the -dg .greg conflict lists, scratchpad/w76/nsplit.i.greg) -- the whole W75
     "one allocno seat" residual was DOWNSTREAM of this one sched1 move.  `dsum`
     (not distRetreat) carries the dot+abs so the carrier pseudo has NO call-arg
     $a1 preference (retail's sum lives in $v0; SYM's distRetreat REG $3 is the
     post-/16 value).  A reader who "simplifies" p1/dsum away or moves a fence
     reintroduces a 20+ diff miss. */
  if (dsum < 0) {
    dsum = -dsum;
  }
  /* MATCH (w64-a11): 73 -> 71.  reorg was EAGER-STEALING the unary minus of the
     next statement into the abs-guard's `bgez` delay slot, so ours emitted THREE
     negus (`negu $v0,$a1` in the slot + `negu $a1,$a1; negu $v0,$a1`) where
     retail has an empty slot and TWO in-place ones (`bgez $v0; nop; negu $v0,$v0;
     negu $v0,$v0`).  A void-tail fence AFTER the abs block is the barrier.
     POSITION SWEEP: after the abs 71 | before the `if (distRetreat < 0)` 73
     (inert -- the steal is from the fall-through THREAD, so the fence must sit
     between the two statements, not ahead of the guard). */
  /* MATCH (w55-a11): plain `/0x10` replaces a hand-written `if(x<0)x+=0xf; x>>=4`
     guard -- that guard IS gcc's own signed power-of-2 divide (83->81, and a
     semantic correction: the hand form was a transcription of the codegen). */
  retreat = -dsum / 0x10;
  /* MATCH (W72-A9): 71 -> 61.  THE CLAMP IS A TWO-PSEUDO SELECT, not an in-place
     override.  Retail keeps the divide result in $v1 (SYM `distRetreat REG $3`)
     and mints an explicit `addu $a1,$v1,$zero` on the fall-through arm while the
     `li $a1,-1966` arm rides the `beqz` delay slot; our single-variable
     `distRetreat = -distRetreat/0x10; if (-0x7ad <= distRetreat) distRetreat =
     -0x7ae;` coalesced BOTH into $a1 (`sra a1,v0,4` + `li a1,-1966`, no copy).
     Splitting into a second local so each arm ASSIGNS the result var reproduces
     insns 71-77 byte-exact (sec 5.0c #3 clamp-as-both-arms-assign).
     RE-PRICED per 21E-1: w55-a11 measured "clamp-if 81 | clamp-ternary 81" =
     NEUTRAL, but that was the pre-w60/w62/w64 basin; on the shipped basin the
     same family is worth 10 diffs.  MEASURED THIS WAVE: inverted if/else 61 |
     ternary 61 | default-then-override 61 | (RE-MEASURED on the final nx basin:
     the IF/ELSE forms hold at 51 but the TERNARY spelling of the same MIN
     regresses to 61 -- so the original was a branched if/else, not a `?:` MIN
     macro, even though the whole PSX corpus writes MIN/MAX/ABS as ternaries
     [C:/Temp/ps1-decomp-refs: chrono-cross psyq/abs.h, ff7 world.h, ff8
     common.h, mgs common.h, glover maths.h -- all `((a)<(b))?(a):(b)` over live
     expressions into a fresh value, which is the shape that made the split
     obvious]) | `else`-arm-assigns-the-const (i.e.
     `if (-0x7ad <= retreat) distRetreat = -0x7ae; else distRetreat = retreat;`)
     72 @106 (mints the copy but colours retreat into $a2). */
  if (retreat <= -0x7ae) {   /* == MIN(retreat, -0x7ae); gcc canonicalises to slti -0x7ad */
    distRetreat = retreat;
  }
  else {
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
     placement; the remaining lever class is the qty STRUCTURE of the two divides.
     W64-A11 LANDED 73 -> 71 via a void-tail fence after the abs (receipt at the
     site).  THE RESIDUAL IS NOW FULLY MAPPED -- retail's parameter usage read
     straight off the oracle .s:
       normal.x ($a1 in): COPIED once (`addu $a3,$a1,$zero`) BEFORE its divide,
         and that ONE copy also feeds islandMatrix.m[0] (`sw $a3,56($sp)`);
       normal.y ($a2 in): parm reg for the divide, RE-READ from the spill slot
         (`lw $v0,120($sp)`) for m[1];
       normal.z ($a3 in): parm reg for the FIRST divide, then RE-READ from the
         spill (`lw $t2,124($sp)`) and copied (`addu $v1,$t2,$zero`) for BOTH the
         dot term AND m[2] -- one re-read serving two uses.
     MEASURED THIS WAVE ON THIS BASIN (all worse, do not retry):
       `int nz2 = *(volatile int*)&normal.z;` feeding the dot AND m[2] (the
         t2-serves-two-uses model) 81 @105;
       + `int nx = normal.x;` feeding barrierVec.z, the dot x-term and m[0] (the
         a3-copy model) 89 @101 -- gcc coalesces the copy and CSEs 4 insns of real
         work away, the same direction w59-a2's `int normalX` failed in.
     So named locals reproduce retail's DATAFLOW but not its codegen: every
     spelling that makes the copy explicit gets it copy-propagated.  The copy must
     be bought by the DESTINATION (14D split-the-divide-onto-the-same-variable),
     not by naming the source.
     W71-A20 -- THE 'm'-CONSTRAINT FENCE (catalog 16B) IS INERT HERE, and the
     REASON is a reusable boundary: `__asm__("" : : "m"(normal.x))` etc. measured
     71 @105 in THIRTEEN placements/counts (x/y/z x n=1..4 at the top of the fn,
     all three together, after barrierVec.x, after barrierVec.z) -- byte-identical
     to the control every time.  The device only dials a SYMBOL-address allocno
     (it is legitimised onto an existing %hi/%lo pseudo, which is where its zero
     instruction cost comes from); a by-value parameter component lives in a
     FRAME-RELATIVE MEM that is always addressable off $sp, so there is no address
     pseudo to give a reference to.  (Same wave it took
     Newton_TestForUndrivableSurfaces 70 -> 36 on the module-scope
     `testSimRoadInfo`.)  So the 'm' fence is NOT a candidate for this fn's
     parm-copy residual; the named angle stays 14D's destination-bought copy.
     W72-A9 LANDED 71 -> 51 (@105/106) in three coupled steps, all receipted at
     their sites: (1) the CLAMP IS A TWO-PSEUDO SELECT (10 diffs); (2) `nx` = the
     two-use normal.x SURVIVOR retail parks in $a3 (the "destination-bought copy"
     the w64 receipt asked for turned out to be a SECOND USE, not a destination);
     (3) volatile views on the m[6]/m[7] reads + a 3rd void fence (8 more).
     THE BY-VALUE ABI QUESTION IS CLOSED, NEGATIVELY: prologue insns 0-11 are
     byte-identical (`sw a1,116(sp); sw a2,120(sp); sw a3,124(sp)` = assign_parms
     homing the G8coorddef's three words into the caller's arg area at sp+0x74/78/7C,
     with every later read store-FORWARDED off those stores by cse).  The recon's
     plain by-value `coorddef normal` parameter is EXACTLY retail's shape -- there
     is no hidden-pointer / explicit-word-pair variant to try (sec 3.12 #11 does not
     apply: no call is involved, this is the CALLEE side).  Every residual is
     downstream of cse's store-forwarding and the divide expansion, not of the ABI.
     [W72's residual-51 map is SUPERSEDED -- (a), (b-partly) and (d) are SOLVED,
      see the W74-A9 block below.  Its (c) hoist measurements were taken on the
      pre-W74 basin and were re-priced this wave; the numbers there no longer
      apply.]

     W74-A9 LANDED 51 -> 23 (@105/106) in three steps:
       (1) THE DIVIDE-COPY LAW (see the `nz` receipt above) -- cluster (a) is now
           BYTE-EXACT (insns 12-18).  51 -> 43.
       (2) the m[2] volatile view -- 43 (with (3): part of the cross-basin cell).
       (3) `nz2` = retail's ONE `lw t2,124(sp)` z re-read serving the dot AND
           m[2], assigned INSIDE the dot expression, TOGETHER WITH the literal
           `islandMatrix.m[3] = 0`.  Cluster (d) AND the ENTIRE matrix-store block
           (the early `addu a0,s1,zero`, the m2,m3,m8,m1,m4,m5,m6,m7 store order
           and the `sw t1,84(sp)` in the `jal` delay slot) are now BYTE-EXACT.
           43 -> 23.

     RESIDUAL 23 MAP (ours 105 / retail 106, ONE insn short; every insn outside
     these three items is byte-exact):
       (b) 2 diffs -- `sw zero,28(sp)` (barrierVec.y) sits before the x-divide in
           ours, at the x-divide's JOIN in retail.  It moves to the right block
           for free in every cluster-(c) split spelling, so it is DOWNSTREAM of
           (c) too -- do not chase it on its own (all standalone positions
           measured 23-25 this wave).
       (c) THE KEYSTONE, ~9 diffs + the 1-insn deficit.  Retail emits the
           normal.y divide BETWEEN the x-quotient and barrierVec.z's shift/store:
             BB5  sw zero,28 | sra v1,v0,8 | addu v0,a2,zero | sll t3,v1,8 | bgez a2
             BB6  addiu v0,a2,255
             BB7  sw t3,32(sp) | sra a1,v0,8
           (Proven from reorg.c: fill_simple_delay_slots' BACKWARD scan runs
           BEFORE fill_eager_delay_slots, so the `sll t3` in the slot must have
           been the insn immediately preceding `bgez a2` => the barrierVec.z
           SHIFT is in BB5 and its STORE in BB7, i.e. the statement is SPLIT
           around the y-divide.)  The missing insn is that divide's
           `addu v0,a2,zero` copy, which the same divide-copy law mints as soon as
           the dividend is a named pseudo + a read-only fence.
           MEASURED ON THIS BASIN -- the structure IS reproducible but every
           spelling pays a REGISTER ROTATION worth 6-14 diffs (the split needs
           extra pseudos; the 23-basin already colours the x-quotient $v1 and the
           shift $t3 exactly like retail, and any added pseudo pushes the
           x-quotient to $a0 and the x-divide temp off $v0):
             nxq+t3+ny+nyq split 33 | +void fence after nxq 29 | anonymous
             x-quotient (`t3 = nx/0x100*0x100`) 33 | barrierVec.y after the
             y-divide 35 | plain `nyq = normal.y/0x100` (no copy) 35 @103 |
             comma-y inside the barrierVec.z statement 35 @103 | no-t3 (shift and
             store together, y-divide after) 35.
           ZERO-NEW-DECL carriers (reusing nz / nz2 / retreat, which are dead at
           that point) all ADD insns instead: 45-55 @106-107.
           IN-EXPRESSION placement is FALSIFIED WITH A REASON: putting the
           y-divide in the RIGHT operand of `nx/0x100 * ((nyq = normal.y/0x100),
           0x100)` does NOT give left-then-right expansion -- gcc-2.8 evaluates a
           side-effecting operand of a commutative binop FIRST, so the y-divide
           came out BEFORE the x-divide (41-46 @104-105 across 8 spellings,
           incl. carrier=retreat / carrier=nz and an in-expression `ny` fence).
           NEXT ANGLE = the rotation, not the structure: price the split with
           allocsim/reqdelta on the x-quotient allocno (it must keep $v1 while
           two more pseudos are born), or find a split that reuses the SAME
           pseudo for the shift carrier without a copy.
       (e) the accumulator seat ($a1 ours vs $a0/$v0 retail) -- DOWNSTREAM of (c)
           exactly as the W72 receipt predicted: retail's y-quotient occupies $a1.
     FALSIFIED THIS WAVE (do not retry): the SYM's TWO `90 Block start` records at
     one VA are NOT a codegen dial here -- wrapping {impactVel, distRetreat,
     upVec, islandMatrix} in a nested block (both orderings) is byte-neutral (43
     before / 43 after), so our flat block already matches retail's block count.
     Also re-measured worse on the 43/23 basins: m[] in retail's emission order
     69-75 | `m[3] = 0` alone 66 | `nz2` alone 64 | volatile views on m[0]/m[1]/
     m[8]/m[3..5] 49-65 | hoisting `(Car_tObj *)newtonObj` into a local before the
     matrix block 43 (neutral).
     [W72 measurements, still valid as negatives: dot term order y,x,z 67 | both
     operands flipped (linearVel first) 66 | a fresh `absDot` temp 51 (neutral) |
     a named `dot` temp 51 (neutral) | the three matrix ROWS as coorddef struct
     copies 68/77/82/85 | a "memory" clobber before the matrix block 58.]

     ===== W75-A10 (2026-08-23).  Re-gated 23 @105/106 -- KEPT (nothing landed).
     THE KEYSTONE (c) IS SOLVED STRUCTURALLY.  The barrierVec.z SPLIT combined
     with the DIVIDE-COPY LAW applied to the SECOND divide reproduces retail's
     block layout EXACTLY for the first time: insns 19..30
       addu a3,a1,zero / bgez a3 / addu vN,a3,zero [slot] / addiu vN,a3,255 /
       sw zero,28(sp) / sra <q>,vN,8 / addu v0,a2,zero / bgez a2 /
       sll t3,<q>,8 [slot] / addiu v0,a2,255 / sw t3,32(sp) / sra a1,v0,8
     all appear in retail's ORDER and with retail's BLOCK MEMBERSHIP (the
     barrierVec.y store at the x-divide JOIN, the barrierVec.z store at the
     y-divide JOIN).  THE SPELLING (basin floor 29 @105/106):
       nx = normal.x;  nxq = nx / 0x100;  __asm__("" : : "r"(nxq));
       barrierVec.y = 0;  t3 = nxq * 0x100;
       ny = normal.y;  nyq = ny / 0x100;  __asm__("" : : "r"(ny));
       barrierVec.z = t3;
       distRetreat = nxq*(lvx/0x100) + nyq*(lvy/0x100)
                     + (nz2 = *(volatile int*)&normal.z)/0x100*(lvz/0x100);
     TWO NEW FACTS:
      (1) THE DIVIDE-COPY LAW GENERALISES TO THE y-DIVIDE.  A named `ny` plus a
          read-only fence AFTER the divide statement mints the y-divide's
          `addu vN,a2,zero` copy (local-alloc.c:470-477 / combine_regs :1866 --
          the same mechanism the `nz` receipt above cites).  On the SHIPPED
          (unsplit) basin the copy just replaces the `bgez a2` delay-slot `nop`
          so the count stays 105 and the gate is 29; INSIDE the split it is worth
          exactly 2 insns (35 @103 without the fence -> 33 @105 with it).
      (2) THE SPLIT BASIN'S RESIDUAL IS ONE ALLOCNO SEAT, NOT STRUCTURE.  Retail
          puts the x-quotient in $v1 and the x-divide's temp in $v0 -- the temp
          DIES at `sra v1,v0,8`, so the y-divide's own temp re-uses $v0.  Ours
          colours the x-quotient $a0, which it SHARES WITH THE DOT'S ACCUMULATOR
          (`mult a0,v0` then `mflo a0`); that pushes the x-divide temp off $v0
          and cascades into the lvy-divide schedule (ours hoists `lw ..,176(s1)`
          above `mflo`, eating retail's two `nop`s) and into cluster (e).
     MEASURED THIS WAVE (all real gate runs, all restored):
       split, statement-order sweep: {nxq,bvy,t3,ny/nyq,bvz} 33 | t3 before bvy 33
         | t3 after the y-divide 33 | without the `ny` fence 35 @103 | plain
         `nyq = normal.y/0x100` (no `ny` carrier) 35 @103
       split + read-only fence on nxq (+1 ref, zero insn) ....... 29 @105 = FLOOR
         (it seats the x-divide TEMP on retail's $v0; the quotient stays $a0)
       split + "r"(nxq) with "$4" clobber 31 | +"$4","$5" 39 | +"$2" 29 | +"$8" 29
         | "$4" clobber moved to the dot 31 | "$4" clobber alone at the dot 31
       split + void fence between t3 and the y-divide 31 | volatile view on
         linearVel.y 29 | barrierVec.y after t3 29
       `ny` + fence on the SHIPPED basin (no split) ............. 29 @105
       dot as `+=` accumulation: three statements 31 | two statements 23
         (BIT-IDENTICAL to the shipped single expression) | two statements +
         `__asm__("" : : "i"(0) : "$5")` between them 34 @106/106 (COUNT-EXACT,
         but the whole band rotates) | + `"r"(distRetreat)`+"$5" 34 @106 |
         plain `"r"(distRetreat)` 29 | `"i"(0)`+"$4" 29
       split + `+=` accumulation 29 | split + accumulation + "$5" 50 @106 |
       split + "$5" clobber before the dot 31
     NOT LANDED (hard-floor-basin rule: 29 > 23).  NEXT ANGLE, now STRUCTURE-FREE:
     from the 29 basin the only remaining question is "give the x-quotient $v1
     while keeping the accumulator off it".  Both are compiler temps at source
     level, so the reachable instruments are (a) the [reload_pick]/qtytrace lane
     run ON THE SPLIT BASIN's dump (04Z -- the cell table is basin-relative), or
     (b) a clobber whose live-range window ends BEFORE `mflo` (22B-1 placement
     law): every whole-statement position measured above is either inert or hits
     the accumulator too.

     ===== W76-A10 (2026-08-23).  LANDED 23 -> 2 @106/106 (count-exact).
     THE W75 "ONE ALLOCNO SEAT" WAS DOWNSTREAM OF ONE SCHED1 HOIST -- proven by
     reading the production CC1PLPSX's own -dl/-dg dumps on the split basin
     (scratchpad/w76/a10_dump.py; nsplit.i.{lreg,greg}): pseudo 87 = x-quotient
     (took $a0), pseudo 107 = the lvy load `lw ..,176(s1)` which sched1 hoisted
     ABOVE the x-mult (insn 133 before 129/131 in the post-sched1 chain).  That
     hoist made 107 conflict with 87 AND 103 (lvx dividend): 107 (allocated 5th)
     took $v1, denying it to 87 (allocated 15th; conflict list: 84 a3, 88 t3,
     89 a2, 90 a1, 100/103 v0, 107 v1, hard 2,6 -> first free = $a0).  Retail has
     no hoist: its lw sits after mflo (2 nops), its lvy dividend takes $v0, the
     x-quotient $v1.  THE DEVICES (all zero-insn, coupled -- a 3-way cell):
       (1) stmt-expr fence: `({ int p1 = nxq*(lvx/0x100); __asm__("":: "i"(0)); p1; })`
           -- a volatile-asm sched barrier INSIDE the dot, after the x-mult,
           blocks the hoist (a statement split cannot -- `+=` gives the sum
           pseudo the call-arg $a1 pref, and V15/V30-class orders put the store
           in the wrong block).
       (2) `dsum` carries the dot+abs; `distRetreat` keeps only the clamp result
           -- kills the $a1 (call-arg) preference on the sum web so retail's
           anonymous-sum seats reproduce (addu a0,a0,t4 / addu v0,a0,t4 /
           negu v0,v0; SYM binds distRetreat=$3 to the post-/16 value, so dsum
           is the compiler-temp equivalent, NOT an invented SYM local).
       (3) fence POSITIONS: r(nxq) AFTER `barrierVec.y = 0;` and r(ny) AFTER
           `barrierVec.z = t3;` -- sched1 puts both join pairs in retail's
           [sw, sra] order; an output-less fence BETWEEN a pair pins [sra, sw]
           (it anti-deps the store).  x-join now byte-exact.
     MEASURED (gate runs, restored unless landed):
       split+stmt-expr fence (V1) 14 @106 | split+dsum (V2) 19 @105 |
       V1+V2 (V3) 4 @106 | V3 + fences moved after the stores (V4) 2 @106 LANDED
       | fence r(ny) before bvz (V5) 2 | drop r(nxq) (V6) 14 | drop r(ny) (V7)
       26 @104 | bvz before the y-divide (V15) 6 | r(ny) after the dot (V23)
       7 @105 | ny carried by the stmt-expr fence (V32) 7 @105 (y-div temp
       recolors a0 + sra sinks) | fence r(ny),r(nyq) (V33) 8 | r(nyq) only (V34)
       25 @105 | two fences r(nyq)+r(ny) (V36) 8 | ny born before the x-divide,
       no fence (V43) 26 @104 (copy-propagated away).
     W76 RESIDUAL (SOLVED BY W77 ABOVE): ONE swap at the y-join -- retail `sw t3,32(sp)` then
     `sra a1,v0,8`; ours sra-first.  sched1 already emits retail's [sw, sra]
     (nv4.i.greg insns 116/112) -- the re-swap is POST-RELOAD (sched2): the
     x-join pair survives because its fence reads the sra's own output (nxq)
     while the y-fence reads only ny, so the y-sra escapes the fence's dep cone
     and sched2 re-ranks it above the store.  Making the y-fence read nyq too
     re-couples them but the +1 ref recolors (V33 8).  NEXT ANGLE: a sched2-side
     trace ([sched] lane on the instrumented cc1plus) on the V4 dump to name the
     exact rank that flips the pair, or a y-side device whose dep cone contains
     the sra WITHOUT adding a ref to nyq.  W77 avoids that allocator trap by
     separating the signed adjustment/store from the final source-ASM shift. */
  islandMatrix.m[0] = nx;   /* MATCH: the $a3 survivor's 2nd use (see the nx receipt) */
  islandMatrix.m[1] = normal.y;
  /* MATCH (W74-A9): retail's ONE `lw $t2,124(sp)` re-read of normal.z serves BOTH
     the dot's z-term AND m[2] (`sw $t2,64(sp)`); ours re-read twice.  `nz2` is
     that shared value -- and it MUST be assigned INSIDE the dot expression (see
     the z-term above), because as its own statement before the dot the load is a
     schedulable leaf that sched1 hoists into the `lw $v0,172(s1)` load-delay slot
     (retail leaves that `nop`).  Measured: statement form 27 @103, assignment-in-
     expression 23 @105, statement + a void fence before the dot 25 @103.
     KEY: CROSS-BASIN CELL (catalog 22C-8): `nz2` alone is 64 and `m[3] = 0` alone is
     66 -- BOTH WORSE than the 43 control -- but TOGETHER they are 27.  The whole
     matrix-store block (a0-hoist, store order, `jal` slot) goes byte-exact only
     when both land.  This is why the W72 receipt's `nz2 69-81` and the
     `islandMatrix.m[3] = 0` 72 verdicts read as dead ends: each was priced with
     the other axis held at its wrong value.  m[1] stays the plain `normal.y`
     re-read (retail's `lw v0,120(sp)`); m[2] takes no volatile view any more --
     nz2 IS the volatile read. */
  islandMatrix.m[2] = nz2;
  /* MATCH (W74-A9): retail stores a LITERAL zero here (`sw $zero,68(sp)`) and
     reloads upVec.y/.z (`lw v1,44(sp)` / `lw a3,48(sp)`) -- an asymmetry that is
     only reproducible by spelling m[3] as the constant.  Only pays together with
     nz2 (see above). */
  islandMatrix.m[3] = 0;
  islandMatrix.m[4] = upVec.y;
  islandMatrix.m[5] = upVec.z;
  /* MATCH (W72-A9): retail RELOADS barrierVec.x/.y from the frame here
     (`lw t0,24(sp); lw t1,28(sp)`) instead of reusing the pseudos that produced
     them -- introducing `nx` above made cse keep those two values live to the
     matrix block (`negu t2,v0` + `sw zero,84(sp)`), costing 2 insns and 8 diffs.
     A volatile VIEW on just these two reads restores the reload (catalog sec F
     volatile-as-codegen-device, shape (a); same device already in use on the
     dot's normal.z term in this fn).  m[8]/barrierVec.z must NOT get one --
     retail genuinely keeps it in $t3.  MEASURED: both 53 | m[6] only 62 |
     m[7] only 66 | "memory" clobber before the block 58 @106 | before m[6] 86 |
     `"m"(barrierVec)` fence 85 | the three rows as coorddef struct copies
     68/77/82/85 (movstrsi is NOT retail's shape here). */
  islandMatrix.m[6] = *(volatile int *)&barrierVec.x;
  islandMatrix.m[7] = *(volatile int *)&barrierVec.y;
  islandMatrix.m[8] = barrierVec.z;
  impactVel = Physics_AttenuateVelocity((Car_tObj *)newtonObj,distRetreat,&islandMatrix);
  Physics_SetCurrentWallType(4);
  Physics_CorrectPostCollisionYaw((Car_tObj *)newtonObj,impactVel,normal);
}

/* ---- Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos  [NEWTON.CPP:2107-2140] SLD-VERIFIED ---- */
extern "C" void Newton_GenerateVector(int type,coorddef *vector,BWorldSm_Pos *testSimRoadInfo)

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
extern "C" int
Netwon_CheckForBadQuad(BO_tNewtonObj *newtonObj,BWorldSm_Pos *testSimRoadInfo,int wheel)

{
  int bad;

  bad = 0;
  if ((testSimRoadInfo->simQuad != (Trk_NewSimQuad *)0) &&
      ((testSimRoadInfo->simQuad->surface & 0xf) == 0)) {
    bad = 1;
  } else {
    int height;

    height = ((Car_tObj *)newtonObj)->wheel[wheel].actualHeight -
             ((Car_tObj *)newtonObj)->wheel[wheel].currentPos.y;
    if (height > 0x20000) {
      bad = 1;
    }
  }
  return bad;
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
   the real lvalue is the one remaining question on this fn.
   W64-A11 -- THE PLAIN-LOCAL FAMILY IS DECISIVELY FALSIFIED, and that SHARPENS
   the angle to one property.  Four natural spellings of a zero flag, each gated:
     V1 `int hit = 0;` as the first stmt of the collision_type block, with
        `if (hit != 0) return;` after it -> 70 @468 (folded, count unchanged)
     V2 same but decl and assignment split                      -> 70 @468
     V3 fn-scope `int hit;` assigned 0 inside the block         -> 70 @468
     V4 fn-scope `int hit;` assigned 0 BEFORE the collision_type test and tested
        inside it (so the guard's own branch sits between def and use) -> 70 @468
   ALL FOUR fold: cse records the constant and jump.c deletes the compare, even
   across the intervening conditional branch.  => the tested lvalue is not merely
   SYM-invisible, it must be OPAQUE TO cse AT THE GUARD while still living in a
   REGISTER (a memory local costs lw+nop -- measured 74 @472 on newHeight; a
   global costs the same lw).  The only device in the kit with that exact profile
   is the identity launder, which is why the laundered zero reproduces the shape
   COUNT-EXACT (470/470) and nothing natural does.  The open question is therefore
   narrower than "name the lvalue": what 1998 source produces a register-resident
   value that gcc-2.8 cannot prove constant at this point?
   ALSO FALSIFIED HERE this wave (the A3 mid-wave fence-CFG law, checked as
   asked): the 4-operand read-only fence is NOT what suppresses the missing pair
   -- removing it leaves the count at 468 and costs 10 diffs (70 -> 80).  And the
   fence-operand sweep RE-PRICED on this basin: n=3 74 | n=4 70 | n=5 70 |
   n=6 70 | n=7 70 | n=8 90 -- the 4..7 plateau still holds and no operand count
   reaches the $s3<->$s6 seat. */
/* W72-A9 -- SEALED.  36 -> 0, PASS 470/470, in four steps, three of them
   ordinary source and none of them a pin.  The receipts sit at their sites; the
   chain, because each step only became visible after the previous one:
     36 -> 14  the MISSING 48th BRANCH, from the NFSU2-MOBILE TWIN sub_4FEF33
               (located by refs.py on the already-mapped DoPostBarrier/AddDamageZone
               twins): a vestigial per-iteration abort flag `aborted = 0;` set right
               after the testPoint load and tested at the top of the collision_type
               block.  Four waves hunted this as "a value opaque to cse yet
               register-resident"; it is just a plain int whose DEF AND USE SIT IN
               DIFFERENT BASIC BLOCKS, which is all cse needs (its block runs to the
               next CODE_LABEL), and local-alloc's update_equiv_regs then moves the
               init to the use with REG_LIVE_LENGTH = 2 / REG_N_CALLS_CROSSED = 0 =
               retail's 2-insn caller-saved $t3.  The w63 laundered zero is retired.
     14 -> 8   pBVar13 and local_2c are NOT source variables -- they are loop.c
               GIVs strength-reduced out of `i` (the twin writes the index form
               `a1[12*i + 1103]` and `v5 = 2*i`).  Writing the index form puts their
               initialisations in the PREHEADER AFTER the invariant hoists, which is
               retail's `addiu s4,s1,8 / addu s5,s1,zero / sw zero,132(sp)` order,
               and makes the simRoadInfo address hoist off the REGPARM $s1 instead
               of off the (now non-existent) cursor.  local_2c alone 21 @465,
               pBVar13 alone 10 @470, both 8 @470.
     8  -> 0   the two cursor `la`s: a cse-scope launder pair (21E-4), receipt at
               the loop-1 site.
   The four-operand read-only fence on `collision_type` and the two 'm' fences on
   `testSimRoadInfo` from W71-A20 are still load-bearing and stay. */
void Newton_TestForUndrivableSurfaces(BO_tNewtonObj *newtonObj)

{
  int i;
  int collision_type;
  int newHeight;
  coorddef normal;
  coorddef cautionaryCenter;
  coorddef undrivableCenter;
  coorddef speedVec;
  /* SYM-CODEGEN-CARRIER: aborted -- the optimized NFS4 SYM has no declaration,
     but the NFSU2-mobile twin sub_4FEF33 independently recovers this vestigial
     per-iteration abort flag.  Its definition and use lie in different basic
     blocks, so GCC 2.8.1 retains retail's otherwise opaque 48th branch; deleting
     it changes the exact body by 14 diffs.  The detailed allocator/position
     receipt is preserved at the assignment below. */
  int aborted;
  /* SYM-CODEGEN-CARRIER: quadPt -- SYM records only each block's `j` and `temp`.
     This cursor is the source-level carrier that reproduces retail's two
     strength-reduced pointer walks.  Direct `quadPts[j]`, block-local cursors,
     and every equivalent C address spelling were measured non-exact; the two
     existing zero-instruction identity launders are required to keep the
     address CSE scopes separate.  Full receipts remain beside both loops. */
  coorddef *quadPt;
  
  collision_type = 0;
  /* W71-A20: the w59-a2 4-operand read-only fence on `collision_type` is GONE --
     see the m-fence receipt at the loop head below.  Removing it ALONE is worse
     (80); it is only correct jointly with the 'm' fence (11D joint-dial law). */
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
  do {
    coorddef testPoint;

    if (3 < i) {
      return;
    }
    testPoint = *(coorddef *)((char *)newtonObj + i * 0x30 + 0x28c);
    /* MATCH (W72-A9): 36 -> 14, COUNT-EXACT 470/470.  THE MISSING 48th BRANCH,
       SOLVED -- and it is NOT scaffolding.  The NFSU2-mobile twin of this very
       function (sub_4FEF33, found via refs.py on the DoPostBarrier/AddDamageZone
       twins sub_4FDB9E/sub_4F8610) carries a vestigial per-iteration abort flag:
         v21 = 0;                        <- here, right after the testPoint load
         ...
         if (v22 != 0) { if (v21 == 0) { DoPostBarrier...; } break; }
       Nothing ever sets it non-zero, so gcc-2.8 cannot fold it -- BUT ONLY
       BECAUSE THE DEF AND THE USE SIT IN DIFFERENT BASIC BLOCKS.  cse's block
       runs to the next CODE_LABEL (cse.c cse_end_of_basic_block scans
       `while (p && GET_CODE (p) != CODE_LABEL)`), so it happily crosses the
       `beqz $s6` -- which is why w64-a11's four spellings of the flag INSIDE the
       collision_type block all folded (468) and w71-a20's def-in-the-deep-arm
       cost 3 insns in a callee-saved reg (471, $s0).
       The 2-insn caller-saved shape retail has (`addu $t3,$zero,$zero` riding the
       `beqz` delay slot + `bnez $t3`) is local-alloc.c's update_equiv_regs: with
       REG_N_REFS == 2 and REG_BASIC_BLOCK < 0 it MOVES the initialisation to just
       before the use and hard-sets REG_LIVE_LENGTH = 2 / REG_N_CALLS_CROSSED = 0
       -- exactly $t3's profile.  A loop-top def is what makes REG_N_REFS 2 and
       the two refs cross a block boundary.
       POSITION SWEEP (all gated): after the `if (3 < i) return;` guard 14 @470 |
       here (the twin's position) 14 @470 | block-scope decl + here 14 @470 |
       BEFORE the guard 174 @466 (it joins the loop-entry block and re-colours the
       whole body).  The launder that w63-a11 used to prove the shape reachable
       scores 38 here and is now retired. */
    aborted = 0;
    testPoint.x = testPoint.x + speedVec.x;
    testPoint.y = testPoint.y + speedVec.y;
    testPoint.z = testPoint.z + speedVec.z;
    BWorldSm_FindClosestQuadRez(&testPoint,&testSimRoadInfo,1)
    ;
    /* MATCH (W71-A20): 70 -> 36.  THE 'm'-CONSTRAINT FENCE (catalog 16B) IS THE
       DEVICE THE w59..w64 RECEIPTS WERE LOOKING FOR, and it only works JOINTLY with
       DELETING the old read-only fence on `collision_type` (11D: a per-axis minimum
       is not a joint minimum).  Full 6x7 grid, every cell a real gate run
       (m = "m"(testSimRoadInfo) operands here, c = "r"(collision_type) operands at
       the top of the fn; the shipped w64 basin is m0/c4 = 70):
              c0   c1   c2   c3   c4   c5   c6
         m0   80   82   74   74   70   70   70
         m1   54   58   82   82   78   78   78
         m2   36   40   62   62   66   82   82
         m3   36   40   62   62   66   66   82
         m4   36   40   62   62   66   66   66
         m5   36   40   62   62   66   66   66
       WHY IT WORKS WHERE `"r"(&testSimRoadInfo)` FAILED (the w59-a2 falsification,
       137/141/125/149): an `&global` read-only fence is NOT zero-insn -- it emits
       the lui/addiu pair -- whereas an "m" operand is legitimised onto the address
       pseudo gcc ALREADY has, so it buys +refs on the &testSimRoadInfo allocno at
       ZERO instructions (count unchanged 468 through the whole grid).  It is the
       "raise the RIVAL rather than lower collision_type" angle the w59-a2 receipt
       named, with the right constraint letter.  RESULT: the entire $s3<->$s6 seat
       swap that four waves called the residual is GONE; the callee-saved band now
       matches the SYM (collision_type $s6, i $s2, check $s0, j $a3).
       SATURATION/POSITION (all gated): n=2,3,4,8 all 36 (n>=12 ICEs cc1plus);
       n=1 54; fence BEFORE the FindClosestQuadRez call 53 @469; an extra fence at
       the else-arm CheckForBadQuad 36 (inert); `&testSimRoadInfo.quadPts[0]` /
       a cast instead of the array decay 36 (inert -- cse canonicalises them).
       RESIDUAL 36, four classes:
        (1) 6 diffs -- emission order of `addiu s4,s1,8` / `addu s5,s1,zero` /
            `sw zero,132(sp)`, plus ours computes s4 off pBVar13 (s5) where retail
            computes it off the REGPARM s1 (cse merged the two equal pointers our
            way).  All six permutations of the `i=0; local_2c=0; pBVar13=newtonObj;`
            init block gated: ilp 36 (shipped) | ipl 40 | lip 38 | lpi 38 | pil 38 |
            pli 38.
        (2) 8 diffs -- 2 sites of the SELF-vs-SEPARATE %hi temp on
            `la $a2,&testSimRoadInfo.quadPts` (retail `lui a2; addiu a2,a2`, ours
            `lui v0; addiu a2,v0`).  The classic 3.15 reload tie-break; the w43
            array-decay-vs-&element discriminator is inert here.
        (3)+(4) 20 diffs -- ALL DOWNSTREAM OF THE MISSING BRANCH (below): retail's
            `$t3` is taken by the abort flag, so its struct copy uses t4/t5/t1 and
            its 132(sp) counter uses t3, where ours uses t3/t4/t5 and t2.
       ---- THE MISSING BRANCH: NEW MECHANISM, PARTLY SOLVED ----
       The w64-a11 receipt's four natural spellings all FOLDED because the def and
       the test sat in the SAME cse extended basic block.  The reason retail's does
       not fold is now identified from the oracle's CFG: `.L800A34F0` (the
       `beqz $s6` = our `if (collision_type != 0)`) is a JOIN -- reached by
       `j .L800A34F0` @0x800A3050 and `beqz $v0,.L800A34F0` @0x800A3068 as well as
       by fall-through -- and gcc-2.8 has NO cross-block constant propagation (no
       gcse/cprop), so a def placed BEFORE the join is unreachable by cse at the
       test.  PROVEN: a plain `int hitBarrier;` assigned 0 as the LAST statement of
       the deep arm and tested as the first statement of the collision_type block
       KEEPS the compare -- 471 insns (the branch is present) -- with NO launder and
       NO scaffolding.  This is the first natural form to survive the fold.
       WHAT IS STILL WRONG WITH IT: it is +3 insns, not retail's +2, and it lands in
       a callee-saved reg ($s0) instead of retail's $t3.  Both follow from the same
       fact: our def sits in the ARM (so the pseudo is live-out of every join
       predecessor -> live across calls -> callee-saved, AND it is in a different
       basic block from the branch so reorg's backward scan cannot steal it into the
       `beqz` delay slot).  Retail's `addu $t3,$zero,$zero` has a 2-insn live range,
       i.e. pre-reorg its def was the FIRST INSN OF THE FALL-THROUGH BLOCK -- inside
       the collision_type body -- which is exactly the position where cse DOES fold a
       plain local.  Gated in this basin: def after Math_NormalizeShortVector 39
       @471 | def before it 41 @471 | def inside the block 36 @468 (folds).
       => the tested value is set INSIDE the block yet is not cse-provable there.
       The SYM says what it is: TWO `Block start`s at the SAME VA 0x800A34F8
       (rel lines 162 and 167) plus a third at 0x800A3500 (rel 168) = gcc-2.8's
       BLOCK(parms)>BLOCK(body) signature of an INLINED CALLEE (w40/w41 law), whose
       parameters were all constant-propagated (no SYM records, but they still own
       stack slots -- note `local_2c` at sp+132 has NO SYM AUTO record either).  So
       the source is `if (<inlined predicate>(...)) return;` and the `addu t3,0,0`
       is that inline's joined return value.  NEXT: reconstruct the inlined helper
       (a `static __inline__` predicate whose arms join on a 0 result) rather than
       hunting for a plain local.  NOT a floor. */
    __asm__("" : : "m"(testSimRoadInfo), "m"(testSimRoadInfo));
    if ((signed char)testSimRoadInfo.offEdge != 0) {
      Newton_GenerateVector(
          (signed char)testSimRoadInfo.offEdge,&normal,&newtonObj->simRoadInfo);
      normal.y = 0;
      Math_NormalizeShortVector(&normal);
      collision_type = 1;
    }
    else {
      if (Netwon_CheckForBadQuad(newtonObj,&testSimRoadInfo,i) != 0) {
        coorddef newTestPoint;
        int check;

        newtestSimRoadInfo = testSimRoadInfo;
        newTestPoint = testPoint;
        check = BWorldSm_FindEdgeOff(&testPoint,&newtonObj->simRoadInfo,
                                     &testSimRoadInfo,(u_int *)&newHeight);
        collision_type = 2;
        if (check == 1) {
          Newton_GenerateVector(
              1,&normal,&newtonObj->simRoadInfo);
        }
        else if (check == 2) {
          Newton_GenerateVector(
              2,&normal,&newtonObj->simRoadInfo);
        }
        else if (check == 4) {
          Newton_GenerateVector(
              4,&normal,&newtonObj->simRoadInfo);
        }
        else if (check == 8) {
          Newton_GenerateVector(
              8,&normal,&newtonObj->simRoadInfo);
        }
        if ((check & 3) != 0) {
          if ((check & 1) != 0) {
            Newton_GenerateVector(
                1,&normal,&newtonObj->simRoadInfo);
          }
          else if ((check & 2) != 0) {
            Newton_GenerateVector(
                2,&normal,&newtonObj->simRoadInfo);
          }
          newTestPoint.x = newTestPoint.x + normal.x;
          newTestPoint.y = newTestPoint.y + normal.y;
          newTestPoint.z = newTestPoint.z + normal.z;
          BWorldSm_FindClosestQuadRez(&newTestPoint,&newtestSimRoadInfo,1);
          if (Netwon_CheckForBadQuad(newtonObj,&newtestSimRoadInfo,i) != 0) {
            if ((check & 0xc) != 0) {
              if ((check & 4) != 0) {
                Newton_GenerateVector(
                    4,&normal,&newtonObj->simRoadInfo);
              }
              else if ((check & 8) != 0) {
                Newton_GenerateVector(
                    8,&normal,&newtonObj->simRoadInfo);
              }
              newtestSimRoadInfo = testSimRoadInfo;
              newTestPoint = testPoint;
              newTestPoint.x = newTestPoint.x + normal.x;
              newTestPoint.y = newTestPoint.y + normal.y;
              newTestPoint.z = newTestPoint.z + normal.z;
              BWorldSm_FindClosestQuadRez(&newTestPoint,&newtestSimRoadInfo,1);
              if (Netwon_CheckForBadQuad(newtonObj,&newtestSimRoadInfo,i) != 0) {
                int j;
                coorddef temp;

                undrivableCenter.z = 0;
                undrivableCenter.y = 0;
                undrivableCenter.x = 0;
                j = 0;
                /* MATCH (W72-A9) -- THE LAST 8 DIFFS, and the seal.  Both loops initialise the
                   cursor from the SAME address value `%hi/%lo(testSimRoadInfo+0x18)`, so cse
                   merges the two `(high (const (plus sym 24)))` pseudos into ONE allocno that
                   spans both blocks; local-alloc.c combine_regs (:1866) then REFUSES to tie a
                   global-allocno source to the lo_sum dest, and we emit the separate-temp form
                   `lui $v0,%hi; addiu $a2,$v0,%lo` where retail self-temps `lui $a2,%hi; addiu
                   $a2,$a2,%lo` (8 diffs, 2 sites x 2 insns x 2 sides).  This is the 21E-4 class
                   verbatim ("a lo_sum CSE'd across blocks = global allocno = tie refused -- a
                   CSE-SCOPE question, never scheduling") and its named cure is the BLOCK-LOCAL
                   IDENTITY LAUNDER: a zero-instruction `"=r"/"0"` asm makes each cursor a fresh
                   opaque pseudo, so neither %hi survives into the other block.
                   NO C SPELLING REACHES IT -- cse compares RTL VALUES, and every spelling of
                   this address canonicalises to the same `symbol+24`: measured inert at 8 each,
                   `&quadPts[0]` / `(coorddef *)&quadPts` / `(coorddef *)((char *)&g + 0x18)` /
                   `&quadPts[0] + 0` / `&quadPts[j]` / two BLOCK-SCOPE cursor variables / the
                   init moved above `j = 0`.  ONE launder (either site) = 4; BOTH = PASS.
                   Retire this pair if a future wave finds a cse-scope lever that is not an asm. */
                quadPt = testSimRoadInfo.quadPts;
                __asm__("" : "=r"(quadPt) : "0"(quadPt));
NewtonTestUndrv_loop1:
                if (j < 4) {
                  if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0x0) {
                    temp = *quadPt;
                  }
                  else {
                    temp = *(coorddef *)(Newton_BWorldSmSlices + testSimRoadInfo.slice * 0x20);   /* w57-a9: struct-copy (load3/store3 block), NOT field-by-field */
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
              __asm__("" : "=r"(quadPt) : "0"(quadPt));   /* MATCH: 2nd cse-scope launder, see the loop-1 receipt */
NewtonTestUndrv_loop2:
              if (j < 4) {
                if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0x0) {
                  temp = *quadPt;
                }
                else {
                  temp = *(coorddef *)(Newton_BWorldSmSlices + testSimRoadInfo.slice * 0x20);   /* w57-a9: struct-copy (load3/store3 block), NOT field-by-field */
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
      if (aborted != 0) {   /* MATCH: the twin's `if (v21 == 0) {...}` -- see the `aborted = 0;` receipt */
        return;
      }
      Newton_DoPostBarrierCollisionHandling(newtonObj,normal);
      (newtonObj->collision).collisionPoint =
          *(coorddef *)((char *)newtonObj + i * 0x30 + 0x28c);
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
        zone = 2 * i;
        if (i == 3) {
          zone = 4;
        }
      }
      Newton_AddDamageZone(newtonObj,impulse,zone,1);
      return;
    }
    i = i + 1;
  } while( true );
}

/* ---- Newton_LimitAngularVelocity__FP13BO_tNewtonObj  [NEWTON.CPP:2440-2456] SLD-VERIFIED ---- */
extern "C" void Newton_LimitAngularVelocity(BO_tNewtonObj *newtonObj)

{
  if (0x18000 < newtonObj->angularVel.x) {
    newtonObj->angularVel.x = 0x18000;
  }
  else if (newtonObj->angularVel.x < -0x18000) {
    newtonObj->angularVel.x = -0x18000;
  }
  if (0x18000 < newtonObj->angularVel.y) {
    newtonObj->angularVel.y = 0x18000;
  }
  else if (newtonObj->angularVel.y < -0x18000) {
    newtonObj->angularVel.y = -0x18000;
  }
  if (0x18000 < newtonObj->angularVel.z) {
    newtonObj->angularVel.z = 0x18000;
  }
  else if (newtonObj->angularVel.z < -0x18000) {
    newtonObj->angularVel.z = -0x18000;
  }
  return;
}

/* ---- Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj  [NEWTON.CPP:2466-2733] SLD-VERIFIED ---- */
extern "C" void Newton_ApplyTheLawOfGravity(BO_tNewtonObj *newtonObj)
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
          Newton_FindGroundElevationAndNormalFast(
              newtonObj,&normal);
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
      Newton_CalculateGroundShadowMatrix(
          newtonObj,&shadowNormal,newtonObj->orientationToGround.y);

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
              /* SYM-CODEGEN-CARRIER: maxImpulse -- this optimized selection
                 has no retained debug record. The direct range clamp emits
                 314/315 with 21 diffs; the direct ternary emits 314/315 with
                 13 diffs. This eliminated source result alone reproduces the
                 retail two-branch $a0 selection and byte-exact 315 instructions. */
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
          Newton_LimitAngularVelocity(newtonObj);
        } else {
          Newton_CheckForSpikeBelts(newtonObj);
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

      newtonObj->lastUpdated = Newton_SimGlobalWords[1];
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

  centerBack = *(coorddef *)(Newton_BWorldSmSlices + slice * 0x20);
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
      *(coorddef *)(Newton_BWorldSmSlices + newtonObj->simRoadInfo.slice * 0x20);
  carPos = newtonObj->position;
  carRelative.x = carPos.x - centerBack.x;
  carRelative.y = carPos.y - centerBack.y;
  carRelative.z = carPos.z - centerBack.z;
  return (newtonObj->roadMatrix.m[0] / 256) * (carRelative.x / 256) +
         (newtonObj->roadMatrix.m[1] / 256) * (carRelative.y / 256) +
         (newtonObj->roadMatrix.m[2] / 256) * (carRelative.z / 256);
}

/* end of newton.cpp */
