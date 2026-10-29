#line 1 "C:/nfs4/GAME/COMMON/newton.cpp"
/* game/common/newton.cpp -- RECONSTRUCTED (NFS4 PSX Newton physics integrator; C++ TU)
 *   32 fns: ground elevation/normal ray-cast, road geometry, slice orientation, rot/vel
 *   integration @32/64Hz, ground-shadow matrices, barrier/spike collision, gravity.
 *   GTE-free (fixed-point + eaclib math). Remaining native/source/SLD
 *   differences are tracked in sym-match.md; no whole-module seal is claimed.
 */
#include "newton_types.h"
#include "newton_externs.h"

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x80055FDC): the unused inline of the
 * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

#define MAX(a,b) (((a) > (b)) ? (a) : (b))


/* ---- newton.obj-owned BSS. SYM records the five named tables/road records as EXT;
 * the two coorddef out-parameter scratch objects are function-local statics below. ---- */
/* RUNTIME-LANE FIX (2026-09-13, value_audit vs NFS4.MAP): these are INITIALIZED
 * const tables in retail .data @0x8011401C/0x801140E4/0x80114124, not zeroed BSS.
 * The old uninitialized decls left them all-zero -> divTable made
 * fixedmult(numerator, divTable[index]) return 0 (broken suspension division),
 * fudgeTable zeroed the ride-height fudge, and swap[]={0,0,0,0} routed all four
 * wheels' impactCompression writes to wheel[0].  Values recovered from the image. */
int          divTable[50] = {
    65536, 66052, 66576, 67108, 67650, 68200, 68759, 69327, 69905, 70492,
    71089, 71697, 72315, 72944, 73584, 74235, 74898, 75573, 76260, 76959,
    77672, 78398, 79137, 79891, 80659, 81442, 82241, 83055, 83886, 84733,
    85598, 86480, 87381, 88301, 89240, 90200, 91180, 92182, 93206, 94254,
    95325, 96420, 97541, 98689, 99864, 101067, 102300, 103563, 104857, 106184
};
short        fudgeTable[32] = {
      0,  20,  36,  44,  30,  44,  52,  46,  36,  20,   6, -20, -30, -16,   0,  18,
     26,  38,  52,  40,  30,  15,   0, -20, -32, -16,  -8,   8,  16,  20,  16,   8
};
int          swap[4] = { 0, 1, 2, 3 };
BWorldSm_Pos testSimRoadInfo;
BWorldSm_Pos newtestSimRoadInfo;

/* Retail's nameless inline pair matches this getter's parameters/body;
 * Newton_GetSpikeBelt is an inferred helper spelling, not a recovered symbol.
 * The direct active_ result needs no extra source-local active snapshot. */
static inline int Newton_GetSpikeBelt(int *slice,int *leftLatPos,int *rightLatPos)
{
  if (AICop_spikeBelt.active_ != 0) {
    *slice = AICop_spikeBelt.slice_;
    *leftLatPos = AICop_spikeBelt.leftLatPos_;
    *rightLatPos = AICop_spikeBelt.rightLatPos_;
  }
  return AICop_spikeBelt.active_;
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


/* ---- Newton_AddDamageZone__FP13BO_tNewtonObjiii [NEWTON.CPP:50; COVERED-SLD-PASS] ---- */
/* 2026-10-29: the actual final maximum selects the old adjacent damage or
 * temp's average into existing imp,then stores it. That real provided-value
 * flow restores the last source111 shift tag without changing502 code words,
 * any of15 owner records,38 block records or end216. No new object,asm,
 * qualifier,identity,fake use,scope or directive is added. Typed Car fields
 * forceNoSimOptz/collision.smoking and every prior source phase stay intact.
 * Literal original select punctuation/reuse spelling is not uniquely proved.
 * Receipt:build/nc12/newton_damage_note_20261029/final-proof.json. */
#line 48 "C:/nfs4/GAME/COMMON/newton.cpp"
void Newton_AddDamageZone(BO_tNewtonObj *newtonObj,int impulse,int zone,int type)

{



  if (Force_IsForceOn((Car_tObj *)newtonObj) != 0) {

    Force_HitWall((newtonObj->collision).impulse);
  }



  if (GameSetup_gData.Damage != 0)
  {
    int imp; if (0x640000 < impulse / 2) imp = 0x640000; else imp = impulse / 2;

    if ((((Car_tObj *)newtonObj)->carFlags & 0x200U) != 0)
      imp = imp / 2;

    if (imp < newtonObj->damage[zone]) imp = newtonObj->damage[zone]; newtonObj->damage[zone] = imp;

    if (zone < 8)
    {

      if (zone == 0)
      {

        int temp = (newtonObj->damage[0] + newtonObj->damage[2]) / 2;
        newtonObj->damage[1] = temp < newtonObj->damage[1] ? newtonObj->damage[1] : temp;
        imp = (newtonObj->damage[0] + newtonObj->damage[6]) / 2;
        if (imp < newtonObj->damage[7]) imp = newtonObj->damage[7]; newtonObj->damage[7] = imp;
      }
      else if (zone == 1)
      {
        int temp;
        temp = (newtonObj->damage[7] + newtonObj->damage[1]) / 2;
        newtonObj->damage[0] = temp < newtonObj->damage[0] ? newtonObj->damage[0] : temp;
        imp = (newtonObj->damage[1] + newtonObj->damage[3]) / 2;
        if (imp < newtonObj->damage[2]) imp = newtonObj->damage[2]; newtonObj->damage[2] = imp;
      }
      else if (zone == 6)
      {
        int temp;
        temp = (newtonObj->damage[4] + newtonObj->damage[6]) / 2;
        newtonObj->damage[5] = temp < newtonObj->damage[5] ? newtonObj->damage[5] : temp;
        imp = (newtonObj->damage[0] + newtonObj->damage[6]) / 2;
        if (imp < newtonObj->damage[7]) imp = newtonObj->damage[7]; newtonObj->damage[7] = imp;
      }
      else if (zone == 7)
      {
        int temp;
        temp = (newtonObj->damage[7] + newtonObj->damage[1]) / 2;
        newtonObj->damage[0] = temp < newtonObj->damage[0] ? newtonObj->damage[0] : temp;
        imp = (newtonObj->damage[5] + newtonObj->damage[7]) / 2;
        if (imp < newtonObj->damage[6]) imp = newtonObj->damage[6]; newtonObj->damage[6] = imp;
      }

      else {

        int temp; temp = (imp + newtonObj->damage[zone + 2]) / 2;
        if (temp < newtonObj->damage[zone + 1]) imp = newtonObj->damage[zone + 1]; else imp = temp; newtonObj->damage[zone + 1] = imp;
        temp = (newtonObj->damage[zone] + newtonObj->damage[zone - 2]) / 2;
        imp = newtonObj->damage[zone - 1] > temp ? newtonObj->damage[zone - 1] : temp; newtonObj->damage[zone - 1] = imp;
      } } }




  if (type != 0)
  {
    matrixtdef transposeMat;
    int intensity; int xMult; int yMult; int zMult;
    xMult = 0x20000;
    yMult = 0;
    zMult = 0x20000;


    if (impulse > 0x5a0000) {

      impulse /= 4;



      newtonObj->flightTime = 1;
      (newtonObj->collision).lastCollision = 0;
      ((Car_tObj *)newtonObj)->collision.smoking = 1;




      if (newtonObj->objAltitude < 0x20000)
        newtonObj->position.y = newtonObj->position.y + 0x10000;








      newtonObj->linearVel.y = 0xc0000 < newtonObj->linearVel.y + impulse / 3 ? 0xc0000 : newtonObj->linearVel.y + impulse / 3;
      intensity = impulse / 32; if (0x9999 < intensity) intensity = 0x9999;



      if ((BWorldSm_TunnelFlagSm(&newtonObj->simRoadInfo) != 0) && (0x90000 < newtonObj->linearVel.y))
        newtonObj->linearVel.y = 0x90000;


      if (0x140000 < impulse) {

        randtemp = fastRandom * randSeed; xMult = ((randtemp & 0xffff00) >> 8) * 4; fastRandom = randtemp & 0xffff;
        randtemp = fastRandom * randSeed; yMult = ((randtemp & 0xffff00) >> 8) * 3; fastRandom = randtemp & 0xffff;
        randtemp = fastRandom * randSeed; zMult = ((randtemp & 0xffff00) >> 8) * 3; fastRandom = randtemp & 0xffff;

        randtemp = fastRandom * randSeed; fastRandom = randtemp & 0xffff; if ((randtemp & 0xffff00) >> 8 < 0x3333)
          intensity = -intensity;

        if (xMult + yMult + zMult < 0x40000) {

          if (xMult < 0x10000)
            xMult *= 2;
          if (yMult < 0x10000)
            yMult *= 2;
          if (zMult < 0x10000)
            zMult *= 2;
        }
      }


      if (type == 2) {

        xMult = xMult << 1;
        yMult = yMult << 1;
        zMult = zMult << 1;
      }
    } else {


      intensity = impulse / 64; if (0x8000 < intensity) intensity = 0x8000;
    }


    ((Car_tObj *)newtonObj)->angularVel_ch.x = fixedmult(newtonObj->angularVel.x,newtonObj->orientMat.m[0]) + fixedmult(newtonObj->angularVel.y,newtonObj->orientMat.m[1]) + fixedmult(newtonObj->angularVel.z,newtonObj->orientMat.m[2]);
    ((Car_tObj *)newtonObj)->angularVel_ch.y = fixedmult(newtonObj->angularVel.x,newtonObj->orientMat.m[3]) + fixedmult(newtonObj->angularVel.y,newtonObj->orientMat.m[4]) + fixedmult(newtonObj->angularVel.z,newtonObj->orientMat.m[5]);
    ((Car_tObj *)newtonObj)->angularVel_ch.z = fixedmult(newtonObj->angularVel.x,newtonObj->orientMat.m[6]) + fixedmult(newtonObj->angularVel.y,newtonObj->orientMat.m[7]) + fixedmult(newtonObj->angularVel.z,newtonObj->orientMat.m[8]);

    if ((u_int)zone < 3) {
      ((Car_tObj *)newtonObj)->angularVel_ch.x -= fixedmult(intensity,xMult) / 2;
    } else
    { ((Car_tObj *)newtonObj)->angularVel_ch.x += fixedmult(intensity,xMult) / 2; }

    if (zone - 2U < 3) {

      ((Car_tObj *)newtonObj)->angularVel_ch.y += fixedmult(intensity,yMult) / 2;
      ((Car_tObj *)newtonObj)->angularVel_ch.z += fixedmult(intensity,zMult) / 2;
    } else {


      ((Car_tObj *)newtonObj)->angularVel_ch.y -= fixedmult(intensity,yMult) / 2;
      ((Car_tObj *)newtonObj)->angularVel_ch.z -= fixedmult(intensity,zMult) / 2;
    }


    transpose(&newtonObj->orientMat,&transposeMat);
    newtonObj->angularVel.x = fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.x,transposeMat.m[0]) + fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.y,transposeMat.m[1]) + fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.z,transposeMat.m[2]);
    newtonObj->angularVel.y = fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.x,transposeMat.m[3]) + fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.y,transposeMat.m[4]) + fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.z,transposeMat.m[5]);
    newtonObj->angularVel.z = fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.x,transposeMat.m[6]) + fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.y,transposeMat.m[7]) + fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.z,transposeMat.m[8]);
  } }
#line 301 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_FindClosestQuad__FP13BO_tNewtonObj [retail NEWTON.CPP:221; COVERED-SLD-PASS] ---- */
/* 2026-10-29: supplied variables and genuine call/mutation/exit phases match
 * every word/file tag,header,frame,owner,block and end. No new source object,
 * qualifier,asm,fake use or scope is introduced. Literal macro/comment text
 * remains unproved. The following boundary-only reset preserves unmodified
 * neighbors' coordinates;it is not a claim that their old layout is retail.
 * Receipt:build/nc12/newton_small_source_20261029/final-proof.json. */
#line 219 "C:/nfs4/GAME/COMMON/newton.cpp"
void Newton_FindClosestQuad(BO_tNewtonObj *n)

{





  BWorldSm_FindClosestQuadRez(&n->position,&n->simRoadInfo,1); return;
}
#line 310 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_CalculateSliceYaw__Fi [retail NEWTON.CPP:235; COVERED-SLD-PASS] ---- */
/* 2026-10-29: supplied variables and genuine call/mutation/exit phases match
 * every word/file tag,header,frame,owner,block and end. No new source object,
 * qualifier,asm,fake use or scope is introduced. Literal macro/comment text
 * remains unproved. The following boundary-only reset preserves unmodified
 * neighbors' coordinates;it is not a claim that their old layout is retail.
 * Receipt:build/nc12/newton_small_source_20261029/final-proof.json. */
#line 233 "C:/nfs4/GAME/COMMON/newton.cpp"
int Newton_CalculateSliceYaw(int slice)

{
  int s; int x1; int z1; int x2; int z2; s = slice + 1 >= gNumSlices ? slice + 1 - gNumSlices : slice + 1;
  x1 = BWorldSm_slices[slice].center[0];
  z1 = BWorldSm_slices[slice].center[2];
  x2 = BWorldSm_slices[s].center[0];
  z2 = BWorldSm_slices[s].center[2];



  x1 = x2 - x1; z1 = z2 - z1; return intatan(x1,z1);
}
#line 331 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_UpdateRoadGeometry__FP13BO_tNewtonObj [NEWTON.CPP:248; COVERED-SLD-PASS] ---- */
/* 2026-10-29: genuine table/roughness/copy/cross-product/YAW/return phases
 * restore all supplied owners,block and absolute SLD records with unchanged
 * code. No new object,asm,qualifier,fake use or synthetic scope is introduced.
 * Literal macro/comment text remains unproved. Boundary reset preserves only
 * the measured coordinates of unchanged neighbors,not source completeness.
 * Receipt:build/nc12/newton_elevation_source_20261029/final-proof.json. */
