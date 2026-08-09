/* game/common/physics.cpp -- RECONSTRUCTED (NFS4 PSX car physics engine; C++ TU)
 *   22 fns: SimCar/Real driver + tire forces, traction circle, accel, autoshift, barrier, RS control.
 *   GTE-free (fixed-point + eaclib math). Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "physics_externs.h"

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


/* ---- Physics_InitCarSpecs__FP8Car_tObjP10Udff_tInfo  [PHYSICS.CPP:243-281] SLD-VERIFIED ---- */
void Physics_InitCarSpecs(Car_tObj *carObj,Udff_tInfo *handle)

{
  int iVar1;
  int iVar2;
  int i;
  int iVar3;
  
  iVar1 = Udff_GetInt(handle);
  carObj->specs->mass = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->numGears = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->gearShiftDelay = iVar1;
  iVar1 = 0;
  do {
    iVar2 = Udff_GetInt(handle);
    iVar3 = iVar1 + 1;
    carObj->specs->velToRpmRatio[iVar1] = iVar2;
    iVar1 = iVar3;
  } while (iVar3 < 8);
  iVar1 = 0;
  do {
    iVar2 = Udff_GetInt(handle);
    iVar3 = iVar1 + 1;
    carObj->specs->gearEfficiency[iVar1] = iVar2;
    iVar1 = iVar3;
  } while (iVar3 < 8);
  iVar1 = 0;
  do {
    iVar2 = Udff_GetInt(handle);
    iVar3 = iVar1 + 1;
    carObj->specs->torqueCurve[iVar1] = iVar2;
    iVar1 = iVar3;
  } while (iVar3 < 0x29);
  iVar1 = Udff_GetInt(handle);
  carObj->specs->redline = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->maxSpeed = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->frontDriveRatio = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->maxBrakeAcc = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->frontBrakeRatio = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->wheelBase = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->frontGripBias = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->maxSteeringAcc = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->steeringRamp = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->lateralGripMult = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->frontAeroDownForce = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->rearAeroDownForce = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->gasOffFactor = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->gTransferFactor = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->slideMultiplier = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->spinVelCap = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->dampingPitchRate = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->dampingRollRate = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->suspensionStiffness = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->pitchAngularVelCap = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->rollAngularVelCap = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->damageFactor = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->bodyPitchFactor = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->bodyRollFactor = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->tireRange = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->rideOffset = iVar1;
  iVar1 = Udff_GetInt(handle);
  carObj->specs->dragFactor = iVar1;
  return;
}

/* ---- Physics_CalculateDerivedCarSpecs__FP8Car_tObj  [PHYSICS.CPP:287-406] SLD-VERIFIED ---- */
void Physics_CalculateDerivedCarSpecs(Car_tObj *carObj)

{
  int i;
  int rpmAtMaxSpeedInHighestGear;
  int accAtMaxSpeedInHighestGear;

  i = 0;
  carObj->specs->redlineInv = 0x10000 / carObj->specs->redline;
  if (carObj->carInfo->WeightTransfer == 1) {
    carObj->specs->steeringRamp = carObj->specs->steeringRamp + 1;
    carObj->specs->maxSteeringAcc =
        fixedmult(carObj->specs->maxSteeringAcc,0x1147a);
  }
  if (carObj->carInfo->GroundEffects == 1) {
    carObj->specs->steeringRamp = carObj->specs->steeringRamp + 1;
    carObj->specs->frontAeroDownForce =
        fixedmult(carObj->specs->frontAeroDownForce,0x13333);
    carObj->specs->rearAeroDownForce =
        fixedmult(carObj->specs->rearAeroDownForce,0x13333);
    carObj->specs->mass = fixedmult(carObj->specs->mass,0xcccc);
    carObj->specs->lateralGripMult =
        fixedmult(carObj->specs->lateralGripMult,0x11999);
  }
  if (carObj->carInfo->EngineMods == 1) {
    carObj->specs->gearShiftDelay = carObj->specs->gearShiftDelay / 2;
    carObj->specs->maxBrakeAcc =
        fixedmult(carObj->specs->maxBrakeAcc,0x14000);
    do {
      carObj->specs->torqueCurve[i] =
          fixedmult(carObj->specs->torqueCurve[i],0x12666);
      i++;
    } while (i < 41);
    carObj->specs->maxSpeed = fixedmult(carObj->specs->maxSpeed,0x11999);
  }

  for (i = 0; i < carObj->specs->numGears; i++) {
    if (carObj->specs->velToRpmRatio[i] != 0) {
      carObj->specs->velToRpmRatioInv[i] =
          fixeddiv(0x10000,carObj->specs->velToRpmRatio[i]);
    }
    else {
      carObj->specs->velToRpmRatioInv[i] = 0x28f;
    }
    carObj->specs->gearAccCoeff[i] =
        fixeddiv(carObj->specs->velToRpmRatio[i],carObj->specs->mass);
    carObj->specs->gearAccCoeff[i] =
        fixeddiv(carObj->specs->gearAccCoeff[i],0xa0000);
    carObj->specs->gearAccCoeff[i] =
        fixedmult(carObj->specs->gearAccCoeff[i],
                  carObj->specs->gearEfficiency[i]);
    carObj->specs->gearVelInv[i] =
        fixeddiv(0x10000,
                 fixedmult(carObj->specs->velToRpmRatioInv[i],
                           carObj->specs->redline << 16));
  }

  rpmAtMaxSpeedInHighestGear =
      fixedmult(carObj->specs->maxSpeed,
                carObj->specs->velToRpmRatio[
                    carObj->specs->numGears - 1]) / 0x10000;
  accAtMaxSpeedInHighestGear =
      fixedmult(carObj->specs->torqueCurve[
                    rpmAtMaxSpeedInHighestGear / 0x100],
                carObj->specs->gearAccCoeff[carObj->specs->numGears - 1]);
  carObj->specs->dragCoeff =
      fixeddiv(accAtMaxSpeedInHighestGear,
               (carObj->specs->maxSpeed / 0x10000) *
               (carObj->specs->maxSpeed / 0x10000) *
               (carObj->specs->maxSpeed / 0x10000));

  if (7 < GameSetup_gData.track) {
    carObj->specs->gasOffFactor = carObj->specs->gasOffFactor + 0x2666;
    carObj->specs->frontBrakeRatio = carObj->specs->frontBrakeRatio - 0x2666;
    carObj->specs->frontGripBias = carObj->specs->frontGripBias + 0x147;
  }

  carObj->specs->alphaToAccRotInertia =
      fixedmult(0x10000,carObj->specs->wheelBase / 2);
  carObj->specs->alphaToAccRotInertia =
      fixedmult(carObj->specs->alphaToAccRotInertia,0x648);
  carObj->specs->alphaToAccRotInertia <<= 8;
  carObj->specs->accToAlphaRotInertia =
      fixeddiv(0x10000,carObj->specs->alphaToAccRotInertia);
  carObj->specs->lateralGripMultInv =
      fixeddiv(0x10000,carObj->specs->lateralGripMult);
}

/* ---- Physics_CheckGamedata__Fv  [PHYSICS.CPP:414-465] SLD-VERIFIED ---- */
void Physics_CheckGamedata(void)

{
  return;
}

/* ---- Physics_AttenuateVelocity__FP8Car_tObjiP10matrixtdef  [PHYSICS.CPP:591-659] SLD-VERIFIED ---- */
int Physics_AttenuateVelocity(Car_tObj *carObj,int force,matrixtdef *roadMat)

{
  int vy;
  register int vx;
  int vz;
  int absvelbx;
  coorddef vel_b;
  matrixtdef transposeMat;

  vel_b.x = force;
  vel_b.y = 0;
  vel_b.z = 0;
  vx = (vel_b.x / 0x100) * (roadMat->m[0] / 0x100) +
       (vel_b.y / 0x100) * (roadMat->m[1] / 0x100) +
       (vel_b.z / 0x100) * (roadMat->m[2] / 0x100);
  vy = (vel_b.x / 0x100) * (roadMat->m[3] / 0x100) +
       (vel_b.y / 0x100) * (roadMat->m[4] / 0x100) +
       (vel_b.z / 0x100) * (roadMat->m[5] / 0x100);
  vz = (vel_b.x / 0x100) * (roadMat->m[6] / 0x100) +
       (vel_b.y / 0x100) * (roadMat->m[7] / 0x100) +
       (vel_b.z / 0x100) * (roadMat->m[8] / 0x100);
  (carObj->N).position.x -= vx;
  (carObj->N).position.y += vy;
  (carObj->N).position.z += vz;

  vel_b.x = -(((carObj->N).linearVel.x / 0x100) * (roadMat->m[0] / 0x100) +
              ((carObj->N).linearVel.y / 0x100) * (roadMat->m[1] / 0x100) +
              ((carObj->N).linearVel.z / 0x100) * (roadMat->m[2] / 0x100));
  vel_b.z = ((carObj->N).linearVel.x / 0x100) * (roadMat->m[6] / 0x100) +
            ((carObj->N).linearVel.y / 0x100) * (roadMat->m[7] / 0x100) +
            ((carObj->N).linearVel.z / 0x100) * (roadMat->m[8] / 0x100);
  absvelbx = ((0 <= vel_b.x) ? vel_b.x : -vel_b.x) >> 1;
  vel_b.x = 0;
  if (0 < vel_b.z) {
    if (0x50000 < vel_b.z) {
      vel_b.z -= (absvelbx / 0x100) * 0xc0;
      if (vel_b.z < 0) {
        vel_b.z = 0;
      }
    }
  }
  else {
    if (vel_b.z < -0x50000) {
      vel_b.z += (absvelbx / 0x100) * 0xc0;
      if (0 < vel_b.z) {
        vel_b.z = 0;
      }
    }
  }
  transpose(roadMat,&transposeMat);
  (carObj->N).linearVel.x = fixedmult(vel_b.x,transposeMat.m[0]) +
                            fixedmult(vel_b.y,transposeMat.m[1]) +
                            fixedmult(vel_b.z,transposeMat.m[2]);
  (carObj->N).linearVel.z = fixedmult(vel_b.x,transposeMat.m[6]) +
                            fixedmult(vel_b.y,transposeMat.m[7]) +
                            fixedmult(vel_b.z,transposeMat.m[8]);
  if (0 < (carObj->N).linearVel.y) {
    (carObj->N).linearVel.y = 0;
  }
  (carObj->linearVel_ch).x = fixedmult((carObj->N).linearVel.x,(carObj->N).orientMat.m[0]) +
                             fixedmult((carObj->N).linearVel.y,(carObj->N).orientMat.m[1]) +
                             fixedmult((carObj->N).linearVel.z,(carObj->N).orientMat.m[2]);
  (carObj->linearVel_ch).y = fixedmult((carObj->N).linearVel.x,(carObj->N).orientMat.m[3]) +
                             fixedmult((carObj->N).linearVel.y,(carObj->N).orientMat.m[4]) +
                             fixedmult((carObj->N).linearVel.z,(carObj->N).orientMat.m[5]);
  (carObj->linearVel_ch).z = fixedmult((carObj->N).linearVel.x,(carObj->N).orientMat.m[6]) +
                             fixedmult((carObj->N).linearVel.y,(carObj->N).orientMat.m[7]) +
                             fixedmult((carObj->N).linearVel.z,(carObj->N).orientMat.m[8]);

  {
    int x = (0 <= (carObj->N).linearVel.x) ?
            (carObj->N).linearVel.x : -(carObj->N).linearVel.x;
    int z = (0 <= (carObj->N).linearVel.z) ?
            (carObj->N).linearVel.z : -(carObj->N).linearVel.z;
    (carObj->N).speedXZ =
        (x > z) ? x + (z >> 2) : z + (x >> 2);
  }
  return absvelbx;
}

