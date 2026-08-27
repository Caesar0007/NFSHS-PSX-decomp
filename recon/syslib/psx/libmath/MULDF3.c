/* syslib/psx/libmath/MULDF3.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj MULDF3.obj ; libmath.lib.  __muldf3 @0x800F62E4 (788 B) + _mul_mant_d @0x800F65F8 (236 B) --
 *   IEEE-754 double multiply.  53x53 mantissa product built from 21-bit limbs via _mul_mant_d/_add_mant_d,
 *   round-to-nearest.  IDA verbatim; 64-bit working values held as int[2] pairs ([0]=lo,[1]=hi); helper
 *   out-pointers write both words.  Overflow -> _err_math(34,13).
 */
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
unsigned int *_dbl_shift_us(unsigned int *out, int dir, unsigned int w0, int w1, int count);
typedef struct {
    unsigned int lo;
    int hi;
} mant_pair;
int          *_add_mant_d(int *out, unsigned int a2, int a3, unsigned int a4, int a5);
int          *_add_mant_pair(int *out, unsigned int a2, int a3, mant_pair addend)
              __asm__("_add_mant_d");
int           _err_math(int errnum, int code);

/* fwd decl: retail VA order puts __muldf3 (0x800F62E4) before _mul_mant_d (0x800F65F8) */
int *_mul_mant_d(int *out, unsigned int x, unsigned int y);

