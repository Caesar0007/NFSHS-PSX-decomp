/* syslib/psx/libmath/DIVDF3.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj DIVDF3.obj ; libmath.lib.  __divdf3 @0x800F5DD4 (736 B) + _comp_mant @0x800F60B4 (80 B) --
 *   IEEE-754 double divide via restoring bitwise long division of the 53-bit mantissas (_comp_mant compares
 *   64-bit mantissa pairs; _mainasu + _add_mant_d do subtract-and-restore).  IDA verbatim.  The IDA locals
 *   v19/v20, v13/v14, v15/v16 are stack-adjacent word pairs the helpers write through &v19 etc -> int[2]
 *   here (dbl_shift order: out[0]=low word, out[1]=high word).
 *
 *   _comp_mant TOOLCHAIN-IDENTITY WALL (w24-a2, 2026-07-25): NO SYM entry (stripped libmath primitive).
 *   The oracle unconditionally spills EVERY incoming arg to its ABI stack home on entry
 *   (`sw a0,0(sp); sw a1,4(sp); sw a2,8(sp); sw a3,12(sp)`, reusing the CALLER's outgoing-arg shadow
 *   space -- .frame $sp,0) yet NEVER reloads them, using the live registers directly for every `sltu`.
 *   Empirically this "defensive spill, no reload" shape is NOT reachable with CC1PSX.EXE (our cc1) at
 *   ANY optimization level: -O2/-O1 spill nothing (register-only, matches OUR current recon, 0 stores);
 *   -O0 spills to the SAME offsets byte-for-byte but ALSO reloads every operand via `lw` before each
 *   `sltu` (oracle has zero `lw`s); `-fomit-frame-pointer`, `register`-qualified params, and K&R-style
 *   (unprototyped) parameter lists were all tried at every -O level -- none reproduce spill-without-
 *   reload. Corroborated by 3 independent sibling primitives (_add_mant_d, _mainasu, _dbl_shift[_us] --
 *   see ADDMANT.c/MAINASU.c/DBSHIFT[U].cpp) all showing the IDENTICAL signature, while the higher-level
 *   routines in THIS SAME FILE (__divdf3 below) show ORDINARY -O2 register allocation with zero
 *   defensive spills -- i.e. libmath.lib's small arithmetic PRIMITIVES were built by a genuinely
 *   DIFFERENT/older compiler pass than the -O2 CC1PSX.EXE that built the rest of the game (per
 *   methodology §3.20's "libmath vendor wall" precedent + §3.25 PER-MODULE TOOLCHAIN IDENTITY). A prior
 *   session's stack-homing-only experiment on this fn was independently recorded net-neutral, consistent
 *   with this conclusion. STRONG floor (>=4 corroborating fns, exact insn-count divergence, exhaustive
 *   flag sweep) -> transcribed VERBATIM as file-scope __asm__; portable C fallback kept for the host. */
/* W52-A4 CLUSTER IDENTITY (applies to every TU in this directory):
 * retail's libmath is NOT an EA rebuild -- it is Sony's PREBUILT vendor object.
 * Each function's retail bytes appear VERBATIM inside the shipped PsyQ
 * PSX/LIB/LIBMATH.LIB of psq43 / psq44 / psq45 / psq47(Lib43,44,45) AND inside
 * psq43/COFF/LIB/LIBMATH.A (ECOFF magic 0x0162; members named adddf3.o,
 * muldf3.o, ... with symbols `<name>.c` + `gcc2_compiled.` + `__gnu_compiled_c`).
 * Verified 10/10 fns: EXACT where the fn has no relocs, HI16-masked where it
 * has jal/%hi (scratchpad/w52a4_libscan.py).  Identical in every SDK drop from
 * 4.0 to 4.7 => Sony compiled it ONCE with a mid-90s gcc-2.x mips-ecoff and
 * shipped that binary unchanged for years.  CONSEQUENCE: the search axis for
 * this cluster is the COMPILER LADDER (04U), not our 2.8 flag space, and no
 * public source exists for it (Sony's own soft-float: _dbl_shift/_add_mant_d/
 * _mainasu/_comp_mant/_mul_mant_d are NOT FSF libgcc2/fp-bit names; searched
 * rage-racer-decomp + psyz + the whole disk -- nothing).  Full ladder tables and
 * the cracked levers are in GTDF2.c / LTDF2.c / MULSF3.c. */
int _comp_mant(unsigned int a1, unsigned int a2, unsigned int a3, unsigned int a4);   /* fwd decl for __divdf3 below */

unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count);
unsigned int *_dbl_shift_us(unsigned int *out, int dir, unsigned int w0, int w1, int count);
int          *_add_mant_d(int *out, unsigned int a2, int a3, unsigned int a4, int a5);
int          *_mainasu(int *out, int a2, int a3);
int           _err_math(int errnum, int code);

