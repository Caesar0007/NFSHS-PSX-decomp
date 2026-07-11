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
  int scaleShifted;
  int prodX;
  int prodY;
  int prodZ;
  int angY;

  (carObj->angularAcc).z = 0;
  (carObj->angularAcc).y = 0;
  (carObj->angularAcc).x = 0;
  (carObj->linearAcc_ch).z = 0;
  (carObj->linearAcc_ch).y = 0;
  (carObj->linearAcc_ch).x = 0;
  (carObj->linearAcc_rh).z = 0;
  (carObj->linearAcc_rh).y = 0;
  (carObj->linearAcc_rh).x = 0;
  if (velScale < 0) {
    velScale = velScale + 0xff;
  }
  scaleShifted = velScale >> 8;
  prodX = scaleShifted * (carObj->N).linearVel.x;
  if (prodX < 0) {
    prodX = prodX + 0xff;
  }
  prodY = scaleShifted * (carObj->N).linearVel.y;
  (carObj->N).linearVel.x = prodX >> 8;
  if (prodY < 0) {
    prodY = prodY + 0xff;
  }
  prodZ = scaleShifted * (carObj->N).linearVel.z;
  (carObj->N).linearVel.y = prodY >> 8;
  if (prodZ < 0) {
    prodZ = prodZ + 0xff;
  }
  angY = (carObj->N).angularVel.y;
  (carObj->N).linearVel.z = prodZ >> 8;
  if (angY < 0) {
    angY = angY + 0xff;
  }
  angY = angY >> 8;
  if (rotScale < 0) {
    rotScale = rotScale + 0xff;
  }
  (carObj->N).angularVel.y = angY * (rotScale >> 8);
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
  int redLine;
  int increase;
  int deadfrm[2];   /* SYM fsize=8 mask=0 -- dead stack filler, no AUTO local recorded */

  redLine = carObj->redLine;
  if (redLine < 0) {
    redLine = redLine + 0xffff;
  }
  increase = ((carObj->carIndex % 2 + 1) * AIPhysic_elapsedTime) * 0x8c;
  redLine = redLine >> 0x10;
  if ((carObj->flywheelRpm & 1) != 0) {
    increase = -(increase >> 1);
    if ((increase & 1) != 0) increase = increase - 1;
  }
  carObj->flywheelRpm = carObj->flywheelRpm + increase;
  if (redLine < carObj->flywheelRpm) {
    carObj->flywheelRpm = (redLine - (redLine >> 0x1f) >> 1) | 1;
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
  int speed;
  int speedDiff;
  int baseRPM;
  int invGearSpeedRange;
  Gear_t gear;
  int iVar1;
  int iVar2;
  int iVar3;

  iVar3 = 3000;
  if (carObj->aiShiftTimer < 1) {
    gear = AIPhysic_CalculateGear(carObj);
    iVar1 = carObj->currentSpeed;
    if (iVar1 < 0) {
      iVar1 = -iVar1;
    }
    iVar3 = 0;
    iVar2 = AIPhysic_GearBottomSpeed(carObj,gear);
    iVar1 = iVar1 - iVar2;
    if (2 < (int)gear) {
      iVar3 = 0xfa00000;
    }
    iVar2 = AIPhysic_GearInvSpeedRange(carObj,gear);
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    if (iVar2 < 0) {
      iVar2 = iVar2 + 0xff;
    }
    iVar1 = (iVar1 >> 8) * (iVar2 >> 8);
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    iVar2 = carObj->redLine - iVar3;
    if (iVar2 < 0) {
      iVar2 = iVar2 + 0xff;
    }
    iVar3 = iVar3 + (iVar1 >> 8) * (iVar2 >> 8);
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xffff;
    }
    iVar3 = iVar3 >> 0x10;
    (carObj->control).gear = (char)gear;
  }
  else {
    carObj->aiShiftTimer = carObj->aiShiftTimer - AIPhysic_elapsedTime;
  }
  iVar2 = carObj->flywheelRpm;
  iVar1 = iVar3 - iVar2;
  if (iVar2 < iVar3) {
    if (iVar1 < 0) {
      iVar1 = iVar1 + 7;
    }
    iVar1 = iVar1 >> 3;
  }
  else {
    iVar1 = iVar2 - iVar3;
    if (iVar2 <= iVar3) {
      return;
    }
    if (iVar1 < 0) {
      iVar1 = iVar1 + 7;
    }
    iVar1 = -(iVar1 >> 3);
  }
  carObj->flywheelRpm = iVar2 + iVar1;
  return;
}

