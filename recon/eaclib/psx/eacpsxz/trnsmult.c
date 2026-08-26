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

/* 🏆🏆 SEALED 2026-08-27 -- PASS 81/81, frame 104 == SYM fsize, with THREE HONEST
   POINTER PARAMETERS and ZERO devices (no asm, no volatile, no by-value aggregate).
   Everything below this note that calls the residual a "STRONG floor" is SUPERSEDED;
   it is kept only for its falsification lists.

   HOW IT FELL.  The gap was always the same 3 instructions: retail reloads `a`
   from its parameter home TWICE and consumes each reload IN PLACE
   (`lw v1,104(sp); addu v1,v1,s7`), while ours reloaded once and added into a
   fresh destination, so choose_reload_regs inherited the register for the second
   element.  The long-standing reading -- "the by-value aggregate works because it
   puts the parameter in MEMORY" -- was only half the chain.  The dumps show the
   rest:

     * an aggregate parameter is stored to its home and has NO pseudo, so
       `args.left` is a MEM read;  a scalar parameter becomes ONE pseudo carrying
       REG_EQUIV to that home.  (Verified in -dr: `(set (mem/s:SI ...) (reg a0))`
       vs `(set (reg/v:SI 80) (reg a0))`.)
     * BUT the decisive consequence is downstream: with the aggregate, the value
       feeding pa[] belongs to a MULTI-BLOCK carrier that goes to global-alloc and
       LOSES, so its defining add is a reload and can reuse the dying input reload
       register.  With three scalars the same value was a BLOCK-LOCAL quantity --
       `Register 91 used 4 times across 2 insns in block 1` -- and local-alloc
       always finds such a quantity a free $v0.  That register, not the parameter's
       storage class, is what blocked the in-place consume.

   THE LEVER (derived from that, not guessed): give the two row pointers
   FUNCTION-SCOPE carriers `c0`/`c1` that are read INSIDE the inner loop, i.e.
   AFTER a fixedmult call.  They then cross calls, need a callee-saved register,
   find none free (s0-s7 + fp are all held by the band) and spill -- exactly the
   aggregate's situation, reached with ordinary C.  Their defining adds become
   reloads, consume in place, and the second `lw ...,104(sp)` appears.  The `pa[2]`
   array is no longer needed and is gone.
   ⚠️ It must be BOTH carriers and they must be read in the inner loop: carrying
   only pa[0] measures 98 @81 with the frame blown to 112, and keeping the pa[]
   array alongside the carriers collapses back to 23 (cse folds the carriers into
   the array reads).  Function-scope carriers that are pre-initialised (`c0 = 0;`)
   also fall back to 23.

*/
/* PARAM TYPE: `int *`, matching every sibling in this cluster -- transpose(int*,
   int*), addmatrix / submatrix / scalematrix(int*,int*,int*), reorthogonalize(int*)
   -- and matching what the call sites pass (`mtx.m`, i.e. int[9], with no casts).
   MEASURED IRRELEVANT to the match: int* / void* / char* parameters all reach the
   same PASS 81/81 at frame 104, because the byte-stepping walkers do the work
   either way.  So this is purely a readability/consistency choice and int* wins it.
   (`char *` would additionally be wrong-ish: int*->char* needs a diagnostic in C89
   and no call site carries a cast.)
   ⚠️ The BYTE units are NOT a style question -- they keep i1/i2 and the index i at
   DIFFERENT scales so combine_givs cannot fold the walkers into one base.  Int-unit
   walkers cost 4 instructions per converted side (81 -> 77 -> 73). */
extern void transmult(int *a, int *b, int *out) /* @0x80105F40 */
{
    int *c0, *c1;
    int temp[9];
    int i, i1, i2;

    for (i = 0, i2 = 8, i1 = 4; i < 9; i2 += 12, i1 += 12, i += 3) {
        int j, j1, j2;

        c0 = (int *)((char *)a + i1);
        c1 = (int *)((char *)a + i2);

        for(j = 0, j2 = 24, j1 = 12; j < 3; j2 += 4, j1 += 4, j++) {
            int acc;
            acc  = fixedmult(a[i], b[j]);
            acc += fixedmult(*c0, *(int *)((char *)b + j1));
            acc += fixedmult(*c1, *(int *)((char *)b + j2));
            temp[i + j] = acc;
        }
    }

    blockmove(temp, out, sizeof(int) * 9);                  /* 9 ints -> output (alias-safe) */
}