/* MATCH (W55-A4): __muldf3 326 -> 22 diffs, ours 195 / oracle 197.
 * Lane UNWIRED (was {"cc1_alt": "2.6.3"}).  04Z re-ladder on the landed basin,
 * whole-TU totals: DEFAULT (CC1PSX+maspsx) = 95+22 = 117 * cc1_alt 2.8.0/2.8.1
 * byte-identical to default * cc1_272/2.7.2 = 93+154 * 2.6.3 (old wiring) =
 * 84+154 * 2.91.66 = 106+168 * 2.95.2 = 102+196.  Default wins the TU by 121.
 *
 * LANDINGS (each gated): 326 -> 158 the 05B `double` params + `double_long`
 * union + the whole oracle re-derivation below; 158 -> 153 the final
 * `_dbl_shift_us` written INSIDE each of the three arms (retail cross-jumps
 * only the shared `jal`, keeping three copies of the arg setup -- a single
 * post-join call merges them and loses 5 insns); 153 -> 22 a 05C REF-FENCE
 * `__asm__("" : : "r"(exp), "r"(sign))` right after `exp = e - 1022`.
 * The fence's OPERAND SET is the whole dial (measured on 2.8.0):
 *   none=189 * "r"(e)=98 * "r"(sign)=42 * "r"(e),"r"(sign)=39 *
 *   "r"(exp),"r"(sign)=22 * adding a third operand=99.
 * Retail parks `sign` in $fp and `exp` in $s7 and SPILLS the exponent SUM to
 * 0x50; every under-dialed fence set gives the mirror (e in a reg, exp or sign
 * spilled).  Falsified on the way: fence at the top of the fn (189), a doubled
 * e-fence (98), no_schedule_insns / _2 / both / no_strength_reduce /
 * no_delayed_branch (151/150/134/145/184), and 6 decl/assignment orders for
 * the tp/up pointer pair.
 *
 * RESIDUAL (22, ours 2 insns short):
 *  (a) VALUE-RELOAD class (6): retail re-LOADS an array element it just stored
 *      (`lw a2,0x28(sp)` / `lw a3,0x20(sp)`), our cse forwards the live reg
 *      (`addu a2,t0,zero`).  Identical class to DIVDF3's t[0] and TRUDFSF2's
 *      residual.  On the 2.6.x/2.7.2 rungs cc1 DOES emit the reload -- it is a
 *      cse-of-stack-slot version behaviour -- but those rungs cost 130+ diffs
 *      elsewhere.  NAMED ANGLE: an opacity device that stops cse recording the
 *      store WITHOUT deleting it (a volatile view on the READ, 05E) -- not
 *      applied here because a whole-fn measurement of the volatile family was
 *      out of this wave's budget.
 *  (b) inner sign test (3): retail `lui s0,0x8000; and; beqz`, ours folds
 *      `(acc[1] & 0x80000000)` to `bgez`.  FALSIFIED: a shared `signbit`
 *      variable (31), `== 0x80000000` (22), `(unsigned)x >= 0x80000000u` (22),
 *      `((unsigned)x & 0x80000000u) != 0u` (22).
 *  (c) arg4-load ORDER at the two loop `_add_mant_d` sites (4) and two
 *      reorg delay-slot picks -- same classes as DIVDF3's residual.
 *
 * 🏆 MATCH (w59-a8): 22 -> 12 AND the count becomes EXACT 197/197 (was 195/197).
 * Both open items (a) and (b) above are now CLOSED, each by one device:
 *  (a) the 05E VOLATILE VIEW ON THE READ, applied where the diff named it:
 *      `*(volatile int *)&am[0]` / `&am[1]` at the first `_dbl_shift_us` (retail
 *      `lw a2,0x28(sp)`/`lw a3,0x2C(sp)`, ours `addu a2,t0,zero`) -- 22 -> 18 --
 *      and `*(volatile int *)&add[0]` at BOTH arm `_add_mant_d` calls (converts
 *      the `addu a3,v0,zero` into retail's `lw a3,0x20(sp)`; diff-neutral on its
 *      own but it is the right SHAPE and it is what lets (b) land cleanly).
 *  (b) the 05H/07A THREE-IDENTITY-FENCE BARE-CONSTANT step applied to the sign
 *      MASK (not to the sign BIT -- that is the "shared signbit variable (31)"
 *      form the W55 receipt falsified).  `unsigned int signmask` ASSIGNED (never
 *      decl-with-init) + three `__asm__("" : "=r"(signmask) : "0"(signmask))`
 *      identity fences, then `if (((unsigned)acc[1] & signmask) != 0u)`.  That
 *      reproduces retail's `lui $s0,0x8000; and $v0,$v0,$s0; beqz` EXACTLY,
 *      including the callee-saved $s0 home -- and it supplies the two
 *      instructions we were short, so the count is now exact.
 *      PLACEMENT IS THE WHOLE DIAL (all measured on this basin, count-exact):
 *        at the `if (acc[1] & 0x80000000)` test  = 18 (mask lands in $v1)
 *        hoisted above `if (acc[1] < 0)`         = 16 (mask reaches $s0, wrong position)
 *        at the ELSE-ARM HEAD, before `add[1]=0` = 12  <- landed
 *      i.e. same law as 05H's "void fence at a single-insn arm's HEAD".
 * RESIDUAL (12, count EXACT 197/197): four `lw $a3,0x38(sp)` / `lw $a3,0x20(sp)`
 * outgoing-arg EMISSION-ORDER swaps (retail loads $a3 before $a1/$a2 at every
 * `_add_mant_d` site; we emit a1,a2,a3 in source order) and one `li $a1,1` vs
 * `lw $t3,0x50(sp)` reorg pick.  The arg-order class is shared with _mul_mant_d
 * above and with DIVDF3 -- one lever would close all of them; a hoist of the 4th
 * argument into a temp is the obvious next probe (untried, would cost a move
 * unless coalesced).
 *
 * W61-A9 (2026-08-15) -- THE 4th-ARG HOIST IS NOW TRIED, AND FALSIFIED, IN ALL
 * THREE TUs.  Re-gated __muldf3 12 / _mul_mant_d 14, both count-exact.  The
 * arg-emission-order class (11B) is measured at NINE call sites across
 * MULDF3 (4 + 2), DIVDF3 (3) and ADDDF3 (2); retail's order at every one of
 * them is `stack-arg store, arg4, arg2, arg3` while ours is
 * `stack-arg store, arg2, arg3, arg4`, i.e. purely WHERE the arg4 chain is
 * emitted.  FALSIFIED (each whole-TU gated; DIVDF3 numbers in DIVDF3.c):
 *   named temp for arg4 (`t0 = t[0]` before the call) -- MULDF3 no change,
 *   DIVDF3 30 then 22-inert, ADDDF3 not applicable * named temps for arg2+arg3
 *   (DIVDF3 76) * a `volatile` 4th argument -- ALREADY IN THIS FILE at the two
 *   `add[0]` sites and the order is STILL ours, so TREE_SIDE_EFFECTS on the arg
 *   does NOT move it into the pre-store pass * swapping the signedness of the
 *   `_add_mant_d` prototype's a2/a4 (DIVDF3 22, inert) * the 8-rung ladder
 *   (this TU: no rung beats the default, w60-a5 table below).
 * ==> the emission position is decided inside expand_call, not by the argument
 * EXPRESSION, so no C spelling of the argument reaches it.  NAMED NEXT ANGLE
 * (single lever, ~18 diffs across the three TUs, worth an instrument run):
 * read calls.c's two arg-store loops on the 2.8 and 2.7.2 cc1s with -dr and
 * find what puts arg4 in the FIRST loop -- most likely `must_preallocate` /
 * `pass_on_stack` interaction with the 5th (stack) argument, which every one of
 * these calls has and which is the one structural feature all nine sites share.
 * Alternatively PER_FN_TEXT_MOVES: each site is a one-line `take`/`after`
 * relocation of a single `lw $a3,N(sp)`, mechanically identical nine times.
 * NOT a floor.
 *
 * W80 source-only update: 12 -> 8 at exact 197/197 by moving the else-arm
 * `exp = e - 1023` assignment after its `_dbl_shift_us(..., 10)` call.  The
 * assignment is semantically independent of that call; sched2 still hoists
 * the exponent calculation, but now stages the second `li $a1,1` before the
 * call-count setup and sinks `lw $t3,0x50($sp)` to the retail position.  This
 * removes the four tail scheduling diffs without changing allocation or any
 * of the four remaining `$a3` load-order pairs.  `_mul_mant_d` remains 6.
 *
 * W80 source-only seal: 8 -> PASS 197/197.  GCC 2.8.1 calls.c handles a
 * two-word final struct argument as a partial register argument: its low word
 * occupies $a3 and its high word the outgoing stack slot, in the separate
 * partial-argument phase before the ordinary $a1/$a2 loads.  `_add_mant_pair`
 * is a source-level ABI view of the real `_add_mant_d` symbol using that
 * natural pair shape.  At the two rounding calls only, an empty `+m(add[0])`
 * dependency prevents CSE forwarding the just-stored low word without
 * invalidating add[1]; the result is retail's early fresh `lw $a3` with zero
 * emitted fence instructions.  A volatile whole-pair view regressed to 12 at
 * 199/197, and whole-pair `+m` regressed to 8 at 201/197.  The scalar helper
 * body calls retain the ordinary five-word declaration, preserving its 6-diff
 * basin independently.  Post-landing 04Z ladder: 2.8.0 PASS+6 (current/best
 * whole TU), 2.8.1 4+6, 970404 131+6, 2.91.66 149+74, 2.95.2 164+70;
 * 2.6.0/2.6.3/2.7.2 reject the modern `+` asm constraint.
 *
 * W61-A9 tail probes for _mul_mant_d (all whole-TU gated,
 * scratchpad/w61a9/mul_v1.json + mul_v2.json), baseline 14, none landed:
 *   opacity fence on `out` after the stores 24 * before the stores 28 *
 *   read-only fence on `out` after the stores 24 * an `shp` pointer local for
 *   both `_add_mant_d` out-args 37 * `out[1]` stored before `out[0]` 14 *
 *   `sh[1] +=` written as a volatile store 14 * volatile on both sides 14 *
 *   `lo` read non-volatile 14 * BOTH reads non-volatile 21 * no named lo/hi
 *   temps (direct volatile reads into `out[]`) 16 * `hi` read before `lo` 14.
 * ==> the tail residual (retail stores through `$s3` and materializes the
 * return copy LAST; ours coalesces `out` into `$v0` and stores through it) is
 * NOT fence- or order-reachable in this basin.
 *
 * Oracle tells specific to __muldf3 (frame 0x80):
 *  - entry copies ONLY `a` (`addu $t0,$a0; addu $t1,$a1`) -- `b` keeps its
 *    $a2:$a3 preference.  That is exactly the __gtdf2 asymmetry (GTDF2.c).
 *  - the two zero exits are ONE `||` condition, not two ifs: the oracle's
 *    `bnez v0,<b-test>` / `beqz t0,<zero>` / `bnez v0,<main>` / `bnez a2,<main>`
 *    chain with the zero block as the FALL-THROUGH is the `&&`-inside-`||`
 *    short-circuit layout.
 *  - frame local map == declaration order:
 *      0x18 acc[2] | 0x20 add[2] | 0x28 am[2] | 0x30 bm[2] | 0x38 t[2] | 0x40 u[2]
 *    then the COMPILER's own slots: 0x48 = the spilled DFmode result union
 *    (`sw fp,0x4C; sw zero,0x48` ... `lw v0,0x48; lw v1,0x4C` = a spilled reg
 *    PAIR loaded into the return pair), 0x50 = the spilled exponent SUM.
 *  - `t` and `u` are reached through POINTER LOCALS ($s4/$s5: `addu $a0,$s4,$zero`
 *    at four sites) while `acc` is materialized fresh (`addiu $a0,$sp,0x18`).
 *  - the two acc-sign tests are spelled DIFFERENTLY: the outer is `acc[1] < 0`
 *    (`bgez`), the inner is `acc[1] & 0x80000000` (`and`+`beqz`).
 *  - the rounding addend is the two-word `add[2]` array (`sw zero,0x24;
 *    sw v0,0x20` then `lw a3,0x20`), never the literals.
 *  - store order is hi-then-lo per operand (am[1],am[0],bm[1],bm[0]).
 */