/* ---- AIPhysic_CalcAcceleration__FP8Car_tObji ---- */
int AIPhysic_CalcAcceleration(Car_tObj *carObj,int speed)
{
  int accelEntry;
  int acceleration;
  int absSpeed;
  int speedUpAcc;
  int normalTopCap;
  int upgradeTopCap;
  int iVar1;
  int iVar2;
  int a;

  if (speed < 0) {
    speed = -speed;
  }
  iVar1 = 0;
  if (carObj->aiShiftTimer < 1) {
    iVar1 = carObj->carInfo->carType;
    if (iVar1 < 0x16) {
      a = Cars_topSpeedCap[iVar1];
      iVar1 = fixedmult(a,carObj->topSpeedUpgradeMult);
      iVar2 = fixedmult(iVar1,carObj->aiGlue);
      if (iVar2 < speed) {
        return 0;
      }
      if (iVar1 < speed) {
        return 0;
      }
      if (a < speed) {
        speed = a + -0x238e3;
      }
    }
    if (speed < 0) {
      speed = speed + 0xffff;
    }
    iVar1 = speed >> 0x10;
    if (0x6f < iVar1) {
      iVar1 = 0x6f;
    }
    if (iVar1 < 0) {
      iVar1 = 0;
    }
    iVar1 = (carObj->accelerationRecord)->Get(iVar1);
    iVar2 = carObj->accNitrous;
    if (iVar2 != 0x10000) {
      if (iVar1 < 0) {
        iVar1 = iVar1 + 0xff;
      }
      if (iVar2 < 0) {
        iVar2 = iVar2 + 0xff;
      }
      iVar1 = (iVar1 >> 8) * (iVar2 >> 8);
    }
    if (iVar1 < 0) {
      iVar1 = iVar1 + 0xff;
    }
    iVar2 = carObj->accUpgradeMult;
    if (iVar2 < 0) {
      iVar2 = iVar2 + 0xff;
    }
    iVar1 = (iVar1 >> 8) * (iVar2 >> 8);
    if (0 < GameSetup_gData.Weather) {
      if (iVar1 < 0) {
        iVar1 = iVar1 + 0xff;
      }
      iVar1 = (iVar1 >> 8) * 0xe6;
    }
    if ((carObj->carFlags & 0x20U) != 0) {
      if (iVar1 < 0) {
        iVar1 = iVar1 + 0xff;
      }
      iVar2 = carObj->copAccMult;
      if (iVar2 < 0) {
        iVar2 = iVar2 + 0xff;
      }
      iVar1 = (iVar1 >> 8) * (iVar2 >> 8);
    }
    if ((((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&
        ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||
         ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) &&
       ((carObj->carFlags & 8U) != 0)) {
      if (iVar1 < 0) {
        iVar1 = iVar1 + 0xff;
      }
      iVar2 = AITune_BTCPerpAccMults[GameSetup_gData.skill];
      if (iVar2 < 0) {
        iVar2 = iVar2 + 0xff;
      }
      iVar1 = (iVar1 >> 8) * (iVar2 >> 8);
    }
    iVar1 = AIPhysic_ModifyAccelerationAccordingToScript(carObj,iVar1);
    iVar2 = AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars(carObj);
    if (iVar2 != 0x10000) {
      iVar1 = fixedmult(iVar1,iVar2);
    }
  }
  return iVar1;
}

/* ---- AIPhysic_CheckDesiredDirection__FP8Car_tObj  (oracle keeps a dead carFlags&0x20-gated
 * GameSetup_gData.raceType read that Ghidra folded away -- §3.2c "folded gate/dead load";
 * turnAroundSpeed is the SYM-named REG local, always 0x8E38E in this build) ---- */
void AIPhysic_CheckDesiredDirection(Car_tObj *carObj)
{
  int turnAroundSpeed = 0x8e38e;
  if (carObj->carFlags & 0x20) {
    int deadRaceType = ((volatile GameSetup_tData *)&GameSetup_gData)->raceType;
    (void)deadRaceType;
  }
  if (carObj->speed < turnAroundSpeed) {
    carObj->direction = carObj->desiredDirection;
  }
  return;
}

/* ---- AIPhysic_Main__FP8Car_tObj ---- */
void AIPhysic_Main(Car_tObj *carObj)
{
  char useCoolPhysics;
  int iVar1;
  u_int uVar2;

  iVar1 = Sched_ExecuteCheck(1,1,(carObj->N).distToPlayer,(carObj->N).objID,&AIPhysic_time,
                     &AIPhysic_elapsedTime,&AIPhysic_iTime,carObj->forceNoSimOptz);
  if (iVar1 == 0) {
    return;
  }
  if ((carObj->carFlags & 2U) != 0) {
    AIWorld_CalcSpeed(carObj);
  }
  AIPhysic_CheckDesiredDirection(carObj);
  AIPhysic_CheckForGripReduction(carObj);
  AIPhysic_HandleSignalling(carObj);
  iVar1 = AIWorld_CalcLateralVelocity(carObj);
  carObj->lateralVelocity = iVar1;
  uVar2 = AIPhysics_UseCoolPhysics(carObj);
  AIPhysic_CalculateRampedDesiredLatPos(carObj,(eRampType)((uVar2 & 0xff) != 0));
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
    iVar1 = 0xfae1;
    if ((carObj->carFlags & 0x400U) == 0) {
      return;
    }
    goto LAB_80069dc0;
  }
  if (carObj->speed < 0x40000) {
    (carObj->linearVel_ch).z = 0;
    carObj->rearSkid = 0;
    carObj->frontSkid = 0;
  }
  if (((carObj->N).flightTime != 0) || (0x4ccb < (carObj->N).orientMat.m[4])) {
    if (carObj->blowout != 0) {
      iVar1 = 0xfd70;
      goto LAB_80069dc0;
    }
    if (carObj->pullOver != 0) {
      if (carObj->speed < 0x238e3) {
        AIPhysic_StopCar(carObj,0xe666,0xe666);
        return;
      }
      if (carObj->speed < 0x8e38e) {
        iVar1 = 0xf5c2;
        goto LAB_80069dc0;
      }
    }
    if (((carObj->carFlags & 1U) != 0) && ((carObj->stats).finishType == 2)) {
      iVar1 = carObj->currentSpeed;
      if (iVar1 < 0) {
        iVar1 = -iVar1;
      }
      if (iVar1 < 0x20000) goto LAB_80069dbc;
    }
    if (carObj->desiredSpeed != 0) {
      if ((uVar2 & 0xff) == 0) {
        AIPhysic_SimplePhysics(carObj);
      }
      else {
        AIPhysic_CoolPhysics(carObj);
      }
      AIPhysic_CheckForBadPosition(carObj);
      AIPhysic_HandleWipeoutTimer(carObj);
      return;
    }
  }
LAB_80069dbc:
  iVar1 = 0xf0a3;
LAB_80069dc0:
  AIPhysic_StopCar(carObj,iVar1,0xfae1);
  return;
}

/* ---- AIPhysic_SimplePhysics__FP8Car_tObj ---- */
void AIPhysic_SimplePhysics(Car_tObj *carObj)
{
  coorddef forward;
  coorddef right;
  int speed;
  int sliceLookAhead;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;

  if ((carObj->AIFlags & 0x10U) != 0) {
    carObj->rampDesiredLatPos = carObj->roadPosition;
    carObj->AIFlags = carObj->AIFlags & 0xffffffef;
  }
  if (((((carObj->carFlags & 8U) != 0) && (carObj->wipeOutStartTick < simGlobal[1])) &&
      (iVar1 = AIDataRecord_TrackCurve->Get((int)(carObj->N).simRoadInfo.slice), 0x1e < iVar1)
      ) && (0x1638e3 < carObj->speed)) {
    carObj->wipeOutEndTick = simGlobal[1] + 0x180;
  }
  AIPhysic_SimplePhysics_LongVel(carObj);
  AIPhysic_SimplePhysics_LatVel(carObj);
  iVar1 = (carObj->N).orientMat.m[6];
  iVar4 = (carObj->N).orientMat.m[7];
  iVar6 = (carObj->N).orientMat.m[8];
  iVar5 = (carObj->N).roadMatrix.m[1];
  iVar7 = (carObj->N).roadMatrix.m[2];
  iVar2 = fixedmult(carObj->laneChangeSpeed,(carObj->N).roadMatrix.m[0]);
  iVar5 = fixedmult(carObj->laneChangeSpeed,iVar5);
  iVar7 = fixedmult(carObj->laneChangeSpeed,iVar7);
  iVar3 = fixedmult(carObj->currentSpeed * carObj->direction,iVar1);
  iVar4 = fixedmult(carObj->currentSpeed * carObj->direction,iVar4);
  iVar6 = fixedmult(carObj->currentSpeed * carObj->direction,iVar6);
  iVar1 = carObj->laneChangeSpeed * carObj->direction;
  (carObj->N).linearVel.x = iVar3 + iVar2;
  iVar2 = carObj->speed;
  (carObj->N).linearVel.y = iVar4 + iVar5;
  (carObj->linearVel_ch).z = iVar2;
  (carObj->N).linearVel.z = iVar6 + iVar7;
  iVar2 = iVar1;
  if (iVar1 < 0) {
    iVar2 = -iVar1;
  }
  (carObj->linearVel_ch).x = iVar1;
  iVar1 = iVar2;
  if (iVar2 < 0) {
    iVar1 = iVar2 + 0xff;
  }
  if ((iVar1 >> 8) * 0x19 < iVar2) {
    carObj->slide = 0x8000;
  }
  else {
    carObj->slide = 0;
  }
  iVar1 = carObj->speed;
  (carObj->N).angularVel.x = 0;
  (carObj->N).angularVel.y = 0;
  (carObj->N).angularVel.z = 0;
  if (0x30000 < iVar1) {
    Newton_CopyRoadMatrixToOrientMat(&carObj->N,(u_int)(carObj->direction == -1));
  }
  iVar1 = carObj->currentSpeed;
  if (iVar1 < 0) {
    iVar1 = -iVar1;
  }
  iVar2 = iVar1 / 0x60000;
  if (-1 < iVar2) {
    if ((iVar2 < AIPhysicConfig.min_lookahead / 6) && (-1 < iVar1)) {
      iVar2 = AIPhysicConfig.min_lookahead / 6;
    }
  }
  if (AIPhysicConfig.max_lookahead / 6 < iVar2) {
    iVar2 = AIPhysicConfig.max_lookahead / 6;
  }
  iVar2 = iVar2 * carObj->direction;
  if (iVar2 < 0) {
    iVar2 = (carObj->N).simRoadInfo.slice + iVar2;
    if (iVar2 < 0) {
      iVar2 = iVar2 + gNumSlices;
    }
  }
  else {
    iVar2 = (carObj->N).simRoadInfo.slice + iVar2;
    if (gNumSlices <= iVar2) {
      iVar2 = iVar2 - gNumSlices;
    }
  }
  carObj->lookAheadSlice = iVar2;
  return;
}

/* ---- AIPhysic_SimplePhysics_LongVel__FP8Car_tObj ---- */
void AIPhysic_SimplePhysics_LongVel(Car_tObj *carObj)
{
  int acceleration;
  int deceleration;
  u_char bVar1;
  char cVar2;
  bool bVar3;
  int iVar4;
  int iVar5;
  int iVar6;

  iVar4 = AIPhysic_CalcAcceleration(carObj,carObj->currentSpeed);
  iVar5 = AIPhysic_CalcDeceleration(carObj);
  if (carObj->pullOver != 0) {
    carObj->desiredSpeed = 0;
  }
  if (simGlobal[1] < carObj->wipeOutEndTick) {
    iVar6 = carObj->desiredSpeed;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 3;
    }
    carObj->desiredSpeed = iVar6 >> 2;
  }
  if (carObj->direction == -1) {
    if ((carObj->currentSpeed < carObj->desiredSpeed) || (carObj->desiredDirection != -1)) {
      bVar1 = (carObj->control).brakeLevel;
      (carObj->linearAcc_ch).z = iVar5;
      if (bVar1 < 0xff) {
        (carObj->control).brakeLevel = bVar1;
      }
      else {
        (carObj->control).brakeLevel = -1;
      }
      if (3 < (u_char)(carObj->control).brakeLevel) {
        (carObj->control).desiredBrakeLevel = '\x01';
      }
      iVar4 = carObj->currentSpeed;
      carObj->currentSpeed = iVar4;
      if (carObj->direction != carObj->desiredDirection) {
        return;
      }
      iVar5 = carObj->desiredSpeed;
      if (iVar4 <= carObj->desiredSpeed) {
        iVar5 = iVar4;
      }
      goto LAB_8006a5dc;
    }
    cVar2 = (carObj->control).brakeLevel;
    carObj->currentSpeed = carObj->currentSpeed;
    if (cVar2 == '\0') {
      (carObj->control).brakeLevel = '\0';
    }
    else {
      (carObj->control).brakeLevel = cVar2;
    }
    if ((carObj->control).brakeLevel == '\0') {
      (carObj->control).desiredBrakeLevel = '\0';
    }
    iVar6 = carObj->currentSpeed;
    iVar5 = carObj->desiredSpeed;
    (carObj->linearAcc_ch).z = iVar4;
    bVar3 = iVar6 < iVar5;
  }
  else {
    if ((carObj->desiredSpeed < carObj->currentSpeed) ||
       (carObj->direction != carObj->desiredDirection)) {
      bVar1 = (carObj->control).brakeLevel;
      (carObj->linearAcc_ch).z = iVar5;
      if (bVar1 < 0xff) {
        (carObj->control).brakeLevel = bVar1;
      }
      else {
        (carObj->control).brakeLevel = -1;
      }
      if (3 < (u_char)(carObj->control).brakeLevel) {
        (carObj->control).desiredBrakeLevel = '\x01';
      }
      iVar4 = carObj->currentSpeed;
      carObj->currentSpeed = iVar4;
      if (carObj->direction != carObj->desiredDirection) {
        return;
      }
      iVar5 = carObj->desiredSpeed;
      if (carObj->desiredSpeed < iVar4) {
        iVar5 = iVar4;
      }
      goto LAB_8006a5dc;
    }
    cVar2 = (carObj->control).brakeLevel;
    carObj->currentSpeed = carObj->currentSpeed;
    if (cVar2 == '\0') {
      (carObj->control).brakeLevel = '\0';
    }
    else {
      (carObj->control).brakeLevel = cVar2;
    }
    if ((carObj->control).brakeLevel == '\0') {
      (carObj->control).desiredBrakeLevel = '\0';
    }
    iVar6 = carObj->currentSpeed;
    iVar5 = carObj->desiredSpeed;
    (carObj->linearAcc_ch).z = iVar4;
    bVar3 = iVar5 < iVar6;
  }
  if (!bVar3) {
    return;
  }
LAB_8006a5dc:
  carObj->currentSpeed = iVar5;
  return;
}

