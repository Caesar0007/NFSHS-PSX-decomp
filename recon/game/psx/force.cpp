/* game/psx/force.cpp -- RECONSTRUCTED (NFS4 PSX force-feedback / rumble; C++ TU)
 *   9 fns: Force_Vbl (per-frame pump), Force_Update (per-car effect dispatch), Force_StartUp,
 *   Force_Disable, Force_IsForceOn, Force_Pause, Force_UnPause, Force_HitSign, Force_HitWall.
 *   Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "force_externs.h"

/* ---- Force.obj-OWNED globals -- DEFINED here (self-contained; SYM-typed via gen_owned_defs:
   .data = real NFS4.EXE bytes, .bss = zero) ---- */
u_char       Force_rand_256[256] = { 0, 128u, 64u, 192u, 32u, 160u, 96u, 224u, 16u, 144u, 80u, 208u, 48u, 176u, 112u, 240u, 8u, 136u, 72u, 200u, 40u, 168u, 104u, 232u, 24u, 152u, 88u, 216u, 56u, 184u, 120u, 248u, 4u, 132u, 68u, 196u, 36u, 164u, 100u, 228u, 20u, 148u, 84u, 212u, 52u, 180u, 116u, 244u, 12u, 140u, 76u, 204u, 44u, 172u, 108u, 236u, 28u, 156u, 92u, 220u, 60u, 188u, 124u, 252u, 2u, 130u, 66u, 194u, 34u, 162u, 98u, 226u, 18u, 146u, 82u, 210u, 50u, 178u, 114u, 242u, 10u, 138u, 74u, 202u, 42u, 170u, 106u, 234u, 26u, 154u, 90u, 218u, 58u, 186u, 122u, 250u, 6u, 134u, 70u, 198u, 38u, 166u, 102u, 230u, 22u, 150u, 86u, 214u, 54u, 182u, 118u, 246u, 14u, 142u, 78u, 206u, 46u, 174u, 110u, 238u, 30u, 158u, 94u, 222u, 62u, 190u, 126u, 254u, 1u, 129u, 65u, 193u, 33u, 161u, 97u, 225u, 17u, 145u, 81u, 209u, 49u, 177u, 113u, 241u, 9u, 137u, 73u, 201u, 41u, 169u, 105u, 233u, 25u, 153u, 89u, 217u, 57u, 185u, 121u, 249u, 5u, 133u, 69u, 197u, 37u, 165u, 101u, 229u, 21u, 149u, 85u, 213u, 53u, 181u, 117u, 245u, 13u, 141u, 77u, 205u, 45u, 173u, 109u, 237u, 29u, 157u, 93u, 221u, 61u, 189u, 125u, 253u, 3u, 131u, 67u, 195u, 35u, 163u, 99u, 227u, 19u, 147u, 83u, 211u, 51u, 179u, 115u, 243u, 11u, 139u, 75u, 203u, 43u, 171u, 107u, 235u, 27u, 155u, 91u, 219u, 59u, 187u, 123u, 251u, 7u, 135u, 71u, 199u, 39u, 167u, 103u, 231u, 23u, 151u, 87u, 215u, 55u, 183u, 119u, 247u, 15u, 143u, 79u, 207u, 47u, 175u, 111u, 239u, 31u, 159u, 95u, 223u, 63u, 191u, 127u, 254u };   /* @0x8011fc60 */
Force_tGlobal Force_g[2];   /* @0x8011fd60  (bss(zero)) */
u_char       Force_gActAlign[6] = { 0, 1u, 255u, 255u, 255u, 255u };   /* @0x8013d840 */
u_char       Force_gOffAlign[6] = { 255u, 255u, 255u, 255u, 255u, 255u };   /* @0x8013d848 */
u_short      Force_gTick;   /* @0x8013d84e  (bss(zero)) */
long         Force_gVblHandle;   /* @0x8013d850  (bss(zero)) */

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Force_Vbl(void);
void Force_Update(Car_tObj *car);
void Force_StartUp(void);
void Force_Disable(void);
int Force_IsForceOn(Car_tObj *car);
void Force_Pause(void);
void Force_UnPause(void);
void Force_HitSign(Car_tObj *car);
void Force_HitWall(int impulse);


