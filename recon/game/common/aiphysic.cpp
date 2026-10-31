/* game/common/aiphysic.cpp -- RECONSTRUCTED (AI physics subsystem).
 *   AIPhysic_* — AI car physics: gear/speed tables, collision, control, road position.
 *   Reconstruction in progress (started 2026-06-20). NOT original source; SYM-faithful,
 *   recompilable C++. Verified per-function vs asm/nonmatchings/main/*.s.
 */
#include "aiphysic_types.h"
#include "aiphysic_externs.h"

/* SOURCE-REVIEW-UNRESOLVED: this helper preserves the unreferenced "SimpleMem" literal at0x800553A0.
 * Retail type/header presence does not recover this helper or the original literal producer;no inline identity is claimed. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

#define MAX(a,b) (((a) > (b)) ? (a) : (b))

/* Owner-module tentative definition: AIPhysic_elapsedTime ($8013c59c) lives in this TU's
 * small-common (.comm,4) so -G4 addresses it gp-relative (`lw $v1,N($gp)`), matching the
 * oracle (HitWallCheck etc.). As a bare `extern` it degraded to absolute lui/lw (+1 insn). */
int AIPhysic_elapsedTime;

/* aiphysic.obj-owned bss globals (tentative defs → gp-relative addressing like elapsedTime) */
AIPhysic_Config_t AIPhysicConfig;   /* @0x8010dc74 */
int AIPhysic_time;                  /* @0x8013c598 */
int AIPhysic_iTime;                 /* @0x8013c594 */


/* ============================================================================
 * PORTED from run-tree (game/common/aiphysic.cpp) — 17 new definitions.
 * Canonical Sim_tSimGlobalVar and gameStarted/gameTicks accesses restored
 * 2026-10-21; the former int[] decompilation shortcut is removed. Personality
 * member reads now use the owning SYM fields;broader source review remains open.
 * ========================================================================== */

/* ---- AIPhysic_StopCar__FP8Car_tObjii [@0x80069238] ----
 * 2026-10-27: actual vector clear/product source groups and final angular
 * product126 recover all49 word/file tags,block lines and end126. Implicit
 * void fallthrough needs no invented final return or temporary. Whole ELF/
 * native CPE and all supplied owner tuples remain unchanged. Older stagger/
 * coloring near-miss history is archived in before.cpp,not an active floor.
 * Original macro spelling remains unproved;no new helper or source object.
 * Receipt:build/nc12/aiphysic_engine_stop_20261027/. */
#line 119 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_StopCar(Car_tObj *carObj,int velScale,int rotScale)
{
  (carObj->angularAcc).z = 0; (carObj->angularAcc).y = 0; (carObj->angularAcc).x = 0;
  (carObj->linearAcc_ch).z = 0; (carObj->linearAcc_ch).y = 0; (carObj->linearAcc_ch).x = 0;
  (carObj->linearAcc_rh).z = 0; (carObj->linearAcc_rh).y = 0; (carObj->linearAcc_rh).x = 0;
  (carObj->N).linearVel.x = velScale / 256 * (carObj->N).linearVel.x / 256; (carObj->N).linearVel.y = velScale / 256 * (carObj->N).linearVel.y / 256; (carObj->N).linearVel.z = velScale / 256 * (carObj->N).linearVel.z / 256;

  (carObj->N).angularVel.y = (carObj->N).angularVel.y / 256 * (rotScale / 256);
}

/* ---- AIPhysic_RevEngine__FP8Car_tObj  (oracle reloads flywheelRpm 3x -- parity test, the add,
 * and the final clamp-check -- and shifts redLine>>16 IN PLACE inside the parity branch's delay
 * slot, not as a fresh expr in the final compare; carIndex%2 (NOT flywheelRpm) feeds `increase`.
 * Signed increase/2 combines to the same shift because the increment is even;
 * its deleted bias pseudo leaves retail's unnamed 8-byte frame. No dummy array.
 * 2026-10-27: all52 word/file tags,block lines and end155 now match.
 * Actual parity142,sign147,rounding148 and final clamp155 groups preserve
 * every byte/owner and the genuine unnamed frame. Original literal macro
 * spelling remains open;receipt:build/nc12/aiphysic_engine_stop_20261027/. ---- */
#line 136 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_RevEngine(Car_tObj *carObj)
{
  int increase;
  int redLine = carObj->redLine / 0x10000;


  increase = ((carObj->carIndex % 2 + 1) * AIPhysic_elapsedTime) * 0x8c;


  if ((carObj->flywheelRpm & 1) != 0) {

    increase = -(increase / 2);
    if ((increase & 1) != 0) increase = increase - 1;
  }
  carObj->flywheelRpm = carObj->flywheelRpm + increase;

  if (redLine < carObj->flywheelRpm) {
    carObj->flywheelRpm = redLine / 2 | 1; }
  if (carObj->flywheelRpm < 0x1f5) {
    carObj->flywheelRpm = 500; }
}

/* ---- AIPhysic_HandleShifting__FP8Car_tObj ---- */
#line 167 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_HandleShifting(Car_tObj *carObj)
{
  int desiredRPM;

  if (carObj->aiShiftTimer > 0) {

    carObj->aiShiftTimer = carObj->aiShiftTimer - AIPhysic_elapsedTime;
    desiredRPM = 3000; }



  else {
    Gear_t gear; int speed; int speedDiff; int baseRPM; int invGearSpeedRange; gear = AIPhysic_CalculateGear(carObj);
    speed = __builtin_abs(carObj->currentSpeed);



    speedDiff = speed - AIPhysic_GearBottomSpeed(carObj,gear);

    baseRPM = 0; if (2 < (int)gear) baseRPM = 0xfa00000;
    invGearSpeedRange = AIPhysic_GearInvSpeedRange(carObj,gear);


    if (speedDiff < 0) speedDiff += 0xff; speedDiff >>= 8; speedDiff *= invGearSpeedRange / 256; if (speedDiff < 0) speedDiff += 0xff; speedDiff >>= 8; desiredRPM = baseRPM + speedDiff * ((carObj->redLine - baseRPM) / 256);
    desiredRPM = desiredRPM / 0x10000;


    (carObj->control).gear = (char)gear;
  }




  if (carObj->flywheelRpm < desiredRPM)
    carObj->flywheelRpm += (desiredRPM - carObj->flywheelRpm) / 8;
  else if (desiredRPM < carObj->flywheelRpm)
    carObj->flywheelRpm -= (carObj->flywheelRpm - desiredRPM) / 8;
}

/* ---- AIPhysic_CalculateGear__FP8Car_tObj  (gear search loop) — MATCHED 100% (pin-free) ----
 * The earlier 64/65 near-miss residual was the abs idiom: a hand-rolled
 * `absV=raw; if(raw<0) absV=-absV;` lets gcc COLLAPSE the `absV=raw` copy (load raw
 * straight into s4), diverging from the oracle's keep-raw-in-v1-then-`addu s4,v1,zero`-`negu`
 * form. THE LEVER: the original source used the standard `abs()` (oracle INLINES it:
 * `bgez; addu s4,$v1,zero; negu s4` — disasm-v4 @0x80069560). decomp.me scratch IxEHO
 * (DataPlusProgram, 2026-06-20) matched with plain `abs()` — but that only works on its
 * cc1/gcc-2.8.0 (which inlines `abs`); OUR seal pipeline is cc1plus/gcc-2.7.2, which compiles
 * plain `abs()` to a real `jal abs` (16 diffs). PORTABLE FORM = **`__builtin_abs(speed)`** —
 * forces the inline `bgez;addu;negu` on BOTH gcc versions, reproducing the v1→s4 copy that
 * was the sole coalescing residual. Also `absSpeed <= 0x1FFFF` folds the constant (no separate
 * `int limit`). Re-verified in-tree (CC1PLPSX+maspsx): PASS 65/65. Pin-free → HARD RULE §3.13.
 * (cross-ref §3.14 SH `@hack Needs to be int for ABS to match`; same class as the
 * SimplePhysics_LatVel clamp-abs residual → __builtin_abs candidate there too.)
 * The two early assignments now use a structured if/else-if/else funnel:
 * GCC emits the same 65 words without a source LABEL record. Retail has no
 * label at that join. 2026-10-27: actual gear updates precede timer stores;
 * ordinary anchored layout matches all65 word/file tags and end254. The
 * NFS2 sibling shifting loop's real break replaces the inner return and moves
 * the root end from+228 to supplied+224,without changing any word. All65
 * tags,complete provided owners,block/end lines and entry facts now agree.
 * Receipt:build/nc12/aiphysic_gear_break_20261027/. Literal text is not unique. */
#line 213 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
Gear_t AIPhysic_CalculateGear(Car_tObj *carObj)
{
    int hi;
    int speed = __builtin_abs(carObj->currentSpeed);
    Gear_t gear = (Gear_t)carObj->control.gear;


    if (speed <= 0x1FFFF) {

        gear = 1;


    } else if (carObj->driveDirection == -1) {

        gear = 0;


    } else {



        while ((hi = AIPhysic_GearTopSpeed(carObj, gear) < speed) || AIPhysic_GearBottomSpeed(carObj, gear) > speed) {


            if (hi) {


                if (AIPhysic_GearTopSpeed(carObj, (Gear_t)(gear + 1)) == 0) break;

                gear = (Gear_t)(gear + 1);
                carObj->aiShiftTimer = carObj->aiShiftDuration;
            } else {


                gear = (Gear_t)(gear - 1);
                carObj->aiShiftTimer = carObj->aiShiftDuration;

            }
        }
    }

    return gear;
}

/* ---- AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t ---- */
#line 261 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
int AIPhysic_GearInvSpeedRange(Car_tObj *carObj, Gear_t gear)
{

    if (gear < 2)
    {
        return AIPhysic_GearInvSpeedRange(carObj, (Gear_t)2);
    }
    else
    {

        int convertedGear = gear - 2;


        return carObj->invTopSpeeds[convertedGear];
    }
}

/* ---- AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t  (clamp via tail-recursion -> gcc `j self`) ---- */
#line 282 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
int AIPhysic_GearTopSpeed(Car_tObj *carObj, Gear_t gear)
{

    if (gear < 2)
    {
        return AIPhysic_GearTopSpeed(carObj, (Gear_t)2);
    }
    else
    {

        int convertedGear = gear - 2;


        return carObj->topSpeeds[convertedGear];
    }
}

/* SOURCE-REVIEW-UNRESOLVED: this convertedGear constant alias has no retail
 * declaration,unlike the supplied REG:$2 locals in the two preceding helpers.
 * Direct/conditional controls preserve bytes but lose two supplied regions;
 * actual value-region controls add a fourth region. Neither failure proves
 * the alias/name original. Recover its source producer,not a debug-elision
 * exemption. All covered SLD fields match;literal source remains unproved.
 * Receipt:build/nc12/aiphysic_gear_helpers_20261027/. */
/* ---- AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t ---- */
#line 302 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
int AIPhysic_GearBottomSpeed(Car_tObj *carObj, Gear_t gear)
{

    if (gear < 3)
    {

        return 0;
    }

    else
    {

        const int convertedGear = gear - 3;

        return carObj->topSpeeds[convertedGear];
    }
}

