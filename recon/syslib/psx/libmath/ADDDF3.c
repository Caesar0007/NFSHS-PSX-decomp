/* syslib/psx/libmath/ADDDF3.c -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays). C lane (3.25, task #90).
 *   obj ADDDF3.obj ; libmath.lib.  __adddf3 @0x800F5A54 (884 B) -- IEEE-754 double add (and, via sign, the
 *   subtract path).  Aligns exponents, adds/subtracts 64-bit mantissas (sign-magnitude through _mainasu),
 *   renormalises, round-to-nearest.  IDA verbatim; the __int64 accumulator v12 is a union (`.ll` for the
 *   64-bit compares/masks, `.w[2]` for the helper word-writes).  Overflow -> _err_math(34,11).
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
unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count);
int          *_add_mant_d(int *out, unsigned int a2, int a3, unsigned int a4, int a5);
int          *_mainasu(int *out, int a2, int a3);
int           _err_math(int errnum, int code);

/* MATCH (2026-08-14): 347 -> 67 diffs (ours 222 / oracle 221).  Lane UNCHANGED
 * {"cc1_alt": "2.7.2-970404"}.  04Z re-ladder on the landed basin: 2.6.0/2.6.3
 * = 128 * 2.7.2-970404 = 126 (count-exact) * 2.7.2 = 125 (222 insns) *
 * 2.8.0/2.8.1 = 126 (count-exact) * 2.91.66 = 269 * 2.95.2 = 233.  The wired
 * 970404 rung stays: it is count-exact and within 1 of the best.
 *
 * LANDINGS: 347 -> 138 the 05B `double` params + `double_long` unions + the
 * 32-bit normalisation tests (the old body compared the 64-bit `union I64`
 * with `long long` operators -- retail only ever ANDs A[1], the HIGH word);
 * 138 -> 126 (a) the zero-double spelled as a union with an ARRAY member; the
 * later `zp` address escape completes the required frame placement (retail
 * `sw zero,0x30/0x34` ... `lw v0,0x30;
 * lw v1,0x34`; the struct form kept it in two registers = 3 wasted insns),
 * and (b) the SECOND early `return b` spelled `return ub.d` so it uses the
 * $s0:$s1 copy the way retail does (the FIRST one legitimately still uses the
 * live $a2:$a3).
 *
 * The latest reduction makes the zero-union address escape through `zp`, forcing
 * retail's stack-backed 0x30/0x34 representation, and keeps a named sign mask
 * live across both sign tests and the result-sign assignment.  That moves the
 * function from 126 to 67 and establishes the retail 0x60-byte frame and $s7
 * result-sign lifetime without asm or volatile.
 *
 * MATCH (W61-A9, 2026-08-15): 67 -> 12 diffs, and the stream is now COUNT-EXACT
 * (221/221).  Four statement-position landings, no asm, no volatile, no wiring
 * change (04Z re-ladder on the NEW basin, whole-TU: 2.6.0/2.6.3 = 52 *
 * 2.7.2 = 49 * 2.7.2-970404 = 12 (WIRED, optimal by 20) * 2.8.0/2.8.1 = 32 *
 * 2.91.66 = 163 * 2.95.2 = 212):
 *   (1) `sign = 0x80000000;` as a LITERAL, not `sign = signMask;`.  The copy
 *       from the named mask was worth 24 diffs: it made retail rematerialize
 *       `lui $s7,0x8000` unreachable AND it held signMask live to the end, which
 *       is what rotated the {be,mask} = {$s5,$s6} seats.  Writing the literal
 *       shortens signMask's live range and the seats snap to retail by
 *       themselves -- the standing "one allocation seat, needs a ref-count dial"
 *       angle was solved by DELETING a ref, not adding one.  67 -> 43.
 *   (2) `rnd[1] = 0;` moved between `k = 255;` and the k-select `if`.  reorg
 *       fills the beqz slot from the nearest preceding movable insn: with the
 *       store there it steals `sw zero,44(sp)` (retail) instead of `li v1,255`,
 *       and the freed `li` then fills the `lw v0,24(sp)` load-delay slot.
 *       43 -> 38.
 *   (3+4) `ae += 1;` moved AFTER its `_dbl_shift(...,1,...,1)` call at BOTH
 *       sites, and `sign = 0x80000000;` moved AFTER its `_mainasu` call.
 *       38 -> 18 -> 12.  KEY: LAW REFINEMENT (sharpens the w60-a5 DIVDF3 row
 *       "reorg can only steal what PRECEDES the jal"): reorg fills a CALL delay
 *       slot from EITHER side.  A statement written BEFORE the call competes
 *       with the argument setup and usually loses (the arg move is nearer);
 *       written AFTER the call it is the nearest candidate in the forward scan
 *       and wins, provided it touches no caller-saved register (`ae` and `sign`
 *       both live in $s4/$s7).  Pick the side by which insn retail put in the
 *       slot: retail's slot insn is the one that must sit on the side reorg
 *       scans first.
 *
 * RESIDUAL (12) -- ALL FOUR are one class, "ours cse-shares a live value where
 * retail re-materializes / re-loads" (the 3b old-gcc no-copy-prop identity):
 *   (a) x2 `addu v0,a1,zero` vs retail `li v0,1` -- the two literal `1`s of
 *       `_dbl_shift(A, 1, A[0], A[1], 1)` (register arg2 + stack arg5).
 *   (b) `addu a3,v1,zero` vs retail `lw a3,40(sp)` -- store-to-load forwarding
 *       of `rnd[0]` at the `_add_mant_d` rounding call.
 *   (c) `addu s0,v1,zero` vs retail `lui s0,57344` -- the 0xE0000000 loop mask
 *       re-materialized in the preheader instead of copied from the peeled test.
 *   (d) `sw zero,48(sp)` scheduled at prologue index 1 by retail, index 19 by us
 *       (sched2 luid order inside the prologue block), plus the paired
 *       `lw a3,32(sp)` arg-order row at the first `_add_mant_d` (11B).
 *   FALSIFIED at this basin (whole-TU gated, scratchpad/w61a9/add_v*.json):
 *   rnd through a pointer local `rp` 17 * rnd[0] AND rnd[1] through `rp` 20 *
 *   identity fence on `k` after the store 12 (inert) * named `int one = 1;` for
 *   the count arg 12 (inert -- constant-propagated) * named `normMask` for the
 *   loop constant 16 * `zp[1]` before `zp[0]` 14 * `sign = 0;` hoisted above the
 *   zp stores 12 (inert) * zp stores after `ua.d`/`ub.d` 12 (inert) * `uz.w[1]`
 *   spelled directly instead of `zp[1]` 12 (inert) * all 8 ladder rungs (above).
 *   NAMED NEXT ANGLE: this is a cse COST-MODEL delta, not a spelling -- in
 *   gcc-2.7 `cse_insn` only substitutes when `rtx_cost` strictly improves, so
 *   retail's cc1 scored a 16-bit `li`/`lui` at the same cost as a reg copy and
 *   kept the constant.  The reachable lever is therefore an instrument question
 *   (dump cse's table on the 970404 rung and find which source shape stops the
 *   value being RECORDED), or a rung not on our ladder.  Not a floor.
 * ---- shape notes ----
 * Same 05B soft-float PAIR shape + oracle re-derivation as DIVDF3.c/MULDF3.c.
 * Oracle tells (frame 0x60): a -> $s2:$s3, b -> $s0:$s1 (BOTH DFmode pairs land
 * in EVEN-ALIGNED CALLEE-SAVED pairs because both live across calls); the RESULT
 * reuses a's pair (`addu v0,s2; addu v1,s3`), i.e. the result union IS `ua`.
 * Frame local map == declaration order: 0x18 A[2] | 0x20 B[2] | 0x28 rnd[2],
 * then the spilled zero-double at 0x30.  `B` is reached through a POINTER LOCAL
 * ($s1 = sp+0x20, `addu a0,s1,zero`) at two sites.  The normalisation tests are
 * 32-bit on A[1] ONLY (`and v0,v0,0xE0000000`), NOT the 64-bit `long long`
 * compares the old IDA transcription used -- that alone was worth ~10 insns.
 * Retail spells the sign tests asymmetrically (`bgez` for A, mask test for B).
 * The current named-mask form deliberately tests both through the same mask: it
 * adds one instruction but raises the mask allocation quantity and is the verified
 * lower-diff basin from which the final $s5/$s6 priority swap can be solved. */
