/* game/common/physics.cpp -- RECONSTRUCTED (NFS4 PSX car physics engine; C++ TU)
 *   22 fns: SimCar/Real driver + tire forces, traction circle, accel, autoshift, barrier, RS control.
 *   GTE-free (fixed-point + eaclib math). Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "physics_externs.h"

/* ---- link-harness owned-global definition (extern-declared, never defined) ---- */
int physics_blipInit[8]; int physics_bblipInit[8];  /* physics.obj-owned blip-init tables (BSS) */

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
  int iVar1;
  int iVar2;
  Car_tSpecs *pCVar3;
  int iVar4;
  int accAtMaxSpeedInHighestGear;
  int i;
  int iVar5;
  
  accAtMaxSpeedInHighestGear = (int)carObj->specs;
  *(int *)(accAtMaxSpeedInHighestGear + 0x15c) =
       0x10000 / *(int *)(accAtMaxSpeedInHighestGear + 0xf0);
  if (carObj->carInfo->WeightTransfer == 1) {
    carObj->specs->steeringRamp = carObj->specs->steeringRamp + 1;
    iVar1 = fixedmult(carObj->specs->maxSteeringAcc,0x1147a);
    carObj->specs->maxSteeringAcc = iVar1;
  }
  if (carObj->carInfo->GroundEffects == 1) {
    carObj->specs->steeringRamp = carObj->specs->steeringRamp + 1;
    iVar1 = fixedmult(carObj->specs->frontAeroDownForce,0x13333);
    carObj->specs->frontAeroDownForce = iVar1;
    iVar1 = fixedmult(carObj->specs->rearAeroDownForce,0x13333);
    carObj->specs->rearAeroDownForce = iVar1;
    iVar1 = fixedmult(carObj->specs->mass,0xcccc);
    carObj->specs->mass = iVar1;
    iVar1 = fixedmult(carObj->specs->lateralGripMult,0x11999);
    carObj->specs->lateralGripMult = iVar1;
  }
  if (carObj->carInfo->EngineMods == 1) {
    carObj->specs->gearShiftDelay = carObj->specs->gearShiftDelay / 2;
    iVar1 = fixedmult(carObj->specs->maxBrakeAcc,0x14000);
    carObj->specs->maxBrakeAcc = iVar1;
    iVar1 = 0;
    do {
      iVar2 = fixedmult(carObj->specs->torqueCurve[iVar1],0x12666);
      iVar5 = iVar1 + 1;
      carObj->specs->torqueCurve[iVar1] = iVar2;
      iVar1 = iVar5;
    } while (iVar5 < 0x29);
    iVar1 = fixedmult(carObj->specs->maxSpeed,0x11999);
    carObj->specs->maxSpeed = iVar1;
  }
  pCVar3 = carObj->specs;
  iVar1 = pCVar3->numGears;
  iVar2 = 0;
  if (0 < iVar1) {
    iVar1 = 0;
    do {
      iVar4 = (int)pCVar3->velToRpmRatio + iVar1 + -0xc;
      iVar5 = 0x28f;
      if (*(int *)(iVar4 + 0xc) != 0) {
        iVar5 = fixeddiv(0x10000,*(int *)(iVar4 + 0xc));
        iVar4 = (int)carObj->specs->velToRpmRatio + iVar1 + -0xc;
      }
      *(int *)(iVar4 + 0x180) = iVar5;
      iVar2 = iVar2 + 1;
      iVar5 = fixeddiv(*(int *)((int)carObj->specs->velToRpmRatio + iVar1),carObj->specs->mass);
      *(int *)((int)carObj->specs->gearAccCoeff + iVar1) = iVar5;
      iVar5 = fixeddiv(*(int *)((int)carObj->specs->gearAccCoeff + iVar1),0xa0000);
      *(int *)((int)carObj->specs->gearAccCoeff + iVar1) = iVar5;
      iVar5 = fixedmult(*(int *)((int)carObj->specs->gearAccCoeff + iVar1),
                         *(int *)((int)carObj->specs->gearEfficiency + iVar1));
      *(int *)((int)carObj->specs->gearAccCoeff + iVar1) = iVar5;
      iVar5 = fixedmult(*(int *)((int)carObj->specs->velToRpmRatioInv + iVar1),
                         carObj->specs->redline << 0x10);
      iVar5 = fixeddiv(0x10000,iVar5);
      *(int *)((int)carObj->specs->gearVelInv + iVar1) = iVar5;
      pCVar3 = carObj->specs;
      iVar1 = iVar1 + 4;
    } while (iVar2 < pCVar3->numGears);
    pCVar3 = carObj->specs;
    iVar1 = pCVar3->numGears;
  }
  iVar1 = fixedmult(pCVar3->maxSpeed,pCVar3->velToRpmRatio[iVar1 + -1]);
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xffff;
  }
  iVar1 = iVar1 >> 0x10;
  pCVar3 = carObj->specs;
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar1 = fixedmult(pCVar3->torqueCurve[iVar1 >> 8],pCVar3->velToRpmRatioInv[pCVar3->numGears + 7])
  ;
  iVar2 = carObj->specs->maxSpeed;
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xffff;
  }
  iVar2 = iVar2 >> 0x10;
  iVar1 = fixeddiv(iVar1,iVar2 * iVar2 * iVar2);
  carObj->specs->dragCoeff = iVar1;
  if (7 < GameSetup_gData.track) {
    carObj->specs->gasOffFactor = carObj->specs->gasOffFactor + 0x2666;
    carObj->specs->frontBrakeRatio = carObj->specs->frontBrakeRatio + -0x2666;
    carObj->specs->frontGripBias = carObj->specs->frontGripBias + 0x147;
  }
  iVar1 = fixedmult(0x10000,carObj->specs->wheelBase / 2);
  carObj->specs->alphaToAccRotInertia = iVar1;
  iVar1 = fixedmult(carObj->specs->alphaToAccRotInertia,0x648);
  carObj->specs->alphaToAccRotInertia = iVar1;
  carObj->specs->alphaToAccRotInertia = carObj->specs->alphaToAccRotInertia << 8;
  iVar1 = fixeddiv(0x10000,carObj->specs->alphaToAccRotInertia);
  carObj->specs->accToAlphaRotInertia = iVar1;
  iVar1 = fixeddiv(0x10000,carObj->specs->lateralGripMult);
  carObj->specs->lateralGripMultInv = iVar1;
  return;
}

/* ---- Physics_CheckGamedata__Fv  [PHYSICS.CPP:414-465] SLD-VERIFIED ---- */
void Physics_CheckGamedata(void)

{
  return;
}

/* ---- Physics_AttenuateVelocity__FP8Car_tObjiP10matrixtdef  [PHYSICS.CPP:591-659] SLD-VERIFIED ---- */
int Physics_AttenuateVelocity(Car_tObj *carObj,int force,matrixtdef *roadMat)

{
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int vx;
  int absvelbx;
  coorddef vel_b;
  matrixtdef transposeMat;
  
  iVar5 = force;
  if (force < 0) {
    iVar5 = force + 0xff;
  }
  iVar1 = roadMat->m[0];
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar2 = roadMat->m[3];
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  if (force < 0) {
    force = force + 0xff;
  }
  iVar3 = roadMat->m[6];
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar8 = (carObj->N).linearVel.x;
  iVar6 = (carObj->N).position.z;
  (carObj->N).position.x = (carObj->N).position.x - (iVar5 >> 8) * (iVar1 >> 8);
  iVar1 = (carObj->N).position.y;
  (carObj->N).position.z = iVar6 + (force >> 8) * (iVar3 >> 8);
  (carObj->N).position.y = iVar1 + (iVar5 >> 8) * (iVar2 >> 8);
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  iVar5 = roadMat->m[0];
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  iVar1 = (carObj->N).linearVel.y;
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar2 = roadMat->m[1];
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar3 = (carObj->N).linearVel.z;
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar6 = roadMat->m[2];
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar1 = (iVar8 >> 8) * (iVar5 >> 8) + (iVar1 >> 8) * (iVar2 >> 8) + (iVar3 >> 8) * (iVar6 >> 8);
  iVar5 = -iVar1;
  iVar2 = (carObj->N).linearVel.x;
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar3 = roadMat->m[6];
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar6 = (carObj->N).linearVel.y;
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar8 = roadMat->m[7];
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  iVar7 = (carObj->N).linearVel.z;
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  iVar4 = roadMat->m[8];
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  if (iVar5 < 0) {
    iVar5 = iVar1;
  }
  iVar5 = iVar5 >> 1;
  vel_b.z = (iVar2 >> 8) * (iVar3 >> 8) + (iVar6 >> 8) * (iVar8 >> 8) + (iVar7 >> 8) * (iVar4 >> 8);
  if (vel_b.z < 1) {
    if (vel_b.z < -0x50000) {
      iVar1 = iVar5;
      if (iVar5 < 0) {
        iVar1 = iVar5 + 0xff;
      }
      vel_b.z = vel_b.z + (iVar1 >> 8) * 0xc0;
      if (0 < vel_b.z) {
        vel_b.z = 0;
      }
    }
  }
  else if (0x50000 < vel_b.z) {
    iVar1 = iVar5;
    if (iVar5 < 0) {
      iVar1 = iVar5 + 0xff;
    }
    vel_b.z = vel_b.z + (iVar1 >> 8) * -0xc0;
    if (vel_b.z < 0) {
      vel_b.z = 0;
    }
  }
  transpose(roadMat,&transposeMat);
  iVar1 = fixedmult(0,transposeMat.m[0]);
  iVar2 = fixedmult(0,transposeMat.m[1]);
  iVar3 = fixedmult(vel_b.z,transposeMat.m[2]);
  (carObj->N).linearVel.x = iVar1 + iVar2 + iVar3;
  iVar1 = fixedmult(0,transposeMat.m[6]);
  iVar2 = fixedmult(0,transposeMat.m[7]);
  iVar3 = fixedmult(vel_b.z,transposeMat.m[8]);
  iVar6 = (carObj->N).linearVel.y;
  (carObj->N).linearVel.z = iVar1 + iVar2 + iVar3;
  if (0 < iVar6) {
    (carObj->N).linearVel.y = 0;
  }
  iVar1 = fixedmult((carObj->N).linearVel.x,(carObj->N).orientMat.m[0]);
  iVar2 = fixedmult((carObj->N).linearVel.y,(carObj->N).orientMat.m[1]);
  iVar3 = fixedmult((carObj->N).linearVel.z,(carObj->N).orientMat.m[2]);
  iVar6 = (carObj->N).linearVel.x;
  iVar8 = (carObj->N).orientMat.m[3];
  (carObj->linearVel_ch).x = iVar1 + iVar2 + iVar3;
  iVar1 = fixedmult(iVar6,iVar8);
  iVar2 = fixedmult((carObj->N).linearVel.y,(carObj->N).orientMat.m[4]);
  iVar3 = fixedmult((carObj->N).linearVel.z,(carObj->N).orientMat.m[5]);
  iVar6 = (carObj->N).linearVel.x;
  iVar8 = (carObj->N).orientMat.m[6];
  (carObj->linearVel_ch).y = iVar1 + iVar2 + iVar3;
  iVar3 = fixedmult(iVar6,iVar8);
  iVar6 = fixedmult((carObj->N).linearVel.y,(carObj->N).orientMat.m[7]);
  iVar8 = fixedmult((carObj->N).linearVel.z,(carObj->N).orientMat.m[8]);
  iVar1 = (carObj->N).linearVel.x;
  iVar2 = (carObj->N).linearVel.z;
  if (iVar1 < 0) {
    iVar1 = -iVar1;
  }
  if (iVar2 < 0) {
    iVar2 = -iVar2;
  }
  (carObj->linearVel_ch).z = iVar3 + iVar6 + iVar8;
  if (iVar2 < iVar1) {
    iVar1 = iVar1 + (iVar2 >> 2);
  }
  else {
    iVar1 = iVar2 + (iVar1 >> 2);
  }
  (carObj->N).speedXZ = iVar1;
  return iVar5;
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
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int result;
  int diffX;
  int diffZ;
  
  (carObj->N).collision.impulse = impactVel * 6;
  iVar1 = currentWallType;
  (carObj->N).collision.otherObj = (BO_tNewtonObj *)0x0;
  (carObj->N).collision.sfxType = iVar1 | 0x40000;
  if ((impactVel < 0xf0000) || ((carObj->linearVel_ch).z < 0x140000)) {
    iVar1 = fixedmult(barrierVec.x,(carObj->N).shadowMat.m[6]);
    iVar2 = fixedmult(barrierVec.y,(carObj->N).shadowMat.m[7]);
    iVar3 = fixedmult(barrierVec.z,(carObj->N).shadowMat.m[8]);
    iVar3 = iVar1 + iVar2 + iVar3;
    iVar1 = fixedmult(barrierVec.x,(carObj->N).shadowMat.m[0]);
    iVar2 = fixedmult(barrierVec.y,(carObj->N).shadowMat.m[1]);
    iVar4 = fixedmult(barrierVec.z,(carObj->N).shadowMat.m[2]);
    iVar4 = iVar1 + iVar2 + iVar4;
    iVar1 = iVar3;
    if (iVar3 < 0) {
      iVar1 = -iVar3;
    }
    iVar2 = iVar4;
    if (iVar4 < 0) {
      iVar2 = -iVar4;
    }
    if (iVar2 < iVar1) {
      iVar1 = iVar2;
    }
    iVar1 = iVar1 >> 1;
    if (iVar3 < 0) {
      if (iVar4 < 0) {
        iVar1 = -iVar1;
      }
    }
    else {
      if (0 < iVar4) {
        iVar1 = -iVar1;
      }
      iVar1 = iVar1 >> 1;
    }
    if ((0xd6666 < (carObj->linearVel_ch).z) &&
       (((0 < iVar1 && (0 < (carObj->control).steering)) ||
        ((iVar1 < 0 && ((carObj->control).steering < 0)))))) {
      iVar1 = iVar1 >> 2;
    }
    (carObj->N).angularVel.y = iVar1;
  }
  return;
}

