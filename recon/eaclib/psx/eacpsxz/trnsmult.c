/* W52-A7 GCC-LADDER RECEIPT (2026-08-09) -- THE COMPILER-VERSION AXIS IS CLOSED FOR eacpsxz.
 * Every residual in this TU was A/B'd across the FULL windows-gcc-psx ladder on UNCHANGED
 * source, on BOTH axes:
 *   (a) ladder lane  NFS4_FORCE_CC1_ALT=<ver>  (272 recipe: macro cc1 + direct GNU-as reorder,
 *       NO maspsx) -- changes compiler AND assembler route at once; and
 *   (b) VERSION-ONLY axis  NFS4_CC1=<ladder>/cc1.exe  (normal compile_c, maspsx KEPT) -- the
 *       clean single-variable experiment.  Use (b) to read a version verdict; (a) confounds.
 * WHOLE-CLUSTER TOTALS, 68 TUs / 244 fns, version-only axis:
 *   default(psq43 CC1PSX)  232 PASS / 173 diffs   <-- the wired lane, WINS
 *   ladder 2.8.0           232 PASS / 173 diffs   <-- BIT-IDENTICAL to psq43 CC1PSX on all 244
 *   ladder 2.8.1           232 PASS / 172 diffs   (+1 F->P nsync, -1 P->F nfile FILE_operror)
 *   2.7.2-970404            61 PASS / 2422        2.7.2  51 / 5855   (SN 2.7.2 == FSF 2.7.2,
 *   2.6.0 / 2.6.3           50 PASS / ~4925        verified via the ladder lane)
 *   2.91.66 92 / 6832       2.95.2 95 / 6881
 * ==> eacpsxz's compiler IS gcc 2.8.0 -- the rung already wired.  NO rung beats it.  Any
 * residual in this file that a prior wave routed to "the toolchain-identity / old-gcc-cse /
 * allocno_compare-delta investigation" is hereby FALSIFIED on the VERSION axis: it is not a
 * gcc-version question.  Remaining candidate axes: per-obj FLAGS (3.25-3d), the assembler
 * route, or source.  Do NOT re-run the ladder on this TU.
 * PER-FN LADDER NUMBERS (version-only axis; 'P' = PASS):
 *   transmult      def 31 | 2.6.0 104 | 2.6.3 104 | 2.7.2-970404 45 | 2.7.2 93 | 2.8.1 31 | 2.91.66 101 | 2.95.2 138
 */
/* MATCH (w51-a8, 2026-08-09) -- the "NAMED NEXT LEVER" below (a cse/copy-prop
 * defeater for a spilled pointer param that is NOT a scheduling barrier) was hunted
 * again and is still UNFOUND; recording what was ruled out so it is not re-derived:
 *   - The residual is NOT the reload itself.  Our build ALREADY emits retail's
 *     `lw <r>,0x68(sp)` param-home reload at both sites; the diff is (a) WHICH
 *     register the reload lands in (ours $a3, retail $v1) and (b) that retail then
 *     mutates it IN PLACE (`addu v1,v1,s7; sw v1,0x38(sp)`) while ours writes a fresh
 *     dest (`addu v0,a3,s7`).  That is reload-register INHERITANCE (choose_reload_regs),
 *     downstream of allocation -- the same verdict the w47 flag sweep reached
 *     (`-fno-schedule-insns2` buys exact 81/81 parity but leaves the reload shape).
 *   - The in-place-dead-pointer-mutate lever (methodology 3.12 #14) cannot reach it:
 *     the value being mutated is a RELOAD temp with no source-level name; the only
 *     names available (`a`, an `ap` carrier) are exactly the two forms already
 *     falsified below (carrier without a fence copy-props away; with a fence the
 *     barrier costs the two load-delay fills).
 * ==> no new device; kept at 31.  A genuine non-barrier value-numbering breaker would
 * have to be a new `asm` flavour (an operand-less UNSPEC-like marker cc1-2.8 does not
 * have) or a maspsx/cc1-side change.
 */
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