/* MATCH (W55-A4): 300 -> 27 diffs, ours 183 / oracle 184.  Lane RE-WIRED
 * {"cc1_alt": "2.7.2"} (was 2.91.66 = now the WORST rung; 04Z re-ladder on the
 * landed basin: 2.6.0/2.6.3=30 * 2.7.2-970404/2.7.2=27 * 2.8.0/2.8.1=28
 * [count-EXACT 184/184] * 2.91.66=171 * 2.95.2=164).
 *
 * THE FIVE LANDINGS, in the order they were measured (each gated separately):
 *   300 -> 192  `double a, double b` + `double_long` union (05B pair law): the
 *                entry `addu $tN,$aN,$zero` quartet appears.
 *   192 -> 188  arm ORDER: the zero tests are POSITIVE (`if (b==0) {..} else if
 *                (a==0) {..} else {main}`), so the small arms are the FALL-THROUGH
 *                (oracle `bnez v1,<else>` / `bnez t2,<else>`), not branch targets.
 *   [re-ladder] 188 -> 92 on 2.6.x, and later 27 on 2.7.2 -- the rung table had
 *                fully INVERTED vs the pre-landing one (04Z).
 *    92 -> 53   05C REF-FENCE on `n` (`__asm__("" : : "r"(n))` before the tail
 *                _dbl_shift_us).  WHY: `ur` is a size-2 DFmode allocno, so
 *                global.c's priority (floor_log2(refs)*refs/live_length * SIZE)
 *                doubles it and it takes the first free even pair $s0:$s1,
 *                pushing n/exp to $s2/$s3 -- the exact MIRROR of retail.  One
 *                extra ref on `n` flips the order to retail's {n=$s0, exp=$s1,
 *                ur=$s2:$s3}.  Falsified first: all 6 decl orders (no effect),
 *                a `int rlo,rhi` funnel (69: gets the arms right but strands the
 *                words in $v0/$v1 + 2 extra moves), fences on exp alone (92).
 *    53 -> 40   `int *dp = buf;` in the LOOP PREHEADER, used only as the
 *                _add_mant_d out-arg -> retail's `addiu $s5,$sp,0x30` + `addu
 *                $a0,$s5,$zero` + the $s5 save (frame 0x60 -> 0x68).  Assigning
 *                dp at the top of the arm instead scores 62; routing every
 *                buf-pointer arg through dp also 62.
 *    40 -> 34   buf init STORE ORDER = hi-then-lo per operand
 *                (buf[1],buf[0],buf[3],buf[2]).
 *    34 -> 27   `exp -= 1;` AFTER the pre-shift call (retail fills the
 *                `jal _dbl_shift` delay slot with it).
 *
 * RESIDUAL (27, ours 1 insn short): (a) the div-by-zero arm -- retail
 * re-materializes 0x7FFFFFFF fresh into $s3 (`li s3,-1; lui; ori`) while our cse
 * REUSES the live mask constant in $v0 and adds a `addu s3,v0,zero` (this also
 * flips the ternary's branch polarity beqz/bnez -- ONE root cause, 4 diffs).
 * FALSIFIED here: 4 ternary/if spellings, 0xFFFFFFFF vs -1, lo-first, and 4 fence
 * placements (void, "r"(sign), after-hi, lo-first) -- all neutral or worse.
 * (b) arg-load ORDER at the three `_add_mant_d` sites: retail emits arg4 right
 * after the arg5 stack store (5,4,2,3), ours defers it (5,2,3,4). (c) three
 * reorg delay-slot picks (`addiu a0,sp,0x18` / `addiu s1,s1,1` / `addu
 * s1,zero,zero`).  NAMED NEXT ANGLE for (a): stop cse from carrying the mask
 * constant into the arm -- an opacity device on the b-side mask, not a barrier
 * (barriers were falsified).  NOT a floor.
 *
 * MATCH (w60-a5, 2026-08-14): 27 -> 25.  Residual (c) half-cleared: the
 * exponent update belongs BEFORE its `_add_mant_d` call, not after -- reorg's
 * backward scan can only steal an insn that PRECEDES the jal, so after the call
 * `exp += 1` / `exp = 0` are unreachable to it and the a0 arg-setup gets stolen
 * instead; moved, retail's `addiu $s1,$s1,1` / `addu $s1,$zero,$zero` land in
 * the two slots.  (Arm 1 carries the whole win; arm 2's move is oracle-evidenced
 * and gate-neutral, kept for faithfulness.)
 * FALSIFIED at 25 for residual (b), the arg-load order: a named temp for arg4
 * `t[0]` 27 | a named temp for the arg5 `t[1]` 25 | a pointer local for `q`
 * assigned at the top of the arm 25.  And re-confirmed for (a) at this basin:
 * if/else instead of the ternary 69 (head) / 73 (tail) / 73 (both), inverted
 * if/else 70 -- the ternary IS retail's shape, the residual is cse's mask reuse
 * exactly as the note above says.
 *
 * MATCH (W61-A9, 2026-08-15): 25 -> 22, two statement-position landings.
 *   (1) arm 2 reordered to `n += 1; _add_mant_d(...); exp = 0;` (25 -> 23).
 *       LAW CORRECTION to the w60-a5 paragraph above: reorg fills a CALL delay
 *       slot from EITHER side, not only from before.  Written BEFORE the call,
 *       `exp = 0` competes with the argument setup and loses; written AFTER it
 *       is the nearest forward candidate and wins -- retail's
 *       `addu $s1,$zero,$zero` now sits in the jal slot.  (Same law landed
 *       ADDDF3 38 -> 12 the same day; see ADDDF3.c for the full statement.)
 *       Pairing matters: `call; exp = 0; n += 1;` measures 24/25 -- `n += 1`
 *       must move BEFORE the call for the slot pick to land.
 *   (2) `qp = q;` hoisted ABOVE the `if (exp >= 0)` and both calls made through
 *       `qp` (23 -> 22).  With the out-pointer common to both arms, reorg can
 *       lift `addiu a0,sp,24` into the `bltz` delay slot exactly like retail
 *       (previously ours left the bltz slot to the arm body).
 * FALSIFIED at 22 (whole-TU gated, scratchpad/w61a9/div_v*.json): arm1
 * `exp += 1` after its call 22 (inert) * arm1 `exp += 1` hoisted above the t
 * stores 23 * arm2 `n += 1` after the call 24 * both-after 24 * arm2
 * `exp = 0` before + `n += 1` after 24 * arm1 t-stores before `n = 1` 23 *
 * arm1 `t[0] = 1` literal 86 * arm2 `t[1] = 0` after `t[0]` 25 * NaN head
 * if/else with -1 first 71 * `sign == 0` ternary 24 * named temps for arg2/arg3
 * at both t sites 76 * named temp for arg4 22 (inert) * named temp for arg4 in
 * the loop site 24 * swapped signedness in the `_add_mant_d` prototype 22
 * (inert).
 *
 * RESIDUAL (22, ours 182 / oracle 184): unchanged in KIND -- (a) the
 * div-by-zero arm's cse mask reuse (4) and (b) the arg4-load order at the three
 * `_add_mant_d` sites (6), plus their alignment fallout.  Both are the same
 * class ADDDF3 ends on: our cse carries a live value where retail
 * re-materializes / re-loads.  See ADDDF3.c's NAMED NEXT ANGLE (a cse
 * cost-model question, reachable through the cc1 instrument lane, not through
 * spellings -- the spelling axis is now exhausted at 20+ falsifications across
 * two waves).  NOT a floor.
 *
 * The W53-A12 handoff recipe applied in full:
 * `double` params + a register-resident `union double_long` (the 05B soft-float PAIR law,
 * mechanism in GTDF2.c) TOGETHER with the oracle re-derivation.
 *
 * WHAT THE ORACLE DICTATES (read off asm/nonmatchings/main/__divdf3.s, frame 0x68):
 *  - entry `addu $t0,$a0; addu $t1,$a1; addu $t2,$a2; addu $t3,$a3` = BOTH DFmode pairs
 *    lose their arg-reg preference and land in $t0:$t1 / $t2:$t3.  Four int params can
 *    never emit this (05B).
 *  - the RETURN is a DFmode pseudo too: every arm writes $s2 (lo) / $s3 (hi) -- an
 *    EVEN-ALIGNED callee-saved pair -- and the epilogue is `addu v0,s2; addu v1,s3`.
 *    That is `double_long ur; ...; return ur.d;`, not two independent ints.
 *  - frame local map (address order == declaration order):
 *      0x18 q[2] | 0x20 bit[2] | 0x28 t[2] | 0x30 buf[4] | 0x40 sub[2]
 *    The dividend AND the divisor live in ONE `int buf[4]` (0x30..0x3C): the loop RELOADS
 *    all four words at every _comp_mant, which scalar divisor locals can never produce
 *    (same one-array lever as __truncdfsf2's buf[4]).
 *  - the `+1` / `1<<n` addend is a real two-word array `t[2]` at 0x28 (`sw zero,0x2C;
 *    sw sN,0x28` then `lw a3,0x28`), NOT the literals `1,0`.
 *  - ONE in-place exponent (`$s1`: `addiu s1,s1,-1` / `addiu s1,s1,1` / `addu s1,zero,zero`)
 *    and ONE in-place shift count (`$s0`), not v4/v7/v8 triples.
 *  - `q[1] &= 0xFFEFFFFF` is stored BACK (`sw v1,0x1C(sp)`), not parked in a temp.
 *  - branch polarity: the overflow test is `if (exp >= 2047) {err} else {normal}`
 *    (`slti v0,s1,0x7FF; bnez v0,<normal>` = the err block is the FALL-THROUGH).
 *  - the loop shift counts are LITERAL 1s (LICM hoists them into $s0 at the preheader);
 *    only the tail count is a variable.
 */