/* ---- Physics_DoBarrierCheck__FP8Car_tObj  [PHYSICS.CPP:761-932] SLD-VERIFIED ---- */
int Physics_DoBarrierCheck(Car_tObj *carObj)

{
  int wallType;
  char cVar1;
  char cVar2;
  short sVar3;
  int r2;
  int iVar4;
  Trk_NewSlice *pTVar5;
  int iVar6;
  int iVar7;
  int r3;
  int iVar8;
  int iVar9;
  int r1;
  int iVar10;
  int iVar11;
  int iVar12;
  int x2;
  int iVar13;
  int iVar14;
  int iVar15;
  int carCollisionWidth;
  int iVar16;
  int x1;
  int x3;
  int x_relRoad;
  int collide;
  int iVar17;
  int diff;
  int iVar18;
  int slice;
  coorddef vel_b;
  coorddef right;
  coorddef normal;
  coorddef widthVector;
  int in_stack_ffffff9c;
  
  iVar18 = 0;
  sVar3 = (carObj->N).simRoadInfo.slice;
  pTVar5 = BWorldSm_slices + sVar3;
  cVar1 = pTVar5->right[0];
  r3 = (int)pTVar5->right[2];
  iVar10 = cVar1 * 0x200;
  cVar2 = pTVar5->right[1];
  iVar17 = 0;
  iVar8 = r3 * 0x200;
  iVar4 = cVar2 * 0x200;
  iVar14 = ((carObj->N).position.x + ((carObj->N).linearVel.x >> 5)) - pTVar5->center[0];
  iVar16 = ((carObj->N).position.y + ((carObj->N).linearVel.y >> 5)) - pTVar5->center[1];
  iVar6 = ((carObj->N).position.z + ((carObj->N).linearVel.z >> 5)) - pTVar5->center[2];
  iVar13 = iVar10;
  if (iVar10 < 0) {
    iVar13 = iVar10 + 0xff;
  }
  if (iVar14 < 0) {
    iVar14 = iVar14 + 0xff;
  }
  iVar11 = iVar4;
  if (iVar4 < 0) {
    iVar11 = iVar4 + 0xff;
  }
  if (iVar16 < 0) {
    iVar16 = iVar16 + 0xff;
  }
  iVar12 = iVar8;
  if (iVar8 < 0) {
    iVar12 = iVar8 + 0xff;
  }
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar9 = (carObj->N).orientMat.m[7];
  iVar7 = (carObj->N).orientMat.m[6];
  iVar15 = (carObj->N).orientMat.m[8];
  iVar13 = (iVar13 >> 8) * (iVar14 >> 8) + (iVar11 >> 8) * (iVar16 >> 8) +
           (iVar12 >> 8) * (iVar6 >> 8);
  (carObj->N).xRelRoadCenter = iVar13;
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  iVar14 = iVar10;
  if (iVar10 < 0) {
    iVar14 = iVar10 + 0xff;
  }
  if (iVar9 < 0) {
    iVar9 = iVar9 + 0xff;
  }
  iVar16 = iVar4;
  if (iVar4 < 0) {
    iVar16 = iVar4 + 0xff;
  }
  if (iVar15 < 0) {
    iVar15 = iVar15 + 0xff;
  }
  iVar6 = iVar8;
  if (iVar8 < 0) {
    iVar6 = iVar8 + 0xff;
  }
  iVar16 = (iVar7 >> 8) * (iVar14 >> 8) + (iVar9 >> 8) * (iVar16 >> 8) +
           (iVar15 >> 8) * (iVar6 >> 8);
  iVar14 = fixedmult((carObj->N).dimension.z,iVar16);
  if (iVar14 < 1) {
    iVar14 = fixedmult((carObj->N).dimension.z,iVar16);
    iVar14 = -iVar14;
  }
  else {
    iVar14 = fixedmult((carObj->N).dimension.z,iVar16);
  }
  iVar6 = (carObj->N).orientMat.m[1];
  iVar16 = (carObj->N).orientMat.m[0];
  iVar11 = (carObj->N).orientMat.m[2];
  if (iVar16 < 0) {
    iVar16 = iVar16 + 0xff;
  }
  iVar12 = iVar10;
  if (iVar10 < 0) {
    iVar12 = iVar10 + 0xff;
  }
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar7 = iVar4;
  if (iVar4 < 0) {
    iVar7 = iVar4 + 0xff;
  }
  if (iVar11 < 0) {
    iVar11 = iVar11 + 0xff;
  }
  iVar9 = iVar8;
  if (iVar8 < 0) {
    iVar9 = iVar8 + 0xff;
  }
  iVar15 = (carObj->N).dimension.x;
  if (iVar15 < 0) {
    iVar15 = iVar15 + 0xff;
  }
  iVar16 = (iVar16 >> 8) * (iVar12 >> 8) + (iVar6 >> 8) * (iVar7 >> 8) +
           (iVar11 >> 8) * (iVar9 >> 8);
  if (iVar16 < 0) {
    iVar16 = iVar16 + 0xff;
  }
  iVar16 = (iVar15 >> 8) * (iVar16 >> 8);
  if (iVar16 < 0) {
    iVar16 = -iVar16;
  }
  iVar6 = iVar14 + iVar16 + BWorldSm_slices[sVar3].leftDrive * -0x100;
  if (iVar13 < iVar6 - carObj->extraWallCollisionAllowance) {
    iVar17 = -1;
    iVar18 = iVar6 - iVar13;
    currentWallType = 1;
  }
  iVar14 = BWorldSm_slices[sVar3].rightDrive * 0x100 - (iVar14 + iVar16);
  if (iVar14 + carObj->extraWallCollisionAllowance < iVar13) {
    iVar17 = 1;
    iVar18 = iVar13 - iVar14;
    currentWallType = 1;
  }
  iVar13 = 0;
  if (iVar17 != 0) {
    iVar13 = Force_IsForceOn(carObj);
    if (iVar13 != 0) {
      Force_HitWall(0x1e0000);
    }
    iVar13 = (carObj->N).dimension.x;
    if (iVar13 < 0) {
      iVar13 = iVar13 + 0xff;
    }
    iVar13 = (iVar13 >> 8) * iVar10;
    if (iVar13 < 0) {
      iVar13 = iVar13 + 0xff;
    }
    iVar14 = (carObj->N).dimension.x;
    if (iVar14 < 0) {
      iVar14 = iVar14 + 0xff;
    }
    iVar14 = (iVar14 >> 8) * iVar4;
    if (iVar14 < 0) {
      iVar14 = iVar14 + 0xff;
    }
    iVar16 = (carObj->N).dimension.x;
    if (iVar16 < 0) {
      iVar16 = iVar16 + 0xff;
    }
    iVar16 = (iVar16 >> 8) * iVar8;
    if (iVar16 < 0) {
      iVar16 = iVar16 + 0xff;
    }
    if (iVar17 < 1) {
      (carObj->N).collision.collisionPoint.x = (carObj->N).position.x - (iVar13 >> 8);
      (carObj->N).collision.collisionPoint.y = (carObj->N).position.y - (iVar14 >> 8);
      iVar13 = (carObj->N).position.z - (iVar16 >> 8);
    }
    else {
      (carObj->N).collision.collisionPoint.x = (carObj->N).position.x + (iVar13 >> 8);
      (carObj->N).collision.collisionPoint.y = (carObj->N).position.y + (iVar14 >> 8);
      iVar13 = (carObj->N).position.z + (iVar16 >> 8);
    }
    (carObj->N).collision.collisionPoint.z = iVar13;
    iVar13 = iVar17;
    if ((((carObj->N).objAltitude < 0x999a) && (0xe665 < (carObj->N).orientationToGround.y)) &&
       (iVar14 = iVar18 * 2, (carObj->N).flightTime == 0)) {
      if (iVar14 < 0) {
        iVar14 = iVar18 * -2;
      }
      iVar4 = Physics_AttenuateVelocity(carObj,iVar17 * iVar14,&(carObj->N).roadMatrix);
      Physics_CorrectPostCollisionYaw(carObj,iVar4,normal);
    }
    else {
      normal.x = iVar10;
      normal.y = iVar4;
      normal.z = iVar8;
      if (-1 < iVar17) {
        normal.x = cVar1 * -0x200;
        normal.y = cVar2 * -0x200;
        normal.z = r3 * -0x200;
      }
      Collide_TestWithPlane(&carObj->N,&normal,&(carObj->N).position);
      iVar4 = currentWallType;
      if ((carObj->N).collision.impulse != 0) {
        (carObj->N).collision.otherObj = (BO_tNewtonObj *)0x0;
        (carObj->N).collision.sfxType = iVar4 | 0x40000;
      }
    }
  }
  return iVar13;
}

/* ---- Physics_AutoShift__FP8Car_tObj  [PHYSICS.CPP:938-1038] SLD-VERIFIED ---- */
void Physics_AutoShift(Car_tObj *carObj)

{
  char cVar1;
  bool bVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  Car_tSpecs *pCVar6;
  u_int uVar7;
  u_int uVar8;
  int previousRpm;
  int iVar9;
  int velocity;
  int previousGear;
  int nextGear;
  u_int uVar10;
  int wheelRpm;
  int ShiftPoint;
  int iVar11;
  int SkipLastGear;
  int sliding;
  
  pCVar6 = carObj->specs;
  iVar9 = pCVar6->redline;
  iVar11 = iVar9 / 6;
  if (1 < (u_char)(carObj->control).gear) {
    if (carObj->RSControl != 0) {
      iVar11 = iVar9 / 2;
    }
    iVar11 = iVar9 - iVar11;
    iVar4 = carObj->slide;
    if (iVar4 < 0) {
      iVar4 = -iVar4;
    }
    iVar9 = fixedmult(pCVar6->gearVelInv[pCVar6->numGears + 6],iVar9 << 0x10);
    bVar2 = carObj->specs->maxSpeed < iVar9;
    iVar9 = 1;
    if (bVar2) {
      iVar9 = 2;
    }
    uVar7 = (u_int)(u_char)(carObj->control).gear;
    uVar10 = uVar7;
    if ((int)uVar7 < carObj->specs->numGears - iVar9) {
      uVar10 = uVar7 + 1;
    }
    if (2 < uVar7) {
      uVar7 = uVar7 - 1;
    }
    iVar9 = (carObj->N).speedXZ;
    if ((carObj->linearVel_ch).z < 0) {
      iVar9 = -iVar9;
    }
    iVar3 = fixedmult(iVar9,carObj->specs->velToRpmRatio[(u_char)(carObj->control).gear]);
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xffff;
    }
    iVar3 = iVar3 >> 0x10;
    fixedmult(iVar9,carObj->specs->velToRpmRatio[uVar10]);
    iVar9 = fixedmult(iVar9,carObj->specs->velToRpmRatio[uVar7]);
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xffff;
    }
    if (gGasRatio < 0x8001) {
      iVar5 = iVar3;
      if (iVar3 < 0) {
        iVar5 = -iVar3;
      }
      if (iVar5 <= carObj->specs->redline) {
        if (iVar11 <= iVar9 >> 0x10) {
          return;
        }
        if ((int)uVar7 < 2) {
          return;
        }
        if (0x1998 < iVar4) {
          return;
        }
        if (uVar7 == (u_char)(carObj->control).gear) {
          return;
        }
        pCVar6 = carObj->specs;
        (carObj->control).downShifting = '\x01';
        (carObj->control).gear = (char)uVar7;
        (carObj->control).gearShiftTimer = (char)pCVar6->gearShiftDelay;
        return;
      }
    }
    if ((iVar11 + 500 < iVar3) &&
       (uVar8 = (u_int)(u_char)(carObj->control).gear,
       (int)uVar8 < (int)(carObj->specs->numGears - (bVar2 + 1)))) {
      if (uVar10 != uVar8) {
        cVar1 = (carObj->control).gear;
        pCVar6 = carObj->specs;
        (carObj->control).downShifting = '\0';
        (carObj->control).gear = (char)uVar10;
        (carObj->control).lastGear = cVar1;
        (carObj->control).gearShiftTimer = (char)pCVar6->gearShiftDelay;
      }
    }
    else if ((iVar9 >> 0x10 < iVar11) && (uVar7 != (u_char)(carObj->control).gear)) {
      cVar1 = (carObj->control).gear;
      pCVar6 = carObj->specs;
      (carObj->control).downShifting = '\x01';
      (carObj->control).gear = (char)uVar7;
      (carObj->control).lastGear = cVar1;
      (carObj->control).gearShiftTimer = (char)pCVar6->gearShiftDelay;
    }
  }
  return;
}