typedef union {
    double d;
    struct { unsigned int lo; int hi; } w;
} double_long;

double __muldf3(double a, double b)   /* @0x800F62E4 */
{
    double_long ua, ub, ur;
    int acc[2];   /* 0x18 */
    int add[2];   /* 0x20 */
    int am[2];    /* 0x28 */
    int bm[2];    /* 0x30 */
    int t[2];     /* 0x38 */
    int u[2];     /* 0x40 */
    int *tp, *up;
    int e, exp;
    unsigned int signmask;
    int sign;
    int ah, bh, al, bl;

    ua.d = a;
    ub.d = b;
    sign = (ua.w.hi & 0x80000000) ^ (ub.w.hi & 0x80000000);
    if (((ua.w.hi & 0x7FFFFFFF) == 0 && ua.w.lo == 0) ||
        ((ub.w.hi & 0x7FFFFFFF) == 0 && ub.w.lo == 0)) {
        ur.w.hi = sign;
        ur.w.lo = 0;
    } else {
        e = ((ua.w.hi >> 20) & 0x7FF) + ((ub.w.hi >> 20) & 0x7FF);
        exp = e - 1022;
        __asm__("" : : "r"(exp), "r"(sign));   /* 05C ref-fence: see receipt */
        tp = t;
        am[1] = (ua.w.hi & 0xFFFFF) | 0x100000;
        am[0] = ua.w.lo;
        bm[1] = (ub.w.hi & 0xFFFFF) | 0x100000;
        bm[0] = ub.w.lo;
        _dbl_shift_us((unsigned int *)tp, 1, *(volatile int *)&am[0],
                      *(volatile int *)&am[1], 21);
        ah = t[0];
        _dbl_shift_us((unsigned int *)tp, 1, bm[0], bm[1], 21);
        bh = t[0];
        al = am[0] & 0x1FFFFF;
        bl = bm[0] & 0x1FFFFF;
        _mul_mant_d(acc, ah, bh);
        up = u;
        _mul_mant_d(up, al, bh);
        _dbl_shift_us((unsigned int *)tp, 1, u[0], u[1], 21);
        _add_mant_pair(acc, acc[0], acc[1], *(mant_pair *)t);
        _mul_mant_d(up, bl, ah);
        _dbl_shift_us((unsigned int *)tp, 1, u[0], u[1], 21);
        _add_mant_pair(acc, acc[0], acc[1], *(mant_pair *)t);
        if (acc[1] < 0) {
            add[1] = 0;
            add[0] = 0x400;
            __asm__("" : "+m"(add[0]));
            _add_mant_pair(acc, acc[0], acc[1], *(mant_pair *)add);
            _dbl_shift_us((unsigned int *)acc, 1, acc[0], acc[1], 11);
        } else {
            signmask = 0x80000000u;
            __asm__("" : "=r"(signmask) : "0"(signmask));
            __asm__("" : "=r"(signmask) : "0"(signmask));
            __asm__("" : "=r"(signmask) : "0"(signmask));
            add[1] = 0;
            add[0] = 0x200;
            __asm__("" : "+m"(add[0]));
            _add_mant_pair(acc, acc[0], acc[1], *(mant_pair *)add);
            if (((unsigned int)acc[1] & signmask) != 0u) {
                _dbl_shift_us((unsigned int *)acc, 1, acc[0], acc[1], 11);
            } else {
                _dbl_shift_us((unsigned int *)acc, 1, acc[0], acc[1], 10);
                exp = e - 1023;
            }
        }
        acc[1] &= 0xFFEFFFFF;
        if (exp >= 2047) {
            _err_math(34, 13);
            ur.w.hi = sign ? 0xFFF00000 : 0x7FF00000;
            ur.w.lo = 0;
        } else {
            ur.w.hi = sign | (exp << 20) | acc[1];
            ur.w.lo = acc[0];
        }
    }
    return ur.d;
}

