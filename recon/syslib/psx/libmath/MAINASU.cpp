/* syslib/psx/libmath/MAINASU.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj MAINASU.obj ; libmath.lib.  _mainasu @0x80106F00 (112 B) -- two's-complement negate a 64-bit value
 *   [a3:a2]: out = ~[a3:a2] + 1, via _add_mant_d.  (The &tmp[0] write reaches both words, matching the binary
 *   stack adjacency.)
 */
extern "C" int *_add_mant_d(int *out, unsigned int a2, int a3, unsigned int a4, int a5);   /* ADDMANT */

extern "C" int *_mainasu(int *out, int a2, int a3)   /* @0x80106F00 */
{
    int tmp[2];
    tmp[0] = ~a2;
    tmp[1] = ~a3;
    _add_mant_d(tmp, ~a2, ~a3, 1u, 0);
    out[0] = tmp[0];
    out[1] = tmp[1];
    return out;
}
