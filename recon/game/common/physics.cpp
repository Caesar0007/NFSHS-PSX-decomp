/* game/common/physics.cpp -- RECONSTRUCTED (NFS4 PSX car physics engine; C++ TU)
 *   22 fns: SimCar/Real driver + tire forces, traction circle, accel, autoshift, barrier, RS control.
 *   GTE-free (fixed-point + eaclib math). Remaining local/scope/SLD restoration
 *   is tracked in sym-match.md; declarations alone are not a source seal.
 */
#include "physics_types.h"
#include "physics_externs.h"

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x80056364): the unused inline of the
 * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

/* EA's canonical NFS2 symbol-bearing source uses these exact MIN/MAX
   expansions in Physics_GetTorque.  The NFS4 oracle confirms the same nested
   COND_EXPR shape; leaving either macro undefined emits a phantom `jal`, while
   reversing MIN's comparison changes retail's branch/allocation sequence. */
#define MIN(a,b) (((a) > (b)) ? (b) : (a))
#define MAX(a,b) (((a) > (b)) ? (a) : (b))

/* physics.obj small-data globals in exact SYM order.  The explicit zero on the
 * file-static currentWallType is source-significant: it keeps that word in
 * .sdata at 0x8013d2fc instead of .sbss. */
int gBrakeRatio = 0, gGasRatio = 0, gSteerRatio = 0;
static int currentWallType = 0;
int exceedRedline = 0;
int roadMult = 0, frontMult = 0, rearMult = 0, leftMult = 0, rightMult = 0;
int slippery = 0, steeringControl = 0, powerControl = 0;

/* physics.obj initialized-data run from the SYM, 0x80116530..0x801165e0.
 * The declaration order and dimensions are the retail debug records; values
 * are transcribed from the same-address executable payload. */
int roadSurfaceFrictionCoeff[10] = {
  0x11999, 0x10ccc, 0x10000, 0xf333, 0xe666,
  0xd999, 0xcccc, 0xc000, 0xb333, 0x8000
};
int ReverseRoadSurfaceFrictionCoeff[10] = {
  0xe8f5, 0xf333, 0x10000, 0x10d91, 0x11c28,
  0x12d0e, 0x14000, 0x1547a, 0x16e14, 0x20000
};
char roadSurfaceIndex[3][20] = {
  {7, 3, 3, 3, 3, 3, 4, 3, 3, 3, 3, 3, 3, 3, 5, 3, 5, 5, 5, 5},
  {7, 2, 4, 4, 2, 4, 5, 2, 2, 4, 2, 3, 3, 4, 5, 4, 5, 5, 5, 5},
  {7, 0, 2, 2, 1, 3, 3, 1, 0, 3, 0, 1, 1, 3, 5, 5, 5, 5, 5, 5}
};
int gripLossTable[3] = {0x20, 8, 8};
int gripLossTableWet[3] = {0x10, 6, 4};
coorddef gravity_ch = {0, 0, 0};

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Physics_InitCarSpecs(Car_tObj *carObj,Udff_tInfo *handle);
void Physics_CalculateDerivedCarSpecs(Car_tObj *carObj);
void Physics_CheckGamedata(void);
int Physics_AttenuateVelocity(Car_tObj *carObj,int force,matrixtdef *roadMat);
void Physics_SetCurrentWallType(int wallType);
int Physics_GetTorque(Car_tObj *carObj,int index);
void Physics_CorrectPostCollisionYaw(Car_tObj *carObj,int impactVel,coorddef barrierVec);
int Physics_DoBarrierCheck(Car_tObj *carObj);
void Physics_AutoShift(Car_tObj *carObj);
void Physics_RampCarControlValues(Car_tObj *carObj);
void Physics_FixEngineRpm(Car_tObj *carObj);
void Physics_ResetCar(Car_tObj *carObj);
void Physics_StopCar(Car_tObj *carObj);
void Physics_TestForBarrierCollision(Car_tObj *carObj);
void Physics_CalculateRoadGripModifiers(Car_tObj *carObj);
int Physics_CalculateCarAcceleration(Car_tObj *carObj);
void Physics_CalcWheelLockAcc(Car_tObj *carObj,Physics_tWheelAccStruct *wheel);
void Physics_CalcTractionCircleAcc(Car_tObj *carObj,Physics_tWheelAccStruct *wheel);
void Physics_CalculateTireForces(Car_tObj *carObj,Physics_tWheelAccStruct *wheel);
int Physics_CalculateRSControlDesiredPosition(Car_tObj *carObj,int sliceAhead,int lookAhead);
void Physics_Real(Car_tObj *carObj);
void Physics_SimCar(Car_tObj *carObj);


/* ---- Physics_InitCarSpecs__FP8Car_tObjP10Udff_tInfo  [PHYSICS.CPP:243-281] COVERED-SLD-PASS ---- */
/* Source/SLD receipt: the original root i drives three real table reads.
 * First/second/third initializers249/251/253 and bodies250/252/254,then
 * actual scalar reads255..281 preserve all167 words and i owner0..208.
 * build/nc12/physics_specs_sld_20261028/;literal original text unproved. */
#line 241 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_InitCarSpecs(Car_tObj *carObj,Udff_tInfo *handle)

{
  int i;

  carObj->specs->mass = Udff_GetInt(handle);
  carObj->specs->numGears = Udff_GetInt(handle);
  carObj->specs->gearShiftDelay = Udff_GetInt(handle);
  for (i = 0; i < 8; i++)
    carObj->specs->velToRpmRatio[i] = Udff_GetInt(handle);
  for (i = 0; i < 8; i++)
    carObj->specs->gearEfficiency[i] = Udff_GetInt(handle);
  for (i = 0; i < 41; i++)
    carObj->specs->torqueCurve[i] = Udff_GetInt(handle);
  carObj->specs->redline = Udff_GetInt(handle);
  carObj->specs->maxSpeed = Udff_GetInt(handle);
  carObj->specs->frontDriveRatio = Udff_GetInt(handle);
  carObj->specs->maxBrakeAcc = Udff_GetInt(handle);
  carObj->specs->frontBrakeRatio = Udff_GetInt(handle);
  carObj->specs->wheelBase = Udff_GetInt(handle);
  carObj->specs->frontGripBias = Udff_GetInt(handle);
  carObj->specs->maxSteeringAcc = Udff_GetInt(handle);
  carObj->specs->steeringRamp = Udff_GetInt(handle);
  carObj->specs->lateralGripMult = Udff_GetInt(handle);
  carObj->specs->frontAeroDownForce = Udff_GetInt(handle);
  carObj->specs->rearAeroDownForce = Udff_GetInt(handle);
  carObj->specs->gasOffFactor = Udff_GetInt(handle);
  carObj->specs->gTransferFactor = Udff_GetInt(handle);
  carObj->specs->slideMultiplier = Udff_GetInt(handle);
  carObj->specs->spinVelCap = Udff_GetInt(handle);
  carObj->specs->dampingPitchRate = Udff_GetInt(handle);
  carObj->specs->dampingRollRate = Udff_GetInt(handle);
  carObj->specs->suspensionStiffness = Udff_GetInt(handle);
  carObj->specs->pitchAngularVelCap = Udff_GetInt(handle);
  carObj->specs->rollAngularVelCap = Udff_GetInt(handle);
  carObj->specs->damageFactor = Udff_GetInt(handle);
  carObj->specs->bodyPitchFactor = Udff_GetInt(handle);
  carObj->specs->bodyRollFactor = Udff_GetInt(handle);
  carObj->specs->tireRange = Udff_GetInt(handle);
  carObj->specs->rideOffset = Udff_GetInt(handle);
  carObj->specs->dragFactor = Udff_GetInt(handle);
}

/* ---- Physics_CalculateDerivedCarSpecs__FP8Car_tObj [PHYSICS.CPP:287-406] COVERED-SLD-PASS ---- */
/* Source/SLD receipt (2026-10-28): a real for using the supplied root i
 * replaces the old do/while at324/324. Moving i initialization into that loop
 * is not byte-exact;existing early initialization is preserved. Actual upgrade,
 * gear/division,drag and inertia phases restore all324 word/file tags,header,
 * frame32,provided owners and block/end coordinates without a new device.
 * SOURCE-REVIEW-UNRESOLVED: rpmAtMaxSpeedInHighestGear has a matching NFS2
 * name/calculation but no supplied NFS4 object record. Its original NFS4 name
 * and distinct-object producer are NOT proved. Plain nesting is320 words;
 * word-type/lookup-order controls can be324 but still differ. These negatives
 * do not prove a required capture or a floor. No alias is renamed/hidden.
 * Literal loop/macro/comment text is not uniquely proved.
 * build/nc12/physics_derived_source_20261028/. */
#line 285 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_CalculateDerivedCarSpecs(Car_tObj *carObj)

{
  int i; int rpmAtMaxSpeedInHighestGear; int accAtMaxSpeedInHighestGear;




  i = 0; carObj->specs->redlineInv = 0x10000 / carObj->specs->redline;






  if (carObj->carInfo->WeightTransfer == 1) {

    carObj->specs->steeringRamp = carObj->specs->steeringRamp + 1;

    carObj->specs->maxSteeringAcc = fixedmult(carObj->specs->maxSteeringAcc,0x1147a);
  }




  if (carObj->carInfo->GroundEffects == 1) {

    carObj->specs->steeringRamp = carObj->specs->steeringRamp + 1;
    carObj->specs->frontAeroDownForce = fixedmult(carObj->specs->frontAeroDownForce,0x13333);
    carObj->specs->rearAeroDownForce = fixedmult(carObj->specs->rearAeroDownForce,0x13333);
    carObj->specs->mass = fixedmult(carObj->specs->mass,0xcccc);
    carObj->specs->lateralGripMult = fixedmult(carObj->specs->lateralGripMult,0x11999);
  }




  if (carObj->carInfo->EngineMods == 1) {

    carObj->specs->gearShiftDelay = carObj->specs->gearShiftDelay / 2;
    carObj->specs->maxBrakeAcc = fixedmult(carObj->specs->maxBrakeAcc,0x14000);

    for (; i < 41; i++) carObj->specs->torqueCurve[i] = fixedmult(carObj->specs->torqueCurve[i],0x12666);


    carObj->specs->maxSpeed = fixedmult(carObj->specs->maxSpeed,0x11999);
  }


  for (i = 0; i < carObj->specs->numGears; i++) {





    if (carObj->specs->velToRpmRatio[i] != 0)
      carObj->specs->velToRpmRatioInv[i] = fixeddiv(0x10000,carObj->specs->velToRpmRatio[i]);
    else
      carObj->specs->velToRpmRatioInv[i] = 0x28f;





    carObj->specs->gearAccCoeff[i] = fixeddiv(carObj->specs->velToRpmRatio[i],carObj->specs->mass);
    carObj->specs->gearAccCoeff[i] = fixeddiv(carObj->specs->gearAccCoeff[i],0xa0000);
    carObj->specs->gearAccCoeff[i] = fixedmult(carObj->specs->gearAccCoeff[i],carObj->specs->gearEfficiency[i]);




    carObj->specs->gearVelInv[i] = fixeddiv(0x10000,fixedmult(carObj->specs->velToRpmRatioInv[i],carObj->specs->redline << 16));
  }






  rpmAtMaxSpeedInHighestGear = fixedmult(carObj->specs->maxSpeed,carObj->specs->velToRpmRatio[carObj->specs->numGears - 1]) / 0x10000;

  accAtMaxSpeedInHighestGear = fixedmult(carObj->specs->torqueCurve[rpmAtMaxSpeedInHighestGear / 0x100],carObj->specs->gearAccCoeff[carObj->specs->numGears - 1]);


  carObj->specs->dragCoeff = fixeddiv(accAtMaxSpeedInHighestGear,(carObj->specs->maxSpeed / 0x10000) * (carObj->specs->maxSpeed / 0x10000) * (carObj->specs->maxSpeed / 0x10000));

  if (7 < PHYSICS_TRACK) {

    carObj->specs->gasOffFactor = carObj->specs->gasOffFactor + 0x2666;
    carObj->specs->frontBrakeRatio = carObj->specs->frontBrakeRatio - 0x2666;
    carObj->specs->frontGripBias = carObj->specs->frontGripBias + 0x147;
  }

























  carObj->specs->alphaToAccRotInertia = fixedmult(0x10000,carObj->specs->wheelBase / 2);
  carObj->specs->alphaToAccRotInertia = fixedmult(carObj->specs->alphaToAccRotInertia,0x648);
  carObj->specs->alphaToAccRotInertia <<= 8;
  carObj->specs->accToAlphaRotInertia = fixeddiv(0x10000,carObj->specs->alphaToAccRotInertia);
  carObj->specs->lateralGripMultInv = fixeddiv(0x10000,carObj->specs->lateralGripMult);
}

/* ---- Physics_CheckGamedata__Fv  [PHYSICS.CPP:414-465] COVERED-SLD-PASS ---- */
/* SOURCE-REVIEW-UNRESOLVED: retail has only jr/nop here. Ordinary empty
 * source recovers header414, kept root415 and exit465, not the lost/elided
 * original body text. build/nc12/physics_small_sld_20261028/. */
#line 412 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_CheckGamedata(void)

{


















































}


