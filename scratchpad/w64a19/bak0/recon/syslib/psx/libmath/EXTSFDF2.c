/* syslib/psx/libmath/EXTSFDF2.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj EXTSFDF2.obj ; libmath.lib.  __extendsfdf2 @0x800F57C4 (348 B) -- float -> double (widen).
 *   a1 = single bit-pattern; returns double in $v0:$v1.  Uses _dbl_shift (normalises denormals).  IDA verbatim.
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
/* MATCH: PASS 87/87 (W53-A12).  Lane: cc1_272 (unchanged).  55 diffs -> 0.
 * THREE levers; the first is the libmath cluster lever (mechanism in GTDF2.c):
 *
 * 1. REAL FLOAT/DOUBLE PARAMETERS + REGISTER-RESIDENT UNIONS.  `float a` is an
 *    SFmode pseudo (retail `addu $s3,$a0,$zero`), the RESULT is a DFmode pseudo
 *    held in the even-aligned callee-saved PAIR $s0:$s1 and copied to the return
 *    pair at the tail (`addu $v0,$s0,$zero; addu $v1,$s1,$zero`) -- that is a
 *    `union double_long` returned by value, NOT two int words.  The unions never
 *    have their address taken, so they stay in registers (frame 0 for them).
 *
 * 2. TWO 8-BYTE SCRATCH ARRAYS, `sh` FIRST.  Retail's frame is 0x48 with the
 *    _dbl_shift buffer at 0x18 and 8 UNTOUCHED bytes at 0x20; the sibling
 *    TRUDFSF2 shows why -- that TU declares an INPUT array and an OUTPUT array
 *    and uses both (in @0x18, out @0x20).  Here the same pair is declared but
 *    _dbl_shift is called in-place on the first one, so the second is dead code
 *    that still owns its frame slot (gcc allocates the slot at expand time).
 *    DECL ORDER IS THE DIAL: first-declared gets the LOW slot, so `sh` must be
 *    declared before `t` (reversing them leaves 30 diffs of offset skew).  Every
 *    non-array candidate was falsified -- a second `double_long`, a bare
 *    `double`, and any non-addressed union get NO slot (they are pseudos).
 *
 * 3. Two oracle-shape corrections: the top-level test is written ZERO-FIRST
 *    (`if ((ua.i & 0x7FFFFFFF) == 0) {...} else {...}`) so the zero case is the
 *    FALL-THROUGH after retail's `bnez` (the `!= 0` spelling inverted the whole
 *    function), and the denormal guard tests `sh[1] & 0xFFE00000` -- the same
 *    value as the IDA-folded `a1 & 0x600000` but off the ARRAY WORD, which is
 *    what puts the constant in $s4 as a hoisted loop invariant beside `$s5 = 1`.
 */
unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count);

typedef union {
    double d;
    struct { unsigned int lo; int hi; } w;
} double_long;

typedef union {
    float f;
    int i;
} float_long;

double __extendsfdf2(float a)   /* @0x800F57C4 */
{
    int sh[2];
    int t[2];
    float_long ua;
    double_long u;
    int i;
    ua.f = a;
    (void)t;
    if ((ua.i & 0x7FFFFFFF) == 0) {
        u.w.hi = ua.i & 0x80000000;
        u.w.lo = 0;
    } else {
        int v3;
        sh[1] = ua.i & 0x7FFFFF;
        sh[0] = 0;
        if ((unsigned char)(ua.i >> 23)) {
            v3 = (unsigned char)(ua.i >> 23) + 896;
            _dbl_shift((unsigned int *)sh, 1, sh[0], sh[1], 3);
        } else {
            v3 = 894;
            if ((sh[1] & 0xFFE00000) != 0) {
                do { _dbl_shift((unsigned int *)sh, 1, sh[0], sh[1], 1); ++v3; }
                while ((sh[1] & 0xFFE00000) != 0);
            }
            for (i = sh[1]; (i & 0x100000) == 0; --v3) { sh[1] = 2 * i; i *= 2; }
            sh[1] &= ~0x100000u;
        }
        u.w.hi = (ua.i & 0x80000000) | (v3 << 20) | sh[1];
        u.w.lo = sh[0];
    }
    return u.d;
}