/* ---- Force_Vbl__Fv  [FORCE.CPP:61-98] SLD-VERIFIED ----
 * w38-a9 full rewrite from the SLD line map + raw oracle.  SYM says the ONLY
 * locals are `i` ($s2, outer block) and, in the LOOP block, `padnum` ($s1) +
 * `padstate` ($v1) -- there is NO pointer local, so `Force_g[i]` is indexed and
 * the walking `$s0` is gcc's strength-reduced giv; `$s3` is the LICM-hoisted
 * `Force_rand_256` base.  SLD statement map: 66 PadGetState / 68 `!=6` test /
 * 70-71 the `<4` arm (FALL-THROUGH, hence the `!= 6` spelling: the ==6 block is
 * the oracle's BRANCH TARGET at .L800CA9F8) / 73-77 the ==6 arm / 79 fade<time /
 * 81-83 + 87-89 + 93-95 the three actuator arms / 97 loop increment /
 * 98 Force_gTick++ AFTER the loop.
 * All arithmetic is SIGNED int (u_char operands promote): oracle uses `slt`,
 * `mult`, `div` + the maspsx --expand-div `break 7`/`break 6` guards -- the old
 * u_int-cast recon emitted sltu/multu/divu.  The `jolt*time/fade` term is
 * written TWICE on purpose: the intervening `actuator[0]` store kills gcc's
 * memory CSE, which is exactly why the oracle has two mult/div sequences.
 *
 * w39-a7: 46 -> PASS 138/138.  FOUR cooperating fixes, in the order they paid:
 *  (1) -G8 (see tools/build.py PER_TU_FLAGS): 46 -> 40.
 *  (2) `Force_tGlobal *f = &Force_g[i];` + `f->` throughout.  The indexed `Force_g[i].x`
 *      form made loop.c build THREE induction/base pseudos -- a base `&Force_g`, an
 *      OFFSET giv `8*i` and a SECOND base `&Force_g+6` for the
 *      `PadSetAct(...,Force_g[i].actuator,...)` argument -- costing 2 extra callee-saved
 *      registers ($s4,$s5) and a 48-byte frame.  Retail has ONE +8 pointer walker in $s0,
 *      the actuator arg as a plain `addiu $a1,$s0,6` displacement, and a 40-byte frame
 *      (SYM fsize 40, mask $800F0000 = ra,s3,s2,s1,s0).  40 -> 8, count exact 138/138.
 *  (3) `padnum = i << 4` (NOT `i * 16`): the multiply spelling let gcc compute the product
 *      straight into the call-arg register and copy it BACK to padnum's home ($s1); retail
 *      does `sll $s1,$s2,4` into padnum's home in the loop guard's delay slot and copies
 *      to `$a0` in the `jal` delay slot.  8 -> 2.
 *  (4) `f->time > f->fade` (NOT `f->fade < f->time`): compare operand order IS load order
 *      for cc1plus (left to right) and retail loads `time` (+4) before `fade` (+5). 2 -> 0.
 * The 0xff clamp is spelled `actuator1 = 0xff; if (... < 0x100) actuator1 = ...;` rather
 * than the ternary `(... > 0xff) ? 0xff : ...`, which narrows the clamp constant against
 * the u_char destination and emits `li $a2,-1` where retail has `li $a2,0xFF`; the if-form
 * also lands the 255 default in the `beqz` delay slot and shares ONE clamp block between
 * the two arms, exactly like the oracle's .L800CAB3C.
 * HONESTY NOTE: the SYM lists only `i`/`padnum`/`padstate` as named locals, so retail's
 * source had NO `f` and no `actuator1`; both are matching devices standing in for the giv
 * retail's cc1 derived from the indexed form and for its anonymous clamp temp.  The
 * emitted instruction stream is byte-identical either way. */
void Force_Vbl(void)