/* ---- Physics_AttenuateVelocity__FP8Car_tObjiP10matrixtdef [PHYSICS.CPP:591-659] COVERED-SLD-PASS ---- */
/* @0x800A8E7C */
/* Source/SLD receipt (2026-10-28): plain int vx replaces the unnecessary
 * register hint at279/279,with the exact supplied t0 home/type/owner. Actual
 * force-vector,three transform components,position stores,road-frame damping,
 * transpose/reprojection and returned impact phases recover every word/file
 * tag,block/end record and frame96 without new source objects or devices.
 * SOURCE-REVIEW-UNRESOLVED: vy/vz have matching NFS2 names/calculations but
 * no supplied NFS4 object records. Original NFS4 spelling/distinct-object
 * producers are NOT proved by inlining failures. Fresh single/joint inlining
 * controls are294/293/323 words and are not adopted. Keep this review explicit,
 * not a generic carrier exemption or an original-name certification.
 * NFS2's precision,zeroed component and vertical-clamp ordering differences
 * are not imported. Literal original text is unproved.
 * build/nc12/physics_attenuate_source_20261028/. */
#line 589 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
int Physics_AttenuateVelocity(Car_tObj *carObj,int force,matrixtdef *roadMat)

{
  coorddef vel_b;
  int vy; int vx; int vz;
  int absvelbx;
  matrixtdef transposeMat;




  vel_b.x = force;
  vel_b.y = 0;
  vel_b.z = 0;





  vx = (vel_b.x / 0x100) * (roadMat->m[0] / 0x100) + (vel_b.y / 0x100) * (roadMat->m[1] / 0x100) + (vel_b.z / 0x100) * (roadMat->m[2] / 0x100);
  vy = (vel_b.x / 0x100) * (roadMat->m[3] / 0x100) + (vel_b.y / 0x100) * (roadMat->m[4] / 0x100) + (vel_b.z / 0x100) * (roadMat->m[5] / 0x100);
  vz = (vel_b.x / 0x100) * (roadMat->m[6] / 0x100) + (vel_b.y / 0x100) * (roadMat->m[7] / 0x100) + (vel_b.z / 0x100) * (roadMat->m[8] / 0x100);

  carObj->N.position.x -= vx;
  carObj->N.position.y += vy;
  carObj->N.position.z += vz;




  vel_b.x = -((carObj->N.linearVel.x / 0x100) * (roadMat->m[0] / 0x100) + (carObj->N.linearVel.y / 0x100) * (roadMat->m[1] / 0x100) + (carObj->N.linearVel.z / 0x100) * (roadMat->m[2] / 0x100));
  vel_b.z = (carObj->N.linearVel.x / 0x100) * (roadMat->m[6] / 0x100) + (carObj->N.linearVel.y / 0x100) * (roadMat->m[7] / 0x100) + (carObj->N.linearVel.z / 0x100) * (roadMat->m[8] / 0x100);
  absvelbx = ((0 <= vel_b.x) ? vel_b.x : -vel_b.x) >> 1;
  vel_b.x = 0;




  if (0 < vel_b.z) {

    if (0x50000 < vel_b.z) {

      vel_b.z -= (absvelbx / 0x100) * 0xc0;

      if (vel_b.z < 0)
        vel_b.z = 0;
    }
  }

  else {
    if (vel_b.z < -0x50000) {

      vel_b.z += (absvelbx / 0x100) * 0xc0;

      if (0 < vel_b.z)
        vel_b.z = 0;
    }
  }

  transpose(roadMat,&transposeMat);
  carObj->N.linearVel.x = fixedmult(vel_b.x,transposeMat.m[0]) + fixedmult(vel_b.y,transposeMat.m[1]) + fixedmult(vel_b.z,transposeMat.m[2]);
  carObj->N.linearVel.z = fixedmult(vel_b.x,transposeMat.m[6]) + fixedmult(vel_b.y,transposeMat.m[7]) + fixedmult(vel_b.z,transposeMat.m[8]);
  if (0 < carObj->N.linearVel.y)
    carObj->N.linearVel.y = 0;

  carObj->linearVel_ch.x = fixedmult(carObj->N.linearVel.x,carObj->N.orientMat.m[0]) + fixedmult(carObj->N.linearVel.y,carObj->N.orientMat.m[1]) + fixedmult(carObj->N.linearVel.z,carObj->N.orientMat.m[2]);
  carObj->linearVel_ch.y = fixedmult(carObj->N.linearVel.x,carObj->N.orientMat.m[3]) + fixedmult(carObj->N.linearVel.y,carObj->N.orientMat.m[4]) + fixedmult(carObj->N.linearVel.z,carObj->N.orientMat.m[5]);
  carObj->linearVel_ch.z = fixedmult(carObj->N.linearVel.x,carObj->N.orientMat.m[6]) + fixedmult(carObj->N.linearVel.y,carObj->N.orientMat.m[7]) + fixedmult(carObj->N.linearVel.z,carObj->N.orientMat.m[8]);
  carObj->N.speedXZ = (__builtin_abs(carObj->N.linearVel.x) > __builtin_abs(carObj->N.linearVel.z)) ? __builtin_abs(carObj->N.linearVel.x) + (__builtin_abs(carObj->N.linearVel.z) >> 2) : __builtin_abs(carObj->N.linearVel.z) + (__builtin_abs(carObj->N.linearVel.x) >> 2);

  return absvelbx;
}

/* ---- Physics_SetCurrentWallType__Fi  [PHYSICS.CPP:665-666] COVERED-SLD-PASS ---- */
#line 663 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_SetCurrentWallType(int wallType)

{
  currentWallType = wallType;
}

/* ---- Physics_GetTorque__FP8Car_tObji  [PHYSICS.CPP:672-674] COVERED-SLD-PASS ---- */
/* Canonical MAX/MIN spelling is independently present in matched NFS2 PC
 * source. Retail NFS4 confirms all15 words and the673 clamp/674 lookup split. */
#line 670 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
int Physics_GetTorque(Car_tObj *carObj,int index)

{
  index = MAX(MIN(index,40),0);
  return carObj->specs->torqueCurve[index];
}

/* ---- Physics_CorrectPostCollisionYaw__FP8Car_tObjiG8coorddef [PHYSICS.CPP:680-721] COVERED-SLD-PASS ---- */
/* MATCH/source receipt (2026-10-28): canonical MIN of the two absolute
 * components, followed by the real half shift, preserves all102 instructions
 * without the old empty assembly scheduling fence. Direct fence deletion from
 * the old per-arm-shift expression still differs; that was source-shape-specific,
 * not proof a barrier belonged to retail source. Real impulse/sfx/otherObj
 * order and separate speed/steering guards recover all instruction/file tags,
 * supplied locals/owners,block lines and end721. Literal macro/comment spelling
 * is not uniquely proved. build/nc12/physics_yaw_source_20261028/. */
#line 678 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_CorrectPostCollisionYaw(Car_tObj *carObj,int impactVel,coorddef barrierVec)

{
  int diffZ; int diffX; int result;

  carObj->N.collision.impulse = impactVel * 6;
  carObj->N.collision.sfxType = currentWallType | 0x40000;
  carObj->N.collision.otherObj = 0;




  if ((impactVel < 0xf0000) || (carObj->linearVel_ch.z < 0x140000)) {




    diffZ = fixedmult(barrierVec.x,carObj->N.shadowMat.m[6]) + fixedmult(barrierVec.y,carObj->N.shadowMat.m[7]) + fixedmult(barrierVec.z,carObj->N.shadowMat.m[8]);
    diffX = fixedmult(barrierVec.x,carObj->N.shadowMat.m[0]) + fixedmult(barrierVec.y,carObj->N.shadowMat.m[1]) + fixedmult(barrierVec.z,carObj->N.shadowMat.m[2]);
    result = MIN(__builtin_abs(diffZ),__builtin_abs(diffX)) >> 1;

    if (diffZ < 0) {


      if (diffX < 0)
        result = -result;
    }


    else {
      if (0 < diffX)
        result = -result;
      result >>= 1;
    }


    if (0xd6666 < carObj->linearVel_ch.z) {


      if (((0 < result) && (0 < carObj->control.steering)) || ((result < 0) && (carObj->control.steering < 0)))
        result >>= 2;
    }

    carObj->N.angularVel.y = result; }
}

/* ---- Physics_DoBarrierCheck__FP8Car_tObj [PHYSICS.CPP:761-932] COVERED-SLD-PASS ---- */
/* Source/SLD receipt (2026-10-29): supplied r1/r2/r3 own the right-vector
 * coefficients, then the center/position/shifted-velocity work. Their genuine
 * reuse naturally requires the later right-vector reloads. Direct x1/x2/x3
 * products remove13 unprovided captures and all12 empty assembly templates;
 * nine native EXTRA records disappear,all23 supplied tuples agree.
 * Ordinary source layout and the real post-plane return recover all358
 * instruction/file tags,ten block records,frame120 and end932. The first
 * r-local region optimizes to zero length;do not fabricate an empty scope.
 * Earlier separate-capture/fence necessity claims are superseded on this graph.
 * NFS2 and the mobile twin support the broad phases,not NFS4's exact names
 * or literal text. Retail uses arithmetic velocity shifts and passes normal
 * uninitialized in the low-altitude else arm;do not import the mobile fix.
 * Literal original macro/comment spelling is not uniquely established.
 * Receipt:build/nc12/physics_barrier_source_20261029/final-proof.json. */
#line 759 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
int Physics_DoBarrierCheck(Car_tObj *carObj)

{
  int diff = 0;
  int carCollisionWidth;
  int x_relRoad;
  int wallType;

  int collide = diff;
  coorddef vel_b;
  coorddef right;
  coorddef normal;
  int slice = (carObj->N).simRoadInfo.slice;



  {
    int r1; int r2; int r3;
    r1 = ((int)(signed char)PHYSICS_SLICE_RIGHT(slice,0)) << 9;
    r2 = ((int)(signed char)PHYSICS_SLICE_RIGHT(slice,1)) << 9;
    r3 = ((int)(signed char)PHYSICS_SLICE_RIGHT(slice,2)) << 9;
    right.x = r1;
    right.y = r2;
    right.z = r3;

    r3 = PHYSICS_SLICE_CENTER(slice,0);
    r1 = (carObj->N).position.x;
    r2 = (carObj->N).linearVel.x >> 5;
    vel_b.x = r1 + r2 - r3;

    r3 = PHYSICS_SLICE_CENTER(slice,1);
    r1 = (carObj->N).position.y;
    r2 = (carObj->N).linearVel.y >> 5;
    vel_b.y = r1 + r2 - r3;

    r3 = PHYSICS_SLICE_CENTER(slice,2);
    r1 = (carObj->N).position.z;
    r2 = (carObj->N).linearVel.z >> 5;
    vel_b.z = r1 + r2 - r3;
  }
  {
    int x1; int x2; int x3;
    x1 = (right.x / 256) * (vel_b.x / 256);
    x2 = (right.y / 256) * (vel_b.y / 256);
    x3 = (right.z / 256) * (vel_b.z / 256);
    x_relRoad = x1 + x2 + x3;
    (carObj->N).xRelRoadCenter = x_relRoad;
  }
  {
    int r1; int r2; int r3; int x1; int x2; int x3;



    r1 = (carObj->N).orientMat.m[6];
    r2 = (carObj->N).orientMat.m[7];
    r3 = (carObj->N).orientMat.m[8];
    x1 = r1 / 0x100 * (right.x / 0x100);
    x2 = r2 / 0x100 * (right.y / 0x100);
    x3 = r3 / 0x100 * (right.z / 0x100);
    carCollisionWidth = (0 < fixedmult((carObj->N).dimension.z,x1 + x2 + x3)) ? fixedmult((carObj->N).dimension.z,x1 + x2 + x3) : -fixedmult((carObj->N).dimension.z,x1 + x2 + x3);

    r1 = (carObj->N).orientMat.m[0];
    r2 = (carObj->N).orientMat.m[1];
    r3 = (carObj->N).orientMat.m[2];
    x1 = r1 / 0x100 * (right.x / 0x100);
    x2 = r2 / 0x100 * (right.y / 0x100);
    x3 = r3 / 0x100 * (right.z / 0x100);
    carCollisionWidth += (0 < ((carObj->N).dimension.x / 0x100 * ((x1 + x2 + x3) / 0x100))) ? ((carObj->N).dimension.x / 0x100 * ((x1 + x2 + x3) / 0x100)) : -((carObj->N).dimension.x / 0x100 * ((x1 + x2 + x3) / 0x100));
  }



















  if (x_relRoad < carCollisionWidth - PHYSICS_SLICE_LEFT_DRIVE(slice) * 0x100 - carObj->extraWallCollisionAllowance) {




    collide = -1;
    diff = carCollisionWidth - PHYSICS_SLICE_LEFT_DRIVE(slice) * 0x100 - x_relRoad;
    wallType = 1; currentWallType = wallType;
  }



  if (PHYSICS_SLICE_RIGHT_DRIVE(slice) * 0x100 - carCollisionWidth + carObj->extraWallCollisionAllowance < x_relRoad) {




    collide = 1;
    diff = x_relRoad - (PHYSICS_SLICE_RIGHT_DRIVE(slice) * 0x100 - carCollisionWidth);
    wallType = 1; currentWallType = wallType;
  }



  if (collide == 0) return 0;



  if (Force_IsForceOn(carObj) != 0) {
    Force_HitWall(0x1e0000);
  }




  {
    coorddef widthVector;
    widthVector.x = ((carObj->N).dimension.x / 0x100 * right.x) / 0x100; widthVector.y = ((carObj->N).dimension.x / 0x100 * right.y) / 0x100; widthVector.z = ((carObj->N).dimension.x / 0x100 * right.z) / 0x100;
    if (0 < collide) {
      (carObj->N).collision.collisionPoint.x = (carObj->N).position.x + widthVector.x; (carObj->N).collision.collisionPoint.y = (carObj->N).position.y + widthVector.y; (carObj->N).collision.collisionPoint.z = (carObj->N).position.z + widthVector.z;
    } else {
      (carObj->N).collision.collisionPoint.x = (carObj->N).position.x - widthVector.x; (carObj->N).collision.collisionPoint.y = (carObj->N).position.y - widthVector.y; (carObj->N).collision.collisionPoint.z = (carObj->N).position.z - widthVector.z;
    } }






  if (((carObj->N).objAltitude >= 0x999a) || ((carObj->N).orientationToGround.y <= 0xe665) || ((carObj->N).flightTime != 0)) {

    if (collide < 0) {

      normal.x = right.x;
      normal.y = right.y;
      normal.z = right.z;
    }
    else {

      normal.x = -right.x;
      normal.y = -right.y;
      normal.z = -right.z;
    }

    Collide_TestWithPlane(&carObj->N,&normal,&(carObj->N).position);

    if ((carObj->N).collision.impulse != 0) {

      (carObj->N).collision.sfxType = currentWallType | 0x40000;
      (carObj->N).collision.otherObj = (BO_tNewtonObj *)0x0;
    }

    return collide;

  } else {



    wallType = Physics_AttenuateVelocity(carObj,collide * __builtin_abs(diff * 2),&(carObj->N).roadMatrix);




    Physics_CorrectPostCollisionYaw(carObj,wallType,normal);
  }
  return collide;
}