/* ---- Physics_RampCarControlValues__FP8Car_tObj  [PHYSICS.CPP:1044-1278] SLD-VERIFIED ---- */
void Physics_RampCarControlValues(Car_tObj *carObj)

{
  char inc;
  u_char bVar1;
  u_char bVar2;
  char cVar3;
  char cVar4;
  int diff;
  int iVar5;
  int iVar6;
  int rampIn;
  Car_tSpecs *pCVar7;
  int iVar8;
  int iVar9;
  int i;
  int gear;
  
  if ((carObj->RSControl != 0) && ((u_char)(carObj->control).gear < 2)) {
    (carObj->control).desiredGear = '\x02';
    (carObj->control).gear = '\x02';
  }
  if (1 < (carObj->stats).finishType) {
    iVar5 = (carObj->N).linearVel.x;
    (carObj->control).steering = 0;
    (carObj->control).gasLevel = '\0';
    (carObj->control).brakeLevel = -1;
    (carObj->control).downShifting = '\0';
    iVar5 = iVar5 * 0xfe;
    (carObj->control).hanno = 0;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    iVar6 = (carObj->N).linearVel.y;
    (carObj->N).linearVel.x = iVar5 >> 8;
    iVar6 = iVar6 * 0xfe;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    iVar5 = (carObj->N).linearVel.z;
    (carObj->N).linearVel.y = iVar6 >> 8;
    iVar5 = iVar5 * 0xfe;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    (carObj->N).linearVel.z = iVar5 >> 8;
    goto RampCtrl_earlyBrake;
  }
  rampIn = 0x30;
  if (carObj->carInfo->RampGas != 0) {
    rampIn = 0x24;
  }
  bVar1 = (carObj->control).gasLevel;
  iVar5 = (u_int)(u_char)(carObj->control).desiredGasLevel - (u_int)bVar1;
  if (iVar5 < 0) {
    cVar3 = bVar1 + (char)iVar5;
    if (rampIn <= -iVar5) {
      cVar3 = bVar1 - (char)rampIn;
    }
  }
  else {
    cVar3 = bVar1 + (char)iVar5;
    if (rampIn <= iVar5) {
      cVar3 = bVar1 + (char)rampIn;
    }
  }
  (carObj->control).gasLevel = cVar3;
  if (carObj->carInfo->RampBrake == 0) {
    cVar3 = (carObj->control).desiredBrakeLevel;
  }
  else {
    bVar1 = (carObj->control).brakeLevel;
    iVar5 = (u_int)(u_char)(carObj->control).desiredBrakeLevel - (u_int)bVar1;
    if (iVar5 < 0) {
      cVar3 = bVar1 + (char)iVar5;
      if (0xf < -iVar5) {
        cVar3 = bVar1 - 0x10;
      }
    }
    else {
      cVar3 = bVar1 + (char)iVar5;
      if (0xf < iVar5) {
        cVar3 = bVar1 + 0x10;
      }
    }
  }
  (carObj->control).brakeLevel = cVar3;
  cVar3 = (carObj->control).gearShiftTimer;
  if (cVar3 != '\0') {
    (carObj->control).gearShiftTimer = cVar3 + -1;
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
        bVar1 = (carObj->control).desiredGear;
        if ((bVar1 == (carObj->control).gear) && ((carObj->stats).finishType == 0)) {
          if ((carObj->pullOver == 0) && (carObj->blowout == 0)) {
            iVar5 = (carObj->N).speedXZ;
            if (iVar5 < 0) {
              iVar5 = -iVar5;
            }
            if (iVar5 < 0x3333) {
              if (((((u_char)(carObj->control).desiredBrakeLevel < 0x81) ||
                   ((carObj->control).desiredGasLevel != '\0')) || (bVar1 < 2)) ||
                 ((carObj->control).hanno != 0)) {
                iVar5 = (carObj->N).speedXZ;
                if (iVar5 < 0) {
                  iVar5 = -iVar5;
                }
                if (((iVar5 < 0x3333) && (0x80 < (u_char)(carObj->control).desiredGasLevel)) &&
                   (((carObj->control).gear == '\0' && ((carObj->control).hanno != 0)))) {
                  (carObj->control).desiredGear = '\x02';
                  goto RampCtrl_hannoReset;
                }
              }
              else {
                (carObj->control).desiredGear = '\0';
                (carObj->control).hanno = 1;
              }
            }
          }
        }
        else {
RampCtrl_hannoReset:
          (carObj->control).hanno = 0;
        }
      }
    }
    bVar1 = (carObj->control).gear;
    bVar2 = (carObj->control).desiredGear;
    if (bVar2 != bVar1) {
      if ((GameSetup_gData.carInfo[carObj->carIndex].Transmission == 1) || (carObj->RSControl != 0))
      {
        if (1 < bVar2) {
          if (bVar2 == 2) {
            iVar5 = 2;
            cVar3 = '\x02';
            if (bVar1 < 2) {
              pCVar7 = carObj->specs;
              (carObj->control).lastGear = bVar1;
              iVar6 = 2;
              if (2 < pCVar7->numGears) {
                iVar8 = 8;
                do {
                  iVar8 = fixedmult(*(int *)((int)pCVar7->velToRpmRatioInv + iVar8),
                                     pCVar7->redline << 0x10);
                  if (iVar8 < (carObj->linearVel_ch).z) {
                    iVar5 = iVar6;
                  }
                  cVar3 = (char)iVar5;
                  pCVar7 = carObj->specs;
                  iVar6 = iVar6 + 1;
                  iVar8 = iVar6 * 4;
                } while (iVar6 < pCVar7->numGears);
              }
              pCVar7 = carObj->specs;
              (carObj->control).downShifting = '\0';
              (carObj->control).gear = cVar3;
              (carObj->control).gearShiftTimer = (char)pCVar7->gearShiftDelay;
            }
          }
          goto RampCtrl_setSteering;
        }
        cVar3 = (carObj->control).gear;
        cVar4 = (carObj->control).desiredGear;
        pCVar7 = carObj->specs;
        (carObj->control).downShifting = '\0';
      }
      else {
        if ((bVar2 < bVar1) && (1 < bVar2)) {
          (carObj->control).downShifting = '\x01';
        }
        else {
          (carObj->control).downShifting = '\0';
        }
        cVar3 = (carObj->control).gear;
        cVar4 = (carObj->control).desiredGear;
        pCVar7 = carObj->specs;
      }
      (carObj->control).lastGear = cVar3;
      (carObj->control).gear = cVar4;
      (carObj->control).gearShiftTimer = (char)pCVar7->gearShiftDelay;
    }
  }
RampCtrl_setSteering:
  if (carObj->carInfo->RampSteering == 0) {
    iVar5 = (carObj->control).desiredSteering;
  }
  else {
    iVar9 = (carObj->control).steering;
    iVar6 = (carObj->control).desiredSteering - iVar9;
    iVar8 = carObj->specs->steeringRamp;
    if (iVar6 < 0) {
      iVar5 = iVar9 + iVar6;
      if (iVar8 <= -iVar6) {
        iVar5 = iVar9 - iVar8;
      }
    }
    else {
      iVar5 = iVar9 + iVar6;
      if (iVar8 <= iVar6) {
        iVar5 = iVar9 + iVar8;
      }
    }
  }
  (carObj->control).steering = iVar5;
RampCtrl_earlyBrake:
  if ((simGlobal.gameTicks < 0x200) &&
     (((GameSetup_gData.raceType != 1 && (GameSetup_gData.raceType != 5)) ||
      (((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0 &&
       ((Cars_gNumHumanRaceCars != 2 || ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0))))))))
  {
    (carObj->control).brakeLevel = -1;
  }
  else if ((carObj->blowout != 0) || (carObj->pullOver != 0)) {
    if ((carObj->control).hanno == 0) {
      (carObj->control).gasLevel = '\0';
      (carObj->control).brakeLevel = -0x80;
    }
    else {
      (carObj->control).gasLevel = -0x80;
      (carObj->control).brakeLevel = '\0';
    }
    (carObj->control).downShifting = '\0';
  }
  if (carObj->crash == 2) {
    (carObj->control).gasLevel = '\0';
  }
  if ((AIInit_forceHumanHandBrake != 0) && (carObj->RSControl != 0)) {
    iVar5 = -0x7c;
    if (carObj->roadPosition * carObj->direction < 1) {
      iVar5 = 0x7c;
    }
    (carObj->control).steering = iVar5;
    (carObj->control).handBrake = '\x01';
  }
  gGasRatio = (((u_char)(carObj->control).gasLevel + 1) * 0x10000) / 0xf8;
  if (0x10000 < (u_int)gGasRatio) {
    gGasRatio = 0x10000;
  }
  gBrakeRatio = (((u_char)(carObj->control).brakeLevel + 1) * 0x10000) / 0xf8;
  if (0x10000 < (u_int)gBrakeRatio) {
    gBrakeRatio = 0x10000;
  }
  iVar5 = (carObj->control).steering;
  if (iVar5 < 0) {
    iVar5 = -iVar5;
  }
  gSteerRatio = iVar5 << 9;
  if (((GameSetup_gData.carInfo[carObj->carIndex].Transmission == 1) &&
      ((carObj->control).gear == '\0')) && ((carObj->control).hanno == 1)) {
    gGasRatio = (((u_char)(carObj->control).brakeLevel + 1) * 0x10000) / 0xf8;
    if (0x10000 < (u_int)gGasRatio) {
      gGasRatio = 0x10000;
    }
    gBrakeRatio = (((u_char)(carObj->control).gasLevel + 1) * 0x10000) / 0xf8;
    if (0x10000 < (u_int)gBrakeRatio) {
      gBrakeRatio = 0x10000;
    }
  }
  return;
}

/* ---- Physics_FixEngineRpm__FP8Car_tObj  [PHYSICS.CPP:1287-1307] SLD-VERIFIED ---- */
void Physics_FixEngineRpm(Car_tObj *carObj)

{
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  
  iVar4 = (carObj->N).linearVel.x;
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar1 = (carObj->N).shadowMat.m[0];
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar5 = (carObj->N).linearVel.y;
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  iVar2 = (carObj->N).shadowMat.m[1];
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar6 = (carObj->N).linearVel.z;
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar3 = (carObj->N).shadowMat.m[2];
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar7 = (carObj->N).linearVel.x;
  (carObj->linearVel_ch).x =
       (iVar4 >> 8) * (iVar1 >> 8) + (iVar5 >> 8) * (iVar2 >> 8) + (iVar6 >> 8) * (iVar3 >> 8);
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  iVar4 = (carObj->N).shadowMat.m[6];
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar1 = (carObj->N).linearVel.y;
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar5 = (carObj->N).shadowMat.m[7];
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  iVar2 = (carObj->N).linearVel.z;
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar6 = (carObj->N).shadowMat.m[8];
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  (carObj->linearVel_ch).z =
       (iVar7 >> 8) * (iVar4 >> 8) + (iVar1 >> 8) * (iVar5 >> 8) + (iVar2 >> 8) * (iVar6 >> 8);
  iVar4 = (carObj->N).collision.collided;
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
  int iVar1;
  
  if (carObj->carInfo->Transmission == 1) {
    (carObj->control).desiredGear = '\x02';
    (carObj->control).gear = '\x02';
  }
  else {
    (carObj->control).desiredGear = '\x01';
    (carObj->control).gear = '\x01';
  }
  iVar1 = 0;
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
  do {
    carObj->wheel[0].wheelInAir = 0;
    carObj->wheel[0].rebound = 0;
    iVar1 = iVar1 + 1;
    carObj = (Car_tObj *)&(carObj->N).simRoadInfo.quadPts[2].z;
  } while (iVar1 < 4);
  return;
}

/* ---- Physics_StopCar__FP8Car_tObj  [PHYSICS.CPP:1364-1370] SLD-VERIFIED ---- */
void Physics_StopCar(Car_tObj *carObj)