{
  int i;

  for (i = 0; i < 2; i = i + 1) {
    Force_tGlobal *f;
    int padnum;
    int padstate;
    int actuator1;

    f = &Force_g[i];
    padnum = i << 4;
    padstate = PadGetState(padnum);
    if (padstate != 6) {
      if (padstate < 4) {
        f->active = 0;
      }
    }
    else if (f->active == 0) {
      PadSetAct(padnum,f->actuator,2);
      PadSetActAlign(padnum,Force_gActAlign);
      f->active = 1;
    }
    if (f->time > f->fade) {
      f->actuator[0] =
           Force_rand_256[Force_gTick >> 1 & 0xff] < f->high + f->jolt;
      actuator1 = 0xff;
      if (f->low + f->jolt < 0x100) {
        actuator1 = f->low + f->jolt;
      }
      f->actuator[1] = actuator1;
      f->time = f->time - 1;
    }
    else if (f->time != 0) {
      f->actuator[0] =
           Force_rand_256[Force_gTick >> 1 & 0xff] <
           f->jolt * f->time / f->fade + f->high;
      actuator1 = 0xff;
      if (f->jolt * f->time / f->fade + f->low < 0x100) {
        actuator1 = f->jolt * f->time / f->fade + f->low;
      }
      f->actuator[1] = actuator1;
      f->time = f->time - 1;
    }
    else {
      f->jolt = 0;
      f->actuator[0] = Force_rand_256[Force_gTick >> 1 & 0xff] < f->high;
      f->actuator[1] = f->low;
    }
  }
  Force_gTick = Force_gTick + 1;
}

/* ---- Force_Update__FP8Car_tObj  [FORCE.CPP:105-223] SLD-VERIFIED ----
 * w38-a9: 432 -> 326 diffs.  The SYM declares a real `Force_tGlobal *f` ($s6) which
 * the recon had declared but left UNWIRED (every access went through the indexed
 * `Force_g[carIndex]`, costing a re-materialized base + index at each site).  Wiring
 * `f = &Force_g[carIndex]` once and using `f->field` throughout dropped 12 insns.
 * w39-a7: 326 -> 223 diffs (271/278).  The rule-8 pass the old note called for, plus
 * three branch-polarity/operand-order fixes read off the raw oracle:
 *  (1) SYM locals WIRED: `skids` ($a1) and `impacts` ($a3) are the two
 *      GameSetup_gData.controllerData reads (shockMode@0xA8 / shockImpact@0xB0) -- they
 *      are CALLER-saved in retail because they are dead after the multiplier setup;
 *      Ghidra had fused them with later values (`iVar4`/`iVar5`), which forced them into
 *      callee-saved registers.  `impactmultiplier` ($s7), `v0` ($s4) / `v1` ($s3) (the
 *      two road-surface accumulators) and the loop's `c` ($s5) / `force` ($s2) /
 *      `shock` ($v1) / `time` ($s0) are named now too.
 *  (2) the front/rear multipliers are THREE separate `if (skids != 0)` / `if (skids != 0)`
 *      / `if (impacts != 0)` guards, not one fused if/else -- the oracle has three
 *      distinct `beqz $a1/$a1/$a3` tests, each with its own zero-store block, and the
 *      NON-zero body is the FALL-THROUGH (so the guard must be spelled `!= 0`).
 *  (3) the Ghidra `iVar8`/`iVar11` snapshot-and-restore dance around the impact block was
 *      an artifact of Ghidra reusing the accumulator variables inside it.  Retail uses
 *      three DIFFERENT locals there (force/shock/time), so v0/v1 are simply not touched;
 *      writing it that way deletes the whole save/restore pair.
 *  (4) the two surface-clamp arms must use a CALLER-saved temp for `|linearVel.z|` (the
 *      oracle holds it in $v0 in BOTH arms); Ghidra had the 10..0xF arm reusing `v1`.
 *
 * w40-a7: 223 -> PASS 278/278.  SIX cooperating fixes, in the order they paid:
 *  (1) 🔴 CORRECTNESS: five `(u_int)x >> 0x10` unsigned shifts (a10's w39 census hit
 *      `srl 5 vs 0`) were Ghidra's rendering of gcc's SIGNED divide-by-2^16 expansion.
 *      The oracle has ZERO `srl` and twelve `sra`, each guarded by `bgez x,L;
 *      addu x,x,$fp` with `$fp` holding 65535 (0xFFFF does not fit an addiu imm16, so
 *      gcc materializes it in a register and CSEs it across the loop).  Every site is a
 *      plain `/ 0x10000` in C -- writing the guard by hand emitted the unsigned shift and
 *      ROUNDED NEGATIVE VALUES THE WRONG WAY.  223 -> 205.
 *  (2) 🔴 the audio-event walk is `car->audio[c]` (Cars_tAudio[7] @+0x798, stride 24),
 *      NOT the Ghidra `(car->N).simRoadInfo.quadPts[c*2-4].z` + `piVar6[0x1e7]` int-index
 *      soup.  Index form keeps the member offsets (0x79C/0x7A0/0x7A8) as LOAD
 *      DISPLACEMENTS off a single `car + c*24` giv that loop.c walks by -24 -- exactly the
 *      oracle -- and deletes the fabricated `piVar6`/`iVar2` locals (the SYM lists NO
 *      pointer local for this loop).  Loop shape is exit-in-the-middle
 *      `while (1) { if (c < 0) break; ...; c = c - 1; }` = the oracle's top `bltz` + the
 *      unconditional `j` back-edge (a `for`/`while` rotates it).  SYM block scopes applied:
 *      `c` is local to the `audioCount != 0` body (Block start line 62) and
 *      `force`/`shock`/`time` to the impact arm (Block start line 77).  205 -> 185.
 *  (3) `(fixeddiv(...) << 5) / 0x10000`, NOT `... * 0x20 / 0x10000`: gcc-2.8 FOLDS
 *      `(x*32)/65536` into `x/2048` (`addiu 2047; sra 11`), which the oracle does not
 *      have.  The shift spelling survives fold, then cse turns it back into `sll 5`
 *      followed by the full `/0x10000` guard+`sra 16` the oracle shows.  185 -> 141.
 *  (4) the two post-loop results are the SYM locals `v0`/`v1` REUSED
 *      (`v0 = fixedmult(...)/0x10000;` ... `f->high = (u_char)v0;`), not fresh `u_char`
 *      temps: a u_char destination lets gcc narrow the divide's final shift to `srl`,
 *      and the oracle keeps both results in v0's/v1's own callee-saved regs across the
 *      second `fixedmult` call.  The pre-call clamp needs a block-local `clamped` copy
 *      (`clamped = v0; if (0xa0000 < clamped) clamped = 0xa0000;`) so the clamp happens
 *      on the arg-register copy (`addu $a0,$s4,$zero; lui $v0,10; slt; lui $a0,10`)
 *      instead of writing back into v0.  Guard polarity is `!= 0` (body = fall-through).
 *      141 -> 130.
 *  (5) the surface clamps ARE the both-arms-assign ternary
 *      `v1 = 0x78000 < X ? 0x78000 : X;` (the w39 note's "falsified" verdict was measured
 *      against the pre-(1)-(4) body and is WITHDRAWN); the default-then-override form
 *      costs 85 diffs here.  130 -> 45.
 *  (6) 🔑 the last 45 were the constant-materialization ORDER: retail emits
 *      `addu $s4,$zero,$zero; lui $v1,7; ori $v1; lui $s3,7` BEFORE the `lw 0x420`,
 *      with a `nop` in the load-delay slot.  That only happens when the |z| is a
 *      SUB-EXPRESSION of the ternary (so expand_expr materializes both 0x78000 copies
 *      while expanding the comparison, before it ever touches the operand's branches).
 *      Spelling it `__builtin_abs((car->linearVel_ch).z) >> 2` INSIDE both ternary arms
 *      does it -- a hand-rolled `if (t < 0) t = -t;` temp, or an `ABS()`-style macro that
 *      expands to a ternary, both put the load first and lose.  (methodology 5.0c:
 *      `__builtin_abs` inlines on BOTH cc1 2.7.2 and 2.8.0; bare `abs()` emits a `jal`.)
 *      45 -> PASS. */
