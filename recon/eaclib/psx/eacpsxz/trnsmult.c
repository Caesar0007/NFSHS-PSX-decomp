/* eaclib/psx/eacpsxz/trnsmult.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
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

extern int  fixedmult(int a, int b);                       /* eacpsxz @0x800E4328 (lbl_D4328) */
extern void blockmove(void *src, void *dst, int n);        /* eacpsxz @0x800E62DC (lbl_D62DC) */

extern int *transmult(int *a, int *b, int *out)            /* @0x80105F40 */
{
    int temp[9];
    int *pa[2];
    register int i, j;
    register int i2, i1;
    register int j2, j1;
    register int acc;
    /* MATCH (107->31; residual = pure instruction-ORDER/scratch-serialization: the oracle .obj shows unscheduled reload output -- serial single-v1 reloads with unfillable load-delay nops -- not reachable under the gate's fixed -O2+sched flags; with -fno-schedule-insns{,2} the insn COUNT is exact 81/81): flat-index outer i BY 3, guard i<9 (oracle slti s5,9); SEPARATE
     * byte-offset walkers i1/i2 (a row elems, step 12) + j1/j2 (b column walk, step 4) =
     * independent variables so no combine_givs base-fold; the two a-element pointers live in
     * a POINTER ARRAY pa[2] (memory by construction -- the temp[] stores alias-block hoisting,
     * so they reload per inner iter at sp+0x38/0x3C like the oracle) which frees exactly the
     * two callee regs i1/i2 need; decl/init order i2-before-i1, j2-before-j1 puts i2->fp,
     * i1->s7, j2->s4, j1->s3; progressive acc (+= per call) avoids a park reg; NO explicit
     * return -- $v0 after blockmove is incidental (oracle writes no v0). */
    i = 0;
    i2 = 8;
    i1 = 4;
    for (; i < 9; i += 3) {
        pa[0] = (int *)((char *)a + i1);
        pa[1] = (int *)((char *)a + i2);
        j2 = 24;
        j1 = 12;
        for (j = 0; j < 3; j++) {
            acc  = fixedmult(a[i], b[j]);
            acc += fixedmult(*pa[0], *(int *)((char *)b + j1));
            acc += fixedmult(*pa[1], *(int *)((char *)b + j2));
            temp[i + j] = acc;
            j1 += 4;
            j2 += 4;
        }
        i2 += 12;
        i1 += 12;
    }
    blockmove(temp, out, 0x24);                                 /* 9 ints -> output (alias-safe) */
}