/* ---- AIPhysic_CalcAcceleration__FP8Car_tObji ---- */
/* Owning AIPHYSIC.obj SYM114f84: Car_tObj::carFlags is INT at+0x260.
 * Both human race-car reads use that supplied member rather than raw byte
 * offsets. Whole native dump and normal object are unchanged.
 * Receipt:build/nc12/aiphysic_carflags_field_20261027/. */
/* 2026-10-27: all184 word/file tags,six block records,end397 and complete
 * supplied owners now agree with retail,without changing normal ELF/CPE.
 * The real glued cap calculation precedes its comparison on341/342. This
 * valid source reuses the provided,already-consumed speed input (same units);
 * an acceleration-reuse control also passes,so literal original reuse is not
 * uniquely proved. No new capture/name/qualifier is introduced.
 * The unused ret0 label/unreachable return are removed;they never emitted a
 * native LABEL record,so source inspection matters beyond the LABEL census.
 * Earlier W59/W79-W82 near-miss/fence and post-compile-copy proposals are
 * historical,not active instructions. Verbatim receipts remain in before.cpp;
 * current pure source passes the unchanged selected stock pipeline. The shared
 * return tail agrees with the mobile logic twin,not a unique-text proof.
 * Receipt:build/nc12/aiphysic_acc_sld_20261027/. */
#line 325 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
int AIPhysic_CalcAcceleration(Car_tObj *carObj,int speed)
{
  int accelEntry; int acceleration; int absSpeed; int speedUpAcc;

  absSpeed = __builtin_abs(speed);


  if (0 < carObj->aiShiftTimer) {    return 0;  }



    if (carObj->carInfo->carType < 0x16)
    {
      int normalTopCap; int upgradeTopCap;
      normalTopCap = Cars_topSpeedCap[carObj->carInfo->carType];
      upgradeTopCap = fixedmult(normalTopCap,carObj->topSpeedUpgradeMult);
      speed = fixedmult(upgradeTopCap,carObj->aiGlue);
      if (speed < absSpeed || upgradeTopCap < absSpeed) { return 0; }


      if (normalTopCap < absSpeed) {
        absSpeed = normalTopCap + -0x238e3;
      }
    }

    accelEntry = absSpeed / 0x10000;
    if (0x6f < accelEntry) accelEntry = 0x6f;
    if (accelEntry < 0) accelEntry = 0;


    acceleration = (carObj->accelerationRecord)->Get(accelEntry);








    if (carObj->accNitrous != 0x10000) {
      acceleration = acceleration / 256 * (carObj->accNitrous / 256);
    }

    acceleration = acceleration / 256 * (carObj->accUpgradeMult / 256);


    if (0 < GameSetup_gData.Weather) {
      acceleration = acceleration / 256 * 0xe6;
    }



    if ((carObj->carFlags & 0x20U) != 0) {

      acceleration = acceleration / 256 * (carObj->copAccMult / 256);
    }
if ((((GameSetup_gData.raceType == RaceType_HotPursuit) || (GameSetup_gData.raceType == RaceType_Id5)) && ((((Cars_gHumanRaceCarList[0]->carFlags) & 0x200) != 0 || ((Cars_gNumHumanRaceCars == 2 && (((Cars_gHumanRaceCarList[1]->carFlags) & 0x200) != 0)))))) && ((carObj->carFlags & 8U) != 0)) {

      acceleration = acceleration / 256 * (AITune_BTCPerpAccMults[GameSetup_gData.skill] / 256);
    }


    acceleration = AIPhysic_ModifyAccelerationAccordingToScript(carObj,acceleration);






    speedUpAcc = AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars(carObj);     if (speedUpAcc != 0x10000) {
      acceleration = fixedmult(acceleration,speedUpAcc);
    }
    return acceleration;
}

/* 2026-10-27: five small covered SYM/SLD seals use the existing anchors.
 * ResetCar,TargetedGetDesiredVector,CalcDeceleration and script acceleration
 * require only real statement grouping/layout. Rear-end damage computes its
 * upper clamp into the existing totalDamage before the separate return.
 * All119 normal ELFs/native CPE,all42 code/branch PASS and prior contracts
 * survive. Literal original macro text remains unproved;no new objects,
 * qualifiers,asm/volatile,statement anchors or generated-output rewrites.
 * Receipt:build/nc12/aiphysic_small_sld_20261027/. */
/* ---- AIPhysic_ModifyAccelerationAccordingToScript__FP8Car_tObji ---- */
#line 403 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
int AIPhysic_ModifyAccelerationAccordingToScript(Car_tObj *carObj, int acc)
{






    if (AIScript_DoReAction(&carObj->script, (AIScript_tAIReaction)4) != -1) {

        acc = ((acc / 256) * 3) << 7;
    }
    return acc;
}

/* ---- AIPhysic_CalcDeceleration__FP8Car_tObj  (the bgez/+0xFF/sra-8 = gcc-2.x signed /256) ---- */
#line 424 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
int AIPhysic_CalcDeceleration(Car_tObj *carObj)
{
    int d = ((AIPhysic_BrakeInfo *)carObj->brakeInfo)->Deceleration();

    if (0x10000 < carObj->aiGlue) {
        d = (d / 256) * (carObj->aiGlue / 256);
    }
    return d;
}

/* ---- AIPhysic_CheckDesiredDirection__FP8Car_tObj [@0x80069a34] ----
 * 2026-10-27: raw mobile sub_4D2407 retains the full race1/5 and human-cop
 * predicate that both decompilers optimized away. Its true arm repeats the
 * same turnaround threshold. Restoring those real source tests removes the
 * volatile read and empty memory fence at18/18,with all covered SYM/SLD exact.
 * Switch controls can also match code but do not recover that predicate and
 * are not adopted. Older fence-necessity claims were incomplete source models.
 * Original macro spelling is not uniquely proved. Verbatim old receipts are
 * archived in before.cpp,not retained as an active assembly exemption.
 * Receipt:build/nc12/aiphysic_turnaround_c_20261027/. */
#line 439 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_CheckDesiredDirection(Car_tObj *carObj)
{
  int turnAroundSpeed = 0x8e38e;
  if (((carObj->carFlags & 0x20) != 0) && ((GameSetup_gData.raceType == RaceType_HotPursuit) || (GameSetup_gData.raceType == RaceType_Id5)) && (((Cars_gHumanRaceCarList[0]->carFlags & 0x200) != 0) || ((Cars_gNumHumanRaceCars == 2) && ((Cars_gHumanRaceCarList[1]->carFlags & 0x200) != 0))))
    turnAroundSpeed = 0x8e38e;



  if (carObj->speed < turnAroundSpeed) {

    carObj->direction = carObj->desiredDirection;
  } }

/* ---- AIPhysic_HandleSignalling__FP8Car_tObj  (turn-signal flags in halfwords 0x8B8/0x8BA) ---- */
#line 457 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_HandleSignalling(Car_tObj *carObj)
{
    if (!(carObj->carFlags & 0x10)) return;
    int lDes, lPos;

    lDes = carObj->desiredLatPos;
    lPos = carObj->roadPosition;


    if (lDes < lPos - 0x40000)
    {
        carObj->render.signalLight[0] = (short)(*(unsigned short *)&carObj->render.signalLight[0] | 0x80);
        carObj->render.signalLight[1] = 0;
    }
    else if (lPos + 0x40000 < lDes)
    {
        carObj->render.signalLight[1] = (short)(*(unsigned short *)&carObj->render.signalLight[1] | 0x80);
        carObj->render.signalLight[0] = 0;
    }
    else
    {
        carObj->render.signalLight[0] = 0;
        carObj->render.signalLight[1] = 0;
    }
}

/* ---- AIPhysic_HandleWipeoutTimer__FP8Car_tObj  (leaf; inline mult PRNG advances 0x744 timer) ----
 * [MATCHED 100% (37/37), pin-free]. The "work-pointer cascade" (car→a1 not a3) was DOWNSTREAM of
 * two structural misses: (1) `limit` was a scalar `D_8011E0B0` → self-temp HI-scratch load; making
 * D_8011E0B0 an UNSIZED ARRAY (`extern int D_8011E0B0[]`, access `[0]`) gives the oracle's
 * separate-temp `lui v0; lw a2,(v0)` (§3.12#5) — also fixed HandleDirection as a bonus. (2) the
 * single final assignment lets the scheduler compute `limit + personality->0x30` before `mflo`,
 * preserving the 4-live-value peak that puts car in $a3. (3) the final `((r>>8)&0xFFFF) & field`:
 * gcc-2.7.2 narrows the `&0xFFFF` into a HALFWORD load (`lhu`, dropping the andi) — write the random
 * as `(unsigned short)(r>>8)` to anchor the andi on the random + keep the full `lw` of the personality field. */
#line 492 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_HandleWipeoutTimer(Car_tObj *carObj)
{







    if ((carObj->carFlags & 8) != 0 && simGlobal.gameTicks > carObj->wipeOutStartTick)
    {



        randtemp = fastRandom * randSeed; fastRandom = randtemp & 0xFFFF; carObj->wipeOutStartTick = simGlobal.gameTicks + carObj->personality->minimumBetweenWipeoutTicks + (int)((unsigned int)(unsigned short)(randtemp >> 8) & carObj->personality->randomBetweenWipeoutTicks);
    }
}

/* ---- AIPhysic_Main__FP8Car_tObj ---- */
#line 528 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_Main(Car_tObj *carObj)
{
  char useCoolPhysics;














  if (Sched_ExecuteCheck(1,1,(carObj->N).distToPlayer,(carObj->N).objID,&AIPhysic_time,&AIPhysic_elapsedTime,&AIPhysic_iTime,carObj->forceNoSimOptz) == 0)
    return;





















  if ((carObj->carFlags & 2U) != 0)
    AIWorld_CalcSpeed(carObj);


  AIPhysic_CheckDesiredDirection(carObj);
  AIPhysic_CheckForGripReduction(carObj);

  AIPhysic_HandleSignalling(carObj);


  carObj->lateralVelocity = AIWorld_CalcLateralVelocity(carObj);

  useCoolPhysics = AIPhysics_UseCoolPhysics(carObj);






  AIPhysic_CalculateRampedDesiredLatPos(carObj,(eRampType)(useCoolPhysics != 0));

  if ((carObj->AIFlags & 4U) != 0) return; if ((carObj->N).active == '\0') return;








  if (simGlobal.gameStarted != 1) {


    AIPhysic_RevEngine(carObj);



    return;
  }



  AIPhysic_HandleShifting(carObj);

  if ((carObj->N).flightTime != 0) {

    if ((carObj->carFlags & 0x400U) == 0) return;

    AIPhysic_StopCar(carObj,0xfae1,0xfae1); return;
  }

  if (carObj->speed < 0x40000) {

    (carObj->linearVel_ch).z = 0;
    carObj->rearSkid = 0; carObj->frontSkid = 0;

  }

  if (((carObj->N).flightTime == 0) && ((carObj->N).orientMat.m[4] < 0x4ccc)) goto stopSlow;






  if (carObj->blowout != 0) {


    AIPhysic_StopCar(carObj,0xfd70,0xfae1); return;
  }

  if (carObj->pullOver != 0) {

    if (carObj->speed < 0x238e3) {

      AIPhysic_StopCar(carObj,0xe666,0xe666);
      return;
    }
    if (carObj->speed < 0x8e38e) {


      AIPhysic_StopCar(carObj,0xf5c2,0xfae1); return;
    }
  }



  if (((carObj->carFlags & 1U) != 0) && ((carObj->stats).finishType == 2)) { if (__builtin_abs(carObj->currentSpeed) < 0x20000) goto stopSlow; } if (carObj->desiredSpeed == 0) {
stopSlow:
    AIPhysic_StopCar(carObj,0xf0a3,0xfae1);
    return;
  }




  if (useCoolPhysics != 0)
    AIPhysic_CoolPhysics(carObj);
  else
    AIPhysic_SimplePhysics(carObj);

  AIPhysic_CheckForBadPosition(carObj);

  AIPhysic_HandleWipeoutTimer(carObj);






}