void Force_Update(Car_tObj *car)

{
  Force_tGlobal *f;
  int skids;
  int impacts;
  int impactmultiplier;
  int v0;
  int v1;
  u_int uVar3;
  int frontmultiplier;
  int rearmultiplier;
  
  uVar3 = car->carIndex;
  if (1 < uVar3) {
    return;
  }
  f = &Force_g[uVar3];
  if (1 < Replay_ReplayMode) {
    f->high = '\0';
    f->low = '\0';
    f->time = '\0';
    return;
  }
  skids = GameSetup_gData.controllerData.shockMode[uVar3];
  impacts = GameSetup_gData.controllerData.shockImpact[uVar3];
  if (skids != 0) {
    frontmultiplier = (skids + 0x10) * 0x2da6;
  }
  else {
    frontmultiplier = 0;
  }
  if (skids != 0) {
    rearmultiplier = (skids + 0x10) * 0x1e6e;
  }
  else {
    rearmultiplier = 0;
  }
  if (impacts != 0) {
    impactmultiplier = (impacts + 0x10) * 0xb699;
  }
  else {
    impactmultiplier = 0;
  }
  v0 = 0;
  v1 = v0;
  if ((car->N).flightTime == 0) {
    switch((car->N).driveSurfaceType) {
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
      v0 = 0;
      v1 = 0x78000 < __builtin_abs((car->linearVel_ch).z) >> 2 ?
           0x78000 : __builtin_abs((car->linearVel_ch).z) >> 2;
      goto ForceUpd_audioRevLoop;
    case 10:
    case 0xb:
    case 0xc:
    case 0xd:
    case 0xf:
      v0 = 0x58000 < __builtin_abs((car->linearVel_ch).z) >> 1 ?
           0x58000 : __builtin_abs((car->linearVel_ch).z) >> 1;
      break;
    case 0xe:
      v0 = 0;
    }
    v1 = 0;
  }
ForceUpd_audioRevLoop:
  if (car->audioCount != 0) {
    int c = car->audioCount + -1;
    while (1) {
      if (c < 0) {
        break;
      }
      if (car->audio[c].channel == 0x12) {
        v0 = v0 > car->audio[c].force * 2 ? v0 : car->audio[c].force * 2;
      }
      else if (car->audio[c].channel == 0x14) {
        v1 = v1 > car->audio[c].force * 2 ? v1 : car->audio[c].force * 2;
      }
      else if ((((car->audio[c].channel < 0) && (impactmultiplier != 0)) &&
                (car->audio[c].surface1 != 10)) && (car->audio[c].surface1 != 8)) {
        int force;
        int shock;
        int time;

        if (0x28000 < car->audio[c].force) {
          force = 0x28000;
          if ((fixeddiv(car->audio[c].force,0x28000) << 5) / 0x10000 < 0x61) {
            time = (fixeddiv(car->audio[c].force,0x28000) << 5) / 0x10000;
          }
          else {
            time = 0x60;
          }
        }
        else {
          force = car->audio[c].force;
          time = 0x20;
        }
        shock = fixedmult(force,impactmultiplier) / 0x10000;
        if (((int)(u_int)f->jolt < shock) || ((int)(u_int)f->time < time)) {
          f->fade = (u_char)(time >> 1);
          f->time = (u_char)time;
          f->jolt = (u_char)shock;
        }
      }
      c = c + -1;
    }
  }
  if (frontmultiplier != 0) {
    int clamped;

    clamped = v0;
    if (0xa0000 < clamped) {
      clamped = 0xa0000;
    }
    v0 = fixedmult(clamped,frontmultiplier) / 0x10000;
  }
  else {
    v0 = 0;
  }
  if (rearmultiplier != 0) {
    int clamped;

    clamped = v1;
    if (0xf0000 < clamped) {
      clamped = 0xf0000;
    }
    v1 = fixedmult(clamped,rearmultiplier) / 0x10000;
  }
  else {
    v1 = 0;
  }
  f->high = (u_char)v0;
  f->low = (u_char)v1;
  return;
}