/* ---- Physics_SetCurrentWallType__Fi  [PHYSICS.CPP:665-666] SLD-VERIFIED ---- */
void Physics_SetCurrentWallType(int wallType)

{
  currentWallType = wallType;
  return;
}

/* ---- Physics_GetTorque__FP8Car_tObji  [PHYSICS.CPP:672-674] SLD-VERIFIED ---- */
int Physics_GetTorque(Car_tObj *carObj,int index)

{
  int iVar1;
  int iVar2;
  
  iVar1 = index;
  if (0x28 < index) {
    iVar1 = 0x28;
  }
  iVar2 = 0;
  if ((0 < iVar1) && (iVar2 = 0x28, 0x28 >= index)) {
    iVar2 = index;
  }
  return carObj->specs->torqueCurve[iVar2];
}

/* ---- Physics_CorrectPostCollisionYaw__FP8Car_tObjiG8coorddef  [PHYSICS.CPP:680-721] SLD-VERIFIED ---- */
void Physics_CorrectPostCollisionYaw(Car_tObj *carObj,int impactVel,coorddef barrierVec)

{
  int diffZ;
  int diffX;
  int result;

  (carObj->N).collision.impulse = impactVel * 6;
  (carObj->N).collision.otherObj = (BO_tNewtonObj *)0x0;
  (carObj->N).collision.sfxType = currentWallType | 0x40000;
  if ((impactVel < 0xf0000) || ((carObj->linearVel_ch).z < 0x140000)) {
    diffZ = fixedmult(barrierVec.x,(carObj->N).shadowMat.m[6]) +
            fixedmult(barrierVec.y,(carObj->N).shadowMat.m[7]) +
            fixedmult(barrierVec.z,(carObj->N).shadowMat.m[8]);
    diffX = fixedmult(barrierVec.x,(carObj->N).shadowMat.m[0]) +
            fixedmult(barrierVec.y,(carObj->N).shadowMat.m[1]) +
            fixedmult(barrierVec.z,(carObj->N).shadowMat.m[2]);
    /* MATCH: zero-insn USE FENCE (sched-issue-position fixpoint, catalog 05C/w45).
       Without it sched2 sinks the two closing `addu s0,s0,*` of the diffX sum
       BELOW the abs(diffZ) block; retail completes the sum in place (SLD 696
       before 697).  Operand-less/void form only -- adding a 2nd operand
       ("r"(diffX),"r"(diffZ)) costs 42 diffs (fence-operand selectivity). */
    __asm__("" : : "i"(0));
    result = __builtin_abs(diffZ);
    if (__builtin_abs(diffX) < result) {
      result = __builtin_abs(diffX) >> 1;
    }
    else {
      result = result >> 1;
    }
    if (diffZ < 0) {
      if (diffX < 0) {
        result = -result;
      }
    }
    else {
      if (0 < diffX) {
        result = -result;
      }
      result = result >> 1;
    }
    if ((0xd6666 < (carObj->linearVel_ch).z) &&
       (((0 < result && (0 < (carObj->control).steering)) ||
        ((result < 0 && ((carObj->control).steering < 0)))))) {
      result = result >> 2;
    }
    (carObj->N).angularVel.y = result;
  }
  return;
}

/* ---- Physics_DoBarrierCheck__FP8Car_tObj  [PHYSICS.CPP:761-932] SLD-VERIFIED ---- */
int Physics_DoBarrierCheck(Car_tObj *carObj)

{
  int diff = 0;
  int carCollisionWidth;
  int x_relRoad;
  int wallType;
  int collide;
  coorddef vel_b;
  coorddef right;
  coorddef normal;
  int slice;

  slice = (carObj->N).simRoadInfo.slice;
  {
    {
    int r1;
    int r2;
    int r3;

    r1 = (int)(signed char)BWorldSm_slices[slice].right[0];
    r3 = (int)(signed char)BWorldSm_slices[slice].right[2];
    right.x = r1 * 0x200;
    r2 = (int)(signed char)BWorldSm_slices[slice].right[1];
    collide = diff;
    right.z = r3 * 0x200;
    right.y = r2 * 0x200;
    {
      int x1;
      int x2;
      int x3;

      vel_b.x = (((carObj->N).linearVel.x >> 5) + (carObj->N).position.x) - BWorldSm_slices[slice].center[0];
      vel_b.y = (((carObj->N).linearVel.y >> 5) + (carObj->N).position.y) - BWorldSm_slices[slice].center[1];
      vel_b.z = (((carObj->N).linearVel.z >> 5) + (carObj->N).position.z) - BWorldSm_slices[slice].center[2];
      x1 = right.x / 0x100 * (vel_b.x / 0x100);
      x2 = right.y / 0x100 * (vel_b.y / 0x100);
      x3 = right.z / 0x100 * (vel_b.z / 0x100);
      x_relRoad = x1 + x2 + x3;
    }
    (carObj->N).xRelRoadCenter = x_relRoad;
    }

    {
    int r1;
    int r2;
    int r3;
    int x1;
    int x2;
    int x3;

    r1 = (carObj->N).orientMat.m[6];
    r2 = (carObj->N).orientMat.m[7];
    r3 = (carObj->N).orientMat.m[8];
    x1 = right.x / 0x100 * (r1 / 0x100);
    x2 = right.y / 0x100 * (r2 / 0x100);
    x3 = right.z / 0x100 * (r3 / 0x100);
    carCollisionWidth =
      (0 < fixedmult((carObj->N).dimension.z,x1 + x2 + x3)) ?
      fixedmult((carObj->N).dimension.z,x1 + x2 + x3) :
      -fixedmult((carObj->N).dimension.z,x1 + x2 + x3);

    r1 = (carObj->N).orientMat.m[0];
    r2 = (carObj->N).orientMat.m[1];
    r3 = (carObj->N).orientMat.m[2];
    x1 = r1 / 0x100 * (right.x / 0x100);
    x2 = r2 / 0x100 * (right.y / 0x100);
    x3 = r3 / 0x100 * (right.z / 0x100);
    carCollisionWidth +=
      (0 < ((carObj->N).dimension.x / 0x100 * ((x1 + x2 + x3) / 0x100))) ?
      ((carObj->N).dimension.x / 0x100 * ((x1 + x2 + x3) / 0x100)) :
      -((carObj->N).dimension.x / 0x100 * ((x1 + x2 + x3) / 0x100));
    r2 = carCollisionWidth - BWorldSm_slices[slice].leftDrive * 0x100;
    if (x_relRoad < r2 - carObj->extraWallCollisionAllowance) {
      collide = -1;
      diff = r2 - x_relRoad;
      currentWallType = 1;
    }
    r3 = BWorldSm_slices[slice].rightDrive * 0x100 - carCollisionWidth;
    if (r3 + carObj->extraWallCollisionAllowance < x_relRoad) {
      collide = 1;
      diff = x_relRoad - r3;
      currentWallType = 1;
    }
    }
  }
  if (collide != 0) {
    if (Force_IsForceOn(carObj) != 0) {
      Force_HitWall(0x1e0000);
    }
    {
      coorddef widthVector;

      widthVector.x = ((carObj->N).dimension.x / 0x100 * right.x) / 0x100;
      widthVector.y = ((carObj->N).dimension.x / 0x100 * right.y) / 0x100;
      widthVector.z = ((carObj->N).dimension.x / 0x100 * right.z) / 0x100;
      if (0 < collide) {
        (carObj->N).collision.collisionPoint.x = (carObj->N).position.x + widthVector.x;
        (carObj->N).collision.collisionPoint.y = (carObj->N).position.y + widthVector.y;
        (carObj->N).collision.collisionPoint.z = (carObj->N).position.z + widthVector.z;
      }
      else {
        (carObj->N).collision.collisionPoint.x = (carObj->N).position.x - widthVector.x;
        (carObj->N).collision.collisionPoint.y = (carObj->N).position.y - widthVector.y;
        (carObj->N).collision.collisionPoint.z = (carObj->N).position.z - widthVector.z;
      }
    }
    if (((carObj->N).objAltitude >= 0x999a) ||
        ((carObj->N).orientationToGround.y <= 0xe665) ||
        ((carObj->N).flightTime != 0)) {
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
        (carObj->N).collision.otherObj = (BO_tNewtonObj *)0x0;
        (carObj->N).collision.sfxType = currentWallType | 0x40000;
      }
    }
    else {
      int impact;

      impact = __builtin_abs(diff * 2);
      wallType = Physics_AttenuateVelocity(carObj,collide * impact,&(carObj->N).roadMatrix);
      Physics_CorrectPostCollisionYaw(carObj,wallType,normal);
    }
    return collide;
  }
  return 0;
}

/* ---- Physics_AutoShift__FP8Car_tObj  [PHYSICS.CPP:938-1038] SLD-VERIFIED ---- */
void Physics_AutoShift(Car_tObj *carObj)

{
  int wheelRpm;
  int previousRpm;
  int previousGear;
  int nextGear;
  int SkipLastGear;
  int ShiftPoint;
  int sliding;

  previousRpm = carObj->specs->redline;
  SkipLastGear = 0;
  ShiftPoint = previousRpm - previousRpm / 6;
  if (1 < (u_char)(carObj->control).gear) {
    if (carObj->RSControl != 0) {
      ShiftPoint = previousRpm - previousRpm / 2;
    }
    sliding = (0 <= carObj->slide) ? carObj->slide : -carObj->slide;
    previousRpm = fixedmult(
        carObj->specs->velToRpmRatioInv[carObj->specs->numGears - 2],
        previousRpm << 0x10);
    if (carObj->specs->maxSpeed < previousRpm) {
      SkipLastGear = 1;
    }
    {
      int lastGearOffset = SkipLastGear + 1;

      nextGear = (u_char)(carObj->control).gear;
      if (nextGear < carObj->specs->numGears - lastGearOffset) {
        nextGear++;
      }
    }
    previousGear = (u_char)(carObj->control).gear;
    if (2 < previousGear) {
      previousGear--;
    }
    {
      int velocity;

      velocity = (carObj->N).speedXZ;
      if ((carObj->linearVel_ch).z < 0) {
        velocity = -velocity;
      }
      wheelRpm = fixedmult(velocity,
                           carObj->specs->velToRpmRatio[(u_char)(carObj->control).gear]) /
                 0x10000;
      fixedmult(velocity,carObj->specs->velToRpmRatio[nextGear]);
      previousRpm = fixedmult(velocity,carObj->specs->velToRpmRatio[previousGear]) /
                    0x10000;
    }
    {
      if ((0x8000 < gGasRatio) ||
          (carObj->specs->redline <
           ((0 <= wheelRpm) ? wheelRpm : -wheelRpm))) {
        if (ShiftPoint + 500 < wheelRpm) {
          if ((u_char)(carObj->control).gear <
              carObj->specs->numGears - (SkipLastGear + 1)) {
            if (nextGear != (u_char)(carObj->control).gear) {
              char oldGear = (carObj->control).gear;

              (carObj->control).downShifting = '\0';
              (carObj->control).gear = (char)nextGear;
              (carObj->control).lastGear = oldGear;
              (carObj->control).gearShiftTimer = (char)carObj->specs->gearShiftDelay;
            }
            return;
          }
        }
        if ((previousRpm < ShiftPoint) &&
            (previousGear != (u_char)(carObj->control).gear)) {
          char oldGear = (carObj->control).gear;

          (carObj->control).downShifting = '\x01';
          (carObj->control).gear = (char)previousGear;
          (carObj->control).lastGear = oldGear;
          (carObj->control).gearShiftTimer = (char)carObj->specs->gearShiftDelay;
        }
      }
      else if ((previousRpm < ShiftPoint) &&
               (1 < previousGear) &&
               (sliding < 0x1999) &&
               (previousGear != (u_char)(carObj->control).gear)) {
        (carObj->control).downShifting = '\x01';
        (carObj->control).gear = (char)previousGear;
        (carObj->control).gearShiftTimer = (char)carObj->specs->gearShiftDelay;
      }
    }
  }
  return;
}