typedef union {
    double d;
    struct { unsigned int lo; int hi; } w;
} double_long;

double __divdf3(double a, double b)   /* @0x800F5DD4 */
{
    double_long ua, ub, ur;
    int q[2];      /* 0x18 -- quotient            */
    int bit[2];    /* 0x20 -- current quotient bit */
    int t[2];      /* 0x28 -- rounding addend      */
    int buf[4];    /* 0x30 -- [0..1] dividend, [2..3] divisor */
    int sub[2];    /* 0x40 -- _mainasu result      */
    int *dp;
    int exp, n;
    int *qp;
    unsigned int *p2;   /* W76-A14: arm2's named tail-call pointer (order fence) */
    int sign;

    /* W62-A8 (2026-08-15) -- RE-GATED at 22.  The div-by-zero arm's named angle ("stop cse
     * carrying the mask constant into the arm -- an opacity device, not a barrier") is now
     * TRIED IN BOTH POLARITIES and FALSIFIED (whole-TU, scratchpad/w62a8/div_v{1,2}.json):
     *   13C INVERTED-DEFAULT `ur.w.hi = -1; if (sign == 0) ur.w.hi = 0x7FFFFFFF;` ..... 70
     *   same with `ur.w.lo = -1` first / both stores then the override ............ 70 / 70
     *   a named `int h` carrying the select, stored once ............................. 23
     *   a named `int nan = 0x7FFFFFFF` + 1 / 2 / 3 identity fences ............. 34 / 33 / 33
     *   a named `int neg = -1` + identity fence, used for BOTH hi and lo ............. 26
     * The 70s are the tell: ANY spelling that writes `ur.w.hi` twice re-materialises the
     * whole union head; the arm is a single-store select and must stay one.  So the residual
     * (a) is NOT reachable by naming or laundering the constant on either side -- retail's
     * `li $s3,-1` in the `bnez` delay slot + `lui;ori` on the fall-through is a jump/reorg
     * polarity that our cse-shared mask forbids.  NEXT: the mask itself is shared with the
     * ub-side guard `(ub.w.hi & 0x7FFFFFFF)`; the only untried device is one that keeps the
     * GUARD's mask in $t3 (it already is) while denying cse the value for the ARM -- i.e. a
     * per-arm constant that is not an allocno at all, which on this lane means TEXT_MOVES.
     * NOT a floor.
     *
     * 🏆 W71-A12 (2026-08-21) -- RE-GATED at 16 (ours 182 / oracle 184, 2 insns SHORT),
     * LANDED 16 -> 12 and the stream is now COUNT-EXACT 184/184.  ONE device, in the
     * `exp < 0` arm (see the void fence in the body):
     *
     *   🔑 THE CROSS-JUMP UN-MERGER, and the SCHED1 mechanism behind it (new law):
     *   the two arms of `if (exp >= 0) ... else ...` BOTH end with the same
     *   `_add_mant_d(qp, q[0], q[1], t[0], t[1])`.  Retail keeps TWO `jal`s (arm1 does
     *   `jal; [slot exp+=1]; j Ljoin; [slot addiu a0,sp,24]`); ours had ONE -- arm1
     *   `j`-ed straight into arm2's call, which is exactly the 2 missing instructions.
     *   WHY OURS MERGED AND RETAIL DID NOT: jump.c's cross_jump merges the longest
     *   common SUFFIX, and it runs (with JUMP_CROSS_JUMP) only in the post-reload
     *   jump2 -- i.e. AFTER sched1.  Retail's arm2 still had `exp = 0` sitting between
     *   its `jal` and the join at that point, so the suffixes differed by one insn and
     *   nothing merged.  OUR sched1 HOISTS `exp = 0` (a callee-saved `$s1` set with no
     *   dependence on the call) ABOVE the `jal`, which makes arm2's suffix start at the
     *   `jal` -- identical to arm1's -- and cross_jump then eats arm1's call.
     *   CURE = a zero-insn 06B VOID FENCE `__asm__ __volatile__("" : : "i"(0));`
     *   placed AFTER `exp = 0;` in the else arm.  It is a scheduling barrier, so
     *   `exp = 0` can no longer leave the post-call region, the two suffixes differ
     *   again, and arm1 gets its own `jal` back.  16 -> 12, 182 -> 184 insns.
     *   ⚠️ PLACEMENT IS THE WHOLE DIAL (all measured this wave, whole-fn gate):
     *     fence BETWEEN the call and `exp = 0`, `n += 1` left before the call .... 12 (184)
     *     fence AFTER `exp = 0`, `n += 1` moved after the fence ................... 12 (184)  <- LANDED
     *     fence AFTER `exp = 0`, `n += 1` left before the call .................... 12 (184)
     *     fence between call and `exp = 0`, `n += 1` after both ................... 15 (185)
     *     fence LAST (`exp = 0; n += 1; fence;`) .................................. 14 (184)
     *     `n += 1` moved after the call with NO fence ............................. 18 (182)
     *   The landed form additionally puts `n += 1` where retail has it (after the
     *   call, feeding the join's `sw $s0,0x10($sp)`), which is the ADDDF3-W61 law
     *   "reorg fills a call delay slot from EITHER side" applied here: with `n += 1`
     *   moved past the fence, reorg's forward scan finds `exp = 0` first and puts
     *   retail's `addu $s1,$zero,$zero` in the `jal` slot instead of our old
     *   `addiu $s0,$s0,1`.
     *   GENERAL FORM OF THE LAW (candidate catalog row): *ours is N insns SHORT and a
     *   `j` appears where retail has a `jal`* => cross_jump merged an arm's call; look
     *   for a post-call statement that sched1 hoisted above the call, and pin it with a
     *   void fence.  This is the INVERSE of the MULDF3-W55 finding (there the cure was
     *   to write a shared call INSIDE each arm); here the call is already per-arm and
     *   the merge happens later, in jump2.
     *
     * RESIDUAL (12, count EXACT 184/184) -- three rows, two classes:
     *   (a) the div-by-zero arm, 4 rows (unchanged): ours `lui $v0,0x7FFF` [shared with
     *       the guard] + `ori` in the `beqz` slot + `li $v0,-1` + `addu $s3,$v0,$zero`,
     *       retail `bnez` + `li $s3,-1` in the slot + a FRESH `lui $s3,0x7FFF; ori`.
     *       🔑 W71 EXPLANATION (this closes the W62 "only untried device" line): the
     *       0x7FFFFFFF here is cse-SHARED with the `(ub.w.hi & 0x7FFFFFFF)` guard mask,
     *       and an identity fence CANNOT break that -- a `"=r"(x) : "0"(x)` fence
     *       LAUNDERS a value, it does not RE-MATERIALIZE it (the "0" constraint ties the
     *       output to the input register, so cse forwards the guard's `lui` straight
     *       into the fence).  Independently re-derived and measured on ADDDF3's twin row
     *       this wave (see ADDDF3.c W71-A12); the MULDF3 `signmask` device only worked
     *       there because MULDF3's other sign test is spelled `acc[1] < 0` (`bgez`) and
     *       materializes no constant for cse to share.  NEW falsification here:
     *       `ur.w.hi = (sign == 0) ? 0x7FFFFFFF : -1;` (the branch-polarity flip that
     *       matches retail's `bnez`) = 13 at 185 insns -- gcc canonicalises the test
     *       back and adds an insn.  Live routes unchanged: a cse-table instrument read,
     *       or TEXT_MOVES.
     *   (b) two scheduling rows around the join's `addiu $a0,$sp,24`: arm1's `j` delay
     *       slot is a `nop` for us where retail target-steals the join's a0 setup, and
     *       in arm2 that same setup lands after `n += 1` instead of before it.  Both are
     *       reorg/sched2 position rows on ONE instruction -- a TEXT_MOVES candidate.
     *   NOT a floor.
     *
     * W72-A20 (2026-08-22) -- RE-GATED at 12 (count-exact 184/184, baseline confirmed).
     * NO landing.  Ten shapes measured, none < 12; recorded so nobody re-fights them.
     *
     * 📚 CORPUS (user directive, the fp-bit lineage dig -- decisive receipt in FIXDFSI.c):
     * Sony's LIBMATH doubles descend from FSF **`gcc-2.8.1/floatlib.c`**, NOT from
     * `config/fp-bit.c`.  THIS function has a direct corpus ancestor: floatlib's appended
     * Barrett-Richardson `__divdf3`, whose two-word mantissa comparator `__dcmp` IS
     * `_comp_mant` (same 1/-1/0 contract, same "compare hi words then lo words" body,
     * and floatlib ships the pair in one file exactly as DIVDF3.obj does).  Shape deltas
     * WORTH KNOWING, all already reflected here or measured below: floatlib clears the
     * divisor's sign bit before the zero test; sets `result.l.lower` FIRST and only then
     * selects `upper` with an `if/else` on `sign`; and drives the quotient with two
     * `while (mask)` loops (0x00200000 then 0x80000000) instead of our single do/while
     * over a `bit[2]` pair.  Sony replaced floatlib's +/-infinity payload with
     * 0x7FFFFFFF/-1 and factored the shift/add/negate helpers out.  Source:
     * C:\Temp\gcc-2.8.1-src\gcc281.tar.gz member gcc-2.8.1/floatlib.c (grep-confirmed
     * that none of the five Sony helper names occurs in floatlib.c, libgcc2.c, fp-bit.c
     * or C:\Temp\windows-gcc-psx).
     *
     * FALSIFIED THIS WAVE (whole-fn gate; scratchpad/W72_A20/div_*.txt).
     *   (a) THE ZERO-DIVIDE ARM, row (a) -- the floatlib STORE ORDER + if/else forms:
     *       `ur.w.lo = -1; ur.w.hi = -1; if (sign == 0) ur.w.hi = 0x7FFFFFFF;` ... 64 @184
     *       same with the two stores swapped ................................... 64 @184
     *       `ur.w.lo = -1; if (sign) ur.w.hi = -1; else ur.w.hi = 0x7FFFFFFF;` .. 67 @185
     *       `ur.w.lo = -1; ur.w.hi = sign ? -1 : 0x7FFFFFFF;` (order only) ...... 14 @184
     *       named `int h` default-then-override, `ur.w.hi = h;` .................. 13 @185
     *       named `h`, lo stored first ......................................... 17 @185
     *       named `h` + an identity fence on `h` before the store ............... 13 @185
     *       named `h` as a real `if/else` (both arms assign) .................... 12 @184
     *     ⇒ the W62 "any spelling that writes ur.w.hi twice re-materialises the whole
     *       union head" verdict REPRODUCES at this basin (64/67, not the old 70), and the
     *       named-carrier route now reaches 12-13 instead of 23 -- i.e. it improved with
     *       the basin but never beats the ternary.  🔑 WHAT THE 13-DIFF `h` FORM PROVES
     *       (read it before the next attempt): it lands retail's BRANCH POLARITY and its
     *       FRESH `lui/ori` materialization (`bnez $s4; li $v0,-1 [slot]; lui $v0,32767;
     *       ori`) -- the whole cse-sharing half of row (a) is SOLVED there.  What it
     *       cannot do is put the result straight into `ur.w.hi`'s register: `h` is a
     *       distinct pseudo, so it pays `addu $s3,$v0,$zero`, and the freed `lui` no
     *       longer feeds reorg's steal into the preceding `bnez t2` slot (a `nop`).  The
     *       remaining question is therefore ONE copy + ONE slot, i.e. the 13B/15B
     *       delete_noop_moves family aimed at `h`->`ur.w.hi`, NOT the constant any more.
     *   (b) THE JOIN ROWS, row (b) -- retail DUPLICATES `addiu $a0,$sp,24` (arm1's `j`
     *       delay slot + arm2 before `n += 1`), we emit it once after `n += 1`:
     *       per-arm `qp = q;` at each arm tail, `_add_mant_d(q,...)` .............. 65 @185
     *       09J duplicate-the-call: `_dbl_shift_us(...)` written in BOTH arms ..... 52 @186
     *       same + the 05C ref-fence duplicated into both arms ................... 53 @187
     *       W72-A20 POINTER LAUNDER on the tail call's first arg, at the join ..... 64 @184
     *       same launder placed at the END OF EACH ARM (per-arm `qq`) ............. 84 @186
     *     ⇒ the ADDDF3 "pointer-first double identity fence" device (which took that
     *       function 6 -> 2 this wave by making `addiu $a0,$sp,N` the first insn of a
     *       call block so reorg steals it) does NOT transfer here: the join is reached by
     *       two edges, so any asm at its head is a barrier that re-colors the whole tail.
     *   (c) 21E-5 constant-sharing breaker on the guard masks:
     *       identity fence on the **ua** guard's 0x7FFFFFFF .................... 18 @184
     *       identity fence on the **ub** guard's 0x7FFFFFFF .................... 56 @184
     *       the latter + the named-`h` arm ..................................... 56 @184
     *   (d) 21C-2 DImode two-word-copy audit (the brief's named check): NEGATIVE.  The
     *       stream is already count-exact 184/184 and every `lw`/`sw` pair here is call
     *       ARGUMENT setup (`lw $a1,0x18($sp); lw $a2,0x1C($sp)` = w0,w1 in a1/a2, an
     *       ODD-aligned pair) or the `t[2]`/`buf[4]` frame arrays -- there is no
     *       even-aligned lw/lw/sw/sw copy run anywhere in the oracle, so the law that
     *       sealed MULDF3's `_mul_mant_d` has no site in __divdf3.
     *
     * W74-A19 2026-08-23 -- RE-GATED at 12, COUNT-EXACT 184/184 (baseline confirmed).
     * NO landing.  Two assignments closed: (A) the floatlib `__divdf3`/`__dcmp` SOURCE
     * was mined DIRECTLY (not just described), and (B) row (a) was cross-checked against
     * the same-wave reload_cse law.
     *
     * (A) 📚 floatlib.c IS EXTRACTED AND READ (C:\Temp\gcc-2.8.1-src\extracted2\
     *     gcc-2.8.1\floatlib.c; `__dcmp` @666, `__divdf3` @689).  Its zero-divide arm is
     *         if (!x2.l.lower && !x2.l.upper) {
     *             result.l.lower = 0x0;
     *             if (sign) result.l.upper = 0xFFF00000;
     *             else      result.l.upper = 0x7FF00000;
     *             return result.d;                 <-- EARLY RETURN INSIDE THE ARM
     *         }
     *     -- i.e. LOWER first, an if/else on `sign` for UPPER, and its OWN `return`.  The
     *     early return is the one ingredient no prior wave had tried here (W62/W71/W72 all
     *     tested the store order and the if/else, never the exit).  MEASURED, whole-fn gate
     *     (scratchpad/W74_A19/div_v*.txt via scratchpad/W72_A20/a20_tmprobe.py):
     *       floatlib verbatim: `lo=-1; if(sign) hi=-1; else hi=0x7FFFFFFF; return ur.d;` 67 @185
     *       ternary + early return, hi then lo ..................................... 64 @184
     *       ternary + early return, lo then hi ..................................... 64 @184
     *       floatlib if/else WITHOUT the early return (control) .................... 67 @185
     *     ⇒ TWO independent readings, both new: the EARLY RETURN alone is worth +52 over
     *       the baseline ternary (64 vs 12) -- retail's arm demonstrably FALLS THROUGH to the
     *       single shared `return ur.d;`, so Sony restructured floatlib's multi-exit body into
     *       one exit; and the if/else-vs-ternary delta (+3, 185 vs 184 insns) reproduces the
     *       W62 "any spelling that writes ur.w.hi twice re-materialises the union head" bound
     *       from the exit axis as well.  ⇒ THE floatlib SHAPE LEAD FOR ROW (a) IS CLOSED --
     *       the corpus ancestor's union spelling and store order are NOT retail's.
     *     (Its quotient loops -- two `while (mask)` passes over 0x00200000 then 0x80000000 --
     *      are likewise NOT retail's: the oracle drives one do/while over the `bit[2]` pair
     *      through `_dbl_shift_us`, exactly as reconstructed here.  `__dcmp` == `_comp_mant`
     *      is re-confirmed line-for-line and is already transcribed verbatim below.)
     *
     * (B) 🔑 ROW (a) IS **NOT** THE reload_cse CLASS (checked, negative -- record it so the
     *     new law is not mis-applied here).  The same-wave ADDDF3.c receipt names
     *     `reload_cse_simplify_set` (gcc-2.8.1 reload1.c:8178) as the pass that turns a
     *     `(set hardreg CONSTANT)` into a copy from a live hard register, and shows it exists
     *     ONLY on the 2.7.2-970404 / 2.8.0 / 2.8.1 rungs.  THIS TU is wired `cc1_alt 2.7.2`,
     *     a rung WITHOUT reload_cse -- so our `addu $s3,$v0,$zero` cannot be that pass.  It is
     *     what the W71/W72 receipts already say: a pre-reload cse SHARE of the guard's
     *     `lui 0x7FFF` plus the funnel copy that local-alloc's `combine_regs` must refuse
     *     because `ur` is a GLOBAL allocno (local-alloc.c:1866).  ⇒ the W71 "live routes: a
     *     cse-table instrument read, or TEXT_MOVES" line stands for THIS function; do not
     *     import ADDDF3's reload_cse certificate here.
     * ANGLE UNCHANGED for row (a): the 13B/15B delete_noop_moves family aimed at the
     * `h`->`ur.w.hi` copy (the 13-diff named-`h` basin already carries retail's polarity and
     * its fresh `lui/ori`), NOT the constant and NOT the union store order.
     *
     * 🏆🏆 W75-A14 2026-08-23 -- **12 -> 6, count-exact 184/184.  ROW (a) IS SOLVED.**  It was
     * never a cse/constant/union-store question at all; three waves priced the wrong axis.
     *
     * 🔴 THE W62/W72 "ANY SPELLING THAT WRITES ur.w.hi TWICE RE-MATERIALISES THE WHOLE UNION
     * HEAD" VERDICT IS FALSE -- it is a two-line DIAGNOSIS ERROR, not a mechanism.  The
     * 64/70-diff readings for the 13C inverted-default form are a clean 3-WAY REGISTER
     * ROTATION and nothing else: sbs shows ours {ur = $s0:$s1, n = $s2, exp = $s3} against
     * retail {n = $s0, exp = $s1, ur = $s2:$s3}, with EVERY other word identical.  Nobody
     * ever ran sbs on the falsified variant -- the raw diff COUNT was taken as the verdict.
     * (Catalog 09K/21E-3 restated: judge a structural move on the sbs, never on the count.)
     *
     * 🔑 LANDING 1 -- THE SHAPE.  Retail's arm IS the 13C inverted default:
     *       ur.w.hi = -1;
     *       if (sign == 0) ur.w.hi = 0x7FFFFFFF;
     *       ur.w.lo = -1;
     *   giving retail's `bnez $s4` polarity, `li $s3,-1` in its delay slot (reorg backward-
     *   steals the default), the FRESH `lui $s3,0x7FFF; ori` on the fall-through, and
     *   `li $s2,-1` in the `j` slot.  No copy, no funnel: the ternary's `addu $s3,$v0,$zero`
     *   and its cse-shared `lui $v0,0x7FFF` are both gone.
     *
     * 🔑 LANDING 2 -- THE SEAT, PREDICTED THEN MEASURED (global.c allocno_compare).
     *   `ur` is ONE DFmode pseudo, and a `(set (subreg:SI (reg:DF)) ...)` is a PARTIAL write,
     *   so flow keeps the pair live from function entry (dump: reg 76, 19 refs / 159 insns /
     *   crosses 11 calls) -- that is why `ur` is callee-saved at all.  EACH `ur.w.X = ...`
     *   costs TWO refs (read-modify-write), so the extra store moves it 17 -> 19 and lifts
     *   its priority just past `n`'s, stealing $s0:$s1.
     *   🏆 THIS LANE'S PRIORITY FORMULA **HAS THE SIZE TERM** -- a correction to 12A/qty272.
     *   Measured on this dump (`scratchpad/w75/rtl/DIVDF3.i.greg`, cc1 = windows-gcc-psx
     *   gcc-2.7.2-psx, the wired rung):  pri = floor_log2(refs)*refs/live_length * SIZE,
     *   size in WORDS.  The printed `;; 11 regs to allocate: 74 (2) 75 (2) 76 (2) 79 130 127
     *   78 80 117 81 77` is reproduced 11/11 by the SIZE form and NOT by the size-free form
     *   (which would rank 79 and 130 ahead of 74/75/76).  qty272.py's `pri()` docstring
     *   claims the size-free rule for "the 272 lane"; that was validated on PsyQ CC1PSX --
     *   it does NOT hold for the windows-gcc-psx 2.7.2 rung, so re-derive per binary.
     *   (Also: qty272.parse_greg CRASHES on this dump -- the `;; N regs to allocate:` line
     *   prints a ` (2)` word-count suffix for multi-word allocnos that the regex does not
     *   accept.  One-line fix queued for the tool owner; the numbers above were read by hand.)
     *   PRICING: pri(76) = 4*19/159*2 = 0.956 vs pri(79 = `n`) = 3*8/28*1 = 0.857.  ONE extra
     *   reference on `n` gives 3*9/28 = 0.964 > 0.956 and flips the pair.  Delivered by adding
     *   a SECOND `"r"(n)` operand to the 05C ref-fence that was already there -- zero insns,
     *   no new asm, no new local.  find_free_reg then hands $s0 to `n`, $s2:$s3 to `ur` (the
     *   lowest FREE EVEN pair, 16 being taken) and $s1 to `exp` -- retail exactly.
     *   MEASURED: baseline (ternary) 12 | inverted default alone 64 @184 (the rotation) |
     *   + "r"(exp) x1/x2/x3 on the fence 64/64/64 (WRONG allocno -- `exp` is reg 78, priority
     *   0.248, nowhere near the boundary; recorded so the operand choice is not re-guessed) |
     *   + a SECOND "r"(n) **6** @184.  Two whole-arm rewrites also falsified here:
     *   split the result into two scalar `int rhi, rlo;` assembled once at the exit ... 29 @183
     *     (they cross NO calls, so they land caller-saved $v0/$v1 -- retail's $s2:$s3 pair is
     *      proof the result IS the partially-written DFmode union, not two ints).
     *
     * RESIDUAL (6) -- TWO reorg TARGET-STEAL rows, both the SAME mechanism, both !own_thread:
     *   (i) idx 27: retail steals `lui $v0,0x7FFF` (the ua-guard mask's first half, which
     *       also stays at its home idx 34) into the `bnez $t2,$L2` delay slot and re-points
     *       that branch one insn later; ours emits `nop`.  $L2 has TWO predecessors, so this
     *       is fill_slots_from_thread's `! own_thread` COPY path (reorg.c:3635
     *       `temp = own_thread ? trial : copy_rtx (trial)`), gated by
     *       `! insn_sets_resource_p (trial, &opposite_needed, 1)` (:3574) where
     *       opposite_needed = mark_target_live_regs of the FALL-THROUGH (arm 1).  Prediction
     *       is fine (mostly_true_jump returns 1 for NE, reorg.c:3961), so the refusal is a
     *       liveness question on $v0 at arm 1's head -- and mark_target_live_regs is
     *       CFG-STALE (13E).  NEXT ANGLE (named, not run): dump -dd/-dR on this rung and read
     *       which resource makes `opposite_needed` claim $v0; the source lever, if any, is to
     *       kill a $v0 use at the head of arm 1.  A fence CANNOT help (13B: a fence blocks
     *       theft, never supplies it).  Mechanism route: this needs a COPY, not a move, so
     *       PER_FN_TEXT_MOVES cannot express it (the line is still needed at $L2) -- it is
     *       the 11B "TEXT_MOVES COPY variant" ask, or PER_FN_BRANCH_RETARGET + a copy row.
     *  (ii) idx 133/145: the same !own_thread copy at the exp>=0 arm's `j`, where retail puts
     *       the join's `addiu $a0,$sp,24` in the `j` slot AND keeps a copy that arm 2 falls
     *       through (retail arm2 order: jal / [slot exp=0] / addiu a0,sp,24 / addiu s0,s0,1).
     *       Ours emits it ONCE, after `n += 1`.  Same COPY-not-MOVE property.  W72's four
     *       duplicate-the-call / per-arm-pointer / launder spellings (52-84) were re-read but
     *       NOT re-run at this basin -- they were all priced when row (a) still cost 6 insns,
     *       so 04Z says re-price them before trusting those numbers.
     *   NOT a floor.
     *
     * 🏆 W76-A14 2026-08-23 -- **6 -> 2, count-exact 184/184.  ROW (ii) IS SOLVED** (both the
     * `j`-slot nop @133 and the @145/146 [n+=1 | addiu a0,sp,24] order swap).  Three landings,
     * all zero-insn, see the in-body comments: (1) the 05C fence MOVED out of the join head
     * (it was the first insn at arm1's `j` target; reorg stop_search_p fires at ANY asm and
     * walled the thread scan -- fence position alone: 6 -> 4); (2) the tail _dbl_shift_us
     * DUPLICATED per arm + a DEAD `qp = 0;` cse-kill after each arm's _add_mant_d (without the
     * kill, cse folds the in-arm &q into qp -> cross-call value -> callee-saved home, s-band
     * rotation, 48; with it the duplicated calls cross_jump-merge exactly at retail's
     * `sw s0,16` label); (3) arm2's tail pointer NAMED (p2) + an output-less order fence
     * before `n += 1` (the sched2 critical-path tie is otherwise unwinnable: increment chain
     * depth 4 via the /s-load false dep, a0-setup depth 2).  ⚠️ ORACLE FACT that unlocked it:
     * .L800F6020 sits at `sw s0,0x10`, AFTER `addiu a0,sp,0x18` -- retail's a0-setup was
     * PER-ARM, not a join insn; W75's "!own_thread COPY" reading of row (ii) was wrong.
     * Falsified at this basin: per-arm `p=(uint*)q` w/o kill 86 @186 | dup w/o kill 48 @186 |
     * `n+1` as 5th arg 65 @185 | `(n+=1)` embedded 4 (inert) | non-/s cast q loads 4 (inert) |
     * 05C before n+=1 4 (inert) | W71 fence REMOVED at this basin 11 @183 (still needed).
     *
     * RESIDUAL (2) = row (i) @27 ONLY, now a CERTIFIED RUNG-IDENTITY row: ours `nop` in the
     * `bnez t2,$L2` slot where retail copy-steals `lui $v0,0x7FFF` ($L2's head) and re-points.
     * MECHANISM (gcc-2.8.1 source read + measured 2.7.2-vs-2.8.0 delta): the steal is gated by
     * `! insn_sets_resource_p (trial, &opposite_needed, 1)` (reorg.c:3574), opposite_needed =
     * mark_target_live_regs(fall-through).  For our fall-through (arm 1, inside block 0 -- no
     * BARRIER+label between fn start and it, find_basic_block returns 0) the block scan marks
     * $v0 live at its prologue SETs and its REG_DEAD (insn 33, `xor s4`) only enters
     * pending_dead_regs, which is flushed ONLY at a CODE_LABEL (reorg.c:2860-2905) -- none
     * exists there, so $v0 stays claimed.  gcc-2.8's find_dead_or_set_registers (reorg.c:2479)
     * then FOLLOWS BOTH ARMS of the conditional at the target and discovers $v0 set-before-use
     * (dead) -- 2.7.2's inline forward scan stops at the first conditional jump and never
     * recovers the death.  MEASURED: on the 2.8.0/2.8.1/970404 rungs the @27 row VANISHES
     * (their reorg fills the slot) but the allocator/cse deltas cost more elsewhere
     * (V13-shape ladder: 2.7.2=2 | 970404=6 | 2.8.0=6 | 2.8.1=6 | 2.6.3=5 @183).  No source
     * lever exists on this rung: the claim is fed by the prologue's unavoidable $v0 sets
     * (identical in retail), not by any arm-1 $v0 use -- W75's "kill a $v0 use at arm 1's
     * head" angle is closed (there is none; the pessimism is structural).  The vendor binary's
     * reorg is 2.8-lineage on this axis while its allocator prices like our 2.7.2 rung
     * (the W75 size-term proof) -- a mixed identity none of our 8 rungs reproduces whole.
     * Routes left: a rung with 2.7.2 allocator + 2.8 reorg (does not exist on disk), or an
     * annotated floor receipt.  Under the no-post-compile-rewrite policy this row is DONE. */
    ua.d = a;
    ub.d = b;
    exp = ((ua.w.hi >> 20) & 0x7FF) - ((ub.w.hi >> 20) & 0x7FF) + 1022;
    sign = (ua.w.hi & 0x80000000) ^ (ub.w.hi & 0x80000000);
    if ((ub.w.hi & 0x7FFFFFFF) == 0 && ub.w.lo == 0) {
        /* W75-A14: the 13C INVERTED DEFAULT, not a ternary -- retail's `bnez $s4` with
         * `li $s3,-1` backward-stolen into its delay slot and a FRESH `lui/ori` on the
         * fall-through.  Costs `ur` two extra refs (a subreg store to a DFmode pseudo is
         * a read-modify-write); the seat that buys back is dialed at the `n` fence below.
         * The W62/W72 "writes ur.w.hi twice = 64/70 diffs" verdict was a mis-read of that
         * seat rotation -- see the receipt. */
        ur.w.hi = -1;
        if (sign == 0) ur.w.hi = 0x7FFFFFFF;
        ur.w.lo = -1;
    } else if ((ua.w.hi & 0x7FFFFFFF) == 0 && ua.w.lo == 0) {
        ur.w.hi = sign;
        ur.w.lo = 0;
    } else {
        {
            buf[1] = (ua.w.hi & 0xFFFFF) | 0x100000;
            buf[0] = ua.w.lo;
            buf[3] = (ub.w.hi & 0xFFFFF) | 0x100000;
            buf[2] = ub.w.lo;
            if (_comp_mant(buf[0], buf[1], buf[2], buf[3]) < 0) {
                _dbl_shift((unsigned int *)buf, 0, buf[0], buf[1], 1);
                exp -= 1;
            }
            dp = buf;
            bit[1] = 0x200000;
            bit[0] = 0;
            q[0] = 0;
            q[1] = 0;
            do {
                if (_comp_mant(buf[0], buf[1], buf[2], buf[3]) >= 0) {
                    q[1] |= bit[1];
                    q[0] |= bit[0];
                    _mainasu(sub, buf[2], buf[3]);
                    _add_mant_d(dp, buf[0], buf[1], sub[0], sub[1]);
                }
                _dbl_shift((unsigned int *)buf, 0, buf[0], buf[1], 1);
                _dbl_shift_us((unsigned int *)bit, 1, bit[0], bit[1], 1);
            } while (bit[1] || bit[0]);
            qp = q;
            if (exp >= 0) {
                n = 1;
                t[1] = 0;
                t[0] = n;
                /* w60-a5: the exponent update sits BEFORE the call in retail --
                 * reorg's backward scan steals it into the jal's delay slot
                 * (`addiu $s1,$s1,1` / `addu $s1,$zero,$zero`).  After the call
                 * it is unreachable to reorg and the a0 arg-setup gets stolen
                 * instead.  27 -> 25. */
                exp += 1;
                _add_mant_d(qp, q[0], q[1], t[0], t[1]);
                /* W76-A14 (2026-08-23): 6 -> 2.  The tail _dbl_shift_us is
                 * DUPLICATED into both arms (retail's true shape -- the oracle's
                 * join label .L800F6020 sits at `sw s0,0x10(sp)`, AFTER the
                 * per-arm `addiu a0,sp,0x18`, so each arm owned its own tail-call
                 * setup and cross_jump merged only from the sw onward; arm1's `j`
                 * then backward-steals ITS OWN a0-setup into the delay slot).
                 * `qp = 0;` after each arm call is a DEAD SET (flow deletes it,
                 * zero insns) whose one job is to INVALIDATE qp's cse quantity:
                 * without it cse folds the in-arm `&q` back into qp, the address
                 * becomes a cross-call value, and the whole s-band rotates into a
                 * callee-saved home (measured 48/86 diffs).  Measured ladder:
                 * fence-move alone 4 | +dup naive 48 | +dup+kill 4 | +p2+order
                 * fence (else arm) 2.  See the else arm + scratchpad/w76. */
                qp = 0;
                _dbl_shift_us((unsigned int *)q, 1, q[0], q[1], n);
            } else {
                n = -exp;
                t[1] = 0;
                t[0] = 1 << n;
                _add_mant_d(qp, q[0], q[1], t[0], t[1]);
                qp = 0;   /* W76-A14 dead cse-kill -- see the arm above */
                exp = 0;
                /* W71-A12 CROSS-JUMP UN-MERGER -- DO NOT DELETE, DO NOT MOVE.
                 * Zero insns.  Without it sched1 hoists `exp = 0` above the jal,
                 * which makes this arm's instruction SUFFIX identical to the
                 * `exp >= 0` arm's, and jump2's cross_jump then deletes THAT arm's
                 * own `jal _add_mant_d` (ours 182 vs retail 184).  The barrier pins
                 * `exp = 0` after the call, the suffixes differ, both arms keep
                 * their call -- and reorg then puts `exp = 0` in the jal's delay
                 * slot exactly like retail.  Placement table in the receipt above.
                 * (W76-A14: still required at the 2-diff basin -- removing it
                 * re-merges the arms, 11 @183.) */
                __asm__ __volatile__("" : : "i"(0));
                /* W76-A14 ORDER FENCE: retail's arm2 tail is [addiu a0,sp,24;
                 * addiu s0,s0,1] -- the a0 setup ABOVE the increment.  Naming the
                 * tail pointer (p2) and reading it through an output-less
                 * (volatile) fence BEFORE `n += 1` forces the a0 materialization
                 * above the fence while the increment cannot hoist across it --
                 * zero insns, the sched2 critical-path tie (increment chain depth
                 * 4 via sw s0,16 vs a0-setup depth 2) is otherwise unwinnable.
                 * The 05C fence AFTER `n += 1` then differs the two arms' suffixes
                 * at the right spot, so cross_jump merges exactly at `sw s0,16`
                 * like retail. */
                p2 = (unsigned int *)q;
                __asm__ __volatile__("" : : "r"(p2));
                n += 1;
                /* 05C ref-fence.  TWO `n` operands, NOT one -- the second is the W75-A14
                 * seat dial: it takes `n`'s REG_N_REFS 8 -> 9, whose global.c priority
                 * floor_log2(9)*9/28 = 0.964 just clears the DFmode `ur` allocno's
                 * floor_log2(19)*19/159*2 = 0.956, so `n` is served first and takes $s0,
                 * leaving retail's $s2:$s3 even pair for `ur` and $s1 for `exp`.
                 * Dropping either operand costs 58 diffs.  Zero insns.
                 * (W76-A14: moved from the join into this arm -- at the join head
                 * it was an asm at the `j` target, and reorg's stop_search_p
                 * fires at ANY asm, walling the thread scan that fills arm1's
                 * `j` delay slot with the a0 setup: the fence position alone was
                 * worth 2 diffs.  Seat effect is position-independent.) */
                __asm__("" : : "r"(n), "r"(n));
                _dbl_shift_us(p2, 1, q[0], q[1], n);
            }
            q[1] &= 0xFFEFFFFF;
            if (exp >= 2047) {
                _err_math(34, 15);
                ur.w.hi = sign ? 0xFFF00000 : 0x7FF00000;
                ur.w.lo = 0;
            } else {
                ur.w.hi = sign | (exp << 20) | q[1];
                ur.w.lo = q[0];
            }
        }
    }
    return ur.d;
}

