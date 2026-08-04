/* syslib/psx/libmath/FLTSIDF.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays, fresh NFS4.EXE.i64).
 *   obj FLTSIDF.obj ; libmath.lib.  __floatsidf @0x800EB7E4 (256 B) -- int -> IEEE-754 double (returned in the
 *   w48-a8: 50 -> 8 diffs (count-exact 64/64) by giving _dbl_shift_us its TRUE arguments (R3:
 *   the oracle re-LOADS both value args out of the sh[] array rather than reusing 0/a1) and
 *   storing the masked hi word back into sh[1].  Residual 8 = two register-identity ties:
 *   (a) the a1==0 early return -- cse hands gcc `sign`'s already-materialized 0 ($s3) where the
 *   oracle re-uses $zero (moving `sign = 0` below the test measures WORSE, 12); (b) the final
 *   `sh[1]|sign|(exp<<20)` or-chain stages through $a0 where the oracle accumulates in place in
 *   $s1 (a named in-place `hi` local measures WORSE, 16).  Both basin-relative -- re-test.
 *   soft-float $v0:$v1 pair; we assemble lo=w[0], hi=w[1]).  Uses _dbl_shift_us.  IDA verbatim.
 */
unsigned int *_dbl_shift_us(unsigned int *out, int dir, unsigned int w0, int w1, int count);

double __floatsidf(int a1)   /* @0x800EB7E4 */
{
    union { double d; unsigned int w[2]; } u;
    unsigned int sign = 0;
    int          exp  = 1053;
    unsigned int sh[2];
    if (a1 == 0) { u.w[0] = 0; u.w[1] = 0; return u.d; }
    if (a1 < 0) { sign = 0x80000000; a1 = -a1; }
    for (; a1 <= 0xFFFFFF;   exp -= 4) a1 *= 16;
    for (; a1 <= 0x3FFFFFFF; --exp)    a1 *= 2;
    sh[1] = a1;
    sh[0] = 0;
    /* w48-a8 (R3, args-vs-oracle): the oracle LOADS both value args back out of the array
     * (`lw $a2,0x18($sp); lw $a3,0x1C($sp)`), it does not re-use the 0 / a1 registers. */
    _dbl_shift_us(sh, 1, sh[0], sh[1], 10);
    sh[1] = sh[1] & 0xFFEFFFFF;   /* oracle stores the masked hi BACK into sh[1] */
    u.w[1] = sh[1] | sign | (exp << 20);
    u.w[0] = sh[0];
    return u.d;
}
