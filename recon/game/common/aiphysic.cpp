/* game/common/aiphysic.cpp -- RECONSTRUCTED (AI physics subsystem).
 *   AIPhysic_* — AI car physics: gear/speed tables, collision, control, road position.
 *   Reconstruction in progress (started 2026-06-20). NOT original source; SYM-faithful,
 *   recompilable C++. Verified per-function vs asm/nonmatchings/main/*.s.
 */
#include "../../nfs4_types.h"
#include "aiphysic_externs.h"


/* ---- AIPhysic_StartUp__Fv / Reset / CleanUp (empty stubs) ---- */
void AIPhysic_StartUp(void) { return; }
void AIPhysic_Reset(void)   { return; }
void AIPhysic_CleanUp(void) { return; }

/* ---- AIPhysic_ResetCar__FP8Car_tObj ---- */
void AIPhysic_ResetCar(Car_tObj *car)
{
    *(int *)((char *)car + 0x278) = 0;
    *(int *)((char *)car + 0x274) = 0;
}

/* ---- AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t  (clamp via tail-recursion -> gcc `j self`) ---- */
int AIPhysic_GearTopSpeed(Car_tObj *car, Gear_t gear)
{
    if (gear < 2) return AIPhysic_GearTopSpeed(car, (Gear_t)2);
    return car->topSpeeds[gear - 2];
}

/* ---- AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t ---- */
int AIPhysic_GearBottomSpeed(Car_tObj *car, Gear_t gear)
{
    if (gear < 3) return 0;
    return car->topSpeeds[gear - 3];
}

/* ---- AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t ---- */
int AIPhysic_GearInvSpeedRange(Car_tObj *car, Gear_t gear)
{
    if (gear < 2) return AIPhysic_GearInvSpeedRange(car, (Gear_t)2);
    return car->invTopSpeeds[gear - 2];
}

/* ---- AIPhysic_TargetedGetDesiredVector__FP8Car_tObj  (desiredVector = targetPos - position) ---- */
void AIPhysic_TargetedGetDesiredVector(Car_tObj *car)
{
    car->desiredVector.x = car->targetPos.x - *(int *)((char *)car + 0xA0);
    car->desiredVector.y = car->targetPos.y - *(int *)((char *)car + 0xA4);
    car->desiredVector.z = car->targetPos.z - *(int *)((char *)car + 0xA8);
    car->rampDesiredLatPos = car->targetLatPos;
}

/* ---- AIPhysic_DeInitCar__FP8Car_tObj ---- */
void AIPhysic_DeInitCar(Car_tObj *car)
{
    if (*(int *)((char *)car + 0x260) & 2) {
        if (car->brakeInfo != (AIPhysic_BrakeInfo *)0) {
            delete car->brakeInfo;
            car->brakeInfo = (AIPhysic_BrakeInfo *)0;
        }
    }
}

/* ---- AIPhysic_GetRearEndDamageFactor__FP8Car_tObj  [NEAR-MISS: pure v0/v1 accumulator tie-break] ---- */
int AIPhysic_GetRearEndDamageFactor(Car_tObj *car)
{
    int r = fixedmult(*(int *)((char *)car + 0x228) + *(int *)((char *)car + 0x22C) +
                      *(int *)((char *)car + 0x230) + *(int *)((char *)car + 0x23C), 0x147);
    if (0x10000 < r) return 0x10000;
    return r;
}

/* ---- AIPhysic_CalcDeceleration__FP8Car_tObj  (the bgez/+0xFF/sra-8 = gcc-2.x signed /256) ---- */
int AIPhysic_CalcDeceleration(Car_tObj *car)
{
    int v1 = *(int *)((char *)car->brakeInfo + 0x80);
    if (0x10000 < *(int *)((char *)car + 0x730)) {
        v1 = (v1 / 256) * (*(int *)((char *)car + 0x730) / 256);
    }
    return v1;
}