/* ---- Physics_AutoShift__FP8Car_tObj [PHYSICS.CPP:938-1038] COVERED-SLD-PASS ---- */
/* Source/SLD receipt (2026-10-28): the actual high-speed limit call/test
 * replaces previousRpm's early unrelated assignment without a new object.
 * Call-first comparison preserves175 words;field-first is174 and rejected.
 * Keep the supplied velocity region and real shift/field phases. Separate
 * coast guards and implicit exit recover every instruction/file tag,header,
 * frame56,owner tuple and block/end line. The declaration-free wrapper is
 * unnecessary and removed. Retail retains the unused next-gear fixedmult
 * call;NFS2's additional local names are not NFS4 declaration evidence.
 * Literal original macros/comments remain unproved.
 * build/nc12/physics_autoshift_source_20261028/.
 * Receipts below describe HISTORICAL source basins,not current differences. */
/* RECEIPT (w59-a2): 73 -> 50, ours 168 -> 173 (oracle 175).  TWO landings:
   (1) ** FIELD-TO-FIELD `lastGear = gear` INSTEAD OF A `char oldGear` LOCAL (73->51,
       +6 insns).  A `char` LOCAL is PROMOTE_MODE'd to SImode, so `char oldGear =
       (carObj->control).gear;` produces the SAME rtx `(zero_extend:SI (mem:QI))` as
       the `(u_char)gear` guard right above it -- cse merges them, the arm reuses the
       guard's register, and the specs pointer is then free to land in the same reg in
       every arm, so gcc CROSS-JUMPS the shared 3-insn tail
       (`lbu v0,8(specs); nop; sb v0,1092(s0)`) out of BOTH shift arms.  Retail keeps
       each arm's tail (09J "each arm carries its own tail").  Writing the direct
       QImode field copy `(carObj->control).lastGear = (carObj->control).gear;`
       (placed BEFORE the `gear = ...` store) emits a FRESH `lbu` into the arm, which
       pushes the specs pointer to a different register per arm => cross_jump can no
       longer merge => both tails come back.  GENERAL RULE: a `char`/`short` LOCAL
       used only to copy one byte field into another is a cse-merger; spell the
       field-to-field copy directly when retail re-reads.
   (2) `previousGear = nextGear;` (one shared `lbu` for both gear locals) 51->50.
   FALSIFIED (each gated): chained `previousGear = nextGear = (u_char)gear` 55@170;
   `previousGear = nextGear` placed AFTER the nextGear guard 50 but SEMANTICALLY WRONG
   (drops the pre-increment value) -- do not adopt; block-local
   `int lastGearOffset = SkipLastGear + 1;` at the SECOND numGears site 60@173 (the new
   pseudo re-colours the whole head, s6->s1); `numGears - SkipLastGear - 1` spelling 51
   (neutral, kept for readability); `if (2 < (u_char)gear)` guard 51 (adds a redundant
   `andi ...,255` because the shared value lives in previousGear's own reg); explicit
   `int curGear` temp + copies to both 55@170.
   ---- w59-a2 ROUND 2, after the W59-A11 mobile-twin brief (50 -> 20, count now
   EXACT 175/175).  THREE MORE LANDINGS, all from `scratchpad/w59a11/
   Physics_AutoShift_twin.md` (mobile sub_504DDF):
   (3) ** NO `previousRpm` CACHE (twin A1) -- 50 -> 46 AND count 173 -> 175 EXACT.
       `carObj->specs->redline` is RE-READ at each of its three uses (ShiftPoint,
       the RS ShiftPoint variant, and the `<< 0x10` fixedmult arg) instead of being
       parked in `previousRpm`.  Pure 3.12 #1: the cache invited gcc to CSE-hoist the
       `specs` load for the whole body; retail rematerialises it.  This ALSO restored
       the duplicated `sra <rD>,v1,16` that reorg copies into the `/0x10000` bgez
       delay slot (previously listed as residual (c) below) -- with the cache gone the
       call result gets its own temp and the shift no longer writes the branch's own
       condition register (09L).
   (4) nextGear/previousGear as SELECT-INTO-FRESH from `control.gear` (twin A3):
       `if (gear >= numGears - SkipLastGear - 1) nextGear = gear; else nextGear =
       gear + 1;` and `if (gear <= 2) previousGear = gear; else previousGear =
       gear - 1;`.  Score-neutral at 46 BUT structurally exact: it produces retail's
       `addu s3,rG,zero / addiu s3,s3,1 / sltiu v0,rG,3 / addu s2,rG,zero /
       addiu s2,rG,-1` and, crucially, the UNSIGNED `sltiu` (the `<= 2` compare now
       reads the zero-extended lbu value directly, so combine canonicalises signed->
       unsigned).  Keep it -- it is the enabler for (5).
   (5) fn-scope `int lastGearOffset;` assigned `SkipLastGear + 1` immediately BEFORE
       the nextGear select, used as `numGears - lastGearOffset` there: 46 -> 20.
       (In the pre-(3) basin this same local cost +10 -- 04Z basin-relativity, 10th
       confirmation.  A block-scope local, a parenthesised `- (SkipLastGear + 1)`, and
       a Yoda'd bound are all NEUTRAL at 46; only the fn-scope local lands.)
   FALSIFIED IN ROUND 2 (each gated, do not retry):
     - twin A2 "flat 3-way if / else-if / else with the upshift as the FALL-THROUGH
       arm" (coast first, `wheelRpm <= ShiftPoint+500 || gear >= numGears-1-Skip` as
       the else-if, upshift last, no early return): **109** on its own and **121**
       paired with A1+A3.  The mobile's arm order is an Ideaworks port artifact --
       our nested-if + early-return block order IS the PSX oracle's.
     - re-assigning `lastGearOffset = SkipLastGear + 1;` a SECOND time before the
       upshift guard (to mimic retail's second `addiu v1,s6,1`): 28.
     - using the already-live `lastGearOffset` at the upshift guard: 47 @174.
   RESIDUAL 20 = (i) the shared gear temp lives in previousGear's own callee-saved reg
   (ours `lbu v1`) where retail uses a fresh caller-saved `lbu a0`; (ii) previousRpm
   colours a0 vs retail's a1 (SYM $5) in the three `slt vN,<rpm>,s5` guards; (iii) the
   `carObj->specs` pointer a0-vs-a1 + retail's third re-read at the velToRpmRatio site;
   (iv) the SECOND `numGears - SkipLastGear - 1` still folds to `subu;addiu -1` where
   retail keeps `addiu v1,s6,1; subu`.
   ---- (stale, kept for the record) RESIDUAL 50 = (a) retail reads gear into a FRESH caller-saved temp (`lbu a0`) and
   copies it into BOTH s3/s2 in their branch delay slots, ours loads straight into s2
   and copies s3=s2 (=> `slti` where retail's zero-extended temp lets combine pick
   `sltiu`); (b) the specs pointer a0-vs-a1 + retail's third re-read of
   `carObj->specs` at the velToRpmRatio site (ours keeps the cse'd a0); (c) the
   `previousRpm = fixedmult(...)/0x10000` divide: retail keeps the call result in its
   own temp v1 and DUPLICATES `sra a1,v1,16` into the bgez delay slot (reorg
   fill_slots_from_thread), ours coalesces the temp with previousRpm so the sra writes
   the branch's own condition register and 09L forbids the fill. */
/* MATCH (W60-A9, 20 -> PASS 175/175): the w45 FOLD-REWRITE ESCAPE.  Retail
         * computes `SkipLastGear + 1` as its OWN insn in the beqz delay slot
         * (`addiu $v1,$s6,1`) and subtracts it; every natural spelling of
         * `numGears - SkipLastGear - 1` (incl. the parenthesised
         * `numGears - (SkipLastGear + 1)` and `- (1 + SkipLastGear)`) is
         * reassociated by fold() to `(numGears - SkipLastGear) - 1` = ours'
         * `subu;addiu -1` pair (20 diffs).  Writing the sum NEGATED FIRST takes
         * split_tree's varsign=-1 branch, whose rewrite fold never re-folds, so the
           * `addiu +1` survives.  The same direct spelling now replaces the earlier
           * unrecorded lastGearOffset snapshot (2026-09-28, 175/175 PASS).
           * Sharing one snapshot across the guards was 47 diffs.  `move_term`
         * (`gear + SkipLastGear + 1 < numGears`) = 23. */
#line 936 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_AutoShift(Car_tObj *carObj)

{
  int wheelRpm; int previousRpm; int previousGear; int nextGear;
  int SkipLastGear; int ShiftPoint; int sliding;



  SkipLastGear = 0;
  ShiftPoint = carObj->specs->redline - carObj->specs->redline / 6;




  if ((u_char)carObj->control.gear <= 1) return;


  if (carObj->RSControl != 0)
    ShiftPoint = carObj->specs->redline - carObj->specs->redline / 2;

  sliding = (0 <= carObj->slide) ? carObj->slide : -carObj->slide;



  if (fixedmult(carObj->specs->velToRpmRatioInv[carObj->specs->numGears - 2],carObj->specs->redline << 0x10) > carObj->specs->maxSpeed)
    SkipLastGear = 1;










  if ((u_char)carObj->control.gear >= -(SkipLastGear + 1) + carObj->specs->numGears) nextGear = (u_char)carObj->control.gear;
  else nextGear = (u_char)carObj->control.gear + 1;




  if ((u_char)carObj->control.gear <= 2) previousGear = (u_char)carObj->control.gear;
  else previousGear = (u_char)carObj->control.gear - 1;




  {
    int velocity = carObj->N.speedXZ;
    if (carObj->linearVel_ch.z < 0)
      velocity = -velocity;


    wheelRpm = fixedmult(velocity,carObj->specs->velToRpmRatio[(u_char)carObj->control.gear]) / 0x10000;
    fixedmult(velocity,carObj->specs->velToRpmRatio[nextGear]);
    previousRpm = fixedmult(velocity,carObj->specs->velToRpmRatio[previousGear]) / 0x10000;
  }

  if ((0x8000 < gGasRatio) || (carObj->specs->redline < ((0 <= wheelRpm) ? wheelRpm : -wheelRpm))) {


    if ((ShiftPoint + 500 < wheelRpm) && ((u_char)carObj->control.gear < -(SkipLastGear + 1) + carObj->specs->numGears)) {

      if (nextGear != (u_char)carObj->control.gear) {

        carObj->control.downShifting = '\0';
        carObj->control.lastGear = carObj->control.gear;
        carObj->control.gear = (char)nextGear;
        carObj->control.gearShiftTimer = (char)carObj->specs->gearShiftDelay; } return;



    }



    if ((previousRpm < ShiftPoint) && (previousGear != (u_char)carObj->control.gear)) {

      carObj->control.downShifting = '\x01';
      carObj->control.lastGear = carObj->control.gear;
      carObj->control.gear = (char)previousGear;
      carObj->control.gearShiftTimer = (char)carObj->specs->gearShiftDelay;
    }
  }





  else if ((previousRpm < ShiftPoint) && (1 < previousGear) && (sliding < 0x1999)) {

    if (previousGear != (u_char)carObj->control.gear) {

      carObj->control.downShifting = '\x01';
      carObj->control.gear = (char)previousGear;
      carObj->control.gearShiftTimer = (char)carObj->specs->gearShiftDelay;
    } }




}

/* SOURCE REVIEW (2026-10-13): retail brake region has outer+140..+1a4
 * and inner+158..+198 (SLD1099/1103/1110/1115),without named locals there.
 * Whole conditional GNU expression502PASS emits only the outer; expression
 * as true arm502PASS emits an extra inner and ends+190,not+198. Both reverted.
 * Do not pad scopes or add a dummy name to clean the report. Actual original
 * producer/source spelling remains unresolved,not a source floor.
 */
