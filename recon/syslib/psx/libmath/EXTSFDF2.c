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
unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count);

double __extendsfdf2(int a1)   /* @0x800F57C4 */
{
    union { double d; unsigned int w[2]; } u;
    int i;
    if ((a1 & 0x7FFFFFFF) != 0) {
        int sh[2];
        int v3;
        sh[1] = a1 & 0x7FFFFF;
        sh[0] = 0;
        if ((unsigned char)(a1 >> 23)) {
            v3 = (unsigned char)(a1 >> 23) + 896;
            _dbl_shift((unsigned int *)sh, 1, sh[0], sh[1], 3);
        } else {
            v3 = 894;
            if ((a1 & 0x600000) != 0) {
                do { _dbl_shift((unsigned int *)sh, 1, sh[0], sh[1], 1); ++v3; }
                while ((sh[1] & 0xFFE00000) != 0);
            }
            for (i = sh[1]; (i & 0x100000) == 0; --v3) { sh[1] = 2 * i; i *= 2; }
            sh[1] &= ~0x100000u;
        }
        u.w[1] = a1 & 0x80000000 | (v3 << 20) | sh[1];
        u.w[0] = sh[0];
    } else {
        u.w[1] = a1 & 0x80000000;
        u.w[0] = 0;
    }
    return u.d;
}