/* ---- AIPhysic_Preperation__FP8Car_tObj ---- */
void AIPhysic_Preperation(Car_tObj *carObj)
{
  coorddef forward;
  int aCar;
  int aCarWRTDesired;
  int aDesired;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;

  iVar1 = fixedmult((carObj->N).linearVel.x,(carObj->N).orientMat.m[0]);
  iVar2 = fixedmult((carObj->N).linearVel.y,(carObj->N).orientMat.m[1]);
  iVar3 = fixedmult((carObj->N).linearVel.z,(carObj->N).orientMat.m[2]);
  iVar4 = (carObj->N).linearVel.x;
  iVar5 = (carObj->N).orientMat.m[3];
  (carObj->linearVel_ch).x = iVar1 + iVar2 + iVar3;
  iVar1 = fixedmult(iVar4,iVar5);
  iVar2 = fixedmult((carObj->N).linearVel.y,(carObj->N).orientMat.m[4]);
  iVar3 = fixedmult((carObj->N).linearVel.z,(carObj->N).orientMat.m[5]);
  iVar4 = (carObj->N).linearVel.x;
  iVar5 = (carObj->N).orientMat.m[6];
  (carObj->linearVel_ch).y = iVar1 + iVar2 + iVar3;
  iVar1 = fixedmult(iVar4,iVar5);
  iVar2 = fixedmult((carObj->N).linearVel.y,(carObj->N).orientMat.m[7]);
  iVar3 = fixedmult((carObj->N).linearVel.z,(carObj->N).orientMat.m[8]);
  iVar4 = (carObj->N).angularVel.x;
  iVar5 = (carObj->N).orientMat.m[0];
  (carObj->linearVel_ch).z = iVar1 + iVar2 + iVar3;
  iVar1 = fixedmult(iVar4,iVar5);
  iVar2 = fixedmult((carObj->N).angularVel.y,(carObj->N).orientMat.m[1]);
  iVar3 = fixedmult((carObj->N).angularVel.z,(carObj->N).orientMat.m[2]);
  iVar4 = (carObj->N).angularVel.x;
  iVar5 = (carObj->N).orientMat.m[3];
  (carObj->angularVel_ch).x = iVar1 + iVar2 + iVar3;
  iVar1 = fixedmult(iVar4,iVar5);
  iVar2 = fixedmult((carObj->N).angularVel.y,(carObj->N).orientMat.m[4]);
  iVar3 = fixedmult((carObj->N).angularVel.z,(carObj->N).orientMat.m[5]);
  iVar4 = (carObj->N).angularVel.x;
  iVar5 = (carObj->N).orientMat.m[6];
  (carObj->angularVel_ch).y = iVar1 + iVar2 + iVar3;
  iVar2 = fixedmult(iVar4,iVar5);
  iVar3 = fixedmult((carObj->N).angularVel.y,(carObj->N).orientMat.m[7]);
  iVar4 = fixedmult((carObj->N).angularVel.z,(carObj->N).orientMat.m[8]);
  iVar1 = (carObj->linearVel_ch).x;
  (carObj->angularVel_ch).z = iVar2 + iVar3 + iVar4;
  if (iVar1 < 0) {
    iVar1 = -iVar1;
  }
  iVar2 = iVar1;
  if (iVar1 < 0) {
    iVar2 = iVar1 + 0xff;
  }
  if ((iVar2 >> 8) * 0x19 < iVar1) {
    carObj->slide = 0x8000;
  }
  else {
    carObj->slide = 0;
  }
  iVar1 = (carObj->N).orientMat.m[6];
  iVar2 = (carObj->N).orientMat.m[8];
  if (carObj->driveDirection != 1) {
    iVar1 = -iVar1;
    iVar2 = -iVar2;
  }
  iVar1 = intatan(iVar1,iVar2);
  carObj->aCar = iVar1;
  AIPhysic_GetDesiredVector(carObj);
  iVar2 = intatan((carObj->desiredVector).x,(carObj->desiredVector).z);
  iVar1 = iVar1 - iVar2;
  iVar3 = iVar1 + 0x400;
  if (-0x201 < iVar1) {
    carObj->aCarWRTDesired = iVar1;
    if (iVar1 < 0x201) goto LAB_8006ab00;
    iVar3 = iVar1 + -0x400;
  }
  carObj->aCarWRTDesired = iVar3;
LAB_8006ab00:
  carObj->aDesired = iVar2;
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
  bool bVar1;
  int iVar2;
  int iVar3;
  int *piVar4;
  int iVar5;
  int iVar6;
  int slice;
  int iVar7;
  coorddef local_38;
  int local_28;
  int local_24;
  int local_20;

  slice = (int)(carObj->N).simRoadInfo.slice;
  iVar7 = 0;
  if ((((carObj->targetPos).x != 0) || ((carObj->targetPos).y != 0)) || ((carObj->targetPos).z != 0)
     ) {
    AIPhysic_TargetedGetDesiredVector(carObj);
    return;
  }
  iVar2 = carObj->currentSpeed;
  if (iVar2 < 0) {
    iVar2 = -iVar2;
  }
  iVar3 = fixedmult(iVar2,0xb333);
  iVar3 = (iVar3 + 0x30000) / 0x60000;
  if (((-1 < iVar3) && (iVar3 < AIPhysicConfig.min_lookahead / 6)) && (-1 < iVar2)) {
    iVar3 = AIPhysicConfig.min_lookahead / 6;
  }
  if (AIPhysicConfig.max_lookahead / 6 < iVar3) {
    iVar3 = AIPhysicConfig.max_lookahead / 6;
  }
  iVar2 = iVar3 * carObj->driveDirection * carObj->direction;
  iVar5 = slice + iVar2;
  if (iVar2 < 0) {
    if (iVar5 < 0) {
      iVar5 = iVar5 + gNumSlices;
    }
  }
  else if (gNumSlices <= iVar5) {
    iVar5 = iVar5 - gNumSlices;
  }
  carObj->lookAheadSlice = iVar5;
  iVar2 = AIWorld_CalcRoadBend(carObj,iVar2);
  iVar5 = carObj->lookAheadSlice * 0x20 + (int)BWorldSm_slices;
  if (iVar2 < 0) {
    iVar2 = -iVar2;
  }
  if ((u_int)*(u_char *)(iVar5 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar5 + 0x1d) >> 4) +
      (u_int)*(u_char *)(iVar5 + 0x1f) * 0x8000 * (*(u_char *)(iVar5 + 0x1d) & 0xf) < 0x120000) {
    if (0xf333 < iVar2) {
      iVar5 = iVar3 * 0xca3d;
      iVar3 = iVar5 >> 0x10;
      if (iVar5 < 0) {
        iVar3 = iVar5 + 0xffff >> 0x10;
      }
    }
    if (iVar2 < 0xe667) {
      if (iVar2 < 0xcccd) {
        if (iVar2 < 0xc001) goto LAB_8006af18;
        iVar2 = iVar3 * 0xf333;
      }
      else {
        iVar2 = iVar3 * 0xe666;
      }
    }
    else {
      iVar2 = iVar3 * 0xd70a;
    }
    iVar3 = iVar2 >> 0x10;
    if (iVar2 < 0) {
      iVar3 = iVar2 + 0xffff >> 0x10;
    }
  }
