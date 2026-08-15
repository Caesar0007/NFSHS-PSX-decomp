/* game/common/physics.cpp -- RECONSTRUCTED (NFS4 PSX car physics engine; C++ TU)
 *   22 fns: SimCar/Real driver + tire forces, traction circle, accel, autoshift, barrier, RS control.
 *   GTE-free (fixed-point + eaclib math). Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "physics_externs.h"

/* EA-era MIN/MAX clamp macros.  The oracle proves retail used the TERNARY form
   (a COND_EXPR whose result lands in a fresh temp reg, then one store) for the
   rpm clamps, NOT the `if (a < b) a = b;` override form -- see the
   CalculateCarAcceleration receipt.  Locally named so nothing in the shared
   headers can collide (an UNDEFINED `MAX(...)` makes cc1 emit an implicit
   variadic `jal MAX` = a phantom link symbol, catalog 08B). */
#define PHY_MIN(a,b) ((a) < (b) ? (a) : (b))
#define PHY_MAX(a,b) ((a) > (b) ? (a) : (b))

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
/* ==== 2026-08-10 MOBILE-TWIN CROSS-CHECK (NFSU2-mobile sub_5046C6, x86; extraction at
 * scratchpad/mobile_DoBarrierCheck.c; VA map in memory reference-nfs4-mobile-nfsu2) ====
 * STRUCTURE CONFIRMED 1:1: every block of this body corresponds to the mobile twin
 * (right<<9 head, vel_b dot, two width dots w/ duplicated fixedmult abs arms, the two
 * threshold ifs, widthVector arms, the objAltitude/orientation/flightTime gate,
 * TestWithPlane arm, AttenuateVelocity+CorrectPostCollisionYaw else-arm). No missing
 * statements, no wrong-arg bugs.
 * ⚠️ MOBILE PORT-FIX CAVEAT (do NOT adopt): the mobile ZEROES `normal` before the
 * else-arm CorrectPostCollisionYaw call; RETAIL PSX DOES NOT (oracle .L800A99EC..
 * reloads sp+0x38/3C/40 with no zero stores -- the uninitialized-normal pass-through
 * is retail's real behavior; Ideaworks fixed it in 2005). Mobile also swapped the
 * otherObj/sfxType store order -- ours already matches retail (otherObj first).
 * PC TWIN: NONE -- pcmap map_a10 rules it NOT-FOUND (PC folded barrier collision
 * into the newton/world TU, different decomposition); mobile is the only twin.
 * RETAIL ALLOCATION RECEIPT: IDA + SLD give the same top-level and nested-local
 * register map. The SLD line trace proves shifted r1/r2/r3 assignments followed by
 * right.x/y/z stores, and the SYM block records prove sibling r-local and x-local
 * scopes. Splitting the first dot product into `x1 = right.x / 0x100; x1 *= ...`
 * changes local allocation without adding code and improves 214 -> 198. Three
 * expression references retain the retail slice-pointer handout; the scheduling
 * boundary then reached 196. The current raw1 source identity keeps the signed-byte
 * value live across its shift, preventing local-alloc's no-conflict combine and
 * recovering retail's initial `lb v0`; this lowers 196 -> 194 (352/358) while
 * preserving FixEngineRpm PASS. FALSIFIED in that older basin: orientation-first
 * width products 237 (best paired basin 226), volatile/right memory views 251/232,
 * in-place raw2/raw3 shifts 202, and r1 priced refs 0-7 neutral / eighth 238.
 * CONTINUATION (2026-08-14): the SLD block ends immediately after the second
 * width multiply, so keeping the wall-threshold expressions outside that local
 * r/x scope improves the fresh 121 baseline to 85. Re-probing the previously
 * basin-relative orientation-first products then gives 24 at exact 358/358.
 * The direct first x1 product, removal of centerKeep's early identity, and a
 * plain keep-alive after x3 produce the complete retail handout and reach
 * source-only FAIL 2 (358/358). The sole residual is `mflo t2` four independent
 * instructions early. A scratch-only PER_FN_TEXT_MOVES probe moving that line
 * after `move $5,$3` independently verifies PASS 358/358; receipt and object:
 * scratchpad/root_probe_physics_barrier_splice.py and
 * scratchpad/root_barrier_fail2_spliced.o. */
int Physics_DoBarrierCheck(Car_tObj *carObj)