/* ---- Physics_RampCarControlValues__FP8Car_tObj [PHYSICS.CPP:1044-1278] WORD-SLD-EXACT; REGIONS OPEN ---- */
/* Known-coordinate receipt (2026-10-28):all502 instruction/file tags,end1278
 * and every PRESENT region coordinate agree at unchanged code/locals.
 * SOURCE-REVIEW-UNRESOLVED:two empty brake regions are still missing and
 * rampIn therefore retains its wrong owner path. No new increment declaration
 * or inferred helper is introduced just to clean that audit. A private used
 * non-const increment/MIN model matches bytes and all region addresses,but
 * both char and int work and retail supplies no name/type. User chose diagnostic-only;
 * no inferred declaration is authorized. No original-name/necessity/floor claim follows.
 * The header's Transmission proxy remains separately unresolved;only a full
 * true-owner type view matched code,with extra type-copy parity still open.
 * build/nc12/physics_ramp_source_20261028/ and physics_transmission_source_20261028/. */
/* MATCH: __builtin_abs INLINE in the shift expression (27->14).  The hand-rolled
     `if (x<0) x = -x;` lets gcc speculate the `sll` into the bgez delay slot AND
     re-emit it after the negu (two slls); the builtin's bgez/negu/sll idiom is
     retail's.  Routing it through a separate temp first only reaches 22/26 -- the operand
     must be the field read itself (methodology 5.0c __builtin_abs lever). */
#line 1042 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_RampCarControlValues(Car_tObj *carObj)

{
  int i; int diff; int gear;












  if ((carObj->RSControl != 0) && ((u_char)(carObj->control).gear < 2)) {

    carObj->control.desiredGear = '\x02';
    carObj->control.gear = '\x02';
  }




  if (1 < (carObj->stats).finishType)
  {
    carObj->control.steering = 0;
    carObj->control.gasLevel = '\0';
    carObj->control.brakeLevel = -1;
    carObj->control.downShifting = '\0';
    carObj->control.hanno = 0;


    carObj->N.linearVel.x = carObj->N.linearVel.x * 0xfe / 0x100; carObj->N.linearVel.y = carObj->N.linearVel.y * 0xfe / 0x100; carObj->N.linearVel.z = carObj->N.linearVel.z * 0xfe / 0x100;
  }

  else {



    {
      char inc;

      if (carObj->carInfo->RampGas != 0)
        inc = 0x24;
      else inc = 0x30;
      diff = carObj->control.desiredGasLevel - carObj->control.gasLevel;
      if (diff >= 0)
        carObj->control.gasLevel += MIN(inc,diff);
      else
        carObj->control.gasLevel -= MIN(inc,-diff);
    }




    if (carObj->carInfo->RampBrake != 0) {



      diff = carObj->control.desiredBrakeLevel - carObj->control.brakeLevel;
      if (diff >= 0) {
        if (diff < 0x10) carObj->control.brakeLevel += diff; else carObj->control.brakeLevel += 0x10;
      } else {
        diff = -diff; if (diff < 0x10) carObj->control.brakeLevel -= diff; else carObj->control.brakeLevel -= 0x10;
      }
    } else
      carObj->control.brakeLevel = carObj->control.desiredBrakeLevel;




    if ((carObj->control).gearShiftTimer > 0)
      carObj->control.gearShiftTimer--;

    if (0x200 < PHYSICS_GAME_TICKS) {

      if (PHYSICS_TRANSMISSION_AT(carObj->carIndex) == 1) {


        if ((PHYSICS_GAME_TICKS < 0x208) && (((PHYSICS_RACE_TYPE != RaceType_HotPursuit && (PHYSICS_RACE_TYPE != RaceType_Id5)) || (((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0 && ((Cars_gNumHumanRaceCars != 2 || ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0)))) ))))

          carObj->control.desiredGear = '\x02';

        else {

          if (((carObj->control).desiredGear == (carObj->control).gear) && ((carObj->stats).finishType == 0)) {



            if ((carObj->pullOver == 0) && (carObj->blowout == 0)) {







              if ((((carObj->N).speedXZ < 0) ? -(carObj->N).speedXZ : (carObj->N).speedXZ) < 0x3333) { if (((u_char)(carObj->control).desiredBrakeLevel > 0x80) && ((carObj->control).desiredGasLevel == '\0') && ((u_char)(carObj->control).desiredGear >= 2) && ((carObj->control).hanno == 0)) {

                carObj->control.desiredGear = '\0';
                carObj->control.hanno = 1;
              } else {




                if ((((((carObj->N).speedXZ < 0) ? -(carObj->N).speedXZ : (carObj->N).speedXZ) < 0x3333) && (0x80 < (u_char)(carObj->control).desiredGasLevel)) && (((carObj->control).gear == '\0' && ((carObj->control).hanno != 0)))) {

                  carObj->control.desiredGear = '\x02';
                  carObj->control.hanno = 0; } } } } } else carObj->control.hanno = 0; }





      } if ((carObj->control).desiredGear != (carObj->control).gear) {


        if ((PHYSICS_TRANSMISSION_AT(carObj->carIndex) == 1) || (carObj->RSControl != 0)) {


          if ((u_char)(carObj->control).desiredGear < 2) {



            carObj->control.downShifting = '\0';
            carObj->control.lastGear = carObj->control.gear;
            carObj->control.gear = carObj->control.desiredGear;
            carObj->control.gearShiftTimer = (char)carObj->specs->gearShiftDelay;
          }

          else if (((carObj->control).desiredGear == 2) && ((u_char)(carObj->control).gear < 2)) {



            carObj->control.lastGear = carObj->control.gear;

            gear = 2;
            for (i = 2; i < carObj->specs->numGears; i++) {

              if (fixedmult(carObj->specs->velToRpmRatioInv[i], carObj->specs->redline << 0x10) < (carObj->linearVel_ch).z)
                gear = i;
            }

            carObj->control.downShifting = '\0';
            carObj->control.gear = gear;
            carObj->control.gearShiftTimer = (char)carObj->specs->gearShiftDelay;
          }
        } else {




          if (((u_char)(carObj->control).desiredGear < (u_char)(carObj->control).gear) && (1 < (u_char)(carObj->control).desiredGear))
            carObj->control.downShifting = '\x01';
          else
            carObj->control.downShifting = '\0';
          carObj->control.lastGear = carObj->control.gear;
          carObj->control.gear = carObj->control.desiredGear;
          carObj->control.gearShiftTimer = (char)carObj->specs->gearShiftDelay;
        }
      }
    }




    if (carObj->carInfo->RampSteering != 0)
    {
      int rampIn = carObj->specs->steeringRamp;

      diff = carObj->control.desiredSteering - carObj->control.steering;
      if (diff >= 0)
        carObj->control.steering += MIN(rampIn,diff);
      else
        carObj->control.steering -= MIN(rampIn,-diff);
    }
    else
      carObj->control.steering = carObj->control.desiredSteering;
  }




  if ((PHYSICS_GAME_TICKS < 0x200) && (((PHYSICS_RACE_TYPE != RaceType_HotPursuit && (PHYSICS_RACE_TYPE != RaceType_Id5)) || (((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0 && ((Cars_gNumHumanRaceCars != 2 || ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0))))))))

    carObj->control.brakeLevel = -1;




  else if ((carObj->blowout != 0) || (carObj->pullOver != 0)) {

    if ((carObj->control).hanno != 0) {

      carObj->control.gasLevel = -0x80;
      carObj->control.brakeLevel = '\0';
    } else {


      carObj->control.gasLevel = '\0';
      carObj->control.brakeLevel = -0x80;
    }
    carObj->control.downShifting = '\0';
  }




  if (carObj->crash == 2)
    carObj->control.gasLevel = '\0';

  if ((AIInit_forceHumanHandBrake != 0) && (carObj->RSControl != 0)) {

    if (carObj->roadPosition * carObj->direction > 0) carObj->control.steering = -0x7c;


    else carObj->control.steering = 0x7c;
    carObj->control.handBrake = '\x01';
  }




  diff = (((u_char)carObj->control.gasLevel + 1) * 0x10000) / 0xf8; if (0x10000 < diff) diff = 0x10000; gGasRatio = diff;
  diff = (((u_char)carObj->control.brakeLevel + 1) * 0x10000) / 0xf8; if (0x10000 < diff) diff = 0x10000; gBrakeRatio = diff;
  gSteerRatio = __builtin_abs(carObj->control.steering) << 9;


  if (PHYSICS_TRANSMISSION_AT(carObj->carIndex) == 1) {

    if ((carObj->control.gear == '\0') && (carObj->control.hanno == 1)) {

    diff = (((u_char)carObj->control.brakeLevel + 1) * 0x10000) / 0xf8; if (0x10000 < diff) diff = 0x10000; gGasRatio = diff;
    diff = (((u_char)carObj->control.gasLevel + 1) * 0x10000) / 0xf8; if (0x10000 < diff) diff = 0x10000; gBrakeRatio = diff; } }
}

/* ---- Physics_FixEngineRpm__FP8Car_tObj [PHYSICS.CPP:1287-1307; COVERED-SYM-SLD-PASS] ---- */
/* @0x800AA4E4
 * 2026-10-29: two actual X/Z dot products and resets need no transformedZ,
 * fake one-shot loops,asm,volatile,qualifier or reference device. The inherited
 * contradictory gear/RPM branch is independently present in matched NFS2 C
 * AND its original Ghidra dump;stock GCC removes its unreachable work here.
 * All86 words,the sole carObj record,root region and every SLD tag match.
 * SOURCE-REVIEW-UNRESOLVED: exact presence/spelling of this unexecuted source
 * path in lost NFS4 text is inferred,not uniquely proved by the retail image.
 * No arbitrary always-false predicate was invented to imitate loop depth.
 * Receipt:build/nc12/physics_rpm_native_source_20261029/final-proof.json. */
#line 1285 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_FixEngineRpm(Car_tObj *carObj)

{

  carObj->linearVel_ch.x = (carObj->N.linearVel.x / 256) * (carObj->N.shadowMat.m[0] / 256) + (carObj->N.linearVel.y / 256) * (carObj->N.shadowMat.m[1] / 256) + (carObj->N.linearVel.z / 256) * (carObj->N.shadowMat.m[2] / 256);
  carObj->linearVel_ch.z = (carObj->N.linearVel.x / 256) * (carObj->N.shadowMat.m[6] / 256) + (carObj->N.linearVel.y / 256) * (carObj->N.shadowMat.m[7] / 256) + (carObj->N.linearVel.z / 256) * (carObj->N.shadowMat.m[8] / 256);

  if (((__builtin_abs(carObj->linearVel_ch.z) >= 0x10000) || (carObj->control.gear != 2)) && (carObj->control.gear == 1)) {

    if (carObj->control.gear != 1)

      carObj->flywheelRpm = ((carObj->linearVel_ch.z / 256) * (carObj->specs->gearVelInv[carObj->control.gear] / 256)) * carObj->specs->redline / 0x10000;
  }


  carObj->wheelSpin = 0;
  carObj->slide = 0;
  carObj->frontSkid = 0;
  carObj->rearSkid = 0;


  if (carObj->N.collision.collided == 2)
    carObj->N.collision.collided = 0; }
#line 1309 "C:/nfs4/GAME/COMMON/PHYSICS.CPP" /* preserve unchanged following-function coordinates */

/* ---- Physics_ResetCar__FP8Car_tObj  [PHYSICS.CPP:1313-1358] COVERED-SLD-PASS ---- */
/* Source/SLD receipt: transmission arm stores,vector/component reset phases
 * and the real for-owned i retain all39 words and complete retail owners.
 * The enclosing/for endpoint is1359;actual loop backedge/end source1358.
 * No dummy region or local is added. Use brace-aware slicing for this body. */
#line 1311 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_ResetCar(Car_tObj *carObj)

{

  if (carObj->carInfo->Transmission == 1) {

    carObj->control.desiredGear = '\x02';
    carObj->control.gear = '\x02';
  } else {


    carObj->control.desiredGear = '\x01';
    carObj->control.gear = '\x01';
  }


  carObj->linearAcc.x = 0;
  carObj->linearAcc.y = 0;
  carObj->linearAcc.z = 0;

  carObj->angularAcc.x = 0;
  carObj->angularAcc.y = 0;
  carObj->angularAcc.z = 0;


  carObj->linearVel_ch.x = 0;
  carObj->linearVel_ch.y = 0;
  carObj->linearVel_ch.z = 0;

  carObj->angularVel_ch.x = 0;
  carObj->angularVel_ch.y = 0;
  carObj->angularVel_ch.z = 0;


  carObj->wheelSpin = 0;
  carObj->slide = 0;
  carObj->frontSkid = 0;
  carObj->rearSkid = 0;
  carObj->crash = 0;
  carObj->blowout = 0;
  carObj->control.hanno = 0;


  for (int i = 0; i < 4;
       i++) {
    carObj->wheel[i].wheelInAir = 0;
    carObj->wheel[i].rebound = 0;
  } }

/* ---- Physics_StopCar__FP8Car_tObj  [PHYSICS.CPP:1364-1370] COVERED-SLD-PASS ---- */
/* Retail groups all three linear components on1365; original vector macro
 * spelling is unproved. Actual angular work is1370, not the scheduled order. */
#line 1362 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_StopCar(Car_tObj *carObj)

{
  (carObj->N).linearVel.x = (carObj->N).linearVel.x * 0xf5 / 0x100; (carObj->N).linearVel.y = (carObj->N).linearVel.y * 0xf5 / 0x100; (carObj->N).linearVel.z = (carObj->N).linearVel.z * 0xf5 / 0x100;

  if ((carObj->N).orientationToGround.y < 0x3333)


    (carObj->N).angularVel.y = (carObj->N).angularVel.y / 0x100 * 0xfa;
}