LAB_8006af18:
  do {
    iVar2 = iVar3 * carObj->driveDirection * carObj->direction;
    if (iVar2 < 0) {
      iVar2 = slice + iVar2;
      if (iVar2 < 0) {
        iVar2 = iVar2 + gNumSlices;
      }
    }
    else {
      iVar2 = slice + iVar2;
      if (gNumSlices <= iVar2) {
        iVar2 = iVar2 - gNumSlices;
      }
    }
    carObj->lookAheadSlice = iVar2;
    piVar4 = (int *)(carObj->lookAheadSlice * 0x20 + (int)BWorldSm_slices);
    iVar2 = *piVar4;
    iVar5 = piVar4[1];
    iVar6 = piVar4[2];
    local_28 = (int)*(char *)(carObj->lookAheadSlice * 0x20 + (int)BWorldSm_slices + 0x12) << 9;
    local_24 = (int)*(char *)(carObj->lookAheadSlice * 0x20 + (int)BWorldSm_slices + 0x13) << 9;
    local_20 = (int)*(char *)(carObj->lookAheadSlice * 0x20 + (int)BWorldSm_slices + 0x14) << 9;
    local_38.x = fixedmult(carObj->rampDesiredLatPos,local_28);
    local_38.y = fixedmult(carObj->rampDesiredLatPos,local_24);
    local_38.z = fixedmult(carObj->rampDesiredLatPos,local_20);
    local_38.x = local_38.x + iVar2;
    local_38.z = local_38.z + iVar6;
    local_38.y = local_38.y + iVar5;
    iVar2 = AIPhysic_CalculateRoadPosition(&local_38,slice);
    iVar5 = slice * 0x20 + (int)BWorldSm_slices;
    if ((((int)((u_int)*(u_char *)(iVar5 + 0x1f) * 0x8000 * (*(u_char *)(iVar5 + 0x1d) & 0xf)) < iVar2)
        && (carObj->roadPosition < iVar2)) ||
       ((iVar2 < (int)-((u_int)*(u_char *)(iVar5 + 0x1e) * 0x8000 *
                       (u_int)(*(u_char *)(iVar5 + 0x1d) >> 4)) && (iVar2 < carObj->roadPosition)))) {
      iVar5 = 1;
      if (iVar2 < carObj->roadPosition) {
        iVar5 = -1;
      }
      iVar2 = AIWorld_LaneIndex(slice,carObj->roadPosition + iVar5 * 0x80000);
      iVar2 = AIWorld_IsDriveableLane(slice,iVar2);
      if (iVar2 == 0) {
        bVar1 = false;
      }
      else {
        iVar2 = AIWorld_LaneIndex(slice,carObj->roadPosition + iVar5 * 0x40000);
        iVar2 = AIWorld_IsDriveableLane(slice,iVar2);
        bVar1 = iVar2 != 0;
      }
    }
    else {
      bVar1 = true;
    }
    iVar7 = iVar7 + 1;
    iVar2 = iVar3 * 0xcccc;
    if (iVar2 < 0) {
      iVar2 = iVar2 + 0xffff;
    }
    iVar3 = 4;
    if (3 < iVar2 >> 0x10) {
      iVar3 = iVar2 >> 0x10;
    }
  } while ((iVar7 < 5) && (!bVar1));
  (carObj->desiredVector).x = local_38.x - (carObj->N).position.x;
  (carObj->desiredVector).y = local_38.y - (carObj->N).position.y;
  (carObj->desiredVector).z = local_38.z - (carObj->N).position.z;
  return;
}

/* ---- AIPhysic_CheckIfOutOfControl__FP8Car_tObj ---- */
int AIPhysic_CheckIfOutOfControl(Car_tObj *carObj)
{
  int futureBend;
  int iVar1;
  int iVar2;
  int iVar3;

  iVar1 = AIWorld_CalcRoadBend(carObj,carObj->direction << 3);
  if (iVar1 < 0) {
    iVar1 = -iVar1;
  }
  if (simGlobal[1] < carObj->wipeOutEndTick) {
    iVar1 = carObj->currentSpeed;
    if (iVar1 < 0) {
      iVar1 = -iVar1;
    }
    return 0x2ffff < iVar1 ^ 1;
  }
  iVar2 = carObj->aCarWRTDesired;
  if (iVar2 < 0) {
    iVar2 = -iVar2;
  }
  if ((iVar2 < 0x74) && (carObj->driveDirection != -1)) {
    iVar2 = carObj->currentSpeed;
    if (iVar2 < 0) {
      iVar2 = -iVar2;
    }
    if (iVar2 < AIPhysicConfig.OOCModel.vel_limit_range + -0x30000) {
      return 1;
    }
    iVar3 = (carObj->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices;
    if (carObj->roadPosition <
        (int)-((u_int)*(u_char *)(iVar3 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar3 + 0x1d) >> 4))) {
      return 1;
    }
    if ((int)((u_int)*(u_char *)(iVar3 + 0x1f) * 0x8000 * (*(u_char *)(iVar3 + 0x1d) & 0xf)) <
        carObj->roadPosition) {
      return 1;
    }
    if (0xcccc < iVar1) {
      return 1;
    }
    iVar1 = (carObj->linearVel_ch).x;
    iVar3 = carObj->speed;
    if (iVar1 < 0) {
      iVar1 = -iVar1;
    }
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xff;
    }
    if (iVar1 <= (iVar3 >> 8) * 0x66) {
      return 0;
    }
    if (0xeffff < iVar2) {
      return 0;
    }
  }
  return 1;
}