#line 246 "C:/nfs4/GAME/COMMON/newton.cpp"
void Newton_UpdateRoadGeometry(BO_tNewtonObj *n)

{
  int hiRez;
  int slice;


  if (!n->active) return;


  hiRez = n->simOptz < 2;


  slice = n->simRoadInfo.slice;


  if (hiRez)
  {

    n->roadCenterPoint.z = 0; n->roadCenterPoint.y = 0; n->roadCenterPoint.x = 0;
    for (int i = 0; i < 4; i++) {
      coorddef temp;

      if (n->simRoadInfo.simQuad) temp = n->simRoadInfo.quadPts[i]; else temp = *(coorddef *)BWorldSm_slices[n->simRoadInfo.slice].center;
      n->roadCenterPoint.x += temp.x;
      n->roadCenterPoint.y += temp.y;
      n->roadCenterPoint.z += temp.z;
    }
    n->roadCenterPoint.x /= 4;
    n->roadCenterPoint.y /= 4;
    n->roadCenterPoint.z /= 4;
  }
  else {
    if (n->simRoadInfo.simQuad) n->roadCenterPoint = n->simRoadInfo.quadPts[0]; else n->roadCenterPoint = *(coorddef *)BWorldSm_slices[slice].center;
  }
  if (hiRez)
  {



    if (*(signed char *)&n->simRoadInfo.quadChanged)
    {
      { int r1; int r2; int r3; int r4; int r5; int r6; int x1; *(coorddef *)&n->roadMatrix.m[3] = *(coorddef *)BWorldSm_UNormal(&n->simRoadInfo);
        *(coorddef *)&n->roadMatrix.m[6] = *(coorddef *)BWorldSm_UForward(&n->simRoadInfo);


        r1 = n->roadMatrix.m[3];
        r2 = n->roadMatrix.m[4];
        r3 = n->roadMatrix.m[5];
        r4 = n->roadMatrix.m[6];
        r5 = n->roadMatrix.m[7];
        r6 = n->roadMatrix.m[8];

        x1 = fixedmult(r2,r6);
        n->roadMatrix.m[0] = fixedmult(r3,r5);
        n->roadMatrix.m[0] = x1 - n->roadMatrix.m[0];

        x1 = fixedmult(r3,r4);
        n->roadMatrix.m[1] = fixedmult(r1,r6);
        n->roadMatrix.m[1] = x1 - n->roadMatrix.m[1];

        x1 = fixedmult(r1,r5);
        n->roadMatrix.m[2] = fixedmult(r2,r4);
        n->roadMatrix.m[2] = x1 - n->roadMatrix.m[2];
      }
    }
  }

  else
  {
    int r1; int r2; int r3;


    r1 = (int)((signed char)BWorldSm_slices[slice].right[0]) << 9;
    r2 = (int)((signed char)BWorldSm_slices[slice].right[1]) << 9;
    r3 = (int)((signed char)BWorldSm_slices[slice].right[2]) << 9;
    n->roadMatrix.m[0] = r1;
    n->roadMatrix.m[1] = r2;
    n->roadMatrix.m[2] = r3;

    r1 = (int)((signed char)BWorldSm_slices[slice].normal[0]) << 9;
    r2 = (int)((signed char)BWorldSm_slices[slice].normal[1]) << 9;
    r3 = (int)((signed char)BWorldSm_slices[slice].normal[2]) << 9;
    n->roadMatrix.m[3] = r1;
    n->roadMatrix.m[4] = r2;
    n->roadMatrix.m[5] = r3;

    r1 = (int)((signed char)BWorldSm_slices[slice].forward[0]) << 9;
    r2 = (int)((signed char)BWorldSm_slices[slice].forward[1]) << 9;
    r3 = (int)((signed char)BWorldSm_slices[slice].forward[2]) << 9;
    n->roadMatrix.m[6] = r1;
    n->roadMatrix.m[7] = r2;
    n->roadMatrix.m[8] = r3;
  }



  {
    int s; int x1; int z1; int x2; int z2; s = slice + 1 >= gNumSlices ? slice + 1 - gNumSlices : slice + 1;
    x1 = BWorldSm_slices[slice].center[0];
    z1 = BWorldSm_slices[slice].center[2];
    x2 = BWorldSm_slices[s].center[0];
    z2 = BWorldSm_slices[s].center[2];



    x1 = x2 - x1; z1 = z2 - z1; n->roadYaw = intatan(x1,z1);
  }
}
#line 445 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_FindGroundElevationGeneral__FP8coorddefN20 [NEWTON.CPP:445; COVERED-SLD-PASS] ---- */
/* 2026-10-29: genuine table/roughness/copy/cross-product/YAW/return phases
 * restore all supplied owners,block and absolute SLD records with unchanged
 * code. No new object,asm,qualifier,fake use or synthetic scope is introduced.
 * Literal macro/comment text remains unproved. Boundary reset preserves only
 * the measured coordinates of unchanged neighbors,not source completeness.
 * Receipt:build/nc12/newton_elevation_source_20261029/final-proof.json. */
#line 443 "C:/nfs4/GAME/COMMON/newton.cpp"
int Newton_FindGroundElevationGeneral(coorddef *point,coorddef *normal,coorddef *pointOnQuad)

{
  int result;

  if (0x9eb8 < normal->y)
  {
    int index; index = (0x10000 - normal->y) >> 9;



    result = fixedmult(-((normal->x / 256) * ((point->x - pointOnQuad->x) / 256)) - (normal->z / 256) * ((point->z - pointOnQuad->z) / 256),divTable[index]) + pointOnQuad->y;
  }
  else {



    result = fixeddiv(-((normal->x / 256) * ((point->x - pointOnQuad->x) / 256)) - (normal->z / 256) * ((point->z - pointOnQuad->z) / 256),normal->y) + pointOnQuad->y;
  }

  return result;
}
#line 469 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_FindGroundElevationRough__FP8coorddefN20 [NEWTON.CPP:475; COVERED-SLD-PASS] ---- */
/* 2026-10-29: genuine table/roughness/copy/cross-product/YAW/return phases
 * restore all supplied owners,block and absolute SLD records with unchanged
 * code. No new object,asm,qualifier,fake use or synthetic scope is introduced.
 * Literal macro/comment text remains unproved. Boundary reset preserves only
 * the measured coordinates of unchanged neighbors,not source completeness.
 * Receipt:build/nc12/newton_elevation_source_20261029/final-proof.json. */
#line 473 "C:/nfs4/GAME/COMMON/newton.cpp"
int Newton_FindGroundElevationRough(coorddef *point,coorddef *normal,coorddef *pointOnQuad)

{
  int result; int fudgeIndex; int fudgeHeight; int fudgeDist; int numerator;


  fudgeHeight = 0;
  numerator = -((normal->x / 256) * ((point->x - pointOnQuad->x) / 256)) - (normal->z / 256) * ((point->z - pointOnQuad->z) / 256);
  { int i;



    i = 0; do {

      if (i == 0) {
        fudgeDist = (__builtin_abs(point->x) > __builtin_abs(point->z >> 1)) ? __builtin_abs(point->x) + (__builtin_abs(point->z >> 1) >> 2) : __builtin_abs(point->z >> 1) + (__builtin_abs(point->x) >> 2);
      } else {
        fudgeDist = (__builtin_abs(point->x >> 2) > __builtin_abs(point->z)) ? __builtin_abs(point->x >> 2) + (__builtin_abs(point->z) >> 2) : __builtin_abs(point->z) + (__builtin_abs(point->x >> 2) >> 2);
      }
      fudgeIndex = fudgeDist >> 15; fudgeDist = __builtin_abs(fudgeIndex);
      fudgeIndex = fudgeDist % 32;
      fudgeHeight += fudgeTable[fudgeIndex] << 7;
      i++; } while (i < 2);
  }
  if (0x9eb8 < normal->y)
  {
    int index = (0x10000 - normal->y) >> 9;
    result = fixedmult(numerator,divTable[index]) + pointOnQuad->y + fudgeHeight;
  }
  else {

    result = fixeddiv(numerator,normal->y) + pointOnQuad->y + fudgeHeight;
  }
  return result;
}
#line 522 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef [NEWTON.CPP:515; COVERED-SLD-PASS] ---- */
/* 2026-10-29: genuine table/roughness/copy/cross-product/YAW/return phases
 * restore all supplied owners,block and absolute SLD records with unchanged
 * code. No new object,asm,qualifier,fake use or synthetic scope is introduced.
 * Literal macro/comment text remains unproved. Boundary reset preserves only
 * the measured coordinates of unchanged neighbors,not source completeness.
 * Fast reader replaces47 raw-offset accesses with existing BO/Car/wheel
 * members. The supplied surfaceType owns the real value1 before the call.
 * Receipt:build/nc12/newton_elevation_source_20261029/final-proof.json. */
#line 513 "C:/nfs4/GAME/COMMON/newton.cpp"
extern "C" int Newton_FindGroundElevationAndNormalFast(BO_tNewtonObj *newtonObj,coorddef *normal)

{
  int elevation;



  {
    int r1; int r2; int r3;
    r1 = newtonObj->roadMatrix.m[3];
    r2 = newtonObj->roadMatrix.m[4];
    r3 = newtonObj->roadMatrix.m[5];
    normal->x = r1;
    normal->y = r2;
    normal->z = r3;
  }

  if (0x199a <= normal->y)
  {
    int surfaceType;





    surfaceType = 1; {
      int r2; int r3; int r4; elevation = Newton_FindGroundElevationGeneral(&newtonObj->position,normal,&newtonObj->roadCenterPoint);





      r2 = newtonObj->position.x;
      r3 = newtonObj->position.z;
      r4 = elevation;
      ((Car_tObj *)newtonObj)->wheel[0].wheelInAir = 0;
      ((Car_tObj *)newtonObj)->wheel[1].wheelInAir = 0;
      ((Car_tObj *)newtonObj)->wheel[2].wheelInAir = 0;
      ((Car_tObj *)newtonObj)->wheel[3].wheelInAir = 0;
      ((Car_tObj *)newtonObj)->wheel[0].rebound = 0;
      ((Car_tObj *)newtonObj)->wheel[1].rebound = 0;
      ((Car_tObj *)newtonObj)->wheel[2].rebound = 0;
      ((Car_tObj *)newtonObj)->wheel[3].rebound = 0;
      ((Car_tObj *)newtonObj)->wheel[0].currentPos.x = r2;
      ((Car_tObj *)newtonObj)->wheel[1].currentPos.x = r2;
      ((Car_tObj *)newtonObj)->wheel[2].currentPos.x = r2;
      ((Car_tObj *)newtonObj)->wheel[3].currentPos.x = r2;
      ((Car_tObj *)newtonObj)->wheel[0].currentPos.z = r3;
      ((Car_tObj *)newtonObj)->wheel[1].currentPos.z = r3;
      ((Car_tObj *)newtonObj)->wheel[2].currentPos.z = r3;
      ((Car_tObj *)newtonObj)->wheel[3].currentPos.z = r3;
      ((Car_tObj *)newtonObj)->wheel[0].currentPos.y = r4;
      ((Car_tObj *)newtonObj)->wheel[1].currentPos.y = r4;
      ((Car_tObj *)newtonObj)->wheel[2].currentPos.y = r4;
      ((Car_tObj *)newtonObj)->wheel[3].currentPos.y = r4;
      ((Car_tObj *)newtonObj)->wheel[0].actualHeight = r4;
      ((Car_tObj *)newtonObj)->wheel[1].actualHeight = r4;
      ((Car_tObj *)newtonObj)->wheel[2].actualHeight = r4;
      ((Car_tObj *)newtonObj)->wheel[3].actualHeight = r4;

      r2 = normal->x;
      r3 = normal->y;
      r4 = normal->z;
      ((Car_tObj *)newtonObj)->wheel[0].roadSurfaceType = surfaceType;
      ((Car_tObj *)newtonObj)->wheel[1].roadSurfaceType = surfaceType;
      ((Car_tObj *)newtonObj)->wheel[2].roadSurfaceType = surfaceType;
      ((Car_tObj *)newtonObj)->wheel[3].roadSurfaceType = surfaceType;
      ((Car_tObj *)newtonObj)->wheel[0].roadNormal.x = r2;
      ((Car_tObj *)newtonObj)->wheel[1].roadNormal.x = r2;
      ((Car_tObj *)newtonObj)->wheel[2].roadNormal.x = r2;
      ((Car_tObj *)newtonObj)->wheel[3].roadNormal.x = r2;
      ((Car_tObj *)newtonObj)->wheel[0].roadNormal.y = r3;
      ((Car_tObj *)newtonObj)->wheel[1].roadNormal.y = r3;
      ((Car_tObj *)newtonObj)->wheel[2].roadNormal.y = r3;
      ((Car_tObj *)newtonObj)->wheel[3].roadNormal.y = r3;
      ((Car_tObj *)newtonObj)->wheel[0].roadNormal.z = r4;
      ((Car_tObj *)newtonObj)->wheel[1].roadNormal.z = r4;
      ((Car_tObj *)newtonObj)->wheel[2].roadNormal.z = r4;
      ((Car_tObj *)newtonObj)->wheel[3].roadNormal.z = r4;

    }
  }
  else
  { elevation = -0x7d000000; }


  return elevation;
}
#line 607 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef [NEWTON.CPP:610-1057; COVERED-SYM-SLD-PASS] ---- */
/* 2026-10-29: real vector/ground/suspension/normal/angular phases preserve
 * all905 words,69 supplied owners,82 block records and end1057. The first
 * wheel loop is ordinary i<4;no integer comparison of synthetic BO pointers.
 * Provided r1/r2/r3 own the position reads before the offset stores;no new
 * asm,volatile,qualifier,identity or fake use is introduced.
 * The actual half-height delta on930 precedes projection931. Its plain result
 * is naturally debug-elided,not const-disguised;all905 source tags now match.
 * halfWheelHeightDelta is a precise behavior-derived name,NOT a recovered SYM
 * identifier. Literal original name/object/macro spelling is not unique.
 * An unshifted delta adds a non-retail REG record;reusing desiredCompression
 * for that input changes its home/code. Neither control is adopted.
 * Receipt:build/nc12/newton_projection_notes_20261029/final-proof.json. */