/* ---- Physics_TestForBarrierCollision__FP8Car_tObj  [PHYSICS.CPP:1377-1385] COVERED-SLD-PASS ---- */
/* Real call1380, hit guard1381, flag test1383, optional repair1384 and
 * crash store1385 recover the complete covered contract without new objects. */
#line 1375 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_TestForBarrierCollision(Car_tObj *carObj)

{
  int hit;

  hit = Physics_DoBarrierCheck(carObj);
  if (hit != 0) {

    if ((carObj->carFlags & 4U) != 0)
      Physics_FixEngineRpm(carObj);
    carObj->crash = hit; }
}

/* ---- Physics_CalculateRoadGripModifiers__FP8Car_tObj [PHYSICS.CPP:1394-1439; COVERED-SYM-SLD-PASS] ---- */
/* @0x800AA808
 * 2026-10-29: ordinary aero if and separately computed front/rear force values
 * restore all95 word/file tags,8 supplied owners,12 block lines and end1439.
 * The two plain int call results are naturally debug-elided;const controls
 * are unnecessary and NOT adopted. No alias,asm,volatile,fake use or scope
 * padding is introduced. The anonymous compound-expression wrappers retire.
 * frontAeroForce/rearAeroForce are behavior-derived names,not recovered SYM
 * identifiers. Their exact original names/macro spelling are not retained;
 * this evidence does not claim unique original source text.
 * Receipt:build/nc12/physics_grip_notes_20261029/final-proof.json. */
#line 1392 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_CalculateRoadGripModifiers(Car_tObj *carObj)

{
  int frontWheels = 0;
  int rearWheels = 0;
  int leftWheels = 0;
  int rightWheels = 0;

  {

    for (int i = 0; i < 4; i++) {
      int roadSurfaceType; int tempSurface;
      roadSurfaceType = carObj->wheel[i].roadSurfaceType & 0xf;
      tempSurface = (u_int)(u_char)roadSurfaceIndex[carObj->carInfo->TireType][roadSurfaceType];

      if (slippery != 0)
        tempSurface = tempSurface + 1;

      if (i < 2)
        frontWheels = frontWheels + roadSurfaceFrictionCoeff[tempSurface];
      else
        rearWheels = rearWheels + roadSurfaceFrictionCoeff[tempSurface];
      if ((i == 0) || (i == 2))
        leftWheels = leftWheels + roadSurfaceFrictionCoeff[tempSurface];
      else
        rightWheels = rightWheels + roadSurfaceFrictionCoeff[tempSurface];
    }


    frontMult = frontWheels >> 1;
  } rearMult = rearWheels >> 1;
  leftMult = leftWheels >> 1;
  rightMult = rightWheels >> 1;
  roadMult = (frontMult + rearMult >> 1) + carObj->N.roadGravityModifier;



  if (carObj->linearVel_ch.z > 0x50000)
  {



    int frontAeroForce = fixedmult(carObj->linearVel_ch.z,carObj->specs->frontAeroDownForce);
    frontMult += frontAeroForce;


    int rearAeroForce = fixedmult(carObj->linearVel_ch.z,carObj->specs->rearAeroDownForce);
    rearMult += rearAeroForce; } }
#line 1441 "C:/nfs4/GAME/COMMON/PHYSICS.CPP" /* preserve unchanged following-function coordinates */

/* ---- Physics_CalculateCarAcceleration__FP8Car_tObj [PHYSICS.CPP:1447-1672; COVERED-SYM-SLD-PASS] ---- */
/* @0x800AA984
 * 2026-10-29: genuine table/RNG/aero/rev-limit/manual/shift/torque/RPM/slide
 * phases preserve all710 words and restore16 supplied owners,16 block-line
 * records,header1447 and end1672. The normal torque guard is1563;the real
 * temp-to-wheelRpm shift is scheduled into that guard's delay slot with its
 * tag. No new capture,qualifier,asm,volatile,identity or fake use is added.
 * ratio remains the actual slide factor;temp owns negative-RPM correction.
 * Nested real car-category/slippery guards restore their distinct phases.
 * Literal original macro/comment/punctuation/reuse text is not uniquely proved.
 * Receipt:build/nc12/physics_acceleration_layout_20261029/final-proof.json. */
#line 1445 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
int Physics_CalculateCarAcceleration(Car_tObj *carObj)

{
  int blip[8] = {0,0,250,200,175,150,125,0};
  int bblip[8] = {0,0,200,175,150,125,100,0};
  int diffDesiredRpm; int diffFlywheelRpm; int desiredRpm; int wheelRpm; int driveAcc; int drag; int ratio; int temp; int smokeRpm; int damage; Car_tSpecs *specs;



  driveAcc = 0;
  wheelRpm = 0;


  smokeRpm = carObj->specs->redline / 8;
  damage = 0;


  randtemp = fastRandom * randSeed; fastRandom = randtemp & 0xffff; if ((randtemp >> 8 & 0xffff) < (u_int)((carObj->N.damage[1] + carObj->N.damage[5]) / 0x100)) {
    damage = 1;
  }
  specs = carObj->specs;
  exceedRedline = 0;
  if (specs->redline + 500 < carObj->flywheelRpm) {

    exceedRedline = 1;
  }




  if (carObj->carInfo->GroundEffects != 0) {
    drag = (carObj->specs->frontAeroDownForce + carObj->specs->rearAeroDownForce) / 2 + 0x10000;
  } else drag = 0x10000;

  drag = fixedmult(carObj->linearVel_ch.z,drag);
  drag = fixedmult(specs->dragCoeff,(drag / 0x10000) * (drag / 0x10000) * (drag / 0x10000));





  if ((carObj->control.gear == 1) || (powerControl == 0))
    desiredRpm = (((specs->redline + 0xfa) > (fixedmult(specs->redline + 0xfa,gGasRatio))) ? (fixedmult(specs->redline + 0xfa,gGasRatio)) : (specs->redline + 0xfa));
  else
    desiredRpm = (((specs->redline + 100) > (fixedmult(specs->redline + 100,gGasRatio))) ? (fixedmult(specs->redline + 100,gGasRatio)) : (specs->redline + 100));


  if (carObj->flywheelRpm >= specs->redline) {

    carObj->flywheelRpm = specs->redline + 0x32;
    if ((carObj->control.gear == 1) || (powerControl == 0))
      carObj->revLimit = 3;

    else carObj->revLimit = 4;
  }

  if (0 < carObj->revLimit) {

    if ((carObj->control.gear == 1) || (powerControl == 0))
      desiredRpm = (((desiredRpm) > (specs->redline - 800)) ? (specs->redline - 800) : (desiredRpm));

    else desiredRpm = (((desiredRpm) > (specs->redline - 400)) ? (specs->redline - 400) : (desiredRpm));
    carObj->revLimit -= 1;
  }




  if ((carObj->control.gear == 1) || (carObj->control.gearShiftTimer != 0) || (powerControl == 0)) {

    if (damage) {

      carObj->flywheelRpm = carObj->flywheelRpm + -100;
      carObj->flywheelRpm = (((carObj->flywheelRpm) > (0)) ? (carObj->flywheelRpm) : (0));
    } else {
      if ((carObj->flywheelRpm < desiredRpm) && (carObj->control.gearShiftTimer == 0)) {


        carObj->flywheelRpm += 0xfa; temp = desiredRpm; if (temp >= carObj->flywheelRpm) temp = carObj->flywheelRpm; carObj->flywheelRpm = temp;
      }
      else if ((carObj->control.gearShiftTimer != 0) && (carObj->control.lastGear != 1)) {

        if (carObj->control.downShifting != 0) {

          if ((u_char)carObj->control.brakeLevel >= 0x41)
            carObj->flywheelRpm += bblip[(u_char)carObj->control.desiredGear];

          else carObj->flywheelRpm += blip[(u_char)carObj->control.desiredGear];
          ratio = (((carObj->flywheelRpm) > (specs->redline)) ? (specs->redline) : (carObj->flywheelRpm)); carObj->flywheelRpm = ratio;
        } else {


          if (4 <= (u_char)carObj->control.gear)
            carObj->flywheelRpm = carObj->flywheelRpm + -200;

          else carObj->flywheelRpm = carObj->flywheelRpm + -100;
          carObj->flywheelRpm = (((carObj->flywheelRpm) > (0)) ? (carObj->flywheelRpm) : (0));
        }
      } else {
        if (carObj->flywheelRpm >= desiredRpm) {
          carObj->flywheelRpm = carObj->flywheelRpm + -200;

          carObj->flywheelRpm = (((carObj->flywheelRpm) > (desiredRpm)) ? (carObj->flywheelRpm) : (desiredRpm));
        } }
    } carObj->frontWheelSpin = 0;
    carObj->wheelSpin = 0;

  } else
  {

    if ((PHYSICS_TRANSMISSION_AT(carObj->carIndex) == 1) || (carObj->RSControl != 0))
      Physics_AutoShift(carObj);

    if ((carObj->control.gearShiftTimer != 0) && (carObj->control.downShifting == 0))
      temp = fixedmult(carObj->linearVel_ch.z,specs->velToRpmRatio[(u_char)carObj->control.lastGear]);

    else temp = fixedmult(carObj->linearVel_ch.z,specs->velToRpmRatio[(u_char)carObj->control.gear]); if (temp < 0) temp = temp + 0xffff;
    wheelRpm = temp >> 0x10;
    if ((exceedRedline != 0) || (0 < carObj->revLimit))

      driveAcc = fixedmult(specs->torqueCurve[specs->redline / 0x100],specs->gearAccCoeff[(u_char)carObj->control.gear]) << 1;


    else driveAcc = fixedmult(Physics_GetTorque(carObj,carObj->flywheelRpm / 0x100),specs->gearAccCoeff[(u_char)carObj->control.gear]);

    diffDesiredRpm = desiredRpm - wheelRpm;
    if ((__builtin_abs(diffDesiredRpm) < 0x7d) && (desiredRpm < specs->redline + -300))
      diffDesiredRpm = 0;

    diffFlywheelRpm = carObj->flywheelRpm - wheelRpm;





    if (!((((((diffFlywheelRpm < 0xfb) || ((carObj->control).gearShiftTimer != '\0')) || (4 < (u_char)(carObj->control).gear)) && ((((u_char)(carObj->control).gear < 2 || (-0x199a < (carObj->linearVel_ch).z)) || (gGasRatio < 0x8001)))) && (((((carObj->control).gear != '\0' || ((carObj->linearVel_ch).z < 0x199a)) || (gGasRatio < 0x8001)) && (carObj->wheelSpin != 1)))) || (carObj->revLimit != 0)))
    { int rpmDrop;

      rpmDrop = 0;

      if ((desiredRpm < 2000) || ((u_char)carObj->control.desiredGasLevel < 0x40) || damage || ((carObj->carInfo->carType == 0x13) && (2 < (u_char)carObj->control.gear))) {
        rpmDrop = 200;
      } else if ((carObj->control.gear == 2) || (carObj->control.gear == 0))
        rpmDrop = 10;
      else if (2 < (u_char)carObj->control.gear)
        rpmDrop = 0x32;

      if (smokeRpm < diffFlywheelRpm)
        carObj->wheelSpin = 2;
      carObj->flywheelRpm -= (rpmDrop >= diffFlywheelRpm) ? diffFlywheelRpm : rpmDrop;
    } else
    { if (diffDesiredRpm < 0)
      { int rpmRise;

        driveAcc = -fixedmult(driveAcc,specs->gasOffFactor);


        if (((0 < gravity_ch.z) && (1 < (u_char)carObj->control.gear) && (driveAcc < 0) && ((u_char)carObj->control.gear < 3)) || ((gravity_ch.z < 0) && (carObj->control.gear == 0) && (0 < driveAcc)))

          driveAcc = driveAcc / 2;


        rpmRise = fixedmult(specs->velToRpmRatioInv[(u_char)carObj->control.gear] << 3,0x28000000) / 0x10000;
        if (carObj->control.gear == 0) {
          if (rpmRise < -diffFlywheelRpm) rpmRise = -diffFlywheelRpm; carObj->flywheelRpm += rpmRise;

        } else { carObj->flywheelRpm += (((-diffFlywheelRpm) > (rpmRise)) ? (rpmRise) : (-diffFlywheelRpm)); }
        if (exceedRedline == 0)
          carObj->flywheelRpm = carObj->flywheelRpm > desiredRpm ? carObj->flywheelRpm : desiredRpm;




      }
      else if (diffDesiredRpm == 0) {

        carObj->flywheelRpm = wheelRpm;
        driveAcc = drag;

      } else {

        if (damage) {

          carObj->flywheelRpm = carObj->flywheelRpm + -100;
          driveAcc = 0;

        } else {

          if (diffFlywheelRpm >= 0xc9)
            carObj->flywheelRpm = carObj->flywheelRpm + -200;
          else if (diffFlywheelRpm < -200)
            carObj->flywheelRpm = carObj->flywheelRpm + 200;

          else carObj->flywheelRpm = wheelRpm;
          driveAcc = fixedmult(driveAcc,gGasRatio);
        }

        diffDesiredRpm = desiredRpm; if (diffDesiredRpm >= carObj->flywheelRpm) diffDesiredRpm = carObj->flywheelRpm; carObj->flywheelRpm = diffDesiredRpm;


        ratio = __builtin_abs(carObj->slide) + 0x10000;
        if ((PHYSICS_SGGE & 8U) != 0) {
          if (0x30000 < ratio) ratio = 0x30000;

        } else if (0x20000 < ratio) ratio = 0x20000;
        driveAcc = (driveAcc / 256) * (ratio / 256);
      }
    }
    if (carObj->flywheelRpm < 0) {

      temp = carObj->linearVel_ch.z * -0x20;

      if ((((driveAcc < 1) || (temp < 1)) || (driveAcc - temp < 1)) && (((-1 < driveAcc || (-1 < temp)) || (-1 < driveAcc - temp)))) {

        driveAcc = temp;
        carObj->flywheelRpm = 0;
      }
    }
  }


  if (carObj->carInfo->carType - 0xcU < 4) {

    if ((slippery != 0) && (carObj->control.gear == 2) && (0 < driveAcc))
      driveAcc = driveAcc * 3 >> 2;
  }

  return driveAcc - drag; }
