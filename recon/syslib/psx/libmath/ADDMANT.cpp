/* syslib/psx/libmath/ADDMANT.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj ADDMANT.obj ; libmath.lib.  _add_mant_d @0x80106F70 (172 B) -- 64-bit mantissa add with 16-bit-lane
 *   carry propagation: out[0:1] = [a3:a2_lo16|...] ; adds (a2,a3)+(a4,a5).  Soft-float primitive.
 */
extern "C" int *_add_mant_d(int *out, unsigned int a2, int a3, unsigned int a4, int a5)   /* @0x80106F70 */
{
    unsigned int v5 = (a4 >> 16) & 0xffff;
    int          v8 = a3;
    int          v7 = (a2 >> 16) & 0xffff;
    if (((((a2 & 0xffff) + (a4 & 0xffff)) & 0x10000) != 0))
        v7 = ((a2 >> 16) & 0xffff) + 1;
    if (((v7 + v5) & 0x10000) != 0)
        v8 = a3 + 1;
    out[0] = (int)(((unsigned int)(v7 + v5) << 16) | (unsigned int)((a2 + a4) & 0xffff));
    out[1] = v8 + a5;
    return out;
}