{
  int iVar1;
  int iVar2;
  
  iVar1 = (carObj->N).linearVel.x * 0xf5;
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar2 = (carObj->N).linearVel.y;
  (carObj->N).linearVel.x = iVar1 >> 8;
  iVar2 = iVar2 * 0xf5;
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar1 = (carObj->N).linearVel.z;
  (carObj->N).linearVel.y = iVar2 >> 8;
  iVar1 = iVar1 * 0xf5;
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar2 = (carObj->N).orientationToGround.y;
  (carObj->N).linearVel.z = iVar1 >> 8;
  if (iVar2 < 0x3333) {
    iVar1 = (carObj->N).angularVel.y;
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    (carObj->N).angularVel.y = (iVar1 >> 8) * 0xfa;
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
  int tempSurface;
  int roadSurfaceType;
  u_int uVar1;
  int iVar2;
  int i;
  Car_tObj *pCVar3;
  int frontWheels;
  int iVar4;
  int rearWheels;
  int iVar5;
  int leftWheels;
  int iVar6;
  int rightWheels;
  int iVar7;
  
  iVar4 = 0;
  iVar5 = 0;
  iVar6 = 0;
  iVar7 = 0;
  pCVar3 = carObj;
  for (iVar2 = 0; frontMult = iVar4 >> 1, iVar2 < 4; iVar2 = iVar2 + 1) {
    uVar1 = (u_int)(u_char)roadSurfaceIndex[carObj->carInfo->TireType]
                        [pCVar3->wheel[0].roadSurfaceType & 0xf];
    if (slippery != 0) {
      uVar1 = uVar1 + 1;
    }
    if (iVar2 < 2) {
      iVar4 = iVar4 + roadSurfaceFrictionCoeff[uVar1];
    }
    else {
      iVar5 = iVar5 + roadSurfaceFrictionCoeff[uVar1];
    }
    if ((iVar2 == 0) || (iVar2 == 2)) {
      iVar6 = iVar6 + roadSurfaceFrictionCoeff[uVar1];
    }
    else {
      iVar7 = iVar7 + roadSurfaceFrictionCoeff[uVar1];
    }
    pCVar3 = (Car_tObj *)&(pCVar3->N).simRoadInfo.quadPts[2].z;
  }
  rearMult = iVar5 >> 1;
  leftMult = iVar6 >> 1;
  rightMult = iVar7 >> 1;
  iVar2 = (carObj->linearVel_ch).z;
  roadMult = (frontMult + rearMult >> 1) + (carObj->N).roadGravityModifier;
  if (0x50000 < iVar2) {
    iVar2 = fixedmult(iVar2,carObj->specs->frontAeroDownForce);
    frontMult = frontMult + iVar2;
    iVar2 = fixedmult((carObj->linearVel_ch).z,carObj->specs->rearAeroDownForce);
    rearMult = rearMult + iVar2;
  }
  return;
}

/* ---- Physics_CalculateCarAcceleration__FP8Car_tObj  [PHYSICS.CPP:1447-1672] SLD-VERIFIED ---- */
int Physics_CalculateCarAcceleration(Car_tObj *carObj)

{
  int diffDesiredRpm;
  int ratio;
  int temp;
  char cVar1;
  u_char bVar2;
  bool bVar3;
  int iVar4;
  int iVar5;
  u_int uVar6;
  int rpmRise;
  int rpmDrop;
  int iVar7;
  int iVar8;
  int iVar9;
  int desiredRpm;
  int iVar10;
  Car_tSpecs *specs;
  Car_tSpecs *pCVar11;
  int diffFlywheelRpm;
  int iVar12;
  int driveAcc;
  int wheelRpm;
  int drag;
  int damage;
  int smokeRpm;
  int blip [8];
  int bblip [8];
  
  blip[0] = physics_blipInit[0];
  blip[1] = physics_blipInit[1];
  blip[2] = physics_blipInit[2];
  blip[3] = physics_blipInit[3];
  blip[4] = physics_blipInit[4];
  blip[5] = physics_blipInit[5];
  blip[6] = physics_blipInit[6];
  blip[7] = physics_blipInit[7];
  bblip[0] = physics_bblipInit[0];
  bblip[1] = physics_bblipInit[1];
  bblip[2] = physics_bblipInit[2];
  bblip[3] = physics_bblipInit[3];
  bblip[4] = physics_bblipInit[4];
  bblip[5] = physics_bblipInit[5];
  bblip[6] = physics_bblipInit[6];
  bblip[7] = physics_bblipInit[7];
  iVar9 = carObj->specs->redline;
  if (iVar9 < 0) {
    iVar9 = iVar9 + 7;
  }
  randtemp = fastRandom * randSeed;
  rpmDrop = (carObj->N).damage[1];
  iVar7 = rpmDrop + (carObj->N).damage[5];
  fastRandom = randtemp & 0xffff;
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  bVar3 = (randtemp >> 8 & 0xffff) < (u_int)(iVar7 >> 8);
  pCVar11 = carObj->specs;
  exceedRedline = (int)(pCVar11->redline + 500 < carObj->flywheelRpm);
  iVar7 = 0x10000;
  if (carObj->carInfo->GroundEffects != 0) {
    iVar7 = (carObj->specs->frontAeroDownForce + carObj->specs->rearAeroDownForce) / 2 + 0x10000;
  }
  iVar7 = fixedmult((carObj->linearVel_ch).z,iVar7);
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xffff;
  }
  iVar7 = iVar7 >> 0x10;
  iVar7 = fixedmult(pCVar11->dragCoeff,iVar7 * iVar7 * iVar7);
  if (((carObj->control).gear == '\x01') || (powerControl == 0)) {
    iVar10 = pCVar11->redline + 0xfa;
    iVar4 = fixedmult(iVar10,gGasRatio);
    if (iVar4 < iVar10) {
      iVar4 = pCVar11->redline + 0xfa;
      goto Phy_CalcAcc_gasRatioMul;
    }
    iVar4 = pCVar11->redline + 0xfa;
  }
  else {
    iVar10 = pCVar11->redline + 100;
    iVar4 = fixedmult(iVar10,gGasRatio);
    if (iVar4 < iVar10) {
      iVar4 = pCVar11->redline + 100;
Phy_CalcAcc_gasRatioMul:
      iVar4 = fixedmult(iVar4,gGasRatio);
    }
    else {
      iVar4 = pCVar11->redline + 100;
    }
  }
  if (pCVar11->redline <= carObj->flywheelRpm) {
    cVar1 = (carObj->control).gear;
    carObj->flywheelRpm = pCVar11->redline + 0x32;
    iVar10 = 3;
    if ((cVar1 != '\x01') && (iVar10 = 4, powerControl == 0)) {
      iVar10 = 3;
    }
    carObj->revLimit = iVar10;
  }
  iVar10 = iVar4;
  if (0 < carObj->revLimit) {
    if (((carObj->control).gear == '\x01') || (powerControl == 0)) {
      iVar10 = pCVar11->redline + -800;
    }
    else {
      iVar10 = pCVar11->redline + -400;
    }
    if (iVar4 <= iVar10) {
      iVar10 = iVar4;
    }
    carObj->revLimit = carObj->revLimit + -1;
  }
  if ((((carObj->control).gear == '\x01') || ((carObj->control).gearShiftTimer != '\0')) ||
     (powerControl == 0)) {
    if (bVar3) {
      iVar9 = carObj->flywheelRpm + -100;
      carObj->flywheelRpm = iVar9;
cfLbl1:   /* @0x800aae38  (-f-build goto label) */
      if (iVar9 < 0) {
        iVar9 = 0;
      }
      carObj->flywheelRpm = iVar9;
    }
    else {
      if (carObj->flywheelRpm < iVar10) {
        iVar9 = carObj->flywheelRpm + 0xfa;
        if ((carObj->control).gearShiftTimer == '\0') {
          carObj->flywheelRpm = iVar9;
          if (iVar9 <= iVar10) {
            iVar10 = iVar9;
          }
        }
        else {
Phy_CalcAcc_gearShiftHandler:
          if ((carObj->control).lastGear == '\x01') goto Phy_CalcAcc_rpmBleedDown;
          if ((carObj->control).downShifting == '\0') {
            if ((u_char)(carObj->control).gear < 4) {
              iVar9 = carObj->flywheelRpm + -100;
            }
            else {
              iVar9 = carObj->flywheelRpm + -200;
            }
            carObj->flywheelRpm = iVar9;
            iVar9 = carObj->flywheelRpm;
            goto cfLbl1;
          }
          if ((u_char)(carObj->control).brakeLevel < 0x41) {
            iVar9 = carObj->flywheelRpm + blip[(u_char)(carObj->control).desiredGear];
          }
          else {
            iVar9 = carObj->flywheelRpm + bblip[(u_char)(carObj->control).desiredGear];
          }
          carObj->flywheelRpm = iVar9;
          iVar10 = pCVar11->redline;
          if (carObj->flywheelRpm <= pCVar11->redline) {
            iVar10 = carObj->flywheelRpm;
          }
        }
      }
      else {
        if ((carObj->control).gearShiftTimer != '\0') goto Phy_CalcAcc_gearShiftHandler;
Phy_CalcAcc_rpmBleedDown:
        iVar9 = carObj->flywheelRpm + -200;
        if (carObj->flywheelRpm < iVar10) goto Phy_CalcAcc_clearWheelSpinExit;
        carObj->flywheelRpm = iVar9;
        if (iVar10 < iVar9) {
          iVar10 = iVar9;
        }
      }
      carObj->flywheelRpm = iVar10;
    }
Phy_CalcAcc_clearWheelSpinExit:
    carObj->frontWheelSpin = 0;
    carObj->wheelSpin = 0;
    iVar4 = 0;
    goto Phy_CalcAcc_finalAdjustReturn;
  }
  if ((GameSetup_gData.carInfo[carObj->carIndex].Transmission == 1) || (carObj->RSControl != 0)) {
    Physics_AutoShift(carObj);
  }
  if (((carObj->control).gearShiftTimer == '\0') || ((carObj->control).downShifting != '\0')) {
    bVar2 = (carObj->control).gear;
  }
  else {
    bVar2 = (carObj->control).lastGear;
  }
  iVar5 = fixedmult((carObj->linearVel_ch).z,pCVar11->velToRpmRatio[bVar2]);
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xffff;
  }
  iVar5 = iVar5 >> 0x10;
  if ((exceedRedline == 0) && (carObj->revLimit < 1)) {
    iVar4 = carObj->flywheelRpm;
    if (iVar4 < 0) {
      iVar4 = iVar4 + 0xff;
    }
    iVar4 = Physics_GetTorque(carObj,iVar4 >> 8);
    iVar4 = fixedmult(iVar4,pCVar11->gearAccCoeff[(u_char)(carObj->control).gear]);
  }
  else {
    iVar4 = pCVar11->redline;
    if (iVar4 < 0) {
      iVar4 = iVar4 + 0xff;
    }
    iVar4 = fixedmult(pCVar11->torqueCurve[iVar4 >> 8],
                       pCVar11->gearAccCoeff[(u_char)(carObj->control).gear]);
    iVar4 = iVar4 << 1;
  }
  iVar8 = iVar10 - iVar5;
  iVar12 = iVar8;
  if (iVar8 < 0) {
    iVar12 = -iVar8;
  }
  if ((iVar12 < 0x7d) && (iVar10 < pCVar11->redline + -300)) {
    iVar8 = 0;
  }
  iVar12 = carObj->flywheelRpm - iVar5;
  if ((((((iVar12 < 0xfb) || ((carObj->control).gearShiftTimer != '\0')) ||
        (4 < (u_char)(carObj->control).gear)) &&
       ((((u_char)(carObj->control).gear < 2 || (-0x199a < (carObj->linearVel_ch).z)) ||
        (gGasRatio < 0x8001)))) &&
      (((((carObj->control).gear != '\0' || ((carObj->linearVel_ch).z < 0x199a)) ||
        (gGasRatio < 0x8001)) && (carObj->wheelSpin != 1)))) || (carObj->revLimit != 0)) {
    if (iVar8 < 0) {
      iVar4 = fixedmult(iVar4,pCVar11->gasOffFactor);
      iVar4 = -iVar4;
      if ((((gravity_ch.z < 1) || (bVar2 = (carObj->control).gear, bVar2 < 2)) || (-1 < iVar4)) ||
         (2 < bVar2)) {
        if (-1 < gravity_ch.z) goto Phy_CalcAcc_gearFetchJoin;
        uVar6 = (u_int)(u_char)(carObj->control).gear;
        if (uVar6 == 0) {
          if (0 < iVar4) goto Phy_CalcAcc_halveAccPath;
          goto Phy_CalcAcc_gearFetchJoin;
        }
      }
      else {
Phy_CalcAcc_halveAccPath:
        iVar4 = iVar4 / 2;
Phy_CalcAcc_gearFetchJoin:
        uVar6 = (u_int)(u_char)(carObj->control).gear;
      }
      iVar9 = fixedmult(pCVar11->velToRpmRatioInv[uVar6] << 3,0x28000000)
      ;
      if (iVar9 < 0) {
        iVar9 = iVar9 + 0xffff;
      }
      iVar9 = iVar9 >> 0x10;
      if ((carObj->control).gear == '\0') {
        if (iVar9 < -iVar12) {
          iVar9 = -iVar12;
        }
        iVar5 = carObj->flywheelRpm + iVar9;
      }
      else {
        iVar5 = carObj->flywheelRpm + iVar9;
        if (-iVar12 <= iVar9) {
          iVar5 = carObj->flywheelRpm - iVar12;
        }
      }
      carObj->flywheelRpm = iVar5;
      if (exceedRedline == 0) {
        if (iVar10 < carObj->flywheelRpm) {
          iVar10 = carObj->flywheelRpm;
        }
        carObj->flywheelRpm = iVar10;
      }
    }
    else if (iVar8 == 0) {
      carObj->flywheelRpm = iVar5;
      iVar4 = iVar7;
    }
    else {
      if (bVar3) {
        iVar9 = 0;
        carObj->flywheelRpm = carObj->flywheelRpm + -100;
      }
      else {
        if (iVar12 < 0xc9) {
          if (iVar12 < -200) {
            carObj->flywheelRpm = carObj->flywheelRpm + 200;
          }
          else {
            carObj->flywheelRpm = iVar5;
          }
        }
        else {
          carObj->flywheelRpm = carObj->flywheelRpm + -200;
        }
        iVar9 = fixedmult(iVar4,gGasRatio);
      }
      if (carObj->flywheelRpm <= iVar10) {
        iVar10 = carObj->flywheelRpm;
      }
      carObj->flywheelRpm = iVar10;
      iVar4 = carObj->slide;
      if (iVar4 < 0) {
        iVar4 = -iVar4;
      }
      iVar4 = iVar4 + 0x10000;
      if ((GameSetup_gData.sgge & 8U) == 0) {
        if (0x20000 < iVar4) {
          iVar4 = 0x20000;
        }
      }
      else if (0x30000 < iVar4) {
        iVar4 = 0x30000;
      }
      if (iVar9 < 0) {
        iVar9 = iVar9 + 0xff;
      }
      if (iVar4 < 0) {
        iVar4 = iVar4 + 0xff;
      }
      iVar4 = (iVar9 >> 8) * (iVar4 >> 8);
    }
  }
  else {
    iVar5 = 0;
    if (((iVar10 < 2000) || ((u_char)(carObj->control).desiredGasLevel < 0x40)) ||
       ((bVar3 || ((carObj->carInfo->carType == 0x13 && (2 < (u_char)(carObj->control).gear)))))) {
      iVar5 = 200;
    }
    else {
      bVar2 = (carObj->control).gear;
      if ((bVar2 == 2) || (bVar2 == 0)) {
        iVar5 = 10;
      }
      else if (2 < bVar2) {
        iVar5 = 0x32;
      }
    }
    if (iVar9 >> 3 < iVar12) {
      carObj->wheelSpin = 2;
    }
    if (iVar12 <= iVar5) {
      iVar5 = iVar12;
    }
    carObj->flywheelRpm = carObj->flywheelRpm - iVar5;
  }
  if (carObj->flywheelRpm < 0) {
    iVar10 = (carObj->linearVel_ch).z;
    iVar9 = iVar10 * -0x20;
    if ((((iVar4 < 1) || (iVar9 < 1)) || (iVar4 + iVar10 * 0x20 < 1)) &&
       (((-1 < iVar4 || (-1 < iVar9)) || (-1 < iVar4 + iVar10 * 0x20)))) {
      carObj->flywheelRpm = 0;
      iVar4 = iVar9;
    }
  }