#if defined(__mips__)
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */

    "\t.globl _comp_mant\n"        /* @0x800F60B4 : int _comp_mant(uint a0,a1,a2,a3) -- compare [a1:a0] vs [a3:a2] as u64 -> 1/-1/0 */
    "_comp_mant:\n"
    "\tsltu\t$v0,$a3,$a1\n"
    "\tsw\t$a0,0($sp)\n"
    "\tsw\t$a1,4($sp)\n"
    "\tsw\t$a2,8($sp)\n"
    "\tbnez\t$v0,.L800F60F8\n"
    "\t sw\t$a3,12($sp)\n"
    "\tsltu\t$v0,$a1,$a3\n"
    "\tbnez\t$v0,.L800F60FC\n"
    "\t addiu\t$v0,$zero,-1\n"
    "\tsltu\t$v0,$a2,$a0\n"
    "\tbnez\t$v0,.L800F60FC\n"
    "\t addiu\t$v0,$zero,1\n"
    "\tsltu\t$v1,$a0,$a2\n"
    "\tbnez\t$v1,.L800F60FC\n"
    "\t addiu\t$v0,$zero,-1\n"
    "\tj\t.L800F60FC\n"
    "\t addu\t$v0,$zero,$zero\n"
    ".L800F60F8:\n"
    "\taddiu\t$v0,$zero,1\n"
    ".L800F60FC:\n"
    "\tjr\t$ra\n"
    "\t nop\n"
    "\t.set pop\n"
);
#else
/* Direct-return cascade (lever 3.12#8): each return materializes $v0 in the branch
 * delay slot; staging through a `result` temp would pin $t0+move instead. */
int _comp_mant(unsigned int a1, unsigned int a2, unsigned int a3, unsigned int a4)
{
    if (a4 < a2) return 1;
    if (a2 < a4) return -1;
    if (a3 < a1) return 1;
    if (a1 < a3) return -1;
    return 0;
}
#endif