{
  int diff;
  int carCollisionWidth;
  int x_relRoad;
  int wallType;
  int collide;
  coorddef vel_b;
  coorddef right;
  coorddef normal;
  int slice;

  diff = 0;
  slice = (carObj->N).simRoadInfo.slice;
  {
    int x1raw;
    int centerX;
    int centerY;
    int centerZ;
    int positionX;
    int positionY;
    int positionZ;
    int linearZ;
    int velocityX;
    int velocityY;
    int velocityZ;
    int centerKeep;

    {
    int r1;
    int r2;
    int r3;
    int raw1;
    int raw2;
    int raw3;
    raw1 = (int)(signed char)BWorldSm_slices[slice].right[0];
    raw3 = (int)(signed char)BWorldSm_slices[slice].right[2];
    __asm__("" : : "r"(raw3), "r"(raw3));
    r1 = raw1 << 9;
    __asm__("" : : "r"(raw1), "r"(raw1));
    raw2 = (int)(signed char)BWorldSm_slices[slice].right[1];
    collide = diff;
    right.x = r1;
    __asm__("" : "+m"(right.x));
    x1raw = right.x;
    __asm__("" : : "r"(x1raw));
    r3 = raw3 << 9;
    right.z = r3;
    r2 = raw2 << 9;
    right.y = r2;
    __asm__("" : "+m"(right.y), "+m"(right.z));
    }

    centerX = BWorldSm_slices[slice].center[0];
    __asm__("" : : "r"(centerX), "r"(centerX));
    positionX = (carObj->N).position.x;
    velocityX = positionX + ((carObj->N).linearVel.x >> 5) - centerX;
    __asm__("" : : "r"(velocityX), "r"(velocityX));
    vel_b.x = velocityX;
    __asm__("" : : "r"(positionX));
    centerY = BWorldSm_slices[slice].center[1];
    __asm__("" : : "r"(centerY), "r"(centerY));
    positionY = (carObj->N).position.y;
    velocityY = positionY + ((carObj->N).linearVel.y >> 5) - centerY;
    __asm__("" : : "r"(velocityY));
    vel_b.y = velocityY;
    __asm__("" : : "r"(positionY));
    centerZ = BWorldSm_slices[slice].center[2];
    __asm__("" : : "r"(centerZ), "r"(centerZ));
    linearZ = (carObj->N).linearVel.z;
    positionZ = (carObj->N).position.z;
    __asm__("" : : "r"(BWorldSm_slices + slice),
                 "r"(BWorldSm_slices + slice),
                 "r"(BWorldSm_slices + slice),
                 "r"(BWorldSm_slices + slice),
                 "r"(BWorldSm_slices + slice),
                 "r"(BWorldSm_slices + slice),
                 "r"(BWorldSm_slices + slice));
    velocityZ = positionZ + (linearZ >> 5) - centerZ;
    centerKeep = centerZ;
    __asm__("" : : "r"(velocityZ), "r"(velocityZ), "r"(velocityZ),
                 "r"(velocityZ), "r"(velocityZ), "r"(velocityZ),
                 "r"(velocityZ), "r"(velocityZ), "r"(velocityZ),
                 "r"(velocityZ));
    __asm__("" : : "r"(velocityZ), "r"(velocityZ), "r"(velocityZ));
    __asm__("" : : "r"(positionZ));
    vel_b.z = velocityZ;
    {
    int x1;
    int x2;
    int x3;
    int rightY;

    x1 = x1raw / 0x100 * (vel_b.x / 0x100);
    rightY = right.y;
    x2 = rightY / 0x100 * (vel_b.y / 0x100);
    x3 = right.z / 0x100 * (vel_b.z / 0x100);
    __asm__("" : : "r"(centerKeep));
    x_relRoad = x1 + x2 + x3;
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
    x1 = r1 / 0x100 * (right.x / 0x100);
    x2 = r2 / 0x100 * (right.y / 0x100);
    x3 = r3 / 0x100 * (right.z / 0x100);
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
    }
    if (x_relRoad < carCollisionWidth - BWorldSm_slices[slice].leftDrive * 0x100 -
                        carObj->extraWallCollisionAllowance) {
      collide = -1;
      diff = carCollisionWidth - BWorldSm_slices[slice].leftDrive * 0x100 -
             x_relRoad;
      currentWallType = 1;
    }
    if (BWorldSm_slices[slice].rightDrive * 0x100 - carCollisionWidth +
            carObj->extraWallCollisionAllowance < x_relRoad) {
      collide = 1;
      diff = x_relRoad -
             (BWorldSm_slices[slice].rightDrive * 0x100 - carCollisionWidth);
      currentWallType = 1;
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
void Physics_AutoShift(Car_tObj *carObj)

{
  int wheelRpm;
  int previousRpm;
  int previousGear;
  int nextGear;
  int SkipLastGear;
  int ShiftPoint;
  int sliding;
  int lastGearOffset;

  SkipLastGear = 0;
  ShiftPoint = carObj->specs->redline - carObj->specs->redline / 6;
  if (1 < (u_char)(carObj->control).gear) {
    if (carObj->RSControl != 0) {
      ShiftPoint = carObj->specs->redline - carObj->specs->redline / 2;
    }
    sliding = (0 <= carObj->slide) ? carObj->slide : -carObj->slide;
    previousRpm = fixedmult(
        carObj->specs->velToRpmRatioInv[carObj->specs->numGears - 2],
        carObj->specs->redline << 0x10);
    if (carObj->specs->maxSpeed < previousRpm) {
      SkipLastGear = 1;
    }
    lastGearOffset = SkipLastGear + 1;
    if ((u_char)(carObj->control).gear >=
        carObj->specs->numGears - lastGearOffset) {
      nextGear = (u_char)(carObj->control).gear;
    }
    else {
      nextGear = (u_char)(carObj->control).gear + 1;
    }
    if ((u_char)(carObj->control).gear <= 2) {
      previousGear = (u_char)(carObj->control).gear;
    }
    else {
      previousGear = (u_char)(carObj->control).gear - 1;
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
          /* MATCH (W60-A9, 20 -> PASS 175/175): the w45 FOLD-REWRITE ESCAPE.  Retail
           * computes `SkipLastGear + 1` as its OWN insn in the beqz delay slot
           * (`addiu $v1,$s6,1`) and subtracts it; every natural spelling of
           * `numGears - SkipLastGear - 1` (incl. the parenthesised
           * `numGears - (SkipLastGear + 1)` and `- (1 + SkipLastGear)`) is
           * reassociated by fold() to `(numGears - SkipLastGear) - 1` = ours'
           * `subu;addiu -1` pair (20 diffs).  Writing the sum NEGATED FIRST takes
           * split_tree's varsign=-1 branch, whose rewrite fold never re-folds, so the
           * `addiu +1` survives.  Do NOT "simplify" this back -- and do NOT reuse the
           * existing `lastGearOffset` local here either (cse then shares the earlier
           * computation instead of rematerialising: 47 diffs).  `move_term`
           * (`gear + SkipLastGear + 1 < numGears`) = 23. */
          if ((u_char)(carObj->control).gear <
              -(SkipLastGear + 1) + carObj->specs->numGears) {
            if (nextGear != (u_char)(carObj->control).gear) {
              (carObj->control).downShifting = '\0';
              (carObj->control).lastGear = (carObj->control).gear;
              (carObj->control).gear = (char)nextGear;
              (carObj->control).gearShiftTimer = (char)carObj->specs->gearShiftDelay;
            }
            return;
          }
        }
        if ((previousRpm < ShiftPoint) &&
            (previousGear != (u_char)(carObj->control).gear)) {
          (carObj->control).downShifting = '\x01';
          (carObj->control).lastGear = (carObj->control).gear;
          (carObj->control).gear = (char)previousGear;
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
    int inc;

    if (carObj->carInfo->RampGas != 0) {
      inc = 0x24;
    }
    else {
      inc = 0x30;
    }
    __asm__("" : "=r"(inc) : "0"(inc));
    diff = (carObj->control).desiredGasLevel - (carObj->control).gasLevel;
    if (diff >= 0) {
      inc &= 0xff;
      (carObj->control).gasLevel =
          diff < inc ? (carObj->control).gasLevel + diff
                     : (carObj->control).gasLevel + inc;
    }
    else {
      inc &= 0xff;
      diff = -diff;
      (carObj->control).gasLevel =
          diff < inc ? (carObj->control).gasLevel - diff
                     : (carObj->control).gasLevel - inc;
    }
    /* MATCH: PASS 502/502.  Retail keeps `inc` in a0, masks it independently
       in both sign arms, and computes the two complete gas-value candidates
       before their shared store.  The zero-instruction identity barrier keeps
       gcc from range-folding the 0x24/0x30 choice; the explicit per-arm masks
       then reproduce the two destructive `andi a0,a0,255` operations. */
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
  /* MATCH: the SYM block has no locals, so collision.collided is read inline.
     A byte-identical qtytrace receipt identified transformedZ as global pseudo
     p88 ($a1, refs 2/live 14) and the final velocity input as p123 ($v1).
     The nine zero-insn references after the destructive += raise p88 across
     the exact global-allocator boundary, producing retail's p88=$v1/p123=$a1
     handout without blocking the retail load/branch schedule.  The smaller
     expression-lifetime fences preserve the two multiply-chain handouts.
     Measured path: 28 -> 23 -> 15 -> 6 -> PASS (86/86). */
  int firstExprGuard;
  int nextVelX;
  int nextMatX;
  int firstProduct;
  int nextVelY;
  int nextMatY;
  int transformedZ;

  __asm__("" : "=r"(firstExprGuard));
  (carObj->linearVel_ch).x =
       (carObj->N).linearVel.x / 256 * ((carObj->N).shadowMat.m[0] / 256) +
       (carObj->N).linearVel.y / 256 * ((carObj->N).shadowMat.m[1] / 256) +
       (carObj->N).linearVel.z / 256 * ((carObj->N).shadowMat.m[2] / 256);
  nextVelX = (carObj->N).linearVel.x / 256;
  nextMatX = (carObj->N).shadowMat.m[6] / 256;
  __asm__("" : "=r"(firstExprGuard) : "0"(firstExprGuard));
  firstProduct = nextVelX * nextMatX;
  nextVelY = (carObj->N).linearVel.y / 256;
  nextMatY = (carObj->N).shadowMat.m[7] / 256;
  __asm__("" : : "r"(nextVelX));
  transformedZ = firstProduct + nextVelY * nextMatY;
  transformedZ +=
       (carObj->N).linearVel.z / 256 * ((carObj->N).shadowMat.m[8] / 256);
  __asm__("" : : "r"(transformedZ), "r"(transformedZ), "r"(transformedZ),
                  "r"(transformedZ), "r"(transformedZ), "r"(transformedZ),
                  "r"(transformedZ), "r"(transformedZ), "r"(transformedZ));
  (carObj->linearVel_ch).z = transformedZ;
  carObj->wheelSpin = 0;
  carObj->slide = 0;
  carObj->frontSkid = 0;
  carObj->rearSkid = 0;
  if ((carObj->N).collision.collided == 2) {
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
/* RECEIPT (w56-a12): fixed a real LINK BUG -- the `MAX(flywheelRpm,0)` clamp at
   cfLbl1 had no macro in scope, so cc1 emitted an implicit variadic `jal MAX`
   (unresolved symbol; final link would fail) instead of the inline `bgez`
   clamp.  Replaced with `if (flywheelRpm < 0) flywheelRpm = 0;` (correct bytes).
   Note: raw diff count moved 217->222 -- the buggy `jal MAX` block boundary
   happened to align the downstream coloring better (the w46 "broken body scores
   lower" artifact); 222 is the CORRECT-CODE count.  RESIDUAL (coloring basin):
   dominant diff = a pervasive s3-vs-s0 global-allocno swap (ours p84=s3 /
   retail wants it in s0) + the non-propagated reg-reg copy class.  allocsim
   MATCHES 34/35 (model valid); reqdelta prices the s0 dial as p84 refs 21->26
   OR p88 refs 11->9 -- NOT landed: retail's FULL handout (that p88 lands s3) is
   unconfirmed, so a fence risks fixing p84 while breaking p88.  NEXT ANGLE:
   confirm p88's retail reg from the oracle, then a zero-insn read-only fence on
   p84's last use.  The cfLbl1 `goto` is load-bearing (skips flywheelRpm=desiredRpm)
   -- do NOT inline the clamp. */
/* RECEIPT (w57-a9): 222 -> 140.  FOUR landings, in order:
   (1) STRUCTURE, not coloring -- retail wrote the rpm clamps as MIN/MAX TERNARIES
       whose result lands in a fresh temp reg (oracle `addu v1,<arm>,zero; slt; b*;
       addu v1,<other>,zero` then ONE store), not as `if (a<b) a=b;` overrides.
       Four sites converted (PHY_MIN/PHY_MAX above).  The cfLbl1 GOTO DIRECTION was
       also backwards: retail's label sits on the shared >=0 clamp inside the
       downshift else-arm (SLD 1541) and the DAMAGE arm jumps INTO it (oracle
       j @800aad14 -> .L800aae34); ours had it the other way round.  Also the
       `gear<4` ARM SWAP: retail's -200 arm is the FALL-THROUGH.  And wheelRpm's
       pre-shift value is the SYM local `temp`(v1), not wheelRpm itself.
   (2) SYM 8c IS THE REGISTER MAP: desiredRpm=$10=s0, diffFlywheelRpm=$13=s3,
       driveAcc=$14=s4, wheelRpm=$15=s5, drag=$16=s6, damage=$17=s7, specs=$12=s2,
       carObj=$11=s1, temp/ratio=$3=v1, rpmDrop=$4=a0, rpmRise=$3=v1.  Ours was a
       3-cycle off (s4/s0/s3).
   (3) reqdelta/allocsim RE-LADDERED after the structural landing (04Z -- the w56
       rung table was stale: it priced p84 21->26, the real dial is 16->20).
       allocsim MATCH 39/40; minimal ADDITIVE dial = p84 refs +4 AND p86 refs +1,
       landed as the two read-only fences below (+1 insn total, 210 then 130).
   (4) RESIDUAL 140 = (a) 06E non-propagated reg-reg copy class (retail keeps a
       separate `addu v1,vN,zero` before each compare; ours copy-propagates) x4;
       (b) local-alloc QTY handout for `temp` (retail v1, ours a0/a1);
       (c) randtemp/fastRandom store ORDER + the damage-arm fall-through.
   FALSIFIED (do NOT re-try): flywheelRpm as the COND_EXPR TARGET (store lands in
   BOTH arms, +8 insns, 241); `temp = <ternary>; flywheelRpm = temp;` for the
   rpmDrop subtract (247); plain two-arm if/else subtract (241). */
/* MATCH (w58-a2): 140 -> PASS, 710/710.  The decisive source reconstruction was
   to stop reusing the SYM-named temp for unrelated expression temporaries:
   direct signed redline/8 plus a short-lived damageAmount made the entire
   RNG/damage opening exact (63 -> 21).  The rev-limit timer is the direct ternary
   store, which creates retail's block-local $v0 graph (21 -> 13).  The +250 clamp
   reuses SYM temp=$a0 and ratio=$v1 around the early flywheel store; this removed
   the complete 8-diff clamp cluster.  A flywheel snapshot fixed both retail load
   orders.  The damage arm needs split compute / empty barrier / store so its store
   fills the jump delay slot without cross-jump merging into the other -100 arm.
   The downshift redline's read-only fence preserves lw-v0 then move-v1-v0.
   Finally, after a scheduling boundary, the signed /256 pair reuses dead
   diffDesiredRpm=$a0 and an identity-laundered ratio copy=$v0; placing the $a0
   shift before the $v0 sign test gives retail's delay-slot interleave.
   FALSIFIED IN THE FINAL BASIN: whole IDA-style control-graph rewrite (89);
   sibling-block scaledRatio assignments (11); explicit scaledDriveAcc quotient
   local (7); reversed multiply operands (12); direct/identity-only divisor copy
   (4/6).  All retained asm templates are zero-instruction allocation/scheduling
   fences; no hard-register pins or emitted hand assembly. */
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
  smokeRpm = carObj->specs->redline / 8;
  damage = 0;
  int damageAmount = (carObj->N).damage[1] + (carObj->N).damage[5];
  randtemp = fastRandom * randSeed;
  fastRandom = randtemp & 0xffff;
  if ((randtemp >> 8 & 0xffff) < (u_int)(damageAmount / 0x100)) {
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
  int currentFlywheelRpm = carObj->flywheelRpm;
  int redlineRpm = specs->redline;
  if (redlineRpm <= currentFlywheelRpm) {
    carObj->flywheelRpm = redlineRpm + 0x32;
    carObj->revLimit =
        (((carObj->control).gear == '\x01') || (powerControl == 0)) ? 3 : 4;
  }
  if (0 < carObj->revLimit) {
    int revLimitedRpm;
    int adjustedDesiredRpm;
    if (((carObj->control).gear == '\x01') || (powerControl == 0)) {
      revLimitedRpm = specs->redline + -800;
    }
    else {
      revLimitedRpm = specs->redline + -400;
    }
    adjustedDesiredRpm = revLimitedRpm;
    __asm__("" : "=r"(adjustedDesiredRpm) : "0"(adjustedDesiredRpm));
    if (adjustedDesiredRpm >= desiredRpm) {
      adjustedDesiredRpm = desiredRpm;
    }
    desiredRpm = adjustedDesiredRpm;
    __asm__("" : : "i"(0));
    carObj->revLimit = carObj->revLimit + -1;
  }
  if ((((carObj->control).gear == '\x01') || ((carObj->control).gearShiftTimer != '\0')) ||
     (powerControl == 0)) {
    if (damage) {
      __asm__("" : : "i"(0));
      int damagedFlywheelRpm = carObj->flywheelRpm + -100;
      __asm__("" : : "i"(0));
      carObj->flywheelRpm = damagedFlywheelRpm;
      goto cfLbl1;   /* retail: j into the shared >=0 clamp @0x800aae34 */
    }
    else {
      if ((carObj->flywheelRpm < desiredRpm) &&
          ((carObj->control).gearShiftTimer == '\0')) {
        temp = carObj->flywheelRpm + 0xfa;
        ratio = desiredRpm;
        carObj->flywheelRpm = temp;
        if (ratio >= temp) {
          ratio = temp;
        }
        carObj->flywheelRpm = ratio;
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
          int downshiftRedlineRpm = specs->redline;
          __asm__("" : : "r"(downshiftRedlineRpm));
          ratio = downshiftRedlineRpm;
          if (ratio >= carObj->flywheelRpm) {
            ratio = carObj->flywheelRpm;
          }
          carObj->flywheelRpm = ratio;
        }
        else {
          if (4 <= (u_char)(carObj->control).gear) {
            carObj->flywheelRpm = carObj->flywheelRpm + -200;
          }
          else {
            carObj->flywheelRpm = carObj->flywheelRpm + -100;
          }
cfLbl1:   /* @0x800aae34  (retail's shared clamp; the damage arm jumps here) */
          carObj->flywheelRpm =
              (carObj->flywheelRpm < 0) ? 0 : carObj->flywheelRpm;
        }
      }
      else {
        if (carObj->flywheelRpm < desiredRpm) goto Phy_CalcAcc_clearWheelSpinExit;
        carObj->flywheelRpm = carObj->flywheelRpm + -200;
        carObj->flywheelRpm = PHY_MAX(carObj->flywheelRpm,desiredRpm);
      }
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
    ratio = fixedmult((carObj->linearVel_ch).z,
                     specs->velToRpmRatio[(u_char)(carObj->control).lastGear]);
  }
  else {
    ratio = fixedmult((carObj->linearVel_ch).z,
                     specs->velToRpmRatio[(u_char)(carObj->control).gear]);
  }
  if (ratio < 0) {
    ratio = ratio + 0xffff;
  }
  wheelRpm = ratio >> 0x10;
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
    int newFlywheelRpm = carObj->flywheelRpm;
    int adjustedFlywheelRpm = (rpmDrop >= diffFlywheelRpm) ?
        newFlywheelRpm - diffFlywheelRpm :
        newFlywheelRpm - rpmDrop;
    carObj->flywheelRpm = adjustedFlywheelRpm;
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
        int adjustedFlywheelRpm = carObj->flywheelRpm + rpmRise;
        carObj->flywheelRpm = adjustedFlywheelRpm;
      }
      else {
        int currentFlywheelRpm = carObj->flywheelRpm;
        int adjustedFlywheelRpm = (rpmRise < -diffFlywheelRpm) ?
            currentFlywheelRpm + rpmRise :
            currentFlywheelRpm - diffFlywheelRpm;
        carObj->flywheelRpm = adjustedFlywheelRpm;
      }
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
        __asm__("" : : "r"(diffFlywheelRpm), "r"(diffFlywheelRpm));
        driveAcc = fixedmult(driveAcc,gGasRatio);
      }
      int currentFlywheelRpm = carObj->flywheelRpm;
      temp = desiredRpm;
      __asm__("" : "=r"(temp) : "0"(temp));
      if (temp >= currentFlywheelRpm) {
        temp = currentFlywheelRpm;
      }
      carObj->flywheelRpm = temp;
      __asm__("" : : "r"(desiredRpm), "r"(desiredRpm), "r"(desiredRpm), "r"(desiredRpm));
      ratio = __builtin_abs(carObj->slide) + 0x10000;
      if ((GameSetup_gData.sgge & 8U) != 0) {
        if (0x30000 < ratio) {
          ratio = 0x30000;
        }
      }
      else if (0x20000 < ratio) {
        ratio = 0x20000;
      }
      __asm__("" : : "i"(0));
      diffDesiredRpm = driveAcc;
      if (driveAcc < 0) {
        diffDesiredRpm = driveAcc + 0xff;
      }
      int scaledRatio = ratio;
      __asm__("" : "=r"(scaledRatio) : "0"(scaledRatio));
      diffDesiredRpm = diffDesiredRpm >> 8;
      if (scaledRatio < 0) {
        scaledRatio = scaledRatio + 0xff;
      }
      scaledRatio = scaledRatio >> 8;
      driveAcc = diffDesiredRpm * scaledRatio;
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
     exists in this fn, so the reachable dial is the 3-QTY LAW boundary (w46).
     ==== 2026-08-14 W59-A16 INSTRUMENT VERDICT: that next angle was WRONG. The lab
     -dl RTL dump (block 22) proves the copy DOES NOT EXIST in our RTL -- cse folds
     it at expand time, so no allocator dial could ever mint it.  Cure = the opacity
     fence (the one device cse cannot see through) on a block-local copy, with the
     skid load hoisted ABOVE the fence (fence is a sched barrier; load below it =
     3 diffs, the barrier eats the load-delay fill).  local-alloc.c:471-477 +
     1867-1869 then guarantee the copy survives (roadGrip is multi-block => reg_qty
     -1 => combine_regs can never tie it).  4 -> PASS 127/127. */
  {
    int skid = wheel->skid;
    int cmp = roadGrip;
    __asm__("" : "=r"(cmp) : "0"(cmp));   /* opacity: mints retail's addu v0,a2,zero */
    if (cmp >= skid) {
      roadGrip = skid;
    }
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
/* MATCH (w58-a1): 41 -> PASS, 233/233.  Retail evaluates gripLoss/divider first
   (`div zero,s1,a1`) and roadGrip/divider second, then keeps the smaller quotient.
   Reversing the symmetric MIN operands first recovered that divide order; spelling
   the result as IDA's explicit quotient/override recovered the remaining copy shape.
   SYM 8c: carObj=$13=s3, wheel=$10=s0, totalAcc=$14=s4,
   ratio=$12=s2, gripLoss=$3=v1, roadGrip=$4=a0, gripLossDivider=$5=a1 (all match).
   IDA's explicit quotient/override shape plus a read-only fence preserves retail's
   `mflo v0` and delayed `addu v1,v0,zero`; the adjacent gripLoss fence crosses the
   global-allocation ref step and restores gripLoss=$s1 / ratio=$s2.  The explicit
   TireType labels and a zero-insn block fence retain retail's fall-through arm and
   filled `j` slot.  Finally, naming skidValue before the identity-fenced comparison
   copy gives the exact `lw v1; addu v0,a0,zero; slt v0,v0,v1` load-delay sequence.
   All three fences emit zero instructions. */
void Physics_CalcTractionCircleAcc(Car_tObj *carObj,Physics_tWheelAccStruct *wheel)

{
  Physics_tWheelAccStruct *wheel_reg;
  int totalAcc;
  int ratio;
  int gripLoss;
  int roadGrip;
  int gripLossDivider;
  int gripLossQuotient;
  int gripLossRatio;
  int roadGripCompare;
  int skidValue;
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
      __asm__("" : : "r"(gripLoss));
      gripLossQuotient = gripLoss / gripLossDivider;
      __asm__("" : : "r"(gripLossQuotient));
      gripLossRatio = gripLossQuotient;
      if (gripLossRatio >= roadGrip / gripLossDivider) {
        gripLossRatio = roadGrip / gripLossDivider;
      }
      ratio = rdiv(roadGrip - gripLossRatio,totalAcc);
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
  if (tireType != 1) goto PhyTracCircle_notType1;
  __asm__("" : : "i"(0));
  roadGrip = 0x80000;
  goto PhyTracCircle_clamp;
PhyTracCircle_notType1:
  roadGrip = 0x40000;
  if (tireType != 2) goto PhyTracCircle_skidAdjust;
PhyTracCircle_clamp:
  skidValue = wheel_reg->skid;
  roadGripCompare = roadGrip;
  __asm__("" : "=r"(roadGripCompare) : "0"(roadGripCompare));
  if (roadGripCompare < skidValue) goto PhyTracCircle_storeGrip;
  roadGrip = skidValue;
PhyTracCircle_storeGrip:
  wheel_reg->skid = roadGrip;
PhyTracCircle_skidAdjust:
  if (carObj->carInfo->Traction != 0) {
    wheel_reg->skid = wheel_reg->skid * 3 / 4;
  }
  return;
}

/* ---- Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct  [PHYSICS.CPP:1815-1979] SLD-VERIFIED ---- */
/* RECEIPT (w59-a2): 68 -> 55, count 346==346 both ways (no missing statements).
   LANDED: the FRONT-tire velCap clamp funnels its THEN arm through a block-local
   `xAcc` and stores `wheel->finalAcc.x` inside that arm, while the ELSE arm still
   stores directly.  Retail funnels BOTH arms into one register (`addu v1,a2,zero` in
   each `j` delay slot + a single shared `sw`); the asymmetric spelling is what our
   cc1plus needs to stop cross_jump collapsing the two selects into one.
   FALSIFIED IN THIS BASIN (each gated): symmetric front funnel (both arms -> xAcc,
   one store) 56@348; whole front block as ONE nested COND_EXPR 79@337; front arms as
   per-arm ternaries 79; rear block funnelled through `xAcc` 59@349; front+rear both
   as nested COND_EXPRs 87@347; rear-only nested COND_EXPR 72@348; Yoda-ing the
   arm-2 `min` to `(velCap.z < acc) ? velCap.z : acc` 76@348; deleting the SYM-absent
   block local `minSlipAngle` and inlining 0x8000 75@347 (09K: the invented local IS
   load-bearing here -- do NOT "clean" it).
   RESIDUAL 55, dominant cluster = the REAR-tire clamp (SLD 1957/1959, 15 diffs):
   retail computes `abs(latAcc)` SEPARATELY INSIDE EACH ARM (`bgez a1; addu v0,a1,zero;
   negu v0,v0` twice) and funnels both selects into v1 for one shared store; ours
   cse's the abs once and merges the arms.
   ---- w59-a2 ROUND 2: the W59-A11 mobile twin (sub_507671,
   `scratchpad/w59a11/Physics_CalculateTireForces_twin.md`) was tried IN FULL and is
   FALSIFIED on PSX in this basin -- every item measured, none adopted:
     - twin A "the wheel-lock path is ONE `||`-guarded INLINE block with an early
       return, not two `goto`s to a shared label": 120 @ EXACT 346/346 (our two-goto
       form is the PSX oracle's block order; the mobile's is a port artifact).
     - twin D "roadGrip clamp arms nested inside the TRUE arm of the upper test"
       + twin E "`gameTicks % 4 != 0` with the arms swapped": 61 @347 on the 55
       baseline; NEUTRAL (120) on top of twin A.
     - twin C "abs is the `(x <= 0 ? -x : x)` macro, not `__builtin_abs`" applied to
       the three wheel-lock guards: 55 @347 (one insn LONG -- no gain).
     - twin C applied to the REAR clamp (per-arm re-emission of the abs, which is the
       shape the residual below asks for): 56 @350.
   => keep `__builtin_abs` and the goto form here; the PSX oracle's words win.
   W62-A11 LANDED 55 -> 49 (@349/346).  Re-baselined 55.  The BRANCH CENSUS is the
   new diagnostic: ours had 71 conditional/uncond branches vs retail's 72, and the
   missing one is in the arm-1 max -- retail emits `slt v0,v1,a0; beqz v0,T; nop;
   j T; addu v1,a0,zero`, i.e. the SAME both-arms-funnel-into-one-register-then-one-
   store shape already banked for the FRONT velCap clamp.  Rewriting the arm-1
   ternary as an explicit if/else through a block-local `a` buys it (-6).
   MEASURED this wave: arm-2 min funnelled the same way ALSO 49 @349 on its own,
   but BOTH funnels together fall back to 55 @347 (non-additive -- cross_jump
   re-merges the two selects once they are the same shape), so exactly ONE funnel
   is the landed form; arm-1 Yoda 67 @351; arm-2 Yoda 51 @351.
   NEXT ANGLE: re-run the branch census after this landing (tools-free: compare the
   per-branch instruction DISTANCE ours-vs-oracle, scratchpad/w62a11/brdist.py) --
   it localises a missing/extra guard far faster than reading the diff, and it is
   the only view that sees branch-OFFSET divergence at all (verify_asm normalises
   branch targets). */
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
      /* w62-a11: ARM-1 MAX FUNNELLED through a block-local (55 -> 49).  Retail
         funnels both arms into one register and stores once -- the same device
         as the FRONT velCap clamp above.  Doing the SAME to the arm-2 min also
         scores 49 alone, but BOTH together fall back to 55 (non-additive:
         cross_jump re-merges them) -- keep exactly one. */
      {
        int a;
        if (wheel->acc > wheel->velCap.z) {
          a = wheel->acc;
        } else {
          a = wheel->velCap.z;
        }
        wheel->acc = a;
      }
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
      int xAcc;

      if (0 < wheel->velCap.x) {
        if (wheel->velCap.x <= __builtin_abs(latAcc)) {
          xAcc = wheel->velCap.x;
        }
        else {
          xAcc = __builtin_abs(latAcc);
        }
        /* w59-a2: THEN arm funnels through xAcc and stores here; the ELSE arm
           stores directly.  The ASYMMETRY is the lever (see the fn receipt). */
        wheel->finalAcc.x = xAcc;
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

    /* RECEIPT (w59-a2): residual 14, count 1272==1272.  Two clusters, both
       re-verified: (a) the /0x200 below -- retail materialises the sum DIRECTLY into
       damage's own register (`addu v1,v0,a0`) and lets expand_sdiv_pow2's temp copy
       survive in the bgez DELAY SLOT (`addu v0,v1,zero; addiu v0,v1,511; sra v1,v0,9`);
       ours needs the identity fence below to reach count parity and then divides in
       place.  FALSIFIED: dropping the identity fence 15@1271 (1 insn SHORT);
       `__volatile__` flavour 14 (no change); a SECOND identity fence 14 (no change);
       a read-only fence on `damage` after the damageMult line 33@1273 (emits an insn);
       splitting into `damageMult = damage / 0x200; damageMult = 0x10000 - damageMult;`
       31@1273.  (b) SLD 2341 (`... * 2` in the wheelMult term): retail issues
       `lw a2,52(sp); lw a0,100(sp)` BEFORE `lw v1,0(gp)`, ours after -- a pure sched
       order + a2-vs-v0 choice, 3 diffs.
       W60-A9 ADDENDUM -- the (a) cluster re-read at instruction level: retail's LAST
       ADDEND writes a FRESH register (`addu v1,v0,a0`, so the sum lands in damage's
       own pseudo) and expand_sdiv_pow2's bias then reads THAT sum (`addiu v0,v1,511`),
       with the temp copy filling the bgez delay slot; ours folds the last addend into
       the accumulator (`addu v0,v0,a0`), copies to v1, and the bias reads the COPY
       (`addiu v1,v1,511`) while the delay slot takes the next statement's
       `addu a0,a1,zero`.  MEASURED THIS WAVE, none beat 14: a named `partial` local
       for the first three addends + the fence 14 | the same without the fence 15@1271
       | `(d0+d1) + (d2+d9)` pair-association 32@1270 | `damage = d0+d1+d2;
       damage += d9;` 14.  So the fresh-destination is not reachable by re-associating
       the sum.  The newton DoPostBarrier device (a volatile-view re-read on ONE term)
       is FALSIFIED here too: volatile on damage[9] / damage[0] / all four = 14@1272
       each, byte-identical to the plain form (the four terms are already separate
       loads, so there is no cse substitution left to block).  NEXT ANGLE: the
       fresh-destination is a local-alloc qty question -- run tools/qtyprio.py on the
       .lreg block that owns the four-addend chain and dial the ACCUMULATOR's birth,
       not the sum's spelling.
       W61-A11: the SYM seats are now read off (VA 800ac5b8 block, line 111-123):
       `damage` = REG $3 = v1, `damageMult` = REG $2 = v0 -- so retail's
       `addu v1,v0,a0` puts the sum straight into damage's OWN seat and the
       expand_sdiv_pow2 bias temp lives in v0 = damageMult's seat (12D dead-pseudo
       staging).  The 12D staging spelling was tried and is FALSIFIED here: routing
       the first three addends through `damageMult` (`damageMult = d0+d1+d2;
       damage = damageMult + d9;`) 43@1273, +the identity fence 45@1273, +the split
       division 43@1273, staging only the first two 45@1273; dropping the fence
       alone 15@1271.  The blocker is NOT the sum's destination -- it is that ours
       divides IN PLACE (damage dead at the division) so delete_noop_moves removes
       expand_sdiv_pow2's `move t,x`, while retail's `damage` and the bias temp got
       DIFFERENT hard regs.  NEXT ANGLE: keep `damage` live PAST the shift with a
       zero-insn read-only fence -- but note the one position tried (after the
       damageMult line) emits an insn (33@1273), and the W61-A11 HeliCam result
       proves fence POSITION is its own dial, so sweep the position properly.
       W62-A11 LANDED 14 -> 6 (@1272/1272), cluster (a) SEALED and the identity
       launder DELETED.  THE LEVER IS THE STATEMENT SPLIT ONTO THE SAME VARIABLE:
       `damage = damage / 0x200; damageMult = 0x10000 - damage;` instead of the
       fused `damageMult = 0x10000 - damage / 0x200;`.  Writing the quotient BACK
       INTO `damage` makes the divide's destination the dividend's own pseudo, so
       expand_sdiv_pow2 must materialise its bias in a THIRD register -- retail's
       `addu v0,v1,zero` in the bgez delay slot, `addiu v0,v1,511`, `sra v1,v0,9`
       -- byte-exact, and the sum already landed in damage's own seat (v1) without
       any fence.  The whole 5-wave `keep the dividend live` programme was chasing
       the wrong axis: the copy is bought by the DESTINATION, not by liveness.
       Falsified/priced this wave: the shipped fused form + launder 14 | fused,
       no launder 15@1271 | fused + read-only fence on damage after the steer line
       24@1272 (this DOES buy retail's exact 6-insn shape but rotates every seat
       one slot up: sum a1 / temp v1 / tempSteer a2 vs retail v1 / v0 / a1) | the
       same with 2 or 3 fence operands 24 (ref dials are INERT -- the rotation is
       conflict-driven, not priority-driven) | fence after the damageMult line
       33@1273 | void fence either side 15/31 | declaration order swapped 14/15 |
       an extra unused local 15 | a `damageTmp` carrier 15 | staging through
       damageMult 33.  RESIDUAL 6 = cluster (b) ONLY (SLD 2341): retail issues
       `lw a2,52(sp); lw a0,100(sp)` (the finalAcc.z pair) BEFORE `lw v1,0(gp)`
       and keeps front-z in a2; ours hoists `lw v1,0(gp)` first and uses v0.
       Shape sweep on the wheelMult block, all gated: control 6 | named accSum
       local before wheelMult 10 | after wheelMult 6 | no local, fully inlined 10 |
       accSum local + inlined wheelMult 10 | void fence after the wheelMult decl 14 |
       swapped `.z` sum operands 6 | `* 2` on one line 6.  => source shape is
       exhausted; this is a sched1 emission-order + one seat, i.e. a
       PER_FN_TEXT_MOVES candidate (move `lw v1,0(gp)` down past the two stack
       loads) that would still leave the a2-vs-v0 pair. */
    damage = (carObj->N).damage[0] + (carObj->N).damage[1] +
             (carObj->N).damage[2] + (carObj->N).damage[9];
    damage = damage / 0x200;
    damageMult = 0x10000 - damage;
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
  {
    int brakeCap = __builtin_abs((carObj->linearVel_ch).z) << 5;
    __asm__("" : "=r"(brakeCap) : "0"(brakeCap));
    int limitedBrakeAcc = brakeCap;
    if (limitedBrakeAcc >= brakeAcc) {
      limitedBrakeAcc = brakeAcc;
    }
    brakeAcc = limitedBrakeAcc;
  }
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
    __asm__("" : "=r"(tempGas) : "0"(tempGas));
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
      __asm__("" : : "r"(lookAhead), "r"(lookAhead), "r"(lookAhead),
                       "r"(lookAhead), "r"(lookAhead), "r"(lookAhead),
                       "r"(lookAhead), "r"(lookAhead), "r"(lookAhead),
                       "r"(lookAhead));
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

        carPos = (carObj->N).position;
        dirVector = *(coorddef *)BWorldSm_slices[sliceAhead].center;
        roadPosition =
            Physics_CalculateRSControlDesiredPosition(
                carObj,sliceAhead,__builtin_abs(lookAhead * 3));
        offset.x = fixedmult(
            (int)(signed char)BWorldSm_slices[sliceAhead].right[0] << 9,
            roadPosition);
        offset.y = fixedmult(
            (int)(signed char)BWorldSm_slices[sliceAhead].right[1] << 9,
            roadPosition);
        offset.z = fixedmult(
            (int)(signed char)BWorldSm_slices[sliceAhead].right[2] << 9,
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
