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
    "\taddu\t$t7,$a0,$zero\n"
    "\taddu\t$v0,$a1,$zero\n"
    "\tbgez\t$t7,.L800F3170\n"
    "\tandi\t$t9,$t7,4095\n"
    "\tnegu\t$t7,$t7\n"
    "\tbgez\t$t7,.L800F3148\n"
    "\tandi\t$t7,$t7,4095\n"
    ".L800F3148:\n"
    "\tsll\t$t8,$t7,2\n"
    "\tlui\t$t9,%hi(rcossin_tbl)\n"
    "\taddu\t$t9,$t9,$t8\n"
    "\tlw\t$t9,%lo(rcossin_tbl)($t9)\n"
    "\tnop\n"
    "\tsll\t$t6,$t9,16\n"
    "\tsra\t$t6,$t6,16\n"
    "\tnegu\t$t1,$t6\n"
    "\tj\t.L800F3190\n"
    "\tsra\t$t0,$t9,16\n"
    ".L800F3170:\n"
    "\tsll\t$t8,$t9,2\n"
    "\tlui\t$t9,%hi(rcossin_tbl)\n"
    "\taddu\t$t9,$t9,$t8\n"
    "\tlw\t$t9,%lo(rcossin_tbl)($t9)\n"
    "\tnop\n"
    "\tsll\t$t8,$t9,16\n"
    "\tsra\t$t1,$t8,16\n"
    "\tsra\t$t0,$t9,16\n"
    ".L800F3190:\n"
    "\tlh\t$t2,0($a1)\n"
    "\tlh\t$t5,6($a1)\n"
    "\t.word\t0x010A0019\n"   /* multu $t0, $t2 */
    "\tlh\t$t3,2($a1)\n"
    "\tlh\t$t6,8($a1)\n"
    "\tmflo\t$t8\n"
    "\tlh\t$t4,4($a1)\n"
    "\tlh\t$t7,10($a1)\n"
    "\t.word\t0x012D0019\n"   /* multu $t1, $t5 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$t9\n"
    "\tsubu\t$t9,$t8,$t9\n"
    "\tsra\t$t8,$t9,12\n"
    "\t.word\t0x010B0019\n"   /* multu $t0, $t3 */
    "\tsh\t$t8,0($a1)\n"
    "\tnop\n"
    "\tmflo\t$t8\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word\t0x012E0019\n"   /* multu $t1, $t6 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$t9\n"
    "\tsubu\t$t9,$t8,$t9\n"
    "\tsra\t$t8,$t9,12\n"
    "\t.word\t0x010C0019\n"   /* multu $t0, $t4 */
    "\tsh\t$t8,2($a1)\n"
    "\tnop\n"
    "\tmflo\t$t8\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word\t0x012F0019\n"   /* multu $t1, $t7 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$t9\n"
    "\tsubu\t$t9,$t8,$t9\n"
    "\tsra\t$t8,$t9,12\n"
    "\t.word\t0x012A0019\n"   /* multu $t1, $t2 */
    "\tsh\t$t8,4($a1)\n"
    "\tnop\n"
    "\tmflo\t$t8\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word\t0x010D0019\n"   /* multu $t0, $t5 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$t9\n"
    "\taddu\t$t9,$t8,$t9\n"
    "\tsra\t$t8,$t9,12\n"
    "\t.word\t0x012B0019\n"   /* multu $t1, $t3 */
    "\tsh\t$t8,6($a1)\n"
    "\tnop\n"
    "\tmflo\t$t8\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word\t0x010E0019\n"   /* multu $t0, $t6 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$t9\n"
    "\taddu\t$t9,$t8,$t9\n"
    "\tsra\t$t8,$t9,12\n"
    "\t.word\t0x012C0019\n"   /* multu $t1, $t4 */
    "\tsh\t$t8,8($a1)\n"
    "\tnop\n"
    "\tmflo\t$t8\n"
    "\tnop\n"
    "\tnop\n"
    "\t.word\t0x010F0019\n"   /* multu $t0, $t7 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$t9\n"
    "\taddu\t$t9,$t8,$t9\n"
    "\tsra\t$t8,$t9,12\n"
    "\tsh\t$t8,10($a1)\n"
    "\tjr\t$ra\n"
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