#line 1731 "C:/nfs4/GAME/COMMON/PHYSICS.CPP" /* preserve unchanged following-function coordinates */

/* ---- Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct [PHYSICS.CPP:1680-1725] COVERED-SYM-SLD-PASS ---- */
/* @0x800AB49C */
/* Source receipt (2026-10-28):roadGrip owns friction,not the later tire ceiling
 * that reuses a2 after its value dies. Real per-tire field-first MIN arms merge
 * to the retail common comparison/copy. The skid/cmp captures,their declaring
 * scope and the empty identity asm are removed,not renamed or const-hidden.
 * Retail SYM directly provides optVar1/optVar2;matched NFS2 independently has
 * those names and the same max-plus-quarter conditional distance expression.
 * All six complete supplied owner tuples,127 word/file tags,root region,
 * header1680/end1725 and every code byte agree. Earlier copy/floor/opacity
 * necessity claims are superseded by the genuine source-role/arm repair.
 * The literal original macro/branch/comment spelling remains unproved,and
 * the wider source-restoration goal is open. No new object or matching device.
 * build/nc12/physics_wheellock_source_20261028/. */
#line 1678 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_CalcWheelLockAcc(Car_tObj *carObj,Physics_tWheelAccStruct *wheel)

{
  int totalAcc;
  int optVar1;
  int optVar2;
  int roadGrip;





  if (wheel->frontTire != 0) {

    wheel->skid = carObj->frontSkid;
    roadGrip = wheel->roadGrip / 256 * (frontMult / 256);
  }
  else {

    wheel->skid = carObj->rearSkid;
    roadGrip = wheel->roadGrip / 256 * (rearMult / 256);
  }

  optVar1 = __builtin_abs(wheel->velCap.x);
  optVar2 = __builtin_abs(wheel->velCap.z);

  totalAcc = optVar1 > optVar2 ? optVar1 + (optVar2 >> 2) : optVar2 + (optVar1 >> 2);
  if (slippery != 0) {
    optVar2 = roadGrip - roadGrip / gripLossTableWet[carObj->carInfo->TireType];
  }
  else { optVar2 = roadGrip - roadGrip / gripLossTable[carObj->carInfo->TireType]; }

  if (roadGrip < totalAcc) {
    wheel->skid = wheel->skid * 3 + (totalAcc - roadGrip) >> 2;
  }
  else { wheel->skid = 0; }


  if (carObj->carInfo->TireType == 2) {
    wheel->skid = MIN(wheel->skid,0x80000);
  }
  else { wheel->skid = MIN(wheel->skid,0xa0000); }

  if (0x100 < __builtin_abs(totalAcc)) {
    optVar1 = fixeddiv(optVar2,totalAcc) >> 8;
  }
  wheel->finalAcc.x = wheel->velCap.x * optVar1 >> 8;
  wheel->finalAcc.z = wheel->velCap.z * optVar1 >> 8; }

/* ---- Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct [PHYSICS.CPP:1731-1810] COVERED-SYM-SLD-PASS ---- */
/* @0x800AB698 */
/* Source receipt (2026-10-28):roadGrip is friction,not the later anonymous
 * type1/type2 ceiling. Real field-first MIN arms preserve the retail common
 * comparison while removing roadGripCompare,skidValue,both empty fences and
 * four named labels/gotos. On this source graph the actual wheel parameter
 * also gets its supplied s0 home directly;wheel_reg is removed,not renamed.
 * Earlier direct-parameter90-diff and clamp/fence necessities were specific
 * to the old graph,not source-object proofs or floors. Correct gripLoss's
 * quotient/clamp role remains intact. All seven provided complete owner
 * tuples,233 word/file tags,root block coordinates,header1731/end1810 match.
 * Ordinary fallthrough permits the lexical closing brace on1811 while native
 * end/epilogue remain1810;an explicit return on1811 regresses eight tags.
 * The max-plus-quarter conditional has independent matched NFS2 evidence,
 * but its different cap/force logic is not imported. Literal original macro,
 * branch/comment spelling and the wider source-restoration goal stay open.
 * No extra source object,qualifier,scope padding or matching device is used.
 * build/nc12/physics_traction_arms_20261028/. */
#line 1729 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_CalcTractionCircleAcc(Car_tObj *carObj,Physics_tWheelAccStruct *wheel)

{
  int totalAcc;
  int ratio;
  int gripLoss;
  int roadGrip;
  int gripLossDivider;





  totalAcc = __builtin_abs(wheel->finalAcc.x) > __builtin_abs(wheel->finalAcc.z) ? __builtin_abs(wheel->finalAcc.x) + (__builtin_abs(wheel->finalAcc.z) >> 2) : __builtin_abs(wheel->finalAcc.z) + (__builtin_abs(wheel->finalAcc.x) >> 2);
  roadGrip = wheel->roadGrip;

  if (wheel->frontTire != 0) {
    wheel->skid = carObj->frontSkid;
  }
  else {
    wheel->skid = carObj->rearSkid;


    if (((roadGrip < __builtin_abs(wheel->finalAcc.z)) && (0x80 < (u_char)(carObj->control).gasLevel)) || (carObj->wheelSpin == 2)) {
      carObj->wheelSpin = 1;
    }
    else { carObj->wheelSpin = 0; }
  }


  if (slippery != 0) {
    gripLossDivider = gripLossTableWet[carObj->carInfo->TireType];
  }
  else { gripLossDivider = gripLossTable[carObj->carInfo->TireType]; }


  if (roadGrip < totalAcc) {

    if (((carObj->carInfo->Traction != 0) && (wheel->frontTire == 0)) && (__builtin_abs(carObj->slide) < 0x2666)) {

      ratio = rdiv(roadGrip,totalAcc);

      wheel->skid = 0;

      if (2 < (u_char)(carObj->control).gear) {
        wheel->finalAcc.x = fixedmult(wheel->finalAcc.x,ratio); }
      wheel->finalAcc.z = fixedmult(wheel->finalAcc.z,ratio);
    }
    else {

      gripLoss = MIN(roadGrip / gripLossDivider,(totalAcc - roadGrip) / gripLossDivider);

      ratio = rdiv(roadGrip - gripLoss,totalAcc);


      if (carObj->carInfo->TireType == 2) {
        wheel->skid = (wheel->skid * 0xf + (totalAcc - roadGrip)) / 16; }

      else { wheel->skid = (wheel->skid * 3 + (totalAcc - roadGrip)) / 4; }

      wheel->finalAcc.x = fixedmult(wheel->finalAcc.x,ratio);
      wheel->finalAcc.z = fixedmult(wheel->finalAcc.z,ratio);
    }
  }

  else { wheel->skid = 0; }

  if (((wheel->frontTire == 0) && (carObj->wheelSpin == 1)) && (carObj->carInfo->Traction == 0)) {

    wheel->skid = totalAcc;
    if ((u_char)(carObj->control).gear < 4) {
      wheel->skid = totalAcc << 2; }
  }


  if (carObj->carInfo->TireType == 1) {
    wheel->skid = MIN(wheel->skid,0x80000); }
  else if (carObj->carInfo->TireType == 2) {
    wheel->skid = MIN(wheel->skid,0x40000); }

  if (carObj->carInfo->Traction != 0) {
    wheel->skid = wheel->skid * 3 / 4; }
}

/* ---- Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct [PHYSICS.CPP:1815-1979] COVERED-SLD-PASS ---- */
/* SOURCE receipt (2026-10-28): the real non-lock/lock if/else removes the
 * reconstruction's wheelLock/normalTire labels and three gotos at346/346 PASS.
 * Canonical MIN/MAX retain the earlier carrier-free clamps; no new local,
 * fence,qualifier or scope padding is needed. Actual braking initialization,
 * nested gas/gear tests,slip/traction phases and implicit fallthrough restore
 * every word/file tag,provided owner tuple and block/end coordinate. Earlier
 * equivalent early-return/flat-guard controls do not match this compiler.
 * Literal original macros/comments remain unproved,not inferred from a seal.
 * build/nc12/physics_tire_source_20261028/. */
#line 1813 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_CalculateTireForces(Car_tObj *carObj,Physics_tWheelAccStruct *wheel)

{
  int latAcc; int brakingSituation; int slipAngle; int roadGrip;





  brakingSituation = 0;

  roadGrip = wheel->roadGrip;





  wheel->skid = 0;



  if (wheel->steeringAngle != 0)
    Math_ResolveRotatedVector(wheel->velCap.x,wheel->velCap.z,wheel->steeringAngle,&wheel->velCap.x,&wheel->velCap.z);

  if ((wheel->acc < 0) && (wheel->velCap.z < 0)) {

    if ((gGasRatio < 0x4001) || (carObj->control.gear != '\0')) {

      wheel->acc = MAX(wheel->acc,wheel->velCap.z);
      brakingSituation = 1; }
  }

  else if ((0 < wheel->acc) && (0 < wheel->velCap.z)) {

    if ((gGasRatio < 0x4001) || ((u_char)carObj->control.gear < 2)) {

      wheel->acc = MIN(wheel->acc,wheel->velCap.z);
      brakingSituation = 1; }
  }





  wheel->acc = fixedmult(wheel->acc,carObj->specs->lateralGripMult);





  if (((brakingSituation != 0) && (__builtin_abs(wheel->acc) > wheel->roadGrip)) || ((carObj->control.handBrake != '\0') && (wheel->frontTire == 0) && (__builtin_abs(carObj->linearVel_ch.z) > 0x8000))) {





    if (!((carObj->control.handBrake != '\0') || ((carObj->carInfo->ABS == 0) && (carObj->linearVel_ch.z < 0x190001) && (0xeb < (u_char)carObj->control.brakeLevel) && ((__builtin_abs(carObj->linearVel_ch.z) > 0x4ffff) || (carObj->wheelSpin != 0))))) {


      if (wheel->acc > wheel->roadGrip) wheel->acc = wheel->roadGrip;



      else if (wheel->acc < -wheel->roadGrip)

        wheel->acc = -wheel->roadGrip;


      if ((carObj->carInfo->ABS != 0) && (carObj->linearVel_ch.z < 0x190000)) {

        if ((PHYSICS_GAME_TICKS & 3U) == 0)
          wheel->skid = 0x80000;
        else
          wheel->skid = 0;
      }

    } else {

      if (wheel->frontTire != 0)
        carObj->wheelLock = carObj->wheelLock + 1;
      else
        carObj->wheelLock = carObj->wheelLock + 2;

      Physics_CalcWheelLockAcc(carObj,wheel);

      if (wheel->frontTire != 0)
        carObj->frontSkid = wheel->skid;
      else
        carObj->rearSkid = wheel->skid;
      return;
    }
  }





  if (wheel->velCap.z != 0) {

    slipAngle = fixedatan(wheel->velCap.x,-wheel->velCap.z / 2);
    if (0 < wheel->velCap.z) {

      if (0 < wheel->velCap.x)
        slipAngle = 0x8000 - slipAngle;
      else if (wheel->velCap.x < 0)
        slipAngle = -0x8000 - slipAngle;
    }
    slipAngle <<= 8;
  } else

    slipAngle = 0;


  if (wheel->frontTire != 0) {

    latAcc = fixedmult(fixedmult((0x100000 < __builtin_abs(slipAngle)) ? 0x100000 : __builtin_abs(slipAngle),roadGrip),0x1555);

    if (slipAngle < 0)
      latAcc = -latAcc;

    wheel->finalAcc.x = latAcc;
    wheel->finalAcc.x = latAcc + gravity_ch.x / 2;




    if (__builtin_abs(wheel->velCap.x) + __builtin_abs(wheel->velCap.z) < 0x200000) {

      if (0 < wheel->velCap.x)
        wheel->finalAcc.x = MIN(wheel->velCap.x,__builtin_abs(latAcc));
      else
        wheel->finalAcc.x = MAX(wheel->velCap.x,-__builtin_abs(latAcc));
    }

  } else {

    latAcc = fixedmult(MIN(MAX(__builtin_abs(slipAngle),0x8000),0x20000),roadGrip) / 2;
    if (slipAngle < 0)
      latAcc = -latAcc;

    latAcc = latAcc + gravity_ch.x / 2;


    if (0 < wheel->velCap.x)
      wheel->finalAcc.x = MIN(wheel->velCap.x,__builtin_abs(latAcc));
    else
      wheel->finalAcc.x = MAX(wheel->velCap.x,-__builtin_abs(latAcc));

  }

  wheel->finalAcc.y = 0;
  wheel->finalAcc.z = wheel->acc;





  Physics_CalcTractionCircleAcc(carObj,wheel);

  if (wheel->steeringAngle != 0)
    Math_ResolveRotatedVector(wheel->finalAcc.x,wheel->finalAcc.z,-wheel->steeringAngle,&wheel->finalAcc.x,&wheel->finalAcc.z);

  if (wheel->frontTire != 0)
    carObj->frontSkid = wheel->skid;
  else
    carObj->rearSkid = wheel->skid;
}