Phy_CalcAcc_finalAdjustReturn:
  iVar9 = iVar4 - iVar7;
  if (carObj->carInfo->carType - 0xcU < 4) {
    if (slippery != 0) {
      if ((carObj->control).gear != '\x02') {
        return iVar4 - iVar7;
      }
      if (0 < iVar4) {
        iVar4 = iVar4 * 3 >> 2;
      }
    }
    iVar9 = iVar4 - iVar7;
  }
  return iVar9;
}

/* ---- Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct  [PHYSICS.CPP:1680-1725] SLD-VERIFIED ---- */
void Physics_CalcWheelLockAcc(Car_tObj *carObj,Physics_tWheelAccStruct *wheel)

{
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int *piVar5;
  int optVar2;
  int totalAcc;
  int roadGrip;
  int iVar6;
  int optVar1;
  
  if (wheel->frontTire == 0) {
    iVar3 = wheel->roadGrip;
    wheel->skid = *(int *)((int)carObj + 0x488);
    iVar1 = rearMult;
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xff;
    }
  }
  else {
    iVar3 = wheel->roadGrip;
    wheel->skid = *(int *)((int)carObj + 0x484);
    iVar1 = frontMult;
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xff;
    }
  }
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar1 = (iVar3 >> 8) * (iVar1 >> 8);
  iVar3 = (wheel->velCap).x;
  iVar4 = (wheel->velCap).z;
  if (iVar3 < 0) {
    iVar3 = -iVar3;
  }
  if (iVar4 < 0) {
    iVar4 = -iVar4;
  }
  if (iVar4 < iVar3) {
    totalAcc = iVar3 + (iVar4 >> 2);
  }
  else {
    totalAcc = iVar4 + (iVar3 >> 2);
  }
  if (slippery == 0) {
    iVar4 = *(int *)(*(int *)((int)carObj + 0x288) + 0x38);
    piVar5 = gripLossTable;
  }
  else {
    iVar4 = *(int *)(*(int *)((int)carObj + 0x288) + 0x38);
    piVar5 = gripLossTableWet;
  }
  iVar4 = piVar5[iVar4];
  if (iVar1 < totalAcc) {
    wheel->skid = wheel->skid * 3 + (totalAcc - iVar1) >> 2;
  }
  else {
    wheel->skid = 0;
  }
  iVar6 = 0xa0000;
  if (*(int *)(*(int *)((int)carObj + 0x288) + 0x38) == 2) {
    iVar6 = 0x80000;
  }
  if (wheel->skid <= iVar6) {
    iVar6 = wheel->skid;
  }
  iVar2 = totalAcc;
  if (totalAcc < 0) {
    iVar2 = -totalAcc;
  }
  wheel->skid = iVar6;
  if (0x100 < iVar2) {
    iVar3 = fixeddiv(iVar1 - iVar1 / iVar4,totalAcc);
    iVar3 = iVar3 >> 8;
  }
  iVar1 = (wheel->velCap).z;
  (wheel->finalAcc).x = (wheel->velCap).x * iVar3 >> 8;
  (wheel->finalAcc).z = iVar1 * iVar3 >> 8;
  return;
}

/* ---- Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct  [PHYSICS.CPP:1731-1810] SLD-VERIFIED ---- */
void Physics_CalcTractionCircleAcc(Car_tObj *carObj,Physics_tWheelAccStruct *wheel)

{
  int iVar1;
  int iVar2;
  int gripLoss;
  int iVar3;
  int *piVar4;
  int roadGrip;
  int gripLossDivider;
  int iVar5;
  int ratio;
  int totalAcc;
  
  iVar1 = (wheel->finalAcc).x;
  iVar3 = (wheel->finalAcc).z;
  if (iVar1 < 0) {
    iVar1 = -iVar1;
  }
  if (iVar3 < 0) {
    iVar3 = -iVar3;
  }
  if (iVar3 < iVar1) {
    iVar1 = iVar1 + (iVar3 >> 2);
  }
  else {
    iVar1 = iVar3 + (iVar1 >> 2);
  }
  roadGrip = wheel->roadGrip;
  if (wheel->frontTire == 0) {
    iVar3 = (wheel->finalAcc).z;
    if (iVar3 < 0) {
      iVar3 = -iVar3;
    }
    wheel->skid = carObj->rearSkid;
    if (((roadGrip < iVar3) && (0x80 < (u_char)(carObj->control).gasLevel)) ||
       (carObj->wheelSpin == 2)) {
      carObj->wheelSpin = 1;
    }
    else {
      carObj->wheelSpin = 0;
    }
  }
  else {
    wheel->skid = carObj->frontSkid;
  }
  if (slippery == 0) {
    iVar3 = carObj->carInfo->TireType;
    piVar4 = gripLossTable;
  }
  else {
    iVar3 = carObj->carInfo->TireType;
    piVar4 = gripLossTableWet;
  }
  iVar3 = piVar4[iVar3];
  if (roadGrip < iVar1) {
    iVar5 = iVar1 - roadGrip;
    if ((carObj->carInfo->Traction == 0) || (wheel->frontTire != 0)) {
PhyTracCircle_divCheck:
      iVar2 = iVar5 / iVar3;
      if (roadGrip / iVar3 <= iVar5 / iVar3) {
        iVar2 = roadGrip / iVar3;
      }
      iVar3 = fixeddiv(roadGrip - iVar2,iVar1);
      if (carObj->carInfo->TireType == 2) {
        iVar5 = wheel->skid * 0xf + iVar5;
        if (iVar5 < 0) {
          iVar5 = iVar5 + 0xf;
        }
        iVar5 = iVar5 >> 4;
      }
      else {
        iVar5 = wheel->skid * 3 + iVar5;
        if (iVar5 < 0) {
          iVar5 = iVar5 + 3;
        }
        iVar5 = iVar5 >> 2;
      }
      wheel->skid = iVar5;
      iVar5 = fixedmult((wheel->finalAcc).x,iVar3);
      iVar2 = (wheel->finalAcc).z;
      (wheel->finalAcc).x = iVar5;
    }
    else {
      iVar2 = carObj->slide;
      if (iVar2 < 0) {
        iVar2 = -iVar2;
      }
      if (0x2665 < iVar2) goto PhyTracCircle_divCheck;
      iVar3 = fixeddiv(roadGrip,iVar1);
      wheel->skid = 0;
      if (2 < (u_char)(carObj->control).gear) {
        iVar5 = fixedmult((wheel->finalAcc).x,iVar3);
        (wheel->finalAcc).x = iVar5;
      }
      iVar2 = (wheel->finalAcc).z;
    }
    iVar3 = fixedmult(iVar2,iVar3);
    (wheel->finalAcc).z = iVar3;
  }
  else {
    wheel->skid = 0;
  }
  if (((wheel->frontTire == 0) && (carObj->wheelSpin == 1)) && (carObj->carInfo->Traction == 0)) {
    wheel->skid = iVar1;
    if ((u_char)(carObj->control).gear < 4) {
      wheel->skid = iVar1 << 2;
    }
  }
  iVar1 = carObj->carInfo->TireType;
  if (iVar1 == 1) {
    iVar3 = 0x80000;
  }
  else {
    iVar3 = 0x40000;
    if (iVar1 != 2) goto PhyTracCircle_skidAdjust;
  }
  if (wheel->skid <= iVar3) {
    iVar3 = wheel->skid;
  }
  wheel->skid = iVar3;
PhyTracCircle_skidAdjust:
  if (carObj->carInfo->Traction != 0) {
    iVar1 = wheel->skid * 3;
    if (iVar1 < 0) {
      iVar1 = iVar1 + 3;
    }
    wheel->skid = iVar1 >> 2;
  }
  return;
}

/* ---- Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct  [PHYSICS.CPP:1815-1979] SLD-VERIFIED ---- */
void Physics_CalculateTireForces(Car_tObj *carObj,Physics_tWheelAccStruct *wheel)

