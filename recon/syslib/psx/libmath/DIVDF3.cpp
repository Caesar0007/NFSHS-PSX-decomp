/* syslib/psx/libmath/DIVDF3.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj DIVDF3.obj ; libmath.lib.  __divdf3 @0x800F5DD4 (736 B) + _comp_mant @0x800F60B4 (80 B) --
 *   IEEE-754 double divide via restoring bitwise long division of the 53-bit mantissas (_comp_mant compares
 *   64-bit mantissa pairs; _mainasu + _add_mant_d do subtract-and-restore).  IDA verbatim.  The IDA locals
 *   v19/v20, v13/v14, v15/v16 are stack-adjacent word pairs the helpers write through &v19 etc -> int[2]
 *   here (dbl_shift order: out[0]=low word, out[1]=high word).
 */
extern "C" unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count);
extern "C" unsigned int *_dbl_shift_us(unsigned int *out, int dir, unsigned int w0, int w1, int count);
extern "C" int          *_add_mant_d(int *out, unsigned int a2, int a3, unsigned int a4, int a5);
extern "C" int          *_mainasu(int *out, int a2, int a3);
extern "C" int           _err_math(int errnum, int code);

/* _comp_mant @0x800F60B4 : compare 64-bit mantissas [a2:a1] vs [a4:a3] -> 1 / -1 / 0.
 * Direct-return cascade (lever 3.12#8): each return materializes $v0 in the branch
 * delay slot; staging through a `result` temp would pin $t0+move instead. */
extern "C" int _comp_mant(unsigned int a1, unsigned int a2, unsigned int a3, unsigned int a4)
{
    if (a4 < a2) return 1;
    if (a2 < a4) return -1;
    if (a3 < a1) return 1;
    if (a1 < a3) return -1;
    return 0;
}

extern "C" double __divdf3(int a1, int a2, int a3, int a4)   /* @0x800F5DD4 */
{
    union { double d; unsigned int w[2]; } u;
    int          v4 = ((a2 >> 20) & 0x7FF) - ((a4 >> 20) & 0x7FF) + 1022;
    unsigned int v5 = a2 & 0x80000000 ^ a4 & 0x80000000;
    if ((a4 & 0x7FFFFFFF) != 0 || a3) {
        if ((a2 & 0x7FFFFFFF) != 0 || a1) {
            int d[2];   /* v19(lo), v20(hi) -- dividend */
            int q[2];   /* v13(lo), v14(hi) -- quotient */
            int b[2];   /* v15(lo), v16(hi) -- current bit */
            int v21 = a3, v22 = a4 & 0xFFFFF | 0x100000;   /* divisor */
            d[0] = a1;
            d[1] = a2 & 0xFFFFF | 0x100000;
            if (_comp_mant(d[0], d[1], v21, v22) < 0) {
                --v4;
                _dbl_shift((unsigned int *)d, 0, d[0], d[1], 1);
            }
            b[1] = 0x200000; b[0] = 0; q[0] = 0; q[1] = 0;
            do {
                if (_comp_mant(d[0], d[1], v21, v22) >= 0) {
                    q[1] |= b[1];
                    q[0] |= b[0];
                    int v23[2];
                    _mainasu(v23, v21, v22);
                    _add_mant_d(d, d[0], d[1], v23[0], v23[1]);
                }
                _dbl_shift((unsigned int *)d, 0, d[0], d[1], 1);
                _dbl_shift_us((unsigned int *)b, 1, b[0], b[1], 1);
            } while (b[1] || b[0]);
            int v7, v8;
            if (v4 < 0) {
                int v17 = 1 << -(char)v4;
                _add_mant_d(q, q[0], q[1], v17, 0);
                v7 = -v4 + 1;
                v8 = 0;
            } else {
                v7 = 1;
                v8 = v4 + 1;
                _add_mant_d(q, q[0], q[1], 1, 0);
            }
            _dbl_shift_us((unsigned int *)q, 1, q[0], q[1], v7);
            unsigned int v10 = q[1] & 0xFFEFFFFF;
            if (v8 < 2047) { u.w[1] = v5 | (v8 << 20) | v10; u.w[0] = q[0]; }
            else { _err_math(34, 15); int v11 = 2146435072; if (v5) v11 = -1048576; u.w[1] = v11; u.w[0] = 0; }
        } else {
            u.w[1] = a2 & 0x80000000 ^ a4 & 0x80000000;
            u.w[0] = 0;
        }
    } else {
        u.w[1] = (v5 == 0) ? 0x7FFFFFFF : 0xFFFFFFFF;
        u.w[0] = 0xFFFFFFFF;
    }
    return u.d;
}