/* ---- AIPhysic_OutOfControlPhysics__FP8Car_tObj ---- */
void AIPhysic_OutOfControlPhysics(Car_tObj *carObj)
{
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
  char cVar1;
  u_char bVar2;
  bool bVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int iVar9;

  carObj->drag = 0;
  bVar3 = false;
  iVar4 = AIWorld_CalcFutureLateralVel(carObj,carObj->direction * AIPhysicConfig.latvelcalc_lookahead);
  if (carObj->direction * carObj->currentSpeed < 0) {
    bVar3 = carObj->driveDirection != -1;
  }
  carObj->wipeOutEndTick = simGlobal[1];
  iVar5 = fixedmult(0x80,AIPhysicConfig.OOCModel.dangle_to_dav);
  iVar5 = -carObj->aCarWRTDesired * iVar5;
  iVar6 = AIPhysicConfig.OOCModel.max_dav;
  if (iVar5 < AIPhysicConfig.OOCModel.max_dav) {
    iVar6 = iVar5;
  }
  iVar5 = -AIPhysicConfig.OOCModel.max_dav;
  if (-AIPhysicConfig.OOCModel.max_dav < iVar6) {
    iVar5 = iVar6;
  }
  iVar6 = iVar5;
  if (iVar5 < 0) {
    iVar6 = iVar5 + 0xff;
  }
  iVar8 = (iVar6 >> 8) * 0xa00;
  iVar6 = AIPhysicConfig.OOCModel.max_dlvel;
  if (iVar8 < AIPhysicConfig.OOCModel.max_dlvel) {
    iVar6 = iVar8;
  }
  iVar8 = -AIPhysicConfig.OOCModel.max_dlvel;
  if (-AIPhysicConfig.OOCModel.max_dlvel < iVar6) {
    iVar8 = iVar6;
  }
  iVar6 = carObj->speed;
  if (iVar8 < carObj->speed) {
    iVar6 = iVar8;
  }
  iVar9 = carObj->speed;
  iVar8 = -iVar9;
  if (-iVar9 < iVar6) {
    iVar8 = iVar6;
  }
  if ((-AIPhysicConfig.OOCModel.vel_limit_range < carObj->currentSpeed) &&
     (carObj->currentSpeed < AIPhysicConfig.OOCModel.vel_limit_range)) {
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    iVar6 = AIPhysicConfig.OOCModel.lat_vel_limit_factor;
    if (AIPhysicConfig.OOCModel.lat_vel_limit_factor < 0) {
      iVar6 = AIPhysicConfig.OOCModel.lat_vel_limit_factor + 0xff;
    }
    iVar6 = (iVar9 >> 8) * (iVar6 >> 8);
    if (iVar6 < 0) {
      iVar6 = -iVar6;
    }
    iVar7 = iVar6;
    if (iVar8 < iVar6) {
      iVar7 = iVar8;
    }
    iVar8 = -iVar6;
    if (-iVar6 < iVar7) {
      iVar8 = iVar7;
    }
    iVar6 = AIPhysicConfig.OOCModel.ang_vel_limit_factor;
    if (AIPhysicConfig.OOCModel.ang_vel_limit_factor < 0) {
      iVar6 = AIPhysicConfig.OOCModel.ang_vel_limit_factor + 0xff;
    }
    iVar6 = (iVar9 >> 8) * (iVar6 >> 8);
    if (iVar6 < 0) {
      iVar6 = -iVar6;
    }
    iVar9 = iVar6;
    if (iVar5 < iVar6) {
      iVar9 = iVar5;
    }
    iVar5 = -iVar6;
    if (-iVar6 < iVar9) {
      iVar5 = iVar9;
    }
  }
  if (carObj->donutMode == 2) {
    iVar5 = iVar5 * 5;
  }
  iVar5 = (carObj->angularVel_ch).y - iVar5;
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  iVar6 = AIPhysicConfig.OOCModel.dav_to_aa;
  if (AIPhysicConfig.OOCModel.dav_to_aa < 0) {
    iVar6 = AIPhysicConfig.OOCModel.dav_to_aa + 0xff;
  }
  iVar9 = carObj->currentSpeed;
  if (iVar9 < 0) {
    iVar9 = -iVar9;
  }
  iVar5 = -((iVar5 >> 8) * (iVar6 >> 8));
  if (0x120000 < iVar9) {
    iVar5 = iVar5 / 2;
  }
  iVar6 = carObj->max_aa;
  if (iVar5 < carObj->max_aa) {
    iVar6 = iVar5;
  }
  iVar5 = -carObj->max_aa;
  if (-carObj->max_aa < iVar6) {
    iVar5 = iVar6;
  }
  iVar8 = (carObj->linearVel_ch).x - iVar8;
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  iVar6 = AIPhysicConfig.OOCModel.dlvel_to_clacc;
  if (AIPhysicConfig.OOCModel.dlvel_to_clacc < 0) {
    iVar6 = AIPhysicConfig.OOCModel.dlvel_to_clacc + 0xff;
  }
  iVar6 = -((iVar8 >> 8) * (iVar6 >> 8));
  iVar8 = carObj->max_clacc;
  if (iVar6 < carObj->max_clacc) {
    iVar8 = iVar6;
  }
  iVar6 = -carObj->max_clacc;
  if (-carObj->max_clacc < iVar8) {
    iVar6 = iVar8;
  }
  iVar8 = (carObj->linearVel_ch).z;
  if ((((carObj->driveDirection == -1) && ((carObj->targetPos).x == 0)) &&
      ((carObj->targetPos).y == 0)) && ((carObj->targetPos).z == 0)) {
    iVar9 = -AIPhysicConfig.OOCModel.vel_limit_range;
  }
  else {
    iVar9 = carObj->desiredSpeed * carObj->direction * carObj->driveDirection;
  }
  if (carObj->pullOver == 0) {
    if (iVar9 < 0) {
      if ((iVar9 <= iVar8) && (iVar8 < 0x20001)) goto LAB_8006b814;
    }
    else if ((-0x20001 < iVar8) && (iVar8 <= iVar9)) {
LAB_8006b814:
      if (carObj->desiredDirection == carObj->direction) {
        iVar8 = AIPhysic_CalcAcceleration(carObj,(carObj->linearVel_ch).z);
        iVar8 = iVar8 * carObj->driveDirection;
        cVar1 = (carObj->control).brakeLevel;
        if (cVar1 == '\0') {
          (carObj->control).brakeLevel = '\0';
        }
        else {
          (carObj->control).brakeLevel = cVar1;
        }
        if ((carObj->control).brakeLevel == '\0') {
          (carObj->control).desiredBrakeLevel = '\0';
        }
        goto LAB_8006b908;
      }
    }
  }
  iVar9 = (carObj->linearVel_ch).z;
  if (iVar9 < 0) {
    iVar9 = -iVar9;
  }
  iVar8 = 0;
  if (0 < iVar9) {
    iVar9 = AIPhysic_CalcDeceleration(carObj);
    bVar2 = (carObj->control).brakeLevel;
    if (bVar2 < 0xff) {
      (carObj->control).brakeLevel = bVar2;
    }
    else {
      (carObj->control).brakeLevel = -1;
    }
    if (3 < (u_char)(carObj->control).brakeLevel) {
      (carObj->control).desiredBrakeLevel = '\x01';
    }
    iVar8 = -iVar9;
    if ((carObj->linearVel_ch).z < 0) {
      iVar8 = iVar9;
    }
  }
LAB_8006b908:
  if (bVar3) {
    if (carObj->speed - 0x140001U < 0x1dffff) {
      if (iVar5 < 0) {
        iVar5 = iVar5 + 3;
      }
      iVar5 = iVar5 >> 2;
      if (iVar8 < 0) {
        iVar8 = iVar8 + 3;
      }
      iVar8 = iVar8 >> 2;
    }
    else {
      iVar5 = fixedmult(iVar5,0xc000);
      iVar9 = iVar8 / 2;
      if (iVar8 < 0) {
        iVar8 = iVar8 + 3;
      }
      iVar8 = iVar9 + (iVar8 >> 2);
    }
    iVar9 = iVar6;
    if (iVar6 < 0) {
      iVar9 = iVar6 + 3;
    }
    if (iVar6 < 0) {
      iVar6 = iVar6 + 7;
    }
    iVar6 = (iVar9 >> 2) + (iVar6 >> 3);
  }
  if (iVar4 < 0) {
    iVar4 = -iVar4;
  }
  iVar4 = iVar4 - AIPhysicConfig.skid_value;
  if (((carObj->direction * carObj->currentSpeed < 0) && (0x38e38 < carObj->speed)) ||
     (carObj->donutMode != 0)) {
    carObj->frontSkid = 0xa0000;
    carObj->rearSkid = 0xa0000;
  }
  else if (iVar4 < 1) {
    carObj->rearSkid = 0;
    carObj->frontSkid = 0;
  }
  else {
    carObj->frontSkid = iVar4;
    carObj->rearSkid = iVar4;
  }
  (carObj->linearAcc_ch).x = iVar6;
  (carObj->linearAcc_ch).y = 0;
  (carObj->linearAcc_ch).z = iVar8;
  (carObj->linearAcc_rh).x = 0;
  (carObj->linearAcc_rh).y = 0;
  (carObj->linearAcc_rh).z = 0;
  (carObj->angularAcc).x = 0;
  (carObj->angularAcc).y = iVar5;
  (carObj->angularAcc).z = 0;
  return;
}