/* ---- Force_StartUp__Fv  [FORCE.CPP:230-244] SLD-VERIFIED ---- */
void Force_StartUp(void)

{
  Force_tGlobal *f;

  f = Force_g;
  if (f < Force_g + 2) {
    do {
      f->active = '\0';
      f->high = '\0';
      f->low = '\0';
      f->time = '\0';
      f->actuator[0] = '\0';
      f->actuator[1] = '\0';
      f = f + 1;
    } while (f < Force_g + 2);
  }
  VSyncCallback(Force_Vbl);
  Sched_AddFunction(simGlobal.schedule32Hz,Force_Update,Cars_gHumanRaceCarList[0],0x32);
  if (GameSetup_gData.commMode == 1) {
    Sched_AddFunction(simGlobal.schedule32Hz,Force_Update,Cars_gHumanRaceCarList[1],0x32);
  }
  return;
}

/* ---- Force_Disable__Fv  [FORCE.CPP:250-258] SLD-VERIFIED ---- */
/* PASS 29/29 (w39-a7).  The loop body/guard was already exact after w38-a9's guarded
 * do-while + direct struct-member stores; the whole 17-diff residual was the POST-loop
 * tail -- the oracle REMATERIALIZES `Force_gOffAlign`'s address at each of the two
 * `PadSetActAlign` call sites (2x `lui a1;addiu a1`, no saved reg, smaller frame), while
 * our build GCSE-hoisted it into `$s0` across the intervening `jal`.  That was NOT a
 * compiler-internal profitability wall as the old comment claimed: force.obj is a **-G8
 * object** (see tools/build.py PER_TU_FLAGS), and under -G8 the 6-byte Force_gOffAlign is
 * small data, so cc1plus emits the `la` MACRO form instead of splitting %hi/%lo itself --
 * there is no split address expression left for GCSE to hoist.  Fixed by the per-TU
 * g_value=8 key, not by a source change. */