/* ---- AIPhysic_CheckForBadPosition__FP8Car_tObj  (two OR-flags → reset on bad) ---- */
#line 680 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_CheckForBadPosition(Car_tObj *carObj)
{
    int badSpeed = 0;
    int badRoadPos = 0;


    if (0x730000 < carObj->N.linearVel.z || 0x730000 < carObj->N.linearVel.x || (0x730000 < carObj->N.speedXZ && carObj->N.simOptz == 0))
        badSpeed = 1;

    if (carObj->roadPosition < (int)0xFFDD0000 - (BWorldSm_slices[carObj->N.simRoadInfo.slice].leftDrive << 8) || (BWorldSm_slices[carObj->N.simRoadInfo.slice].rightDrive << 8) + 0x230000 < carObj->roadPosition)
        badRoadPos = 1;




























    if (badSpeed || badRoadPos)
        Cars_ResetCollidedCars(carObj, 1, 0);
}

/* ---- AIPhysics_UseCoolPhysics__FP8Car_tObj [@0x80069eec] COVERED-SLD-PASS ---- */ /* 2026-10-27: the ordinary compound predicate removes unprovided ret1/ret0;all17 words and provided absolute SYM/SLD fields match. Older goto-only claims were basin-relative,not a source floor. Literal original text remains unproved. Receipt: build/nc12/aiphysic_cool_20261027/. */
#line 731 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
int AIPhysics_UseCoolPhysics(Car_tObj *carObj)
{


  if ((carObj->carFlags & 0x800) || carObj->N.simOptz == 0 || ((carObj->carFlags & 0x20) && carObj->N.simOptz < 2U))
    return 1;

  return 0;
}

/* ---- AIPhysic_SimplePhysics__FP8Car_tObj ---- */
/* 2026-10-31: speed is set once (line 50 abs), the lane-change product is stored straight to
   linearVel_ch.x: retail SYM speed REG $5 and the sched1 birthing order (speed REG_N_SETS==1). */
#line 756 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_SimplePhysics(Car_tObj *carObj)
{
  coorddef forward;
  coorddef right;
  int speed; int sliceLookAhead; if ((carObj->AIFlags & 0x10U) != 0) {

    carObj->rampDesiredLatPos = carObj->roadPosition;
    carObj->AIFlags = carObj->AIFlags & 0xffffffef;
  }

  if (((carObj->carFlags & 8U) != 0) && (simGlobal.gameTicks > carObj->wipeOutStartTick))
  {
    int curve = AIDataRecord_TrackCurve_Get(AIDataRecord_TrackCurve,(int)(carObj->N).simRoadInfo.slice);




    if ((0x1e < curve) && (0x1638e3 < carObj->speed))
      carObj->wipeOutEndTick = simGlobal.gameTicks + 0x180;
  }


  AIPhysic_SimplePhysics_LongVel(carObj);
  AIPhysic_SimplePhysics_LatVel(carObj);


  forward = *(coorddef *)&(carObj->N).orientMat.m[6];
  right = *(coorddef *)&(carObj->N).roadMatrix.m[0];

  right.x = fixedmult(carObj->laneChangeSpeed,right.x); right.y = fixedmult(carObj->laneChangeSpeed,right.y); right.z = fixedmult(carObj->laneChangeSpeed,right.z);
  forward.x = fixedmult(carObj->currentSpeed * carObj->direction,forward.x); forward.y = fixedmult(carObj->currentSpeed * carObj->direction,forward.y); forward.z = fixedmult(carObj->currentSpeed * carObj->direction,forward.z);
  (carObj->N).linearVel.x = forward.x + right.x; (carObj->N).linearVel.y = forward.y + right.y; (carObj->N).linearVel.z = forward.z + right.z;


  (carObj->linearVel_ch).z = carObj->speed;
  (carObj->linearVel_ch).x = carObj->laneChangeSpeed * carObj->direction;

  if (__builtin_abs((carObj->linearVel_ch).x) / 256 * 0x19 < __builtin_abs((carObj->linearVel_ch).x))
    carObj->slide = 0x8000;
  else
    carObj->slide = 0;

  (carObj->N).angularVel.x = 0;
  (carObj->N).angularVel.y = 0;
  (carObj->N).angularVel.z = 0;



  if (0x30000 < carObj->speed)
    Newton_CopyRoadMatrixToOrientMat(&carObj->N,(u_int)(carObj->direction == -1));

  speed = __builtin_abs(carObj->currentSpeed);

  sliceLookAhead = speed / 0x60000;
  if (-1 < sliceLookAhead) { if ((sliceLookAhead < AIPhysicConfig.min_lookahead / 6) && (-1 < speed))
      sliceLookAhead = AIPhysicConfig.min_lookahead / 6; }
  if (AIPhysicConfig.max_lookahead / 6 < sliceLookAhead) sliceLookAhead = AIPhysicConfig.max_lookahead / 6;


  carObj->lookAheadSlice = (sliceLookAhead * carObj->direction >= 0) ? (((carObj->N).simRoadInfo.slice + sliceLookAhead * carObj->direction >= gNumSlices) ? (carObj->N).simRoadInfo.slice + sliceLookAhead * carObj->direction - gNumSlices : (carObj->N).simRoadInfo.slice + sliceLookAhead * carObj->direction) : (((carObj->N).simRoadInfo.slice + sliceLookAhead * carObj->direction < 0) ? ((carObj->N).simRoadInfo.slice + sliceLookAhead * carObj->direction) + gNumSlices : (carObj->N).simRoadInfo.slice + sliceLookAhead * carObj->direction);
}

/* ---- AIPhysic_SimplePhysics_LongVel__FP8Car_tObj ---- */
#line 824 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_SimplePhysics_LongVel(Car_tObj *carObj)
{
  int acceleration;
  int deceleration;




  acceleration = AIPhysic_CalcAcceleration(carObj,carObj->currentSpeed);
  deceleration = AIPhysic_CalcDeceleration(carObj);

  if (carObj->pullOver != 0)


    carObj->desiredSpeed = 0;


  if (simGlobal.gameTicks < carObj->wipeOutEndTick)


    carObj->desiredSpeed = carObj->desiredSpeed / 4;


  if (carObj->direction == -1) {

    if ((carObj->desiredSpeed > carObj->currentSpeed) || (carObj->desiredDirection != -1)) {



      (carObj->linearAcc_ch).z = deceleration; if ((carObj->control).brakeLevel + AIPhysic_elapsedTime * 4 < 0xff) { (carObj->control).brakeLevel = (carObj->control).brakeLevel + AIPhysic_elapsedTime * 4; } else { (carObj->control).brakeLevel = 0xff; } if (3U < (u_char)(carObj->control).brakeLevel) { (carObj->control).desiredBrakeLevel = 1; }
      carObj->currentSpeed = carObj->currentSpeed + deceleration / 256 * (AIPhysic_iTime / 256);
      if (carObj->direction != carObj->desiredDirection) return;
      carObj->currentSpeed = (carObj->currentSpeed > carObj->desiredSpeed) ? carObj->desiredSpeed : carObj->currentSpeed;
    }
    else {

      carObj->currentSpeed -= acceleration / 256 * (AIPhysic_iTime / 256);

      if (AIPhysic_elapsedTime < (carObj->control).brakeLevel) { (carObj->control).brakeLevel = (carObj->control).brakeLevel - AIPhysic_elapsedTime; } else { (carObj->control).brakeLevel = 0; } if ((carObj->control).brakeLevel == 0) { (carObj->control).desiredBrakeLevel = 0; }
      (carObj->linearAcc_ch).z = acceleration;
      if (carObj->currentSpeed < carObj->desiredSpeed)
        carObj->currentSpeed = carObj->desiredSpeed;
    }
  }
  else {



    if ((carObj->desiredSpeed < carObj->currentSpeed) || (carObj->direction != carObj->desiredDirection)) {



      (carObj->linearAcc_ch).z = deceleration; if ((carObj->control).brakeLevel + AIPhysic_elapsedTime * 4 < 0xff) { (carObj->control).brakeLevel = (carObj->control).brakeLevel + AIPhysic_elapsedTime * 4; } else { (carObj->control).brakeLevel = 0xff; } if (3U < (u_char)(carObj->control).brakeLevel) { (carObj->control).desiredBrakeLevel = 1; }
      carObj->currentSpeed = carObj->currentSpeed - deceleration / 256 * (AIPhysic_iTime / 256);
      if (carObj->direction != carObj->desiredDirection) return;
      carObj->currentSpeed = MAX(carObj->currentSpeed,carObj->desiredSpeed);
    }
    else {


      carObj->currentSpeed += acceleration / 256 * (AIPhysic_iTime / 256);

      if (AIPhysic_elapsedTime < (carObj->control).brakeLevel) { (carObj->control).brakeLevel = (carObj->control).brakeLevel - AIPhysic_elapsedTime; } else { (carObj->control).brakeLevel = 0; } if ((carObj->control).brakeLevel == 0) { (carObj->control).desiredBrakeLevel = 0; }
      (carObj->linearAcc_ch).z = acceleration;
      if (carObj->currentSpeed > carObj->desiredSpeed)
        carObj->currentSpeed = carObj->desiredSpeed; } } }

/* ---- AIPhysic_SimplePhysics_LatVel__FP8Car_tObj  (3-axis fixedmult or clamp to ±abs(latVel)) ----
 * [MATCHED 100% (73/73), pin-free]. Three levers: (1) STRUCT-COPY for the fixedmult setup
 * (`vals = *(coorddef*)&car->0x144`); (2) EXPLICIT `else s0 = 0;` (not `int s0=0;` up top) —
 * lands the 0 in the beqz DELAY SLOT and splits x568's live-range to $v1+reload; (3) 🔑 the
 * clamp uses `__builtin_abs(v)` — the SAME lever that sealed CalculateGear. The earlier 6-diff
 * residual was the clamp-abs coalescing (a hand-rolled `absV=v; if(v<0)absV=-absV;` collapses
 * the copy); __builtin_abs forces the oracle's keep-v-then-copy-then-negate form. NOT a
 * permuter/decomp.me wall after all — it was the abs-idiom (cross-ref CalculateGear note). */
#line 901 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_SimplePhysics_LatVel(Car_tObj *carObj)
{
    int off;
    coorddef right;





    if (0x30000 < carObj->speed)
        off = carObj->rampDesiredLatPos - carObj->roadPosition;
    else
        off = 0;


    if (0x190000 < carObj->speed)
    {
        right = *(coorddef *)&carObj->N.roadMatrix;
        right.x = fixedmult(off, right.x); right.y = fixedmult(off, right.y); right.z = fixedmult(off, right.z);

        carObj->N.position.x += right.x; carObj->N.position.y += right.y; carObj->N.position.z += right.z;
        carObj->laneChangeSpeed = 0;
    }
    else
    {
        int carSpeed;
        carSpeed = __builtin_abs(carObj->currentSpeed);

        carObj->laneChangeSpeed = off; if (off < -carSpeed)
            carObj->laneChangeSpeed = -carSpeed;
        else if (carSpeed < off)
            carObj->laneChangeSpeed = carSpeed;
    }
}