/* _mul_mant_d @0x800F65F8 : 32x32->64 unsigned multiply of (x,y) via 16-bit lanes -> out[0:1].
 * MATCH (W55-A4): 84 -> 18 diffs, count EXACT 59/59 (default lane; 14 on the 2.6.3/2.7.2 rungs,
 * but those cost __muldf3 +132 so the TU stays on the default).  REWRITE off the oracle -- the
 * old body was an IDA-verbatim `unsigned long long` transcription emitting 67 insns.
 * RESIDUAL (18): the VALUE-RELOAD class at both calls (`addu a3,v0,zero` vs retail's
 * `lw a3,0x20(sp)`, 4), the `sw ra` / `addiu a0,sp,0x18` scheduling picks (4), and the tail's
 * load/store interleave -- ours hoists `lw sh[0]` above the `mflo`, pushing the product into
 * $t1 and making the second store use $v0 as base.  FALSIFIED on the tail: a named product
 * temp (30), swapped store order (15 but 58 insns), `sh[1] = sh[1] + x*y` (18), block-local
 * lo/hi (23), and five fence placements (13-35, ALL +1 insn -- the void fence at the tail head
 * scores 13 but breaks count-exactness, so ctrl is kept).
 *
 * 🏆 MATCH (w59-a8): 18 -> 14, still count EXACT 59/59, via the 05E VALUE-RELOAD device the
 * W55-A4 receipt named but did not have budget for -- a VOLATILE VIEW ON THE READ:
 *   (1) `*(volatile int *)&add[0]` as the 4th argument of BOTH `_add_mant_d` calls stops cse
 *       forwarding the live register and restores retail's `lw $a3,0x20($sp)` (was
 *       `addu $a3,$v0,$zero`).  -2 diffs.  Only add[0] needs it: the 5th (stack) argument
 *       add[1] is register-forwarded in retail too (`sw $v1,0x10($sp)`), so do NOT volatile it.
 *   (2) the tail's two `out[]` sources read through `lo`/`hi` FUNCTION-SCOPE temps, each a
 *       volatile view (`lo = *(volatile int *)&sh[0]`).  -2 more.  Both halves are required:
 *       volatile-without-temps = 16 (the two loads stay split by the store, costing a `nop`),
 *       temps-without-volatile = 19 at 58 insns (cse forwards and the count breaks).
 *   FALSIFIED here (w59-a8): a `__asm__ __volatile__("" : : "i"(0))` void-tail barrier between
 *   `sh[1] += x*y` and the tail reads is INERT once the temps exist (14 either way) and costs a
 *   `nop` (11 diffs at 60 insns) when the temps are absent -- dropped, count-exactness kept.
 * RESIDUAL (14, count EXACT): the outgoing-arg EMISSION ORDER at both calls -- retail loads
 * $a3 (add[0]) BEFORE $a1/$a2 (sh[0]/sh[1]), we load a1,a2,a3 in source order -- plus the
 * `addiu $a0,$sp,0x18` scheduling pick and the tail's `move $v0,$s3` return copy, which our
 * allocator coalesces EARLY and then uses as the store base (retail keeps $s3 as the base and
 * copies to $v0 last).  Same arg-order class as __muldf3's residual below.
 * LADDER (04Z re-run on this basin, whole TU = _mul_mant_d + __muldf3):
 *   default/2.8.0/2.8.1 = 14+12 = 26 * 2.7.2 = 12+150 * 2.7.2-970404 = 14+150 *
 *   2.6.0 = 18+155 * 2.6.3 = 18+154 * 2.91.66 = 86+169 * 2.95.2 = 80+180.
 *   The DEFAULT lane still wins the TU by 136; UNWIRED stays correct.  NOTE for a future
 *   mechanism spec: 2.7.2 is _mul_mant_d's best rung (12) -- a PER-FN cc1-version splice would
 *   buy 2 more diffs, but PER_FN_CC1_VER_SPLICE_272 only exists in the 272/alt lane and this TU
 *   is on the default maspsx lane, so it is not reachable today.
 * Oracle tells (frame 0x40):
 *  - locals in address order: 0x18 sh[2] (the running 64-bit sum) | 0x20 add[2] (the shifted
 *    partial product handed to _add_mant_d, a REAL two-word array: `sw v1,0x24; sw v0,0x20`
 *    then `lw a3,0x20`), so the addend is NOT an expression at the call.
 *  - BOTH multiplicands are shifted IN PLACE ($s1 = x, `srl s1,s1,16`; $s0 = y, `srl s0,s0,16`
 *    in the first jal's delay slot).  Separate hi/lo locals would burn two more callee-saved
 *    regs; the in-place form is what puts xlo alone in $s2.
 *  - the low half `x & 0xFFFF` is a NAMED value live across both calls ($s2), the low half of
 *    y is an anonymous caller-saved temp ($v0) -- i.e. ylo is used twice in a row and dies. */
