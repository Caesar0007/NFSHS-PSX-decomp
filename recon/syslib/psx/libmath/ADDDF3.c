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
 * RESIDUAL (67): the remaining dominant coloring is one allocation-seat swap
 * (ours {be=$s5, mask=$s6}, retail {mask=$s5, be=$s6}), plus the two early-return block placements
 * (retail keeps `return b` as the FALL-THROUGH of both zero tests) and the
 * arg4-load order class shared with DIVDF3/MULDF3.  FALSIFIED: seven 05C fence
 * operand sets at the mantissa-build anchor (sign / be / ae and every pair and
 * the triple) -- ALL cost +1 insn and +5 diffs on every rung, i.e. this basin
 * has no slack there.  NAMED NEXT ANGLE: the rotation is one allocation seat,
 * so the dial is a ref-count change that does NOT add an insn -- a duplicated
 * `return` var or a loop-depth-weighted extra use (06B "no-asm alternatives"),
 * not a fence.  Not a floor.
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
        sign = signMask;
        _mainasu(A, A[0], A[1]);
    } else if (A[1] == 0 && A[0] == 0) {
        return uz.d;
    }
    while ((A[1] & 0xE0000000) == 0) {
        _dbl_shift((unsigned int *)A, 0, A[0], A[1], 1);
        ae -= 1;
    }
    if (A[1] & 0x40000000) {
        ae += 1;
        _dbl_shift((unsigned int *)A, 1, A[0], A[1], 1);
    }
    k = 255;
    if ((A[0] & 0x200) != 0) k = 256;
    rnd[1] = 0;
    rnd[0] = k;
    _add_mant_d(A, A[0], A[1], rnd[0], rnd[1]);
    if (A[1] & 0x40000000) {
        ae += 1;
        _dbl_shift((unsigned int *)A, 1, A[0], A[1], 1);
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