#line 608 "C:/nfs4/GAME/COMMON/newton.cpp"
int Newton_FindGroundElevationAndNormal(BO_tNewtonObj *newtonObj,coorddef *normal)

{
  coorddef elevation; coorddef tireCoord[4]; coorddef carNormal; int wheelsInAir; int bounce;


  wheelsInAir = 0;
  bounce = 0;




  {

    int r2 = ((coorddef *)&newtonObj->orientMat.m[3])->x;
    int r3 = ((coorddef *)&newtonObj->orientMat.m[3])->y;
    int r4 = ((coorddef *)&newtonObj->orientMat.m[3])->z;


    carNormal.x = r2;
    carNormal.y = r3;
    carNormal.z = r4; }
  elevation.x = 0;
  elevation.y = 0;
  elevation.z = 0;





  { coorddef lengthVector; coorddef widthVector; coorddef carGroundCoord; coorddef vecOffset;




    {
      int v1 = newtonObj->dimension.z * 0xd >> 0xc;
      int r1 = newtonObj->orientMat.m[6] >> 8;
      int r2 = newtonObj->orientMat.m[7] >> 8;
      int r3 = newtonObj->orientMat.m[8] >> 8;

      lengthVector.x = v1 * r1;
      lengthVector.y = v1 * r2;
      lengthVector.z = v1 * r3; }


    {
      int v1 = newtonObj->dimension.x * 7 >> 0xb;
      int r1 = newtonObj->orientMat.m[0] >> 8;
      int r2 = newtonObj->orientMat.m[1] >> 8;
      int r3 = newtonObj->orientMat.m[2] >> 8;

      widthVector.x = v1 * r1;
      widthVector.y = v1 * r2;
      widthVector.z = v1 * r3; }


    {
      int v1 = -newtonObj->dimension.y >> 8;
      int r1 = newtonObj->orientMat.m[3] >> 8;
      int r2 = newtonObj->orientMat.m[4] >> 8;
      int r3 = newtonObj->orientMat.m[5] >> 8;


      vecOffset.x = v1 * r1;
      vecOffset.y = v1 * r2;
      vecOffset.z = v1 * r3; }



    {
      int r1 = newtonObj->position.x;
      int r2 = newtonObj->position.y;
      int r3 = newtonObj->position.z;




      carGroundCoord.x = r1 + vecOffset.x;
      carGroundCoord.y = r2 + vecOffset.y;
      carGroundCoord.z = r3 + vecOffset.z; }





    {
      int r1 = carGroundCoord.x + lengthVector.x;
      int r2 = carGroundCoord.y + lengthVector.y;
      int r3 = carGroundCoord.z + lengthVector.z;




      tireCoord[0].x = r1 - widthVector.x;
      tireCoord[0].y = r2 - widthVector.y;
      tireCoord[0].z = r3 - widthVector.z;

      tireCoord[1].x = r1 + widthVector.x;
      tireCoord[1].y = r2 + widthVector.y;
      tireCoord[1].z = r3 + widthVector.z; }





    {
      int r1 = carGroundCoord.x - lengthVector.x;
      int r2 = carGroundCoord.y - lengthVector.y;
      int r3 = carGroundCoord.z - lengthVector.z;




      tireCoord[2].x = r1 - widthVector.x;
      tireCoord[2].y = r2 - widthVector.y;
      tireCoord[2].z = r3 - widthVector.z;

      tireCoord[3].x = r1 + widthVector.x;
      tireCoord[3].y = r2 + widthVector.y;
      tireCoord[3].z = r3 + widthVector.z; }
  }



  { BWorldSm_Pos testSimRoadInfo; coorddef wheelHeight[4];


    testSimRoadInfo = newtonObj->simRoadInfo;






    for (int i = 0; i < 4; i = i + 1) {
      coorddef roadNormal; coorddef roadCenterPoint; int roadSurfaceType;







      wheelHeight[i] = tireCoord[i];
      ((Car_tObj *)newtonObj)->wheel[i].actualHeight = tireCoord[i].y;



      BWorldSm_FindClosestTriangleRez(&tireCoord[i],&testSimRoadInfo,1);


      roadNormal = *(coorddef *)BWorldSm_UNormal(&testSimRoadInfo);


      roadSurfaceType = 0xe; if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0) roadSurfaceType = (u_int)testSimRoadInfo.simQuad->surface; ((Car_tObj *)newtonObj)->wheel[i].roadSurfaceType = roadSurfaceType;




      roadSurfaceType = roadSurfaceType & 0xf;
      if ((roadNormal.y < 0x1999) || (roadSurfaceType == 0xe) || (roadSurfaceType == 0)) {

        roadNormal.x = 0;
        roadNormal.y = 0x10000;
        roadNormal.z = 0;
        elevation.x += tireCoord[i].x;
        elevation.y += tireCoord[i].y - newtonObj->objAltitude;
        elevation.z += tireCoord[i].z;
      } else


      {

        if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0) roadCenterPoint = testSimRoadInfo.quadPts[0]; else roadCenterPoint = *(coorddef *)BWorldSm_slices[testSimRoadInfo.slice].center;


        if ((u_int)(roadSurfaceType - 2) < 2)
          wheelHeight[i].y = Newton_FindGroundElevationRough(&tireCoord[i],&roadNormal,&roadCenterPoint);
        else
          wheelHeight[i].y = Newton_FindGroundElevationGeneral(&tireCoord[i],&roadNormal,&roadCenterPoint);

        ((Car_tObj *)newtonObj)->wheel[i].actualHeight = wheelHeight[i].y;


        if (0x20000 < wheelHeight[i].y - tireCoord[i].y) {

          roadNormal.x = 0;
          roadNormal.y = 0x10000;
          roadNormal.z = 0;
          wheelHeight[i].y = tireCoord[i].y;
          elevation.x += tireCoord[i].x;
          elevation.y += tireCoord[i].y;
          elevation.z += tireCoord[i].z;
        } else

        {
          int r1 = wheelHeight[i].x;
          int r2 = wheelHeight[i].y;
          int r3 = wheelHeight[i].z;
          elevation.x += r1;
          elevation.y += r2;
          elevation.z += r3;
        }
      }


      {
        int r1 = wheelHeight[i].x;
        int r2 = wheelHeight[i].y;
        int r3 = wheelHeight[i].z;
        ((Car_tObj *)newtonObj)->wheel[i].currentPos.x = r1;
        ((Car_tObj *)newtonObj)->wheel[i].currentPos.y = r2;
        ((Car_tObj *)newtonObj)->wheel[i].currentPos.z = r3; }



      {
        int r1 = roadNormal.x;
        int r2 = roadNormal.y;
        int r3 = roadNormal.z;
        ((Car_tObj *)newtonObj)->wheel[i].roadNormal.x = r1;
        ((Car_tObj *)newtonObj)->wheel[i].roadNormal.y = r2;
        ((Car_tObj *)newtonObj)->wheel[i].roadNormal.z = r3; }

    }


    { coorddef wheelVec; int compressionValue[4]; int count;


      wheelVec.x = 0;
      wheelVec.z = 0;
      count = 0;

      for (int i = 0; i < 4; i = i + 1) {

        wheelVec.y = (((Car_tObj *)newtonObj)->wheel[i].currentPos.y - tireCoord[i].y) / 2;
        ((Car_tObj *)newtonObj)->wheel[i].rebound = 0;

        if (wheelVec.y < -0x2665) {


          ((Car_tObj *)newtonObj)->wheel[i].wheelInAir = 1;
          wheelsInAir += 1;
        }
        else if (((Car_tObj *)newtonObj)->wheel[i].wheelInAir == 1) {


          if (wheelVec.y > 0) {

            ((Car_tObj *)newtonObj)->wheel[i].wheelInAir = 0;

            bounce += 1; ((Car_tObj *)newtonObj)->wheel[i].rebound = 1;
          }




          else if ((newtonObj->objAltitude < 0x3333) && (-0x1999 < newtonObj->linearVel.y) && (0xf333 < newtonObj->orientationToGround.y)) {

            ((Car_tObj *)newtonObj)->wheel[i].wheelInAir = 0;
          }
        }


        { int limit;
          limit = -0x3333;
          if (0x358000 < newtonObj->speedXZ)
            limit = -0x2666;
          if (wheelVec.y < limit)
            wheelVec.y = limit;
        }


        compressionValue[i] = (wheelVec.y / 0x100) * (carNormal.y / 0x100);
        ((Car_tObj *)newtonObj)->wheel[i].wheelAcc = (compressionValue[i] / 0x100) * (((Car_tObj *)newtonObj)->specs->suspensionStiffness / 0x100);


        if (((Car_tObj *)newtonObj)->carInfo->WeightTransfer == 1)
          ((Car_tObj *)newtonObj)->wheel[i].wheelAcc *= 2;
      }


      if (bounce != 0)
      {
        int r1 = ((Car_tObj *)newtonObj)->wheel[0].rebound;
        int r2 = ((Car_tObj *)newtonObj)->wheel[1].rebound;
        int r3 = ((Car_tObj *)newtonObj)->wheel[2].rebound;
        int r4 = ((Car_tObj *)newtonObj)->wheel[3].rebound;
        count = r1 + r2 + r3 + r4;
      }


      for (int i = 0; i < 4; i = i + 1) {

        int wheelBounce;

        { if (bounce == 0) { if ((((Car_tObj *)newtonObj)->wheel[i].wheelAcc < 0) && (0xdc28 < newtonObj->orientationToGround.y)) { ((Car_tObj *)newtonObj)->wheel[i].wheelAcc >>= 1; continue; } }


          { if ((bounce != 0) && (((Car_tObj *)newtonObj)->wheel[i].rebound != 0) && (newtonObj->linearVel.y < 0))
          { int speed;
            speed = __builtin_abs(newtonObj->linearVel.y) + newtonObj->groundVel;
            if (-1 < speed)


            {
              wheelBounce = speed / count >> 1;
              if (speed < 0x100000)
              { int ratio;
                ratio = fixedmult(speed,0x1000); if (ratio >= 0x4ccd) ratio = fixedmult(speed,0x1000); else ratio = 0x4ccc;
                wheelBounce = fixedmult(ratio,wheelBounce);
              }
              ((Car_tObj *)newtonObj)->wheel[i].wheelAcc += wheelBounce;
            }
          } } }
      }


      for (int i = 0; i < 4; i = i + 1) {
        int desiredCompression;
        int halfWheelHeightDelta = (tireCoord[i].y - wheelHeight[i].y) >> 1;
        desiredCompression = fixedmult(halfWheelHeightDelta,newtonObj->orientMat.m[4]);

        if (desiredCompression > 0)
          desiredCompression = ((Car_tObj *)newtonObj)->specs->tireRange > desiredCompression ? desiredCompression : ((Car_tObj *)newtonObj)->specs->tireRange;

        else { if (desiredCompression < -((Car_tObj *)newtonObj)->specs->tireRange) desiredCompression = -((Car_tObj *)newtonObj)->specs->tireRange; }


        ((Car_tObj *)newtonObj)->wheel[swap[i]].impactCompression = desiredCompression;
      }
    }



    { coorddef tempVecX; coorddef tempVecY; coorddef tempVecZ; elevation.x >>= 2;
      elevation.y >>= 2;
      elevation.z >>= 2;








      tempVecZ.x = (wheelHeight[0].x + wheelHeight[1].x - (wheelHeight[2].x + wheelHeight[3].x)) >> 1;
      tempVecZ.y = (wheelHeight[0].y + wheelHeight[1].y - (wheelHeight[2].y + wheelHeight[3].y)) >> 1;
      tempVecZ.z = (wheelHeight[0].z + wheelHeight[1].z - (wheelHeight[2].z + wheelHeight[3].z)) >> 1;
      Math_NormalizeShortVector(&tempVecZ);


      tempVecX.x = (wheelHeight[1].x + wheelHeight[3].x - (wheelHeight[0].x + wheelHeight[2].x)) >> 1;
      tempVecX.y = (wheelHeight[1].y + wheelHeight[3].y - (wheelHeight[0].y + wheelHeight[2].y)) >> 1;
      tempVecX.z = (wheelHeight[1].z + wheelHeight[3].z - (wheelHeight[0].z + wheelHeight[2].z)) >> 1;
      Math_NormalizeShortVector(&tempVecX);


      tempVecY.x = fixedmult(tempVecZ.y,tempVecX.z) - fixedmult(tempVecZ.z,tempVecX.y); tempVecY.y = fixedmult(tempVecZ.z,tempVecX.x) - fixedmult(tempVecZ.x,tempVecX.z); tempVecY.z = fixedmult(tempVecZ.x,tempVecX.y) - fixedmult(tempVecZ.y,tempVecX.x);
      Math_NormalizeShortVector(&tempVecY);

      if (tempVecY.y >= 0) {

        normal->x = tempVecY.x;
        normal->y = tempVecY.y;
        normal->z = tempVecY.z;

        if (tempVecY.y <= 0x7fff)
          wheelsInAir = 4;
      } else {





        normal->x = 0;
        normal->y = 0x10000;
        normal->z = 0;
        wheelsInAir = 4;
      }




      if (newtonObj->orientationToGround.y < -0xe666) {
        newtonObj->angularVel.x = newtonObj->angularVel.x * 0xfd / 0x100; newtonObj->angularVel.y = newtonObj->angularVel.y * 0xfd / 0x100; newtonObj->angularVel.z = newtonObj->angularVel.z * 0xfd / 0x100;
      }
      else if (wheelsInAir < 4)
      { matrixtdef transposeMat; int pitch; int roll;





        ((Car_tObj *)newtonObj)->angularVel_ch.x = fixedmult(newtonObj->angularVel.x,newtonObj->orientMat.m[0]) + fixedmult(newtonObj->angularVel.y,newtonObj->orientMat.m[1]) + fixedmult(newtonObj->angularVel.z,newtonObj->orientMat.m[2]);
        ((Car_tObj *)newtonObj)->angularVel_ch.y = fixedmult(newtonObj->angularVel.x,newtonObj->orientMat.m[3]) + fixedmult(newtonObj->angularVel.y,newtonObj->orientMat.m[4]) + fixedmult(newtonObj->angularVel.z,newtonObj->orientMat.m[5]);
        ((Car_tObj *)newtonObj)->angularVel_ch.z = fixedmult(newtonObj->angularVel.x,newtonObj->orientMat.m[6]) + fixedmult(newtonObj->angularVel.y,newtonObj->orientMat.m[7]) + fixedmult(newtonObj->angularVel.z,newtonObj->orientMat.m[8]);



        pitch = (((Car_tObj *)newtonObj)->wheel[2].wheelAcc + ((Car_tObj *)newtonObj)->wheel[3].wheelAcc - (((Car_tObj *)newtonObj)->wheel[0].wheelAcc + ((Car_tObj *)newtonObj)->wheel[1].wheelAcc)) >> 2;
        if (pitch > 0)
          pitch = pitch > ((Car_tObj *)newtonObj)->specs->pitchAngularVelCap ? ((Car_tObj *)newtonObj)->specs->pitchAngularVelCap : pitch;

        else pitch = pitch > -((Car_tObj *)newtonObj)->specs->pitchAngularVelCap ? pitch : -((Car_tObj *)newtonObj)->specs->pitchAngularVelCap;



        roll = (((Car_tObj *)newtonObj)->wheel[0].wheelAcc + ((Car_tObj *)newtonObj)->wheel[2].wheelAcc - (((Car_tObj *)newtonObj)->wheel[1].wheelAcc + ((Car_tObj *)newtonObj)->wheel[3].wheelAcc)) >> 2;
        if (roll > 0)
          roll = roll > ((Car_tObj *)newtonObj)->specs->rollAngularVelCap ? ((Car_tObj *)newtonObj)->specs->rollAngularVelCap : roll;

        else roll = roll > -((Car_tObj *)newtonObj)->specs->rollAngularVelCap ? roll : -((Car_tObj *)newtonObj)->specs->rollAngularVelCap;


        if (__builtin_abs(((Car_tObj *)newtonObj)->angularVel_ch.x) < 0x13333)
          ((Car_tObj *)newtonObj)->angularVel_ch.x = fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.x,((Car_tObj *)newtonObj)->specs->dampingPitchRate);

        else ((Car_tObj *)newtonObj)->angularVel_ch.x = fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.x,0xd999);
        ((Car_tObj *)newtonObj)->angularVel_ch.x += pitch;


        if (__builtin_abs(((Car_tObj *)newtonObj)->angularVel_ch.z) < 0x13333)
          ((Car_tObj *)newtonObj)->angularVel_ch.z = fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.z,((Car_tObj *)newtonObj)->specs->dampingRollRate);

        else ((Car_tObj *)newtonObj)->angularVel_ch.z = fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.z,0xd999);
        ((Car_tObj *)newtonObj)->angularVel_ch.z -= roll;


        transpose(&newtonObj->orientMat,&transposeMat);
        newtonObj->angularVel.x = fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.x,transposeMat.m[0]) + fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.y,transposeMat.m[1]) + fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.z,transposeMat.m[2]);
        newtonObj->angularVel.y = fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.x,transposeMat.m[3]) + fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.y,transposeMat.m[4]) + fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.z,transposeMat.m[5]);
        newtonObj->angularVel.z = fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.x,transposeMat.m[6]) + fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.y,transposeMat.m[7]) + fixedmult(((Car_tObj *)newtonObj)->angularVel_ch.z,transposeMat.m[8]);
      }
    }





    if (simGlobal.gameTicks < 0x40)
      newtonObj->objAltitude = Newton_CalcPerpenHeightOfCenterPointFromGround(newtonObj,normal,&newtonObj->roadCenterPoint);

    else newtonObj->objAltitude = Newton_CalcPerpenHeightOfCenterPointFromGround(newtonObj,normal,&elevation);
  }


  return elevation.y; }
