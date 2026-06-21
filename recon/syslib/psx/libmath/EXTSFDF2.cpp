/* syslib/psx/libmath/EXTSFDF2.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj EXTSFDF2.obj ; libmath.lib.  __extendsfdf2 @0x800F57C4 (348 B) -- float -> double (widen).
 *   a1 = single bit-pattern; returns double in $v0:$v1.  Uses _dbl_shift (normalises denormals).  IDA verbatim.
 */
extern "C" unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count);

extern "C" double __extendsfdf2(int a1)   /* @0x800F57C4 */
{
    union { double d; unsigned int w[2]; } u;
    if ((a1 & 0x7FFFFFFF) != 0) {
        int sh[2];
        sh[1] = a1 & 0x7FFFFF;
        sh[0] = 0;
        int v3;
        if ((unsigned char)(a1 >> 23)) {
            v3 = (unsigned char)(a1 >> 23) + 896;
            _dbl_shift((unsigned int *)sh, 1, sh[0], sh[1], 3);
        } else {
            v3 = 894;
            if ((a1 & 0x600000) != 0) {
                do { _dbl_shift((unsigned int *)sh, 1, sh[0], sh[1], 1); ++v3; }
                while ((sh[1] & 0xFFE00000) != 0);
            }
            for (int i = sh[1]; (i & 0x100000) == 0; --v3) { sh[1] = 2 * i; i *= 2; }
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