/* ---- AIPhysic_ProcessBarrierCollision__FP8Car_tObj  [NEAR-MISS: v0/v1 + constant-hoist tie-break] ---- */
void AIPhysic_ProcessBarrierCollision(Car_tObj *car)
{
    int v;
    if (*(int *)((char *)car + 0x260) & 4) return;
    v = *(int *)((char *)car + 0x564);
    if (v < 0) v = -v;
    if (0x9FFFF < v) return;
    AIPhysic_ChangeDirection(car, 0x60);
}

/* ---- AIPhysic_HitWallCheck__FP8Car_tObj  [NEAR-MISS: v0/v1+a2/a3 regalloc tie-break] ---- */
int AIPhysic_HitWallCheck(Car_tObj *car)
{
    Trk_NewSlice *slice = BWorldSm_slices + *(short *)((char *)car + 8);
    unsigned int b = *(unsigned char *)((char *)slice + 0x1D);
    int a2;
    if (*(int *)((char *)car + 0x6C4) < 7 - (int)(b >> 4)) {
        a2 = 0;
    } else {
        a2 = (int)(b & 0xF) + 6 >= *(int *)((char *)car + 0x6C4);
    }
    if (a2) return 0;
    if (*(int *)((char *)car + 0x6F0) == -1) {
        *(int *)((char *)car + 0x724) += AIPhysic_elapsedTime;
    } else {
        *(int *)((char *)car + 0x724) = 0;
    }
    if (*(int *)((char *)car + 0x724) < 9) {
        return !(0xD999 < *(int *)((char *)car + 0x154));
    }
    return 1;
}

/* ---- AIPhysic_CoolPhysics__FP8Car_tObj  (per-frame physics sequencer) ---- */
void AIPhysic_CoolPhysics(Car_tObj *car)
{
    *(int *)((char *)car + 0x570) |= 0x10;
    AIPhysic_HandleDirection(car);
    if (*(int *)((char *)car + 0x554) * *(int *)((char *)car + 0x564) < 0) {
        if (*(int *)((char *)car + 0x6F0) != -1) {
            *(int *)((char *)car + 0x718) = 0;
        }
    }
    if (AIPhysic_HitWallCheck(car)) {
        AIPhysic_ChangeDirection(car, 0x40);
    }
    AIPhysic_Preperation(car);
    if (AIPhysic_CheckIfOutOfControl(car)) {
        AIPhysic_OutOfControlPhysics(car);
    } else {
        AIPhysic_InControlPhysics(car);
    }
    AIPhysic_FinishUp(car);
}

/* ---- AIPhysic_ProcessCollision__FP8Car_tObj  [NEAR-MISS: abs+0x9FFFF constant-hoist tie-break, as ProcessBarrier] ---- */
void AIPhysic_ProcessCollision(Car_tObj *car)
{
    int v;
    if (0xD999 < *(int *)((char *)car + 0x190)) {
        if (*(int *)((char *)car + 0x194) != 0) {
            v = *(int *)((char *)car + 0x564);
            if (v < 0) v = -v;
            if (!(0x9FFFF < v)) {
                AIPhysic_ChangeDirection(car, (*(int *)((char *)car + 0x260) & 0x10) ? 0xA0 : 0x60);
            }
        }
    }
}

/* ---- AIPhysic_HandleSignalling__FP8Car_tObj  (turn-signal flags in halfwords 0x8B8/0x8BA) ---- */
void AIPhysic_HandleSignalling(Car_tObj *car)
{
    int pos, target;
    if (!(*(int *)((char *)car + 0x260) & 0x10)) return;
    pos    = *(int *)((char *)car + 0x558);
    target = *(int *)((char *)car + 0x574);
    if (pos < target - 0x40000) {
        *(short *)((char *)car + 0x8B8) = (short)(*(unsigned short *)((char *)car + 0x8B8) | 0x80);
        *(short *)((char *)car + 0x8BA) = 0;
    } else if (target + 0x40000 < pos) {
        *(short *)((char *)car + 0x8BA) = (short)(*(unsigned short *)((char *)car + 0x8BA) | 0x80);
        *(short *)((char *)car + 0x8B8) = 0;
    } else {
        *(short *)((char *)car + 0x8B8) = 0;
        *(short *)((char *)car + 0x8BA) = 0;
    }
}