#line 1064 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_LimitCarsToDrivableDist__FP13BO_tNewtonObj [retail NEWTON.CPP:1062; COVERED-SLD-PASS] ---- */
/* 2026-10-29: supplied variables and genuine call/mutation/exit phases match
 * every word/file tag,header,frame,owner,block and end. No new source object,
 * qualifier,asm,fake use or scope is introduced. Literal macro/comment text
 * remains unproved. The following boundary-only reset preserves unmodified
 * neighbors' coordinates;it is not a claim that their old layout is retail.
 * Receipt:build/nc12/newton_small_source_20261029/final-proof.json. */
#line 1060 "C:/nfs4/GAME/COMMON/newton.cpp"
void Newton_LimitCarsToDrivableDist(BO_tNewtonObj *newtonObj)

{
  if (Physics_DoBarrierCheck((Car_tObj *)newtonObj) != 0) {

    (newtonObj->collision).impulse = 0;
    (newtonObj->collision).otherObj = (BO_tNewtonObj *)0x0;
    Newton_FindClosestQuad(newtonObj);
    Newton_UpdateRoadGeometry(newtonObj); }
}
#line 1077 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_CalcPerpenHeightOfLowestPointFromGround__FP13BO_tNewtonObjP8coorddefT1 [NEWTON.CPP:1079; COVERED-SLD-PASS] ---- */
/* 2026-10-29: real matrix/sign/vector/return phases preserve every code word
 * and restore full supplied owner,block and absolute SLD contracts. No new
 * object,asm,qualifier,fake use or scope is introduced. Literal macro/comment
 * text remains unproved. Boundary reset preserves unchanged neighbors only.
 * Receipt:build/nc12/newton_matrix_height_20261029/final-proof.json. */
#line 1077 "C:/nfs4/GAME/COMMON/newton.cpp"
int Newton_CalcPerpenHeightOfLowestPointFromGround(BO_tNewtonObj *newtonObj,coorddef *normal,coorddef *samplePoint)

{
  coorddef basisDots;
  int xDir;
  int yDir;
  int zDir;
  coorddef relativePos;
  int relativeDot;
  basisDots.x = ((normal->x / 0x100) * (newtonObj->orientMat.m[0] / 0x100) + (normal->y / 0x100) * (newtonObj->orientMat.m[1] / 0x100) + (normal->z / 0x100) * (newtonObj->orientMat.m[2] / 0x100)) / 0x100 * (newtonObj->dimension.x / 0x100);

  basisDots.y = ((normal->x / 0x100) * (newtonObj->orientMat.m[3] / 0x100) + (normal->y / 0x100) * (newtonObj->orientMat.m[4] / 0x100) + (normal->z / 0x100) * (newtonObj->orientMat.m[5] / 0x100)) / 0x100 * (newtonObj->dimension.y / 0x100);

  basisDots.z = ((normal->x / 0x100) * (newtonObj->orientMat.m[6] / 0x100) + (normal->y / 0x100) * (newtonObj->orientMat.m[7] / 0x100) + (normal->z / 0x100) * (newtonObj->orientMat.m[8] / 0x100)) / 0x100 * (newtonObj->dimension.z / 0x100);

  if (basisDots.x < 0) xDir = 1;
  else xDir = -1;
  yDir = -1; if (basisDots.y < 0) yDir = 1;

  zDir = -1; if (basisDots.z < 0) zDir = 1;


  relativePos.x = newtonObj->position.x - samplePoint->x; relativePos.y = newtonObj->position.y - samplePoint->y; relativePos.z = newtonObj->position.z - samplePoint->z;
  relativeDot = (normal->x / 0x100) * (relativePos.x / 0x100) + (normal->y / 0x100) * (relativePos.y / 0x100) + (normal->z / 0x100) * (relativePos.z / 0x100);

  return xDir * basisDots.x + yDir * basisDots.y + zDir * basisDots.z + relativeDot;
}
#line 1126 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_CalcPerpenHeightOfCenterPointFromGround__FP13BO_tNewtonObjP8coorddefT1 [NEWTON.CPP:1110; COVERED-SLD-PASS] ---- */
/* 2026-10-29: real matrix/sign/vector/return phases preserve every code word
 * and restore full supplied owner,block and absolute SLD contracts. No new
 * object,asm,qualifier,fake use or scope is introduced. Literal macro/comment
 * text remains unproved. Boundary reset preserves unchanged neighbors only.
 * Receipt:build/nc12/newton_matrix_height_20261029/final-proof.json. */
#line 1108 "C:/nfs4/GAME/COMMON/newton.cpp"
int Newton_CalcPerpenHeightOfCenterPointFromGround(BO_tNewtonObj *newtonObj,coorddef *normal,coorddef *samplePoint)

{
  coorddef relativePos;
  int relativeDot;
  relativePos.x = (newtonObj->position).x - samplePoint->x; relativePos.y = (newtonObj->position).y - samplePoint->y; relativePos.z = (newtonObj->position).z - samplePoint->z;
  relativeDot = fixedmult(normal->x,relativePos.x) + fixedmult(normal->y,relativePos.y) + fixedmult(normal->z,relativePos.z);
  if (0xb334 <= __builtin_abs((newtonObj->orientationToGround).y)) {
    return relativeDot - (newtonObj->dimension).y;
  }
  return relativeDot - (newtonObj->dimension).x;
}
#line 1144 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj [NEWTON.CPP:1123; COVERED-SLD-PASS] ---- */
/* 2026-10-29: real damage/impulse or player-distance/upgrade source phases.
 * All200 word/file tags,provided owners,blocks and end1215 match retail.
 * Genuine last-work scope closure preserves the shared1210 epilogue tag.
 * Retail Car fields replace bogus BO[3] projections:forceNoSimOptz1884
 * and collision.smoking1932. No new object,asm,qualifier or fake use.
 * Literal original text remains unproved;boundary reset preserves only
 * measured unchanged-neighbor coordinates,not their source completeness.
 * Receipt:build/nc12/newton_damage_distance_20261029/final-proof.json. */
#line 1121 "C:/nfs4/GAME/COMMON/newton.cpp"
void Newton_CalcDistToClosestPlayerCar(BO_tNewtonObj *n)

{
  int dist; int x; int z; int whichPlayer; int forcedSimOptz;
  whichPlayer = 0;
  forcedSimOptz = 0;

  x = n->position.x - Cars_gHumanRaceCarList[GameSetup_gData.localCar]->N.position.x; if (x < 1) x = Cars_gHumanRaceCarList[GameSetup_gData.localCar]->N.position.x - n->position.x;
  z = n->position.z - Cars_gHumanRaceCarList[GameSetup_gData.localCar]->N.position.z; if (z < 1) z = Cars_gHumanRaceCarList[GameSetup_gData.localCar]->N.position.z - n->position.z;
  if (z < x) n->distToPlayer = x + (z >> 2); else n->distToPlayer = z + (x >> 2);

  if (Cars_gNumHumanRaceCars == 2) {

  x = n->position.x - Cars_gHumanRaceCarList[1 - GameSetup_gData.localCar]->N.position.x; if (x < 1) x = Cars_gHumanRaceCarList[1 - GameSetup_gData.localCar]->N.position.x - n->position.x;
  z = n->position.z - Cars_gHumanRaceCarList[1 - GameSetup_gData.localCar]->N.position.z; if (z < 1) z = Cars_gHumanRaceCarList[1 - GameSetup_gData.localCar]->N.position.z - n->position.z;
    if (z < x) dist = x + (z >> 2); else dist = z + (x >> 2);
    if (dist < n->distToPlayer) {

      whichPlayer = 1;
      n->distToPlayer = dist;
    } }






  if (n->distToPlayer < 0x600001) {

    if (BWorld_CheckChunkVisible(&(Cars_gHumanRaceCarList[whichPlayer]->N).simRoadInfo,&n->simRoadInfo) == 0)
      forcedSimOptz = 1;
  }



  if (((0x600000 < n->distToPlayer) || (forcedSimOptz != 0)) && ((((Car_tObj *)n)->forceNoSimOptz == 0) || (simGlobal.gameTicks < 3))) {


    if (n->simOptz != '\x02') {




      n->groundSurfaceType = 1; n->driveSurfaceType = 1; }

    n->simOptz = '\x02';
    n->angularVel.x = 0;
    n->angularVel.z = 0; return;
  }

  else
  {
    int oldOptz; oldOptz = n->simOptz;

    if (((((Car_tObj *)n)->carFlags & 0x30U) == 0) && ((((Car_tObj *)n)->forceNoSimOptz == 0) || (simGlobal.gameTicks < 3))) {





      if (0x480000 < n->distToPlayer)
        n->simOptz = '\x01';
      else
        n->simOptz = '\0'; } else n->simOptz = '\0';





    if (1 < oldOptz)
    {


      static coorddef dummy __attribute__((section(".bss.newton_dummy_124")));


      Cars_SetCarUpForHiRezSim((Car_tObj *)n);
      Newton_FindClosestQuad(n);
      Newton_UpdateRoadGeometry(n);
      Newton_LimitCarsToDrivableDist(n);
      if (stackSpeedUpEnbabledFlag != 0) {

        gWSavePtr = SetSp(gWSavePtr); stackSpeedUpEnbabledFlag = 0;

        n->groundElevation = Newton_FindGroundElevationAndNormal(n,&dummy);
        gWSavePtr = SetSp(gWSavePtr); stackSpeedUpEnbabledFlag = 1;
      } else
      { n->groundElevation = Newton_FindGroundElevationAndNormal(n,&dummy); }
      n->groundSurfaceType = 1; n->driveSurfaceType = 1;
      n->position.y = n->groundElevation + n->dimension.y;
      n->groundVel = 0;

      n->collision.impulse = 0;
      n->collision.otherObj = (BO_tNewtonObj *)0x0;
      n->objAltitude = 0; } } }

