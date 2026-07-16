/* syslib/psx/libmath/MULDF3.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj MULDF3.obj ; libmath.lib.  __muldf3 @0x800F62E4 (788 B) + _mul_mant_d @0x800F65F8 (236 B) --
 *   IEEE-754 double multiply.  53x53 mantissa product built from 21-bit limbs via _mul_mant_d/_add_mant_d,
 *   round-to-nearest.  IDA verbatim; 64-bit working values held as int[2] pairs ([0]=lo,[1]=hi); helper
 *   out-pointers write both words.  Overflow -> _err_math(34,13).
 */
unsigned int *_dbl_shift_us(unsigned int *out, int dir, unsigned int w0, int w1, int count);
int          *_add_mant_d(int *out, unsigned int a2, int a3, unsigned int a4, int a5);
int           _err_math(int errnum, int code);

/* _mul_mant_d @0x800F65F8 : 32x32->64 unsigned multiply of (a2,a3) via 16-bit lanes -> out[0:1]. */
int *_mul_mant_d(int *out, unsigned int a2, unsigned int a3)
{
    int          v3 = (unsigned short)a2;
    unsigned int v4 = (a2 >> 16) & 0xffff;
    unsigned int v6 = (a3 >> 16) & 0xffff;
    unsigned long long v11;
    int sh[2];
    sh[1] = 0;
    sh[0] = (int)((unsigned short)a2 * (unsigned short)a3);
    v11 = (unsigned long long)(((a2 >> 16) & 0xffff) * (unsigned short)a3) << 16;
    _add_mant_d(sh, sh[0], 0, (((a2 >> 16) & 0xffff) * (unsigned short)a3) << 16, (int)(unsigned int)(v11 >> 32));
    v11 = (unsigned long long)((unsigned int)(v3 * v6)) << 16;
    _add_mant_d(sh, sh[0], sh[1], (unsigned int)(v3 * v6) << 16, (int)(unsigned int)(v11 >> 32));
    sh[1] += v4 * v6;
    out[0] = sh[0];
    out[1] = sh[1];
    return out;
}

double __muldf3(int a1, int a2, int a3, int a4)   /* @0x800F62E4 */
{
    union { double d; unsigned int w[2]; } u;
    unsigned int v4 = a2 & 0x80000000 ^ a4 & 0x80000000;
    int v5;
    if ((a2 & 0x7FFFFFFF) == 0 && !a1) { u.w[1] = a2 & 0x80000000 ^ a4 & 0x80000000; u.w[0] = 0; return u.d; }
    if ((a4 & 0x7FFFFFFF) != 0) {
        v5 = (a2 >> 20) & 0x7FF;
    } else {
        v5 = (a2 >> 20) & 0x7FF;
        if (!a3) { u.w[1] = a2 & 0x80000000 ^ a4 & 0x80000000; u.w[0] = 0; return u.d; }
    }
    {
    int v6  = v5 + ((a4 >> 20) & 0x7FF);
    int v7  = v6 - 1022;
    int v28 = v6;
    int v20 = a2 & 0xFFFFF | 0x100000, v19 = a1;
    int v22 = a4 & 0xFFFFF | 0x100000, v21 = a3;
    int t1[2], t2[2], acc[2];
    int v8, v9, v10, v11;
    unsigned int v12;
    _dbl_shift_us((unsigned int *)t1, 1, a1, v20, 21);  v8 = t1[0];
    _dbl_shift_us((unsigned int *)t1, 1, v21, v22, 21); v9 = t1[0];
    v10 = v19 & 0x1FFFFF;
    v11 = v21 & 0x1FFFFF;
    _mul_mant_d(acc, v8, v9);
    _mul_mant_d(t2, v10, v9);
    _dbl_shift_us((unsigned int *)t1, 1, t2[0], t2[1], 21);
    _add_mant_d(acc, acc[0], acc[1], t1[0], t1[1]);
    _mul_mant_d(t2, v11, v8);
    _dbl_shift_us((unsigned int *)t1, 1, t2[0], t2[1], 21);
    _add_mant_d(acc, acc[0], acc[1], t1[0], t1[1]);
    if (acc[1] >= 0) {
        _add_mant_d(acc, acc[0], acc[1], 512, 0);
        if (acc[1] < 0) { _dbl_shift_us((unsigned int *)acc, 1, acc[0], acc[1], 11); }
        else            { v7 = v28 - 1023; _dbl_shift_us((unsigned int *)acc, 1, acc[0], acc[1], 10); }
    } else {
        _add_mant_d(acc, acc[0], acc[1], 1024, 0);
        _dbl_shift_us((unsigned int *)acc, 1, acc[0], acc[1], 11);
    }
    v12 = acc[1] & 0xFFEFFFFF;
    if (v7 < 2047) { u.w[1] = v4 | (v7 << 20) | v12; u.w[0] = acc[0]; }
    else { int v13; _err_math(34, 13); v13 = 2146435072; if (v4) v13 = -1048576; u.w[1] = v13; u.w[0] = 0; }
    }
    return u.d;
}