void Force_Disable(void)

{
  Force_tGlobal *f;

  f = Force_g;
  if (f < Force_g + 2) {
    do {
      f->actuator[0] = '\0';
      f->actuator[1] = '\0';
      f = f + 1;
    } while (f < Force_g + 2);
  }
  PadSetActAlign(0,Force_gOffAlign);
  PadSetActAlign(4,Force_gOffAlign);
  VSyncCallback((void *)0x0);
  return;
}

/* ---- Force_IsForceOn__FP8Car_tObj  [FORCE.CPP:264-273] SLD-VERIFIED ---- */
/* PASS 23/23 (w39-a7, was a "certified" 14-diff allocator floor -- the floor claim was
 * WRONG).  Two things had to be right:
 *   (1) branch polarity: the carIndex-range guard is an early-return `if(>=2) return 0;`
 *       (the oracle's fall-through IS the real body), not the inline-body `if(<2){...}`
 *       form -- that had cost 3 extra insns (w38-a9).
 *   (2) the last 14 diffs were NOT the "dead-param $a0 reuse" the old comment blamed.
 *       They are the COMMUTATIVE-addu / sll-vs-base SCHEDULING tie-break (methodology
 *       Sec.5.0c): the oracle computes the scaled index FIRST -- `sll $v0,$a0,3` sits in
 *       the guard's `beqz` delay slot -- then materializes the Force_g base into $v1 and
 *       does `addu $v0,$v0,$v1` (scaled index = addu operand 1).  A plain `Force_g[...]`
 *       subscript makes gcc emit `addu rd,BASE,scaled` and materialize the base first,
 *       which cascades the whole $v0/$v1 pair.  Writing the address as an explicit
 *       int-cast with the INDEX TERM FIRST, `(car->carIndex << 3) + (int)Force_g`, puts the
 *       just-computed shift in addu operand 1 and frees the schedule => byte-exact.
 * Falsified on the way (do not re-try): the single `&&` boolean form (IDA renders this fn
 * as `v1 < 2 && LOBYTE(...) == 1`) REGRESSES 14 -> 20; `u_int` vs `int` for the local is
 * neutral; the dead-param-reuse hack `car = (Car_tObj *)car->carIndex;` also reaches PASS
 * but is not needed once the addu operand order is right.  The named result pointer is
 * SYM's `Force_tGlobal *f` in $v0; GCC CSEs the repeated field read so the index remains
 * in $a0 exactly as IDA (`sub_800CB158`) shows. */
int Force_IsForceOn(Car_tObj *car)

{
  Force_tGlobal *f;

  if (1 < Replay_ReplayMode) {
    return 0;
  }
  if ((u_int)car->carIndex >= 2) {
    return 0;
  }
  f = (Force_tGlobal *)((car->carIndex << 3) + (int)Force_g);
  return f->active == 1;
}

/* ---- Force_Pause__Fv  [FORCE.CPP:279-285] SLD-VERIFIED ---- */
void Force_Pause(void)

{
  Force_tGlobal *f;

  f = Force_g;
  if (f < Force_g + 2) {
    do {
      f->high = '\0';
      f->low = '\0';
      f->time = '\0';
      f = f + 1;
    } while (f < Force_g + 2);
  }
  return;
}

/* ---- Force_UnPause__Fv  [FORCE.CPP:291-292] SLD-VERIFIED ---- */
void Force_UnPause(void)

{
  return;
}

/* ---- Force_HitSign__FP8Car_tObj  [FORCE.CPP:298-299] SLD-VERIFIED ---- */
void Force_HitSign(Car_tObj *car)

{
  return;
}

/* ---- Force_HitWall__Fi  [FORCE.CPP:301-302] SLD-VERIFIED ---- */
void Force_HitWall(int impulse)

{

  int skids;
  int impacts;

  int padnum;

  int v1;
  int v0;

  int impactmultiplier;
  int frontmultiplier;
  int rearmultiplier;
  
  return;
}

/* end of force.cpp */