#line 1245 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_UpdateRoadInfo__FP13BO_tNewtonObj [retail NEWTON.CPP:1227; COVERED-SLD-PASS] ---- */
/* 2026-10-29: supplied variables and genuine call/mutation/exit phases match
 * every word/file tag,header,frame,owner,block and end. No new source object,
 * qualifier,asm,fake use or scope is introduced. Literal macro/comment text
 * remains unproved. The following boundary-only reset preserves unmodified
 * neighbors' coordinates;it is not a claim that their old layout is retail.
 * Receipt:build/nc12/newton_small_source_20261029/final-proof.json. */
#line 1225 "C:/nfs4/GAME/COMMON/newton.cpp"
void Newton_UpdateRoadInfo(BO_tNewtonObj *n)

{
  if (n->active != '\0') {






    Newton_CalcDistToClosestPlayerCar(n);
    Newton_FindClosestQuad(n);

    if (*(signed char *)&(n->simRoadInfo).quadChanged != '\0') {
      Newton_UpdateRoadGeometry(n);
    }



    if (n->simOptz == '\0') {

      n->groundSurfaceType = n->simRoadInfo.simQuad == (Trk_NewSimQuad *)0 ? 0xe : n->simRoadInfo.simQuad->surface;
      n->driveSurfaceType = n->groundSurfaceType & 0xf; } return; }













}
#line 1264 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji [NEWTON.CPP:1264; COVERED-SLD-PASS] ---- */
/* 2026-10-29: real matrix/sign/vector/return phases preserve every code word
 * and restore full supplied owner,block and absolute SLD contracts. No new
 * object,asm,qualifier,fake use or scope is introduced. Literal macro/comment
 * text remains unproved. Boundary reset preserves unchanged neighbors only.
 * Receipt:build/nc12/newton_matrix_height_20261029/final-proof.json. */
#line 1262 "C:/nfs4/GAME/COMMON/newton.cpp"
void Newton_CopyRoadMatrixToOrientMat(BO_tNewtonObj *n,int backwards)

{
  if (backwards == 0) {
    n->orientMat = n->roadMatrix;
  }
  else {
    matrixtdef *ori; matrixtdef *road;
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
  } }
#line 1290 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji [NEWTON.CPP:1285; COVERED-SLD-PASS] ---- */
/* 2026-10-29: real matrix/sign/vector/return phases preserve every code word
 * and restore full supplied owner,block and absolute SLD contracts. No new
 * object,asm,qualifier,fake use or scope is introduced. Literal macro/comment
 * text remains unproved. Boundary reset preserves unchanged neighbors only.
 * Receipt:build/nc12/newton_matrix_height_20261029/final-proof.json. */
#line 1283 "C:/nfs4/GAME/COMMON/newton.cpp"
void Newton_CopyRoadMatrixToShadowMat(BO_tNewtonObj *n,int backwards)

{
  if (backwards == 0) {
    n->shadowMat = n->roadMatrix;
  }
  else {
    matrixtdef *shad; matrixtdef *road;
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
  } }
#line 1316 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi [NEWTON.CPP:1307; COVERED-SLD-PASS] ---- */
/* 2026-10-29: actual initialization/guard/transform/copy/reset/exit phases
 * restore all supplied owners,blocks and absolute SLD with unchanged code.
 * No new object,asm,qualifier,fake use or synthetic scope is introduced.
 * Literal macro/comment text remains unproved;boundary reset preserves only
 * measured unchanged-neighbor coordinates,not their source completeness.
 * Keep source dummy and its pre-existing BSS placement;the generated
 * suffix is not a new source identifier. Unused parameters are retained.
 * Receipt:build/nc12/newton_initial_shadow_20261029/final-proof.json. */
#line 1305 "C:/nfs4/GAME/COMMON/newton.cpp"
void Newton_SetInitialSlicePositionOrientationEtc(BO_tNewtonObj *n,int slice,coorddef *offset,int direction)

{
  coorddef rOffset;
  matrixtdef transposeMat;
  int backwards;

  backwards = direction != 1;





  BWorldSm_SetSlice(slice,&n->simRoadInfo);
  n->totalSlice = (u_short)slice;


  n->roadMatrix.m[0] = ((signed char)BWorldSm_slices[slice].right[0]) << 9;
  n->roadMatrix.m[1] = ((signed char)BWorldSm_slices[slice].right[1]) << 9;
  n->roadMatrix.m[2] = ((signed char)BWorldSm_slices[slice].right[2]) << 9;

  n->roadMatrix.m[3] = ((signed char)BWorldSm_slices[slice].normal[0]) << 9;
  n->roadMatrix.m[4] = ((signed char)BWorldSm_slices[slice].normal[1]) << 9;
  n->roadMatrix.m[5] = ((signed char)BWorldSm_slices[slice].normal[2]) << 9;

  n->roadMatrix.m[6] = ((signed char)BWorldSm_slices[slice].forward[0]) << 9;
  n->roadMatrix.m[7] = ((signed char)BWorldSm_slices[slice].forward[1]) << 9;
  n->roadMatrix.m[8] = ((signed char)BWorldSm_slices[slice].forward[2]) << 9;

  Math_NormalizeShortVector((coorddef *)&n->roadMatrix);
  Math_NormalizeShortVector((coorddef *)(n->roadMatrix.m + 3));
  Math_NormalizeShortVector((coorddef *)(n->roadMatrix.m + 6));
  transpose(&n->roadMatrix,&transposeMat);

  Newton_CopyRoadMatrixToOrientMat(n,backwards);
  Newton_CopyRoadMatrixToShadowMat(n,backwards);

  rOffset.x = fixedmult(offset->x,transposeMat.m[0]) + fixedmult(offset->y,transposeMat.m[1]) + fixedmult(offset->z,transposeMat.m[2]);
  rOffset.y = fixedmult(offset->x,transposeMat.m[3]) + fixedmult(offset->y,transposeMat.m[4]) + fixedmult(offset->z,transposeMat.m[5]);
  rOffset.z = fixedmult(offset->x,transposeMat.m[6]) + fixedmult(offset->y,transposeMat.m[7]) + fixedmult(offset->z,transposeMat.m[8]);


  n->position.x = rOffset.x + BWorldSm_slices[slice].center[0];
  n->position.y = rOffset.y + BWorldSm_slices[slice].center[1];
  n->position.z = rOffset.z + BWorldSm_slices[slice].center[2];


  if (((Car_tObj *)n)->carFlags & 4) {
    n->simOptz = 0;
  } else
  { n->simOptz = 2; }

  Newton_FindClosestQuad(n);
  Newton_UpdateRoadInfo(n);
  Newton_UpdateRoadGeometry(n);

  Newton_CopyRoadMatrixToOrientMat(n,backwards);
  Newton_CopyRoadMatrixToShadowMat(n,backwards);


  if (n->simOptz == 2) {


    n->groundElevation = BWorldSm_slices[slice].center[1];
  }
  else if (n->simOptz == 1)
  {
    int i;

    int quadCenterY = 0;

    for (i = 0; i < 4; i++) {
      coorddef temp;

      if (n->simRoadInfo.simQuad != (Trk_NewSimQuad *)0) temp = n->simRoadInfo.quadPts[i]; else temp = *(coorddef *)BWorldSm_slices[n->simRoadInfo.slice].center;
      quadCenterY += temp.y;
    }
    quadCenterY /= 4;

    n->groundElevation = quadCenterY;
  }
  else
  {

    static coorddef dummy __attribute__((section(".bss.newton_dummy_133")));

    if (stackSpeedUpEnbabledFlag != 0) {

      gWSavePtr = SetSp(gWSavePtr); stackSpeedUpEnbabledFlag = 0;

      n->groundElevation = Newton_FindGroundElevationAndNormal(n,&dummy);
      gWSavePtr = SetSp(gWSavePtr); stackSpeedUpEnbabledFlag = 1;
    } else
    { n->groundElevation = Newton_FindGroundElevationAndNormal(n,&dummy); }

    n->position.y = n->groundElevation + n->dimension.y;
  }




  n->objAltitude = Newton_CalcPerpenHeightOfLowestPointFromGround(n,(coorddef *)(n->roadMatrix.m + 3),&n->roadCenterPoint);
  n->position.y -= n->objAltitude;
  n->objAltitude = 0;

  if (n->simOptz == 0) {
    n->groundSurfaceType = n->simRoadInfo.simQuad == (Trk_NewSimQuad *)0 ? 0xe : n->simRoadInfo.simQuad->surface;
  } else
  { n->groundSurfaceType = 1; }

  n->driveSurfaceType = n->groundSurfaceType & 0xf; return;
}
#line 1415 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii [NEWTON.CPP:1420; COVERED-SLD-PASS] ---- */
/* 2026-10-29: actual initialization/guard/transform/copy/reset/exit phases
 * restore all supplied owners,blocks and absolute SLD with unchanged code.
 * No new object,asm,qualifier,fake use or synthetic scope is introduced.
 * Literal macro/comment text remains unproved;boundary reset preserves only
 * measured unchanged-neighbor coordinates,not their source completeness.
 * Receipt:build/nc12/newton_initial_shadow_20261029/final-proof.json. */
#line 1417 "C:/nfs4/GAME/COMMON/newton.cpp"
extern "C" void Newton_InitBaseNewtonObj(
    BO_tNewtonObj *newtonObj,int index,int mass,int moInertia,
    int dimX,int dimY,int dimZ)
{
  newtonObj->objID = index;
  newtonObj->simRoadInfo.simSlice = 0;
  newtonObj->simOptz = 0;




  newtonObj->position.x = 0; newtonObj->position.y = 0; newtonObj->position.z = 0;
  newtonObj->linearVel.x = 0; newtonObj->linearVel.y = 0; newtonObj->linearVel.z = 0;




  newtonObj->mass = mass;

  if (((GameSetup_gData.sgge & 2U) != 0) && ((((Car_tObj *)newtonObj)->carFlags & 4) != 0)) {
    newtonObj->mass = mass * 5;
  }
  if ((((Car_tObj *)newtonObj)->carFlags & 0x20) != 0) {

    if (GameSetup_gData.commMode == 1) {



      if ((Cars_gHumanRaceCarList[0]->carInfo->carType < 0x16) || (Cars_gHumanRaceCarList[1]->carInfo->carType < 0x16)) {



        newtonObj->mass = newtonObj->mass << 1;
      } else {

        newtonObj->mass = (newtonObj->mass * 3) / 2; } } else { newtonObj->mass = (newtonObj->mass * 3) / 2; } }


  newtonObj->massInv = fixeddiv(0x10000,newtonObj->mass);




  newtonObj->moInertia = newtonObj->mass << 3;
  newtonObj->moInertiaInv = fixeddiv(0x10000,newtonObj->moInertia);




  newtonObj->angularVel.x = 0; newtonObj->angularVel.y = 0; newtonObj->angularVel.z = 0;
  newtonObj->orientationToGround.x = 0; newtonObj->orientationToGround.y = 0x10000; newtonObj->orientationToGround.z = 0;




  newtonObj->dimension.x = dimX;
  newtonObj->dimension.y = dimY;
  newtonObj->dimension.z = dimZ;

  newtonObj->dimensionRadius = fixedsqrt((dimX / 0x100) * (dimX / 0x100) + (dimY / 0x100) * (dimY / 0x100));

  newtonObj->dimensionRadius = fixedsqrt((newtonObj->dimensionRadius / 0x100) * (newtonObj->dimensionRadius / 0x100) + (dimZ / 0x100) * (dimZ / 0x100));




  newtonObj->flightTime = 0;
  newtonObj->groundSurfaceType = 1; newtonObj->driveSurfaceType = 1;
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
  { int i; i = 9; do {
    newtonObj->damage[i] = 0; i--; } while (i >= 0);
  }



    newtonObj->reOrthoCounter = 0;
    newtonObj->deadTimer = 0;
    newtonObj->active = 1;
  newtonObj->cumulatedRot = 0;
}
#line 1495 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_QDUpdateVel__FP13BO_tNewtonObj [NEWTON.CPP:1516; COVERED-SLD-PASS] ---- */
/* 2026-10-29: real velocity/rotation/guard/exit phases preserve every code word
 * and restore full supplied owner,block and absolute SLD contracts. No new
 * object,asm,qualifier,fake use or scope is introduced. Literal macro/comment
 * text remains unproved. Boundary reset preserves unchanged neighbors only.
 * Receipt:build/nc12/newton_motion_source_20261029/final-proof.json. */
