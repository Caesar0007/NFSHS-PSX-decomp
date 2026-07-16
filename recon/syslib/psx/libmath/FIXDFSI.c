/* syslib/psx/libmath/FIXDFSI.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj FIXDFSI.obj ; libmath.lib.  __fixdfsi @0x800F6834 (252 B) -- double -> signed int (truncate toward 0).
 *   Soft-float ABI: a1=lo word, a2=hi word.  Uses _dbl_shift; overflow -> _err_math(34,17), INT_MAX/MIN.
 */
unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count);
int _err_math(int errnum, int code);

unsigned int __fixdfsi(int a1, int a2)   /* @0x800F6834 */
{
    unsigned int result;
    int v4;
    if ((a2 & 0x7FFFFFFF) == 0 && !a1) return a2 & 0x80000000;
    v4 = (a2 >> 20) & 0x7FF;
    if (v4 - 1053 <= 0) {
        int sh[2];
        int v8;
        char v5;
        sh[1] = a2 & 0xFFFFF | 0x100000;
        sh[0] = a1;
        _dbl_shift((unsigned int *)sh, 0, a1, sh[1], 10);
        v8 = sh[1];
        v5 = 29 - v4;
        if ((unsigned int)(v4 - 1022) < 0x20 && v8 != 0) {
            int v6 = v8 >> v5;
            result = (unsigned int)(v8 >> v5);
            if (a2 < 0) return (unsigned int)(-v6);
        } else {
            return 0;
        }
    } else {
        _err_math(34, 17);
        result = 0x7FFFFFFF;
        if (a2 < 0) return 0x80000000;
    }
    return result;
}