/* ---- AIPhysic_CoolPhysics__FP8Car_tObj  (per-frame physics sequencer) ---- */
#line 958 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_CoolPhysics(Car_tObj *carObj)
{
    carObj->AIFlags |= 0x10;


    AIPhysic_HandleDirection(carObj);


    if (carObj->direction * carObj->currentSpeed < 0 && carObj->driveDirection != -1)
        carObj->rampDesiredLatPos = 0;



    if (AIPhysic_HitWallCheck(carObj))
        AIPhysic_ChangeDirection(carObj, 0x40);


    AIPhysic_Preperation(carObj);

    if (AIPhysic_CheckIfOutOfControl(carObj))
    {
        AIPhysic_OutOfControlPhysics(carObj);
    }
    else
    {
        AIPhysic_InControlPhysics(carObj);
    }

    AIPhysic_FinishUp(carObj);
}

/* ---- AIPhysic_HandleDirection__FP8Car_tObj  (register-only; D_8011E0B0 == &simGlobal.gameTicks) ----
 * [MATCHED 100% (58/58), pin-free]. The lone residual `lui v0,%hi` (a reorg delay-slot fill on
 * the D_8011E0B0 address materialization) was NOT a reorg wall — it was the scalar-vs-array shape:
 * declaring D_8011E0B0 as an UNSIZED ARRAY (`extern int D_8011E0B0[]`, access `[0] - 0x18`) changed
 * the address-materialization so gcc duplicates the `%hi` into the `bgtz` delay slot exactly as the
 * oracle (§3.12#5; same lever that fixed HandleWipeoutTimer). D_8011E0B0 == &simGlobal.gameTicks. */
#line 995 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_HandleDirection(Car_tObj *carObj)
{


    if (carObj->driveDirection == -1) {



    if ((carObj->roadPosition < carObj->rampDesiredLatPos - 0xA0000 && carObj->lateralVelocity > 0) || (carObj->rampDesiredLatPos + 0xA0000 < carObj->roadPosition && carObj->lateralVelocity < 0))

        carObj->driveDirectionTimer = simGlobal.gameTicks - 0x18;


    if (carObj->driveDirectionReverseTime < simGlobal.gameTicks - carObj->driveDirectionTimer) {

        carObj->driveDirection = 1;
        carObj->driveDirectionTimer = simGlobal.gameTicks;
    }

    if (0x140000 < carObj->desiredSpeed) carObj->desiredSpeed = 0x140000;
    if (0x140000 < -carObj->desiredSpeed) carObj->desiredSpeed = (int)0xFFEC0000;

    carObj->rampDesiredLatPos = 0;
    }
}

/* ---- AIPhysic_Preperation__FP8Car_tObj ---- */
#line 1025 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_Preperation(Car_tObj *carObj)
{
  coorddef forward;
  int aCar;
  int aCarWRTDesired;
  int aDesired;






  (carObj->linearVel_ch).x = fixedmult((carObj->N).linearVel.x,(carObj->N).orientMat.m[0]) + fixedmult((carObj->N).linearVel.y,(carObj->N).orientMat.m[1]) + fixedmult((carObj->N).linearVel.z,(carObj->N).orientMat.m[2]);
  (carObj->linearVel_ch).y = fixedmult((carObj->N).linearVel.x,(carObj->N).orientMat.m[3]) + fixedmult((carObj->N).linearVel.y,(carObj->N).orientMat.m[4]) + fixedmult((carObj->N).linearVel.z,(carObj->N).orientMat.m[5]);
  (carObj->linearVel_ch).z = fixedmult((carObj->N).linearVel.x,(carObj->N).orientMat.m[6]) + fixedmult((carObj->N).linearVel.y,(carObj->N).orientMat.m[7]) + fixedmult((carObj->N).linearVel.z,(carObj->N).orientMat.m[8]);

  (carObj->angularVel_ch).x = fixedmult((carObj->N).angularVel.x,(carObj->N).orientMat.m[0]) + fixedmult((carObj->N).angularVel.y,(carObj->N).orientMat.m[1]) + fixedmult((carObj->N).angularVel.z,(carObj->N).orientMat.m[2]);
  (carObj->angularVel_ch).y = fixedmult((carObj->N).angularVel.x,(carObj->N).orientMat.m[3]) + fixedmult((carObj->N).angularVel.y,(carObj->N).orientMat.m[4]) + fixedmult((carObj->N).angularVel.z,(carObj->N).orientMat.m[5]);
  (carObj->angularVel_ch).z = fixedmult((carObj->N).angularVel.x,(carObj->N).orientMat.m[6]) + fixedmult((carObj->N).angularVel.y,(carObj->N).orientMat.m[7]) + fixedmult((carObj->N).angularVel.z,(carObj->N).orientMat.m[8]);

  if (__builtin_abs((carObj->linearVel_ch).x) / 256 * 0x19 < __builtin_abs((carObj->linearVel_ch).x))
    carObj->slide = 0x8000;
  else
    carObj->slide = 0;



  forward = *(coorddef *)&(carObj->N).orientMat.m[6];
  if (carObj->driveDirection == 1)
    aCar = intatan(forward.x,forward.z);
  else
    aCar = intatan(-forward.x,-forward.z);


  carObj->aCar = aCar;

  AIPhysic_GetDesiredVector(carObj);


  aDesired = intatan((carObj->desiredVector).x,(carObj->desiredVector).z);
  aCarWRTDesired = aCar - aDesired;
  if (aCarWRTDesired < -0x200) { carObj->aCarWRTDesired = aCarWRTDesired + 0x400; } else { carObj->aCarWRTDesired = aCarWRTDesired; if (!(aCarWRTDesired < 0x201)) { carObj->aCarWRTDesired = aCarWRTDesired + -0x400; } }
  carObj->aDesired = aDesired;
}

/* ---- AIPhysic_CalculateRoadPosition__FP8coorddefi  (leaf: dot(pos-sliceCenter, sliceRight)/256^2) ---- */
/* 2026-10-31: the dot product is stored into the dead parameter `slice` and returned on the
   closing line: retail tags the final mflo/addu/epilogue with the `}` line (14), fn end 14. */
#line 1074 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
int AIPhysic_CalculateRoadPosition(coorddef *pos, int slice)
{
    coorddef centerBack;
    coorddef carRelative;
    coorddef right;


    centerBack = *(coorddef *)BWorldSm_slices[slice].center;
    carRelative.x = pos->x - centerBack.x; carRelative.y = pos->y - centerBack.y; carRelative.z = pos->z - centerBack.z;
    right.x = (signed char)BWorldSm_slices[slice].right[0] << 9;
    right.y = (signed char)BWorldSm_slices[slice].right[1] << 9;
    right.z = (signed char)BWorldSm_slices[slice].right[2] << 9;

    slice = (right.x / 256) * (carRelative.x / 256) + (right.y / 256) * (carRelative.y / 256) + (right.z / 256) * (carRelative.z / 256);

    return slice; }

/* ---- AIPhysic_GetDesiredVector__FP8Car_tObj ---- */
#line 1098 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_GetDesiredVector(Car_tObj *carObj)
{










    int speed; int roadWidth; int sliceLookAhead; int dirCorrectedSliceLookAhead; coorddef fCPoint; coorddef fPoint; coorddef right; int futureBend; int futureRoadPosition; int numReductions; int goodVector; int thisSlice; thisSlice = (int)(carObj->N).simRoadInfo.slice;

    numReductions = 0; if ((((carObj->targetPos).x != 0) || ((carObj->targetPos).y != 0)) || ((carObj->targetPos).z != 0) ) {

    AIPhysic_TargetedGetDesiredVector(carObj);
    return; }





    speed = __builtin_abs(carObj->currentSpeed);




    sliceLookAhead = fixedmult(speed,0xb333);
    sliceLookAhead = (sliceLookAhead + 0x30000) / 0x60000;


    if (((-1 < sliceLookAhead) && (sliceLookAhead < AIPhysicConfig.min_lookahead / 6)) && (-1 < speed)) {
    sliceLookAhead = AIPhysicConfig.min_lookahead / 6; }
    sliceLookAhead = (AIPhysicConfig.max_lookahead / 6 < sliceLookAhead) ? AIPhysicConfig.max_lookahead / 6 : sliceLookAhead;


    dirCorrectedSliceLookAhead = sliceLookAhead * carObj->driveDirection * carObj->direction;


    carObj->lookAheadSlice = (dirCorrectedSliceLookAhead >= 0) ? ((thisSlice + dirCorrectedSliceLookAhead >= gNumSlices) ? thisSlice + dirCorrectedSliceLookAhead - gNumSlices : thisSlice + dirCorrectedSliceLookAhead) : ((thisSlice + dirCorrectedSliceLookAhead < 0) ? (thisSlice + dirCorrectedSliceLookAhead) + gNumSlices : thisSlice + dirCorrectedSliceLookAhead);

    futureBend = AIWorld_CalcRoadBend(carObj,dirCorrectedSliceLookAhead);
    futureBend = __builtin_abs(futureBend);





    roadWidth = (u_int)(BWorldSm_slices[carObj->lookAheadSlice].avgPavedWidthLf << 15) * (u_int)(BWorldSm_slices[carObj->lookAheadSlice].laneCount >> 4) + (u_int)(BWorldSm_slices[carObj->lookAheadSlice].avgPavedWidthRt << 15) * (BWorldSm_slices[carObj->lookAheadSlice].laneCount & 0xf);






    if (roadWidth < 0x120000) {

    if (0xf333 < futureBend) {





    sliceLookAhead = sliceLookAhead * 0xca3d / 0x10000; }

    if (0xe666 < futureBend) {




    sliceLookAhead = sliceLookAhead * 0xd70a / 0x10000; }

    else if (0xcccc < futureBend) {




    sliceLookAhead = sliceLookAhead * 0xe666 / 0x10000; }

    else if (0xc000 < futureBend) {




    sliceLookAhead = sliceLookAhead * 0xf333 / 0x10000; } }








    do {

    dirCorrectedSliceLookAhead = sliceLookAhead * carObj->driveDirection * carObj->direction;

    carObj->lookAheadSlice = (dirCorrectedSliceLookAhead >= 0) ? ((thisSlice + dirCorrectedSliceLookAhead >= gNumSlices) ? thisSlice + dirCorrectedSliceLookAhead - gNumSlices : thisSlice + dirCorrectedSliceLookAhead) : ((thisSlice + dirCorrectedSliceLookAhead < 0) ? (thisSlice + dirCorrectedSliceLookAhead) + gNumSlices : thisSlice + dirCorrectedSliceLookAhead);


    fCPoint = *(coorddef *)BWorldSm_slices[carObj->lookAheadSlice].center;


    right.x = (int)(signed char)BWorldSm_slices[carObj->lookAheadSlice].right[0] << 9;
    right.y = (int)(signed char)BWorldSm_slices[carObj->lookAheadSlice].right[1] << 9;
    right.z = (int)(signed char)BWorldSm_slices[carObj->lookAheadSlice].right[2] << 9;



    fPoint.x = fixedmult(carObj->rampDesiredLatPos,right.x), fPoint.y = fixedmult(carObj->rampDesiredLatPos,right.y), fPoint.z = fixedmult(carObj->rampDesiredLatPos,right.z);
    fPoint.x = fPoint.x + fCPoint.x, fPoint.y = fPoint.y + fCPoint.y, fPoint.z = fPoint.z + fCPoint.z;

    futureRoadPosition = AIPhysic_CalculateRoadPosition(&fPoint,thisSlice);


    if ((((int)((u_int)(BWorldSm_slices[thisSlice].avgPavedWidthRt << 15) * (BWorldSm_slices[thisSlice].laneCount & 0xf)) < futureRoadPosition) && (carObj->roadPosition < futureRoadPosition)) || ((futureRoadPosition < (int)-((u_int)(BWorldSm_slices[thisSlice].avgPavedWidthLf << 15) * (u_int)(BWorldSm_slices[thisSlice].laneCount >> 4))) && (futureRoadPosition < carObj->roadPosition)))
    {




    int checkSide; checkSide = 1; if (futureRoadPosition < carObj->roadPosition) {
    checkSide = -1; }


    goodVector = carObj->roadPosition + checkSide * 0x80000;
    goodVector = AIWorld_LaneIndex(thisSlice,goodVector);
    if (AIWorld_IsDriveableLane(thisSlice,goodVector) != 0) {

    goodVector = carObj->roadPosition + checkSide * 0x40000;
    goodVector = AIWorld_LaneIndex(thisSlice,goodVector);
    goodVector = AIWorld_IsDriveableLane(thisSlice,goodVector);











    goodVector = goodVector != 0; }








    else { goodVector = 0; } }




    else { goodVector = 1; }



    numReductions = numReductions + 1;
    sliceLookAhead = sliceLookAhead * 0xcccc;
    sliceLookAhead = sliceLookAhead / 0x10000;
    sliceLookAhead = MAX(4,sliceLookAhead);

    } while ((numReductions < 5) && (goodVector == 0));




    (carObj->desiredVector).x = fPoint.x - (carObj->N).position.x, (carObj->desiredVector).y = fPoint.y - (carObj->N).position.y, (carObj->desiredVector).z = fPoint.z - (carObj->N).position.z;

}