#line 1514 "C:/nfs4/GAME/COMMON/newton.cpp"
extern "C" void Newton_QDUpdateVel(BO_tNewtonObj *newtonObj)

{











  if (newtonObj->active == '\0') return;





  if ((GameSetup_gData.sgge & 4U) != 0)
  {
    int t1; int t2; int t3; t1 = newtonObj->linearVel.x >> 6;
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
    newtonObj->position.z = newtonObj->position.z + (newtonObj->linearVel.z >> 6); return; }





}
#line 1523 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_OptzRotxform__FP10matrixtdefiiiPiiT4 [NEWTON.CPP:1569; COVERED-SLD-PASS] ---- */
/* 2026-10-29: genuine transform/vector/guard/increment/return phases preserve
 * every code word and restore supplied owners,blocks and full absolute SLD.
 * No new object,asm,qualifier,fake use or synthetic declaring scope is added.
 * Literal original macro/comment text remains unproved. Boundary reset below
 * preserves unmodified neighbors' coordinates,not their source completeness.
 * Receipt:build/nc12/newton_queries_source_20261029/final-proof.json. */
#line 1565 "C:/nfs4/GAME/COMMON/newton.cpp"
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

  *reOrthoNeeded = 0;

  absx = __builtin_abs(ax);
  absy = __builtin_abs(ay);
  absz = __builtin_abs(az);

  *cumulatedRot += absx + absy + absz;




  fixedxformy(my.m,ay);
  changed = absy > 19;




  if (absx > 13) {

    fixedxformx(mx.m,ax);
    Math_fasttransmult(&mx,&my,&mt);
    changed = 1;
  }
  else {

    mt = my;
  }

  if (absz > 13) {

    fixedxformz(mz.m,az);
    Math_fasttransmult(&mt,&mz,m);
    changed = 1;
  }
  else {

    *m = mt;
  }
  return changed;
}
#line 1564 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj [NEWTON.CPP:1621; COVERED-SLD-PASS] ---- */
/* 2026-10-29: real velocity/rotation/guard/exit phases preserve every code word
 * and restore full supplied owner,block and absolute SLD contracts. No new
 * object,asm,qualifier,fake use or scope is introduced. Literal macro/comment
 * text remains unproved. Boundary reset preserves unchanged neighbors only.
 * Receipt:build/nc12/newton_motion_source_20261029/final-proof.json. */
#line 1619 "C:/nfs4/GAME/COMMON/newton.cpp"
extern "C" void Newton_QDUpdateRot64Hz(BO_tNewtonObj *newtonObj)

{
  matrixtdef m;
  int reOrthoNeeded;
  coorddef angularVel;






  if (newtonObj->active != 0) {





    angularVel.x = newtonObj->angularVel.x / 64;
    angularVel.y = newtonObj->angularVel.y / 64;
    angularVel.z = newtonObj->angularVel.z / 64;







    if (Newton_OptzRotxform(&m,angularVel.x,angularVel.y,angularVel.z,&reOrthoNeeded,0x1000,&newtonObj->cumulatedRot)) {








      Math_fasttransmult(&newtonObj->orientMat,&m,&newtonObj->orientMat);
      newtonObj->reOrthoCounter--; if ((newtonObj->reOrthoCounter == 0) || (reOrthoNeeded != 0)) {

        reorthogonalize(newtonObj->orientMat.m);
        newtonObj->reOrthoCounter = 0x20;
        newtonObj->cumulatedRot = 0; } } return; }





}
#line 1590 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj [NEWTON.CPP:1670; COVERED-SLD-PASS] ---- */
/* 2026-10-29: real velocity/rotation/guard/exit phases preserve every code word
 * and restore full supplied owner,block and absolute SLD contracts. No new
 * object,asm,qualifier,fake use or scope is introduced. Literal macro/comment
 * text remains unproved. Boundary reset preserves unchanged neighbors only.
 * Receipt:build/nc12/newton_motion_source_20261029/final-proof.json. */
#line 1668 "C:/nfs4/GAME/COMMON/newton.cpp"
extern "C" void Newton_QDUpdateRot32Hz(BO_tNewtonObj *newtonObj)

{
  matrixtdef m;
  int reOrthoNeeded;
  coorddef angularVel;






  if ((newtonObj->active != 0) && (newtonObj->simOptz == 0)) {





    angularVel.x = newtonObj->angularVel.x / 16;
    angularVel.y = newtonObj->angularVel.y / 16;
    angularVel.z = newtonObj->angularVel.z / 16;














    if (Newton_OptzRotxform(&m,angularVel.x,angularVel.y,angularVel.z,&reOrthoNeeded,0x2000,&newtonObj->cumulatedRot)) {







      Math_fasttransmult(&newtonObj->orientMat,&m,&newtonObj->orientMat);

      if ((reOrthoNeeded != 0) || (--newtonObj->reOrthoCounter == 0)) {

        reorthogonalize(newtonObj->orientMat.m);
        newtonObj->reOrthoCounter = 0x40;
        newtonObj->cumulatedRot = 0; } } return; }




}
#line 1615 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi [NEWTON.CPP:1730; COVERED-SLD-PASS] ---- */
/* 2026-10-29: actual initialization/guard/transform/copy/reset/exit phases
 * restore all supplied owners,blocks and absolute SLD with unchanged code.
 * No new object,asm,qualifier,fake use or synthetic scope is introduced.
 * Literal macro/comment text remains unproved;boundary reset preserves only
 * measured unchanged-neighbor coordinates,not their source completeness.
 * Receipt:build/nc12/newton_initial_shadow_20261029/final-proof.json. */
#line 1728 "C:/nfs4/GAME/COMMON/newton.cpp"
extern "C" void Newton_CalculateGroundShadowMatrix(BO_tNewtonObj *newtonObj,coorddef *normal,int orientToGround)

{






  if (((((Car_tObj *)newtonObj)->carFlags & 4U) == 0) && (0xe666 < orientToGround))
  {
    newtonObj->shadowMat = newtonObj->orientMat; {
      int r1; int r2; int r3;

      r1 = normal->x;
      r2 = normal->y;
      r3 = normal->z;
      newtonObj->shadowMat.m[3] = r1;
      newtonObj->shadowMat.m[4] = r2;
      newtonObj->shadowMat.m[5] = r3;
    }
  }
  else
  {



    {
      int r1; int r2; int r3; r1 = normal->x;
      r2 = normal->y;
      r3 = normal->z;
      newtonObj->shadowMat.m[3] = r1;
      newtonObj->shadowMat.m[4] = r2;
      newtonObj->shadowMat.m[5] = r3;
    }

    if (orientToGround < 0x8000) {

      if (0.5 < (double)__builtin_abs(newtonObj->orientMat.m[0] / 256 * (normal->x / 256) + newtonObj->orientMat.m[1] / 256 * (normal->y / 256) + newtonObj->orientMat.m[2] / 256 * (normal->z / 256))) {






        newtonObj->shadowMat.m[0] = fixedmult(newtonObj->shadowMat.m[4],newtonObj->orientMat.m[8]) - fixedmult(newtonObj->shadowMat.m[5],newtonObj->orientMat.m[7]);         newtonObj->shadowMat.m[1] = fixedmult(newtonObj->shadowMat.m[5],newtonObj->orientMat.m[6]) - fixedmult(newtonObj->shadowMat.m[3],newtonObj->orientMat.m[8]);         newtonObj->shadowMat.m[2] = fixedmult(newtonObj->shadowMat.m[3],newtonObj->orientMat.m[7]) - fixedmult(newtonObj->shadowMat.m[4],newtonObj->orientMat.m[6]);

        Math_NormalizeShortVector((coorddef *)&newtonObj->shadowMat.m[0]);






        newtonObj->shadowMat.m[6] = fixedmult(newtonObj->shadowMat.m[1],newtonObj->shadowMat.m[5]) - fixedmult(newtonObj->shadowMat.m[2],newtonObj->shadowMat.m[4]);         newtonObj->shadowMat.m[7] = fixedmult(newtonObj->shadowMat.m[2],newtonObj->shadowMat.m[3]) - fixedmult(newtonObj->shadowMat.m[0],newtonObj->shadowMat.m[5]);         newtonObj->shadowMat.m[8] = fixedmult(newtonObj->shadowMat.m[0],newtonObj->shadowMat.m[4]) - fixedmult(newtonObj->shadowMat.m[1],newtonObj->shadowMat.m[3]);

        Math_NormalizeShortVector((coorddef *)&newtonObj->shadowMat.m[6]);
        return;
      }
    }






    newtonObj->shadowMat.m[6] = fixedmult(newtonObj->orientMat.m[1],newtonObj->shadowMat.m[5]) - fixedmult(newtonObj->orientMat.m[2],newtonObj->shadowMat.m[4]);     newtonObj->shadowMat.m[7] = fixedmult(newtonObj->orientMat.m[2],newtonObj->shadowMat.m[3]) - fixedmult(newtonObj->orientMat.m[0],newtonObj->shadowMat.m[5]);     newtonObj->shadowMat.m[8] = fixedmult(newtonObj->orientMat.m[0],newtonObj->shadowMat.m[4]) - fixedmult(newtonObj->orientMat.m[1],newtonObj->shadowMat.m[3]);

    Math_NormalizeShortVector((coorddef *)&newtonObj->shadowMat.m[6]);






    newtonObj->shadowMat.m[0] = fixedmult(newtonObj->shadowMat.m[4],newtonObj->shadowMat.m[8]) - fixedmult(newtonObj->shadowMat.m[5],newtonObj->shadowMat.m[7]);     newtonObj->shadowMat.m[1] = fixedmult(newtonObj->shadowMat.m[5],newtonObj->shadowMat.m[6]) - fixedmult(newtonObj->shadowMat.m[3],newtonObj->shadowMat.m[8]);     newtonObj->shadowMat.m[2] = fixedmult(newtonObj->shadowMat.m[3],newtonObj->shadowMat.m[7]) - fixedmult(newtonObj->shadowMat.m[4],newtonObj->shadowMat.m[6]);

    Math_NormalizeShortVector((coorddef *)&newtonObj->shadowMat.m[0]); return; }

}
#line 1700 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_CalcRealShadowCoordinates__FP8Car_tObji [NEWTON.CPP:1830; COVERED-SLD-PASS] ---- */
/* 2026-10-29: actual initialization/guard/transform/copy/reset/exit phases
 * restore all supplied owners,blocks and absolute SLD with unchanged code.
 * No new object,asm,qualifier,fake use or synthetic scope is introduced.
 * Literal macro/comment text remains unproved;boundary reset preserves only
 * measured unchanged-neighbor coordinates,not their source completeness.
 * Receipt:build/nc12/newton_initial_shadow_20261029/final-proof.json. */
#line 1828 "C:/nfs4/GAME/COMMON/newton.cpp"
extern "C" void Newton_CalcRealShadowCoordinates(Car_tObj *carObj,int currentTick)

