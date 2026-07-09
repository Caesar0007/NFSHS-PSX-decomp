/* eaclib/psx/eacpsxz/trnsfrm.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\trnsfrm.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   1 fn @0x800EAED8 (0x110 bytes): transform -- transform a 3-vector by a 3x3 (16.16) matrix.
 *   FULL reconstruction (disasm-v3 MIPS); NOT a stub.  C-linkage.  EA fixed-point math runtime.
 *
 *   out = vec (as a ROW) * M :  out[j] = sum_i vec[i] * M[i][j]  (M row-major, m[i*3+j]), via
 *   fixedmult (16.16).  The asm computes the 3 components into stack temps and writes them to `out`
 *   only at the end, so `out` may safely alias `vec` or `mat`.
 */
extern int fixedmult(int a, int b);                        /* eacpsxz @0x800E4328 (lbl_D4328) */

extern int *transform(int *vec, int *mat, int *out)        /* @0x800EAED8 */
{
    int o0, o1, o2;
    o0 = fixedmult(vec[0], mat[0]) + fixedmult(vec[1], mat[3]) + fixedmult(vec[2], mat[6]);
    o1 = fixedmult(vec[0], mat[1]) + fixedmult(vec[1], mat[4]) + fixedmult(vec[2], mat[7]);
    o2 = fixedmult(vec[0], mat[2]) + fixedmult(vec[1], mat[5]) + fixedmult(vec[2], mat[8]);
    out[0] = o0;
    out[1] = o1;
    out[2] = o2;
    return out;
}