/* w53-a10 2026-08-09 -- THE RAGE-RACER MINING ANGLE IS FALSIFIED (recorded so it is not re-tried).
 * The W53 briefing named C:/Temp/rage-racer-decomp/src/main/PAL/lib/libgte as carrying "matched
 * MulMatrix-family C" to compare this function's loop/temp structure against.  It does not: every
 * matrix routine there is INCLUDE_ASM / HANDWRITTEN_ASM and explicitly excluded from RR's progress
 * -- multiply_matrix.c (MulMatrix), multiply_matrix_2.c (MulMatrix2), matrix_stack.c
 * (CompMatrix/MulMatrix0/MulRotMatrix/SetMulMatrix/...), rotation_matrix.c and scale_matrix.c are
 * all one-line INCLUDE_ASM stubs carrying a "gcc 2.6.3 cannot reproduce this from C" note.  The
 * matched C in that directory (apply_matrix, geometry_math, geo_00, register_access, set_matrices,
 * leading_zero_count) is GTE/COP2 macro code with no fixedmult-style scalar accumulate loop.  So
 * there is no sibling body to mine for this function -- and in any case the residual here is not
 * loop/temp SHAPE (the shape has already been byte-exact at 81/81 in two separate basins); it is
 * reload-register round-robin, which no source corpus can supply.  Kept at 31. */
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
     * 🔴 w49-a8 2026-08-08 -- THE COUNT HALF OF THAT VERDICT IS REFUTED; THE COLORING HALF STANDS.
     * The w47 OPACITY FENCE (`__asm__("" : "=r"(x) : "0"(x))`, a ZERO-INSN value-numbering
     * barrier) placed BETWEEN the two pa[] computations DOES break reload inheritance:
     *     pa[0] = (int *)((char *)a + i1);
     *     __asm__("" : "=r"(a) : "0"(a));
     *     pa[1] = (int *)((char *)a + i2);
     * gates INSTRUCTION-EXACT 81/81 -- i.e. the three 'not source-addressable' instructions (the
     * un-inherited `lw v1,0x68(sp)` + its two load-delay nops) ARE recoverable from C, because the
     * fence gives `a` a fresh def that choose_reload_regs cannot inherit across.  What it does NOT
     * fix is the register ROLES: the whole callee-saved band rotates and it gates 100.  Variants
     * measured the same session (none better than the kept 31): fence BEFORE both pa[] stores 112
     * (81/81), fence AFTER both 100 (81/81), a separate `int *a2 = a;` carrier + fence 33 (80/81),
     * carrier fence FIRST 32 (79/81), reversed pa store order + fence 101 (82/81), operand-swapped
     * `i2 + (char *)a` + fence 100 (81/81), and the plain w48 void fence `__asm__("" : : "i"(0))`
     * between them 32 (79/81 -- barrier only, no value-numbering effect, so no extra insn).
     * ==> RE-CLASSIFIED: this is NOT 'reload inheritance is unreachable'.  It is reload inheritance
     * (reachable, above) PLUS an allocno rotation that has to be solved at the same time.  The
     * next attack is reqdelta/allocsim on the 81/81 fence basin -- solve the band there, not here;
     * do NOT restart the 20-form spelling sweep, which was run against the 78-insn basin.
     * w50-a8 2026-08-09 -- THE 81/81 FENCE BASIN'S BAND IS NOT DIALABLE; ITS ROTATION IS
     * STRUCTURAL, so that hand-off is closed.  Reading the two basins side by side settles it:
     * retail's `a` pseudo gets NO hard register (it is spilled to its param home 0x68(sp) and
     * RELOADED twice per row) while a SEPARATE giv walks `a[i]` (`addiu s6,s6,12` in the outer
     * back-edge slot).  An opacity fence whose operand IS `a` forces `a` into a hard register by
     * construction ("=r"), which (a) kills that giv -- ours then spends `sll v0,s5,2; addu s7,v0,s6`
     * per row -- and (b) evicts i2 to $a3 plus a stack spill, growing the frame to 112 vs retail's
     * 104.  Adding an explicit `aw` walker for `a[i]` does NOT recover it (100, byte-identical to
     * the plain fence).  So the fence basin cannot host retail's allocation at all.
     * TWO NEW BASINS, both with the ENTIRE register band byte-correct (prologue 0-17 identical,
     * s0=acc s1=j s2=b s3=j1 s4=j2 s5=i s6=a-walker s7=i1 fp=i2 -- i.e. strictly better SHAPE than
     * the 100-diff fence basin), neither landed because neither beats the kept 31:
     *   W2 = a named `va = *pa[k];` value temp + a w45 USE FENCE on it, per inner call:
     *        32 diffs at COUNT-EXACT 81/81.  Residual = the reload-register round-robin
     *        (ours `lw a3,0x6C(sp)`, retail `lw v1,0x6C(sp)`) + the acc-accumulate position.
     *   Z1 = an `ap` CARRIER opacity-fenced (the fence redefines the CARRIER, never `a`, so the
     *        giv survives): `ap = a; asm("":"=r"(ap):"0"(ap)); ap += i1; pa[0] = ap;` twice.
     *        34 at 81/81, and it reproduces retail's DOUBLE `lw ...,0x68(sp)` with the in-place
     *        `addu v1,v1,s7` -- i.e. the reload-inheritance half IS source-reachable.
     *        Its cost is the fence's BARRIER: retail fills the two load-delay slots with the inner
     *        `li s4,24 / li s3,12` inits, and no insn may cross the fence, so we pay 2 nops.
     * ==> the two halves are mutually exclusive under any barrier-carrying device.  NAMED NEXT
     * LEVER (same gap w47-a1's reservehandle receipt names): a copy-prop/cse-defeating device for
     * a spilled pointer param that is NOT a scheduling barrier.
     * Also falsified this wave (all vs 31): plain use fence between the pa[] stores 32 (79/81) |
     * opacity fence on i2 58 | `pt = a` carrier without a fence 31 (copy-prop folds it) | operand
     * swap `(int *)(i1 + (char *)a)` 31 | explicit `aw` walker alone 41 | `__asm__("":: "m"(a))`
     * memory fence 47, with W2 46, as an "=m" pair 49, after both stores 48 | W2 + any of the
     * above header fences 33-99 | carrier + W2 34-35 | the inner inits moved between the two pa
     * computations 32 | a single carried read (first or second only) 32-33.
     * Shape levers that DID land the 107->31: flat-index outer i BY 3, guard i<9 (oracle slti s5,9); SEPARATE
     * byte-offset walkers i1/i2 (a row elems, step 12) + j1/j2 (b column walk, step 4) =
     * independent variables so no combine_givs base-fold; the two a-element pointers live in
     * a POINTER ARRAY pa[2] (memory by construction -- the temp[] stores alias-block hoisting,
     * so they reload per inner iter at sp+0x38/0x3C like the oracle) which frees exactly the
     * two callee regs i1/i2 need; decl/init order i2-before-i1, j2-before-j1 puts i2->fp,
     * i1->s7, j2->s4, j1->s3; progressive acc (+= per call) avoids a park reg; NO explicit
     * return -- $v0 after blockmove is incidental (oracle writes no v0). */
    /* MATCH (w58, 31->29): IDA's retail register annotation order is significant here: the inner
     * counter and its two byte-offset walkers are initialized before the pa[] address materialization.
     * Spelling j's initialization as a separate statement at that boundary makes sched1 place
     * `addu s1,zero,zero` at retail's exact slot, without changing code size or the saved-register
     * allocation.  The remaining 29-diff floor is still the single inherited a-param reload and the
     * two inherited b-param reload/load-delay pairs documented above. */
    i = 0;
    i2 = 8;
    i1 = 4;
    for (; i < 9; i += 3) {
        j = 0;
        j2 = 24;
        j1 = 12;
        pa[0] = (int *)((char *)a + i1);
        pa[1] = (int *)((char *)a + i2);
        for (; j < 3; j++) {
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