{
  coorddef lengthVector; coorddef widthVector; coorddef frontWidthVector; coorddef carGroundCoord; coorddef temp; coorddef vecOffset; int diff; coorddef dimension;



  diff = currentTick - carObj->N.lastUpdated;

  dimension = carObj->N.dimension;
  dimension.x += 0xccc;
  dimension.z += 0xccc;


  lengthVector.x = fixedmult(dimension.z,carObj->N.orientMat.m[6]);   lengthVector.y = fixedmult(dimension.z,carObj->N.orientMat.m[7]);   lengthVector.z = fixedmult(dimension.z,carObj->N.orientMat.m[8]);
  widthVector.x = fixedmult(dimension.x,carObj->N.orientMat.m[0]);   widthVector.y = fixedmult(dimension.x,carObj->N.orientMat.m[1]);   widthVector.z = fixedmult(dimension.x,carObj->N.orientMat.m[2]);

  if (carObj->render.currentCarType == 20)
  {
    int front; front = dimension.x * 0xc0 >> 8;
    frontWidthVector.x = fixedmult(front,carObj->N.orientMat.m[0]);     frontWidthVector.y = fixedmult(front,carObj->N.orientMat.m[1]);     frontWidthVector.z = fixedmult(front,carObj->N.orientMat.m[2]);

  } else {
    frontWidthVector.z = widthVector.z; frontWidthVector.x = widthVector.x; frontWidthVector.y = widthVector.y;
  }

  if (carObj->N.orientationToGround.y > 0xe666) {

    vecOffset.x = fixedmult(-dimension.y - carObj->N.objAltitude,carObj->N.roadMatrix.m[3]);     vecOffset.y = fixedmult(-dimension.y - carObj->N.objAltitude,carObj->N.roadMatrix.m[4]);     vecOffset.z = fixedmult(-dimension.y - carObj->N.objAltitude,carObj->N.roadMatrix.m[5]);
    carGroundCoord.x = carObj->N.position.x + vecOffset.x;     carGroundCoord.y = carObj->N.position.y + vecOffset.y;     carGroundCoord.z = carObj->N.position.z + vecOffset.z;


  } else {
    carGroundCoord = carObj->N.position;
    carGroundCoord.y = carObj->N.groundElevation;
  }

  temp.x = carGroundCoord.x + lengthVector.x;   temp.y = carGroundCoord.y + lengthVector.y;   temp.z = carGroundCoord.z + lengthVector.z;
  carObj->N.shadowCoord[0].x = temp.x - frontWidthVector.x;   carObj->N.shadowCoord[0].y = temp.y - frontWidthVector.y;   carObj->N.shadowCoord[0].z = temp.z - frontWidthVector.z;
  carObj->N.shadowCoord[1].x = temp.x + frontWidthVector.x;   carObj->N.shadowCoord[1].y = temp.y + frontWidthVector.y;   carObj->N.shadowCoord[1].z = temp.z + frontWidthVector.z;

  temp.x = carGroundCoord.x - lengthVector.x;   temp.y = carGroundCoord.y - lengthVector.y;   temp.z = carGroundCoord.z - lengthVector.z;
  carObj->N.shadowCoord[2].x = temp.x - widthVector.x;   carObj->N.shadowCoord[2].y = temp.y - widthVector.y;   carObj->N.shadowCoord[2].z = temp.z - widthVector.z;
  carObj->N.shadowCoord[3].x = temp.x + widthVector.x;   carObj->N.shadowCoord[3].y = temp.y + widthVector.y;   carObj->N.shadowCoord[3].z = temp.z + widthVector.z;


  for (int i = 0; i < 4; i++) {


    carObj->N.shadowCoord[i].y = carObj->wheel[i].currentPos.y;

    carObj->N.shadowCoord[i].y += (carObj->N.linearVel.y / 64) * diff;
  } return;
}
#line 1780 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_CheckForSpikeBelts__FP13BO_tNewtonObj [NEWTON.CPP:1885; COVERED-SLD-PASS] ---- */
/* 2026-10-29: genuine transform/vector/guard/increment/return phases preserve
 * every code word and restore supplied owners,blocks and full absolute SLD.
 * No new object,asm,qualifier,fake use or synthetic declaring scope is added.
 * Literal original macro/comment text remains unproved. Boundary reset below
 * preserves unmodified neighbors' coordinates,not their source completeness.
 * Newton_GetSpikeBelt remains a pre-existing inferred inline spelling;
 * its original name is not supplied by these otherwise exact records.
 * Receipt:build/nc12/newton_queries_source_20261029/final-proof.json. */
#line 1883 "C:/nfs4/GAME/COMMON/newton.cpp"
extern "C" void Newton_CheckForSpikeBelts(BO_tNewtonObj *newtonObj)

{
  int slice;
  int leftLatPos;
  int rightLatPos;

  if ((Newton_GetSpikeBelt(&slice,&leftLatPos,&rightLatPos) != 0) && (newtonObj->simRoadInfo.slice == slice))
  {
    int latPos;
    latPos = ((Car_tObj *)newtonObj)->roadPosition;


    if ((((Car_tObj *)newtonObj)->carFlags & 0x230) == 0) {


      if ((leftLatPos < latPos) && (latPos < rightLatPos)) {

        ++((Car_tObj *)newtonObj)->blowout;


        if (((Car_tObj *)newtonObj)->blowout == 1) {

          newtonObj->collision.impulse = 0xf0000;
          newtonObj->collision.sfxType = 0x50007;
          newtonObj->collision.collisionPoint = newtonObj->position; } } } return; }







}
#line 1803 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef [NEWTON.CPP:1922; COVERED-SLD-PASS] ---- */
/* 2026-10-29: restore the real normal/up-vector cross product and velocity
 * dot product,then negative absolute-value/16 and bound-first clamp.
 * The matched NFS2 body independently supports those geometric roles;
 * retail PSX words require signed /256 factors,not >>8 or full fixedmult.
 * All106 words and supplied owners/blocks/absolute SLD match without the
 * old eleven capture locals,two asm fences,three volatile reads,three
 * one-shot loops or two absorption identities. Earlier necessity/floor
 * claims are superseded. No replacement device or source object is added.
 * Keep retail's normal argument to CorrectPostCollisionYaw;NFS2 differs.
 * Literal original macro text is not uniquely recovered from these records.
 * Receipt:build/nc12/newton_barrier_source_20261029/final-proof.json. */
#line 1920 "C:/nfs4/GAME/COMMON/newton.cpp"
extern "C" void Newton_DoPostBarrierCollisionHandling(BO_tNewtonObj *newtonObj,coorddef normal)

{
  coorddef barrierVec;
  {
    int impactVel; int distRetreat;
    coorddef upVec;
    matrixtdef islandMatrix;




    upVec.x = 0;
    upVec.y = 0x10000;
    upVec.z = 0;

    barrierVec.x = ((normal.y) / 0x100) * ((upVec.z) / 0x100) - ((normal.z) / 0x100) * ((upVec.y) / 0x100); barrierVec.y = ((normal.z) / 0x100) * ((upVec.x) / 0x100) - ((normal.x) / 0x100) * ((upVec.z) / 0x100); barrierVec.z = ((normal.x) / 0x100) * ((upVec.y) / 0x100) - ((normal.y) / 0x100) * ((upVec.x) / 0x100);


    distRetreat = -__builtin_abs(((normal.x) / 0x100) * ((newtonObj->linearVel.x) / 0x100) + ((normal.y) / 0x100) * ((newtonObj->linearVel.y) / 0x100) + ((normal.z) / 0x100) * ((newtonObj->linearVel.z) / 0x100)) / 0x10;
    distRetreat = -0x7ae < distRetreat ? -0x7ae : distRetreat;

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
    Physics_CorrectPostCollisionYaw((Car_tObj *)newtonObj,impactVel,normal); } }
#line 2364 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos [NEWTON.CPP:2107; COVERED-SLD-PASS] ---- */
/* 2026-10-29: genuine transform/vector/guard/increment/return phases preserve
 * every code word and restore supplied owners,blocks and full absolute SLD.
 * No new object,asm,qualifier,fake use or synthetic declaring scope is added.
 * Literal original macro/comment text remains unproved. Boundary reset below
 * preserves unmodified neighbors' coordinates,not their source completeness.
 * Receipt:build/nc12/newton_queries_source_20261029/final-proof.json. */
#line 2105 "C:/nfs4/GAME/COMMON/newton.cpp"
extern "C" void Newton_GenerateVector(int type,coorddef *vector,BWorldSm_Pos *testSimRoadInfo)

{
  coorddef fwdVec;
  coorddef upVec;
  coorddef result;

  upVec.x = upVec.z = 0;
  upVec.y = 0x10000;

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
  result.x = fixedmult(fwdVec.y,upVec.z) - fixedmult(fwdVec.z,upVec.y); result.y = fixedmult(fwdVec.z,upVec.x) - fixedmult(fwdVec.x,upVec.z); result.z = fixedmult(fwdVec.x,upVec.y) - fixedmult(fwdVec.y,upVec.x);
  vector->x = result.x;
  vector->y = result.y;
  vector->z = result.z;
}
#line 2404 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi [NEWTON.CPP:2144; COVERED-SLD-PASS] ---- */
/* 2026-10-29: genuine transform/vector/guard/increment/return phases preserve
 * every code word and restore supplied owners,blocks and full absolute SLD.
 * No new object,asm,qualifier,fake use or synthetic declaring scope is added.
 * Literal original macro/comment text remains unproved. Boundary reset below
 * preserves unmodified neighbors' coordinates,not their source completeness.
 * Receipt:build/nc12/newton_queries_source_20261029/final-proof.json. */
#line 2141 "C:/nfs4/GAME/COMMON/newton.cpp"
extern "C" int
Netwon_CheckForBadQuad(BO_tNewtonObj *newtonObj,BWorldSm_Pos *testSimRoadInfo,int wheel)

{
  int bad;
  bad = 0;

  if ((testSimRoadInfo->simQuad != (Trk_NewSimQuad *)0) && ((testSimRoadInfo->simQuad->surface & 0xf) == 0)) {
    bad = 1;
  } else
  {
    int height; height = ((Car_tObj *)newtonObj)->wheel[wheel].actualHeight - ((Car_tObj *)newtonObj)->wheel[wheel].currentPos.y;

    if (height > 0x20000)
      bad = 1;
  }
  return bad;
}
#line 2427 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj [NEWTON.CPP:2161; COVERED-SLD-PASS] ---- */
/* 2026-10-29: genuine wheel/edge/centroid/collision phases preserve all470
 * words,17 supplied declaration owners,52 block records and absolute SLD.
 * Retail Car.wheel[4] at652,stride48,currentPos0 replaces two raw copies.
 * The real for-initializer statement supplies2179 independently of its
 * declaring loop's2176 note;no new object or synthetic region is added.
 * SOURCE-REVIEW-UNRESOLVED: aborted is inferred,not a retail SYM name.
 * Mobile sub_4FEF33 independently has the per-wheel zero flag and guarded
 * collision exit. Removing it loses two retail instructions on this graph;
 * that is not proof of unique original spelling,type or all-source necessity.
 * Literal original macro/flag text remains review;no generic carrier waiver.
 * Keep signed offEdge,real temp/j ownership and index-first quad addresses.
 * No asm,volatile,identity,fake use or generated-output rewrite is added.
 * Receipt:build/nc12/newton_undrivable_source_20261029/final-proof.json. */
#line 2159 "C:/nfs4/GAME/COMMON/newton.cpp"
void Newton_TestForUndrivableSurfaces(BO_tNewtonObj *newtonObj)

{
  int i; int collision_type; int newHeight; coorddef normal; coorddef cautionaryCenter; coorddef undrivableCenter; coorddef speedVec; int aborted;
  collision_type = 0;



  newHeight = 0;

  cautionaryCenter = newtonObj->roadCenterPoint;

  memset((u_char *)&speedVec,0,12);
  testSimRoadInfo = newtonObj->simRoadInfo;

  if (0x280000 < newtonObj->speedXZ) {

    speedVec.x = newtonObj->linearVel.x * 5 / 0x100; speedVec.y = newtonObj->linearVel.y * 5 / 0x100; speedVec.z = newtonObj->linearVel.z * 5 / 0x100; } for ({


    i = 0; } i < 4; i++) {
    coorddef testPoint;
    testPoint = ((Car_tObj *)newtonObj)->wheel[i].currentPos;

    aborted = 0;
    testPoint.x += speedVec.x; testPoint.y += speedVec.y; testPoint.z += speedVec.z;
    BWorldSm_FindClosestQuadRez(&testPoint,&testSimRoadInfo,1);


    if ((signed char)testSimRoadInfo.offEdge != 0)
    {

      Newton_GenerateVector((signed char)testSimRoadInfo.offEdge,&normal,&newtonObj->simRoadInfo);
      normal.y = 0;
      Math_NormalizeShortVector(&normal);
      collision_type = 1;
    } else

    { if (Netwon_CheckForBadQuad(newtonObj,&testSimRoadInfo,i) != 0)
      { coorddef newTestPoint; int check;
        newtestSimRoadInfo = testSimRoadInfo;
        newTestPoint = testPoint;
        check = BWorldSm_FindEdgeOff(&testPoint,&newtonObj->simRoadInfo,&testSimRoadInfo,(u_int *)&newHeight);



        collision_type = 2; if (check == 1) {


          Newton_GenerateVector(1,&normal,&newtonObj->simRoadInfo);
        }
        else if (check == 2) {


          Newton_GenerateVector(2,&normal,&newtonObj->simRoadInfo);
        }
        else if (check == 4) {


          Newton_GenerateVector(4,&normal,&newtonObj->simRoadInfo);
        }
        else if (check == 8) {


          Newton_GenerateVector(8,&normal,&newtonObj->simRoadInfo);
        }


        if ((check & 3) != 0)
        {
          if ((check & 1) != 0) {


            Newton_GenerateVector(1,&normal,&newtonObj->simRoadInfo);
          }
          else if ((check & 2) != 0) {


            Newton_GenerateVector(2,&normal,&newtonObj->simRoadInfo);
          }

          newTestPoint.x += normal.x;
          newTestPoint.y += normal.y;
          newTestPoint.z += normal.z;
          BWorldSm_FindClosestQuadRez(&newTestPoint,&newtestSimRoadInfo,1);


          if (Netwon_CheckForBadQuad(newtonObj,&newtestSimRoadInfo,i) != 0)
          {

            if ((check & 0xc) != 0)
            {
              if ((check & 4) != 0) {


                Newton_GenerateVector(4,&normal,&newtonObj->simRoadInfo);
              }
              else if ((check & 8) != 0) {


                Newton_GenerateVector(8,&normal,&newtonObj->simRoadInfo);
              }


              newtestSimRoadInfo = testSimRoadInfo;
              newTestPoint = testPoint;
              newTestPoint.x += normal.x;
              newTestPoint.y += normal.y;
              newTestPoint.z += normal.z;
              BWorldSm_FindClosestQuadRez(&newTestPoint,&newtestSimRoadInfo,1);

              if (Netwon_CheckForBadQuad(newtonObj,&newtestSimRoadInfo,i) != 0)
              {


                { int j; undrivableCenter.z = 0; undrivableCenter.y = 0; undrivableCenter.x = 0;
                  j = 0; while (j < 4) {

                    coorddef temp;
                    if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0) temp = *(coorddef *)((j * 12) + (int)testSimRoadInfo.quadPts); else temp = *(coorddef *)BWorldSm_slices[testSimRoadInfo.slice].center;
                    undrivableCenter.x += temp.x;
                    undrivableCenter.y += temp.y;
                    undrivableCenter.z += temp.z;
                    j++; } }
                undrivableCenter.x /= 4;
                undrivableCenter.y /= 4;
                undrivableCenter.z /= 4;


                normal.x = cautionaryCenter.x - undrivableCenter.x;
                normal.z = cautionaryCenter.z - undrivableCenter.z;
                normal.y = 0;
              }


            } else {


              { int j; undrivableCenter.z = 0; undrivableCenter.y = 0; undrivableCenter.x = 0;
                j = 0; while (j < 4) {

                  coorddef temp;
                  if (testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0) temp = *(coorddef *)((j * 12) + (int)testSimRoadInfo.quadPts); else temp = *(coorddef *)BWorldSm_slices[testSimRoadInfo.slice].center;
                  undrivableCenter.x += temp.x;
                  undrivableCenter.y += temp.y;
                  undrivableCenter.z += temp.z;
                  j++; } }
              undrivableCenter.x /= 4;
              undrivableCenter.y /= 4;
              undrivableCenter.z /= 4;


              normal.x = newtonObj->position.x - undrivableCenter.x;
              normal.z = newtonObj->position.z - undrivableCenter.z;
              normal.y = 0;
            }
          }
        }
        normal.y = 0;
        Math_NormalizeShortVector(&normal);
      }
    }
    if (collision_type != 0)
    {




      if (aborted == 0)
      {
        Newton_DoPostBarrierCollisionHandling(newtonObj,normal);
        newtonObj->collision.collisionPoint = ((Car_tObj *)newtonObj)->wheel[i].currentPos;
        AIPhysic_ProcessBarrierCollision((Car_tObj *)newtonObj);




        if ((((Car_tObj *)newtonObj)->carFlags & 4U) != 0) {

          Physics_FixEngineRpm((Car_tObj *)newtonObj);
        }


        if (newtonObj->collision.impulse >= 0xa0001)
        { int impulse; int zone;

          impulse = newtonObj->collision.impulse;


          if (i == 2) zone = 6;

          else if (i == 3)
            zone = 4;

          else zone = 2 * i;


          Newton_AddDamageZone(newtonObj,impulse,zone,1);
        } }

      return;
    }
  } }