/* ---- AIPhysic_InControlPhysics__FP8Car_tObj ---- */
void AIPhysic_InControlPhysics(Car_tObj *carObj)
{
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
  int vely;
  int fishtailtick;
  int signAngle;
  int maxLatVel;
  int maxAngVel;
  char cVar1;
  u_char bVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  BO_tNewtonObj *pBVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  int iVar10;
  int iVar11;
  coorddef local_60;
  int local_50;
  int local_4c;
  int local_48;
  int local_40;
  int local_3c;
  int local_38;
  int local_34;
  int local_30;

  local_38 = carObj->direction;
  carObj->drag = 0;
  local_60.x = (carObj->desiredVector).x;
  local_60.y = (carObj->desiredVector).y;
  local_60.z = (carObj->desiredVector).z;
  Math_QDNormalizeVector(&local_60);
  local_30 = 0;
  local_48 = -local_60.x;
  local_50 = local_60.z;
  local_4c = local_60.y;
  iVar11 = 0;
  iVar3 = fixedmult((carObj->N).linearVel.x,local_60.z);
  iVar4 = fixedmult((carObj->N).linearVel.y,local_4c);
  iVar5 = fixedmult((carObj->N).linearVel.z,local_48);
  local_40 = (iVar3 + iVar4 + iVar5) * carObj->direction;
  iVar4 = carObj->max_aa;
  local_3c = carObj->roadPosition - carObj->rampDesiredLatPos;
  iVar3 = fixedmult((carObj->linearVel_ch).z,0x62);
  iVar3 = fixedmult(iVar3 + 0x10000,carObj->gripFactor);
  if (((carObj->carFlags & 8U) != 0) && (carObj->wipeOutStartTick < simGlobal[1])) {
    iVar5 = (carObj->N).angularVel.y;
    if (iVar5 < 0) {
      iVar5 = -iVar5;
    }
    if ((1000 < iVar5) && (0x1638e3 < carObj->speed)) {
      carObj->wipeOutEndTick = simGlobal[1] + 0x180;
    }
  }
  iVar10 = simGlobal[1] - (carObj->N).collision.lastTime;
  iVar5 = AIScript_DoReAction(&carObj->script,(AIScript_tAIReaction)0x800);
  if ((iVar5 != -1) || (simGlobal[1] < carObj->wipeOutEndTick)) {
    iVar4 = 0;
    if (simGlobal[1] - (carObj->N).collision.lastTime < 0x40) {
      carObj->wipeOutEndTick = simGlobal[1];
    }
    iVar11 = (carObj->N).angularVel.y;
    iVar3 = 0;
    if (iVar11 < 0) {
      iVar11 = -iVar11;
    }
    iVar11 = iVar11 + 0x1ca;
    if (0x3333 < iVar11) {
      iVar11 = 0x3333;
    }
    if ((carObj->N).angularVel.y < 1) {
      (carObj->N).angularVel.y = -iVar11;
    }
    else {
      (carObj->N).angularVel.y = iVar11;
    }
    iVar11 = 0xa0000;
  }
  iVar5 = GameSetup_gData.skill;
  if (iVar10 < 0x10) {
    carObj->wipeOutStartTick = carObj->wipeOutStartTick + -0x14;
  }
  if (((iVar10 < (int)(u_int)*(u_char *)((int)AIInit_forceHumanHandBrake + iVar5 + 0xc)) &&
      (pBVar6 = (carObj->N).collision.lastOtherObj, pBVar6 != (BO_tNewtonObj *)0x0)) &&
     ((pBVar6[1].simRoadInfo.quadPts[1].y & 0x200U) != 0)) {
    iVar4 = 0;
    local_30 = 1;
    iVar3 = fixedmult(iVar3,*(int *)(AIPerson_ScriptData[0x3f].reaction + iVar5 * 4));
  }
  iVar10 = carObj->max_clacc;
  if (iVar10 < 0) {
    iVar10 = iVar10 + 0xff;
  }
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar10 = (iVar10 >> 8) * (iVar3 >> 8);
  iVar7 = AIPhysicConfig.ICModel.dlvel_to_clacc;
  if (AIPhysicConfig.ICModel.dlvel_to_clacc < 0) {
    iVar7 = AIPhysicConfig.ICModel.dlvel_to_clacc + 0xff;
  }
  iVar3 = (iVar7 >> 8) * (iVar3 >> 8);
  iVar7 = carObj->aiGlue;
  if (0x10000 < iVar7) {
    if (iVar7 < 0) {
      iVar7 = iVar7 + 0xff;
    }
    if (iVar10 < 0) {
      iVar10 = iVar10 + 0xff;
    }
    iVar10 = (iVar7 >> 8) * (iVar10 >> 8);
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xff;
    }
    iVar3 = (iVar7 >> 8) * (iVar3 >> 8);
  }
  iVar7 = carObj->aCarWRTDesired;
  local_34 = carObj->desiredSpeed;
  if (simGlobal[1] < carObj->AIFishtailEndTick) {
    iVar9 = 1;
    iVar8 = carObj->AIFishtailEndTick - simGlobal[1];
    if ((simGlobal[1] / 0x28 & 1U) != 0) {
      iVar9 = -1;
    }
    if (0x96 - iVar8 < 0x32) {
      iVar9 = (iVar9 * 0x1e * (0x96 - iVar8)) / 0x32;
    }
    else {
      iVar9 = iVar9 * (iVar8 / 7 + 10);
    }
    iVar7 = iVar7 + iVar9;
    if (0x32 < iVar8) {
      iVar11 = (iVar8 * 0x140000) / 0x32;
    }
  }
  else {
    iVar9 = iVar7;
    if (iVar7 < 0) {
      iVar9 = -iVar7;
    }
    if (((*(int *)((char *)carObj->personality + 0x2c) < iVar9) && (0 < iVar7 * (carObj->angularAcc).y)) &&
       (iVar8 = AIPhysic_GetRearEndDamageFactor(carObj),
       (0x10000 - iVar8) * 0x14 + (*(int *)((char *)carObj->personality + 0x2c) + -0x14) * 0x10000 <
       iVar9 << 0x10)) {
      carObj->AIFishtailEndTick = simGlobal[1] + 0x96;
    }
  }
  iVar8 = fixedmult(0x80,AIPhysicConfig.ICModel.dangle_to_dav);
  iVar9 = AIPhysicConfig.ICModel.max_dav;
  if (-iVar7 * iVar8 < AIPhysicConfig.ICModel.max_dav) {
    iVar9 = -iVar7 * iVar8;
  }
  iVar7 = -AIPhysicConfig.ICModel.max_dav;
  if (-AIPhysicConfig.ICModel.max_dav < iVar9) {
    iVar7 = iVar9;
  }
  iVar9 = carObj->speed;
  if ((-AIPhysicConfig.ICModel.vel_limit_range < carObj->currentSpeed) &&
     (carObj->currentSpeed < AIPhysicConfig.ICModel.vel_limit_range)) {
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    iVar8 = AIPhysicConfig.ICModel.ang_vel_limit_factor;
    if (AIPhysicConfig.ICModel.ang_vel_limit_factor < 0) {
      iVar8 = AIPhysicConfig.ICModel.ang_vel_limit_factor + 0xff;
    }
    iVar9 = (iVar9 >> 8) * (iVar8 >> 8);
    if (iVar9 < 0) {
      iVar9 = -iVar9;
    }
    iVar8 = iVar9;
    if (iVar7 < iVar9) {
      iVar8 = iVar7;
    }
    iVar7 = -iVar9;
    if (-iVar9 < iVar8) {
      iVar7 = iVar8;
    }
  }
  iVar9 = fixedmult((carObj->angularVel_ch).y - iVar7,AIPhysicConfig.ICModel.dav_to_aa);
  iVar7 = iVar4;
  if (-iVar9 < iVar4) {
    iVar7 = -iVar9;
  }
  iVar9 = -iVar4;
  if (-iVar4 < iVar7) {
    iVar9 = iVar7;
  }
  iVar4 = fixedmult(local_40,iVar3);
  iVar3 = iVar10;
  if (-local_38 * iVar4 < iVar10) {
    iVar3 = -local_38 * iVar4;
  }
  iVar4 = -iVar10;
  if (-iVar10 < iVar3) {
    iVar4 = iVar3;
  }
  if (((carObj->currentSpeed * local_38 < local_34 * local_38) && (carObj->pullOver == 0)) &&
     (carObj->desiredDirection == carObj->direction)) {
    iVar10 = AIPhysic_CalcAcceleration(carObj,carObj->currentSpeed);
    cVar1 = (carObj->control).brakeLevel;
    if (cVar1 == '\0') {
      (carObj->control).brakeLevel = '\0';
    }
    else {
      (carObj->control).brakeLevel = cVar1;
    }
    if ((carObj->control).brakeLevel == '\0') {
      (carObj->control).desiredBrakeLevel = '\0';
    }
  }
  else {
    iVar3 = AIPhysic_CalcDeceleration(carObj);
    bVar2 = (carObj->control).brakeLevel;
    if (bVar2 < 0xff) {
      (carObj->control).brakeLevel = bVar2;
    }
    else {
      (carObj->control).brakeLevel = -1;
    }
    if (3 < (u_char)(carObj->control).brakeLevel) {
      (carObj->control).desiredBrakeLevel = '\x01';
    }
    iVar10 = -iVar3;
    if ((carObj->linearVel_ch).z < 0) {
      iVar10 = iVar3;
    }
  }
  if (local_30 != 0) {
    iVar10 = -*(int *)(AIPerson_ScriptData[0x41].reaction + iVar5 * 4);
  }
  if (iVar11 == 0) {
    if (local_40 < 0) {
      local_40 = -local_40;
    }
    iVar11 = local_40 - AIPhysicConfig.skid_value;
  }
  if (iVar11 < 1) {
    carObj->rearSkid = 0;
    carObj->frontSkid = 0;
  }
  else {
    carObj->rearSkid = iVar11;
    carObj->frontSkid = iVar11;
  }
  (carObj->linearAcc_ch).x = iVar4;
  (carObj->linearAcc_ch).y = 0;
  (carObj->linearAcc_ch).z = iVar10;
  (carObj->linearAcc_rh).x = 0;
  (carObj->linearAcc_rh).y = 0;
  (carObj->linearAcc_rh).z = 0;
  (carObj->angularAcc).x = 0;
  (carObj->angularAcc).y = iVar9;
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
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  int local_60;
  int local_5c;
  int local_58;
  int local_54;
  int local_50;
  int local_4c;
  int local_48;
  int local_44;
  int local_40;
  int local_38;
  int local_34;
  int local_30;
  int local_2c;
  int local_28;
  int local_24;
  int local_20;
  int local_1c;
  int local_18;

  (carObj->linearAcc_ch).z = (carObj->linearAcc_ch).z + (carObj->linearAcc_rh).z;
  Cars_DoGravityEffectsOnAcc(carObj,0);
  (carObj->linearAcc_ch).z = (carObj->linearAcc_ch).z - (carObj->linearAcc_rh).z;
  transpose(&(carObj->N).orientMat,(matrixtdef *)&local_60);
  transpose(&(carObj->N).roadMatrix,(matrixtdef *)&local_38);
  iVar1 = fixedmult((carObj->linearAcc_ch).x,local_60);
  iVar2 = fixedmult((carObj->linearAcc_ch).y,local_5c);
  iVar3 = fixedmult((carObj->linearAcc_ch).z,local_58);
  (carObj->linearAcc).x = iVar1 + iVar2 + iVar3;
  iVar1 = fixedmult((carObj->linearAcc_ch).x,local_54);
  iVar2 = fixedmult((carObj->linearAcc_ch).y,local_50);
  iVar3 = fixedmult((carObj->linearAcc_ch).z,local_4c);
  iVar9 = (carObj->linearAcc_ch).x;
  (carObj->linearAcc).y = iVar1 + iVar2 + iVar3;
  iVar1 = fixedmult(iVar9,local_48);
  iVar2 = fixedmult((carObj->linearAcc_ch).y,local_44);
  iVar3 = fixedmult((carObj->linearAcc_ch).z,local_40);
  iVar9 = (carObj->linearAcc_rh).x;
  (carObj->linearAcc).z = iVar1 + iVar2 + iVar3;
  iVar1 = fixedmult(iVar9,local_38);
  iVar2 = fixedmult((carObj->linearAcc_rh).y,local_34);
  iVar3 = fixedmult((carObj->linearAcc_rh).z,local_30);
  (carObj->linearAcc).x = (carObj->linearAcc).x + iVar1 + iVar2 + iVar3;
  iVar1 = fixedmult((carObj->linearAcc_rh).x,local_2c);
  iVar2 = fixedmult((carObj->linearAcc_rh).y,local_28);
  iVar3 = fixedmult((carObj->linearAcc_rh).z,local_24);
  iVar9 = (carObj->linearAcc_rh).x;
  (carObj->linearAcc).y = (carObj->linearAcc).y + iVar1 + iVar2 + iVar3;
  iVar1 = fixedmult(iVar9,local_20);
  iVar2 = fixedmult((carObj->linearAcc_rh).y,local_1c);
  iVar3 = fixedmult((carObj->linearAcc_rh).z,local_18);
  iVar9 = (carObj->angularAcc).x;
  (carObj->linearAcc).z = (carObj->linearAcc).z + iVar1 + iVar2 + iVar3;
  iVar1 = fixedmult(iVar9,local_60);
  iVar2 = fixedmult((carObj->angularAcc).y,local_5c);
  iVar3 = fixedmult((carObj->angularAcc).z,local_58);
  iVar9 = fixedmult((carObj->angularAcc).x,local_54);
  iVar4 = fixedmult((carObj->angularAcc).y,local_50);
  iVar5 = fixedmult((carObj->angularAcc).z,local_4c);
  iVar6 = fixedmult((carObj->angularAcc).x,local_48);
  iVar7 = fixedmult((carObj->angularAcc).y,local_44);
  iVar8 = fixedmult((carObj->angularAcc).z,local_40);
  (carObj->angularAcc).x = iVar1 + iVar2 + iVar3;
  (carObj->angularAcc).y = iVar9 + iVar4 + iVar5;
  (carObj->angularAcc).z = iVar6 + iVar7 + iVar8;
  iVar1 = fixedmult((carObj->linearAcc).x,AIPhysic_iTime);
  iVar2 = (carObj->linearAcc).y;
  (carObj->N).linearVel.x = (carObj->N).linearVel.x + iVar1;
  iVar1 = fixedmult(iVar2,AIPhysic_iTime);
  iVar2 = (carObj->linearAcc).z;
  (carObj->N).linearVel.y = (carObj->N).linearVel.y + iVar1;
  iVar1 = fixedmult(iVar2,AIPhysic_iTime);
  iVar2 = carObj->drag;
  (carObj->N).linearVel.z = (carObj->N).linearVel.z + iVar1;
  for (iVar1 = 0; (iVar2 != 0 && (iVar1 < AIPhysic_elapsedTime)); iVar1 = iVar1 + 1) {
    iVar2 = fixedmult((carObj->N).linearVel.x,carObj->drag);
    iVar3 = (carObj->N).linearVel.y;
    iVar9 = carObj->drag;
    (carObj->N).linearVel.x = iVar2;
    iVar2 = fixedmult(iVar3,iVar9);
    iVar3 = (carObj->N).linearVel.z;
    iVar9 = carObj->drag;
    (carObj->N).linearVel.y = iVar2;
    iVar3 = fixedmult(iVar3,iVar9);
    iVar2 = carObj->drag;
    (carObj->N).linearVel.z = iVar3;
  }
  (carObj->N).angularVel.x = (carObj->N).angularVel.x + fixedmult((carObj->angularAcc).x,AIPhysic_iTime);
  (carObj->N).angularVel.y = (carObj->N).angularVel.y + fixedmult((carObj->angularAcc).y,AIPhysic_iTime);
  (carObj->N).angularVel.z = (carObj->N).angularVel.z + fixedmult((carObj->angularAcc).z,AIPhysic_iTime);
  return;
}