/* ---- Physics_RampCarControlValues__FP8Car_tObj  [PHYSICS.CPP:1044-1278] SLD-VERIFIED ---- */
void Physics_RampCarControlValues(Car_tObj *carObj)

{
  int diff;
  int iVar5;
  int i;
  int gear;
  
  if ((carObj->RSControl != 0) && ((u_char)(carObj->control).gear < 2)) {
    (carObj->control).desiredGear = '\x02';
    (carObj->control).gear = '\x02';
  }
  if (1 < (carObj->stats).finishType) {
    (carObj->control).steering = 0;
    (carObj->control).gasLevel = '\0';
    (carObj->control).brakeLevel = -1;
    (carObj->control).downShifting = '\0';
    (carObj->control).hanno = 0;
    (carObj->N).linearVel.x = (carObj->N).linearVel.x * 0xfe / 0x100;
    (carObj->N).linearVel.y = (carObj->N).linearVel.y * 0xfe / 0x100;
    (carObj->N).linearVel.z = (carObj->N).linearVel.z * 0xfe / 0x100;
    goto RampCtrl_earlyBrake;
  }
  {
    char inc;

    if (carObj->carInfo->RampGas != 0) {
      inc = 0x24;
    }
    else {
      inc = 0x30;
    }
    diff = (carObj->control).desiredGasLevel - (carObj->control).gasLevel;
    if (diff >= 0) {
      /* MATCH: explicit min-clamp into `diff` then a plain += (14->10).  The
         `+= (cond ? diff : inc)` ternary makes gcc funnel the selected value
         through inc's register (extra `addu a0,v1,zero`); clamping diff in
         place lets both jump-opt arms add their own register like retail. */
      if (diff >= (u_char)inc) { diff = (u_char)inc; }
      (carObj->control).gasLevel += diff;
    }
    else {
      diff = -diff;
      if (diff >= (u_char)inc) { diff = (u_char)inc; }
      (carObj->control).gasLevel -= diff;
    }
    /* RECEIPT (w55-a11): the 8-diff residual here is the non-propagated reg-reg copy
       class -- oracle `addu v0,a1,a0` (adds the masked inc register straight in),
       ours inserts `addu v1,a0,zero` first, so we run 2 LONGER (504 vs 502).
       Oracle shape decoded at 800A9E18-800A9E44: the two arms are value-selects
       feeding ONE cross-jump-merged `sb v0,0x43F(s1)`, polarity `slt v0,diff,inc;
       bnez -> use diff`.  MEASURED BASINS: base 10 @504 | yoda 10 @504 |
       u_char step local 10 @504 | tern `(diff<inc)?diff:inc` 14 @504 |
       tern via explicit `gasLevel = gasLevel +/- (...)` 14 @504 |
       if/else per-arm += 31 @499 | mutate-inc (`if(diff<inc) inc=diff;`) 20 @502
       COUNT-EXACT | tern `>=` polarity 32 @502 COUNT-EXACT.  => two COUNT-EXACT
       basins exist (mutate-inc, tern-ge); per the floor bar the count-exact basin is
       the structurally right one, so the next agent should grind coloring FROM
       mutate-inc (20) rather than from the lower-scoring 10, and re-probe the
       falsified spellings there (falsifications are basin-relative, w45 05I). */
  }
  if (carObj->carInfo->RampBrake != 0) {
    diff = (carObj->control).desiredBrakeLevel - (carObj->control).brakeLevel;
    if (diff >= 0) {
      if (diff < 0x10) {
        (carObj->control).brakeLevel += diff;
      }
      else {
        (carObj->control).brakeLevel += 0x10;
      }
    }
    else {
      diff = -diff;
      if (diff < 0x10) {
        (carObj->control).brakeLevel -= diff;
      }
      else {
        (carObj->control).brakeLevel -= 0x10;
      }
    }
  }
  else {
    (carObj->control).brakeLevel = (carObj->control).desiredBrakeLevel;
  }
  if ((carObj->control).gearShiftTimer > 0) {
    (carObj->control).gearShiftTimer--;
  }
  if (0x200 < simGlobal.gameTicks) {
    if (GameSetup_gData.carInfo[carObj->carIndex].Transmission == 1) {
      if ((simGlobal.gameTicks < 0x208) &&
         (((GameSetup_gData.raceType != 1 && (GameSetup_gData.raceType != 5)) ||
          (((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0 &&
           ((Cars_gNumHumanRaceCars != 2 || ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0))))
          )))) {
        (carObj->control).desiredGear = '\x02';
      }
      else {
        if (((carObj->control).desiredGear == (carObj->control).gear) &&
            ((carObj->stats).finishType == 0)) {
          if ((carObj->pullOver == 0) && (carObj->blowout == 0)) {
            if ((((carObj->N).speedXZ < 0) ? -(carObj->N).speedXZ :
                 (carObj->N).speedXZ) < 0x3333) {
              if (((u_char)(carObj->control).desiredBrakeLevel > 0x80) &&
                  ((carObj->control).desiredGasLevel == '\0') &&
                  ((u_char)(carObj->control).desiredGear >= 2) &&
                  ((carObj->control).hanno == 0)) {
                (carObj->control).desiredGear = '\0';
                (carObj->control).hanno = 1;
              }
              else {
                if ((((((carObj->N).speedXZ < 0) ? -(carObj->N).speedXZ :
                       (carObj->N).speedXZ) < 0x3333) &&
                     (0x80 < (u_char)(carObj->control).desiredGasLevel)) &&
                   (((carObj->control).gear == '\0' && ((carObj->control).hanno != 0)))) {
                  (carObj->control).desiredGear = '\x02';
                  (carObj->control).hanno = 0;
                }
              }
            }
          }
        }
        else {
          (carObj->control).hanno = 0;
        }
      }
    }
    if ((carObj->control).desiredGear != (carObj->control).gear) {
      if ((GameSetup_gData.carInfo[carObj->carIndex].Transmission == 1) ||
          (carObj->RSControl != 0)) {
        if ((u_char)(carObj->control).desiredGear < 2) {
          (carObj->control).downShifting = '\0';
          (carObj->control).lastGear = (carObj->control).gear;
          (carObj->control).gear = (carObj->control).desiredGear;
          (carObj->control).gearShiftTimer = (char)carObj->specs->gearShiftDelay;
        }
        else if (((carObj->control).desiredGear == 2) &&
                 ((u_char)(carObj->control).gear < 2)) {
          (carObj->control).lastGear = (carObj->control).gear;
          gear = 2;
          for (i = 2; i < carObj->specs->numGears; i++) {
            if (fixedmult(carObj->specs->velToRpmRatioInv[i],
                          carObj->specs->redline << 0x10) <
                (carObj->linearVel_ch).z) {
              gear = i;
            }
          }
          (carObj->control).downShifting = '\0';
          (carObj->control).gear = gear;
          (carObj->control).gearShiftTimer = (char)carObj->specs->gearShiftDelay;
        }
      }
      else {
        if (((u_char)(carObj->control).desiredGear <
             (u_char)(carObj->control).gear) &&
            (1 < (u_char)(carObj->control).desiredGear)) {
          (carObj->control).downShifting = '\x01';
        }
        else {
          (carObj->control).downShifting = '\0';
        }
        (carObj->control).lastGear = (carObj->control).gear;
        (carObj->control).gear = (carObj->control).desiredGear;
        (carObj->control).gearShiftTimer = (char)carObj->specs->gearShiftDelay;
      }
    }
  }
RampCtrl_setSteering:
  if (carObj->carInfo->RampSteering != 0) {
    int rampIn;

    rampIn = carObj->specs->steeringRamp;
    diff = (carObj->control).desiredSteering - (carObj->control).steering;
    if (diff >= 0) {
      if (diff < rampIn) {
        (carObj->control).steering += diff;
      }
      else {
        (carObj->control).steering += rampIn;
      }
    }
    else {
      diff = -diff;
      if (diff < rampIn) {
        (carObj->control).steering -= diff;
      }
      else {
        (carObj->control).steering -= rampIn;
      }
    }
  }
  else {
    (carObj->control).steering = (carObj->control).desiredSteering;
  }
RampCtrl_earlyBrake:
  if ((simGlobal.gameTicks < 0x200) &&
     (((GameSetup_gData.raceType != 1 && (GameSetup_gData.raceType != 5)) ||
      (((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0 &&
       ((Cars_gNumHumanRaceCars != 2 || ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0))))))))
  {
    (carObj->control).brakeLevel = -1;
  }
  else if ((carObj->blowout != 0) || (carObj->pullOver != 0)) {
    if ((carObj->control).hanno != 0) {
      (carObj->control).gasLevel = -0x80;
      (carObj->control).brakeLevel = '\0';
    }
    else {
      (carObj->control).gasLevel = '\0';
      (carObj->control).brakeLevel = -0x80;
    }
    (carObj->control).downShifting = '\0';
  }
  if (carObj->crash == 2) {
    (carObj->control).gasLevel = '\0';
  }
  if ((AIInit_forceHumanHandBrake != 0) && (carObj->RSControl != 0)) {
    if (carObj->roadPosition * carObj->direction > 0) {
      (carObj->control).steering = -0x7c;
    }
    else {
      (carObj->control).steering = 0x7c;
    }
    (carObj->control).handBrake = '\x01';
  }
  iVar5 = (((u_char)(carObj->control).gasLevel + 1) * 0x10000) / 0xf8;
  if (0x10000 < iVar5) {
    iVar5 = 0x10000;
  }
  gGasRatio = iVar5;
  iVar5 = (((u_char)(carObj->control).brakeLevel + 1) * 0x10000) / 0xf8;
  if (0x10000 < iVar5) {
    iVar5 = 0x10000;
  }
  gBrakeRatio = iVar5;
  /* MATCH: __builtin_abs INLINE in the shift expression (27->14).  The hand-rolled
     `if (x<0) x = -x;` lets gcc speculate the `sll` into the bgez delay slot AND
     re-emit it after the negu (two slls); the builtin's bgez/negu/sll idiom is
     retail's.  Routing it through iVar5 first only reaches 22/26 -- the operand
     must be the field read itself (methodology 5.0c __builtin_abs lever). */
  gSteerRatio = __builtin_abs((carObj->control).steering) << 9;
  if (((GameSetup_gData.carInfo[carObj->carIndex].Transmission == 1) &&
      ((carObj->control).gear == '\0')) && ((carObj->control).hanno == 1)) {
    iVar5 = (((u_char)(carObj->control).brakeLevel + 1) * 0x10000) / 0xf8;
    if (0x10000 < iVar5) {
      iVar5 = 0x10000;
    }
    gGasRatio = iVar5;
    iVar5 = (((u_char)(carObj->control).gasLevel + 1) * 0x10000) / 0xf8;
    if (0x10000 < iVar5) {
      iVar5 = 0x10000;
    }
    gBrakeRatio = iVar5;
  }
  return;
}

/* ---- Physics_FixEngineRpm__FP8Car_tObj  [PHYSICS.CPP:1287-1307] SLD-VERIFIED ---- */
void Physics_FixEngineRpm(Car_tObj *carObj)

