/* eaclib/psx/eacpsxz/crossprd.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\crossprd.obj (EACPSXZ.LIB).  1 fn @0x800EAAE4 : crossproduct.
 *   FULL reconstruction (disasm-v3 MIPS); NOT a stub.  Standard 3D cross product in 16.16 fixed
 *   point (each component product via fixedmult).  out = a x b.  C-linkage.
 */
extern int fixedmult(int a, int b);              /* eacpsxz @0x800E4328 (16.16 multiply) */

extern int *crossproduct(int *a, int *b, int *out)   /* @0x800EAAE4 */
{
    /* out[1] keeps its subtrahend in an explicit temp so gcc-2.8.0 evaluates the
     * subtrahend FIRST (oracle: result lands in $v0, `subu v0,v0,s0`); out[0]/out[2]
     * keep the bare form (result in $s0).  The oracle's `addu v0,s3,zero` before the
     * final store is the RETURN-VALUE setup -- this fn RETURNS `out` (in $v0), it is
     * NOT void (void->non-void discriminator: a dead-base copy to $v0 at the epilogue
     * = the return value, §3.2). */
    out[0] = fixedmult(a[1], b[2]) - fixedmult(a[2], b[1]);
    { int t = fixedmult(a[0], b[2]); out[1] = fixedmult(a[2], b[0]) - t; }
    out[2] = fixedmult(a[0], b[1]) - fixedmult(a[1], b[0]);
    return out;
}