/* ---- Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii [PHYSICS.CPP:1982-2040] COVERED-SYM-SLD-PASS ---- */
/* @0x800ABFA4 */
/* Source receipt (2026-10-28): position owns the final signed result,not the
 * intermediate magnitude. A common return after both arms preserves112 words,
 * restores its supplied v0 home and ends the positive desLane/laneOffset
 * scope at+284 instead of+292. All nine complete supplied owner tuples and
 * every word/file/block/end fact agree;no variable is renamed or added.
 * Signed conversion before negation is safe for all256 widths and four
 * reachable lane offsets;maximum magnitude with bias is29343744.
 * SOURCE-REVIEW-UNRESOLVED: both laneWidth captures remain unprovided source
 * objects/names. Capture-free scale/half-width controls do not match;this is
 * not proof of original spelling or necessity. Literal source text is open.
 * build/nc12/physics_rsposition_source_20261028/. */
#line 1980 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
int Physics_CalculateRSControlDesiredPosition(Car_tObj *carObj,int sliceAhead,int lookAhead)

{
  int driveSide; int position;






  driveSide = carObj->RSControl * AITune_driveSide;









  if ((((carObj->roadPosition < 0) && (0 < driveSide)) && (AIWorld_IsDriveableLane((int)carObj->N.simRoadInfo.slice,carObj->laneIndex + 1) == 0)) || (((0 < carObj->roadPosition) && (driveSide < 0)) && (AIWorld_IsDriveableLane((int)carObj->N.simRoadInfo.slice,carObj->laneIndex - 1) == 0)))

    driveSide = -driveSide;



  if (0 < driveSide)
  {
    int desLane; int laneOffset; int laneWidth;
    desLane = 7;
    while ((AIWorld_IsDriveableLaneInSliceRange((int)carObj->N.simRoadInfo.slice,lookAhead,carObj->RSControl,desLane) == 0) && (desLane < 10))
      desLane = desLane + 1;
    laneOffset = desLane - 7;
    laneWidth = (u_int)PHYSICS_SLICE_WIDTH_RT(sliceAhead) * 0x8000; position = (laneOffset * laneWidth + ((u_int)laneWidth >> 1)) + ((0 < laneOffset) ? 0x18000 : 0);
  }








  else
  {
    int desLane = 6; int laneOffset; int laneWidth;
    while ((AIWorld_IsDriveableLaneInSliceRange((int)carObj->N.simRoadInfo.slice,lookAhead,carObj->RSControl,desLane) == 0) && (4 <= desLane))
      desLane = desLane - 1;
    laneOffset = 6 - desLane;
    laneWidth = (u_int)PHYSICS_SLICE_WIDTH_LF(sliceAhead) * 0x8000; position = -(int)((laneOffset * laneWidth + ((u_int)laneWidth >> 1)) + ((0 < laneOffset) ? 0x18000 : 0));
  }









  return position;
}

/* ---- Physics_Real__FP8Car_tObj [PHYSICS.CPP:2048-2500] COVERED-SYM-SLD-PASS ---- */
/* @0x800AC164 */
/* Source receipt (2026-10-28):initialize the supplied lookAhead at declaration
 * using the existing EA/NFS2 MAX expansion. A separate assignment lowers the
 * conditional product through an anonymous result/copy;initialization gives
 * the real provided result its target directly. The rsControl capture is gone,
 * not const-qualified or renamed. All35 complete local tuples,46 block records,
 * 1272 word/file tags,header2048/end2500 and every instruction byte now match.
 * Xcomponent is the first product;finalAngularAcc_ch.y owns the second product
 * and completed sum. No fz,lm,sumZ,wheelMult,fence,absorption identity,one-shot
 * loop or named drag-skip label remains. Real damping/offset lifetimes,retail
 * phase order and ordinary terminal fallthrough preserve the supplied evidence.
 * Earlier matching-device/source-exhaustion claims are superseded,not floors.
 * The exact erased literal/macro/comment spelling is not uniquely proved by
 * these covered contracts;the wider original-source goal remains open.
 * build/nc12/physics_real_init_20261028/ and physics_real_alloc_20261028/. */
#line 2046 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_Real(Car_tObj *carObj)

