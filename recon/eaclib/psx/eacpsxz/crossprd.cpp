/* eaclib/psx/eacpsxz/crossprd.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\crossprd.obj (EACPSXZ.LIB).  1 fn @0x800EAAE4 : crossproduct.
 *   FULL reconstruction (disasm-v3 MIPS); NOT a stub.  Standard 3D cross product in 16.16 fixed
 *   point (each component product via fixedmult).  out = a x b.  C-linkage.
 */
extern "C" int fixedmult(int a, int b);              /* eacpsxz @0x800E4328 (16.16 multiply) */

extern "C" void crossproduct(int *a, int *b, int *out)   /* @0x800EAAE4 */
{
    out[0] = fixedmult(a[1], b[2]) - fixedmult(a[2], b[1]);
    out[1] = fixedmult(a[2], b[0]) - fixedmult(a[0], b[2]);
    out[2] = fixedmult(a[0], b[1]) - fixedmult(a[1], b[0]);
}