{
  int brakingSituation;
  bool bVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int latAcc;
  int slipAngle;
  int roadGrip;
  int iVar5;
  
  iVar5 = wheel->roadGrip;
  bVar1 = false;
  wheel->skid = 0;
  if (wheel->steeringAngle != 0) {
    latAcc = (wheel->velCap).z;
    Math_ResolveRotatedVector((wheel->velCap).x,latAcc,wheel->steeringAngle,&(wheel->velCap).x,&(wheel->velCap).z);
  }
  iVar4 = wheel->acc;
  if ((iVar4 < 0) && (iVar3 = (wheel->velCap).z, iVar3 < 0)) {
    if ((gGasRatio < 0x4001) || ((carObj->control).gear != '\0')) {
      if (iVar3 < iVar4) {
        iVar3 = iVar4;
      }
Phy_TireF_applyAccCap:
      wheel->acc = iVar3;
      bVar1 = true;
    }
  }
  else if (((0 < iVar4) && (iVar3 = (wheel->velCap).z, 0 < iVar3)) &&
          ((gGasRatio < 0x4001 || ((u_char)(carObj->control).gear < 2)))) {
    if (iVar4 <= iVar3) {
      iVar3 = iVar4;
    }
    goto Phy_TireF_applyAccCap;
  }
  iVar4 = fixedmult(wheel->acc,carObj->specs->lateralGripMult);
  wheel->acc = iVar4;
  if (bVar1) {
    if (iVar4 < 0) {
      iVar4 = -iVar4;
    }
    if (iVar4 <= wheel->roadGrip) goto Phy_TireF_handBrakeCheck;
Phy_TireF_handBrakeActive:
    if ((carObj->control).handBrake != '\0') {
Phy_TireF_wheelLockCalc:
      if (wheel->frontTire == 0) {
        iVar5 = carObj->wheelLock + 2;
      }
      else {
        iVar5 = carObj->wheelLock + 1;
      }
      carObj->wheelLock = iVar5;
      Physics_CalcWheelLockAcc(carObj,wheel);
      iVar5 = wheel->frontTire;
      goto cfLbl2;
    }
    if (((carObj->carInfo->ABS == 0) && (iVar4 = (carObj->linearVel_ch).z, iVar4 < 0x190001)) &&
       (0xeb < (u_char)(carObj->control).brakeLevel)) {
      if (iVar4 < 0) {
        iVar4 = -iVar4;
      }
      if ((0x4ffff < iVar4) || (carObj->wheelSpin != 0)) goto Phy_TireF_wheelLockCalc;
    }
    iVar4 = wheel->roadGrip;
    if ((iVar4 < wheel->acc) || (iVar4 = -iVar4, wheel->acc < iVar4)) {
      wheel->acc = iVar4;
    }
    if ((carObj->carInfo->ABS != 0) && ((carObj->linearVel_ch).z < 0x190000)) {
      if ((simGlobal.gameTicks & 3U) == 0) {
        wheel->skid = 0x80000;
      }
      else {
        wheel->skid = 0;
      }
    }
  }
  else {
Phy_TireF_handBrakeCheck:
    if (((carObj->control).handBrake != '\0') && (wheel->frontTire == 0)) {
      iVar4 = (carObj->linearVel_ch).z;
      if (iVar4 < 0) {
        iVar4 = -iVar4;
      }
      if (0x8000 < iVar4) goto Phy_TireF_handBrakeActive;
    }
  }
  iVar4 = (wheel->velCap).z;
  if (iVar4 == 0) {
    iVar4 = 0;
  }
  else {
    iVar4 = fixedatan((wheel->velCap).x,-iVar4 / 2);
    if (0 < (wheel->velCap).z) {
      iVar3 = (wheel->velCap).x;
      if (iVar3 < 1) {
        iVar2 = -0x8000;
        if (-1 < iVar3) goto Phy_TireF_finalShift;
      }
      else {
        iVar2 = 0x8000;
      }
      iVar4 = iVar2 - iVar4;
    }
Phy_TireF_finalShift:
    iVar4 = iVar4 << 8;
  }
  if (wheel->frontTire == 0) {
    iVar3 = iVar4;
    if (iVar4 < 0) {
      iVar3 = -iVar4;
    }
    if (iVar3 < 0x8000) {
      iVar3 = 0x8000;
    }
    iVar2 = 0x20000;
    if (iVar3 < 0x20001) {
      iVar2 = iVar4;
      if (iVar4 < 0) {
        iVar2 = -iVar4;
      }
      if (iVar2 < 0x8000) {
        iVar2 = 0x8000;
      }
    }
    iVar5 = fixedmult(iVar2,iVar5);
    iVar5 = iVar5 / 2;
    if (iVar4 < 0) {
      iVar5 = -iVar5;
    }
    iVar4 = (wheel->velCap).x;
    iVar5 = iVar5 + gravity_ch.x / 2;
    if (iVar4 < 1) {
      if (iVar5 < 0) {
        iVar5 = -iVar5;
      }
      iVar3 = -iVar5;
      if (-iVar5 < iVar4) {
        iVar3 = iVar4;
      }
    }
    else {
      if (iVar5 < 0) {
        iVar5 = -iVar5;
      }
      iVar3 = iVar5;
      if (iVar4 <= iVar5) {
        iVar3 = iVar4;
      }
    }
Phy_TireF_finalAccX:
    (wheel->finalAcc).x = iVar3;
  }
  else {
    iVar3 = iVar4;
    if (iVar4 < 0) {
      iVar3 = -iVar4;
    }
    iVar2 = 0x100000;
    if (iVar3 < 0x100001) {
      iVar2 = iVar3;
    }
    iVar5 = fixedmult(iVar2,iVar5);
    iVar5 = fixedmult(iVar5,0x1555);
    if (iVar4 < 0) {
      iVar5 = -iVar5;
    }
    (wheel->finalAcc).x = iVar5;
    iVar2 = (wheel->velCap).x;
    (wheel->finalAcc).x = iVar5 + gravity_ch.x / 2;
    iVar3 = (wheel->velCap).z;
    iVar4 = iVar2;
    if (iVar2 < 0) {
      iVar4 = -iVar2;
    }
    if (iVar3 < 0) {
      iVar3 = -iVar3;
    }
    if (iVar4 + iVar3 < 0x200000) {
      if (iVar2 < 1) {
        if (iVar5 < 0) {
          iVar5 = -iVar5;
        }
        iVar3 = -iVar5;
        if (-iVar5 < iVar2) {
          iVar3 = iVar2;
        }
      }
      else {
        if (iVar5 < 0) {
          iVar5 = -iVar5;
        }
        iVar3 = iVar5;
        if (iVar2 <= iVar5) {
          iVar3 = iVar2;
        }
      }
      goto Phy_TireF_finalAccX;
    }
  }
  iVar5 = wheel->acc;
  (wheel->finalAcc).y = 0;
  (wheel->finalAcc).z = iVar5;
  Physics_CalcTractionCircleAcc(carObj,wheel);
  if (wheel->steeringAngle != 0) {
    Math_ResolveRotatedVector((wheel->finalAcc).x,(wheel->finalAcc).z,-wheel->steeringAngle,&(wheel->finalAcc).x,
               &(wheel->finalAcc).z);
  }
  iVar5 = wheel->frontTire;
cfLbl2:   /* @0x800abf68  (-f-build goto label) */
  if (iVar5 == 0) {
    carObj->rearSkid = wheel->skid;
  }
  else {
    carObj->frontSkid = wheel->skid;
  }
  return;
}

/* ---- Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii  [PHYSICS.CPP:1982-2040] SLD-VERIFIED ---- */
int Physics_CalculateRSControlDesiredPosition(Car_tObj *carObj,int sliceAhead,int lookAhead)

{
  int driveSide;
  bool bVar1;
  int position;
  int iVar2;
  int iVar3;
  u_int uVar4;
  int laneOffset;
  int iVar5;
  int desLane;
  
  iVar3 = carObj->RSControl * AITune_driveSide;
  bVar1 = false;
  if ((((carObj->roadPosition < 0) && (0 < iVar3)) &&
      (iVar2 = AIWorld_IsDriveableLane((int)(carObj->N).simRoadInfo.slice,carObj->laneIndex + 1), iVar2 == 0)) ||
     (((0 < carObj->roadPosition && (iVar3 < 0)) &&
      (iVar2 = AIWorld_IsDriveableLane((int)(carObj->N).simRoadInfo.slice,carObj->laneIndex + -1), iVar2 == 0))))
  {
    bVar1 = true;
  }
  if (bVar1) {
    iVar3 = -iVar3;
  }
  iVar2 = 7;
  if (iVar3 < 1) {
    iVar3 = 6;
    while( true ) {
      iVar2 = AIWorld_IsDriveableLaneInSliceRange((int)(carObj->N).simRoadInfo.slice,lookAhead,carObj->RSControl,iVar3);
      if ((iVar2 != 0) || (iVar3 < 4)) break;
      iVar3 = iVar3 + -1;
    }
    uVar4 = (u_int)BWorldSm_slices[sliceAhead].avgPavedWidthLf * 0x8000;
    iVar5 = (6 - iVar3) * uVar4 + (uVar4 >> 1);
    if (6 - iVar3 < 1) {
      iVar5 = -iVar5;
    }
    else {
      iVar5 = -(iVar5 + 0x18000);
    }
  }
  else {
    while( true ) {
      iVar3 = AIWorld_IsDriveableLaneInSliceRange((int)(carObj->N).simRoadInfo.slice,lookAhead,carObj->RSControl,iVar2);
      if ((iVar3 != 0) || (9 < iVar2)) break;
      iVar2 = iVar2 + 1;
    }
    uVar4 = (u_int)BWorldSm_slices[sliceAhead].avgPavedWidthRt * 0x8000;
    iVar5 = (iVar2 + -7) * uVar4 + (uVar4 >> 1);
    if (0 < iVar2 + -7) {
      iVar5 = iVar5 + 0x18000;
    }
  }
  return iVar5;
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
  int damage;
  int damageMult;
  int transferMult;
  int Xcomponent;
  int desiredRpm;
  int diffRpm;
  bool bVar1;
  int currentRpm;
  void *pvVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  u_int uVar8;
  Trk_NewSlice *pTVar9;
  int lookAhead;
  int tempGas;
  int iVar10;
  int sliceAhead;
  int iVar11;
  int damp;
  int roadPosition;
  int rotationalAccCap;
  Car_tSpecs *specs;
  Car_tSpecs *pCVar12;
  u_int uVar13;
  Physics_tWheelAccStruct frontWheel;
  Physics_tWheelAccStruct rearWheel;
  coorddef temp;
  coorddef finalAngularAcc_ch;
  coorddef carAccCap_ch;
  matrixtdef transposeMat;
  coorddef carPos;
  coorddef dirVector;
  coorddef offset;
  
  (carObj->linearAcc_ch).x = 0;
  (carObj->linearAcc_ch).y = 0;
  (carObj->linearAcc_ch).z = 0;
  pCVar12 = carObj->specs;
  steeringControl = 1;
  powerControl = 1;
  if ((GameSetup_gData.Weather == 0) ||
     (tempGas = (int)&(carObj->N).simRoadInfo,
     pvVar2 = BWorldSm_TunnelFlagSm((BWorldSm_Pos *)tempGas),
     pvVar2 == (void *)0x1)) {
    slippery = 0;
  }
  else {
    slippery = 1;
  }
  if (((carObj->wheel[0].wheelInAir != 0) && (carObj->wheel[1].wheelInAir != 0)) &&
     (0xccc < (carObj->N).objAltitude)) {
    steeringControl = 0;
  }
  if (((carObj->wheel[2].wheelInAir != 0) && (carObj->wheel[3].wheelInAir != 0)) &&
     (0xccc < (carObj->N).objAltitude)) {
    powerControl = 0;
  }
  iVar3 = fixedmult((carObj->N).linearVel.x,(carObj->N).shadowMat.m[0]);
  iVar4 = fixedmult((carObj->N).linearVel.y,(carObj->N).shadowMat.m[1]);
  iVar5 = fixedmult((carObj->N).linearVel.z,(carObj->N).shadowMat.m[2]);
  iVar10 = (carObj->N).linearVel.x;
  iVar11 = (carObj->N).shadowMat.m[3];
  (carObj->linearVel_ch).x = iVar3 + iVar4 + iVar5;
  iVar3 = fixedmult(iVar10,iVar11);
  iVar4 = fixedmult((carObj->N).linearVel.y,(carObj->N).shadowMat.m[4]);
  iVar5 = fixedmult((carObj->N).linearVel.z,(carObj->N).shadowMat.m[5]);
  iVar10 = (carObj->N).linearVel.x;
  iVar11 = (carObj->N).shadowMat.m[6];
  (carObj->linearVel_ch).y = iVar3 + iVar4 + iVar5;
  iVar3 = fixedmult(iVar10,iVar11);
  iVar4 = fixedmult((carObj->N).linearVel.y,(carObj->N).shadowMat.m[7]);
  iVar5 = fixedmult((carObj->N).linearVel.z,(carObj->N).shadowMat.m[8]);
  iVar10 = (carObj->N).angularVel.x;
  iVar11 = (carObj->N).shadowMat.m[0];
  (carObj->linearVel_ch).z = iVar3 + iVar4 + iVar5;
  iVar3 = fixedmult(iVar10,iVar11);
  iVar4 = fixedmult((carObj->N).angularVel.y,(carObj->N).shadowMat.m[1]);
  iVar5 = fixedmult((carObj->N).angularVel.z,(carObj->N).shadowMat.m[2]);
  iVar10 = (carObj->N).angularVel.x;
  iVar11 = (carObj->N).shadowMat.m[3];
  (carObj->angularVel_ch).x = iVar3 + iVar4 + iVar5;
  iVar3 = fixedmult(iVar10,iVar11);
  iVar4 = fixedmult((carObj->N).angularVel.y,(carObj->N).shadowMat.m[4]);
  iVar5 = fixedmult((carObj->N).angularVel.z,(carObj->N).shadowMat.m[5]);
  iVar10 = (carObj->N).angularVel.x;
  iVar11 = (carObj->N).shadowMat.m[6];
  (carObj->angularVel_ch).y = iVar3 + iVar4 + iVar5;
  iVar3 = fixedmult(iVar10,iVar11);
  iVar4 = fixedmult((carObj->N).angularVel.y,(carObj->N).shadowMat.m[7]);
  iVar5 = fixedmult((carObj->N).angularVel.z,(carObj->N).shadowMat.m[8]);
  iVar10 = (carObj->linearVel_ch).z;
  (carObj->angularVel_ch).z = iVar3 + iVar4 + iVar5;
  if (iVar10 < 0x50001) {
    carObj->slide = 0;
  }
  else {
    iVar3 = fixeddiv((carObj->linearVel_ch).x,iVar10);
    carObj->slide = iVar3;
  }
  iVar3 = ((carObj->linearVel_ch).x * -0x20) / 2;
  iVar4 = ((carObj->linearVel_ch).y * -0x20) / 2;
  iVar5 = ((carObj->linearVel_ch).z * -0x20) / 2;
  iVar10 = fixedmult((carObj->N).angularVel.y << 5,pCVar12->alphaToAccRotInertia);
  iVar11 = fixedmult(0,(carObj->N).shadowMat.m[0]);
  iVar6 = fixedmult(-0xa0000,(carObj->N).shadowMat.m[1]);
  iVar7 = fixedmult(0,(carObj->N).shadowMat.m[2]);
  gravity_ch.x = iVar11 + iVar6 + iVar7;
  iVar11 = fixedmult(0,(carObj->N).shadowMat.m[3]);
  iVar6 = fixedmult(-0xa0000,(carObj->N).shadowMat.m[4]);
  iVar7 = fixedmult(0,(carObj->N).shadowMat.m[5]);
  gravity_ch.y = iVar11 + iVar6 + iVar7;
  iVar11 = fixedmult(0,(carObj->N).shadowMat.m[6]);
  iVar6 = fixedmult(-0xa0000,(carObj->N).shadowMat.m[7]);
  iVar7 = fixedmult(0,(carObj->N).shadowMat.m[8]);
  gravity_ch.z = iVar11 + iVar6 + iVar7;
  frontWheel.velCap.x = iVar3 + -iVar10 / 2;
  rearWheel.velCap.x = iVar3 - -iVar10 / 2;
  frontWheel.velCap.y = iVar4;
  frontWheel.velCap.z = iVar5;
  rearWheel.velCap.y = iVar4;
  rearWheel.velCap.z = iVar5;
  Physics_RampCarControlValues(carObj);
  iVar3 = gravity_ch.x;
  if (gravity_ch.x < 0) {
    iVar3 = gravity_ch.x + 0xff;
  }
  iVar3 = (iVar3 >> 8) * 0x300;
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xffff;
  }
  iVar3 = (carObj->control).steering + (iVar3 >> 0x10);
  if (iVar3 < 0x80) {
    if (iVar3 < -0x7f) {
      iVar3 = -0x7f;
    }
  }
  else {
    iVar3 = 0x7f;
  }
  iVar3 = iVar3 * pCVar12->maxSteeringAcc;
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0x7f;
  }
  iVar3 = iVar3 >> 7;
  iVar4 = (carObj->N).damage[0] + (carObj->N).damage[1] + (carObj->N).damage[2] +
          (carObj->N).damage[9];
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0x1ff;
  }
  iVar5 = -(iVar4 >> 9) + 0x10000;
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  if (iVar5 < 0) {
    iVar5 = -(iVar4 >> 9) + 0x100ff;
  }
  frontWheel.steeringAngle = (iVar3 >> 8) * (iVar5 >> 8);
  iVar3 = (carObj->linearVel_ch).z;
  if (0x3c0000 < iVar3) {
    iVar3 = fixedmult(iVar3,0x444);
    frontWheel.steeringAngle = fixeddiv(frontWheel.steeringAngle,iVar3);
  }
  iVar3 = (carObj->linearVel_ch).z;
  if (iVar3 < 0x1ab334) {
    if (0xd6666 < iVar3) {
      iVar3 = carObj->slide;
      bVar1 = iVar3 < -0x2666;
      if (0x2666 < iVar3) {
        bVar1 = iVar3 < -0x2666;
        goto cfLbl3;
      }
      goto PhyReal_steerAngleCheck;
    }
  }
  else {
    iVar3 = carObj->slide;
    bVar1 = iVar3 < -0xccc;
    if (iVar3 < 0xccd) {
PhyReal_steerAngleCheck:
      if ((!bVar1) || (-1 < frontWheel.steeringAngle)) goto PhyReal_calcAccel;
    }
    else {
      bVar1 = iVar3 < -0xccc;
cfLbl3:   /* @0x800ac6bc  (-f-build goto label) */
      if (frontWheel.steeringAngle < 1) goto PhyReal_steerAngleCheck;
    }
    iVar3 = carObj->slide;
    if (iVar3 < 0) {
      iVar3 = -iVar3;
    }
    iVar4 = 0x10000;
    if (iVar3 << 1 < 0x10001) {
      iVar4 = iVar3 << 1;
    }
    frontWheel.steeringAngle = fixedmult(frontWheel.steeringAngle,iVar4);
  }