{
  int iVar4;

  iVar4 = (carObj->N).collision.collided;
  (carObj->linearVel_ch).x =
       (carObj->N).linearVel.x / 256 * ((carObj->N).shadowMat.m[0] / 256) +
       (carObj->N).linearVel.y / 256 * ((carObj->N).shadowMat.m[1] / 256) +
       (carObj->N).linearVel.z / 256 * ((carObj->N).shadowMat.m[2] / 256);
  (carObj->linearVel_ch).z =
       (carObj->N).linearVel.x / 256 * ((carObj->N).shadowMat.m[6] / 256) +
       (carObj->N).linearVel.y / 256 * ((carObj->N).shadowMat.m[7] / 256) +
       (carObj->N).linearVel.z / 256 * ((carObj->N).shadowMat.m[8] / 256);
  carObj->wheelSpin = 0;
  carObj->slide = 0;
  carObj->frontSkid = 0;
  carObj->rearSkid = 0;
  if (iVar4 == 2) {
    (carObj->N).collision.collided = 0;
  }
  return;
}

/* ---- Physics_ResetCar__FP8Car_tObj  [PHYSICS.CPP:1313-1358] SLD-VERIFIED ---- */
void Physics_ResetCar(Car_tObj *carObj)

{
  int i;

  if (carObj->carInfo->Transmission == 1) {
    (carObj->control).desiredGear = '\x02';
    (carObj->control).gear = '\x02';
  }
  else {
    (carObj->control).desiredGear = '\x01';
    (carObj->control).gear = '\x01';
  }
  (carObj->linearAcc).x = 0;
  (carObj->linearAcc).y = 0;
  (carObj->linearAcc).z = 0;
  (carObj->angularAcc).x = 0;
  (carObj->angularAcc).y = 0;
  (carObj->angularAcc).z = 0;
  (carObj->linearVel_ch).x = 0;
  (carObj->linearVel_ch).y = 0;
  (carObj->linearVel_ch).z = 0;
  (carObj->angularVel_ch).x = 0;
  (carObj->angularVel_ch).y = 0;
  (carObj->angularVel_ch).z = 0;
  carObj->wheelSpin = 0;
  carObj->slide = 0;
  carObj->frontSkid = 0;
  carObj->rearSkid = 0;
  carObj->crash = 0;
  carObj->blowout = 0;
  (carObj->control).hanno = 0;
  for (i = 0; i < 4; i++) {
    carObj->wheel[i].wheelInAir = 0;
    carObj->wheel[i].rebound = 0;
  }
  return;
}

/* ---- Physics_StopCar__FP8Car_tObj  [PHYSICS.CPP:1364-1370] SLD-VERIFIED ---- */
void Physics_StopCar(Car_tObj *carObj)

{
  int iVarX;
  int iVarY;
  int iVarZ;
  int iVarW;

  iVarX = (carObj->N).linearVel.x * 0xf5;
  if (iVarX < 0) {
    iVarX = iVarX + 0xff;
  }
  (carObj->N).linearVel.x = iVarX >> 8;
  iVarY = (carObj->N).linearVel.y * 0xf5;
  if (iVarY < 0) {
    iVarY = iVarY + 0xff;
  }
  (carObj->N).linearVel.y = iVarY >> 8;
  iVarZ = (carObj->N).linearVel.z * 0xf5;
  if (iVarZ < 0) {
    iVarZ = iVarZ + 0xff;
  }
  (carObj->N).linearVel.z = iVarZ >> 8;
  if ((carObj->N).orientationToGround.y < 0x3333) {
    iVarW = (carObj->N).angularVel.y;
    if (iVarW < 0) {
      iVarW = iVarW + 0xff;
    }
    (carObj->N).angularVel.y = (iVarW >> 8) * 0xfa;
  }
  return;
}

/* ---- Physics_TestForBarrierCollision__FP8Car_tObj  [PHYSICS.CPP:1377-1385] SLD-VERIFIED ---- */
void Physics_TestForBarrierCollision(Car_tObj *carObj)

{
  int iVar1;
  int hit;
  
  iVar1 = Physics_DoBarrierCheck(carObj);
  if (iVar1 != 0) {
    if ((carObj->carFlags & 4U) != 0) {
      Physics_FixEngineRpm(carObj);
    }
    carObj->crash = iVar1;
  }
  return;
}

/* ---- Physics_CalculateRoadGripModifiers__FP8Car_tObj  [PHYSICS.CPP:1394-1439] SLD-VERIFIED ---- */
void Physics_CalculateRoadGripModifiers(Car_tObj *carObj)

{
  int frontWheels;
  int rearWheels;
  int leftWheels;
  int rightWheels;
  int i;
  int roadSurfaceType;
  int tempSurface;
  int speed;

  frontWheels = 0;
  rearWheels = 0;
  leftWheels = 0;
  rightWheels = 0;
  i = 0;
  while (true) {
    if (4 <= i) {
      break;
    }
    roadSurfaceType = carObj->wheel[i].roadSurfaceType & 0xf;
    tempSurface = (u_int)(u_char)roadSurfaceIndex[carObj->carInfo->TireType][roadSurfaceType];
    if (slippery != 0) {
      tempSurface = tempSurface + 1;
    }
    if (i < 2) {
      frontWheels = frontWheels + roadSurfaceFrictionCoeff[tempSurface];
    }
    else {
      rearWheels = rearWheels + roadSurfaceFrictionCoeff[tempSurface];
    }
    if ((i == 0) || (i == 2)) {
      leftWheels = leftWheels + roadSurfaceFrictionCoeff[tempSurface];
    }
    else {
      rightWheels = rightWheels + roadSurfaceFrictionCoeff[tempSurface];
    }
    i = i + 1;
  }
  frontMult = frontWheels >> 1;
  rearMult = rearWheels >> 1;
  leftMult = leftWheels >> 1;
  rightMult = rightWheels >> 1;
  speed = (carObj->linearVel_ch).z;
  roadMult = (frontMult + rearMult >> 1) + (carObj->N).roadGravityModifier;
  if (0x50000 < speed) {
    speed = fixedmult(speed,carObj->specs->frontAeroDownForce);
    frontMult = frontMult + speed;
    speed = fixedmult((carObj->linearVel_ch).z,carObj->specs->rearAeroDownForce);
    rearMult = rearMult + speed;
  }
  return;
}

/* ---- Physics_CalculateCarAcceleration__FP8Car_tObj  [PHYSICS.CPP:1447-1672] SLD-VERIFIED ---- */
int Physics_CalculateCarAcceleration(Car_tObj *carObj)

