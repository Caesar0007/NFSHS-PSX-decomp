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
    car->pullOver = 0;
    car->blowout = 0;
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
    car->desiredVector.x = car->targetPos.x - car->N.position.x;
    car->desiredVector.y = car->targetPos.y - car->N.position.y;
    car->desiredVector.z = car->targetPos.z - car->N.position.z;
    car->rampDesiredLatPos = car->targetLatPos;
}

/* ---- AIPhysic_DeInitCar__FP8Car_tObj ---- */
void AIPhysic_DeInitCar(Car_tObj *car)
{
    if (car->carFlags & 2) {
        if (car->brakeInfo != (AIPhysic_BrakeInfo *)0) {
            delete car->brakeInfo;
            car->brakeInfo = (AIPhysic_BrakeInfo *)0;
        }
    }
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
 * 3. SEPARATE `result` var + `if(x<=0x10000) result=x; else result=0x10000;` (BOTH branches assign
 *    — NOT a default+conditional-override funnel, which gave 17): produces the oracle's $a0 result-
 *    funnel + the `addu v0,a0,zero` slt-scratch copy. (An equivalent ternary `x<=0x10000?x:0x10000`
 *    also matches; the if/else is Mc-muffin (Ethanol)'s canonical form.)
 * 24→0. META: a "permuter plateau" (it stalled at 115) does NOT mean unbeatable — the permuter
 * can't restructure a sum-expr into +=-accumulation or change scalar→array access. Re-derive the
 * SYM's variable/type structure first. CANONICAL 100% scratch: https://decomp.me/scratch/JS0Q0
 * (Caesar0007 spotted the array + the missing decl; Mc-muffin / Ethanol @ Discord, github.com/Mc-muffin, cracked the last-stage clamp form.) */
int AIPhysic_GetRearEndDamageFactor(Car_tObj *car)
{
    int totalDamage;
    int result;
    totalDamage = car->N.damage[4];
    totalDamage += car->N.damage[5];
    totalDamage += car->N.damage[6];
    totalDamage += car->N.damage[9];
    totalDamage = fixedmult(totalDamage, 0x147);
    if (totalDamage <= 0x10000)
        result = totalDamage;
    else
        result = 0x10000;
    return result;
}

/* ---- AIPhysic_CalcDeceleration__FP8Car_tObj  (the bgez/+0xFF/sra-8 = gcc-2.x signed /256) ---- */
int AIPhysic_CalcDeceleration(Car_tObj *car)
{
    int v1 = *(int *)((char *)car->brakeInfo + 0x80);
    if (0x10000 < car->aiGlue) {
        v1 = (v1 / 256) * (car->aiGlue / 256);
    }
    return v1;
}

/* ---- AIPhysic_ProcessBarrierCollision__FP8Car_tObj  [MATCHED 100% via __builtin_abs] ----
 * Was a "v0/v1 + 0x9FFFF constant-hoist" near-miss; the hoist was DOWNSTREAM of the abs idiom
 * (hand-rolled `if(v<0)v=-v` vs oracle's inline `bgez;negu`). __builtin_abs collapsed it. */
void AIPhysic_ProcessBarrierCollision(Car_tObj *car)
{
    int v;
    if (car->carFlags & 4) return;
    v = car->currentSpeed;
    v = __builtin_abs(v);
    if (0x9FFFF < v) return;
    AIPhysic_ChangeDirection(car, 0x60);
}

/* ---- AIPhysic_HitWallCheck__FP8Car_tObj  [NEAR-MISS 21/44: onRoad/laneCount reg coloring] ----
 * SYM (nfs4-f-v3.txt): ONE named local `onRoad` class REG $6 (=$a2) INT; field at slice+0x1D =
 * `laneCount` (UCHAR, NOT a bitfield). slice-addr via commutative-addu lever (idx<<5)+(int)base.
 * RESIDUAL ROOT CAUSE (from SLD+oracle): the oracle puts `li v0,-1` in the `beqz onRoad` DELAY SLOT,
 * sharing that -1 with the `car->0x6F0 == -1` check at .L54 (reorg fill-from-target). That REQUIRES
 * v0 free at the branch → forces onRoad OUT of v0 into $a2 (and laneCount to $a3). It's a CIRCULAR
 * coupling: onRoad-in-$v0 blocks the -1 share; the -1 share needs $v0 free. gcc here picks the other
 * local optimum (onRoad→$v0, laneCount→$a2, -1 materialized separately). NOT a compiler-version diff
 * — SAME coloring on BOTH cc1plus/2.7.2 (in-tree) AND gcc2.8.1-psx C++ (scratch pwneU, 625). Tried:
 * named/anon laneCount, decl order, limit-inline, if/else vs ternary, early-init, nested-!onRoad
 * (19 diffs but flips branch polarity). The original broke the cycle via a source form not yet
 * found (the reorg delay-slot -1 hoist). Genuine reorg/coloring residual; forcing $a2 = pin (§3.13,
 * forbidden). SYM+ORACLE confirms structure/types/logic correct — only the coloring differs. */
int AIPhysic_HitWallCheck(Car_tObj *car)
{
    Trk_NewSlice *slice = (Trk_NewSlice *)((*(short *)((char *)car + 8) << 5) + (int)BWorldSm_slices);
    int limit = car->laneIndex;
    int onRoad;
    if (limit < 7 - (int)(slice->laneCount >> 4))
        onRoad = 0;
    else
        onRoad = (int)(slice->laneCount & 0xF) + 6 >= limit;
    if (onRoad) return 0;
    if (car->driveDirection == -1) {
        car->timeOffRoad += AIPhysic_elapsedTime;
    } else {
        car->timeOffRoad = 0;
    }
    if (car->timeOffRoad < 9) {
        return !(0xD999 < car->N.roadMatrix.m[4]);
    }
    return 1;
}

/* ---- AIPhysic_CoolPhysics__FP8Car_tObj  (per-frame physics sequencer) ---- */
void AIPhysic_CoolPhysics(Car_tObj *car)
{
    car->AIFlags |= 0x10;
    AIPhysic_HandleDirection(car);
    if (car->direction * car->currentSpeed < 0) {
        if (car->driveDirection != -1) {
            car->rampDesiredLatPos = 0;
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

/* ---- AIPhysic_ProcessCollision__FP8Car_tObj  [MATCHED 100% via __builtin_abs, as ProcessBarrier] ---- */
void AIPhysic_ProcessCollision(Car_tObj *car)
{
    int v;
    if (0xD999 < car->N.collision.impulse) {
        if (car->N.collision.otherObj != 0) {
            v = car->currentSpeed;
            v = __builtin_abs(v);
            if (!(0x9FFFF < v)) {
                AIPhysic_ChangeDirection(car, (car->carFlags & 0x10) ? 0xA0 : 0x60);
            }
        }
    }
}

/* ---- AIPhysic_HandleSignalling__FP8Car_tObj  (turn-signal flags in halfwords 0x8B8/0x8BA) ---- */
void AIPhysic_HandleSignalling(Car_tObj *car)
{
    int pos, target;
    if (!(car->carFlags & 0x10)) return;
    pos    = car->desiredLatPos;
    target = car->roadPosition;
    if (pos < target - 0x40000) {
        car->render.signalLight[0] = (short)(*(unsigned short *)&car->render.signalLight[0] | 0x80);
        car->render.signalLight[1] = 0;
    } else if (target + 0x40000 < pos) {
        car->render.signalLight[1] = (short)(*(unsigned short *)&car->render.signalLight[1] | 0x80);
        car->render.signalLight[0] = 0;
    } else {
        car->render.signalLight[0] = 0;
        car->render.signalLight[1] = 0;
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
    int flags = car->carFlags;
    unsigned char b;
    if (flags & 0x800) goto ret1;
    b = car->N.simOptz;
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
    if (0x730000 < car->N.linearVel.z ||
        0x730000 < car->N.linearVel.x ||
        (0x730000 < car->N.speedXZ &&
         car->N.simOptz == 0))
        bad1 = 1;
    slice = (Trk_NewSlice *)((*(short *)((char *)car + 8) << 5) + (int)BWorldSm_slices);
    pos = car->roadPosition;
    if (pos < (int)0xFFDD0000 - (*(short *)((char *)slice + 0x18) << 8) ||
        (*(short *)((char *)slice + 0x1A) << 8) + 0x230000 < pos)
        bad2 = 1;
    if (bad1 || bad2)
        Cars_ResetCollidedCars(car, 1, 0);
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
 * SimplePhysics_LatVel clamp-abs residual → __builtin_abs candidate there too.) */
int AIPhysic_CalculateGear(Car_tObj *car)
{
    int speed = car->currentSpeed;
    int absSpeed = __builtin_abs(speed);
    int gear = car->control.gear;
    int tooLow;
    if (absSpeed <= 0x1FFFF) {
        gear = 1;
        goto end;
    }
    if (car->driveDirection == -1) {
        gear = 0;
        goto end;
    }
    for (;;) {
        int found = 0;
        tooLow = AIPhysic_GearTopSpeed(car, (Gear_t)gear) < absSpeed;
        if (tooLow || absSpeed < AIPhysic_GearBottomSpeed(car, (Gear_t)gear))
            found = 1;
        if (!found)
            return gear;
        if (tooLow) {
            speed = AIPhysic_GearTopSpeed(car, (Gear_t)(gear + 1));
            if (speed == 0)
                return gear;
            car->aiShiftTimer = car->aiShiftDuration;
            gear = gear + 1;
        } else {
            car->aiShiftTimer = car->aiShiftDuration;
            gear = gear - 1;
        }
    }
end:
    return gear;
}

/* ---- AIPhysic_HandleDirection__FP8Car_tObj  (register-only; D_8011E0B0 == &simGlobal[1]) ----
 * [MATCHED 100% (58/58), pin-free]. The lone residual `lui v0,%hi` (a reorg delay-slot fill on
 * the D_8011E0B0 address materialization) was NOT a reorg wall — it was the scalar-vs-array shape:
 * declaring D_8011E0B0 as an UNSIZED ARRAY (`extern int D_8011E0B0[]`, access `[0] - 0x18`) changed
 * the address-materialization so gcc duplicates the `%hi` into the `bgtz` delay slot exactly as the
 * oracle (§3.12#5; same lever that fixed HandleWipeoutTimer). D_8011E0B0 == &simGlobal[1]. */
void AIPhysic_HandleDirection(Car_tObj *car)
{
    int x718;
    int x574;
    if (car->driveDirection != -1)
        return;
    x718 = car->rampDesiredLatPos;
    x574 = car->roadPosition;
    if (x574 < x718 - 0xA0000 && car->lateralVelocity > 0)
        goto setRamp;
    if (x718 + 0xA0000 < x574 && car->lateralVelocity < 0)
        goto setRamp;
    goto afterRamp;
setRamp:
    car->driveDirectionTimer = D_8011E0B0[0] - 0x18;
afterRamp:
    if (car->driveDirectionReverseTime < simGlobal[1] - car->driveDirectionTimer) {
        car->driveDirection = 1;
        car->driveDirectionTimer = simGlobal[1];
    }
    if (0x140000 < car->desiredSpeed)
        car->desiredSpeed = 0x140000;
    if (0x140000 < -car->desiredSpeed)
        car->desiredSpeed = (int)0xFFEC0000;
    car->rampDesiredLatPos = 0;
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

/* ---- AIPhysic_SimplePhysics_LatVel__FP8Car_tObj  (3-axis fixedmult or clamp to ±abs(latVel)) ----
 * [MATCHED 100% (73/73), pin-free]. Three levers: (1) STRUCT-COPY for the fixedmult setup
 * (`vals = *(coorddef*)&car->0x144`); (2) EXPLICIT `else s0 = 0;` (not `int s0=0;` up top) —
 * lands the 0 in the beqz DELAY SLOT and splits x568's live-range to $v1+reload; (3) 🔑 the
 * clamp uses `__builtin_abs(v)` — the SAME lever that sealed CalculateGear. The earlier 6-diff
 * residual was the clamp-abs coalescing (a hand-rolled `absV=v; if(v<0)absV=-absV;` collapses
 * the copy); __builtin_abs forces the oracle's keep-v-then-copy-then-negate form. NOT a
 * permuter/decomp.me wall after all — it was the abs-idiom (cross-ref CalculateGear note). */
void AIPhysic_SimplePhysics_LatVel(Car_tObj *car)
{
    int s0;
    if (0x30000 < car->speed)
        s0 = car->rampDesiredLatPos - car->roadPosition;
    else
        s0 = 0;
    if (0x190000 < car->speed) {
        coorddef vals;
        vals = *(coorddef *)&car->N.roadMatrix;
        vals.x = fixedmult(s0, vals.x);
        vals.y = fixedmult(s0, vals.y);
        vals.z = fixedmult(s0, vals.z);
        car->N.position.x += vals.x;
        car->N.position.y += vals.y;
        car->N.position.z += vals.z;
        car->laneChangeSpeed = 0;
    } else {
        int v = car->currentSpeed;
        int absV = __builtin_abs(v);
        car->laneChangeSpeed = s0;
        if (s0 < -absV)
            car->laneChangeSpeed = -absV;
        else if (absV < s0)
            car->laneChangeSpeed = absV;
    }
}

/* ---- AIPhysic_HandleWipeoutTimer__FP8Car_tObj  (leaf; inline mult PRNG advances 0x744 timer) ----
 * [MATCHED 100% (37/37), pin-free]. The "work-pointer cascade" (car→a1 not a3) was DOWNSTREAM of
 * two structural misses: (1) `limit` was a scalar `D_8011E0B0` → self-temp HI-scratch load; making
 * D_8011E0B0 an UNSIZED ARRAY (`extern int D_8011E0B0[]`, access `[0]`) gives the oracle's
 * separate-temp `lui v0; lw a2,(v0)` (§3.12#5) — also fixed HandleDirection as a bonus. (2) the
 * `base = limit + info->0x30` add had to be computed EARLY (before the PRNG, as the oracle does)
 * to force the 4-live-value peak that puts car in $a3. (3) the final `((r>>8)&0xFFFF) & info->0x34`:
 * gcc-2.7.2 narrows the `&0xFFFF` into a HALFWORD load (`lhu`, dropping the andi) — write the random
 * as `(unsigned short)(r>>8)` to anchor the andi on the random + keep the full `lw` of info->0x34. */
void AIPhysic_HandleWipeoutTimer(Car_tObj *car)
{
    int limit, base;
    unsigned int r;
    char *info;
    if ((car->carFlags & 8) == 0)
        return;
    limit = D_8011E0B0[0];
    if (!(car->wipeOutStartTick < limit))
        return;
    r = (unsigned int)(fastRandom * randSeed);
    info = (char *)car->personality;
    base = limit + *(int *)(info + 0x30);
    randtemp = r;
    fastRandom = r & 0xFFFF;
    car->wipeOutStartTick =
        base + (int)((unsigned int)(unsigned short)(r >> 8) & (unsigned int)*(int *)(info + 0x34));
}

/* ---- AIPhysic_ChangeDirection__FP8Car_tObji  (leaf; flip the 0x6F0 dir flag +1/-1 under window) ----
 * [MATCHED 100% (46/46), pin-free]. The 55-diff "regalloc cascade" was FIVE composed structural
 * levers, none allocator-bound: (1) `__builtin_abs(v)` for the speed clamp; (2) SHORT newDir
 * live-range — set `newDir=1` right before `goto action` (not `int newDir=1;` up top) so it lands
 * in v0 like the oracle, freeing car→a2; (3) FLIP the compare to `sg[1]-0x6F4 > 0x6EC/2` (sub as
 * LEFT operand) so gcc evaluates sg[1] first (matches the oracle's subu operand order); (4) ASSIGN
 * `sg = simGlobal` PER-BLOCK (function-scope `int *sg;` assigned in each block, NOT declared-init
 * once) → gcc rematerializes `&simGlobal` per block, both flowing into the shared action via a3
 * (a declared-init pointer gets GCSE-hoisted to ONE materialization — wrong); (5) read `sg[1]` into
 * a temp AFTER the newDir store so the `dir` store fills its load-delay slot (kills the lone nop). */
void AIPhysic_ChangeDirection(Car_tObj *car, int dir)
{
    int newDir;
    int *sg;
    if (car->driveDirection == -1) {
        sg = simGlobal;
        if (sg[1] - car->driveDirectionTimer > car->driveDirectionReverseTime / 2) {
            newDir = 1;
            goto action;
        }
    }
    if (car->driveDirection != 1)
        return;
    sg = simGlobal;
    if (!(sg[1] - car->driveDirectionTimer > car->driveDirectionReverseTime / 2))
        return;
    {
        int v = car->currentSpeed;
        if (__builtin_abs(v) > 0x13FFFF)
            return;
    }
    newDir = -1;
action:
    car->driveDirection = newDir;
    {
        int rampPos = sg[1];
        car->driveDirectionReverseTime = dir;
        car->driveDirectionTimer = rampPos;
    }
}
