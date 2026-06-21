/* eaclib/psx/eacpsxz/fsincos.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\fsincos.obj (EACPSXZ.LIB).  1 fn @0x800F3670 : fixedsincos.
 *   FULL reconstruction (disasm-v3 MIPS); NOT a stub.  Writes high-resolution sin/cos of a fixed
 *   angle (same fractional-angle Taylor correction as fixedsin/fixedcos, but both outputs from one
 *   intsincos base call):  *psin = s + (c>>2)*P >> 21 ,  *pcos = c - (s>>2)*P >> 21
 *   where (s,c) = intsincos(angle>>6) and P = the 6-bit fractional weight (angle & 0x3F).  16.16.
 */
extern "C" void intsincos(int angle, int *psin, int *pcos);   /* isincos @0x800EADBC */

static int spch_poly(int f)          /* same weight polynomial as fixdsin */
{
    int v1 = (f << 1) + f;
    v1 = v1 + (v1 << 6);
    v1 = v1 << 5;
    v1 = v1 - f;
    v1 = v1 + (v1 << 5);
    v1 = v1 << 1;
    return v1 >> 9;
}

extern "C" void fixedsincos(int angle, int *psin, int *pcos)   /* @0x800F3670 */
{
    int s, c;
    intsincos(angle >> 6, &s, &c);
    int p = spch_poly(angle & 0x3F);
    *psin = s + (int)(((long long)(c >> 2) * (long long)p) >> 21);
    *pcos = c - (int)(((long long)(s >> 2) * (long long)p) >> 21);
}