{
  int diffDesiredRpm;
  int ratio;
  int temp;
  int desiredRpm;
  Car_tSpecs *specs;
  int diffFlywheelRpm;
  int driveAcc;
  int wheelRpm;
  int drag;
  int damage;
  int smokeRpm;
  int blip [8] = { 0, 0, 250, 200, 175, 150, 125, 0 };
  int bblip [8] = { 0, 0, 200, 175, 150, 125, 100, 0 };
  driveAcc = 0;
  wheelRpm = 0;
  temp = carObj->specs->redline;
  if (temp < 0) {
    temp = temp + 7;
  }
  smokeRpm = temp >> 3;
  randtemp = fastRandom * randSeed;
  damage = 0;
  temp = (carObj->N).damage[1] + (carObj->N).damage[5];
  fastRandom = randtemp & 0xffff;
  if (temp < 0) {
    temp = temp + 0xff;
  }
  if ((randtemp >> 8 & 0xffff) < (u_int)(temp >> 8)) {
    damage = 1;
  }
  specs = carObj->specs;
  exceedRedline = 0;
  if (specs->redline + 500 < carObj->flywheelRpm) {
    exceedRedline = 1;
  }
  if (carObj->carInfo->GroundEffects != 0) {
    drag = (carObj->specs->frontAeroDownForce + carObj->specs->rearAeroDownForce) / 2 + 0x10000;
  } else {
    drag = 0x10000;
  }
  drag = fixedmult((carObj->linearVel_ch).z,drag);
  drag = fixedmult(specs->dragCoeff,
                   (drag / 0x10000) * (drag / 0x10000) * (drag / 0x10000));
  if (((carObj->control).gear == '\x01') || (powerControl == 0)) {
    int candidateRpm = specs->redline + 0xfa;
    if (fixedmult(candidateRpm,gGasRatio) >= candidateRpm) {
      desiredRpm = specs->redline + 0xfa;
    } else {
      desiredRpm = fixedmult(specs->redline + 0xfa,gGasRatio);
    }
  }
  else {
    int candidateRpm = specs->redline + 100;
    if (fixedmult(candidateRpm,gGasRatio) >= candidateRpm) {
      desiredRpm = specs->redline + 100;
    } else {
      desiredRpm = fixedmult(specs->redline + 100,gGasRatio);
    }
  }
  if (specs->redline <= carObj->flywheelRpm) {
    carObj->flywheelRpm = specs->redline + 0x32;
    temp = 3;
    if (((carObj->control).gear != '\x01') && (temp = 4, powerControl == 0)) {
      temp = 3;
    }
    carObj->revLimit = temp;
  }
  if (0 < carObj->revLimit) {
    if (((carObj->control).gear == '\x01') || (powerControl == 0)) {
      temp = specs->redline + -800;
    }
    else {
      temp = specs->redline + -400;
    }
    if (temp < desiredRpm) {
      desiredRpm = temp;
    }
    carObj->revLimit = carObj->revLimit + -1;
  }
  if ((((carObj->control).gear == '\x01') || ((carObj->control).gearShiftTimer != '\0')) ||
     (powerControl == 0)) {
    if (damage) {
      carObj->flywheelRpm = carObj->flywheelRpm + -100;
cfLbl1:   /* @0x800aae38  (-f-build goto label) */
      carObj->flywheelRpm = MAX(carObj->flywheelRpm,0);
    }
    else {
      if ((carObj->flywheelRpm < desiredRpm) &&
          ((carObj->control).gearShiftTimer == '\0')) {
        temp = carObj->flywheelRpm + 0xfa;
        carObj->flywheelRpm = temp;
        if (temp <= desiredRpm) {
          desiredRpm = temp;
        }
      }
      else if (((carObj->control).gearShiftTimer != '\0') &&
               ((carObj->control).lastGear != '\x01')) {
        if ((carObj->control).downShifting != '\0') {
          if ((u_char)(carObj->control).brakeLevel >= 0x41) {
            carObj->flywheelRpm =
                carObj->flywheelRpm + bblip[(u_char)(carObj->control).desiredGear];
          }
          else {
            carObj->flywheelRpm =
                carObj->flywheelRpm + blip[(u_char)(carObj->control).desiredGear];
          }
          desiredRpm = specs->redline;
          if (carObj->flywheelRpm <= specs->redline) {
            desiredRpm = carObj->flywheelRpm;
          }
        }
        else {
          if ((u_char)(carObj->control).gear < 4) {
            carObj->flywheelRpm = carObj->flywheelRpm + -100;
          }
          else {
            carObj->flywheelRpm = carObj->flywheelRpm + -200;
          }
          goto cfLbl1;
        }
      }
      else {
        if (carObj->flywheelRpm < desiredRpm) goto Phy_CalcAcc_clearWheelSpinExit;
        carObj->flywheelRpm = carObj->flywheelRpm + -200;
        if (desiredRpm < carObj->flywheelRpm) {
          desiredRpm = carObj->flywheelRpm;
        }
      }
      carObj->flywheelRpm = desiredRpm;
    }
Phy_CalcAcc_clearWheelSpinExit:
    carObj->frontWheelSpin = 0;
    carObj->wheelSpin = 0;
    goto Phy_CalcAcc_finalAdjustReturn;
  }
  if ((GameSetup_gData.carInfo[carObj->carIndex].Transmission == 1) || (carObj->RSControl != 0)) {
    Physics_AutoShift(carObj);
  }
  if (((carObj->control).gearShiftTimer != '\0') && ((carObj->control).downShifting == '\0')) {
    wheelRpm = fixedmult((carObj->linearVel_ch).z,
                         specs->velToRpmRatio[(u_char)(carObj->control).lastGear]);
  }
  else {
    wheelRpm = fixedmult((carObj->linearVel_ch).z,
                         specs->velToRpmRatio[(u_char)(carObj->control).gear]);
  }
  if (wheelRpm < 0) {
    wheelRpm = wheelRpm + 0xffff;
  }
  wheelRpm = wheelRpm >> 0x10;
  if ((exceedRedline != 0) || (0 < carObj->revLimit)) {
    driveAcc = fixedmult(specs->torqueCurve[specs->redline / 0x100],
                         specs->gearAccCoeff[(u_char)(carObj->control).gear]) << 1;
  }
  else {
    driveAcc = fixedmult(Physics_GetTorque(carObj,carObj->flywheelRpm / 0x100),
                         specs->gearAccCoeff[(u_char)(carObj->control).gear]);
  }
  diffDesiredRpm = desiredRpm - wheelRpm;
  if ((__builtin_abs(diffDesiredRpm) < 0x7d) && (desiredRpm < specs->redline + -300)) {
    diffDesiredRpm = 0;
  }
  diffFlywheelRpm = carObj->flywheelRpm - wheelRpm;
  if (!((((((diffFlywheelRpm < 0xfb) || ((carObj->control).gearShiftTimer != '\0')) ||
        (4 < (u_char)(carObj->control).gear)) &&
       ((((u_char)(carObj->control).gear < 2 || (-0x199a < (carObj->linearVel_ch).z)) ||
        (gGasRatio < 0x8001)))) &&
      (((((carObj->control).gear != '\0' || ((carObj->linearVel_ch).z < 0x199a)) ||
        (gGasRatio < 0x8001)) && (carObj->wheelSpin != 1)))) || (carObj->revLimit != 0))) {
    int rpmDrop;
    rpmDrop = 0;
    if (((desiredRpm < 2000) || ((u_char)(carObj->control).desiredGasLevel < 0x40)) ||
       ((damage || ((carObj->carInfo->carType == 0x13 && (2 < (u_char)(carObj->control).gear)))))) {
      rpmDrop = 200;
    }
    else {
      if (((carObj->control).gear == 2) || ((carObj->control).gear == 0)) {
        rpmDrop = 10;
      }
      else if (2 < (u_char)(carObj->control).gear) {
        rpmDrop = 0x32;
      }
    }
    if (smokeRpm < diffFlywheelRpm) {
      carObj->wheelSpin = 2;
    }
    if (diffFlywheelRpm <= rpmDrop) {
      rpmDrop = diffFlywheelRpm;
    }
    carObj->flywheelRpm = carObj->flywheelRpm - rpmDrop;
  }
  else {
    if (diffDesiredRpm < 0) {
      int rpmRise;
      driveAcc = -fixedmult(driveAcc,specs->gasOffFactor);
      if ((((0 < gravity_ch.z) && (1 < (u_char)(carObj->control).gear)) &&
           ((driveAcc < 0) && ((u_char)(carObj->control).gear < 3))) ||
          (((gravity_ch.z < 0) && ((carObj->control).gear == 0)) && (0 < driveAcc))) {
        driveAcc = driveAcc / 2;
      }
      rpmRise = fixedmult(specs->velToRpmRatioInv[(u_char)(carObj->control).gear] << 3,
                          0x28000000) / 0x10000;
      if ((carObj->control).gear == '\0') {
        if (rpmRise < -diffFlywheelRpm) {
          rpmRise = -diffFlywheelRpm;
        }
        temp = carObj->flywheelRpm + rpmRise;
      }
      else {
        temp = carObj->flywheelRpm + rpmRise;
        if (-diffFlywheelRpm <= rpmRise) {
          temp = carObj->flywheelRpm - diffFlywheelRpm;
        }
      }
      carObj->flywheelRpm = temp;
      if (exceedRedline == 0) {
        carObj->flywheelRpm =
            ((carObj->flywheelRpm > desiredRpm) ? carObj->flywheelRpm : desiredRpm);
      }
    }
    else if (diffDesiredRpm == 0) {
      carObj->flywheelRpm = wheelRpm;
      driveAcc = drag;
    }
    else {
      if (damage) {
        driveAcc = 0;
        carObj->flywheelRpm = carObj->flywheelRpm + -100;
      }
      else {
        if (diffFlywheelRpm >= 0xc9) {
          carObj->flywheelRpm = carObj->flywheelRpm + -200;
        }
        else if (diffFlywheelRpm < -200) {
          carObj->flywheelRpm = carObj->flywheelRpm + 200;
        }
        else {
          carObj->flywheelRpm = wheelRpm;
        }
        driveAcc = fixedmult(driveAcc,gGasRatio);
      }
      temp = desiredRpm;
      if (temp >= carObj->flywheelRpm) {
        temp = carObj->flywheelRpm;
      }
      carObj->flywheelRpm = temp;
      temp = 0x10000;
      ratio = carObj->slide;
      if (ratio < 0) {
        ratio = -ratio;
      }
      ratio = ratio + temp;
      if ((GameSetup_gData.sgge & 8U) != 0) {
        if (0x30000 < ratio) {
          ratio = 0x30000;
        }
      }
      else if (0x20000 < ratio) {
        ratio = 0x20000;
      }
      driveAcc = (driveAcc / 0x100) * (ratio / 0x100);
    }
  }
  if (carObj->flywheelRpm < 0) {
    ratio = (carObj->linearVel_ch).z * -0x20;
    if ((((driveAcc < 1) || (ratio < 1)) || (driveAcc - ratio < 1)) &&
       (((-1 < driveAcc || (-1 < ratio)) || (-1 < driveAcc - ratio)))) {
      driveAcc = ratio;
      carObj->flywheelRpm = 0;
    }
  }
Phy_CalcAcc_finalAdjustReturn:
  if (carObj->carInfo->carType - 0xcU < 4) {
    if (slippery != 0) {
      if ((carObj->control).gear != '\x02') {
        return driveAcc - drag;
      }
      if (0 < driveAcc) {
        driveAcc = driveAcc * 3 >> 2;
      }
    }
  }
  return driveAcc - drag;
}

/* ---- Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct  [PHYSICS.CPP:1680-1725] SLD-VERIFIED ---- */
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
  if (optVar2 < optVar1) {
    totalAcc = optVar1 + (optVar2 >> 2);
  }
  else {
    totalAcc = optVar2 + (optVar1 >> 2);
  }
  if (slippery != 0) {
    optVar2 = roadGrip - roadGrip / gripLossTableWet[carObj->carInfo->TireType];
  }
  else {
    optVar2 = roadGrip - roadGrip / gripLossTable[carObj->carInfo->TireType];
  }
  if (roadGrip < totalAcc) {
    wheel->skid = wheel->skid * 3 + (totalAcc - roadGrip) >> 2;
  }
  else {
    wheel->skid = 0;
  }
  roadGrip = 0xa0000;
  if (carObj->carInfo->TireType == 2) {
    roadGrip = 0x80000;
  }
  /* RECEIPT (w55-a11): residual 4 diffs, count-EXACT 127/127, SYM-exact locals
     (totalAcc $a1 / optVar1 $a3 / optVar2 $a0 / roadGrip $a2 all confirmed vs the
     8c block).  Sole residual = the NON-PROPAGATED REG-REG COPY class: oracle emits
     `addu v0,a2,zero; slt v0,v0,v1` (the copy also fills the lw's load-delay slot);
     ours coalesces it to `nop; slt v0,a2,v1`.  SLD 1719 covers the whole compare
     AND the assignment => retail wrote this clamp on ONE source line, so the shape
     is already right.  FALSIFIED IN THIS BASIN (12 spellings, each gated):
     one-line-if, ternary-min (10), ternary-yoda (38), min-dbl-eval (10), <=-form,
     !(<)-form, store-readback (10), skid-through-optVar1 (46), volatile skid read (8),
     opacity fence on roadGrip, read-only fence, __volatile__ fence, tern-select on
     the TireType pick.  NEXT ANGLE (not tried): allocsim/reqdelta on the block's
     qtys -- the copy's dest is a block-local qty, so per w47 delete_noop_moves the
     lever is to stop combine_regs tying it (make the copy's DEST a global allocno,
     05D) which needs a sibling block writing the same variable; no such sibling
     exists in this fn, so the reachable dial is the 3-QTY LAW boundary (w46). */
  if (roadGrip >= wheel->skid) {
    roadGrip = wheel->skid;
  }
  wheel->skid = roadGrip;
  if (0x100 < __builtin_abs(totalAcc)) {
    optVar1 = fixeddiv(optVar2,totalAcc) >> 8;
  }
  wheel->finalAcc.x = wheel->velCap.x * optVar1 >> 8;
  wheel->finalAcc.z = wheel->velCap.z * optVar1 >> 8;
  return;
}

/* ---- Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct  [PHYSICS.CPP:1731-1810] SLD-VERIFIED ---- */
void Physics_CalcTractionCircleAcc(Car_tObj *carObj,Physics_tWheelAccStruct *wheel)

{
  Physics_tWheelAccStruct *wheel_reg;
  int totalAcc;
  int ratio;
  int gripLoss;
  int roadGrip;
  int gripLossDivider;
  int tireType;

  wheel_reg = wheel;
  if (__builtin_abs(wheel_reg->finalAcc.x) > __builtin_abs(wheel_reg->finalAcc.z)) {
    totalAcc = __builtin_abs(wheel_reg->finalAcc.x) + (__builtin_abs(wheel_reg->finalAcc.z) >> 2);
  }
  else {
    totalAcc = __builtin_abs(wheel_reg->finalAcc.z) + (__builtin_abs(wheel_reg->finalAcc.x) >> 2);
  }
  roadGrip = wheel_reg->roadGrip;
  if (wheel_reg->frontTire != 0) {
    wheel_reg->skid = carObj->frontSkid;
  }
  else {
    wheel_reg->skid = carObj->rearSkid;
    if (((roadGrip < __builtin_abs(wheel_reg->finalAcc.z)) &&
         (0x80 < (u_char)(carObj->control).gasLevel)) ||
       (carObj->wheelSpin == 2)) {
      carObj->wheelSpin = 1;
    }
    else {
      carObj->wheelSpin = 0;
    }
  }
  if (slippery != 0) {
    gripLossDivider = gripLossTableWet[carObj->carInfo->TireType];
  }
  else {
    gripLossDivider = gripLossTable[carObj->carInfo->TireType];
  }
  if (roadGrip < totalAcc) {
    gripLoss = totalAcc - roadGrip;
    if (((carObj->carInfo->Traction != 0) && (wheel_reg->frontTire == 0)) &&
        (__builtin_abs(carObj->slide) < 0x2666)) {
      ratio = rdiv(roadGrip,totalAcc);
      wheel_reg->skid = 0;
      if (2 < (u_char)(carObj->control).gear) {
        wheel_reg->finalAcc.x = fixedmult(wheel_reg->finalAcc.x,ratio);
      }
      wheel_reg->finalAcc.z = fixedmult(wheel_reg->finalAcc.z,ratio);
    }
    else {
      ratio = rdiv(roadGrip -
                   ((gripLoss / gripLossDivider < roadGrip / gripLossDivider) ?
                    gripLoss / gripLossDivider : roadGrip / gripLossDivider),
                   totalAcc);
      if (carObj->carInfo->TireType == 2) {
        wheel_reg->skid = (wheel_reg->skid * 0xf + gripLoss) / 16;
      }
      else {
        wheel_reg->skid = (wheel_reg->skid * 3 + gripLoss) / 4;
      }
      wheel_reg->finalAcc.x = fixedmult(wheel_reg->finalAcc.x,ratio);
      wheel_reg->finalAcc.z = fixedmult(wheel_reg->finalAcc.z,ratio);
    }
  }
  else {
    wheel_reg->skid = 0;
  }
  if (((wheel_reg->frontTire == 0) && (carObj->wheelSpin == 1)) && (carObj->carInfo->Traction == 0)) {
    wheel_reg->skid = totalAcc;
    if ((u_char)(carObj->control).gear < 4) {
      wheel_reg->skid = totalAcc << 2;
    }
  }
  tireType = carObj->carInfo->TireType;
  if (tireType == 1) {
    roadGrip = 0x80000;
  }
  else {
    roadGrip = 0x40000;
    if (tireType != 2) goto PhyTracCircle_skidAdjust;
  }
  if (roadGrip >= wheel_reg->skid) {
    roadGrip = wheel_reg->skid;
  }
  wheel_reg->skid = roadGrip;
PhyTracCircle_skidAdjust:
  if (carObj->carInfo->Traction != 0) {
    wheel_reg->skid = wheel_reg->skid * 3 / 4;
  }
  return;
}