/* ---- AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType  (oracle computes a per-tick
 * ramp STEP = elapsedTime*51 + (elapsedTime*51)<<8 = elapsedTime*13107 (via 3<<4+3 shift-add, not
 * a plain multiply) and clamps rampDesiredLatPos toward desiredLatPos by at most that step; my
 * earlier recon dropped the whole step-ramp tail entirely -- SYM/oracle-driven full rewrite) ---- */
void AIPhysic_CalculateRampedDesiredLatPos(Car_tObj *carObj,eRampType rampType)
{
  int rampStepLo;
  int rampStepHi;
  int rampStep;
  int roadPos;
  int rampPos;
  int desiredPos;

  if (rampType == 1) {
    carObj->rampDesiredLatPos = carObj->desiredLatPos;
    return;
  }
  AIWorld_CalculateDeltaRoadYaw(carObj);
  roadPos = carObj->roadPosition;
  rampStepLo = AIPhysic_elapsedTime * 3;
  rampStepLo = rampStepLo + rampStepLo * 16;
  rampStepHi = rampStepLo << 8;
  rampStep = rampStepLo + rampStepHi;
  if (carObj->desiredLatPos < roadPos) {
    if (roadPos < carObj->rampDesiredLatPos + -0x10000) {
      carObj->rampDesiredLatPos = roadPos;
      goto tail;
    }
  } else {
    rampStep = rampStepLo + rampStepHi;
  }
  roadPos = carObj->roadPosition;
  if ((carObj->rampDesiredLatPos + 0x10000 < roadPos) && (roadPos < carObj->desiredLatPos)) {
    carObj->rampDesiredLatPos = roadPos;
  }
tail:
  rampPos = carObj->rampDesiredLatPos;
  desiredPos = carObj->desiredLatPos;
  if (rampPos < desiredPos) {
    rampPos = rampPos + rampStep;
    carObj->rampDesiredLatPos = rampPos;
    if (desiredPos < rampPos) {
      carObj->rampDesiredLatPos = desiredPos;
    }
  } else if (desiredPos < rampPos) {
    rampPos = rampPos - rampStep;
    desiredPos = carObj->desiredLatPos;
    carObj->rampDesiredLatPos = rampPos;
    if (rampPos < desiredPos) {
      carObj->rampDesiredLatPos = desiredPos;
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
    if (2000 < iVar5) {
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
  /* MATCH: residual 3-diff xori/beqz vs bnez branch-sense floor (2000<iVar5 guard) —
     tried &&/||, empty-if/else, goto-skip, >=2001, !(x<2001): all identical RTL, gcc
     canonicalizes the comparison the same way regardless of source phrasing. Genuine
     floor (§F scheduling class), not source-shapable without a forbidden pin. */
}

/* ---- AIPhysic_InitCar__FP8Car_tObj ---- */
void AIPhysic_InitCar(Car_tObj *carObj)
{
  int d;
  int deceleration;
  int invDeceleration;
  int brakeTableLoop;
  int brakeDistanceMeters;
  int distance;
  int sIndex;
  AIPhysic_BrakeInfo *pAVar1;
  int iVar2;
  int iVar3;
  u_int carFlags;
  u_int uVar4;
  int iVar5;
  int iVar6;

  carFlags = carObj->carFlags;
  if ((carFlags & 2) != 0) {
    iVar5 = 0xc0000;
    if ((carFlags & 0x28) != 0) {
      iVar5 = 0xb0000;
    }
    iVar3 = *(int *)((char *)carObj->personality + 0x20);
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xff;
    }
    iVar5 = (iVar3 >> 8) * (iVar5 >> 8);
    if ((carFlags & 8) != 0) {
      iVar3 = AISpeeds_GetUpgradeBrakeMult(carObj->carIndex);
      if (iVar5 < 0) {
        iVar5 = iVar5 + 0xff;
      }
      if (iVar3 < 0) {
        iVar3 = iVar3 + 0xff;
      }
      iVar5 = (iVar5 >> 8) * (iVar3 >> 8);
    }
    pAVar1 = (AIPhysic_BrakeInfo *)__builtin_new(0x84);
    pAVar1->deceleration_ = iVar5;
    iVar5 = fixeddiv(0x10000,iVar5);
    for (iVar3 = 0; uVar4 = iVar3 << 0x10, iVar3 < 0x80; iVar3 = iVar3 + 1) {
      iVar2 = fixedmult(uVar4,iVar5);
      iVar2 = fixedmult(iVar2,uVar4);
      iVar2 = iVar2 / 2;
      if ((int)uVar4 < 0) {
        uVar4 = uVar4 | 0xffff;
      }
      iVar6 = (int)uVar4 >> 0x10;
      if (iVar6 < 0) {
        iVar6 = -iVar6;
      }
      if (0x7f < iVar6) {
        iVar6 = 0x80;
      }
      if (iVar2 < 0) {
        iVar2 = iVar2 + 0x1ffff;
      }
      pAVar1->brakeTable_[iVar6] = (u_char)(iVar2 >> 0x11);
    }
    carObj->brakeInfo = pAVar1;
  }
  return;
}
