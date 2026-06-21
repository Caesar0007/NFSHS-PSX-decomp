/* eaclib/psx/eacpsxz/trnsmult.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\trnsmult.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   1 fn @0x80105F40 (0x140 bytes): transmult -- 3x3 fixed-point (16.16) matrix multiply C = A * B.
 *   FULL reconstruction of the actual MIPS (disasm-v3); NOT a stub.  C-linkage.  EA SND/math runtime.
 *
 *   3x3 matrices are 9 ints row-major.  Each output element C[i][k] = sum_j A[i][j] * B[j][k] using
 *   fixedmult (16.16).  The binary computes into a 9-int stack scratch (sp+0x10) and then blockmove's
 *   0x24 (36) bytes to the caller's output -- so C may safely alias A or B.  (Name "transmult" is the
 *   EA obj name; the math is a plain A*B, with A read row-major and B read column-strided.)
 *
 *   asm structure: outer i=0..2 (row, A pointer s6 += 0xC, scratch index s5 += 3),
 *                  inner k=0..2 (column), three fixedmult+accumulate, store scratch[3*i+k].
 */

extern "C" int  fixedmult(int a, int b);                       /* eacpsxz @0x800E4328 (lbl_D4328) */
extern "C" void blockmove(void *src, void *dst, int n);        /* eacpsxz @0x800E62DC (lbl_D62DC) */

extern "C" int *transmult(int *a, int *b, int *out)            /* @0x80105F40 */
{
    int scratch[9];
    int i, k;
    for (i = 0; i < 3; i++) {
        for (k = 0; k < 3; k++) {
            int acc = fixedmult(a[i * 3 + 0], b[0 * 3 + k]);
            acc += fixedmult(a[i * 3 + 1], b[1 * 3 + k]);
            acc += fixedmult(a[i * 3 + 2], b[2 * 3 + k]);
            scratch[i * 3 + k] = acc;
        }
    }
    blockmove(scratch, out, 0x24);                              /* 9 ints -> output (alias-safe) */
    return out;
}