/* ---- Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct  [PHYSICS.CPP:1815-1979] SLD-VERIFIED ---- */
void Physics_CalculateTireForces(Car_tObj *carObj,Physics_tWheelAccStruct *wheel)

{
  int latAcc;
  int brakingSituation;
  int slipAngle;
  int roadGrip;

  roadGrip = wheel->roadGrip;
  brakingSituation = 0;
  wheel->skid = 0;
  if (wheel->steeringAngle != 0) {
    Math_ResolveRotatedVector(wheel->velCap.x,wheel->velCap.z,wheel->steeringAngle,
                             &wheel->velCap.x,&wheel->velCap.z);
  }
  if ((wheel->acc < 0) && (wheel->velCap.z < 0)) {
    if ((gGasRatio < 0x4001) || ((carObj->control).gear != '\0')) {
      wheel->acc = (wheel->acc > wheel->velCap.z) ? wheel->acc : wheel->velCap.z;
      brakingSituation = 1;
    }
  }
  else if (((0 < wheel->acc) && (0 < wheel->velCap.z)) &&
           ((gGasRatio < 0x4001) || ((u_char)(carObj->control).gear < 2))) {
    wheel->acc = (wheel->acc < wheel->velCap.z) ? wheel->acc : wheel->velCap.z;
    brakingSituation = 1;
  }
  wheel->acc = fixedmult(wheel->acc,carObj->specs->lateralGripMult);
  if (((brakingSituation != 0) && (__builtin_abs(wheel->acc) > wheel->roadGrip)) ||
      (((carObj->control).handBrake != '\0') && (wheel->frontTire == 0) &&
       (__builtin_abs(carObj->linearVel_ch.z) > 0x8000))) {
    if ((carObj->control).handBrake != '\0') {
      goto Phy_TireF_wheelLock;
    }
    if ((((carObj->carInfo->ABS == 0) && (carObj->linearVel_ch.z < 0x190001)) &&
         (0xeb < (u_char)(carObj->control).brakeLevel)) &&
        ((__builtin_abs(carObj->linearVel_ch.z) > 0x4ffff) || (carObj->wheelSpin != 0))) {
      goto Phy_TireF_wheelLock;
    }
    if (wheel->acc > wheel->roadGrip) {
      wheel->acc = wheel->roadGrip;
    }
    else if (wheel->acc < -wheel->roadGrip) {
      wheel->acc = -wheel->roadGrip;
    }
    if ((carObj->carInfo->ABS != 0) && (carObj->linearVel_ch.z < 0x190000)) {
      if ((simGlobal.gameTicks & 3U) == 0) {
        wheel->skid = 0x80000;
      }
      else {
        wheel->skid = 0;
      }
    }
  }
  goto Phy_TireF_normalTire;
Phy_TireF_wheelLock:
  if (wheel->frontTire != 0) {
    carObj->wheelLock = carObj->wheelLock + 1;
  }
  else {
    carObj->wheelLock = carObj->wheelLock + 2;
  }
  Physics_CalcWheelLockAcc(carObj,wheel);
  if (wheel->frontTire != 0) {
    carObj->frontSkid = wheel->skid;
  }
  else {
    carObj->rearSkid = wheel->skid;
  }
  return;
Phy_TireF_normalTire:
  if (wheel->velCap.z != 0) {
    slipAngle = fixedatan(wheel->velCap.x,-wheel->velCap.z / 2);
    if (0 < wheel->velCap.z) {
      if (0 < wheel->velCap.x) {
        slipAngle = 0x8000 - slipAngle;
      }
      else if (wheel->velCap.x < 0) {
        slipAngle = -0x8000 - slipAngle;
      }
    }
    slipAngle = slipAngle << 8;
  }
  else {
    slipAngle = 0;
  }
  if (wheel->frontTire != 0) {
    latAcc = fixedmult(
        fixedmult((0x100000 < __builtin_abs(slipAngle)) ?
                  0x100000 : __builtin_abs(slipAngle),roadGrip),0x1555);
    if (slipAngle < 0) {
      latAcc = -latAcc;
    }
    wheel->finalAcc.x = latAcc;
    wheel->finalAcc.x = latAcc + gravity_ch.x / 2;
    if (__builtin_abs(wheel->velCap.x) + __builtin_abs(wheel->velCap.z) < 0x200000) {
      if (0 < wheel->velCap.x) {
        if (wheel->velCap.x <= __builtin_abs(latAcc)) {
          wheel->finalAcc.x = wheel->velCap.x;
        }
        else {
          wheel->finalAcc.x = __builtin_abs(latAcc);
        }
      }
      else {
        if (-__builtin_abs(latAcc) < wheel->velCap.x) {
          wheel->finalAcc.x = wheel->velCap.x;
        }
        else {
          wheel->finalAcc.x = -__builtin_abs(latAcc);
        }
      }
    }
  }
  else {
    int minSlipAngle;

    minSlipAngle = 0x8000;
    latAcc = fixedmult(
        (0x20000 < ((__builtin_abs(slipAngle) < minSlipAngle) ?
                    minSlipAngle : __builtin_abs(slipAngle))) ?
        0x20000 :
        ((__builtin_abs(slipAngle) < minSlipAngle) ? minSlipAngle : __builtin_abs(slipAngle)),
        roadGrip) / 2;
    if (slipAngle < 0) {
      latAcc = -latAcc;
    }
    latAcc = latAcc + gravity_ch.x / 2;
    if (0 < wheel->velCap.x) {
      wheel->finalAcc.x = (wheel->velCap.x <= __builtin_abs(latAcc)) ?
                          wheel->velCap.x : __builtin_abs(latAcc);
    }
    else {
      wheel->finalAcc.x = (-__builtin_abs(latAcc) < wheel->velCap.x) ?
                          wheel->velCap.x : -__builtin_abs(latAcc);
    }
  }
  wheel->finalAcc.y = 0;
  wheel->finalAcc.z = wheel->acc;
  Physics_CalcTractionCircleAcc(carObj,wheel);
  if (wheel->steeringAngle != 0) {
    Math_ResolveRotatedVector(wheel->finalAcc.x,wheel->finalAcc.z,-wheel->steeringAngle,
                             &wheel->finalAcc.x,&wheel->finalAcc.z);
  }
Phy_TireF_storeSkid:
  if (wheel->frontTire != 0) {
    carObj->frontSkid = wheel->skid;
  }
  else {
    carObj->rearSkid = wheel->skid;
  }
  return;
}

/* ---- Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii  [PHYSICS.CPP:1982-2040] SLD-VERIFIED ---- */
int Physics_CalculateRSControlDesiredPosition(Car_tObj *carObj,int sliceAhead,int lookAhead)

{
  int driveSide;
  int position;

  driveSide = carObj->RSControl * AITune_driveSide;
  if ((((carObj->roadPosition < 0) && (0 < driveSide)) &&
       (AIWorld_IsDriveableLane((int)carObj->N.simRoadInfo.slice,carObj->laneIndex + 1) == 0)) ||
      (((0 < carObj->roadPosition) && (driveSide < 0)) &&
       (AIWorld_IsDriveableLane((int)carObj->N.simRoadInfo.slice,carObj->laneIndex - 1) == 0))) {
    driveSide = -driveSide;
  }
  if (0 < driveSide) {
    int desLane;
    int laneOffset;

    desLane = 7;
    while ((AIWorld_IsDriveableLaneInSliceRange((int)carObj->N.simRoadInfo.slice,lookAhead,
                                                carObj->RSControl,desLane) == 0) &&
           (desLane < 10)) {
      desLane = desLane + 1;
    }
    laneOffset = (u_int)BWorldSm_slices[sliceAhead].avgPavedWidthRt * 0x8000;
    position = (desLane - 7) * laneOffset + ((u_int)laneOffset >> 1);
    if (0 < desLane - 7) {
      position = position + 0x18000;
    }
    return position;
  }
  else {
    int desLane;
    int laneOffset;
    int laneDelta;

    desLane = 6;
    while ((AIWorld_IsDriveableLaneInSliceRange((int)carObj->N.simRoadInfo.slice,lookAhead,
                                                carObj->RSControl,desLane) == 0) &&
           (4 <= desLane)) {
      desLane = desLane - 1;
    }
    laneDelta = 6 - desLane;
    laneOffset = (u_int)BWorldSm_slices[sliceAhead].avgPavedWidthLf * 0x8000;
    position = laneDelta * laneOffset + ((u_int)laneOffset >> 1);
    return (0 < laneDelta) ? -(position + 0x18000) : -position;
  }
}

/* ---- Physics_Real__FP8Car_tObj  [PHYSICS.CPP:2048-2500] SLD-VERIFIED ---- */
void Physics_Real(Car_tObj *carObj)