/* ---- AIPhysic_TargetedGetDesiredVector__FP8Car_tObj  (desiredVector = targetPos - position) ---- */
#line 1274 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_TargetedGetDesiredVector(Car_tObj *carObj)
{


    carObj->desiredVector.x = carObj->targetPos.x - carObj->N.position.x; carObj->desiredVector.y = carObj->targetPos.y - carObj->N.position.y; carObj->desiredVector.z = carObj->targetPos.z - carObj->N.position.z;




    carObj->rampDesiredLatPos = carObj->targetLatPos;
}

/* ---- AIPhysic_CheckIfOutOfControl__FP8Car_tObj ---- */
/* PHYS 2026-10-31 SLD layout: retail tags the whole goto test chain on line 1312
   (one physical line here), the shared ret1 `return 1` on 1325 and ret0 on 1333;
   the wipe-out arm is if/return 0 + return 1 on separate lines (jump folds it to the
   retail xori). abs uses __builtin_abs (single bgez/negu macro). Gaps left blank. */
#line 1290 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
int AIPhysic_CheckIfOutOfControl(Car_tObj *carObj)
{
  int futureBend; futureBend = AIWorld_CalcRoadBend(carObj,carObj->direction << 3);

  futureBend = __builtin_abs(futureBend);



  if (simGlobal.gameTicks < carObj->wipeOutEndTick) {

    if (0x2ffff < __builtin_abs(carObj->currentSpeed))
      return 0;

    return 1;
  }







  if ((__builtin_abs(carObj->aCarWRTDesired) < 0x74) && (carObj->driveDirection != -1)) { if (__builtin_abs(carObj->currentSpeed) < AIPhysicConfig.OOCModel.vel_limit_range + -0x30000) { goto ret1; } if (carObj->roadPosition < (int)-((u_int)(BWorldSm_slices[(carObj->N).simRoadInfo.slice].avgPavedWidthLf << 15) * (u_int)(BWorldSm_slices[(carObj->N).simRoadInfo.slice].laneCount >> 4))) { goto ret1; } if ((int)((u_int)(BWorldSm_slices[(carObj->N).simRoadInfo.slice].avgPavedWidthRt << 15) * (u_int)(BWorldSm_slices[(carObj->N).simRoadInfo.slice].laneCount & 0xf)) < carObj->roadPosition) { goto ret1; } if (0xcccc < futureBend) { goto ret1; } if (__builtin_abs((carObj->linearVel_ch).x) <= carObj->speed / 256 * 0x66) { goto ret0; } if (0xeffff < __builtin_abs(carObj->currentSpeed)) { goto ret0; } }











ret1:
  return 1;






ret0:
  return 0;
}

/* 2026-10-31: no asm, no cfg/latvelcalcLookahead carriers; all14 retail locals and registers.
 * FENCE DEBT (pure-C cse1 skip-blocks barrier): the redundant `else uTurn = 0;` gives the
 * join label a second use so cse1 stops there; retail's real construct is still unknown.
 * Equivalent evidence (same mechanism, also PASS 0/412): the ternary
 * `uTurn = cond ? (carObj->driveDirection != -1) : 0;` and the inverted if/else.
 * Mechanism: the else-jump stops cse1 at the join,
 * so the line-20 full AIPhysicConfig address dies there and cse2 (after the jump pass drops
 * the empty else) reuses only the %hi register, building the full address at line 34 as
 * retail does. vel_limit_range and the two velocity differences go through dead SYM locals
 * (latVelLimit, maxAngVel, maxLatVel) on their retail lines 45/72/80. */
/* ---- AIPhysic_OutOfControlPhysics__FP8Car_tObj ---- */
#line 1350 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_OutOfControlPhysics(Car_tObj *carObj)
{






    int desiredAngVel; int desiredLatVel; int currentAngAcc; int currentLatAcc; int currentLongAcc; int maxLatVel; int maxAngVel; int skid; int dir; int currentLatVel; int latVelLimit; int targetVel; int uTurn; int currentVel; dir = carObj->direction;







    carObj->drag = 0;




    uTurn = 0; currentLatVel = AIWorld_CalcFutureLateralVel(carObj, dir * AIPhysicConfig.latvelcalc_lookahead);


    if (carObj->direction * carObj->currentSpeed < 0) { uTurn = carObj->driveDirection != -1; } else uTurn = 0;



    carObj->wipeOutEndTick = simGlobal.gameTicks;






    desiredAngVel = -carObj->aCarWRTDesired * fixedmult(0x80,AIPhysicConfig.OOCModel.dangle_to_dav);
    desiredAngVel = (desiredAngVel < AIPhysicConfig.OOCModel.max_dav) ? desiredAngVel : AIPhysicConfig.OOCModel.max_dav;
    desiredAngVel = MAX(desiredAngVel,-AIPhysicConfig.OOCModel.max_dav);


    desiredLatVel = (desiredAngVel / 256) * 0xa00;
    desiredLatVel = (desiredLatVel < AIPhysicConfig.OOCModel.max_dlvel) ? desiredLatVel : AIPhysicConfig.OOCModel.max_dlvel;
    desiredLatVel = MAX(desiredLatVel,-AIPhysicConfig.OOCModel.max_dlvel);
    desiredLatVel = (desiredLatVel < carObj->speed) ? desiredLatVel : carObj->speed;
    desiredLatVel = MAX(desiredLatVel,-carObj->speed);

    latVelLimit = AIPhysicConfig.OOCModel.vel_limit_range;
    if ((-latVelLimit < carObj->currentSpeed) && (carObj->currentSpeed < latVelLimit)) {





    maxLatVel = (carObj->speed / 256) * (AIPhysicConfig.OOCModel.lat_vel_limit_factor / 256);
    maxLatVel = __builtin_abs(maxLatVel);
    latVelLimit = (desiredLatVel < maxLatVel) ? desiredLatVel : maxLatVel; desiredLatVel = latVelLimit;
    desiredLatVel = MAX(desiredLatVel,-maxLatVel);

    maxAngVel = (carObj->speed / 256) * (AIPhysicConfig.OOCModel.ang_vel_limit_factor / 256);
    maxAngVel = __builtin_abs(maxAngVel);
    desiredAngVel = (desiredAngVel < maxAngVel) ? desiredAngVel : maxAngVel;
    desiredAngVel = MAX(desiredAngVel,-maxAngVel); }








    if (carObj->donutMode == 2) {
    desiredAngVel = desiredAngVel * 5; }

    maxAngVel = (carObj->angularVel_ch).y - desiredAngVel;
    currentAngAcc = -((maxAngVel / 256) * (AIPhysicConfig.OOCModel.dav_to_aa / 256));
    if (0x120000 < __builtin_abs(carObj->currentSpeed)) {
    currentAngAcc = currentAngAcc / 2; }
    currentAngAcc = (currentAngAcc < carObj->max_aa) ? currentAngAcc : carObj->max_aa;
    currentAngAcc = MAX(currentAngAcc,-carObj->max_aa);


    maxLatVel = (carObj->linearVel_ch).x - desiredLatVel;
    currentLatAcc = -((maxLatVel / 256) * (AIPhysicConfig.OOCModel.dlvel_to_clacc / 256));
    currentLatAcc = (currentLatAcc < carObj->max_clacc) ? currentLatAcc : carObj->max_clacc;
    currentLatAcc = MAX(currentLatAcc,-carObj->max_clacc);






    currentVel = (carObj->linearVel_ch).z;

    if (((carObj->driveDirection == -1) && ((carObj->targetPos).x == 0)) && ((carObj->targetPos).y == 0) && ((carObj->targetPos).z == 0)) {
    targetVel = -AIPhysicConfig.OOCModel.vel_limit_range; }

    else { targetVel = carObj->desiredSpeed * carObj->direction * carObj->driveDirection; }





    if (carObj->pullOver == 0 && (-1 < targetVel ? (!(currentVel < -0x20000) && currentVel <= targetVel) : (targetVel <= currentVel && currentVel < 0x20001)) && carObj->desiredDirection == carObj->direction) {


    currentLongAcc = AIPhysic_CalcAcceleration(carObj,(carObj->linearVel_ch).z) * carObj->driveDirection;
    if (AIPhysic_elapsedTime < (carObj->control).brakeLevel) { (carObj->control).brakeLevel = (carObj->control).brakeLevel - AIPhysic_elapsedTime; } else { (carObj->control).brakeLevel = 0; } if ((carObj->control).brakeLevel == 0) { (carObj->control).desiredBrakeLevel = 0; }


    } else { currentLongAcc = 0; if (0 < __builtin_abs((carObj->linearVel_ch).z)) {

    currentLongAcc = -AIPhysic_CalcDeceleration(carObj);

    if ((carObj->control).brakeLevel + AIPhysic_elapsedTime * 4 < 0xff) { (carObj->control).brakeLevel = (carObj->control).brakeLevel + AIPhysic_elapsedTime * 4; } else { (carObj->control).brakeLevel = 0xff; } if (3 < (u_char)(carObj->control).brakeLevel) { (carObj->control).desiredBrakeLevel = 1; }
    if ((carObj->linearVel_ch).z < 0) {

    currentLongAcc = -currentLongAcc; } } }








    if (uTurn != 0) {

    if (carObj->speed - 0x140001U < 0x1dffff) {

    currentAngAcc = currentAngAcc / 4;
    currentLongAcc = currentLongAcc / 4; }



    else { currentAngAcc = fixedmult(currentAngAcc,0xc000);
    currentLongAcc = currentLongAcc / 2 + currentLongAcc / 4; }

    currentLatAcc = currentLatAcc / 4 + currentLatAcc / 8; }



    skid = __builtin_abs(currentLatVel) - AIPhysicConfig.skid_value;
    if (((carObj->direction * carObj->currentSpeed < 0) && (0x38e38 < carObj->speed)) || (carObj->donutMode != 0)) {

    carObj->frontSkid = 0xa0000;
    carObj->rearSkid = 0xa0000; }

    else if (0 < skid) {

    carObj->frontSkid = skid;
    carObj->rearSkid = skid;



    } else { carObj->rearSkid = 0; carObj->frontSkid = 0; }


    (carObj->linearAcc_ch).x = currentLatAcc;
    (carObj->linearAcc_ch).y = 0;
    (carObj->linearAcc_ch).z = currentLongAcc;

    (carObj->linearAcc_rh).x = 0;
    (carObj->linearAcc_rh).y = 0;
    (carObj->linearAcc_rh).z = 0;

    (carObj->angularAcc).x = 0;
    (carObj->angularAcc).y = currentAngAcc;
    (carObj->angularAcc).z = 0; return;
}

