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
int          *_add_mant_d(int *out, unsigned int a2, int a3, unsigned int a4, int a5);
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
        _add_mant_d(acc, acc[0], acc[1], t[0], t[1]);
        _mul_mant_d(up, bl, ah);
        _dbl_shift_us((unsigned int *)tp, 1, u[0], u[1], 21);
        _add_mant_d(acc, acc[0], acc[1], t[0], t[1]);
        if (acc[1] < 0) {
            add[1] = 0;
            add[0] = 0x400;
            _add_mant_d(acc, acc[0], acc[1], *(volatile int *)&add[0], add[1]);
            _dbl_shift_us((unsigned int *)acc, 1, acc[0], acc[1], 11);
        } else {
            signmask = 0x80000000u;
            __asm__("" : "=r"(signmask) : "0"(signmask));
            __asm__("" : "=r"(signmask) : "0"(signmask));
            __asm__("" : "=r"(signmask) : "0"(signmask));
            add[1] = 0;
            add[0] = 0x200;
            _add_mant_d(acc, acc[0], acc[1], *(volatile int *)&add[0], add[1]);
            if (((unsigned int)acc[1] & signmask) != 0u) {
                _dbl_shift_us((unsigned int *)acc, 1, acc[0], acc[1], 11);
            } else {
                exp = e - 1023;
                _dbl_shift_us((unsigned int *)acc, 1, acc[0], acc[1], 10);
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
int *_mul_mant_d(int *out, unsigned int x, unsigned int y)
{
    int sh[2];       /* 0x18 */
    int add[2];      /* 0x20 */
    unsigned int xlo, ylo, p;
    int lo, hi;

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
    lo = *(volatile int *)&sh[0];
    hi = *(volatile int *)&sh[1];
    out[0] = lo;
    out[1] = hi;
    return out;
}
