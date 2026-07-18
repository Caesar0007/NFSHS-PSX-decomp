/* game/common/aiphysic.cpp -- RECONSTRUCTED (AI physics subsystem).
 *   AIPhysic_* — AI car physics: gear/speed tables, collision, control, road position.
 *   Reconstruction in progress (started 2026-06-20). NOT original source; SYM-faithful,
 *   recompilable C++. Verified per-function vs asm/nonmatchings/main/*.s.
 */
#include "../../nfs4_types.h"
#include "aiphysic_externs.h"

/* Owner-module tentative definition: AIPhysic_elapsedTime ($8013c59c) lives in this TU's
 * small-common (.comm,4) so -G4 addresses it gp-relative (`lw $v1,N($gp)`), matching the
 * oracle (HitWallCheck etc.). As a bare `extern` it degraded to absolute lui/lw (+1 insn). */
int AIPhysic_elapsedTime;

/* aiphysic.obj-owned bss globals (tentative defs → gp-relative addressing like elapsedTime) */
AIPhysic_Config_t AIPhysicConfig;   /* @0x8010dc74 */
int AIPhysic_time;                  /* @0x8013c598 */
int AIPhysic_iTime;                 /* @0x8013c594 */


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
int AIPhysic_HitWallCheck(Car_tObj *car)
{
    int onRoad;
    onRoad = (car->laneIndex >= 7 - (BWorldSm_slices[*(short *)((char *)car + 8)].laneCount >> 4)) &&
             ((int)(BWorldSm_slices[*(short *)((char *)car + 8)].laneCount & 0xF) + 6 >= car->laneIndex);
    if (onRoad) return 0;
    if (car->driveDirection == -1) {
        car->timeOffRoad += AIPhysic_elapsedTime;
    } else {
        car->timeOffRoad = 0;
    }
    if (car->timeOffRoad >= 9) {
        return 1;
    }
    return !(0xD999 < car->N.roadMatrix.m[4]);
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

/* ============================================================================
 * PORTED from run-tree (game/common/aiphysic.cpp) — 17 new definitions.
 * Minimal decomp-type adaptations only: simGlobal.gameTicks→simGlobal[1],
 * simGlobal.gameStarted→simGlobal[0], (char*) casts for personality byte-arith.
 * ========================================================================== */

/* ---- AIPhysic_StopCar__FP8Car_tObjii  (oracle STAGGERS each fixedmult store into the NEXT
 * field's clamp-check delay slot -- linearVel.x's store rides bgez(prodY), .y's rides the
 * fallthrough after prodZ's mult, .z's rides bgez(angularVel.y); reproduce the exact stagger,
 * not a per-field sequential store, or the branch/delay-slot shape won't match.
 * MATCH: `angY >>= 8;` reordered BEFORE `if(rotScale<0)` (was after) lets gcc schedule the
 * shift into bgez(rotScale)'s delay slot like the oracle, 31->28 diffs. Residual: velScale's
 * adjusted copy colors into a1 (in-place, reused for scaleShifted too) where the oracle keeps
 * velScale(a1) untouched and materializes the clamp + scaleShifted into fresh v1/t0 -- tried
 * separate-local copy, plain `/256` idiom, both compile IDENTICAL (gcc coalesces the dead
 * original back in); genuine allocator floor (§3.15 family), not source-reachable without a
 * forbidden pin. ---- */
void AIPhysic_StopCar(Car_tObj *carObj,int velScale,int rotScale)
{
  (carObj->angularAcc).z = 0;
  (carObj->angularAcc).y = 0;
  (carObj->angularAcc).x = 0;
  (carObj->linearAcc_ch).z = 0;
  (carObj->linearAcc_ch).y = 0;
  (carObj->linearAcc_ch).x = 0;
  (carObj->linearAcc_rh).z = 0;
  (carObj->linearAcc_rh).y = 0;
  (carObj->linearAcc_rh).x = 0;
  (carObj->N).linearVel.x = velScale / 256 * (carObj->N).linearVel.x / 256;
  (carObj->N).linearVel.y = velScale / 256 * (carObj->N).linearVel.y / 256;
  (carObj->N).linearVel.z = velScale / 256 * (carObj->N).linearVel.z / 256;
  (carObj->N).angularVel.y = (carObj->N).angularVel.y / 256 * (rotScale / 256);
  return;
}

/* ---- AIPhysic_RevEngine__FP8Car_tObj  (oracle reloads flywheelRpm 3x -- parity test, the add,
 * and the final clamp-check -- and shifts redLine>>16 IN PLACE inside the parity branch's delay
 * slot, not as a fresh expr in the final compare; carIndex%2 (NOT flywheelRpm) feeds `increase`.
 * MATCH: SYM shows fsize=8/mask=0 with only 2 REG locals (no AUTO) -- a dead 8-byte filler
 * `deadfrm[2]` reproduces the frame (35->32 diffs, count now EXACT 52/52). Residual: the last
 * `*4` step of the `*0x8c` strength-reduction fuses into the odd-flywheelRpm branch's `>>1` in
 * ours (a1) vs the oracle materializing it unconditionally beforehand (v1) -- a gcc constant-
 * multiply/branch scheduling floor, not reachable by statement reordering alone (tried both
 * positions of the redLine shift + several algebraic rewrites, all tie or regress). ---- */
void AIPhysic_RevEngine(Car_tObj *carObj)
{
  int increase;
  int redLine;
  int deadfrm[2];   /* SYM fsize=8 mask=0 -- dead stack filler, no AUTO local recorded */

  redLine = carObj->redLine / 0x10000;
  increase = ((carObj->carIndex % 2 + 1) * AIPhysic_elapsedTime) * 0x8c;
  if ((carObj->flywheelRpm & 1) != 0) {
    increase = -(increase >> 1);
    if ((increase & 1) != 0) increase = increase - 1;
  }
  carObj->flywheelRpm = carObj->flywheelRpm + increase;
  if (redLine < carObj->flywheelRpm) {
    carObj->flywheelRpm = redLine / 2 | 1;
  }
  if (carObj->flywheelRpm < 0x1f5) {
    carObj->flywheelRpm = 500;
  }
  return;
}

/* ---- AIPhysic_HandleShifting__FP8Car_tObj ---- */
void AIPhysic_HandleShifting(Car_tObj *carObj)
{
  int desiredRPM;

  desiredRPM = 3000;
  if (carObj->aiShiftTimer > 0) {
    carObj->aiShiftTimer = carObj->aiShiftTimer - AIPhysic_elapsedTime;
  }
  else {
    Gear_t gear;
    int speed;
    int speedDiff;
    int baseRPM;
    int invGearSpeedRange;

    gear = AIPhysic_CalculateGear(carObj);
    speed = __builtin_abs(carObj->currentSpeed);
    speedDiff = speed - AIPhysic_GearBottomSpeed(carObj,gear);
    baseRPM = 0;
    if (2 < (int)gear) {
      baseRPM = 0xfa00000;
    }
    invGearSpeedRange = AIPhysic_GearInvSpeedRange(carObj,gear);
    if (speedDiff < 0) speedDiff += 0xff;
    speedDiff >>= 8;
    speedDiff *= invGearSpeedRange / 256;
    if (speedDiff < 0) speedDiff += 0xff;
    speedDiff >>= 8;
    desiredRPM = baseRPM + speedDiff * ((carObj->redLine - baseRPM) / 256);
    desiredRPM = desiredRPM / 0x10000;
    (carObj->control).gear = (char)gear;
  }
  if (carObj->flywheelRpm < desiredRPM) {
    carObj->flywheelRpm += (desiredRPM - carObj->flywheelRpm) / 8;
  }
  else if (desiredRPM < carObj->flywheelRpm) {
    carObj->flywheelRpm -= (carObj->flywheelRpm - desiredRPM) / 8;
  }
  return;
}

/* ---- AIPhysic_CalcAcceleration__FP8Car_tObji ---- */
int AIPhysic_CalcAcceleration(Car_tObj *carObj,int speed)
{
  int accelEntry;
  int acceleration;
  int absSpeed;
  int speedUpAcc;

  absSpeed = __builtin_abs(speed);
  if (0 < carObj->aiShiftTimer) {
    return 0;
  }
  {
    if (carObj->carInfo->carType < 0x16) {
      int normalTopCap;
      int upgradeTopCap;

      normalTopCap = Cars_topSpeedCap[carObj->carInfo->carType];
      upgradeTopCap = fixedmult(normalTopCap,carObj->topSpeedUpgradeMult);
      if (fixedmult(upgradeTopCap,carObj->aiGlue) < absSpeed) {
        goto ret0;
      }
      if (upgradeTopCap < absSpeed) {
        goto ret0;
      }
      if (normalTopCap < absSpeed) {
        absSpeed = normalTopCap + -0x238e3;
      }
    }
    accelEntry = absSpeed / 0x10000;
    if (0x6f < accelEntry) {
      accelEntry = 0x6f;
    }
    if (accelEntry < 0) {
      accelEntry = 0;
    }
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
    if ((((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&
        ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||
         ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) &&
       ((carObj->carFlags & 8U) != 0)) {
      acceleration = acceleration / 256 * (AITune_BTCPerpAccMults[GameSetup_gData.skill] / 256);
    }
    acceleration = AIPhysic_ModifyAccelerationAccordingToScript(carObj,acceleration);
    speedUpAcc = AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars(carObj);
    if (speedUpAcc != 0x10000) {
      acceleration = fixedmult(acceleration,speedUpAcc);
    }
  }
  return acceleration;
  /* NEAR-MISS 2 diffs, count-exact 184/184 (w11-a8, was 123): the final beqz's delay
     slot -- aspsx-2.77 fills it with the merge target's `addu v0,s0` (redundant-copy
     fill), maspsx unconditionally nops a reorder-mode branch slot. Catalog F
     maspsx-reorder-branch-slot FLOOR (TurnOff/TurnOn class); not source-reachable. */
ret0:
  return 0;
}

/* ---- AIPhysic_CheckDesiredDirection__FP8Car_tObj  (oracle keeps a dead carFlags&0x20-gated
 * GameSetup_gData.raceType read that Ghidra folded away -- §3.2c "folded gate/dead load";
 * turnAroundSpeed is the SYM-named REG local, always 0x8E38E in this build) ---- */
void AIPhysic_CheckDesiredDirection(Car_tObj *carObj)
{
  int turnAroundSpeed = 0x8e38e;
  if (carObj->carFlags & 0x20) {
    *(volatile int *)&GameSetup_gData.raceType;
  }
  if (carObj->speed < turnAroundSpeed) {
    carObj->direction = carObj->desiredDirection;
  }
  return;
  /* NEAR-MISS 8 diffs, count-exact 18/18 (w11-a8): oracle colors the dead raceType
     load dest v1 (separate from its v0 addr scratch) pushing turnAroundSpeed (SYM
     REG $5=a1) to a1; ours coalesces dead value into the addr reg (v0 self-temp),
     freeing v1 for turnAroundSpeed. Tried: bare volatile stmt, named local, pointer
     local, unsized-array read, volatile object, init-reorder, same-value folded
     store, cross-jump dup-tail (gcc deleted the whole block) — all self-temp. The
     retail separate-dest implies a value USE deleted post-regalloc (cross-jump/dbr)
     unreachable from source statement forms. Permuter candidate. */
}

/* ---- AIPhysic_Main__FP8Car_tObj ---- */
void AIPhysic_Main(Car_tObj *carObj)
{
  char useCoolPhysics;

  if (Sched_ExecuteCheck(1,1,(carObj->N).distToPlayer,(carObj->N).objID,&AIPhysic_time,
                     &AIPhysic_elapsedTime,&AIPhysic_iTime,carObj->forceNoSimOptz) == 0) {
    return;
  }
  if ((carObj->carFlags & 2U) != 0) {
    AIWorld_CalcSpeed(carObj);
  }
  AIPhysic_CheckDesiredDirection(carObj);
  AIPhysic_CheckForGripReduction(carObj);
  AIPhysic_HandleSignalling(carObj);
  carObj->lateralVelocity = AIWorld_CalcLateralVelocity(carObj);
  useCoolPhysics = AIPhysics_UseCoolPhysics(carObj);
  AIPhysic_CalculateRampedDesiredLatPos(carObj,(eRampType)(useCoolPhysics != 0));
  if ((carObj->AIFlags & 4U) != 0) {
    return;
  }
  if ((carObj->N).active == '\0') {
    return;
  }
  if (simGlobal[0] != 1) {
    AIPhysic_RevEngine(carObj);
    return;
  }
  AIPhysic_HandleShifting(carObj);
  if ((carObj->N).flightTime != 0) {
    if ((carObj->carFlags & 0x400U) == 0) {
      return;
    }
    AIPhysic_StopCar(carObj,0xfae1,0xfae1);
    return;
  }
  if (carObj->speed < 0x40000) {
    (carObj->linearVel_ch).z = 0;
    carObj->rearSkid = 0;
    carObj->frontSkid = 0;
  }
  if (((carObj->N).flightTime == 0) && ((carObj->N).orientMat.m[4] < 0x4ccc)) {
    goto stopSlow;
  }
  if (carObj->blowout != 0) {
    AIPhysic_StopCar(carObj,0xfd70,0xfae1);
    return;
  }
  if (carObj->pullOver != 0) {
    if (carObj->speed < 0x238e3) {
      AIPhysic_StopCar(carObj,0xe666,0xe666);
      return;
    }
    if (carObj->speed < 0x8e38e) {
      AIPhysic_StopCar(carObj,0xf5c2,0xfae1);
      return;
    }
  }
  if (((carObj->carFlags & 1U) != 0) && ((carObj->stats).finishType == 2)) {
    if (__builtin_abs(carObj->currentSpeed) < 0x20000) goto stopSlow;
  }
  if (carObj->desiredSpeed == 0) {
stopSlow:
    AIPhysic_StopCar(carObj,0xf0a3,0xfae1);
    return;
  }
  if (useCoolPhysics != 0) {
    AIPhysic_CoolPhysics(carObj);
  }
  else {
    AIPhysic_SimplePhysics(carObj);
  }
  AIPhysic_CheckForBadPosition(carObj);
  AIPhysic_HandleWipeoutTimer(carObj);
  return;
}

/* ---- AIPhysic_SimplePhysics__FP8Car_tObj ---- */
void AIPhysic_SimplePhysics(Car_tObj *carObj)
{
  coorddef forward;
  coorddef right;
  int speed;
  int sliceLookAhead;

  if ((carObj->AIFlags & 0x10U) != 0) {
    carObj->rampDesiredLatPos = carObj->roadPosition;
    carObj->AIFlags = carObj->AIFlags & 0xffffffef;
  }
  if (((((carObj->carFlags & 8U) != 0) && (simGlobal[1] > carObj->wipeOutStartTick)) &&
      (0x1e < AIDataRecord_TrackCurve->Get((int)(carObj->N).simRoadInfo.slice))
      ) && (0x1638e3 < carObj->speed)) {
    carObj->wipeOutEndTick = simGlobal[1] + 0x180;
  }
  AIPhysic_SimplePhysics_LongVel(carObj);
  AIPhysic_SimplePhysics_LatVel(carObj);
  forward = *(coorddef *)&(carObj->N).orientMat.m[6];
  right = *(coorddef *)&(carObj->N).roadMatrix.m[0];
  right.x = fixedmult(carObj->laneChangeSpeed,right.x);
  right.y = fixedmult(carObj->laneChangeSpeed,right.y);
  right.z = fixedmult(carObj->laneChangeSpeed,right.z);
  forward.x = fixedmult(carObj->currentSpeed * carObj->direction,forward.x);
  forward.y = fixedmult(carObj->currentSpeed * carObj->direction,forward.y);
  forward.z = fixedmult(carObj->currentSpeed * carObj->direction,forward.z);
  (carObj->N).linearVel.x = forward.x + right.x;
  (carObj->N).linearVel.y = forward.y + right.y;
  (carObj->N).linearVel.z = forward.z + right.z;
  (carObj->linearVel_ch).z = carObj->speed;
  {
    int lat = carObj->laneChangeSpeed * carObj->direction;
    (carObj->linearVel_ch).x = lat;
    {
      int a = __builtin_abs(lat);
      if (a / 256 * 0x19 < a) {
        carObj->slide = 0x8000;
      }
      else {
        carObj->slide = 0;
      }
    }
  }
  speed = carObj->speed;
  (carObj->N).angularVel.x = 0;
  (carObj->N).angularVel.y = 0;
  (carObj->N).angularVel.z = 0;
  if (0x30000 < speed) {
    Newton_CopyRoadMatrixToOrientMat(&carObj->N,(u_int)(carObj->direction == -1));
  }
  {
    int cs = __builtin_abs(carObj->currentSpeed);
    sliceLookAhead = cs / 0x60000;
    if (-1 < sliceLookAhead) {
      if ((sliceLookAhead < AIPhysicConfig.min_lookahead / 6) && (-1 < cs)) {
        sliceLookAhead = AIPhysicConfig.min_lookahead / 6;
      }
    }
    if (AIPhysicConfig.max_lookahead / 6 < sliceLookAhead) {
      sliceLookAhead = AIPhysicConfig.max_lookahead / 6;
    }
  }
  if (!(sliceLookAhead * carObj->direction < 0)) {
    int v = (carObj->N).simRoadInfo.slice + sliceLookAhead * carObj->direction;
    if (!(v < gNumSlices)) {
      v = v - gNumSlices;
    }
    carObj->lookAheadSlice = v;
  }
  else {
    int v = (carObj->N).simRoadInfo.slice + sliceLookAhead * carObj->direction;
    if (v < 0) {
      v = v + gNumSlices;
    }
    carObj->lookAheadSlice = v;
  }
  return;
}

/* ---- AIPhysic_SimplePhysics_LongVel__FP8Car_tObj ---- */
void AIPhysic_SimplePhysics_LongVel(Car_tObj *carObj)
{
  int acceleration;
  int deceleration;
  int t;

  acceleration = AIPhysic_CalcAcceleration(carObj,carObj->currentSpeed);
  deceleration = AIPhysic_CalcDeceleration(carObj);
  if (carObj->pullOver != 0) {
    carObj->desiredSpeed = 0;
  }
  if (simGlobal[1] < carObj->wipeOutEndTick) {
    carObj->desiredSpeed = carObj->desiredSpeed / 4;
  }
  if (carObj->direction == -1) {
    if ((carObj->desiredSpeed > carObj->currentSpeed) || (carObj->desiredDirection != -1)) {
      (carObj->linearAcc_ch).z = deceleration;
      {
        int level = (carObj->control).brakeLevel + AIPhysic_elapsedTime * 4;
        if (level < 0xff) {
          (carObj->control).brakeLevel = level;
        }
        else {
          (carObj->control).brakeLevel = 0xff;
        }
      }
      if (3U < (u_char)(carObj->control).brakeLevel) {
        (carObj->control).desiredBrakeLevel = 1;
      }
      {
        int newSpeed = carObj->currentSpeed + deceleration / 256 * (AIPhysic_iTime / 256);
        carObj->currentSpeed = newSpeed;
        if (carObj->direction != carObj->desiredDirection) {
          return;
        }
        t = carObj->desiredSpeed;
        if (!(t < newSpeed)) t = newSpeed;
        carObj->currentSpeed = t;
        /* NEAR-MISS 5 diffs 213/214 (w11-a8, was 231): oracle loads desiredSpeed into
           v0 then copies to t=v1 (uncoalesced); ours coalesces the load into t. Tried
           two-local init, ternary, both-assign if/else, fn-scope t - all coalesce or
           regress. 1-insn copy class. Correctness fixed: brakeLevel +=elapsed*4
           saturate & -=elapsed release were MISSING in the old recon (Ghidra fold). */
      }
    }
    else {
      carObj->currentSpeed -= acceleration / 256 * (AIPhysic_iTime / 256);
      if (AIPhysic_elapsedTime < (carObj->control).brakeLevel) {
        (carObj->control).brakeLevel = (carObj->control).brakeLevel - AIPhysic_elapsedTime;
      }
      else {
        (carObj->control).brakeLevel = 0;
      }
      if ((carObj->control).brakeLevel == 0) {
        (carObj->control).desiredBrakeLevel = 0;
      }
      (carObj->linearAcc_ch).z = acceleration;
      if (carObj->currentSpeed < carObj->desiredSpeed) {
        carObj->currentSpeed = carObj->desiredSpeed;
      }
    }
  }
  else {
    if ((carObj->desiredSpeed < carObj->currentSpeed) || (carObj->direction != carObj->desiredDirection)) {
      (carObj->linearAcc_ch).z = deceleration;
      {
        int level = (carObj->control).brakeLevel + AIPhysic_elapsedTime * 4;
        if (level < 0xff) {
          (carObj->control).brakeLevel = level;
        }
        else {
          (carObj->control).brakeLevel = 0xff;
        }
      }
      if (3U < (u_char)(carObj->control).brakeLevel) {
        (carObj->control).desiredBrakeLevel = 1;
      }
      {
        int newSpeed = carObj->currentSpeed - deceleration / 256 * (AIPhysic_iTime / 256);
        carObj->currentSpeed = newSpeed;
        if (carObj->direction != carObj->desiredDirection) {
          return;
        }
        t = carObj->desiredSpeed;
        if (t < newSpeed) t = newSpeed;
        carObj->currentSpeed = t;
      }
    }
    else {
      carObj->currentSpeed += acceleration / 256 * (AIPhysic_iTime / 256);
      if (AIPhysic_elapsedTime < (carObj->control).brakeLevel) {
        (carObj->control).brakeLevel = (carObj->control).brakeLevel - AIPhysic_elapsedTime;
      }
      else {
        (carObj->control).brakeLevel = 0;
      }
      if ((carObj->control).brakeLevel == 0) {
        (carObj->control).desiredBrakeLevel = 0;
      }
      (carObj->linearAcc_ch).z = acceleration;
      if (carObj->currentSpeed > carObj->desiredSpeed) {
        carObj->currentSpeed = carObj->desiredSpeed;
      }
    }
  }
  return;
}

/* ---- AIPhysic_Preperation__FP8Car_tObj ---- */
void AIPhysic_Preperation(Car_tObj *carObj)
{
  coorddef forward;
  int aCar;
  int aCarWRTDesired;
  int aDesired;

  (carObj->linearVel_ch).x = fixedmult((carObj->N).linearVel.x,(carObj->N).orientMat.m[0]) +
      fixedmult((carObj->N).linearVel.y,(carObj->N).orientMat.m[1]) +
      fixedmult((carObj->N).linearVel.z,(carObj->N).orientMat.m[2]);
  (carObj->linearVel_ch).y = fixedmult((carObj->N).linearVel.x,(carObj->N).orientMat.m[3]) +
      fixedmult((carObj->N).linearVel.y,(carObj->N).orientMat.m[4]) +
      fixedmult((carObj->N).linearVel.z,(carObj->N).orientMat.m[5]);
  (carObj->linearVel_ch).z = fixedmult((carObj->N).linearVel.x,(carObj->N).orientMat.m[6]) +
      fixedmult((carObj->N).linearVel.y,(carObj->N).orientMat.m[7]) +
      fixedmult((carObj->N).linearVel.z,(carObj->N).orientMat.m[8]);
  (carObj->angularVel_ch).x = fixedmult((carObj->N).angularVel.x,(carObj->N).orientMat.m[0]) +
      fixedmult((carObj->N).angularVel.y,(carObj->N).orientMat.m[1]) +
      fixedmult((carObj->N).angularVel.z,(carObj->N).orientMat.m[2]);
  (carObj->angularVel_ch).y = fixedmult((carObj->N).angularVel.x,(carObj->N).orientMat.m[3]) +
      fixedmult((carObj->N).angularVel.y,(carObj->N).orientMat.m[4]) +
      fixedmult((carObj->N).angularVel.z,(carObj->N).orientMat.m[5]);
  (carObj->angularVel_ch).z = fixedmult((carObj->N).angularVel.x,(carObj->N).orientMat.m[6]) +
      fixedmult((carObj->N).angularVel.y,(carObj->N).orientMat.m[7]) +
      fixedmult((carObj->N).angularVel.z,(carObj->N).orientMat.m[8]);
  {
    int lat = __builtin_abs((carObj->linearVel_ch).x);
    if (lat / 256 * 0x19 < lat) {
      carObj->slide = 0x8000;
    }
    else {
      carObj->slide = 0;
    }
  }
  forward = *(coorddef *)&(carObj->N).orientMat.m[6];
  if (carObj->driveDirection == 1) {
    aCar = intatan(forward.x,forward.z);
  }
  else {
    aCar = intatan(-forward.x,-forward.z);
  }
  carObj->aCar = aCar;
  AIPhysic_GetDesiredVector(carObj);
  aDesired = intatan((carObj->desiredVector).x,(carObj->desiredVector).z);
  aCarWRTDesired = aCar - aDesired;
  if (aCarWRTDesired < -0x200) {
    carObj->aCarWRTDesired = aCarWRTDesired + 0x400;
  }
  else {
    carObj->aCarWRTDesired = aCarWRTDesired;
    if (!(aCarWRTDesired < 0x201)) {
      carObj->aCarWRTDesired = aCarWRTDesired + -0x400;
    }
  }
  carObj->aDesired = aDesired;
  return;
}

/* ---- AIPhysic_GetDesiredVector__FP8Car_tObj ---- */
void AIPhysic_GetDesiredVector(Car_tObj *carObj)
{
  int speed;
  int roadWidth;
  int sliceLookAhead;
  int dirCorrectedSliceLookAhead;
  coorddef fCPoint;
  coorddef fPoint;
  coorddef right;
  int futureBend;
  int futureRoadPosition;
  int numReductions;
  int goodVector;
  int thisSlice;
  int checkSide;

  thisSlice = (int)(carObj->N).simRoadInfo.slice;
  numReductions = 0;
  if ((((carObj->targetPos).x != 0) || ((carObj->targetPos).y != 0)) || ((carObj->targetPos).z != 0)
     ) {
    AIPhysic_TargetedGetDesiredVector(carObj);
    return;
  }
  speed = __builtin_abs(carObj->currentSpeed);
  sliceLookAhead = (fixedmult(speed,0xb333) + 0x30000) / 0x60000;
  if (((-1 < sliceLookAhead) && (sliceLookAhead < AIPhysicConfig.min_lookahead / 6)) && (-1 < speed)) {
    sliceLookAhead = AIPhysicConfig.min_lookahead / 6;
  }
  if (AIPhysicConfig.max_lookahead / 6 < sliceLookAhead) {
    sliceLookAhead = AIPhysicConfig.max_lookahead / 6;
  }
  dirCorrectedSliceLookAhead = sliceLookAhead * carObj->driveDirection * carObj->direction;
  if (!(dirCorrectedSliceLookAhead < 0)) {
    int v = thisSlice + dirCorrectedSliceLookAhead;
    if (!(v < gNumSlices)) {
      v = v - gNumSlices;
    }
    carObj->lookAheadSlice = v;
  }
  else {
    int v = thisSlice + dirCorrectedSliceLookAhead;
    if (v < 0) {
      v = v + gNumSlices;
    }
    carObj->lookAheadSlice = v;
  }
  futureBend = __builtin_abs(AIWorld_CalcRoadBend(carObj,dirCorrectedSliceLookAhead));
  {
    int sl = carObj->lookAheadSlice * 0x20 + (int)BWorldSm_slices;
    roadWidth = (u_int)(*(u_char *)(sl + 0x1e) << 15) * (u_int)(*(u_char *)(sl + 0x1d) >> 4) +
                (u_int)(*(u_char *)(sl + 0x1f) << 15) * (*(u_char *)(sl + 0x1d) & 0xf);
  }
  if (roadWidth < 0x120000) {
    if (0xf333 < futureBend) {
      sliceLookAhead = sliceLookAhead * 0xca3d / 0x10000;
    }
    if (0xe666 < futureBend) {
      sliceLookAhead = sliceLookAhead * 0xd70a / 0x10000;
    }
    else if (0xcccc < futureBend) {
      sliceLookAhead = sliceLookAhead * 0xe666 / 0x10000;
    }
    else if (0xc000 < futureBend) {
      sliceLookAhead = sliceLookAhead * 0xf333 / 0x10000;
    }
  }
  do {
    dirCorrectedSliceLookAhead = sliceLookAhead * carObj->driveDirection * carObj->direction;
    if (!(dirCorrectedSliceLookAhead < 0)) {
      int v = thisSlice + dirCorrectedSliceLookAhead;
      if (!(v < gNumSlices)) {
        v = v - gNumSlices;
      }
      carObj->lookAheadSlice = v;
    }
    else {
      int v = thisSlice + dirCorrectedSliceLookAhead;
      if (v < 0) {
        v = v + gNumSlices;
      }
      carObj->lookAheadSlice = v;
    }
    fCPoint = *(coorddef *)(carObj->lookAheadSlice * 0x20 + (int)BWorldSm_slices);
    right.x = (int)*(signed char *)(carObj->lookAheadSlice * 0x20 + (int)BWorldSm_slices + 0x12) << 9;
    right.y = (int)*(signed char *)(carObj->lookAheadSlice * 0x20 + (int)BWorldSm_slices + 0x13) << 9;
    right.z = (int)*(signed char *)(carObj->lookAheadSlice * 0x20 + (int)BWorldSm_slices + 0x14) << 9;
    fPoint.x = fixedmult(carObj->rampDesiredLatPos,right.x);
    fPoint.y = fixedmult(carObj->rampDesiredLatPos,right.y);
    fPoint.z = fixedmult(carObj->rampDesiredLatPos,right.z);
    fPoint.x = fPoint.x + fCPoint.x;
    fPoint.y = fPoint.y + fCPoint.y;
    fPoint.z = fPoint.z + fCPoint.z;
    futureRoadPosition = AIPhysic_CalculateRoadPosition(&fPoint,thisSlice);
    {
      int sl = thisSlice * 0x20 + (int)BWorldSm_slices;
      if ((((int)((u_int)(*(u_char *)(sl + 0x1f) << 15) * (*(u_char *)(sl + 0x1d) & 0xf)) < futureRoadPosition)
          && (carObj->roadPosition < futureRoadPosition)) ||
         ((futureRoadPosition < (int)-((u_int)(*(u_char *)(sl + 0x1e) << 15) *
                         (u_int)(*(u_char *)(sl + 0x1d) >> 4))) && (futureRoadPosition < carObj->roadPosition))) {
        checkSide = 1;
        if (futureRoadPosition < carObj->roadPosition) {
          checkSide = -1;
        }
        if (AIWorld_IsDriveableLane(thisSlice,AIWorld_LaneIndex(thisSlice,carObj->roadPosition + checkSide * 0x80000)) != 0) {
          goodVector = AIWorld_IsDriveableLane(thisSlice,AIWorld_LaneIndex(thisSlice,carObj->roadPosition + checkSide * 0x40000)) != 0;
        }
        else {
          goodVector = 0;
        }
      }
      else {
        goodVector = 1;
      }
    }
    numReductions = numReductions + 1;
    sliceLookAhead = sliceLookAhead * 0xcccc;
    sliceLookAhead = sliceLookAhead / 0x10000;
    {
      int t = 4;
      if (!(sliceLookAhead < 4)) t = sliceLookAhead;
      sliceLookAhead = t;
    }
  } while ((numReductions < 5) && (goodVector == 0));
  (carObj->desiredVector).x = fPoint.x - (carObj->N).position.x;
  (carObj->desiredVector).y = fPoint.y - (carObj->N).position.y;
  (carObj->desiredVector).z = fPoint.z - (carObj->N).position.z;
  return;
}

/* ---- AIPhysic_CheckIfOutOfControl__FP8Car_tObj ---- */
int AIPhysic_CheckIfOutOfControl(Car_tObj *carObj)
{
  int futureBend;

  /* MATCH: every abs here is __builtin_abs -- gcc emits the single-insn assembler
     `abs' macro (bgez/negu with move in the slot), so loads schedule around it;
     branchy if(x<0)x=-x forms split the block and mis-schedule (w11-a8) */
  futureBend = __builtin_abs(AIWorld_CalcRoadBend(carObj,carObj->direction << 3));
  if (simGlobal[1] < carObj->wipeOutEndTick) {
    return (0x2ffff < __builtin_abs(carObj->currentSpeed)) ^ 1;
  }
  if ((__builtin_abs(carObj->aCarWRTDesired) < 0x74) && (carObj->driveDirection != -1)) {
    int iVar3;

    if (__builtin_abs(carObj->currentSpeed) < AIPhysicConfig.OOCModel.vel_limit_range + -0x30000) {
      return 1;
    }
    iVar3 = (carObj->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices;
    if (carObj->roadPosition <
        (int)-((u_int)(*(u_char *)(iVar3 + 0x1e) << 15) * (u_int)(*(u_char *)(iVar3 + 0x1d) >> 4))) {
      return 1;
    }
    if ((int)((u_int)(*(u_char *)(iVar3 + 0x1f) << 15) * (u_int)(*(u_char *)(iVar3 + 0x1d) & 0xf)) <
        carObj->roadPosition) {
      return 1;
    }
    if (0xcccc < futureBend) {
      return 1;
    }
    {
      int lat = (carObj->linearVel_ch).x;
      int spd = carObj->speed;
      if (__builtin_abs(lat) > spd / 256 * 0x66) {
        if (0xeffff < __builtin_abs(carObj->currentSpeed)) {
          goto ret0;
        }
        goto ret1;
      }
ret0:
      return 0;
    }
  }
ret1:
  return 1;
  /* NEAR-MISS 20 diffs, count-exact 104/104 (w11-a8, was 96): residuals = (a) a3/t0
     allocation-order swap between futureBend (SYM $7=a3) and the CSE'd
     abs(currentSpeed) temp -- priority tie the source can't flip without breaking
     the CSE the oracle keeps; (b) EFFFF-test bnez-vs-beqz jump-around-jump
     canonicalization + ret0/ret1 block placement. Permuter candidate. */
}

/* ---- AIPhysic_OutOfControlPhysics__FP8Car_tObj ---- */
void AIPhysic_OutOfControlPhysics(Car_tObj *carObj)
{
  /* Rule-8 rewrite w13-a4: SYM 8c block @0x8006B400 (fsize 0x30, mask $803f0000, carObj REGPARM $s1).
   * Oracle holds &AIPhysicConfig in $s0 across the head calls (cluster 1: latvelcalc_lookahead,
   * dangle/max_dav, max_dlvel, vel_limit_range, lat/ang factors) -> block-local cfg pointer;
   * later accesses (dav_to_aa, dlvel_to_clacc, targetVel vel_limit_range, skid_value) are fresh
   * caller-saved rematerializations -> direct AIPhysicConfig globals. */
  int desiredAngVel;
  int desiredLatVel;
  int currentAngAcc;
  int currentLatAcc;
  int currentLongAcc;
  int maxLatVel;
  int maxAngVel;
  int skid;
  int dir;
  int currentLatVel;
  int latVelLimit;
  int targetVel;
  int uTurn;
  int currentVel;

  carObj->drag = 0;
  uTurn = 0;
  currentLatVel = AIWorld_CalcFutureLateralVel(carObj,carObj->direction * AIPhysicConfig.latvelcalc_lookahead);
  if (carObj->direction * carObj->currentSpeed < 0) {
    uTurn = carObj->driveDirection != -1;
  }
  carObj->wipeOutEndTick = simGlobal[1];
  desiredAngVel = -carObj->aCarWRTDesired * fixedmult(0x80,AIPhysicConfig.OOCModel.dangle_to_dav);
  desiredAngVel = (desiredAngVel < AIPhysicConfig.OOCModel.max_dav)
      ? desiredAngVel : AIPhysicConfig.OOCModel.max_dav;
  {
    int r;
    r = -AIPhysicConfig.OOCModel.max_dav;
    if (r < desiredAngVel) r = desiredAngVel;
    desiredAngVel = r;
  }
  desiredLatVel = (desiredAngVel / 256) * 0xa00;
  desiredLatVel = (desiredLatVel < AIPhysicConfig.OOCModel.max_dlvel)
      ? desiredLatVel : AIPhysicConfig.OOCModel.max_dlvel;
  {
    int r;
    r = -AIPhysicConfig.OOCModel.max_dlvel;
    if (r < desiredLatVel) r = desiredLatVel;
    desiredLatVel = r;
  }
  desiredLatVel = (desiredLatVel < carObj->speed) ? desiredLatVel : carObj->speed;
  {
    int r;
    r = -carObj->speed;
    if (r < desiredLatVel) r = desiredLatVel;
    desiredLatVel = r;
  }
  if ((-AIPhysicConfig.OOCModel.vel_limit_range < carObj->currentSpeed) &&
      (carObj->currentSpeed < AIPhysicConfig.OOCModel.vel_limit_range)) {
    maxLatVel = (carObj->speed / 256) * (AIPhysicConfig.OOCModel.lat_vel_limit_factor / 256);
    maxLatVel = __builtin_abs(maxLatVel);
    desiredLatVel = (desiredLatVel < maxLatVel) ? desiredLatVel : maxLatVel;
    {
      int r;
      r = -maxLatVel;
      if (r < desiredLatVel) r = desiredLatVel;
      desiredLatVel = r;
    }
    maxAngVel = (carObj->speed / 256) * (AIPhysicConfig.OOCModel.ang_vel_limit_factor / 256);
    maxAngVel = __builtin_abs(maxAngVel);
    desiredAngVel = (desiredAngVel < maxAngVel) ? desiredAngVel : maxAngVel;
    {
      int r;
      r = -maxAngVel;
      if (r < desiredAngVel) r = desiredAngVel;
      desiredAngVel = r;
    }
  }
  if (carObj->donutMode == 2) {
    desiredAngVel = desiredAngVel * 5;
  }
  currentAngAcc = -((((carObj->angularVel_ch).y - desiredAngVel) / 256) *
                    (AIPhysicConfig.OOCModel.dav_to_aa / 256));
  if (0x120000 < __builtin_abs(carObj->currentSpeed)) {
    currentAngAcc = currentAngAcc / 2;
  }
  currentAngAcc = (currentAngAcc < carObj->max_aa) ? currentAngAcc : carObj->max_aa;
  {
    int r;
    r = -carObj->max_aa;
    if (r < currentAngAcc) r = currentAngAcc;
    currentAngAcc = r;
  }
  currentLatAcc = -((((carObj->linearVel_ch).x - desiredLatVel) / 256) *
                    (AIPhysicConfig.OOCModel.dlvel_to_clacc / 256));
  currentLatAcc = (currentLatAcc < carObj->max_clacc) ? currentLatAcc : carObj->max_clacc;
  {
    int r;
    r = -carObj->max_clacc;
    if (r < currentLatAcc) r = currentLatAcc;
    currentLatAcc = r;
  }
  currentVel = (carObj->linearVel_ch).z;
  if (((carObj->driveDirection == -1) && ((carObj->targetPos).x == 0)) &&
      ((carObj->targetPos).y == 0) && ((carObj->targetPos).z == 0)) {
    targetVel = -AIPhysicConfig.OOCModel.vel_limit_range;
  }
  else {
    targetVel = carObj->desiredSpeed * carObj->direction * carObj->driveDirection;
  }
  if (carObj->pullOver == 0) {
    if (-1 < targetVel) {
      if (!(currentVel < -0x20000) && (currentVel <= targetVel)) goto LAB_8006b814;
    }
    else if ((targetVel <= currentVel) && (currentVel < 0x20001)) {
LAB_8006b814:
      if (carObj->desiredDirection == carObj->direction) {
        currentLongAcc = AIPhysic_CalcAcceleration(carObj,(carObj->linearVel_ch).z) *
                         carObj->driveDirection;
        if (AIPhysic_elapsedTime < (carObj->control).brakeLevel) {
          (carObj->control).brakeLevel = (carObj->control).brakeLevel - AIPhysic_elapsedTime;
        }
        else {
          (carObj->control).brakeLevel = 0;
        }
        if ((carObj->control).brakeLevel == 0) {
          (carObj->control).desiredBrakeLevel = 0;
        }
        goto LAB_8006b908;
      }
    }
  }
  currentLongAcc = 0;
  if (0 < __builtin_abs((carObj->linearVel_ch).z)) {
    currentLongAcc = -AIPhysic_CalcDeceleration(carObj);
    if ((carObj->control).brakeLevel + AIPhysic_elapsedTime * 4 < 0xff) {
      (carObj->control).brakeLevel = (carObj->control).brakeLevel + AIPhysic_elapsedTime * 4;
    }
    else {
      (carObj->control).brakeLevel = 0xff;
    }
    if (3 < (u_char)(carObj->control).brakeLevel) {
      (carObj->control).desiredBrakeLevel = 1;
    }
    if ((carObj->linearVel_ch).z < 0) {
      currentLongAcc = -currentLongAcc;
    }
  }
LAB_8006b908:
  if (uTurn != 0) {
    if (carObj->speed - 0x140001U < 0x1dffff) {
      currentAngAcc = currentAngAcc / 4;
      currentLongAcc = currentLongAcc / 4;
    }
    else {
      currentAngAcc = fixedmult(currentAngAcc,0xc000);
      currentLongAcc = currentLongAcc / 2 + currentLongAcc / 4;
    }
    currentLatAcc = currentLatAcc / 4 + currentLatAcc / 8;
  }
  skid = __builtin_abs(currentLatVel) - AIPhysicConfig.skid_value;
  if (((carObj->direction * carObj->currentSpeed < 0) && (0x38e38 < carObj->speed)) ||
      (carObj->donutMode != 0)) {
    carObj->frontSkid = 0xa0000;
    carObj->rearSkid = 0xa0000;
  }
  else if (0 < skid) {
    carObj->frontSkid = skid;
    carObj->rearSkid = skid;
  }
  else {
    carObj->rearSkid = 0;
    carObj->frontSkid = 0;
  }
  (carObj->linearAcc_ch).x = currentLatAcc;
  (carObj->linearAcc_ch).y = 0;
  (carObj->linearAcc_ch).z = currentLongAcc;
  (carObj->linearAcc_rh).x = 0;
  (carObj->linearAcc_rh).y = 0;
  (carObj->linearAcc_rh).z = 0;
  (carObj->angularAcc).x = 0;
  (carObj->angularAcc).y = currentAngAcc;
  (carObj->angularAcc).z = 0;
  return;
}

/* ---- AIPhysic_InControlPhysics__FP8Car_tObj ---- */
void AIPhysic_InControlPhysics(Car_tObj *carObj)
{
  /* Rule-8 rewrite w13-a4: SYM 8c block @0x8006BAC8 (fsize 0x70, mask $c0ff0000, carObj REGPARM $s2).
   * Statics: copCollisionReactionTime @0x8013C590 (BSS), copCollisionGripLoss @0x8010DC54,
   * copCollisionSlowDown @0x8010DC64 (.data). All named locals per SYM AUTO/REG records. */
  static char copCollisionReactionTime[4];
  static int copCollisionGripLoss[4];
  static int copCollisionSlowDown[4];
  int currentLatVel;
  int currentLatPos;
  int desiredLatPos;
  int deltaLatPos;
  int desiredAngVel;
  int currentAngAcc;
  int desiredLatVel;
  int currentLatAcc;
  int currentLongAcc;
  int maxAngularAcceleration;
  int angleWRTdesired;
  int skid;
  int dir;
  int gripMultiplier;
  int maxLateralAcceleration;
  int dlvel_to_clacc;
  int desiredSpeed;
  int justBumped;
  coorddef unitDesiredVector;
  coorddef unitDesiredVectorRight;
  int lastCollisionTickDiff;
  int copCollisionFirmness;

  dir = carObj->direction;
  carObj->drag = 0;
  unitDesiredVector = carObj->desiredVector;
  Math_QDNormalizeVector(&unitDesiredVector);
  justBumped = 0;
  unitDesiredVectorRight.x = unitDesiredVector.z;
  unitDesiredVectorRight.y = unitDesiredVector.y;
  unitDesiredVectorRight.z = -unitDesiredVector.x;
  skid = 0;
  currentLatVel = (fixedmult((carObj->N).linearVel.x,unitDesiredVectorRight.x) +
                   fixedmult((carObj->N).linearVel.y,unitDesiredVectorRight.y) +
                   fixedmult((carObj->N).linearVel.z,unitDesiredVectorRight.z)) * carObj->direction;
  maxAngularAcceleration = carObj->max_aa;
  currentLatPos = carObj->roadPosition;
  desiredLatPos = carObj->rampDesiredLatPos;
  deltaLatPos = currentLatPos - desiredLatPos;
  gripMultiplier = fixedmult((carObj->linearVel_ch).z,0x62);
  gripMultiplier = fixedmult(gripMultiplier + 0x10000,carObj->gripFactor);
  if ((carObj->carFlags & 8U) != 0) {
    if (simGlobal[1] > carObj->wipeOutStartTick) {
      if ((1000 < __builtin_abs((carObj->N).angularVel.y)) && (0x1638e3 < carObj->speed)) {
        carObj->wipeOutEndTick = simGlobal[1] + 0x180;
      }
    }
  }
  lastCollisionTickDiff = simGlobal[1] - (carObj->N).collision.lastTime;
  if ((AIScript_DoReAction(&carObj->script,(AIScript_tAIReaction)0x800) != -1) ||
      (simGlobal[1] < carObj->wipeOutEndTick)) {
    int vely;
    maxAngularAcceleration = 0;
    if (simGlobal[1] - (carObj->N).collision.lastTime < 0x40) {
      carObj->wipeOutEndTick = simGlobal[1];
    }
    gripMultiplier = 0;
    vely = (carObj->N).angularVel.y;
    vely = __builtin_abs(vely);
    vely = vely + 0x1ca;
    if (0x3333 < vely) {
      vely = 0x3333;
    }
    if (0 < (carObj->N).angularVel.y) {
      (carObj->N).angularVel.y = vely;
    }
    else {
      (carObj->N).angularVel.y = -vely;
    }
    skid = 0xa0000;
  }
  copCollisionFirmness = GameSetup_gData.skill;
  if (lastCollisionTickDiff < 0x10) {
    carObj->wipeOutStartTick = carObj->wipeOutStartTick - 0x14;
  }
  if (((lastCollisionTickDiff < copCollisionReactionTime[copCollisionFirmness]) &&
       ((carObj->N).collision.lastOtherObj != (BO_tNewtonObj *)0x0)) &&
      ((((Car_tObj *)(carObj->N).collision.lastOtherObj)->carFlags & 0x200U) != 0)) {
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
  angleWRTdesired = carObj->aCarWRTDesired;
  desiredSpeed = carObj->desiredSpeed;
  if (carObj->AIFishtailEndTick > simGlobal[1]) {
    int fishtailtick;
    int signAngle;
    signAngle = 1;
    fishtailtick = carObj->AIFishtailEndTick - simGlobal[1];
    if ((simGlobal[1] / 0x28 & 1U) != 0) {
      signAngle = -1;
    }
    if (0x96 - fishtailtick < 0x32) {
      int r;
      r = signAngle * 0x1e;   /* stmt boundary blocks reassociation */
      angleWRTdesired += r * (0x96 - fishtailtick) / 0x32;
    }
    else {
      angleWRTdesired += signAngle * (fishtailtick / 7 + 10);
    }
    if (0x32 < fishtailtick) {
      skid = (fishtailtick * 0x140000) / 0x32;
    }
  }
  else {
    if (((*(int *)((char *)carObj->personality + 0x2c) < __builtin_abs(angleWRTdesired)) &&
         (0 < angleWRTdesired * (carObj->angularAcc).y)) &&
        (__builtin_abs(angleWRTdesired) << 0x10 >
         (0x10000 - AIPhysic_GetRearEndDamageFactor(carObj)) * 0x14 +
         (*(int *)((char *)carObj->personality + 0x2c) - 0x14) * 0x10000)) {
      carObj->AIFishtailEndTick = simGlobal[1] + 0x96;
    }
  }
  desiredAngVel = -angleWRTdesired * fixedmult(0x80,AIPhysicConfig.ICModel.dangle_to_dav);
  desiredAngVel = (desiredAngVel < AIPhysicConfig.ICModel.max_dav)
      ? desiredAngVel : AIPhysicConfig.ICModel.max_dav;
  {
    int r;
    r = -AIPhysicConfig.ICModel.max_dav;
    if (r < desiredAngVel) r = desiredAngVel;
    desiredAngVel = r;
  }
  desiredLatVel = -((deltaLatPos / 256) * (AIPhysicConfig.ICModel.dlpos_to_dlvel / 256));
  desiredLatVel = (desiredLatVel < AIPhysicConfig.ICModel.max_dlvel)
      ? desiredLatVel : AIPhysicConfig.ICModel.max_dlvel;
  {
    int r;
    r = -AIPhysicConfig.ICModel.max_dlvel;
    if (r < desiredLatVel) r = desiredLatVel;
    desiredLatVel = r;
  }
  desiredLatVel = (desiredLatVel < carObj->speed) ? desiredLatVel : carObj->speed;
  {
    int r;
    r = -carObj->speed;
    if (r < desiredLatVel) r = desiredLatVel;
    desiredLatVel = r;
  }
  if ((-AIPhysicConfig.ICModel.vel_limit_range < carObj->currentSpeed) &&
      (carObj->currentSpeed < AIPhysicConfig.ICModel.vel_limit_range)) {
    int maxLatVel;
    int maxAngVel;
    maxLatVel = (carObj->speed / 256) * (AIPhysicConfig.ICModel.lat_vel_limit_factor / 256);
    maxLatVel = __builtin_abs(maxLatVel);
    {
      int r;
      r = maxLatVel;
      if (desiredLatVel < maxLatVel) r = desiredLatVel;
      __asm__("" : : "r" (r), "r" (maxLatVel));  /* liveness fence: original keeps the dead lat clamp */
    }
    maxAngVel = (carObj->speed / 256) * (AIPhysicConfig.ICModel.ang_vel_limit_factor / 256);
    maxAngVel = __builtin_abs(maxAngVel);
    desiredAngVel = (desiredAngVel < maxAngVel) ? desiredAngVel : maxAngVel;
    {
      int r;
      r = -maxAngVel;
      if (r < desiredAngVel) r = desiredAngVel;
      desiredAngVel = r;
    }
  }
  currentAngAcc = -fixedmult((carObj->angularVel_ch).y - desiredAngVel,AIPhysicConfig.ICModel.dav_to_aa);
  currentAngAcc = (currentAngAcc < maxAngularAcceleration)
      ? currentAngAcc : maxAngularAcceleration;
  {
    int r;
    r = -maxAngularAcceleration;
    if (r < currentAngAcc) r = currentAngAcc;
    currentAngAcc = r;
  }
  currentLatAcc = -dir * fixedmult(currentLatVel,dlvel_to_clacc);
  currentLatAcc = (currentLatAcc < maxLateralAcceleration)
      ? currentLatAcc : maxLateralAcceleration;
  {
    int r;
    r = -maxLateralAcceleration;
    if (r < currentLatAcc) r = currentLatAcc;
    currentLatAcc = r;
  }
  if (((desiredSpeed * dir > carObj->currentSpeed * dir) && (carObj->pullOver == 0)) &&
      (carObj->desiredDirection == carObj->direction)) {
    currentLongAcc = AIPhysic_CalcAcceleration(carObj,carObj->currentSpeed);
    if (AIPhysic_elapsedTime < (carObj->control).brakeLevel) {
      (carObj->control).brakeLevel = (carObj->control).brakeLevel - AIPhysic_elapsedTime;
    }
    else {
      (carObj->control).brakeLevel = 0;
    }
    if ((carObj->control).brakeLevel == 0) {
      (carObj->control).desiredBrakeLevel = 0;
    }
  }
  else {
    currentLongAcc = -AIPhysic_CalcDeceleration(carObj);
    if ((carObj->control).brakeLevel + AIPhysic_elapsedTime * 4 < 0xff) {
      (carObj->control).brakeLevel = (carObj->control).brakeLevel + AIPhysic_elapsedTime * 4;
    }
    else {
      (carObj->control).brakeLevel = 0xff;
    }
    if (3 < (u_char)(carObj->control).brakeLevel) {
      (carObj->control).desiredBrakeLevel = 1;
    }
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
    carObj->rearSkid = skid;
    carObj->frontSkid = skid;
  }
  else {
    carObj->rearSkid = 0;
    carObj->frontSkid = 0;
  }
  (carObj->linearAcc_ch).x = currentLatAcc;
  (carObj->linearAcc_ch).y = 0;
  (carObj->linearAcc_ch).z = currentLongAcc;
  (carObj->linearAcc_rh).x = 0;
  (carObj->linearAcc_rh).y = 0;
  (carObj->linearAcc_rh).z = 0;
  (carObj->angularAcc).x = 0;
  (carObj->angularAcc).y = currentAngAcc;
  (carObj->angularAcc).z = 0;
  return;
}

/* ---- AIPhysic_FinishUp__FP8Car_tObj ---- */
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
  (carObj->linearAcc).x = fixedmult((carObj->linearAcc_ch).x,transOrientMat.m[0]) +
      fixedmult((carObj->linearAcc_ch).y,transOrientMat.m[1]) +
      fixedmult((carObj->linearAcc_ch).z,transOrientMat.m[2]);
  (carObj->linearAcc).y = fixedmult((carObj->linearAcc_ch).x,transOrientMat.m[3]) +
      fixedmult((carObj->linearAcc_ch).y,transOrientMat.m[4]) +
      fixedmult((carObj->linearAcc_ch).z,transOrientMat.m[5]);
  (carObj->linearAcc).z = fixedmult((carObj->linearAcc_ch).x,transOrientMat.m[6]) +
      fixedmult((carObj->linearAcc_ch).y,transOrientMat.m[7]) +
      fixedmult((carObj->linearAcc_ch).z,transOrientMat.m[8]);
  (carObj->linearAcc).x = (carObj->linearAcc).x +
      (fixedmult((carObj->linearAcc_rh).x,transRoadMat.m[0]) +
       fixedmult((carObj->linearAcc_rh).y,transRoadMat.m[1]) +
       fixedmult((carObj->linearAcc_rh).z,transRoadMat.m[2]));
  (carObj->linearAcc).y = (carObj->linearAcc).y +
      (fixedmult((carObj->linearAcc_rh).x,transRoadMat.m[3]) +
       fixedmult((carObj->linearAcc_rh).y,transRoadMat.m[4]) +
       fixedmult((carObj->linearAcc_rh).z,transRoadMat.m[5]));
  (carObj->linearAcc).z = (carObj->linearAcc).z +
      (fixedmult((carObj->linearAcc_rh).x,transRoadMat.m[6]) +
       fixedmult((carObj->linearAcc_rh).y,transRoadMat.m[7]) +
       fixedmult((carObj->linearAcc_rh).z,transRoadMat.m[8]));
  angAcc.x = fixedmult((carObj->angularAcc).x,transOrientMat.m[0]) +
      fixedmult((carObj->angularAcc).y,transOrientMat.m[1]) +
      fixedmult((carObj->angularAcc).z,transOrientMat.m[2]);
  angAcc.y = fixedmult((carObj->angularAcc).x,transOrientMat.m[3]) +
      fixedmult((carObj->angularAcc).y,transOrientMat.m[4]) +
      fixedmult((carObj->angularAcc).z,transOrientMat.m[5]);
  angAcc.z = fixedmult((carObj->angularAcc).x,transOrientMat.m[6]) +
      fixedmult((carObj->angularAcc).y,transOrientMat.m[7]) +
      fixedmult((carObj->angularAcc).z,transOrientMat.m[8]);
  carObj->angularAcc = angAcc;
  tickLoop = 0;
  (carObj->N).linearVel.x = (carObj->N).linearVel.x + fixedmult((carObj->linearAcc).x,AIPhysic_iTime);
  (carObj->N).linearVel.y = (carObj->N).linearVel.y + fixedmult((carObj->linearAcc).y,AIPhysic_iTime);
  (carObj->N).linearVel.z = (carObj->N).linearVel.z + fixedmult((carObj->linearAcc).z,AIPhysic_iTime);
  for (; (carObj->drag != 0) && (tickLoop < AIPhysic_elapsedTime); tickLoop = tickLoop + 1) {
    (carObj->N).linearVel.x = fixedmult((carObj->N).linearVel.x,carObj->drag);
    (carObj->N).linearVel.y = fixedmult((carObj->N).linearVel.y,carObj->drag);
    (carObj->N).linearVel.z = fixedmult((carObj->N).linearVel.z,carObj->drag);
  }
  (carObj->N).angularVel.x = (carObj->N).angularVel.x + (carObj->angularAcc).x / 256 * (AIPhysic_iTime / 256);
  (carObj->N).angularVel.y = (carObj->N).angularVel.y + (carObj->angularAcc).y / 256 * (AIPhysic_iTime / 256);
  (carObj->N).angularVel.z = (carObj->N).angularVel.z + (carObj->angularAcc).z / 256 * (AIPhysic_iTime / 256);
  return;
}

/* ---- AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType  (PASS 66/66 w11-a8:
 * SYM has ONE local rampSpeed (REG $6=a2); plain `elapsedTime * 13107` — gcc synth_mult
 * emits the oracle's *3,*17,<<8 shift-add chain; clamp pair = if(A&&B) X; else if(C&&D) X;
 * with DIRECT field expressions (no cached locals — cse-region reloads fall out); ramp
 * tail = field-direct `+=`/`-=` so the new value takes a fresh temp, MATCH: do not
 * introduce locals here) ---- */
void AIPhysic_CalculateRampedDesiredLatPos(Car_tObj *carObj,eRampType rampType)
{
  int rampSpeed;

  if (rampType == 1) {
    carObj->rampDesiredLatPos = carObj->desiredLatPos;
    return;
  }
  AIWorld_CalculateDeltaRoadYaw(carObj);
  rampSpeed = AIPhysic_elapsedTime * 13107;
  if ((carObj->desiredLatPos < carObj->roadPosition) &&
      (carObj->roadPosition < carObj->rampDesiredLatPos - 0x10000)) {
    carObj->rampDesiredLatPos = carObj->roadPosition;
  }
  else if ((carObj->rampDesiredLatPos + 0x10000 < carObj->roadPosition) &&
           (carObj->roadPosition < carObj->desiredLatPos)) {
    carObj->rampDesiredLatPos = carObj->roadPosition;
  }
  if (carObj->rampDesiredLatPos < carObj->desiredLatPos) {
    carObj->rampDesiredLatPos += rampSpeed;
    if (carObj->desiredLatPos < carObj->rampDesiredLatPos) {
      carObj->rampDesiredLatPos = carObj->desiredLatPos;
    }
  }
  else if (carObj->desiredLatPos < carObj->rampDesiredLatPos) {
    carObj->rampDesiredLatPos -= rampSpeed;
    if (carObj->rampDesiredLatPos < carObj->desiredLatPos) {
      carObj->rampDesiredLatPos = carObj->desiredLatPos;
    }
  }
  return;
}


/* ---- AIPhysic_CheckForGripReduction__FP8Car_tObj ---- */
void AIPhysic_CheckForGripReduction(Car_tObj *carObj)
{
  int randVal;
  int perTickProb;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;

  iVar4 = carObj->gripFactor;
  if (iVar4 < 0x10000) {
    iVar4 = iVar4 + AIPhysic_elapsedTime * carObj->personality->gripLossRecoveryPerTick;
    iVar2 = (carObj->N).collision.lastTime;
    carObj->gripFactor = iVar4;
    if ((simGlobal[1] - iVar2 < 0x40) &&
       ((carObj->N).collision.lastOtherObj == (BO_tNewtonObj *)0x0)) {
      carObj->gripFactor = 0x10000;
    }
    else {
      iVar3 = carObj->personality->gripLossMinFactor;
      iVar1 = 0x10000;
      iVar1 = iVar1 - iVar3;
      if (iVar1 < 0) {
        iVar1 = iVar1 + 3;
      }
      if (iVar3 + (iVar1 >> 2) < iVar4) {
        carObj->gripFactor = 0x10000;
      }
    }
  }
  else if (((carObj->N).simOptz == '\0') && ((carObj->carFlags & 0x28U) != 0)) {
    iVar5 = AIWorld_CalcRoadBend(carObj,1);
    if (iVar5 >= 1) {
      iVar5 = AIWorld_CalcRoadBend(carObj,1);
    }
    else {
      iVar5 = AIWorld_CalcRoadBend(carObj,1);
      iVar5 = -iVar5;
    }
    iVar1 = 2000 < iVar5;
    if (iVar1) {
      AIPerson_t *pers = carObj->personality;
      perTickProb = AIPhysic_elapsedTime * pers->gripLossProbPerSecond;
      randtemp = fastRandom * randSeed;
      randVal = (int)(((u_int)randtemp >> 8) & 0xffff);
      fastRandom = randtemp & 0xffff;
      if (randVal < perTickProb / 32) {
        carObj->gripFactor = pers->gripLossMinFactor;
      }
    }
  }
  return;
  /* MATCH: iVar1 = 2000 < iVar5; if (iVar1) — the STORED-BOOL phrasing keeps the
     oracle's slti;xori;beqz (materialized truth value blocks gcc's branch-inversion
     to slti;bnez). Direct if(2000<iVar5) folds the xori away. 3->0 PASS (w11-a8). */
}

/* ---- AIPhysic_InitCar__FP8Car_tObj  (SYM: inlined AIPhysic_BrakeInfo ctor -- block-scoped
 * d/deceleration/sIndex share $16 via SYM Block scopes; plain /256,/0x10000,/2,/0x20000
 * divisions (gcc emits the bias idioms; distance=i<<16 turns the /0x10000 bias into ori)) ---- */
void AIPhysic_InitCar(Car_tObj *carObj)
{
  u_int carFlags;

  carFlags = carObj->carFlags;
  if ((carFlags & 2) != 0) {
    /* SYM: 'd' (block @cc94) and 'deceleration' (ctor block) share REG $16=s0 via
       block scoping -- modeled as ONE variable (repurposed, codegen-identical) */
    {
      AIPhysic_BrakeInfo *this_;
      int deceleration;
      int invDeceleration;
      int brakeTableLoop;

      deceleration = 0xc0000;
      if ((carFlags & 0x28) != 0) {
        deceleration = 0xb0000;
      }
      deceleration = *(int *)((char *)carObj->personality + 0x20) / 256 * (deceleration / 256);
      if ((carFlags & 8) != 0) {
        deceleration = deceleration / 256 * (AISpeeds_GetUpgradeBrakeMult(carObj->carIndex) / 256);
      }
      this_ = (AIPhysic_BrakeInfo *)__builtin_new(0x84);
      this_->deceleration_ = deceleration;
      invDeceleration = fixeddiv(0x10000,deceleration);
      brakeTableLoop = 0;
      while (true) {
        if (!(brakeTableLoop < 0x80)) break;
        {
          int distance = brakeTableLoop << 0x10;
          int brakeDistanceMeters = fixedmult(fixedmult(distance,invDeceleration),distance) / 2;
          {
            int sIndex = distance / 0x10000;
            if (sIndex < 0) {
              sIndex = -sIndex;
            }
            if (!(sIndex < 0x80)) {
              sIndex = 0x80;
            }
            this_->brakeTable_[sIndex] = (u_char)(brakeDistanceMeters / 0x20000);
          }
        }
        brakeTableLoop = brakeTableLoop + 1;
      }
      carObj->brakeInfo = this_;
    }
  }
  return;
}
