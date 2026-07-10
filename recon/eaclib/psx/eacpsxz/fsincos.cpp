/* eaclib/psx/eacpsxz/fsincos.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\fsincos.obj (EACPSXZ.LIB).  1 fn @0x800F3670 : fixedsincos.
 *   FULL reconstruction (disasm-v3 MIPS); NOT a stub.  Writes high-resolution sin/cos of a fixed
 *   angle (same fractional-angle Taylor correction as fixedsin/fixedcos, but both outputs from one
 *   intsincos base call):  *psin = s + (c>>2)*P >> 21 ,  *pcos = c - (s>>2)*P >> 21
 *   where (s,c) = intsincos(angle>>6) and P = the 6-bit fractional weight (angle & 0x3F).  16.16.
 */
extern "C" void intsincos(int angle, int *psin, int *pcos);   /* isincos @0x800EADBC */

extern "C" void fixedsincos(int angle, int *psin, int *pcos)   /* @0x800F3670 */
{
    /* MATCH: the weight polynomial is INLINE (no helper call exists in the binary --
     * the oracle has the sll/addu chain right after intsincos, andi s0 in place),
     * and the products are plain 32-bit mult/mflo (NOT a 64-bit long long widen). */
    int s, c;
    int p;
    intsincos(angle >> 6, &s, &c);
    angle = angle & 0x3F;
    p = (angle << 1) + angle;
    p = p + (p << 6);
    p = p << 5;
    p = p - angle;
    p = p + (p << 5);
    p = p << 1;
    p = p >> 9;
    {
        int t;                        /* ONE reused temp -> both sra land in a0 */
        t = ((c >> 2) * p) >> 21;
        *psin = s + t;
        t = ((s >> 2) * p) >> 21;
        *pcos = c - t;
    }
}
