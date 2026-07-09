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

/* P(f): the fixed-point fractional-angle weight, transcribed shift-for-shift from the MIPS. */
static int spch_poly(int f)
{
    int v1 = (f << 1) + f;        /* 3f  */
    v1 = v1 + (v1 << 6);          /* *65 */
    v1 = v1 << 5;                 /* *32 */
    v1 = v1 - f;
    v1 = v1 + (v1 << 5);          /* *33 */
    v1 = v1 << 1;
    return v1 >> 9;
}

extern int fixedsin(int x)   /* @0x800ED424 */
{
    int base  = fastintsin(x >> 6);
    int deriv = fastintcos(x >> 6);
    int p = spch_poly(x & 0x3F);
    return base + (int)(((long long)(deriv >> 2) * (long long)p) >> 21);
}

extern int fixedcos(int x)   /* @0x800ED4A4 */
{
    int base  = fastintcos(x >> 6);
    int deriv = -fastintsin(x >> 6);
    int p = spch_poly(x & 0x3F);
    return base + (int)(((long long)(deriv >> 2) * (long long)p) >> 21);
}
