/* syslib/psx/libmath/MULSF3.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj MULSF3.obj ; libmath.lib.  __mulsf3 @0x800F34B0 (320 B) -- IEEE-754 single multiply (a1*a2 bit
 *   patterns).  24x24 mantissa product split into 16/8-bit lanes; round-to-nearest.  Overflow -> _err_math.
 */
extern "C" int _err_math(int errnum, int code);

extern "C" unsigned int __mulsf3(int a1, int a2)   /* @0x800F34B0 */
{
    unsigned int v2 = a1 & 0x80000000 ^ a2 & 0x80000000;
    if ((a1 & 0x7FFFFFFF) == 0 || (a2 & 0x7FFFFFFF) == 0)
        return a1 & 0x80000000 ^ a2 & 0x80000000;
    int v4 = (unsigned char)(a1 >> 23) + (unsigned char)(a2 >> 23);
    int v5 = ((a1 & 0x7FFFFF | 0x800000) >> 8) * ((a2 & 0x7FFFFF | 0x800000) >> 8)
           + (((unsigned char)a1 * ((a2 & 0x7FFFFF | 0x800000) >> 8)) >> 8)
           + (((unsigned char)a2 * ((a1 & 0x7FFFFF | 0x800000) >> 8)) >> 8);
    int          v6 = v4 - 126;
    unsigned int v7;
    if (v5 < 0) {
        v7 = (unsigned int)(v5 + 128) >> 8;
    } else {
        unsigned int v8 = v5 + 64;
        if ((v8 & 0x80000000) != 0) {
            v7 = v8 >> 8;
        } else {
            v7 = v8 >> 7;
            v6 = v4 - 127;
        }
    }
    unsigned int v9 = v7 & 0xFF7FFFFF;
    if (v6 < 255) return v2 | (v6 << 23) | v9;
    _err_math(34, 12);
    int v10 = 2139095040;
    if (v2) return -8388608;
    return v10;
}