PhyReal_calcAccel:
  rearWheel.steeringAngle = 0;
  frontWheel.frontTire = 1;
  rearWheel.frontTire = 0;
  iVar5 = Physics_CalculateCarAcceleration(carObj);
  iVar3 = gBrakeRatio;
  iVar4 = iVar5;
  if (iVar5 < 0) {
    iVar4 = iVar5 + 0xff;
  }
  iVar10 = pCVar12->frontDriveRatio;
  if (iVar10 < 0) {
    iVar10 = iVar10 + 0xff;
  }
  frontWheel.acc = (iVar4 >> 8) * (iVar10 >> 8);
  rearWheel.acc = iVar5 - frontWheel.acc;
  if ((steeringControl == 0) && (powerControl == 0)) {
    carObj->frontSkid = 0;
    carObj->rearSkid = 0;
    return;
  }
  bVar1 = gBrakeRatio < 0;
  carObj->crash = 0;
  if (bVar1) {
    iVar3 = iVar3 + 0xff;
  }
  iVar4 = pCVar12->maxBrakeAcc;
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar3 = (iVar3 >> 8) * (iVar4 >> 8);
  iVar4 = (carObj->linearVel_ch).z;
  if (iVar4 < 0) {
    iVar4 = -iVar4;
  }
  iVar5 = iVar4 << 5;
  if (iVar3 <= iVar4 << 5) {
    iVar5 = iVar3;
  }
  iVar3 = (carObj->N).damage[9];
  if (iVar3 != 0) {
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0x7f;
    }
    iVar4 = -(iVar3 >> 7) + 0x10000;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    if (iVar4 < 0) {
      iVar4 = -(iVar3 >> 7) + 0x100ff;
    }
    iVar5 = (iVar5 >> 8) * (iVar4 >> 8);
  }
  if (0 < (carObj->linearVel_ch).z) {
    iVar5 = -iVar5;
  }
  iVar3 = fixedmult(iVar5,pCVar12->frontBrakeRatio);
  frontWheel.acc = frontWheel.acc + iVar3;
  rearWheel.acc = rearWheel.acc + (iVar5 - iVar3);
  iVar3 = fixedmult(-gravity_ch.y,pCVar12->lateralGripMult);
  Physics_CalculateRoadGripModifiers(carObj);
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar4 = roadMult;
  if (roadMult < 0) {
    iVar4 = roadMult + 0xff;
  }
  iVar3 = (iVar3 >> 8) * (iVar4 >> 8);
  if (iVar3 < 0) {
    return;
  }
  if (slippery == 0) {
    iVar4 = pCVar12->frontGripBias;
  }
  else {
    iVar4 = pCVar12->frontGripBias + 0x28f;
  }
  iVar4 = fixedmult(iVar3,iVar4);
  iVar5 = (carObj->N).damage[4] + (carObj->N).damage[5] + (carObj->N).damage[6] +
          (carObj->N).damage[9];
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0x1ff;
  }
  iVar11 = (iVar5 >> 9) + 0xc000;
  iVar10 = fixedmult(carObj->gTransferFront,iVar11);
  carObj->gTransferFront = iVar10;
  if (iVar10 < 0) {
    if (iVar11 < 0) {
      iVar11 = (iVar5 >> 9) + 0xc0ff;
    }
    carObj->gTransferFront = (iVar10 + 0xff >> 8) * (iVar11 >> 8);
  }
  else if (0 < iVar10) {
    iVar10 = iVar10 * 3;
    if (iVar10 < 0) {
      iVar10 = iVar10 + 3;
    }
    carObj->gTransferFront = iVar10 >> 2;
  }
  iVar5 = steeringControl;
  iVar11 = iVar4 - carObj->gTransferFront;
  iVar10 = frontMult;
  if (frontMult < 0) {
    iVar10 = frontMult + 0xff;
  }
  if (iVar11 < 0) {
    iVar11 = iVar11 + 0xff;
  }
  frontWheel.roadGrip = (iVar10 >> 8) * (iVar11 >> 8);
  iVar4 = (iVar3 - iVar4) + carObj->gTransferFront;
  iVar3 = rearMult;
  if (rearMult < 0) {
    iVar3 = rearMult + 0xff;
  }
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  rearWheel.roadGrip = (iVar3 >> 8) * (iVar4 >> 8);
  carObj->wheelLock = 0;
  frontWheel.finalAcc.x = 0;
  frontWheel.finalAcc.z = 0;
  rearWheel.finalAcc.x = 0;
  rearWheel.finalAcc.z = 0;
  if (iVar5 != 0) {
    Physics_CalculateTireForces(carObj,&frontWheel);
  }
  if (powerControl != 0) {
    Physics_CalculateTireForces(carObj,&rearWheel);
  }
  (carObj->linearAcc_ch).z = frontWheel.finalAcc.z + rearWheel.finalAcc.z;
  (carObj->linearAcc_ch).x = frontWheel.finalAcc.x + rearWheel.finalAcc.x;
  iVar3 = fixedmult((carObj->linearAcc_ch).z,pCVar12->lateralGripMultInv)
  ;
  (carObj->linearAcc_ch).z = iVar3;
  if (((GameSetup_gData.sgge == 0x80) && (0 < iVar3)) && ((carObj->control).horn != '\0')) {
    (carObj->linearAcc_ch).z = iVar3 << 2;
  }
  if (slippery == 0) {
    if ((carObj->carInfo->TireType == 2) && ((u_char)(carObj->control).gear < 4)) {
      iVar3 = (carObj->linearAcc_ch).z;
      iVar4 = 0x12666;
    }
    else {
      iVar3 = (carObj->linearAcc_ch).z;
      iVar4 = 0x11999;
    }
    iVar3 = fixedmult(iVar3,iVar4);
    (carObj->linearAcc_ch).z = iVar3;
  }
  (carObj->linearAcc_ch).y = 0;
  iVar3 = fixedmult(gravity_ch.z,0x1999);
  iVar4 = (carObj->linearAcc_ch).x;
  if (iVar4 < 0) {
    iVar4 = iVar4 + 7;
  }
  iVar4 = fixedmult(iVar4 >> 3,pCVar12->gTransferFactor);
  iVar5 = (carObj->linearAcc_ch).z;
  carObj->gTransferRight = -iVar4;
  iVar4 = fixedmult(iVar5,pCVar12->gTransferFactor);
  carObj->gTransferFront = iVar4 - iVar3;
  iVar3 = fixedmult(frontWheel.finalAcc.x - rearWheel.finalAcc.x,pCVar12->accToAlphaRotInertia);
  iVar4 = fixedmult(frontWheel.finalAcc.z + rearWheel.finalAcc.z,leftMult - rightMult);
  iVar4 = fixedmult(iVar4,pCVar12->accToAlphaRotInertia);
  finalAngularAcc_ch.y = iVar3 + iVar4 * 2;
  iVar3 = (carObj->N).angularVel.y;
  if (((0 < iVar3) && (0 < finalAngularAcc_ch.y)) || ((iVar3 < 0 && (finalAngularAcc_ch.y < 0)))) {
    if (((carObj->control).handBrake == '\0') || ((GameSetup_gData.sgge & 8U) != 0)) {
      iVar3 = (carObj->control).desiredSteering;
      if ((((iVar3 < 0) && (0x3333 < (carObj->N).angularVel.y)) ||
          ((0 < iVar3 && ((carObj->N).angularVel.y < -0x3333)))) && (carObj->wheelSpin == 1)) {
        finalAngularAcc_ch.y = -(carObj->N).angularVel.y;
      }
      else {
        finalAngularAcc_ch.y =
             fixedmult(finalAngularAcc_ch.y,carObj->specs->spinVelCap);
      }
    }
    else {
      finalAngularAcc_ch.y = finalAngularAcc_ch.y / 2;
    }
  }
  transpose(&(carObj->N).shadowMat,&transposeMat);
  Cars_DoGravityEffectsOnAcc(carObj,0);
  iVar3 = fixedmult((carObj->linearAcc_ch).x,transposeMat.m[0]);
  iVar4 = fixedmult((carObj->linearAcc_ch).y,transposeMat.m[1]);
  iVar5 = fixedmult((carObj->linearAcc_ch).z,transposeMat.m[2]);
  (carObj->linearAcc).x = iVar3 + iVar4 + iVar5;
  iVar3 = fixedmult((carObj->linearAcc_ch).x,transposeMat.m[3]);
  iVar4 = fixedmult((carObj->linearAcc_ch).y,transposeMat.m[4]);
  iVar5 = fixedmult((carObj->linearAcc_ch).z,transposeMat.m[5]);
  iVar10 = (carObj->linearAcc_ch).x;
  (carObj->linearAcc).y = iVar3 + iVar4 + iVar5;
  iVar3 = fixedmult(iVar10,transposeMat.m[6]);
  iVar4 = fixedmult((carObj->linearAcc_ch).y,transposeMat.m[7]);
  iVar5 = fixedmult((carObj->linearAcc_ch).z,transposeMat.m[8]);
  (carObj->linearAcc).z = iVar3 + iVar4 + iVar5;
  iVar3 = fixedmult(0,transposeMat.m[0]);
  iVar4 = fixedmult(finalAngularAcc_ch.y,transposeMat.m[1]);
  iVar5 = fixedmult(0,transposeMat.m[2]);
  (carObj->angularAcc).x = iVar3 + iVar4 + iVar5;
  iVar3 = fixedmult(0,transposeMat.m[3]);
  iVar4 = fixedmult(finalAngularAcc_ch.y,transposeMat.m[4]);
  iVar5 = fixedmult(0,transposeMat.m[5]);
  (carObj->angularAcc).y = iVar3 + iVar4 + iVar5;
  iVar3 = fixedmult(0,transposeMat.m[6]);
  iVar4 = fixedmult(finalAngularAcc_ch.y,transposeMat.m[7]);
  iVar5 = fixedmult(0,transposeMat.m[8]);
  iVar10 = (carObj->linearAcc).x;
  (carObj->angularAcc).z = iVar3 + iVar4 + iVar5;
  if (iVar10 < 0) {
    iVar10 = iVar10 + 0x1f;
  }
  iVar3 = (carObj->linearAcc).y;
  (carObj->N).linearVel.x = (carObj->N).linearVel.x + (iVar10 >> 5);
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0x1f;
  }
  iVar4 = (carObj->linearAcc).z;
  (carObj->N).linearVel.y = (carObj->N).linearVel.y + (iVar3 >> 5);
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0x1f;
  }
  iVar3 = (carObj->angularAcc).x;
  (carObj->N).linearVel.z = (carObj->N).linearVel.z + (iVar4 >> 5);
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0x1f;
  }
  iVar4 = (carObj->angularAcc).y;
  (carObj->N).angularVel.x = (carObj->N).angularVel.x + (iVar3 >> 5);
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0x3f;
  }
  iVar3 = (carObj->angularAcc).z;
  (carObj->N).angularVel.y = (carObj->N).angularVel.y + (iVar4 >> 6);
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0x1f;
  }
  iVar4 = carObj->RSControl;
  (carObj->N).angularVel.z = (carObj->N).angularVel.z + (iVar3 >> 5);
  if (iVar4 != 0) {
    if (carObj->desiredSpeed < 0x471c7) {
      if ((u_char)(carObj->control).gear < 2) {
        iVar3 = 8;
      }
      else {
        iVar3 = (u_int)(u_char)(carObj->control).gear << 2;
      }
      iVar3 = *(int *)((int)pCVar12->velToRpmRatio + iVar3);
      iVar4 = 0x188000;
    }
    else {
      if ((u_char)(carObj->control).gear < 2) {
        iVar3 = 8;
      }
      else {
        iVar3 = (u_int)(u_char)(carObj->control).gear << 2;
      }
      iVar4 = carObj->desiredSpeed;
      iVar3 = *(int *)((int)pCVar12->velToRpmRatio + iVar3);
    }
    iVar3 = fixedmult(iVar4,iVar3);
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xffff;
    }
    iVar3 = iVar3 >> 0x10;
    if ((u_char)(carObj->control).gear < 2) {
      iVar4 = 8;
    }
    else {
      iVar4 = (u_int)(u_char)(carObj->control).gear << 2;
    }
    iVar4 = fixedmult((carObj->linearVel_ch).z,*(int *)((int)pCVar12->velToRpmRatio + iVar4));
    if (iVar4 < 0) {
      iVar4 = iVar4 + 0xffff;
    }
    iVar5 = pCVar12->redline;
    iVar10 = (iVar3 << 8) / iVar5;
    iVar4 = iVar3 - (iVar4 >> 0x10);
    if (iVar4 < 0xc9) {
      if (iVar4 < 200) {
        iVar10 = iVar10 + (iVar4 * 0x80) / iVar3;
        if (iVar10 < 0) {
          carObj->RSGasLevel = '\0';
        }
        else {
          carObj->RSGasLevel = (char)iVar10;
        }
        if (iVar4 < 0) {
          iVar3 = iVar4 * 0x200;
          iVar5 = pCVar12->redline;
          if (iVar3 < 0) {
            iVar3 = iVar4 * -0x200;
          }
          uVar13 = iVar3 / iVar5;
          uVar8 = uVar13 & 0xff;
          if (0xff < (int)uVar13) {
            uVar13 = 0xff;
            uVar8 = 0xff;
          }
          carObj->RSBrakeLevel = (char)uVar13;
          if (0x80 < uVar8) {
            carObj->RSGasLevel = '\0';
          }
        }
      }
    }
    else {
      iVar10 = iVar10 + (iVar4 * 0x80) / iVar3;
      if (0xe0 < iVar10) {
        iVar10 = 0xe0;
      }
      carObj->RSGasLevel = (char)iVar10;
    }
    iVar3 = carObj->currentSpeed;
    if (iVar3 < 0) {
      iVar3 = -iVar3;
    }
    if (iVar3 / 0x60000 < 3) {
      iVar3 = carObj->RSControl * 3;
    }
    else {
      iVar3 = carObj->RSControl * (iVar3 / 0x60000);
    }
    if (iVar3 < 0) {
      iVar4 = (carObj->N).simRoadInfo.slice + iVar3;
      if (iVar4 < 0) {
        iVar4 = iVar4 + gNumSlices;
      }
    }
    else {
      iVar4 = (carObj->N).simRoadInfo.slice + iVar3;
      if (gNumSlices <= iVar4) {
        iVar4 = iVar4 - gNumSlices;
      }
    }
    iVar5 = iVar3 * 3;
    if (iVar5 < 0) {
      iVar5 = iVar3 * -3;
    }
    iVar11 = (carObj->N).position.x;
    iVar6 = (carObj->N).position.y;
    iVar7 = (carObj->N).position.z;
    pTVar9 = BWorldSm_slices + iVar4;
    dirVector.x = pTVar9->center[0];
    dirVector.y = pTVar9->center[1];
    dirVector.z = pTVar9->center[2];
    iVar3 = Physics_CalculateRSControlDesiredPosition(carObj,iVar4,iVar5);
    iVar5 = fixedmult((int)BWorldSm_slices[iVar4].right[0] << 9,iVar3);
    iVar10 = fixedmult((int)BWorldSm_slices[iVar4].right[1] << 9,iVar3);
    iVar3 = fixedmult((int)BWorldSm_slices[iVar4].right[2] << 9,iVar3);
    dirVector.x = (dirVector.x + iVar5) - iVar11;
    dirVector.y = (dirVector.y + iVar10) - iVar6;
    dirVector.z = (dirVector.z + iVar3) - iVar7;
    Math_NormalizeVector(&dirVector);
    iVar3 = fixedmult(dirVector.x,(carObj->N).orientMat.m[0]);
    iVar4 = fixedmult(dirVector.y,(carObj->N).orientMat.m[1]);
    iVar5 = fixedmult(dirVector.z,(carObj->N).orientMat.m[2]);
    iVar5 = iVar3 + iVar4 + iVar5;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    iVar5 = iVar5 >> 8;
    carObj->RSSteering = iVar5;
    if (iVar5 < 0x80) {
      iVar3 = -0x7f;
      if (-0x80 < iVar5) goto PhyReal_postRSSteering;
    }
    else {
      iVar3 = 0x7f;
    }
    carObj->RSSteering = iVar3;
  }
