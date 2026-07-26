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
    /* MATCH (107->31; residual = pure instruction-ORDER/scratch-serialization: the oracle .obj shows
     * unscheduled reload output -- serial single-$v1 reloads with unfillable load-delay nops -- not
     * reachable under the gate's fixed -O2+sched flags.  w33-a4 pinned the 3-insn gap EXACTLY: it is
     * (a) ONE extra `lw v1,0x68(sp)` -- retail reloads the `a` param from its home slot for BOTH
     * pa[] elements and consumes it IN PLACE (`addu v1,v1,s7`), so reload cannot inherit; ours keeps
     * one copy in $a3 and adds into $v0 -- plus (b) the two `lw pa[k]; nop; lw a0,0(v1)` load-delay
     * nops our sched1 fills by interleaving the `b` reload.  Flag measurements (scratch cc1, NOT
     * applied): -fno-schedule-insns alone = still 78; -fno-schedule-insns2 = exact 81/81 but the
     * prologue `sw sN`/`init sN` interleave (which retail HAS) is lost, so neither flag alone is
     * retail's build.  Source-side attempts that do NOT move it: `int *volatile pa[2]`,
     * `volatile int *pa[2]` (31 both).  Per-obj toolchain identity, methodology 3.25-3d / W30 rule 6.
     * SLD is unavailable here (eaclib .lib C members are debug-stripped: 0 records in 800E0000+).
     * ------------------------------------------------------------------------------------------
     * w34-a4 2026-07-26 -- THE MECHANISM IS NOW NAMED AND PROVEN (still 31; do not re-fight).
     * ALL 31 diffs are ONE root cause, not three: retail reloads `a` (sp+0x68) and `b` (sp+0x6C)
     * SERIALLY THROUGH $v1 and consumes the reload IN PLACE (`lw v1,0x68(sp); addu v1,v1,s7; sw
     * v1,0x38(sp)` twice), while ours loads once into $a3 and adds to a separate dest (`lw a3,...;
     * addu v0,a3,s7`).  Ours' single load is gcc RELOAD INHERITANCE: because our `addu` writes a
     * DIFFERENT register, $a3 still holds `a` at the 2nd use and choose_reload_regs reuses it; the
     * missing 3 instructions and both load-delay `nop`s (which our sched2 fills with the independent
     * `b` reload) follow from that one decision.  PROOF (A/B, not inference): declaring the params
     * `int * volatile a, int * volatile b` makes every read a MEM operand instead of a spilled
     * pseudo, and cc1 then emits retail's shape EXACTLY -- two `lw`s, in-place `addu v0,v0,s7`,
     * serial single-scratch reloads, the same nops.  So retail's `a`/`b` behaved as MEM operands,
     * ours behave as spilled pseudos; the residual is reload's inheritance + reload-register
     * ROUND-ROBIN ($v1 vs $a3 -- `allocate_reload_reg` starts at `last_spill_reg+1`), neither of
     * which is source-addressable.  The volatile form is NOT kept: it costs the prologue's
     * `addu s6,a0,zero` (becomes `lw s6,0x68(sp)`) and lands at 42-44 diffs / 79 insns.
     * FALSIFIED this session (all measured with verify_asm, none better than 31): `int **va = &a`
     * address-taken (100, and it kills the a[i] strength-reduction), `*(int * volatile *)&a` (31 --
     * gcc folds `*&x` through the cast, so the qualifier never reaches the MEM), `&a[i+1]`/`&a[i+2]`
     * index form (41), a[i] via `(char*)a + (i1>>2)` (35), `pa[3]` (85), block-scoped temps (31),
     * swapped pa store order (31), `pa[0]=a; pa[0]+=i1` in-place (31), `ac[0]=a` memory-array holder
     * (85), `b[j+3]/b[j+6]` index form (79), explicit `bw` b-walker (53), named `bv` b-element temps
     * (31), `acc = acc + ...` vs `+=` (31), do-while loops (31), `void` return (31), and IDA's
     * literal shape from sub_80105F40 (two plain `int *` locals + `&a1[v5]` index givs: 109/66 insns
     * -- gcc hoists pa0/pa1 into walkers, which is exactly what the `int *pa[2]` array prevents;
     * IDA's own asm shows retail storing them to sp+0x38/0x3C every row, so the array IS the right
     * shape and IDA's two-locals rendering is a decompiler view, not the source).
     * PERMUTER: 445 iterations, 35 candidates gate-tested one by one -- best 33, i.e. the scorer and
     * verify_asm are ANTI-correlated here (permuter base 630 = 31 gate diffs; its "best" 410 = 33).
     * Flag matrix (scratch, none adopted): -fno-schedule-insns 37 (78 insns) | -fno-schedule-insns2
     * 52 (81/81 EXACT parity but the a3 shape is unchanged, proving it is reload, not scheduling) |
     * both 58 | -mno-split-addresses 31 | -fno-expensive-optimizations 31 | -fno-delayed-branch 51.
     * w35-a6 2026-07-26: the A/B control was re-run PER PARAMETER (the w34 note only measured both
     * params volatile at once, and its recorded "42-44 diffs / 79 insns" figure is STALE against the
     * current base -- do not quote it).  Fresh: `int * volatile a` alone 49 (78/81), `int * volatile b`
     * alone 78 (79/81), both 85 (80/81).  So the MEM-operand shape is not separable per parameter and
     * every variant is far worse than 31; the volatile A/B remains a DIAGNOSTIC that names the
     * mechanism (reload inheritance + reload-register round-robin), never a candidate fix.  The count
     * gap stays exactly 3 = the one un-inherited `lw v1,0x68(sp)` plus its two load-delay nops.
     * VERDICT: STRONG floor (>=20 alternate source forms byte-identical or worse, mechanism named,
     * A/B-proven). Reopen only with a reload-level toolchain lever.
     * Shape levers that DID land the 107->31: flat-index outer i BY 3, guard i<9 (oracle slti s5,9); SEPARATE
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