/* ---- AIPhysic_GetRearEndDamageFactor__FP8Car_tObj  [MATCHED 100% (22/22), pin-free] ----
 * 🏆 The "permuter-confirmed unbeatable v0/v1 coin-flip" was WRONG — it was fully source-reachable
 * via THREE structural insights (cross-ref SYM nfs4-f-v3.txt defs + SLD lines + disasm-v4):
 * 1. ARRAY ACCESS: the summed fields are `N.damage[10]` @0x218 → damage[4]/[5]/[6]/[9] (NOT opaque
 *    offsets). SLD puts one term per line (1572-1575) = an unrolled sum.
 * 2. `+=` ACCUMULATION (each term its OWN statement, not one `a+b+c+d` expr): makes totalDamage's
 *    lifetime start at damage[4], so the sum accumulates IN totalDamage ($v1) and the fixedmult
 *    result moves back into it (`move v1,v0`) — exactly the SYM's `totalDamage REG $3`. The single-
 *    expression form let gcc coalesce the (anonymous) sum into $v0 (the 17-diff near-miss).
 * 3. BOUND-FIRST conditional expression: `0x10000 < totalDamage ? 0x10000 : totalDamage`
 *    preserves the oracle's anonymous $a0 clamp-result funnel and scratch copy without
 *    inventing a named result local (retail names only totalDamage). Operand/arm order
 *    matters to GCC's MIN_EXPR expansion; the other measured ternary had 21 diffs.
 * 24→0. META: a "permuter plateau" (it stalled at 115) does NOT mean unbeatable — the permuter
 * can't restructure a sum-expr into +=-accumulation or change scalar→array access. Re-derive the
 * SYM's variable/type structure first. CANONICAL 100% scratch: https://decomp.me/scratch/JS0Q0
 * (Caesar0007 spotted the array + the missing decl; Mc-muffin / Ethanol @ Discord, github.com/Mc-muffin, cracked the last-stage clamp form.) */
#line 1569 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
int AIPhysic_GetRearEndDamageFactor(Car_tObj *carObj)
{
    int totalDamage;
    totalDamage = carObj->N.damage[4];
    totalDamage += carObj->N.damage[5];
    totalDamage += carObj->N.damage[6];
    totalDamage += carObj->N.damage[9];



    totalDamage = fixedmult(totalDamage, 0x147);


    totalDamage = 0x10000 < totalDamage ? 0x10000 : totalDamage;

    return totalDamage;
}

/* 2026-10-27 source receipt: the real upper-then-lower desiredLatVel
 * clamp (also in the matched NFS2 sibling) replaces the empty asm keep-alive.
 * Whole normal ELF/native CPE,all557 words,locals/owners and prior SLD facts
 * are unchanged. Dropping the clamp or either half alone fails;the coupled
 * source graph matters. No invented use,object,name or replacement fence.
 * Full covered SLD is now exact;original literal macro spelling remains open.
 * Receipt:build/nc12/aiphysic_ic_clamp_20261027/. */

/* ---- AIPhysic_InControlPhysics__FP8Car_tObj ---- */
/* 2026-10-27: all557 word/file tags,14 block records,end1873 and
 * every complete supplied local/owner/frame/header now match retail. Real
 * flag-reset order,grip offset-before-scale,split fishtail guards and
 * currentAngAcc difference-before-product restore source phases without
 * new objects,asm/volatile,scope padding or statement anchors. Equivalent
 * initialization/lower-clamp spellings pass too;literal text is not unique.
 * Receipt:build/nc12/aiphysic_ic_sld_20261027/. */
/* Rule-8 rewrite w13-a4: SYM 8c block @0x8006BAC8 (fsize 0x70, mask $c0ff0000, carObj REGPARM $s2).
   * Statics: copCollisionReactionTime @0x8013C590 (BSS), copCollisionGripLoss @0x8010DC54,
   * copCollisionSlowDown @0x8010DC64 (.data). All named locals per SYM AUTO/REG records. */
/* Retail initial values (image @0x8013C590 / @0x8010DC54 / @0x8010DC64): initialized
   * function statics are emitted when this function compiles, which puts the two int
   * tables at the head of AIPHYSIC.obj's .data (before the deferred AIPhysicConfig) and
   * the reaction-time table in .sdata -- exactly the retail layout. */
/* Historical w17 near-miss: 4 diffs at 557/557, superseded by current PASS.
     The earlier report observed that oracle defers
     the `gripMultiplier = 0;` materialization into $s0 by COPYING the already-zero $s7
     (from the immediately-preceding `maxAngularAcceleration = 0;`) into the __builtin_abs()
     bgez delay slot; ours materializes a fresh literal directly into $s0 but the gcc
     scheduler instead places it one branch later (the vely-clamp bnez slot) -- same net
     effect, different delay-slot choice. Tried: `gripMultiplier = maxAngularAcceleration;`
     (explicit copy instead of literal 0) and reordering the statement relative to the
     `vely = angularVel.y` read -- neither moved that basin's slot choice.
     These finite trials did not establish a source floor. Current byte/native
     gates pass; the fence is now removed by the complete two-stage clamp;
     the following full SLD round supersedes that partial map;original
     macro spelling remains unproved. */
/* Owning AIPHYSIC.obj SYM11308f: AIPerson_t::fishtailAngle is INT at+0x2c;
 * SYM11550a: Car_tObj::personality is AIPerson_t* at+0x4f0. Typed accesses
 * replace both byte-offset views with the whole native dump/object unchanged.
 * Receipt:build/nc12/aiphysic_personality_field_20261027/. */