{
  int driveAcc;
  int brakeAcc;
  int frontBrake;
  int ratio;
  int tempSteer;
  int roadGrip;
  int frontGrip;
  Physics_tWheelAccStruct frontWheel;
  Physics_tWheelAccStruct rearWheel;
  coorddef temp;
  coorddef finalAngularAcc_ch;
  coorddef carAccCap_ch;
  int rotationalAccCap;
  matrixtdef transposeMat;
  Car_tSpecs *specs;



  specs = carObj->specs;
  (carObj->linearAcc_ch).x = 0; (carObj->linearAcc_ch).y = 0; (carObj->linearAcc_ch).z = 0;
  steeringControl = 1;
  powerControl = 1;


  if ((PHYSICS_WEATHER != 0) && ((((int)BWorldSm_TunnelFlagSm(&(carObj->N).simRoadInfo)) ^ 1) != 0))
  { slippery = 1;
  }
  else { slippery = 0;
  }

  if (((carObj->wheel[0].wheelInAir != 0) && (carObj->wheel[1].wheelInAir != 0)) && (0xccc < (carObj->N).objAltitude))
  { steeringControl = 0;
  }

  if (((carObj->wheel[2].wheelInAir != 0) && (carObj->wheel[3].wheelInAir != 0)) && (0xccc < (carObj->N).objAltitude))
  { powerControl = 0;
  }








  (carObj->linearVel_ch).x = fixedmult((carObj->N).linearVel.x,(carObj->N).shadowMat.m[0]) + fixedmult((carObj->N).linearVel.y,(carObj->N).shadowMat.m[1]) + fixedmult((carObj->N).linearVel.z,(carObj->N).shadowMat.m[2]);
  (carObj->linearVel_ch).y = fixedmult((carObj->N).linearVel.x,(carObj->N).shadowMat.m[3]) + fixedmult((carObj->N).linearVel.y,(carObj->N).shadowMat.m[4]) + fixedmult((carObj->N).linearVel.z,(carObj->N).shadowMat.m[5]);
  (carObj->linearVel_ch).z = fixedmult((carObj->N).linearVel.x,(carObj->N).shadowMat.m[6]) + fixedmult((carObj->N).linearVel.y,(carObj->N).shadowMat.m[7]) + fixedmult((carObj->N).linearVel.z,(carObj->N).shadowMat.m[8]);

  (carObj->angularVel_ch).x = fixedmult((carObj->N).angularVel.x,(carObj->N).shadowMat.m[0]) + fixedmult((carObj->N).angularVel.y,(carObj->N).shadowMat.m[1]) + fixedmult((carObj->N).angularVel.z,(carObj->N).shadowMat.m[2]);
  (carObj->angularVel_ch).y = fixedmult((carObj->N).angularVel.x,(carObj->N).shadowMat.m[3]) + fixedmult((carObj->N).angularVel.y,(carObj->N).shadowMat.m[4]) + fixedmult((carObj->N).angularVel.z,(carObj->N).shadowMat.m[5]);
  (carObj->angularVel_ch).z = fixedmult((carObj->N).angularVel.x,(carObj->N).shadowMat.m[6]) + fixedmult((carObj->N).angularVel.y,(carObj->N).shadowMat.m[7]) + fixedmult((carObj->N).angularVel.z,(carObj->N).shadowMat.m[8]);


  if ((carObj->linearVel_ch).z > 0x50000)
  {
    ratio = fixeddiv((carObj->linearVel_ch).x,(carObj->linearVel_ch).z);
    carObj->slide = ratio;
  }
  else
  { carObj->slide = 0;
  }




  carAccCap_ch.x = ((carObj->linearVel_ch).x * -0x20) / 2;
  carAccCap_ch.y = ((carObj->linearVel_ch).y * -0x20) / 2;
  carAccCap_ch.z = ((carObj->linearVel_ch).z * -0x20) / 2;

  rotationalAccCap = -fixedmult((carObj->N).angularVel.y << 5,specs->alphaToAccRotInertia) ;
  rotationalAccCap /= 2;




  temp.x = 0;
  temp.y = -0xa0000;
  temp.z = 0;

  gravity_ch.x = fixedmult(temp.x,(carObj->N).shadowMat.m[0]) + fixedmult(temp.y,(carObj->N).shadowMat.m[1]) + fixedmult(temp.z,(carObj->N).shadowMat.m[2]);
  gravity_ch.y = fixedmult(temp.x,(carObj->N).shadowMat.m[3]) + fixedmult(temp.y,(carObj->N).shadowMat.m[4]) + fixedmult(temp.z,(carObj->N).shadowMat.m[5]);
  gravity_ch.z = fixedmult(temp.x,(carObj->N).shadowMat.m[6]) + fixedmult(temp.y,(carObj->N).shadowMat.m[7]) + fixedmult(temp.z,(carObj->N).shadowMat.m[8]);




  frontWheel.velCap.x = carAccCap_ch.x + rotationalAccCap;
  frontWheel.velCap.y = carAccCap_ch.y;
  frontWheel.velCap.z = carAccCap_ch.z;

  rearWheel.velCap.x = carAccCap_ch.x - rotationalAccCap;
  rearWheel.velCap.y = carAccCap_ch.y;
  rearWheel.velCap.z = carAccCap_ch.z;




  Physics_RampCarControlValues(carObj);


  ratio = (gravity_ch.x / 0x100) * 0x300 / 0x10000;
  tempSteer = (carObj->control).steering + ratio;

  if (tempSteer > 0x7f)
  { tempSteer = 0x7f;
  } else if (tempSteer < -0x7f)
  { tempSteer = -0x7f;
  }
  frontWheel.steeringAngle = tempSteer * specs->maxSteeringAcc / 0x80;
  {
    int damage;
    int damageMult;
    damage = (carObj->N).damage[0] + (carObj->N).damage[1] + (carObj->N).damage[2] + (carObj->N).damage[9];


    damage = damage / 0x200;



    damageMult = 0x10000 - damage;
    frontWheel.steeringAngle = (frontWheel.steeringAngle / 0x100) * (damageMult / 0x100);
  }


  if ((carObj->linearVel_ch).z > 0x3c0000)
  {
    ratio = fixedmult((carObj->linearVel_ch).z,0x444);
    frontWheel.steeringAngle = fixeddiv(frontWheel.steeringAngle,ratio);
  }


  if ((carObj->linearVel_ch).z > 0x1ab333)
  {
    if (
        (((carObj->slide > 0xccc) && (frontWheel.steeringAngle > 0))) || (((carObj->slide < -0xccc) && (frontWheel.steeringAngle < 0))))
    {
      int ratio;
      ratio = (0x10000 < (__builtin_abs(carObj->slide) << 1)) ? 0x10000 : (__builtin_abs(carObj->slide) << 1); frontWheel.steeringAngle = fixedmult(frontWheel.steeringAngle,ratio);
    }
  }
  else if ((carObj->linearVel_ch).z > 0xd6666)
  {
    if (
        (((carObj->slide > 0x2666) && (frontWheel.steeringAngle > 0))) || (((carObj->slide < -0x2666) && (frontWheel.steeringAngle < 0))))
    {
      int ratio; ratio = (0x10000 < (__builtin_abs(carObj->slide) << 1)) ? 0x10000 : (__builtin_abs(carObj->slide) << 1);
      frontWheel.steeringAngle = fixedmult(frontWheel.steeringAngle,ratio);
    }
  }

  rearWheel.steeringAngle = 0;
  frontWheel.frontTire = 1;
  rearWheel.frontTire = 0;




  driveAcc = Physics_CalculateCarAcceleration(carObj);
















  frontWheel.acc = (driveAcc / 0x100) * (specs->frontDriveRatio / 0x100);
  rearWheel.acc = driveAcc - frontWheel.acc;




  if ((steeringControl == 0) && (powerControl == 0))
  {
    carObj->frontSkid = 0;
    carObj->rearSkid = 0;
    return;
  }
  carObj->crash = 0;




  brakeAcc = (gBrakeRatio / 0x100) * (specs->maxBrakeAcc / 0x100);
  brakeAcc = MIN(brakeAcc,__builtin_abs((carObj->linearVel_ch).z) * 32);
  if (
      (carObj->N).damage[9] != 0)
  {
    int damage; damage = 0x10000 - (carObj->N).damage[9] / 0x80;
    brakeAcc = (brakeAcc / 0x100) * (damage / 0x100);
  }
  if (0 < (carObj->linearVel_ch).z)
  { brakeAcc = -brakeAcc;
  } frontBrake = fixedmult(brakeAcc,specs->frontBrakeRatio);
  frontWheel.acc = frontWheel.acc + frontBrake;
  rearWheel.acc = rearWheel.acc + (brakeAcc - frontBrake);




  roadGrip = fixedmult(-gravity_ch.y,specs->lateralGripMult);


  Physics_CalculateRoadGripModifiers(carObj);
  roadGrip = (roadGrip / 0x100) * (roadMult / 0x100);

  if (roadGrip < 0)
  {
    return;
  }
  if (slippery != 0)
  { frontGrip = fixedmult(roadGrip,specs->frontGripBias + 0x28f);
  }
  else { frontGrip = fixedmult(roadGrip,specs->frontGripBias);
  }

  {
    int damage; int transferMult;
    damage = ((carObj->N).damage[4] + (carObj->N).damage[5] + (carObj->N).damage[6] + (carObj->N).damage[9]) / 0x200;
    transferMult = damage + 0xc000;

    carObj->gTransferFront = fixedmult(carObj->gTransferFront,transferMult);

    if (carObj->gTransferFront < 0)
    { carObj->gTransferFront = (carObj->gTransferFront / 0x100) * (transferMult / 0x100);
    } else if (0 < carObj->gTransferFront)
    { carObj->gTransferFront = carObj->gTransferFront * 3 / 4;
  } }

  frontWheel.roadGrip = frontGrip - carObj->gTransferFront;
  frontWheel.roadGrip = (frontMult / 0x100) * (frontWheel.roadGrip / 0x100);
  rearWheel.roadGrip = (roadGrip - frontGrip) + carObj->gTransferFront;
  rearWheel.roadGrip = (rearMult / 0x100) * (rearWheel.roadGrip / 0x100);





  carObj->wheelLock = 0;
  frontWheel.finalAcc.x = 0;
  frontWheel.finalAcc.z = 0;
  rearWheel.finalAcc.x = 0;
  rearWheel.finalAcc.z = 0;

  if (steeringControl != 0)
  { Physics_CalculateTireForces(carObj,&frontWheel);
  } if (powerControl != 0)
  { Physics_CalculateTireForces(carObj,&rearWheel);
  }



  (carObj->linearAcc_ch).z = frontWheel.finalAcc.z + rearWheel.finalAcc.z;
  (carObj->linearAcc_ch).x = frontWheel.finalAcc.x + rearWheel.finalAcc.x;
  (carObj->linearAcc_ch).z = fixedmult((carObj->linearAcc_ch).z,specs->lateralGripMultInv);


  if (PHYSICS_SGGE == 0x80)
  {
    if ((0 < (carObj->linearAcc_ch).z) && ((carObj->control).horn != '\0'))
    { (carObj->linearAcc_ch).z <<= 2;
    }
  }
  if (slippery == 0)
  {
    if ((carObj->carInfo->TireType == 2) && ((u_char)(carObj->control).gear < 4))
    { (carObj->linearAcc_ch).z = fixedmult((carObj->linearAcc_ch).z,0x12666);
    }
    else { (carObj->linearAcc_ch).z = fixedmult((carObj->linearAcc_ch).z,0x11999);
    }
  } (carObj->linearAcc_ch).y = 0;


  ratio = -fixedmult(gravity_ch.z,0x1999);
  carObj->gTransferRight = -fixedmult((carObj->linearAcc_ch).x / 8,specs->gTransferFactor);
  carObj->gTransferFront = fixedmult((carObj->linearAcc_ch).z,specs->gTransferFactor) + ratio;





  { int Xcomponent;
    Xcomponent = fixedmult(frontWheel.finalAcc.x - rearWheel.finalAcc.x, specs->accToAlphaRotInertia);
    finalAngularAcc_ch.y = fixedmult(fixedmult(frontWheel.finalAcc.z + rearWheel.finalAcc.z, leftMult - rightMult), specs->accToAlphaRotInertia);
    finalAngularAcc_ch.y = Xcomponent + finalAngularAcc_ch.y * 2;


    if ((((carObj->N).angularVel.y > 0) && (finalAngularAcc_ch.y > 0)) || (((carObj->N).angularVel.y < 0) && (finalAngularAcc_ch.y < 0)))
    {
      if (((carObj->control).handBrake != '\0') && ((PHYSICS_SGGE & 8U) == 0))
      { finalAngularAcc_ch.y = finalAngularAcc_ch.y / 2;
      }
      else
      { if (((((carObj->control).desiredSteering < 0) && (0x3333 < (carObj->N).angularVel.y)) || ((0 < (carObj->control).desiredSteering && ((carObj->N).angularVel.y < -0x3333)))) && (carObj->wheelSpin == 1))
        {
          finalAngularAcc_ch.y = -(carObj->N).angularVel.y;
        }
        else
        { finalAngularAcc_ch.y = fixedmult(finalAngularAcc_ch.y,carObj->specs->spinVelCap);
  } } } }

  finalAngularAcc_ch.x = 0;
  finalAngularAcc_ch.z = 0;





  transpose(&(carObj->N).shadowMat,&transposeMat);




  Cars_DoGravityEffectsOnAcc(carObj,0);

  (carObj->linearAcc).x = fixedmult((carObj->linearAcc_ch).x,transposeMat.m[0]) + fixedmult((carObj->linearAcc_ch).y,transposeMat.m[1]) + fixedmult((carObj->linearAcc_ch).z,transposeMat.m[2]);
  (carObj->linearAcc).y = fixedmult((carObj->linearAcc_ch).x,transposeMat.m[3]) + fixedmult((carObj->linearAcc_ch).y,transposeMat.m[4]) + fixedmult((carObj->linearAcc_ch).z,transposeMat.m[5]);
  (carObj->linearAcc).z = fixedmult((carObj->linearAcc_ch).x,transposeMat.m[6]) + fixedmult((carObj->linearAcc_ch).y,transposeMat.m[7]) + fixedmult((carObj->linearAcc_ch).z,transposeMat.m[8]);

  (carObj->angularAcc).x = fixedmult(finalAngularAcc_ch.x,transposeMat.m[0]) + fixedmult(finalAngularAcc_ch.y,transposeMat.m[1]) + fixedmult(finalAngularAcc_ch.z,transposeMat.m[2]);
  (carObj->angularAcc).y = fixedmult(finalAngularAcc_ch.x,transposeMat.m[3]) + fixedmult(finalAngularAcc_ch.y,transposeMat.m[4]) + fixedmult(finalAngularAcc_ch.z,transposeMat.m[5]);
  (carObj->angularAcc).z = fixedmult(finalAngularAcc_ch.x,transposeMat.m[6]) + fixedmult(finalAngularAcc_ch.y,transposeMat.m[7]) + fixedmult(finalAngularAcc_ch.z,transposeMat.m[8]);




  (carObj->N).linearVel.x += (carObj->linearAcc).x / 0x20;
  (carObj->N).linearVel.y += (carObj->linearAcc).y / 0x20;
  (carObj->N).linearVel.z += (carObj->linearAcc).z / 0x20;

  (carObj->N).angularVel.x += (carObj->angularAcc).x / 0x20;
  (carObj->N).angularVel.y += (carObj->angularAcc).y / 0x40;
  (carObj->N).angularVel.z += (carObj->angularAcc).z / 0x20;
  if (



      carObj->RSControl != 0)
  {
    int desiredRpm;
    int currentRpm;
    int diffRpm;
    int tempGas;
    if (carObj->desiredSpeed < 0x471c7)
    { desiredRpm = fixedmult(0x188000, specs->velToRpmRatio[ ((u_char)(carObj->control).gear < 2) ? 2 : (u_char)(carObj->control).gear]) / 0x10000;
    }
    else { desiredRpm = fixedmult(carObj->desiredSpeed, specs->velToRpmRatio[ ((u_char)(carObj->control).gear < 2) ? 2 : (u_char)(carObj->control).gear]) / 0x10000;
    }

    currentRpm = fixedmult((carObj->linearVel_ch).z, specs->velToRpmRatio[ ((u_char)(carObj->control).gear < 2) ? 2 : (u_char)(carObj->control).gear]) / 0x10000;
    diffRpm = desiredRpm - currentRpm;
    tempGas = (desiredRpm << 8) / specs->redline;


    if (diffRpm >= 0xc9)
    {
      tempGas += (diffRpm * 0x80) / desiredRpm;
      carObj->RSGasLevel = (char)MIN(0xe0,tempGas);
    }
    else if (diffRpm < 200)
    {
      tempGas = tempGas + (diffRpm * 0x80) / desiredRpm;
      carObj->RSGasLevel = (char)MAX(0,tempGas);

      if (diffRpm < 0)
      {

        tempGas = __builtin_abs(diffRpm << 9) / specs->redline;
        carObj->RSBrakeLevel = (char)MIN(0xff,tempGas);


        if (0x80 < (u_char)carObj->RSBrakeLevel)
        { carObj->RSGasLevel = '\0';
        }
      }
    }

    {
      int lookAhead = carObj->RSControl * MAX(3,__builtin_abs(carObj->currentSpeed) / 0x60000); int sliceAhead; coorddef carPos; coorddef dirVector;
      if (lookAhead >= 0) { sliceAhead = (carObj->N).simRoadInfo.slice + lookAhead; if (gNumSlices <= sliceAhead) { sliceAhead = sliceAhead - gNumSlices; } } else { sliceAhead = (carObj->N).simRoadInfo.slice + lookAhead; if (sliceAhead < 0) { sliceAhead = sliceAhead + gNumSlices;
      } } carPos = (carObj->N).position;
      dirVector = *(coorddef *)PHYSICS_SLICE_ADDR(sliceAhead); { int roadPosition; coorddef offset;




        roadPosition = Physics_CalculateRSControlDesiredPosition( carObj,sliceAhead,__builtin_abs(lookAhead * 3));

        offset.x = fixedmult( (int)(signed char)PHYSICS_SLICE_RIGHT(sliceAhead,0) << 9, roadPosition);
        offset.y = fixedmult( (int)(signed char)PHYSICS_SLICE_RIGHT(sliceAhead,1) << 9, roadPosition);
        offset.z = fixedmult( (int)(signed char)PHYSICS_SLICE_RIGHT(sliceAhead,2) << 9, roadPosition);
        dirVector.x += offset.x; dirVector.y += offset.y; dirVector.z += offset.z;
      }


      dirVector.x -= carPos.x; dirVector.y -= carPos.y; dirVector.z -= carPos.z;

      Math_NormalizeVector(&dirVector);






      carObj->RSSteering = (fixedmult(dirVector.x,(carObj->N).orientMat.m[0]) + fixedmult(dirVector.y,(carObj->N).orientMat.m[1]) + fixedmult(dirVector.z,(carObj->N).orientMat.m[2])) / 0x100;


      if (carObj->RSSteering > 0x7f)
      { carObj->RSSteering = 0x7f;
      } else if (carObj->RSSteering < -0x7f)
      { carObj->RSSteering = -0x7f;
  } } }





  if ((PHYSICS_SGGE & 8U) == 0)
  {
    if (((carObj->control).gasLevel == '\0') || (__builtin_abs(carObj->slide) >= 0x199a)) {
      (carObj->N).linearVel.x = fixedmult(carObj->specs->dragFactor,(carObj->N).linearVel.x); (carObj->N).linearVel.y = fixedmult(carObj->specs->dragFactor,(carObj->N).linearVel.y); (carObj->N).linearVel.z = fixedmult(carObj->specs->dragFactor,(carObj->N).linearVel.z);
    }
  }
  if (((carObj->N).driveSurfaceType == 3) && (0x2ca3d7 < (carObj->N).speedXZ))
  {
    (carObj->N).linearVel.x = fixedmult(0xfeb8,(carObj->N).linearVel.x); (carObj->N).linearVel.y = fixedmult(0xfeb8,(carObj->N).linearVel.y); (carObj->N).linearVel.z = fixedmult(0xfeb8,(carObj->N).linearVel.z);
  }
  else { if (((carObj->control).gear == '\x01') && (__builtin_abs(gravity_ch.z) < 0x8000))
    {
      int damp;

      if ((__builtin_abs((carObj->linearVel_ch).z) < 0x140000) || (__builtin_abs((carObj->control).steering) > 0x20))
      { damp = 0xfd70;
      }
      else
      {
        damp = 0xff7c; } (carObj->N).linearVel.x = fixedmult(damp,(carObj->N).linearVel.x); (carObj->N).linearVel.y = fixedmult(damp,(carObj->N).linearVel.y); (carObj->N).linearVel.z = fixedmult(damp,(carObj->N).linearVel.z);
      (carObj->N).angularVel.x = fixedmult(damp,(carObj->N).angularVel.x); (carObj->N).angularVel.y = fixedmult(damp,(carObj->N).angularVel.y); (carObj->N).angularVel.z = fixedmult(damp,(carObj->N).angularVel.z);
    }
    else if (((carObj->control).handBrake != '\0') && ((carObj->N).speedXZ <= 0xffff))
    { (carObj->N).linearVel.x = fixedmult(0x8000,(carObj->N).linearVel.x); (carObj->N).linearVel.y = fixedmult(0x8000,(carObj->N).linearVel.y); (carObj->N).linearVel.z = fixedmult(0x8000,(carObj->N).linearVel.z);
  }  }
}

/* ---- Physics_SimCar__FP8Car_tObj  [PHYSICS.CPP:2507-2532] COVERED-SLD-PASS ---- */
/* Source/SLD receipt: real low-orientation clearing,RPM decrement and altitude
 * stop/normal-physics arms recover all33 words and complete covered metadata.
 * Implicit fallthrough preserves exit2532;literal source text is unproved. */
#line 2505 "C:/nfs4/GAME/COMMON/PHYSICS.CPP"
void Physics_SimCar(Car_tObj *carObj)

{




  if (carObj->N.orientationToGround.y < 0x1999) {


    carObj->wheelSpin = 0;
    carObj->slide = 0;
    carObj->frontSkid = 0;
    carObj->rearSkid = 0;


    if (carObj->flywheelRpm >= 501)
      carObj->flywheelRpm -= 500;
    else
      carObj->flywheelRpm = 0;


    if (carObj->N.objAltitude < 0x8000)
      Physics_StopCar(carObj);
  } else


    Physics_Real(carObj);
}

/* end of physics.cpp */
