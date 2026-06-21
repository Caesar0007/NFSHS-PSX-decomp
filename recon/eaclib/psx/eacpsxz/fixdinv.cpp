/* eaclib/psx/eacpsxz/fixdinv.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\fixdinv.obj (EACPSXZ.LIB).  1 fn @0x800ED3EC, dual XDEF
 *   `fixedinverse` + `rinverse`.  FULL reconstruction (disasm-v3 MIPS); NOT a stub.
 *   Rounded reciprocal: result = round(0xFFFFFFFF / x) carrying x's sign (abs, unsigned divide,
 *   round-half-up via remainder vs |x|/2, then re-apply sign).
 */
extern "C" unsigned fixedinverse(int x)   /* @0x800ED3EC */
{
    int sign = x >> 31;                       /* 0 or -1 */
    unsigned ax = (unsigned)((x ^ sign) - sign);   /* |x| */
    unsigned q = 0xFFFFFFFFu / ax;
    unsigned r = 0xFFFFFFFFu % ax;
    if ((ax >> 1) < r)                        /* round half up */
        q += 1;
    return (unsigned)(((int)q ^ sign) - sign);     /* re-apply sign */
}
extern "C" unsigned rinverse(int x) __attribute__((alias("fixedinverse")));