{
  int driveAcc;
  int brakeAcc;
  int frontBrake;
  int ratio;
  int tempSteer;
  int frontGrip;
  int roadGrip;
  bool bVar1;
  void *pvVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  u_int uVar8;
  Trk_NewSlice *pTVar9;
  int iVar10;
  int iVar11;
  int damp;
  int rotationalAccCap;
  Car_tSpecs *pCVar12;
  u_int uVar13;
  Physics_tWheelAccStruct frontWheel;
  Physics_tWheelAccStruct rearWheel;
  coorddef temp;
  coorddef finalAngularAcc_ch;
  coorddef carAccCap_ch;
  matrixtdef transposeMat;
  
  (carObj->linearAcc_ch).x = 0;
  (carObj->linearAcc_ch).y = 0;
  (carObj->linearAcc_ch).z = 0;
  pCVar12 = carObj->specs;
  steeringControl = 1;
  powerControl = 1;
  if ((GameSetup_gData.Weather != 0) &&
      ((((int)BWorldSm_TunnelFlagSm(&(carObj->N).simRoadInfo)) ^ 1) != 0)) {
    slippery = 1;
  }
  else {
    slippery = 0;
  }
  if (((carObj->wheel[0].wheelInAir != 0) && (carObj->wheel[1].wheelInAir != 0)) &&
     (0xccc < (carObj->N).objAltitude)) {
    steeringControl = 0;
  }
  if (((carObj->wheel[2].wheelInAir != 0) && (carObj->wheel[3].wheelInAir != 0)) &&
     (0xccc < (carObj->N).objAltitude)) {
    powerControl = 0;
  }
  (carObj->linearVel_ch).x =
      fixedmult((carObj->N).linearVel.x,(carObj->N).shadowMat.m[0]) +
      fixedmult((carObj->N).linearVel.y,(carObj->N).shadowMat.m[1]) +
      fixedmult((carObj->N).linearVel.z,(carObj->N).shadowMat.m[2]);
  (carObj->linearVel_ch).y =
      fixedmult((carObj->N).linearVel.x,(carObj->N).shadowMat.m[3]) +
      fixedmult((carObj->N).linearVel.y,(carObj->N).shadowMat.m[4]) +
      fixedmult((carObj->N).linearVel.z,(carObj->N).shadowMat.m[5]);
  (carObj->linearVel_ch).z =
      fixedmult((carObj->N).linearVel.x,(carObj->N).shadowMat.m[6]) +
      fixedmult((carObj->N).linearVel.y,(carObj->N).shadowMat.m[7]) +
      fixedmult((carObj->N).linearVel.z,(carObj->N).shadowMat.m[8]);
  (carObj->angularVel_ch).x =
      fixedmult((carObj->N).angularVel.x,(carObj->N).shadowMat.m[0]) +
      fixedmult((carObj->N).angularVel.y,(carObj->N).shadowMat.m[1]) +
      fixedmult((carObj->N).angularVel.z,(carObj->N).shadowMat.m[2]);
  (carObj->angularVel_ch).y =
      fixedmult((carObj->N).angularVel.x,(carObj->N).shadowMat.m[3]) +
      fixedmult((carObj->N).angularVel.y,(carObj->N).shadowMat.m[4]) +
      fixedmult((carObj->N).angularVel.z,(carObj->N).shadowMat.m[5]);
  (carObj->angularVel_ch).z =
      fixedmult((carObj->N).angularVel.x,(carObj->N).shadowMat.m[6]) +
      fixedmult((carObj->N).angularVel.y,(carObj->N).shadowMat.m[7]) +
      fixedmult((carObj->N).angularVel.z,(carObj->N).shadowMat.m[8]);
  if ((carObj->linearVel_ch).z > 0x50000) {
    ratio = fixeddiv((carObj->linearVel_ch).x,(carObj->linearVel_ch).z);
    carObj->slide = ratio;
  }
  else {
    carObj->slide = 0;
  }
  carAccCap_ch.x = ((carObj->linearVel_ch).x * -0x20) / 2;
  carAccCap_ch.y = ((carObj->linearVel_ch).y * -0x20) / 2;
  carAccCap_ch.z = ((carObj->linearVel_ch).z * -0x20) / 2;
  rotationalAccCap =
      -fixedmult((carObj->N).angularVel.y << 5,pCVar12->alphaToAccRotInertia) / 2;
  temp.x = 0;
  temp.y = -0xa0000;
  temp.z = 0;
  gravity_ch.x =
      fixedmult(temp.x,(carObj->N).shadowMat.m[0]) +
      fixedmult(temp.y,(carObj->N).shadowMat.m[1]) +
      fixedmult(temp.z,(carObj->N).shadowMat.m[2]);
  gravity_ch.y =
      fixedmult(temp.x,(carObj->N).shadowMat.m[3]) +
      fixedmult(temp.y,(carObj->N).shadowMat.m[4]) +
      fixedmult(temp.z,(carObj->N).shadowMat.m[5]);
  gravity_ch.z =
      fixedmult(temp.x,(carObj->N).shadowMat.m[6]) +
      fixedmult(temp.y,(carObj->N).shadowMat.m[7]) +
      fixedmult(temp.z,(carObj->N).shadowMat.m[8]);
  frontWheel.velCap.x = carAccCap_ch.x + rotationalAccCap;
  frontWheel.velCap.y = carAccCap_ch.y;
  frontWheel.velCap.z = carAccCap_ch.z;
  rearWheel.velCap.x = carAccCap_ch.x - rotationalAccCap;
  rearWheel.velCap.y = carAccCap_ch.y;
  rearWheel.velCap.z = carAccCap_ch.z;
  Physics_RampCarControlValues(carObj);
  ratio = (gravity_ch.x / 0x100) * 0x300 / 0x10000;
  tempSteer = (carObj->control).steering + ratio;
  if (tempSteer > 0x7f) {
    tempSteer = 0x7f;
  }
  else if (tempSteer < -0x7f) {
    tempSteer = -0x7f;
  }
  frontWheel.steeringAngle =
      tempSteer * pCVar12->maxSteeringAcc / 0x80;
  {
    int damage;
    int damageMult;

    damage = (carObj->N).damage[0] + (carObj->N).damage[1] +
             (carObj->N).damage[2] + (carObj->N).damage[9];
    damageMult = 0x10000 - damage / 0x200;
    frontWheel.steeringAngle =
        (frontWheel.steeringAngle / 0x100) * (damageMult / 0x100);
  }
  if ((carObj->linearVel_ch).z > 0x3c0000) {
    ratio = fixedmult((carObj->linearVel_ch).z,0x444);
    frontWheel.steeringAngle = fixeddiv(frontWheel.steeringAngle,ratio);
  }
  if ((carObj->linearVel_ch).z > 0x1ab333) {
    if ((((carObj->slide > 0xccc) &&
          (frontWheel.steeringAngle > 0))) ||
        (((carObj->slide < -0xccc) &&
          (frontWheel.steeringAngle < 0)))) {
      int ratio;

      ratio = (0x10000 < (__builtin_abs(carObj->slide) << 1))
                  ? 0x10000
                  : (__builtin_abs(carObj->slide) << 1);
      frontWheel.steeringAngle =
          fixedmult(frontWheel.steeringAngle,ratio);
    }
  }
  else if ((carObj->linearVel_ch).z > 0xd6666) {
    if ((((carObj->slide > 0x2666) &&
          (frontWheel.steeringAngle > 0))) ||
        (((carObj->slide < -0x2666) &&
          (frontWheel.steeringAngle < 0)))) {
      int ratio;

      ratio = (0x10000 < (__builtin_abs(carObj->slide) << 1))
                  ? 0x10000
                  : (__builtin_abs(carObj->slide) << 1);
      frontWheel.steeringAngle =
          fixedmult(frontWheel.steeringAngle,ratio);
    }
  }
  rearWheel.steeringAngle = 0;
  frontWheel.frontTire = 1;
  rearWheel.frontTire = 0;
  driveAcc = Physics_CalculateCarAcceleration(carObj);
  frontWheel.acc =
      (driveAcc / 0x100) * (pCVar12->frontDriveRatio / 0x100);
  rearWheel.acc = driveAcc - frontWheel.acc;
  if ((steeringControl == 0) && (powerControl == 0)) {
    carObj->frontSkid = 0;
    carObj->rearSkid = 0;
    return;
  }
  carObj->crash = 0;
  brakeAcc =
      (gBrakeRatio / 0x100) * (pCVar12->maxBrakeAcc / 0x100);
  brakeAcc = (brakeAcc < (__builtin_abs((carObj->linearVel_ch).z) << 5))
                 ? brakeAcc
                 : (__builtin_abs((carObj->linearVel_ch).z) << 5);
  {
    int damage;
    int damageMult;

    damage = (carObj->N).damage[9];
    if (damage != 0) {
      damageMult = 0x10000 - damage / 0x80;
      brakeAcc = (brakeAcc / 0x100) * (damageMult / 0x100);
    }
  }
  if (0 < (carObj->linearVel_ch).z) {
    brakeAcc = -brakeAcc;
  }
  frontBrake = fixedmult(brakeAcc,pCVar12->frontBrakeRatio);
  frontWheel.acc = frontWheel.acc + frontBrake;
  rearWheel.acc = rearWheel.acc + (brakeAcc - frontBrake);
  roadGrip = fixedmult(-gravity_ch.y,pCVar12->lateralGripMult);
  Physics_CalculateRoadGripModifiers(carObj);
  roadGrip = (roadGrip / 0x100) * (roadMult / 0x100);
  if (roadGrip < 0) {
    return;
  }
  if (slippery != 0) {
    frontGrip =
        fixedmult(roadGrip,pCVar12->frontGripBias + 0x28f);
  }
  else {
    frontGrip =
        fixedmult(roadGrip,pCVar12->frontGripBias);
  }
  {
    int damage;
    int transferMult;

    damage = (carObj->N).damage[4] + (carObj->N).damage[5] +
             (carObj->N).damage[6] + (carObj->N).damage[9];
    transferMult = damage / 0x200 + 0xc000;
    carObj->gTransferFront =
        fixedmult(carObj->gTransferFront,transferMult);
    if (carObj->gTransferFront < 0) {
      carObj->gTransferFront =
          (carObj->gTransferFront / 0x100) * (transferMult / 0x100);
    }
    else if (0 < carObj->gTransferFront) {
      carObj->gTransferFront = carObj->gTransferFront * 3 / 4;
    }
  }
  frontWheel.roadGrip = frontGrip - carObj->gTransferFront;
  frontWheel.roadGrip =
      (frontMult / 0x100) * (frontWheel.roadGrip / 0x100);
  rearWheel.roadGrip =
      (roadGrip - frontGrip) + carObj->gTransferFront;
  rearWheel.roadGrip =
      (rearMult / 0x100) * (rearWheel.roadGrip / 0x100);
  carObj->wheelLock = 0;
  frontWheel.finalAcc.x = 0;
  frontWheel.finalAcc.z = 0;
  rearWheel.finalAcc.x = 0;
  rearWheel.finalAcc.z = 0;
  if (steeringControl != 0) {
    Physics_CalculateTireForces(carObj,&frontWheel);
  }
  if (powerControl != 0) {
    Physics_CalculateTireForces(carObj,&rearWheel);
  }
  (carObj->linearAcc_ch).z = frontWheel.finalAcc.z + rearWheel.finalAcc.z;
  (carObj->linearAcc_ch).x = frontWheel.finalAcc.x + rearWheel.finalAcc.x;
  (carObj->linearAcc_ch).z =
      fixedmult((carObj->linearAcc_ch).z,pCVar12->lateralGripMultInv);
  if (((GameSetup_gData.sgge == 0x80) &&
       (0 < (carObj->linearAcc_ch).z)) &&
      ((carObj->control).horn != '\0')) {
    (carObj->linearAcc_ch).z <<= 2;
  }
  if (slippery == 0) {
    if ((carObj->carInfo->TireType == 2) && ((u_char)(carObj->control).gear < 4)) {
      (carObj->linearAcc_ch).z =
          fixedmult((carObj->linearAcc_ch).z,0x12666);
    }
    else {
      (carObj->linearAcc_ch).z =
          fixedmult((carObj->linearAcc_ch).z,0x11999);
    }
  }
  (carObj->linearAcc_ch).y = 0;
  ratio = -fixedmult(gravity_ch.z,0x1999);
  carObj->gTransferRight =
      -fixedmult((carObj->linearAcc_ch).x / 8,pCVar12->gTransferFactor);
  carObj->gTransferFront =
      fixedmult((carObj->linearAcc_ch).z,pCVar12->gTransferFactor) + ratio;
  ratio = fixedmult(frontWheel.finalAcc.x - rearWheel.finalAcc.x,
                    pCVar12->accToAlphaRotInertia);
  {
    int wheelMult = leftMult - rightMult;

    ratio += fixedmult(fixedmult(frontWheel.finalAcc.z + rearWheel.finalAcc.z,
                                 wheelMult),
                       pCVar12->accToAlphaRotInertia) *
             2;
  }
  finalAngularAcc_ch.y = ratio;
  if ((((carObj->N).angularVel.y > 0) && (finalAngularAcc_ch.y > 0)) ||
      (((carObj->N).angularVel.y < 0) && (finalAngularAcc_ch.y < 0))) {
    if (((carObj->control).handBrake != '\0') &&
        ((GameSetup_gData.sgge & 8U) == 0)) {
      finalAngularAcc_ch.y = finalAngularAcc_ch.y / 2;
    }
    else {
      if (((((carObj->control).desiredSteering < 0) &&
            (0x3333 < (carObj->N).angularVel.y)) ||
           ((0 < (carObj->control).desiredSteering &&
            ((carObj->N).angularVel.y < -0x3333)))) &&
          (carObj->wheelSpin == 1)) {
        finalAngularAcc_ch.y = -(carObj->N).angularVel.y;
      }
      else {
        finalAngularAcc_ch.y =
            fixedmult(finalAngularAcc_ch.y,carObj->specs->spinVelCap);
      }
    }
  }
  finalAngularAcc_ch.x = 0;
  finalAngularAcc_ch.z = 0;
  transpose(&(carObj->N).shadowMat,&transposeMat);
  Cars_DoGravityEffectsOnAcc(carObj,0);
  (carObj->linearAcc).x =
      fixedmult((carObj->linearAcc_ch).x,transposeMat.m[0]) +
      fixedmult((carObj->linearAcc_ch).y,transposeMat.m[1]) +
      fixedmult((carObj->linearAcc_ch).z,transposeMat.m[2]);
  (carObj->linearAcc).y =
      fixedmult((carObj->linearAcc_ch).x,transposeMat.m[3]) +
      fixedmult((carObj->linearAcc_ch).y,transposeMat.m[4]) +
      fixedmult((carObj->linearAcc_ch).z,transposeMat.m[5]);
  (carObj->linearAcc).z =
      fixedmult((carObj->linearAcc_ch).x,transposeMat.m[6]) +
      fixedmult((carObj->linearAcc_ch).y,transposeMat.m[7]) +
      fixedmult((carObj->linearAcc_ch).z,transposeMat.m[8]);
  (carObj->angularAcc).x =
      fixedmult(finalAngularAcc_ch.x,transposeMat.m[0]) +
      fixedmult(finalAngularAcc_ch.y,transposeMat.m[1]) +
      fixedmult(finalAngularAcc_ch.z,transposeMat.m[2]);
  (carObj->angularAcc).y =
      fixedmult(finalAngularAcc_ch.x,transposeMat.m[3]) +
      fixedmult(finalAngularAcc_ch.y,transposeMat.m[4]) +
      fixedmult(finalAngularAcc_ch.z,transposeMat.m[5]);
  (carObj->angularAcc).z =
      fixedmult(finalAngularAcc_ch.x,transposeMat.m[6]) +
      fixedmult(finalAngularAcc_ch.y,transposeMat.m[7]) +
      fixedmult(finalAngularAcc_ch.z,transposeMat.m[8]);
  (carObj->N).linearVel.x += (carObj->linearAcc).x / 0x20;
  (carObj->N).linearVel.y += (carObj->linearAcc).y / 0x20;
  (carObj->N).linearVel.z += (carObj->linearAcc).z / 0x20;
  (carObj->N).angularVel.x += (carObj->angularAcc).x / 0x20;
  (carObj->N).angularVel.y += (carObj->angularAcc).y / 0x40;
  (carObj->N).angularVel.z += (carObj->angularAcc).z / 0x20;
  if (carObj->RSControl != 0) {
    int desiredRpm;
    int currentRpm;
    int diffRpm;
    int tempGas;

    if (carObj->desiredSpeed < 0x471c7) {
      desiredRpm =
          fixedmult(0x188000,
                    pCVar12->velToRpmRatio[
                        ((u_char)(carObj->control).gear < 2)
                            ? 2 : (u_char)(carObj->control).gear]) /
          0x10000;
    }
    else {
      desiredRpm =
          fixedmult(carObj->desiredSpeed,
                    pCVar12->velToRpmRatio[
                        ((u_char)(carObj->control).gear < 2)
                            ? 2 : (u_char)(carObj->control).gear]) /
          0x10000;
    }
    int adjustedRpm =
        fixedmult((carObj->linearVel_ch).z,
                  pCVar12->velToRpmRatio[
                      ((u_char)(carObj->control).gear < 2)
                          ? 2 : (u_char)(carObj->control).gear]);
    if (adjustedRpm < 0) {
      adjustedRpm += 0xffff;
    }
    tempGas = (desiredRpm << 8) / pCVar12->redline;
    diffRpm = desiredRpm - (adjustedRpm >> 16);
    if (diffRpm >= 0xc9) {
      int gasLevel;

      tempGas += (diffRpm * 0x80) / desiredRpm;
      gasLevel = tempGas;
      if (0xe0 < gasLevel) {
        gasLevel = 0xe0;
      }
      carObj->RSGasLevel = (char)gasLevel;
    }
    else if (diffRpm < 200) {
      tempGas = tempGas + (diffRpm * 0x80) / desiredRpm;
      if (tempGas >= 0) {
        carObj->RSGasLevel = (char)tempGas;
      }
      else {
        carObj->RSGasLevel = '\0';
      }
      if (diffRpm < 0) {
        u_int brakeLevel =
            __builtin_abs(diffRpm << 9) / pCVar12->redline;
        if (0xff < (int)brakeLevel) {
          brakeLevel = 0xff;
        }
        carObj->RSBrakeLevel = (char)brakeLevel;
        if (0x80 < (u_char)brakeLevel) {
          carObj->RSGasLevel = '\0';
        }
      }
    }
    {
      int lookAhead;
      int sliceAhead;
      coorddef carPos;
      coorddef dirVector;

      currentRpm = __builtin_abs(carObj->currentSpeed) / 0x60000;
      int rsControl = carObj->RSControl;
      if (currentRpm >= 3) {
        lookAhead = rsControl * currentRpm;
      }
      else {
        lookAhead = rsControl * 3;
      }
      if (lookAhead >= 0) {
        sliceAhead = (carObj->N).simRoadInfo.slice + lookAhead;
        if (gNumSlices <= sliceAhead) {
          sliceAhead = sliceAhead - gNumSlices;
        }
      }
      else {
        sliceAhead = (carObj->N).simRoadInfo.slice + lookAhead;
        if (sliceAhead < 0) {
          sliceAhead = sliceAhead + gNumSlices;
        }
      }
      {
        int roadPosition;
        coorddef offset;

        pTVar9 = BWorldSm_slices + sliceAhead;
        carPos = (carObj->N).position;
        dirVector.x = pTVar9->center[0];
        dirVector.y = pTVar9->center[1];
        dirVector.z = pTVar9->center[2];
        roadPosition =
            Physics_CalculateRSControlDesiredPosition(
                carObj,sliceAhead,__builtin_abs(lookAhead * 3));
        pTVar9 = BWorldSm_slices + sliceAhead;
        offset.x = fixedmult(
            (int)(signed char)pTVar9->right[0] << 9,
            roadPosition);
        pTVar9 = BWorldSm_slices + sliceAhead;
        offset.y = fixedmult(
            (int)(signed char)pTVar9->right[1] << 9,
            roadPosition);
        pTVar9 = BWorldSm_slices + sliceAhead;
        offset.z = fixedmult(
            (int)(signed char)pTVar9->right[2] << 9,
            roadPosition);
        dirVector.x += offset.x;
        dirVector.y += offset.y;
        dirVector.z += offset.z;
        dirVector.x -= carPos.x;
        dirVector.y -= carPos.y;
        dirVector.z -= carPos.z;
        Math_NormalizeVector(&dirVector);
        carObj->RSSteering =
            (fixedmult(dirVector.x,(carObj->N).orientMat.m[0]) +
             fixedmult(dirVector.y,(carObj->N).orientMat.m[1]) +
             fixedmult(dirVector.z,(carObj->N).orientMat.m[2])) / 0x100;
        if (carObj->RSSteering > 0x7f) {
          carObj->RSSteering = 0x7f;
        }
        else if (carObj->RSSteering < -0x7f) {
          carObj->RSSteering = -0x7f;
        }
      }
    }
  }
  if ((GameSetup_gData.sgge & 8U) == 0) {
    if ((carObj->control).gasLevel != '\0') {
      if (__builtin_abs(carObj->slide) < 0x199a) {
        goto PhyReal_iceBraking;
      }
    }
    (carObj->N).linearVel.x =
        fixedmult(carObj->specs->dragFactor,(carObj->N).linearVel.x);
    (carObj->N).linearVel.y =
        fixedmult(carObj->specs->dragFactor,(carObj->N).linearVel.y);
    (carObj->N).linearVel.z =
        fixedmult(carObj->specs->dragFactor,(carObj->N).linearVel.z);
  }
PhyReal_iceBraking:
  if (((carObj->N).driveSurfaceType == 3) && (0x2ca3d7 < (carObj->N).speedXZ)) {
    (carObj->N).linearVel.x =
        fixedmult(0xfeb8,(carObj->N).linearVel.x);
    (carObj->N).linearVel.y =
        fixedmult(0xfeb8,(carObj->N).linearVel.y);
    (carObj->N).linearVel.z =
        fixedmult(0xfeb8,(carObj->N).linearVel.z);
  }
  else {
    if (((carObj->control).gear == '\x01') &&
        (__builtin_abs(gravity_ch.z) < 0x8000)) {
      if ((__builtin_abs((carObj->linearVel_ch).z) < 0x140000) ||
          (__builtin_abs((carObj->control).steering) > 0x20)) {
        damp = 0xfd70;
      }
      else {
        damp = 0xff7c;
      }
      (carObj->N).linearVel.x =
          fixedmult(damp,(carObj->N).linearVel.x);
      (carObj->N).linearVel.y =
          fixedmult(damp,(carObj->N).linearVel.y);
      (carObj->N).linearVel.z =
          fixedmult(damp,(carObj->N).linearVel.z);
      (carObj->N).angularVel.x =
          fixedmult(damp,(carObj->N).angularVel.x);
      (carObj->N).angularVel.y =
          fixedmult(damp,(carObj->N).angularVel.y);
      (carObj->N).angularVel.z =
          fixedmult(damp,(carObj->N).angularVel.z);
      return;
    }
    if (((carObj->control).handBrake != '\0') &&
        ((carObj->N).speedXZ <= 0xffff)) {
      (carObj->N).linearVel.x =
          fixedmult(0x8000,(carObj->N).linearVel.x);
      (carObj->N).linearVel.y =
          fixedmult(0x8000,(carObj->N).linearVel.y);
      (carObj->N).linearVel.z =
          fixedmult(0x8000,(carObj->N).linearVel.z);
    }
    else {
      return;
    }
  }
  return;
}

