/* syslib/psx/libgte/FGO_06.c -- RECONSTRUCTED from nfs4-f.exe.  NOT original source.
 *   obj libgte.lib(FGO_06.OBJ): RotMatrixZ -- post-rotate the matrix m about Z by angle r; row 2 untouched, rows 0/1 mixed
 *   by sin/cos in 4.12 fixed point.
 *
 *   HAND-WRITTEN PsyQ libgte SDK ASSEMBLY -- transcribed VERBATIM (blockmove / MSC02 / PATCH
 *   precedent).  It was never C, so it is NOT a C-matching target.  THREE independent proofs:
 *     (1) OBJECT-LEVEL (W51-A6, the decisive one): the COFF sibling of this exact library,
 *         PsyQ 4.3 `COFF/LIB/LIBGTE.A` member `fgo_06.o`, carries NO `gcc2_compiled.` marker
 *         and NO `.c` source-file record -- while its C-compiled neighbours (cor_01/02/03.o =
 *         csincos/ccos/csin, fog_01.o = SetFogNear) carry BOTH `gcc2_compiled.` and their
 *         `cor_0N.c` / `fog_01.c` names.  Assembled, never compiled.
 *     (2) CODEGEN SIGNATURE: 12x `multu` / 12x `mflo` / ZERO `mfhi` and ZERO `mult` in the
 *         whole body -- narrow UNSIGNED multiplies keeping only the low word.  gcc-2.7.2/2.8
 *         canonicalise every truncated 32-bit multiply to signed `mult`, and emit `multu` only
 *         for a true 64-bit widening multiply, which ALWAYS reads `mfhi`.  `multu` with no
 *         `mfhi` is unreachable from C.  Also: the packed table entry is read with ONE `lw`
 *         then split by `sll 16; sra 16` / `sra 16` where cc1 folds such halfword extraction
 *         into `lh`; and the register file is $t0-$t9 only (no callee-saved, no frame).
 *     (3) CROSS-PROJECT: the Rage Racer decomp (100%% complete, same PsyQ libgte, gcc-2.7.2)
 *         independently classified its byte-identical RotMatrix as HANDWRITTEN_ASM on exactly
 *         signature (2) -- src/main/PAL/lib/libgte/rotation_matrix.c.
 *
 *   Transcription conventions (ASM-pattern-catalog SS G): DOUBLE `.set noreorder` (TAB form turns
 *   maspsx's is_reorder OFF so it stops materialising branch-delay nops; SPACE form passes
 *   through to gnu-as), decimal immediates/displacements (maspsx parses base-10), operands
 *   comma-joined with no spaces (maspsx position-parses several ALU ops), and a closing TAB-form
 *   `.set reorder` -- gcc HOISTS file-scope asm above every function and maspsx tracks `.set`
 *   state LINEARLY, so a leaked `noreorder` would kill jal-delay nops for the WHOLE TU.
 *
 *   The `#else` host body is a behavioural placeholder only (never assembled on MIPS). */

extern const int rcossin_tbl[];   /* @0x80137D20 : 4096 x { short sin; short cos } (one circle) */

#if defined(__mips__)

/* @0x800F312C : RotMatrixZ -- verbatim SDK assembly. */
__asm__(
    "\t.set\tnoat\n"
    "\t.set\tnoreorder\n"   /* TAB form: maspsx is_reorder OFF */
    "\t.set noreorder\n"    /* SPACE form: passes through to gnu-as */
    "\t.globl RotMatrixZ\n"
    "RotMatrixZ:\n"
    "\taddu\t$15,$4,$0\n"
    "\taddu\t$2,$5,$0\n"
    "\tbgez\t$15,.L800F3170\n"
    "\tandi\t$25,$15,4095\n"
    "\tnegu\t$15,$15\n"
    "\tbgez\t$15,.L800F3148\n"
    "\tandi\t$15,$15,4095\n"
    ".L800F3148:\n"
    "\tsll\t$24,$15,2\n"
    "\tlui\t$25,%hi(rcossin_tbl)\n"
    "\taddu\t$25,$25,$24\n"
    "\tlw\t$25,%lo(rcossin_tbl)($25)\n"
    "\tnop\n"
    "\tsll\t$14,$25,16\n"
    "\tsra\t$14,$14,16\n"
    "\tnegu\t$9,$14\n"
    "\tj\t.L800F3190\n"
    "\tsra\t$8,$25,16\n"
    ".L800F3170:\n"
    "\tsll\t$24,$25,2\n"
    "\tlui\t$25,%hi(rcossin_tbl)\n"
    "\taddu\t$25,$25,$24\n"
    "\tlw\t$25,%lo(rcossin_tbl)($25)\n"
    "\tnop\n"
    "\tsll\t$24,$25,16\n"
    "\tsra\t$9,$24,16\n"
    "\tsra\t$8,$25,16\n"
    ".L800F3190:\n"
    "\tlh\t$10,0($5)\n"
    "\tlh\t$13,6($5)\n"
    "\t.word\t0x010A0019\n"   /* multu $t0, $t2 */
    "\tlh\t$11,2($5)\n"
    "\tlh\t$14,8($5)\n"
    "\tmflo\t$24\n"
    "\tlh\t$12,4($5)\n"
    "\tlh\t$15,10($5)\n"
    "\t.word\t0x012D0019\n"   /* multu $t1, $t5 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$25\n"
    "\tsubu\t$25,$24,$25\n"
    "\tsra\t$24,$25,12\n"
    "\t.word\t0x010B0019\n"   /* multu $t0, $t3 */
    "\tsh\t$24,0($5)\n"
    "\tnop\n"
    "\tmflo\t$24\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word\t0x012E0019\n"   /* multu $t1, $t6 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$25\n"
    "\tsubu\t$25,$24,$25\n"
    "\tsra\t$24,$25,12\n"
    "\t.word\t0x010C0019\n"   /* multu $t0, $t4 */
    "\tsh\t$24,2($5)\n"
    "\tnop\n"
    "\tmflo\t$24\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word\t0x012F0019\n"   /* multu $t1, $t7 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$25\n"
    "\tsubu\t$25,$24,$25\n"
    "\tsra\t$24,$25,12\n"
    "\t.word\t0x012A0019\n"   /* multu $t1, $t2 */
    "\tsh\t$24,4($5)\n"
    "\tnop\n"
    "\tmflo\t$24\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word\t0x010D0019\n"   /* multu $t0, $t5 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$25\n"
    "\taddu\t$25,$24,$25\n"
    "\tsra\t$24,$25,12\n"
    "\t.word\t0x012B0019\n"   /* multu $t1, $t3 */
    "\tsh\t$24,6($5)\n"
    "\tnop\n"
    "\tmflo\t$24\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word\t0x010E0019\n"   /* multu $t0, $t6 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$25\n"
    "\taddu\t$25,$24,$25\n"
    "\tsra\t$24,$25,12\n"
    "\t.word\t0x012C0019\n"   /* multu $t1, $t4 */
    "\tsh\t$24,8($5)\n"
    "\tnop\n"
    "\tmflo\t$24\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word\t0x010F0019\n"   /* multu $t0, $t7 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$25\n"
    "\taddu\t$25,$24,$25\n"
    "\tsra\t$24,$25,12\n"
    "\tsh\t$24,10($5)\n"
    "\tjr\t$31\n"
    "\tnop\n"
    "\t.set\treorder\n"
);

#else  /* host build: behavioural placeholder (never assembled on MIPS) */

extern void *RotMatrixZ(int r, void *m)
{
    (void)r;
    return m;
}

#endif