/* W62-A8 (2026-08-15) -- RE-GATED at 14 (59/59).  The tail's `move $v0,$s3` class was
 * re-attacked with the device that cracked MemCardExist_cb's identical-looking tails (the
 * 13B IDENTITY-LAUNDER ON THE RETURNED VALUE) and it does NOT transfer here.  FALSIFIED,
 * whole-TU gated (scratchpad/w62a8/mul_v1.json):
 *   `{ int *r = out; __asm__("" : "=r"(r) : "0"(r)); return r; }` after the stores .. 24
 *   read-only fence `__asm__("" : : "r"(out));` after the stores .................... 24
 *   block-local `int *o = out; o[0]=lo; o[1]=hi;` then `return out;` ................ 14 (inert)
 *   same + an opacity fence on `o` .................................................. 15
 * WHY IT DIFFERS FROM THE MEMCARD CASE (worth keeping): there the laundered pseudo was the
 * CALL RESULT competing with a hard `li $v0,K` return set; here BOTH candidates are the same
 * pointer, so laundering only adds a second copy.  13B's governing limit applies -- the copy
 * `addu $v0,$s3,$zero` already exists in our output, so this is a SCHEDULING/position row
 * (retail emits it after the two stores), not an allocation row.
 * Residual (14) otherwise unchanged: the 11B arg-emission order at both `_add_mant_d` sites
 * plus the `addiu $a0,$sp,0x18` pick.  TEXT_MOVES rows filed in
 * scratchpad/w62a8/text_moves_probe.json.  NOT a floor. */
