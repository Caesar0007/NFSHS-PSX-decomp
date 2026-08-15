/* syslib/psx/libgte/FGO_01.c -- RECONSTRUCTED from nfs4-f.exe.  NOT original source.
 *   obj libgte.lib(FGO_01.OBJ): RotMatrix -- build a 3x3 rotation matrix from an SVECTOR of Euler angles (rx,ry,rz; one
 *   revolution = 0x1000), 4.12 fixed point, sin/cos from the packed _rsincos table.
 *
 *   HAND-WRITTEN PsyQ libgte SDK ASSEMBLY -- transcribed VERBATIM (blockmove / MSC02 / PATCH
 *   precedent).  It was never C, so it is NOT a C-matching target.  THREE independent proofs:
 *     (1) OBJECT-LEVEL (W51-A6, the decisive one): the COFF sibling of this exact library,
 *         PsyQ 4.3 `COFF/LIB/LIBGTE.A` member `fgo_01.o`, carries NO `gcc2_compiled.` marker
 *         and NO `.c` source-file record -- while its C-compiled neighbours (cor_01/02/03.o =
 *         csincos/ccos/csin, fog_01.o = SetFogNear) carry BOTH `gcc2_compiled.` and their
 *         `cor_0N.c` / `fog_01.c` names.  Assembled, never compiled.
 *     (2) CODEGEN SIGNATURE: 14x `multu` / 15x `mflo` / ZERO `mfhi` and ZERO `mult` in the
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

extern const int _rsincos[];   /* @0x80137D20 : 4096 x { short sin; short cos } (one circle) */

#if defined(__mips__)