/* ---- AIPhysic_ModifyAccelerationAccordingToScript__FP8Car_tObji ---- */
int AIPhysic_ModifyAccelerationAccordingToScript(Car_tObj *car, int accel)
{
    int result = accel;
    if (AIScript_DoReAction(&car->script, (AIScript_tAIReaction)4) != -1) {
        result = ((accel / 256) * 3) << 7;
    }
    return result;
}

/* ---- AIPhysics_UseCoolPhysics__FP8Car_tObj  (note the 'AIPhysicS' prefix) ----
 * Shared-tail structure: every condition branches TO a return block (ret1 = fall-through
 * default, laid out before ret0). The `goto`-to-shared-tail form reproduces gcc's exact
 * block order + branch polarity (the `||` form lays return 0 first → wrong order). */
int AIPhysics_UseCoolPhysics(Car_tObj *car)
{
    int flags = *(int *)((char *)car + 0x260);
    unsigned char b;
    if (flags & 0x800) goto ret1;
    b = *(unsigned char *)((char *)car + 0x90);
    if (b == 0) goto ret1;
    if (!(flags & 0x20)) goto ret0;
    if (b >= 2) goto ret0;
ret1:
    return 1;
ret0:
    return 0;
}

/* ---- AIPhysic_CheckForBadPosition__FP8Car_tObj  (two OR-flags → reset on bad) ---- */
void AIPhysic_CheckForBadPosition(Car_tObj *car)
{
    int bad1 = 0;
    int bad2 = 0;
    Trk_NewSlice *slice;
    int pos;
    if (0x730000 < *(int *)((char *)car + 0xB4) ||
        0x730000 < *(int *)((char *)car + 0xAC) ||
        (0x730000 < *(int *)((char *)car + 0xC0) &&
         *(unsigned char *)((char *)car + 0x90) == 0))
        bad1 = 1;
    slice = (Trk_NewSlice *)((*(short *)((char *)car + 8) << 5) + (int)BWorldSm_slices);
    pos = *(int *)((char *)car + 0x574);
    if (pos < (int)0xFFDD0000 - (*(short *)((char *)slice + 0x18) << 8) ||
        (*(short *)((char *)slice + 0x1A) << 8) + 0x230000 < pos)
        bad2 = 1;
    if (bad1 || bad2)
        Cars_ResetCollidedCars(car, 1, 0);
}

/* ---- AIPhysic_CalculateGear__FP8Car_tObj  (gear search loop) — 100% MATCH ----
 * STRUCTURE (all source-reachable, the hard part): (1) flat early-exit-via-`goto end`
 * for the return-1/return-0 cases — both set `gear` then jump over the loop to a shared
 * `return gear` (oracle's L614/L618 split: early returns funnel `s1`->`v0`, loop returns
 * go direct); (2) abs as copy-then-conditional-negate `absV=raw; if(raw<0) absV=-absV;`;
 * (3) `limit` hoisted as an early named local. RESIDUAL coalescing tie-break: the oracle
 * keeps `raw` (0x564) in a caller-saved temp (v1) copied to s4, freeing the bgez delay
 * slot for the copy (which in turn keeps lui+ori paired early); gcc otherwise loads raw
 * direct into s4 (1-insn shorter). Forced here with a single `raw asm("$3")` pin.
 * 🔴 PIN = coalescing CRUTCH at 100% — strip via permuter from the pin-removed 64/65 base. */
