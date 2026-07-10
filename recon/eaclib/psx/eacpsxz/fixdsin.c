/* eaclib/psx/eacpsxz/fixdsin.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\fixdsin.obj (EACPSXZ.LIB).  2 fns: fixedsin@0x800ED424,
 *   fixedcos@0x800ED4A4.  FULL reconstruction (disasm-v3 MIPS); NOT stubs.
 *
 *   Higher-resolution sin/cos: take the coarse table value (fastintsin/fastintcos of x>>6) and
 *   add a first-order correction using the derivative (Taylor: sin(a+d)=sin a + cos a * d,
 *   cos(a+d)=cos a - sin a * d).  d is the 6-bit fractional angle (x & 0x3F) run through a fixed
 *   integer polynomial P(f), and the correction is (deriv>>2) * P(f) >> 21.  Returns 16.16.
 */
extern int fastintsin(int angle);   /* sinfunc @0x800F18E8 */
extern int fastintcos(int angle);   /* sinfunc @0x800F18E4 */

/* MATCH (both fns): the weight polynomial P(f) is INLINE (no helper call in the binary),
 * the coarse angle x>>6 is ONE shared local (s1, reused for both call args, then the
 * base result reuses its reg), and the products are plain 32-bit mult (no long long). */

extern int fixedsin(int x)   /* @0x800ED424 */
{
    int a = x >> 6;
    int base  = fastintsin(a);
    int deriv = fastintcos(a);
    int p;
    x = x & 0x3F;
    p = (x << 1) + x;             /* 3f  */
    p = p + (p << 6);             /* *65 */
    p = p << 5;                   /* *32 */
    p = p - x;
    p = p + (p << 5);             /* *33 */
    p = p << 1;
    p = p >> 9;
    return base + (((deriv >> 2) * p) >> 21);
}

extern int fixedcos(int x)   /* @0x800ED4A4 */
{
    int a = x >> 6;
    int base  = fastintcos(a);
    int deriv = -fastintsin(a);
    int p;
    x = x & 0x3F;
    p = (x << 1) + x;
    p = p + (p << 6);
    p = p << 5;
    p = p - x;
    p = p + (p << 5);
    p = p << 1;
    p = p >> 9;
    return base + (((deriv >> 2) * p) >> 21);
}