#line 1603 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_InControlPhysics(Car_tObj *carObj)
{
  static char copCollisionReactionTime[4] = { (char)0x8c, 0x64, 0x50, 0x3c };
  static int copCollisionGripLoss[4] = { 0x4ccc, 0x8000, 0x8000, 0x10000 };
  static int copCollisionSlowDown[4] = { 0x90000, 0x84000, 0x70000, 0x5c000 };
 int currentLatVel; int currentLatPos; int desiredLatPos; int deltaLatPos;
 int desiredAngVel; int currentAngAcc; int desiredLatVel; int currentLatAcc;
 int currentLongAcc; int maxAngularAcceleration; int angleWRTdesired; int skid;
 int dir; int gripMultiplier; int maxLateralAcceleration; int dlvel_to_clacc;
 int desiredSpeed; int justBumped; coorddef unitDesiredVector; coorddef unitDesiredVectorRight;
 int lastCollisionTickDiff; int copCollisionFirmness;



 dir = carObj->direction;

  skid = 0;
  justBumped = 0;




 carObj->drag = 0;







 unitDesiredVector = carObj->desiredVector;
 Math_QDNormalizeVector(&unitDesiredVector);
 unitDesiredVectorRight.x = unitDesiredVector.z;
 unitDesiredVectorRight.y = unitDesiredVector.y;
 unitDesiredVectorRight.z = -unitDesiredVector.x;


currentLatVel = (fixedmult((carObj->N).linearVel.x,unitDesiredVectorRight.x) + fixedmult((carObj->N).linearVel.y,unitDesiredVectorRight.y) + fixedmult((carObj->N).linearVel.z,unitDesiredVectorRight.z)) * carObj->direction;












 currentLatPos = carObj->roadPosition;


 desiredLatPos = carObj->rampDesiredLatPos;


 deltaLatPos = currentLatPos - desiredLatPos;

 maxAngularAcceleration = carObj->max_aa;


 gripMultiplier = fixedmult((carObj->linearVel_ch).z,0x62) + 0x10000;
 gripMultiplier = fixedmult(gripMultiplier,carObj->gripFactor);

 if ((carObj->carFlags & 8U) != 0) { if (simGlobal.gameTicks > carObj->wipeOutStartTick) {





 if ((1000 < __builtin_abs((carObj->N).angularVel.y)) && (0x1638e3 < carObj->speed)) {
 carObj->wipeOutEndTick = simGlobal.gameTicks + 0x180;
 } } }

 lastCollisionTickDiff = simGlobal.gameTicks - (carObj->N).collision.lastTime;
  if (
    (AIScript_DoReAction(&carObj->script,(AIScript_tAIReaction)0x800) != -1) || (simGlobal.gameTicks < carObj->wipeOutEndTick))
  {
 int vely;
 if (simGlobal.gameTicks - (carObj->N).collision.lastTime < 0x40) {
 carObj->wipeOutEndTick = simGlobal.gameTicks;
 }
 maxAngularAcceleration = 0;

 vely = (carObj->N).angularVel.y; gripMultiplier = maxAngularAcceleration;
 if (vely < 0) { vely = -vely; }
 vely = vely + 0x1ca; if (0x3333 < vely) { vely = 0x3333; }
 if (0 < (carObj->N).angularVel.y) {
 (carObj->N).angularVel.y = vely;
 } else {
 (carObj->N).angularVel.y = -vely; }
 skid = 0xa0000;
 }


 copCollisionFirmness = GameSetup_gData.skill;







 if (lastCollisionTickDiff < 0x10) {
 carObj->wipeOutStartTick = carObj->wipeOutStartTick - 0x14;
 }
 if (((lastCollisionTickDiff < copCollisionReactionTime[copCollisionFirmness]) && ((carObj->N).collision.lastOtherObj != (BO_tNewtonObj *)0x0)) && ((((Car_tObj *)(carObj->N).collision.lastOtherObj)->carFlags & 0x200U) != 0)) {

 maxAngularAcceleration = 0;





 gripMultiplier = fixedmult(gripMultiplier,copCollisionGripLoss[copCollisionFirmness]);
 justBumped = 1;
 }

 maxLateralAcceleration = (carObj->max_clacc / 256) * (gripMultiplier / 256);

 dlvel_to_clacc = (AIPhysicConfig.ICModel.dlvel_to_clacc / 256) * (gripMultiplier / 256);

 if (0x10000 < carObj->aiGlue) {

 maxLateralAcceleration = (carObj->aiGlue / 256) * (maxLateralAcceleration / 256);
 dlvel_to_clacc = (carObj->aiGlue / 256) * (dlvel_to_clacc / 256);
 }


 desiredSpeed = carObj->desiredSpeed;





 angleWRTdesired = carObj->aCarWRTDesired;

 if (carObj->AIFishtailEndTick > simGlobal.gameTicks)
  {
    int fishtailtick; int signAngle; fishtailtick = carObj->AIFishtailEndTick - simGlobal.gameTicks;


    signAngle = 1;  if ((simGlobal.gameTicks / 0x28 & 1U) != 0) { signAngle = -1; }

 if (0x96 - fishtailtick < 0x32) {

 angleWRTdesired += (short)(signAngle * 0x1e) * (0x96 - fishtailtick) / 0x32;
 }
 else {
 angleWRTdesired += signAngle * (fishtailtick / 7 + 10);
 }
 if (0x32 < fishtailtick) {
 skid = (fishtailtick * 0x140000) / 0x32; }
 }
 else {
    if ((carObj->personality->fishtailAngle < __builtin_abs(angleWRTdesired)) && (0 < angleWRTdesired * (carObj->angularAcc).y)) {


      if (__builtin_abs(angleWRTdesired) << 0x10 > (0x10000 - AIPhysic_GetRearEndDamageFactor(carObj)) * 0x14 + (carObj->personality->fishtailAngle - 0x14) * 0x10000) {
 carObj->AIFishtailEndTick = simGlobal.gameTicks + 0x96;
      } } }




 desiredAngVel = -angleWRTdesired * fixedmult(0x80,AIPhysicConfig.ICModel.dangle_to_dav);
 desiredAngVel = (desiredAngVel < AIPhysicConfig.ICModel.max_dav) ? desiredAngVel : AIPhysicConfig.ICModel.max_dav;
 desiredAngVel = MAX(desiredAngVel,-AIPhysicConfig.ICModel.max_dav);




 desiredLatVel = -((deltaLatPos / 256) * (AIPhysicConfig.ICModel.dlpos_to_dlvel / 256));
 desiredLatVel = (desiredLatVel < AIPhysicConfig.ICModel.max_dlvel) ? desiredLatVel : AIPhysicConfig.ICModel.max_dlvel;
 desiredLatVel = MAX(desiredLatVel,-AIPhysicConfig.ICModel.max_dlvel);
 desiredLatVel = (desiredLatVel < carObj->speed) ? desiredLatVel : carObj->speed;
 desiredLatVel = MAX(desiredLatVel,-carObj->speed);




 if ((-AIPhysicConfig.ICModel.vel_limit_range < carObj->currentSpeed) && (carObj->currentSpeed < AIPhysicConfig.ICModel.vel_limit_range))
  {
 int maxLatVel; int maxAngVel;
 maxLatVel = (carObj->speed / 256) * (AIPhysicConfig.ICModel.lat_vel_limit_factor / 256);
 maxLatVel = __builtin_abs(maxLatVel);
 desiredLatVel = (desiredLatVel < maxLatVel) ? desiredLatVel : maxLatVel;
    desiredLatVel = MAX(desiredLatVel,-maxLatVel);

 maxAngVel = (carObj->speed / 256) * (AIPhysicConfig.ICModel.ang_vel_limit_factor / 256);
 maxAngVel = __builtin_abs(maxAngVel);
 desiredAngVel = (desiredAngVel < maxAngVel) ? desiredAngVel : maxAngVel;
 desiredAngVel = MAX(desiredAngVel,-maxAngVel);
 }









  currentAngAcc = (carObj->angularVel_ch).y - desiredAngVel;
  currentAngAcc = -fixedmult(currentAngAcc,AIPhysicConfig.ICModel.dav_to_aa);
 currentAngAcc = (currentAngAcc < maxAngularAcceleration) ? currentAngAcc : maxAngularAcceleration;
 currentAngAcc = MAX(currentAngAcc,-maxAngularAcceleration);



 currentLatAcc = -dir * fixedmult(currentLatVel,dlvel_to_clacc);
 currentLatAcc = (currentLatAcc < maxLateralAcceleration) ? currentLatAcc : maxLateralAcceleration;
 currentLatAcc = MAX(currentLatAcc,-maxLateralAcceleration);



 if (((desiredSpeed * dir > carObj->currentSpeed * dir) && (carObj->pullOver == 0)) && (carObj->desiredDirection == carObj->direction)) {

 currentLongAcc = AIPhysic_CalcAcceleration(carObj,carObj->currentSpeed);
 if (AIPhysic_elapsedTime < (carObj->control).brakeLevel) { (carObj->control).brakeLevel = (carObj->control).brakeLevel - AIPhysic_elapsedTime; } else { (carObj->control).brakeLevel = 0; } if ((carObj->control).brakeLevel == 0) { (carObj->control).desiredBrakeLevel = 0; }
 }
 else {

 currentLongAcc = -AIPhysic_CalcDeceleration(carObj);

 if ((carObj->control).brakeLevel + AIPhysic_elapsedTime * 4 < 0xff) { (carObj->control).brakeLevel = (carObj->control).brakeLevel + AIPhysic_elapsedTime * 4; } else { (carObj->control).brakeLevel = 0xff; } if (3 < (u_char)(carObj->control).brakeLevel) { (carObj->control).desiredBrakeLevel = 1; }
 if ((carObj->linearVel_ch).z < 0) {
 currentLongAcc = -currentLongAcc;
 }
 }

 if (justBumped != 0) {






 currentLongAcc = -copCollisionSlowDown[copCollisionFirmness];
 }


 if (skid == 0) {

 skid = __builtin_abs(currentLatVel) - AIPhysicConfig.skid_value;
 }

 if (0 < skid) {
 carObj->rearSkid = skid; carObj->frontSkid = skid;
 } else {
 carObj->rearSkid = 0; carObj->frontSkid = 0;
 }








 (carObj->linearAcc_ch).x = currentLatAcc;
 (carObj->linearAcc_ch).y = 0;
 (carObj->linearAcc_ch).z = currentLongAcc;
 (carObj->linearAcc_rh).x = 0;
 (carObj->linearAcc_rh).y = 0;
 (carObj->linearAcc_rh).z = 0;


 (carObj->angularAcc).x = 0;
 (carObj->angularAcc).y = currentAngAcc;
 (carObj->angularAcc).z = 0; return;
}


/* ---- AIPhysic_FinishUp__FP8Car_tObj ---- */
#line 1923 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_FinishUp(Car_tObj *carObj)
{
  coorddef angAcc;
  matrixtdef transOrientMat;
  matrixtdef transRoadMat;
  int tickLoop;


  (carObj->linearAcc_ch).z = (carObj->linearAcc_ch).z + (carObj->linearAcc_rh).z;
  Cars_DoGravityEffectsOnAcc(carObj,0);
  (carObj->linearAcc_ch).z = (carObj->linearAcc_ch).z - (carObj->linearAcc_rh).z;

  transpose(&(carObj->N).orientMat,&transOrientMat);
  transpose(&(carObj->N).roadMatrix,&transRoadMat);

  (carObj->linearAcc).x = fixedmult((carObj->linearAcc_ch).x,transOrientMat.m[0]) + fixedmult((carObj->linearAcc_ch).y,transOrientMat.m[1]) + fixedmult((carObj->linearAcc_ch).z,transOrientMat.m[2]);
  (carObj->linearAcc).y = fixedmult((carObj->linearAcc_ch).x,transOrientMat.m[3]) + fixedmult((carObj->linearAcc_ch).y,transOrientMat.m[4]) + fixedmult((carObj->linearAcc_ch).z,transOrientMat.m[5]);
  (carObj->linearAcc).z = fixedmult((carObj->linearAcc_ch).x,transOrientMat.m[6]) + fixedmult((carObj->linearAcc_ch).y,transOrientMat.m[7]) + fixedmult((carObj->linearAcc_ch).z,transOrientMat.m[8]);

  (carObj->linearAcc).x = (carObj->linearAcc).x + (fixedmult((carObj->linearAcc_rh).x,transRoadMat.m[0]) + fixedmult((carObj->linearAcc_rh).y,transRoadMat.m[1]) + fixedmult((carObj->linearAcc_rh).z,transRoadMat.m[2]));
  (carObj->linearAcc).y = (carObj->linearAcc).y + (fixedmult((carObj->linearAcc_rh).x,transRoadMat.m[3]) + fixedmult((carObj->linearAcc_rh).y,transRoadMat.m[4]) + fixedmult((carObj->linearAcc_rh).z,transRoadMat.m[5]));
  (carObj->linearAcc).z = (carObj->linearAcc).z + (fixedmult((carObj->linearAcc_rh).x,transRoadMat.m[6]) + fixedmult((carObj->linearAcc_rh).y,transRoadMat.m[7]) + fixedmult((carObj->linearAcc_rh).z,transRoadMat.m[8]));

  angAcc.x = fixedmult((carObj->angularAcc).x,transOrientMat.m[0]) + fixedmult((carObj->angularAcc).y,transOrientMat.m[1]) + fixedmult((carObj->angularAcc).z,transOrientMat.m[2]);
  angAcc.y = fixedmult((carObj->angularAcc).x,transOrientMat.m[3]) + fixedmult((carObj->angularAcc).y,transOrientMat.m[4]) + fixedmult((carObj->angularAcc).z,transOrientMat.m[5]);
  angAcc.z = fixedmult((carObj->angularAcc).x,transOrientMat.m[6]) + fixedmult((carObj->angularAcc).y,transOrientMat.m[7]) + fixedmult((carObj->angularAcc).z,transOrientMat.m[8]);

  carObj->angularAcc = angAcc; tickLoop = 0;
  (carObj->N).linearVel.x = (carObj->N).linearVel.x + fixedmult((carObj->linearAcc).x,AIPhysic_iTime);
  (carObj->N).linearVel.y = (carObj->N).linearVel.y + fixedmult((carObj->linearAcc).y,AIPhysic_iTime);
  (carObj->N).linearVel.z = (carObj->N).linearVel.z + fixedmult((carObj->linearAcc).z,AIPhysic_iTime);

  for (; (carObj->drag != 0) && (tickLoop < AIPhysic_elapsedTime); tickLoop = tickLoop + 1)
  {
    (carObj->N).linearVel.x = fixedmult((carObj->N).linearVel.x,carObj->drag);
    (carObj->N).linearVel.y = fixedmult((carObj->N).linearVel.y,carObj->drag);
    (carObj->N).linearVel.z = fixedmult((carObj->N).linearVel.z,carObj->drag);
  }

  (carObj->N).angularVel.x = (carObj->N).angularVel.x + (carObj->angularAcc).x / 256 * (AIPhysic_iTime / 256);
  (carObj->N).angularVel.y = (carObj->N).angularVel.y + (carObj->angularAcc).y / 256 * (AIPhysic_iTime / 256);
  (carObj->N).angularVel.z = (carObj->N).angularVel.z + (carObj->angularAcc).z / 256 * (AIPhysic_iTime / 256);
}