typedef union {
    double d;
    struct { unsigned int lo; int hi; } w;
} double_long;

double __adddf3(double a, double b)   /* @0x800F5A54 */
{
    double_long ua, ub;
    union { double d; int w[2]; } uz;   /* ARRAY member + the `zp` address escape
                                         * force the frame, which is what retail's
                                         * `sw zero,0x30/0x34` + `lw v0,0x30;
                                         * lw v1,0x34` return path shows. */
    int A[2];     /* 0x18 */
    int B[2];     /* 0x20 */
    int rnd[2];   /* 0x28 */
    int *zp;
    int *bp;
    int ae, be, k;
    int sign;
    int signMask;

    zp = uz.w;
    zp[0] = 0;
    zp[1] = 0;
    sign = 0;
    ua.d = a;
    ub.d = b;
    if ((ua.w.hi & 0x7FFFFFFF) == 0 && ua.w.lo == 0) return b;
    if ((ub.w.hi & 0x7FFFFFFF) == 0 && ub.w.lo == 0) return ua.d;
    ae = (ua.w.hi >> 20) & 0x7FF;
    be = (ub.w.hi >> 20) & 0x7FF;
    if (be + 54 < ae) return ua.d;
    if (ae + 54 < be) return ub.d;
    A[1] = (ua.w.hi & 0xFFFFF) | 0x100000;
    A[0] = ua.w.lo;
    B[1] = (ub.w.hi & 0xFFFFF) | 0x100000;
    B[0] = ub.w.lo;
    signMask = 0x80000000;
    if (ua.w.hi & signMask) _mainasu(A, A[0], A[1]);
    if (ub.w.hi & signMask) _mainasu(B, B[0], B[1]);
    _dbl_shift((unsigned int *)A, 0, A[0], A[1], 9);
    bp = B;
    _dbl_shift((unsigned int *)bp, 0, B[0], B[1], 9);
    if (be < ae) {
        _dbl_shift((unsigned int *)bp, 1, B[0], B[1], ae - be);
    } else {
        _dbl_shift((unsigned int *)A, 1, A[0], A[1], be - ae);
        ae = be;
    }
    _add_mant_d(A, A[0], A[1], B[0], B[1]);
    if (A[1] < 0) {
        _mainasu(A, A[0], A[1]);
        sign = 0x80000000;
    } else if (A[1] == 0 && A[0] == 0) {
        return uz.d;
    }
    while ((A[1] & 0xE0000000) == 0) {
        _dbl_shift((unsigned int *)A, 0, A[0], A[1], 1);
        ae -= 1;
    }
    if (A[1] & 0x40000000) {
        _dbl_shift((unsigned int *)A, 1, A[0], A[1], 1);
        ae += 1;
    }
    k = 255;
    rnd[1] = 0;
    if ((A[0] & 0x200) != 0) k = 256;
    rnd[0] = k;
    _add_mant_d(A, A[0], A[1], rnd[0], rnd[1]);
    if (A[1] & 0x40000000) {
        _dbl_shift((unsigned int *)A, 1, A[0], A[1], 1);
        ae += 1;
    }
    _dbl_shift((unsigned int *)A, 1, A[0], A[1], 9);
    A[1] &= 0xFFEFFFFF;
    if (ae >= 2047) {
        _err_math(34, 11);
        ua.w.hi = sign ? 0xFFF00000 : 0x7FF00000;
        ua.w.lo = 0;
    } else {
        ua.w.hi = sign | (ae << 20) | A[1];
        ua.w.lo = A[0];
    }
    return ua.d;
}
