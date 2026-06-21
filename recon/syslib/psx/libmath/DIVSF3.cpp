/* syslib/psx/libmath/DIVSF3.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj DIVSF3.obj ; libmath.lib.  __divsf3 @0x800F66E4 (324 B) -- IEEE-754 single divide (a1/a2 bit
 *   patterns) via restoring bitwise long division of the mantissas.  Div-by-0 -> +/-Inf; overflow -> _err_math.
 */
extern "C" int _err_math(int errnum, int code);

extern "C" unsigned int __divsf3(int a1, int a2)   /* @0x800F66E4 */
{
    int          v2 = (unsigned char)(a1 >> 23) - (unsigned char)(a2 >> 23);
    int          v3 = v2 + 126;
    unsigned int v4 = a1 & 0x80000000 ^ a2 & 0x80000000;
    if ((a2 & 0x7FFFFFFF) != 0) {
        if ((a1 & 0x7FFFFFFF) != 0) {
            int v6 = a1 & 0x7FFFFF | 0x800000;
            int v7 = a2 & 0x7FFFFF | 0x800000;
            int v8 = 0x1000000;
            if (v6 < v7) { v6 *= 2; v3 = v2 + 125; }
            int v9 = 0;
            do {
                if (v6 >= v7) { v9 |= v8; v6 -= v7; }
                v8 >>= 1;
                v6 *= 2;
            } while (v8);
            int v10, v11;
            if (v3 < 0) {
                v11 = (v9 + (1 << -(char)v3)) >> (1 - v3);
                v10 = 0;
            } else {
                v10 = v3 + 1;
                v11 = (v9 + 1) >> 1;
            }
            unsigned int v12 = v11 & 0xFF7FFFFF;
            if (v10 < 255) return v4 | (v10 << 23) | v12;
            _err_math(34, 14);
            int v13 = 2139095040;
            if (v4) return -8388608;
            return v13;
        } else {
            return a1 & 0x80000000 ^ a2 & 0x80000000;
        }
    } else {
        unsigned int result = 1325400064;
        if (v4) return 1333788672;
        return result;
    }
}