PhyReal_postRSSteering:
  if ((GameSetup_gData.sgge & 8U) == 0) {
    if ((carObj->control).gasLevel != '\0') {
      iVar3 = carObj->slide;
      if (iVar3 < 0) {
        iVar3 = -iVar3;
      }
      if (iVar3 < 0x199a) goto PhyReal_iceBraking;
    }
    iVar3 = fixedmult(carObj->specs->dragFactor,(carObj->N).linearVel.x);
    iVar4 = (carObj->N).linearVel.y;
    pCVar12 = carObj->specs;
    (carObj->N).linearVel.x = iVar3;
    iVar3 = fixedmult(pCVar12->dragFactor,iVar4);
    iVar4 = (carObj->N).linearVel.z;
    pCVar12 = carObj->specs;
    (carObj->N).linearVel.y = iVar3;
    iVar3 = fixedmult(pCVar12->dragFactor,iVar4);
    (carObj->N).linearVel.z = iVar3;
  }
PhyReal_iceBraking:
  if (((carObj->N).driveSurfaceType == 3) && (0x2ca3d7 < (carObj->N).speedXZ)) {
    iVar3 = fixedmult(0xfeb8,(carObj->N).linearVel.x);
    iVar4 = (carObj->N).linearVel.y;
    (carObj->N).linearVel.x = iVar3;
    iVar3 = fixedmult(0xfeb8,iVar4);
    iVar5 = (carObj->N).linearVel.z;
    iVar4 = 0xfeb8;
  }
  else {
    if ((carObj->control).gear == '\x01') {
      iVar3 = gravity_ch.z;
      if (gravity_ch.z < 0) {
        iVar3 = -gravity_ch.z;
      }
      if (iVar3 < 0x8000) {
        iVar3 = (carObj->linearVel_ch).z;
        if (iVar3 < 0) {
          iVar3 = -iVar3;
        }
        iVar4 = 0xfd70;
        if (0x13ffff < iVar3) {
          iVar3 = (carObj->control).steering;
          if (iVar3 < 0) {
            iVar3 = -iVar3;
          }
          iVar4 = 0xff7c;
          if (0x20 < iVar3) {
            iVar4 = 0xfd70;
          }
        }
        iVar3 = fixedmult(iVar4,(carObj->N).linearVel.x);
        iVar5 = (carObj->N).linearVel.y;
        (carObj->N).linearVel.x = iVar3;
        iVar3 = fixedmult(iVar4,iVar5);
        iVar5 = (carObj->N).linearVel.z;
        (carObj->N).linearVel.y = iVar3;
        iVar3 = fixedmult(iVar4,iVar5);
        iVar5 = (carObj->N).angularVel.x;
        (carObj->N).linearVel.z = iVar3;
        iVar3 = fixedmult(iVar4,iVar5);
        iVar5 = (carObj->N).angularVel.y;
        (carObj->N).angularVel.x = iVar3;
        iVar3 = fixedmult(iVar4,iVar5);
        iVar5 = (carObj->N).angularVel.z;
        (carObj->N).angularVel.y = iVar3;
        iVar3 = fixedmult(iVar4,iVar5);
        (carObj->N).angularVel.z = iVar3;
        return;
      }
    }
    if ((carObj->control).handBrake == '\0') {
      return;
    }
    if (0xffff < (carObj->N).speedXZ) {
      return;
    }
    iVar3 = fixedmult(0x8000,(carObj->N).linearVel.x);
    iVar4 = (carObj->N).linearVel.y;
    (carObj->N).linearVel.x = iVar3;
    iVar3 = fixedmult(0x8000,iVar4);
    iVar5 = (carObj->N).linearVel.z;
    iVar4 = 0x8000;
  }
  (carObj->N).linearVel.y = iVar3;
  iVar3 = fixedmult(iVar4,iVar5);
  (carObj->N).linearVel.z = iVar3;
  return;
}

/* ---- Physics_SimCar__FP8Car_tObj  [PHYSICS.CPP:2507-2532] SLD-VERIFIED ---- */
void Physics_SimCar(Car_tObj *carObj)

{
  int currentRpm;
  int tempSteer;
  int diffRpm;
  int roadGrip;
  int optVar1;
  int frontWheels;
  int rearWheels;
  int leftWheels;
  int rightWheels;
  int damp;
  int roadPosition;
  int rotationalAccCap;
  int diffFlywheelRpm;
  int driveAcc;
  int ShiftPoint;
  int drag;
  int damage;
  coorddef finalAngularAcc_ch;
  coorddef carAccCap_ch;
  coorddef carPos;
  coorddef dirVector;
  coorddef offset;
  
  if ((carObj->N).orientationToGround.y < 0x1999) {
    carObj->wheelSpin = 0;
    carObj->slide = 0;
    carObj->frontSkid = 0;
    carObj->rearSkid = 0;
    if (carObj->flywheelRpm < 0x1f5) {
      carObj->flywheelRpm = 0;
    }
    else {
      carObj->flywheelRpm = carObj->flywheelRpm + -500;
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
