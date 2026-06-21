/* syslib/psx/libmath/FLTSIDF.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays, fresh NFS4.EXE.i64).
 *   obj FLTSIDF.obj ; libmath.lib.  __floatsidf @0x800EB7E4 (256 B) -- int -> IEEE-754 double (returned in the
 *   soft-float $v0:$v1 pair; we assemble lo=w[0], hi=w[1]).  Uses _dbl_shift_us.  IDA verbatim.
 */
extern "C" unsigned int *_dbl_shift_us(unsigned int *out, int dir, unsigned int w0, int w1, int count);

extern "C" double __floatsidf(int a1)   /* @0x800EB7E4 */
{
    union { double d; unsigned int w[2]; } u;
    unsigned int sign = 0;
    int          exp  = 1053;
    if (a1 == 0) { u.w[0] = 0; u.w[1] = 0; return u.d; }
    if (a1 < 0) { sign = 0x80000000; a1 = -a1; }
    for (; a1 <= 0xFFFFFF;   exp -= 4) a1 *= 16;
    for (; a1 <= 0x3FFFFFFF; --exp)    a1 *= 2;
    unsigned int sh[2];
    sh[1] = a1;
    sh[0] = 0;
    _dbl_shift_us(sh, 1, 0, a1, 10);
    u.w[1] = sh[1] & 0xFFEFFFFF | sign | (exp << 20);
    u.w[0] = sh[0];
    return u.d;
}
