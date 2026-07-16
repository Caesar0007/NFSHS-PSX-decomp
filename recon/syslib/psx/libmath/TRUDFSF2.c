/* syslib/psx/libmath/TRUDFSF2.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj TRUDFSF2.obj ; libmath.lib.  __truncdfsf2 @0x800F5924 (304 B) -- double -> float (narrow, round).
 *   a1=lo, a2=hi double words; returns the single bit-pattern.  Uses _dbl_shift; overflow -> _err_math(34,16).
 *   The `1 << (1-(v4+0x80))` denormal shifts rely on MIPS sllv masking (count & 0x1f), as in the binary.
 */
unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count);
int _err_math(int errnum, int code);

int __truncdfsf2(int a1, int a2)   /* @0x800F5924 */
{
    int result;
    int v4, v5, v9;
    int sh[2];
    unsigned int v6, v7;
    if ((a2 & 0x7FFFFFFF) == 0 && !a1) return a2 & 0x80000000;
    v4 = (a2 >> 20) & 0x7FF;
    v5 = v4 - 896;
    _dbl_shift((unsigned int *)sh, 0, a1, a2 & 0xFFFFF | 0x100000, 4);
    v9 = sh[1];
    if (v4 - 896 <= 0) {
        v6 = (unsigned int)(v9 + (1 << (1 - (v4 + 0x80)))) >> (2 - (v4 + 0x80));
        v5 = 0;
    } else {
        v6 = (unsigned int)(v9 + 1) >> 1;
        if ((v6 & 0xFF000000) != 0) {
            v6 = (unsigned int)(v9 + 1) >> 2;
            v5 = v4 - 895;
        }
    }
    v7 = v6 & 0xFF7FFFFF;
    if (v5 < 255) return a2 & 0x80000000 | (v5 << 23) | v7;
    _err_math(34, 16);
    result = 2139095040;
    if (a2 < 0) return -8388608;
    return result;
}