/* @0x800F252C : RotMatrix -- verbatim SDK assembly. */
__asm__(
    "\t.set\tnoat\n"
    "\t.set\tnoreorder\n"   /* TAB form: maspsx is_reorder OFF */
    "\t.set noreorder\n"    /* SPACE form: passes through to gnu-as */
    "\t.globl RotMatrix\n"
    "RotMatrix:\n"
    "\tlh\t$t7,0($a0)\n"
    "\taddu\t$v0,$a1,$zero\n"
    "\tbgez\t$t7,.L800F2570\n"
    "\tandi\t$t9,$t7,4095\n"
    "\tnegu\t$t7,$t7\n"
    "\tbgez\t$t7,.L800F2548\n"
    "\tandi\t$t7,$t7,4095\n"
    ".L800F2548:\n"
    "\tsll\t$t8,$t7,2\n"
    "\tlui\t$t9,%hi(_rsincos)\n"
    "\taddu\t$t9,$t9,$t8\n"
    "\tlw\t$t9,%lo(_rsincos)($t9)\n"
    "\tnop\n"
    "\tsll\t$t8,$t9,16\n"
    "\tsra\t$t8,$t8,16\n"
    "\tnegu\t$t3,$t8\n"
    "\tj\t.L800F2590\n"
    "\tsra\t$t0,$t9,16\n"
    ".L800F2570:\n"
    "\tsll\t$t8,$t9,2\n"
    "\tlui\t$t9,%hi(_rsincos)\n"
    "\taddu\t$t9,$t9,$t8\n"
    "\tlw\t$t9,%lo(_rsincos)($t9)\n"
    "\tnop\n"
    "\tsll\t$t8,$t9,16\n"
    "\tsra\t$t3,$t8,16\n"
    "\tsra\t$t0,$t9,16\n"
    ".L800F2590:\n"
    "\tlh\t$t7,2($a0)\n"
    "\tnop\n"
    "\tbgez\t$t7,.L800F25D4\n"
    "\tandi\t$t9,$t7,4095\n"
    "\tnegu\t$t7,$t7\n"
    "\tbgez\t$t7,.L800F25AC\n"
    "\tandi\t$t7,$t7,4095\n"
    ".L800F25AC:\n"
    "\tsll\t$t8,$t7,2\n"
    "\tlui\t$t9,%hi(_rsincos)\n"
    "\taddu\t$t9,$t9,$t8\n"
    "\tlw\t$t9,%lo(_rsincos)($t9)\n"
    "\tnop\n"
    "\tsll\t$t4,$t9,16\n"
    "\tsra\t$t4,$t4,16\n"
    "\tnegu\t$t6,$t4\n"
    "\tj\t.L800F25F8\n"
    "\tsra\t$t1,$t9,16\n"
    ".L800F25D4:\n"
    "\tsll\t$t8,$t9,2\n"
    "\tlui\t$t9,%hi(_rsincos)\n"
    "\taddu\t$t9,$t9,$t8\n"
    "\tlw\t$t9,%lo(_rsincos)($t9)\n"
    "\tnop\n"
    "\tsll\t$t6,$t9,16\n"
    "\tsra\t$t6,$t6,16\n"
    "\tnegu\t$t4,$t6\n"
    "\tsra\t$t1,$t9,16\n"
    ".L800F25F8:\n"
    "\t.word\t0x012B0019\n"   /* multu $t1, $t3 */
    "\tlh\t$t7,4($a0)\n"
    "\tsh\t$t6,4($a1)\n"
    "\tmflo\t$t8\n"
    "\tnegu\t$t9,$t8\n"
    "\tsra\t$t6,$t9,12\n"
    "\t.word\t0x01280019\n"   /* multu $t1, $t0 */
    "\tsh\t$t6,10($a1)\n"
    "\tbgez\t$t7,.L800F2660\n"
    "\tandi\t$t9,$t7,4095\n"
    "\tmflo\t$t8\n"
    "\tsra\t$t6,$t8,12\n"
    "\tsh\t$t6,16($a1)\n"
    "\tnegu\t$t7,$t7\n"
    "\tbgez\t$t7,.L800F2638\n"
    "\tandi\t$t7,$t7,4095\n"
    ".L800F2638:\n"
    "\tsll\t$t8,$t7,2\n"
    "\tlui\t$t9,%hi(_rsincos)\n"
    "\taddu\t$t9,$t9,$t8\n"
    "\tlw\t$t9,%lo(_rsincos)($t9)\n"
    "\tnop\n"
    "\tsll\t$t8,$t9,16\n"
    "\tsra\t$t8,$t8,16\n"
    "\tnegu\t$t5,$t8\n"
    "\tj\t.L800F268C\n"
    "\tsra\t$t2,$t9,16\n"
    ".L800F2660:\n"
    "\tmflo\t$t7\n"
    "\tsra\t$t6,$t7,12\n"
    "\tsh\t$t6,16($a1)\n"
    "\tsll\t$t8,$t9,2\n"
    "\tlui\t$t9,%hi(_rsincos)\n"
    "\taddu\t$t9,$t9,$t8\n"
    "\tlw\t$t9,%lo(_rsincos)($t9)\n"
    "\tnop\n"
    "\tsll\t$t8,$t9,16\n"
    "\tsra\t$t5,$t8,16\n"
    "\tsra\t$t2,$t9,16\n"
    ".L800F268C:\n"
    "\t.word\t0x01490019\n"   /* multu $t2, $t1 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$t7\n"
    "\tsra\t$t6,$t7,12\n"
    "\tsh\t$t6,0($a1)\n"
    "\t.word\t0x01A90019\n"   /* multu $t5, $t1 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$t7\n"
    "\tnegu\t$t6,$t7\n"
    "\tsra\t$t7,$t6,12\n"
    "\t.word\t0x014C0019\n"   /* multu $t2, $t4 */
    "\tsh\t$t7,2($a1)\n"
    "\tnop\n"
    "\tmflo\t$t7\n"
    "\tsra\t$t8,$t7,12\n"
    "\tnop\n"
    "\t.word\t0x030B0019\n"   /* multu $t8, $t3 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$t7\n"
    "\tsra\t$t6,$t7,12\n"
    "\tnop\n"
    "\t.word\t0x01A80019\n"   /* multu $t5, $t0 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$t7\n"
    "\tsra\t$t9,$t7,12\n"
    "\tsubu\t$t7,$t9,$t6\n"
    "\t.word\t0x03080019\n"   /* multu $t8, $t0 */
    "\tsh\t$t7,6($a1)\n"
    "\tnop\n"
    "\tmflo\t$t6\n"
    "\tsra\t$t7,$t6,12\n"
    "\tnop\n"
    "\t.word\t0x01AB0019\n"   /* multu $t5, $t3 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$t6\n"
    "\tsra\t$t9,$t6,12\n"
    "\taddu\t$t6,$t9,$t7\n"
    "\t.word\t0x01AC0019\n"   /* multu $t5, $t4 */
    "\tsh\t$t6,12($a1)\n"
    "\tnop\n"
    "\tmflo\t$t7\n"
    "\tsra\t$t8,$t7,12\n"
    "\tnop\n"
    "\t.word\t0x030B0019\n"   /* multu $t8, $t3 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$t7\n"
    "\tsra\t$t6,$t7,12\n"
    "\tnop\n"
    "\t.word\t0x01480019\n"   /* multu $t2, $t0 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$t7\n"
    "\tsra\t$t9,$t7,12\n"
    "\taddu\t$t7,$t9,$t6\n"
    "\t.word\t0x03080019\n"   /* multu $t8, $t0 */
    "\tsh\t$t7,8($a1)\n"
    "\tnop\n"
    "\tmflo\t$t6\n"
    "\tsra\t$t7,$t6,12\n"
    "\tnop\n"
    "\t.word\t0x014B0019\n"   /* multu $t2, $t3 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$t6\n"
    "\tsra\t$t9,$t6,12\n"
    "\tsubu\t$t6,$t9,$t7\n"
    "\tsh\t$t6,14($a1)\n"
    "\tjr\t$ra\n"
    "\tnop\n"
    "\t.set\treorder\n"
);

#else  /* host build: behavioural placeholder (never assembled on MIPS) */

extern void *RotMatrix(void *r, void *m)
{
    short *ms = (short *)m;
    int i;
    (void)r;
    for (i = 0; i < 9; i++) ms[i] = (i % 4 == 0) ? 4096 : 0;   /* identity */
    return m;
}

#endif