int AIPhysic_CalculateGear(Car_tObj *car)
{
    int limit = 0x1FFFF;
    register int raw asm("$3") = *(int *)((char *)car + 0x564);
    int absV = raw;
    int gear = *(unsigned char *)((char *)car + 0x442);
    int tooLow;
    if (raw < 0)
        absV = -absV;
    if (!(limit < absV)) {
        gear = 1;
        goto end;
    }
    if (*(int *)((char *)car + 0x6F0) == -1) {
        gear = 0;
        goto end;
    }
    for (;;) {
        int found = 0;
        tooLow = AIPhysic_GearTopSpeed(car, (Gear_t)gear) < absV;
        if (tooLow || absV < AIPhysic_GearBottomSpeed(car, (Gear_t)gear))
            found = 1;
        if (!found)
            return gear;
        if (tooLow) {
            if (AIPhysic_GearTopSpeed(car, (Gear_t)(gear + 1)) == 0)
                return gear;
            *(int *)((char *)car + 0x580) = *(int *)((char *)car + 0x57C);
            gear = gear + 1;
        } else {
            *(int *)((char *)car + 0x580) = *(int *)((char *)car + 0x57C);
            gear = gear - 1;
        }
    }
end:
    return gear;
}

/* ---- AIPhysic_HandleDirection__FP8Car_tObj  (register-only; D_8011E0B0 == &simGlobal[1]) ----
 * [NEAR-MISS 57/58 insns]: residual = ONE duplicated `%hi(D_8011E0B0)`. The shared setRamp
 * block is reached from two paths; the oracle pulls the block's first `lui %hi` into BOTH
 * predecessors' delay slots (duplicated), gcc here CSE's it to one. Delay-slot-fill /
 * shared-block scheduling tie-break (the ChangeDirection class) — source-unreachable → decomp.me. */
void AIPhysic_HandleDirection(Car_tObj *car)
{
    int x718;
    int x574;
    if (*(int *)((char *)car + 0x6F0) != -1)
        return;
    x718 = *(int *)((char *)car + 0x718);
    x574 = *(int *)((char *)car + 0x574);
    if ((x574 < x718 - 0xA0000 && *(int *)((char *)car + 0x704) > 0) ||
        (x718 + 0xA0000 < x574 && *(int *)((char *)car + 0x704) < 0))
        *(int *)((char *)car + 0x6F4) = D_8011E0B0 - 0x18;
    if (*(int *)((char *)car + 0x6EC) < simGlobal[1] - *(int *)((char *)car + 0x6F4)) {
        *(int *)((char *)car + 0x6F0) = 1;
        *(int *)((char *)car + 0x6F4) = simGlobal[1];
    }
    if (0x140000 < *(int *)((char *)car + 0x55C))
        *(int *)((char *)car + 0x55C) = 0x140000;
    if (0x140000 < -*(int *)((char *)car + 0x55C))
        *(int *)((char *)car + 0x55C) = (int)0xFFEC0000;
    *(int *)((char *)car + 0x718) = 0;
}

/* ---- AIPhysic_CalculateRoadPosition__FP8coorddefi  (leaf: dot(pos-sliceCenter, sliceRight)/256^2) ---- */
int AIPhysic_CalculateRoadPosition(coorddef *pos, int sliceIdx)
{
    coorddef org;
    coorddef delta;
    coorddef nrm;
    org = *(coorddef *)BWorldSm_slices[sliceIdx].center;
    delta.x = pos->x - org.x;
    delta.y = pos->y - org.y;
    delta.z = pos->z - org.z;
    nrm.x = (signed char)BWorldSm_slices[sliceIdx].right[0] << 9;
    nrm.y = (signed char)BWorldSm_slices[sliceIdx].right[1] << 9;
    nrm.z = (signed char)BWorldSm_slices[sliceIdx].right[2] << 9;
    return (nrm.x / 256) * (delta.x / 256) +
           (nrm.y / 256) * (delta.y / 256) +
           (nrm.z / 256) * (delta.z / 256);
}