/* 🏆 W71-A12 (2026-08-21) -- _mul_mant_d BYTE-PASS 59/59, 8 -> 0.  Re-gated baseline 8
 * (the w63/w64 TEXT_MOVES rows had already closed the 11B arg-order class; the whole
 * residual was the four-insn tail).  TWO devices, BOTH required (each alone = 8):
 *
 *  (1) 🔑 THE DImode COPY (new law candidate -- "a two-word tail copy that retail spells
 *      lw/lw/sw/sw with an EVEN-ODD register pair is a 64-BIT-TYPE assignment, not two
 *      int stores"):  `*(long long *)out = *(long long *)sh;`  replaces the
 *      `lo/hi` volatile-view temps + `out[0]=lo; out[1]=hi;` pair.  ONE RTL insn per
 *      direction (movdi_internal, split into two lw / two sw at final) buys THREE things
 *      at once that no int spelling reaches:
 *        (a) the loads are a DImode REGISTER PAIR -> HARD_REGNO_MODE_OK forces an EVEN
 *            start -> retail's exact `$v0,$v1`.  (The struct-assignment spelling
 *            `*(struct{int,int}*)out = *(struct{int,int}*)sh` produces the same INSN ORDER
 *            but goes through mips `movstrsi_internal` with four `=&d` SCRATCH clobbers,
 *            and reload hands scratches out of the LEAST-used spill regs -> `$t0,$t1`.
 *            Measured: struct form = 8 diffs, all four tail rows, unfixable from source.)
 *        (b) cse cannot forward the just-stored `sh[1]` through a DImode read, so the
 *            VALUE-RELOAD (05E) appears WITHOUT any `volatile` view -- and without
 *            volatile the two loads stay adjacent instead of one being hoisted above
 *            `sw sh[1]` (that hoist was 1 of the 4 baseline rows).
 *        (c) `out` drops from 4 refs to 3 (one MEM base use instead of two), which is
 *            what keeps local-alloc's handout at retail's `xlo->$s2 / out->$s3`.  With the
 *            int spelling + fence `out` has 4 refs and the pair SWAPS to `out->$s2`,
 *            which additionally breaks the wired TEXT_MOVES row (it keys on `move $19,$4`)
 *            and costs 11 rows / 20 diffs.  Measured lreg: 2 refs (baseline) -> $s3,
 *            3 refs (DImode / struct) -> $s3, 4 refs (int stores + fence) -> $s2.
 *
 *  (2) the 06B VOID-TAIL FENCE `__asm__ __volatile__("" : : "i"(0));` between the copy and
 *      `return out;`.  Without it sched1 hoists the return copy `(set (reg 2) (reg out))`
 *      above the tail, and the store base then becomes `$v0` (retail keeps `$s3` and copies
 *      to `$v0` LAST) -- exactly the w62-a8 "position row" that the 13B identity launder
 *      could not reach.  DO NOT DELETE: removing it alone re-opens the fn at 8 diffs
 *      (measured this wave).
 *
 * FALSIFIED this wave (whole-TU gated, __muldf3 stayed PASS throughout):
 *   struct-pair assignment + fence ............................. 8  (movstrsi scratch regs)
 *   struct-pair assignment, no fence ........................... 16
 *   volatile lo/hi temps + fence ............................... 20 (s2/s3 swap + TEXT_MOVES miss)
 *   volatile temps + fence + block-local `int *o = out` ........ 20
 *   volatile temps + fence + read-only ref fence on `xlo` ...... 86 (an operand-less asm is
 *                                                                    implicitly volatile ->
 *                                                                    it is a BARRIER, and one
 *                                                                    placed mid-body wrecks
 *                                                                    the whole schedule)
 * The DImode-copy device is a general candidate for every remaining libmath/soft-float tail
 * that moves a two-word value: DIVDF3/ADDDF3 carry the same `int[2]` idiom. */
int *_mul_mant_d(int *out, unsigned int x, unsigned int y)
{
    int sh[2];       /* 0x18 */
    int add[2];      /* 0x20 */
    unsigned int xlo, ylo, p;

    xlo = x & 0xFFFF;
    ylo = y & 0xFFFF;
    sh[1] = 0;
    sh[0] = xlo * ylo;
    x >>= 16;
    p = x * ylo;
    add[1] = p >> 16;
    add[0] = p << 16;
    _add_mant_d(sh, sh[0], sh[1], *(volatile int *)&add[0], add[1]);
    y >>= 16;
    p = xlo * y;
    add[1] = p >> 16;
    add[0] = p << 16;
    _add_mant_d(sh, sh[0], sh[1], *(volatile int *)&add[0], add[1]);
    sh[1] += x * y;
    *(long long *)out = *(long long *)sh;
    __asm__ __volatile__("" : : "i"(0));   /* 06B void-tail fence -- REQUIRED, see receipt */
    return out;
}