/* ---- AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType  (PASS 66/66 w11-a8:
 * SYM has ONE local rampSpeed (REG $6=a2); plain `elapsedTime * 13107` — gcc synth_mult
 * emits the oracle's *3,*17,<<8 shift-add chain; clamp pair = if(A&&B) X; else if(C&&D) X;
 * with DIRECT field expressions (no cached locals — cse-region reloads fall out); ramp
 * tail = field-direct `+=`/`-=` so the new value takes a fresh temp, MATCH: do not
 * introduce locals here) ---- */
#line 1988 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_CalculateRampedDesiredLatPos(Car_tObj *carObj,eRampType rampType)
{
  int rampSpeed;
  if (rampType == 1)
  {
    carObj->rampDesiredLatPos = carObj->desiredLatPos;
    return;
  }


  AIWorld_CalculateDeltaRoadYaw(carObj);
  rampSpeed = AIPhysic_elapsedTime * 13107;


























  if ((carObj->desiredLatPos < carObj->roadPosition) && (carObj->roadPosition < carObj->rampDesiredLatPos - 0x10000))
  {
    carObj->rampDesiredLatPos = carObj->roadPosition;
  }
  else if ((carObj->rampDesiredLatPos + 0x10000 < carObj->roadPosition) && (carObj->roadPosition < carObj->desiredLatPos))
  {
    carObj->rampDesiredLatPos = carObj->roadPosition;
  }



  if (carObj->rampDesiredLatPos < carObj->desiredLatPos)
  {
    carObj->rampDesiredLatPos += rampSpeed;

    if (carObj->desiredLatPos < carObj->rampDesiredLatPos) carObj->rampDesiredLatPos = carObj->desiredLatPos;

  }   else if (carObj->desiredLatPos < carObj->rampDesiredLatPos)
  {
    carObj->rampDesiredLatPos -= rampSpeed;
    if (carObj->rampDesiredLatPos < carObj->desiredLatPos)
      carObj->rampDesiredLatPos = carObj->desiredLatPos;
  }
















}


/* ---- AIPhysic_HitWallCheck__FP8Car_tObj  [MATCHED 100% (44/44), pin-free] ----
 * 🏆 The "confirmed cross-compiler coloring wall" was WRONG — it WAS source-reachable. The 18-diff
 * near-miss (onRoad→$v0/laneCount→$a2 vs oracle $a2/$a3) survived 8 structural levers, BOTH compiler
 * versions (cc1plus 2.7.2 + gcc2.8.1, Mc-muffin's YsDj7 99.20%), AND the permuter — yet TWO source
 * rewrites collapsed it to 0 (user-driven, 2026-06-21):
 * 1. **`&&` SINGLE-EXPRESSION** for onRoad (NOT if/else, NOT ternary): the range check
 *    `if(limit<lo) onRoad=0; else onRoad=(hi>=limit)` is identically `onRoad = (limit>=lo) && (hi>=limit)`.
 *    Writing it as the `&&` flips the WHOLE coloring to the oracle's — onRoad→$a2, laneCount→$a3.
 *    (if/else and ternary both gave $v0/$a2 = the 18-diff wall; only the `&&` short-circuit form makes
 *    gcc-2.x allocate the funnel the oracle's way. 18→6.)
 * 2. **INVERTED TAIL early-out**: `if(timeOffRoad>=9) return 1; return !(0xD999<m[4]);` — NOT
 *    `if(<9) return !(...); return 1;`. Makes `return 1` the branch-target early-out and the m[4]
 *    check the fall-through, matching the oracle's `beqz v0,.La8` polarity. 6→0.
 * Plus the gp-rel fix from earlier this session: `int AIPhysic_elapsedTime;` tentative def (§3.12 #6)
 * → `lw $v1,N($gp)` not absolute lui/lw. All three together = byte-perfect.
 * 🔑 META: a residual that beats structural levers + 2 compilers + an expert + the permuter is STILL
 * not proven unmatchable — re-express the LOGIC (a 2-branch select IS a `&&`/`||`; an if-body can be
 * the fall-through OR the branch-target). The permuter can't discover `&&`↔if/else or branch-polarity
 * reshapes; only re-deriving the boolean structure does. (Cf. GetRearEnd: same lesson via array+=.) */
#line 2072 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
int AIPhysic_HitWallCheck(Car_tObj *carObj)
{
    int onRoad;





    onRoad = (carObj->laneIndex >= 7 - (BWorldSm_slices[carObj->N.simRoadInfo.slice].laneCount >> 4)) && ((int)(BWorldSm_slices[carObj->N.simRoadInfo.slice].laneCount & 0xF) + 6 >= carObj->laneIndex);

    if (onRoad)
        return 0;

    if (carObj->driveDirection == -1)
        carObj->timeOffRoad += AIPhysic_elapsedTime;
    else
        carObj->timeOffRoad = 0;

    if (carObj->timeOffRoad >= 9)
    {



        return 1;
    }



    if (0xD999 < carObj->N.roadMatrix.m[4])
        return 0;





    return 1;
}

/* ---- AIPhysic_ProcessBarrierCollision__FP8Car_tObj  [MATCHED 100% via __builtin_abs] ----
 * Was a "v0/v1 + 0x9FFFF constant-hoist" near-miss; the hoist was DOWNSTREAM of the abs idiom
 * (hand-rolled `if(v<0)v=-v` vs oracle's inline `bgez;negu`). __builtin_abs collapsed it. */
#line 2116 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_ProcessBarrierCollision(Car_tObj *carObj)
{
    if (!(carObj->carFlags & 4) && !(0x9FFFF < __builtin_abs(carObj->currentSpeed)))




        AIPhysic_ChangeDirection(carObj, 0x60);
}

/* ---- AIPhysic_ProcessCollision__FP8Car_tObj  [MATCHED 100% via __builtin_abs, as ProcessBarrier] ---- */
#line 2133 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_ProcessCollision(Car_tObj *carObj)
{

    if (0xD999 < carObj->N.collision.impulse && carObj->N.collision.otherObj != 0)
    {
        if (!(0x9FFFF < __builtin_abs(carObj->currentSpeed)))
        {
            int reverseTime;



            reverseTime = 0x60; if (carObj->carFlags & 0x10)
                reverseTime = 0xA0;
            AIPhysic_ChangeDirection(carObj, reverseTime);
        }
    }
}

/* AIPhysic_ChangeDirection: retail AIPHYSIC.CPP:2163-2186, 46/46 PASS.
 * Matched NFS2 source supports the two-arm form and timer-before-time stores.
 * Native names/homes/scopes match; PHYS 2026-10-31: statement lines placed on retail's SLD
 * coordinates (sldprobe 0/46 tags, block 1..24); gap contents unrecovered and left blank. */
#line 2162 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_ChangeDirection(Car_tObj *carObj, int time)
{


    if ((carObj->driveDirection == -1) && (simGlobal.gameTicks - carObj->driveDirectionTimer > carObj->driveDirectionReverseTime / 2))
    {
        carObj->driveDirection = 1;
        carObj->driveDirectionTimer = simGlobal.gameTicks;
        carObj->driveDirectionReverseTime = time;
    }







    else if ((carObj->driveDirection == 1) && (simGlobal.gameTicks - carObj->driveDirectionTimer > carObj->driveDirectionReverseTime / 2) && (__builtin_abs(carObj->currentSpeed) <= 0x13FFFF))
    {



        carObj->driveDirection = -1;
        carObj->driveDirectionTimer = simGlobal.gameTicks;
        carObj->driveDirectionReverseTime = time; }
}

/* ---- AIPhysic_CheckForGripReduction__FP8Car_tObj ---- */
#line 2196 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_CheckForGripReduction(Car_tObj *carObj)
{


  if (carObj->gripFactor < 0x10000)
  {
    carObj->gripFactor += AIPhysic_elapsedTime * carObj->personality->gripLossRecoveryPerTick;





    if (((simGlobal.gameTicks - (carObj->N).collision.lastTime < 0x40) && ((carObj->N).collision.lastOtherObj == (BO_tNewtonObj *)0x0)) || (carObj->personality->gripLossMinFactor + ((0x10000 - carObj->personality->gripLossMinFactor) / 4) < carObj->gripFactor))
      carObj->gripFactor = 0x10000;
  }
  else if (((carObj->N).simOptz == '\0') && ((carObj->carFlags & 0x28U) != 0) && 2000 < ((AIWorld_CalcRoadBend(carObj,1) >= 1) ? AIWorld_CalcRoadBend(carObj,1) : -AIWorld_CalcRoadBend(carObj,1)))
  {
    int randVal;
    int perTickProb;
    randtemp = fastRandom * randSeed; randVal = (int)(((u_int)randtemp >> 8) & 0xffff); fastRandom = randtemp & 0xffff;
    perTickProb = AIPhysic_elapsedTime * carObj->personality->gripLossProbPerSecond / 32;

    if (randVal < perTickProb)
    {
      carObj->gripFactor = carObj->personality->gripLossMinFactor;
    }
  }
}

/* ---- AIPhysic_StartUp__Fv / CleanUp / Reset (empty stubs, retail VA order 0x8006cc3c/44/4c) ---- */
#line 2233 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_StartUp(void) {
}
#line 2237 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_CleanUp(void) {
}
#line 2240 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_Reset(void) {
}

/* ---- AIPhysic_ResetCar__FP8Car_tObj ---- */
#line 2242 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_ResetCar(Car_tObj *carObj)
{

    carObj->pullOver = 0;
    carObj->blowout = 0;
}

/* ---- AIPhysic_InitCar__FP8Car_tObj  (SYM: inlined AIPhysic_BrakeInfo ctor -- block-scoped
 * d/deceleration/sIndex share $16 via SYM Block scopes; plain /256,/0x10000,/2,/0x20000
 * divisions (gcc emits the bias idioms; distance=i<<16 turns the /0x10000 bias into ori)) ---- */
/* Owning AIPHYSIC.obj SYM: AIPerson_t::brakeMultiplier is INT at+0x20;
 * Car_tObj::personality is AIPerson_t* at+0x4f0. Exact typed member replaces
 * the raw byte-offset read with the entire native dump/code unchanged.
 * Receipt:build/nc12/aiphysic_engine_stop_20261027/. */
#line 2249 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_InitCar(Car_tObj *carObj)
{
  if ((carObj->carFlags & 2) != 0)
  {
      int d;
      /* SYM-INLINE-THIS: AIPhysic_BrakeInfo; SYM-INLINE-LOCAL: deceleration, invDeceleration, brakeTableLoop, distance, brakeDistanceMeters, sIndex = AIPhysic_BrakeInfo */































      d = 0xc0000;
      if ((carObj->carFlags & 0x28) != 0)
        d = 0xb0000;



      d = carObj->personality->brakeMultiplier / 256 * (d / 256);
      if ((carObj->carFlags & 8) != 0)
        d = d / 256 * (AISpeeds_GetUpgradeBrakeMult(carObj->carIndex) / 256);

      carObj->brakeInfo = new AIPhysic_BrakeInfo(d);
  }
}
/* ---- AIPhysic_DeInitCar__FP8Car_tObj ---- */
#line 2300 "C:/nfs4/GAME/COMMON/AIPHYSIC.CPP"
void AIPhysic_DeInitCar(Car_tObj *carObj)
{
    if ((carObj->carFlags & 2) && carObj->brakeInfo != (AIPhysic_BrakeInfo *)0) {

        delete carObj->brakeInfo;
        carObj->brakeInfo = (AIPhysic_BrakeInfo *)0;
    }
}