/* ---- Physics_SimCar__FP8Car_tObj  [PHYSICS.CPP:2507-2532] SLD-VERIFIED ---- */
void Physics_SimCar(Car_tObj *carObj)

{
  if ((carObj->N).orientationToGround.y < 0x1999) {
    carObj->wheelSpin = 0;
    carObj->slide = 0;
    carObj->frontSkid = 0;
    carObj->rearSkid = 0;
    if (carObj->flywheelRpm >= 0x1f5) {
      carObj->flywheelRpm = carObj->flywheelRpm + -500;
    }
    else {
      carObj->flywheelRpm = 0;
    }
    if ((carObj->N).objAltitude < 0x8000) {
      Physics_StopCar(carObj);
    }
  }
  else {
    Physics_Real(carObj);
  }
  return;
}

/* end of physics.cpp */

/* owning-TU def (extern-declared, never defined; link-harness) */
int currentWallType;

/* owning-TU defs for the rest of physics.obj's scalar globals (SYM class EXT, contiguous
 * 0x8013d2f0..0x8013d320 block right after currentWallType/exceedRedline) -- these were left
 * pure `extern` in physics_externs.h (never defined anywhere in-tree), which denies the
 * compiler the size info needed for -G4 .sbss gp-relative placement: every access oracle takes
 * as a single `lw/sw r,off(gp)` compiled to a 2-insn lui/lw|sw absolute-address pair instead.
 * Materializing the tentative defs here (physics.cpp is the true SYM owner) restores gp-rel
 * codegen tree-wide for every fn touching them (CalculateRoadGripModifiers, CalculateCarAcceleration,
 * AutoShift, DoBarrierCheck, RampCarControlValues, ...). */
int gBrakeRatio, gGasRatio, gSteerRatio;
int exceedRedline;
int roadMult, frontMult, rearMult, leftMult, rightMult;
int slippery, steeringControl, powerControl;