#line 2802 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_LimitAngularVelocity__FP13BO_tNewtonObj [NEWTON.CPP:2440; COVERED-SLD-PASS] ---- */
/* 2026-10-29: real velocity/rotation/guard/exit phases preserve every code word
 * and restore full supplied owner,block and absolute SLD contracts. No new
 * object,asm,qualifier,fake use or scope is introduced. Literal macro/comment
 * text remains unproved. Boundary reset preserves unchanged neighbors only.
 * Receipt:build/nc12/newton_motion_source_20261029/final-proof.json. */
#line 2438 "C:/nfs4/GAME/COMMON/newton.cpp"
extern "C" void Newton_LimitAngularVelocity(BO_tNewtonObj *newtonObj)

{


  if (0x18000 < newtonObj->angularVel.x) {
    newtonObj->angularVel.x = 0x18000;
  } else if (newtonObj->angularVel.x < -0x18000) {
    newtonObj->angularVel.x = -0x18000;
  }
  if (0x18000 < newtonObj->angularVel.y) {
    newtonObj->angularVel.y = 0x18000;
  } else if (newtonObj->angularVel.y < -0x18000) {
    newtonObj->angularVel.y = -0x18000;
  }
  if (0x18000 < newtonObj->angularVel.z) {
    newtonObj->angularVel.z = 0x18000;
  } else if (newtonObj->angularVel.z < -0x18000) {
    newtonObj->angularVel.z = -0x18000;
  } }
#line 2827 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj [NEWTON.CPP:2466-2733; COVERED-SYM-SLD-PASS] ---- */
/* 2026-10-29: genuine schedule/ground/gravity/landing/velocity/tunnel phases
 * preserve all315 words,15 supplied owners,30 block records and end2733.
 * Separate absolute-speed results on2553/2554 restore the last two load tags.
 * Plain x/z are independently supported by matched NFS2 absolute-value source,
 * not recovered NFS4 identifiers. Both results are naturally debug-elided;
 * capturing the raw signed inputs instead adds unprovided records. No const
 * disguise is needed. Original object/name/macro spelling is not unique.
 * Keep the provided ground-height/closing-velocity value flow and actual
 * shadowNormal copy region;literal reuse/macro syntax is not uniquely proved.
 * No new qualifier,asm,volatile,fake use or scope is added.
 * Boundary reset preserves only unchanged-neighbor coordinates.
 * Receipt:build/nc12/newton_gravity_speed_20261029/final-proof.json. */
#line 2465 "C:/nfs4/GAME/COMMON/newton.cpp"
extern "C" void Newton_ApplyTheLawOfGravity(BO_tNewtonObj *newtonObj)
{
  int elevationOfGround; int objAltitude; int groundVel; int relativeClosingVelocity; coorddef normal; coorddef shadowNormal; int timeCount; int elapsedTime; int iTimeCount; int modifiedGravity;










  modifiedGravity = 0x4800;

  if (!newtonObj->active) return;










  if (!Sched_ExecuteCheck(1,3,newtonObj->distToPlayer,newtonObj->objID,&timeCount,&elapsedTime,&iTimeCount,((Car_tObj *)newtonObj)->forceNoSimOptz)) return;








  if (newtonObj->simOptz >= 2) {

    newtonObj->linearVel.y = 0;
    newtonObj->flightTime = 0;

    elevationOfGround = Newton_FindGroundElevationAndNormalFast(newtonObj,&normal) + newtonObj->dimension.y;





    newtonObj->position.y = elevationOfGround; return;
  }






  elevationOfGround = Newton_FindGroundElevationAndNormal(newtonObj,&normal);
  ({ shadowNormal = normal; });
  objAltitude = newtonObj->objAltitude;
  relativeClosingVelocity = newtonObj->groundElevation; groundVel = (elevationOfGround - relativeClosingVelocity) * timeCount;






  newtonObj->groundElevation = elevationOfGround;




  newtonObj->linearVel.y -= fixedmult(elapsedTime * modifiedGravity,newtonObj->gravityMult);









  newtonObj->orientationToGround.y = fixedmult(newtonObj->orientMat.m[3],normal.x) + fixedmult(newtonObj->orientMat.m[4],normal.y) + fixedmult(newtonObj->orientMat.m[5],normal.z);
  Newton_CalculateGroundShadowMatrix(newtonObj,&shadowNormal,newtonObj->orientationToGround.y);







  int x = __builtin_abs(newtonObj->linearVel.x);
  int z = __builtin_abs(newtonObj->linearVel.z);
  newtonObj->speedXZ = Math_BetterDist(x,z);





  newtonObj->roadGravityModifier = (newtonObj->roadGravityModifier * 7 + (groundVel - newtonObj->groundVel)) / 8;




  newtonObj->groundVel = groundVel;
  if (objAltitude >= 0x3333) {








    newtonObj->roadGravityModifier = 0;
    newtonObj->flightTime += elapsedTime;
    newtonObj->linearVel.y -= fixedmult(elapsedTime * modifiedGravity,newtonObj->gravityMult);

  } else
  {



    if (newtonObj->flightTime != 0)
    {



      if ((((Car_tObj *)newtonObj)->carFlags & 4) != 0)
        Physics_FixEngineRpm((Car_tObj *)newtonObj);




      relativeClosingVelocity = groundVel - newtonObj->linearVel.y;
      {




        if (newtonObj->orientationToGround.y < 0xb334)
        {
          coorddef collisionPoint;
          collisionPoint = newtonObj->roadCenterPoint;
          collisionPoint.y -= 0x1999;
          Collide_TestWithPlane(newtonObj,&normal,&collisionPoint);


          if (newtonObj->collision.impulse > 0x50000)

            newtonObj->collision.impulse = (0x140000 > newtonObj->collision.impulse) ? 0x140000 : newtonObj->collision.impulse;



          if (newtonObj->orientationToGround.y < 0x3333)
            ((Car_tObj *)newtonObj)->collision.smoking = 1;
        }

        else {



          int bounceVel = 0;
          for (int k = 0; k < 4; k++) {
            bounceVel += ((Car_tObj *)newtonObj)->wheel[k].wheelAcc; }
          if (bounceVel > 0) {

            newtonObj->linearVel.y = groundVel + bounceVel * 3 / 4;
            newtonObj->position.y -= objAltitude;
            objAltitude = 0xccc;
            newtonObj->collision.impulse = relativeClosingVelocity * 2;
            newtonObj->flightTime = 0;
            newtonObj->objAltitude = objAltitude;
            if (newtonObj->collision.impulse > 0x140000) {

              newtonObj->collision.sfxType = 0x10000;
              newtonObj->collision.otherObj = 0;
              newtonObj->collision.collisionPoint = newtonObj->position;
              Newton_AddDamageZone(newtonObj,newtonObj->collision.impulse,9,0);
            }


            if (Force_IsForceOn((Car_tObj *)newtonObj))

              Force_HitWall(newtonObj->collision.impulse);
          }
        }


      Newton_LimitAngularVelocity(newtonObj); }
    } else {










      Newton_CheckForSpikeBelts(newtonObj);
    }





    if (objAltitude < 0xa3d)
    {
      newtonObj->position.y -= objAltitude;
      newtonObj->objAltitude = 0;



      if (((((Car_tObj *)newtonObj)->carFlags & 0x400) == 0) && newtonObj->orientationToGround.y > 0xe666)
        newtonObj->flightTime = 0;


      if (groundVel > 0x5ffff)
      { int scale;

        scale = 0xffdf;
        if (groundVel > 0xc0000)
          scale = 0xffbe;

        newtonObj->linearVel.x = fixedmult(newtonObj->linearVel.x,scale);
        newtonObj->linearVel.z = fixedmult(newtonObj->linearVel.z,scale);
      }










      if (newtonObj->speedXZ < 0x50000)
        newtonObj->linearVel.y = groundVel / 4;
      else if (newtonObj->speedXZ < 0xa0000)
        newtonObj->linearVel.y = groundVel / 2;
      else
        newtonObj->linearVel.y = groundVel;
    }
  }

  newtonObj->lastUpdated = simGlobal.gameTicks;



  if (BWorldSm_TunnelFlagSm(&newtonObj->simRoadInfo) && newtonObj->linearVel.y > 0 && newtonObj->position.y - newtonObj->roadCenterPoint.y > 0x80000) {

    newtonObj->linearVel.y = -newtonObj->linearVel.y;
  }















}
#line 2970 "C:/nfs4/GAME/COMMON/newton.cpp" /* preserve unchanged following-function coordinates */

/* ---- Newton_CalculateRoadPositionFromSliceAndPosition__FiP8coorddefP10matrixtdef [NEWTON.CPP:2736-2745] COVERED-SLD-PASS ---- */
/* Source phases (2026-10-29): root roadPosition and separate calculation/
 * return follow matched NFS2 Newton_CalculateRoadPosition. The plain int,
 * not a const alias,has no emitted REG row on the selected stock compiler.
 * All word/file tags,provided declarations,blocks and end agree. NFS2 backs
 * the result name/pattern;its original NFS4 spelling and the vector macro's
 * literal text are not uniquely retained. Do not claim full source recovery
 * from debug elision or add a generic source-object exemption.
 * Receipt:build/nc12/newton_anchor_source_20261029/final-proof.json. */
#line 2734 "C:/nfs4/GAME/COMMON/NEWTON.CPP"
int Newton_CalculateRoadPositionFromSliceAndPosition(int slice,coorddef *position,matrixtdef *matrix)

{
  coorddef centerBack;
  coorddef carRelative;
  int roadPosition;

  centerBack = *(coorddef *)BWorldSm_slices[slice].center;
  carRelative.x = position->x - centerBack.x; carRelative.y = position->y - centerBack.y; carRelative.z = position->z - centerBack.z;

  roadPosition = (matrix->m[0] / 256) * (carRelative.x / 256) + (matrix->m[1] / 256) * (carRelative.y / 256) + (matrix->m[2] / 256) * (carRelative.z / 256);
  return roadPosition; }

/* ---- Newton_CalculateRoadPosition__FP13BO_tNewtonObj [NEWTON.CPP:2762-2773] COVERED-SLD-PASS ---- */
/* Source phases (2026-10-29): root roadPosition and separate calculation/
 * return follow matched NFS2 Newton_CalculateRoadPosition. The plain int,
 * not a const alias,has no emitted REG row on the selected stock compiler.
 * All word/file tags,provided declarations,blocks and end agree. NFS2 backs
 * the result name/pattern;its original NFS4 spelling and the vector macro's
 * literal text are not uniquely retained. Do not claim full source recovery
 * from debug elision or add a generic source-object exemption.
 * Receipt:build/nc12/newton_anchor_source_20261029/final-proof.json. */
#line 2760 "C:/nfs4/GAME/COMMON/NEWTON.CPP"
int Newton_CalculateRoadPosition(BO_tNewtonObj *newtonObj)

{
  coorddef centerBack;
  coorddef carRelative;
  coorddef carPos;
  int roadPosition;
  centerBack = *(coorddef *)BWorldSm_slices[newtonObj->simRoadInfo.slice].center;
  carPos = newtonObj->position;
  carRelative.x = carPos.x - centerBack.x; carRelative.y = carPos.y - centerBack.y; carRelative.z = carPos.z - centerBack.z;

  roadPosition = (newtonObj->roadMatrix.m[0] / 256) * (carRelative.x / 256) + (newtonObj->roadMatrix.m[1] / 256) * (carRelative.y / 256) + (newtonObj->roadMatrix.m[2] / 256) * (carRelative.z / 256);

  return roadPosition; }

/* end of newton.cpp */
