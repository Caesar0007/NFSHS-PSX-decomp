/* syslib/psx/libgte/FGO_01.c -- RECONSTRUCTED from nfs4-f.exe.  NOT original source.
 *   obj libgte.lib(FGO_01.OBJ): RotMatrix -- build a 3x3 rotation matrix from an SVECTOR of Euler angles (rx,ry,rz; one
 *   revolution = 0x1000), 4.12 fixed point, sin/cos from the packed rcossin_tbl table.
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

extern const int rcossin_tbl[];   /* @0x80137D20 : 4096 x { short sin; short cos } (one circle) */

#if defined(__mips__)

/* @0x800F252C : RotMatrix -- verbatim SDK assembly. */
__asm__(
    "\t.set\tnoat\n"
    "\t.set\tnoreorder\n"   /* TAB form: maspsx is_reorder OFF */
    "\t.set noreorder\n"    /* SPACE form: passes through to gnu-as */
    "\t.globl RotMatrix\n"
    "RotMatrix:\n"
    "\tlh\t$15,0($4)\n"
    "\taddu\t$2,$5,$0\n"
    "\tbgez\t$15,.L800F2570\n"
    "\tandi\t$25,$15,4095\n"
    "\tnegu\t$15,$15\n"
    "\tbgez\t$15,.L800F2548\n"
    "\tandi\t$15,$15,4095\n"
    ".L800F2548:\n"
    "\tsll\t$24,$15,2\n"
    "\tlui\t$25,%hi(rcossin_tbl)\n"
    "\taddu\t$25,$25,$24\n"
    "\tlw\t$25,%lo(rcossin_tbl)($25)\n"
    "\tnop\n"
    "\tsll\t$24,$25,16\n"
    "\tsra\t$24,$24,16\n"
    "\tnegu\t$11,$24\n"
    "\tj\t.L800F2590\n"
    "\tsra\t$8,$25,16\n"
    ".L800F2570:\n"
    "\tsll\t$24,$25,2\n"
    "\tlui\t$25,%hi(rcossin_tbl)\n"
    "\taddu\t$25,$25,$24\n"
    "\tlw\t$25,%lo(rcossin_tbl)($25)\n"
    "\tnop\n"
    "\tsll\t$24,$25,16\n"
    "\tsra\t$11,$24,16\n"
    "\tsra\t$8,$25,16\n"
    ".L800F2590:\n"
    "\tlh\t$15,2($4)\n"
    "\tnop\n"
    "\tbgez\t$15,.L800F25D4\n"
    "\tandi\t$25,$15,4095\n"
    "\tnegu\t$15,$15\n"
    "\tbgez\t$15,.L800F25AC\n"
    "\tandi\t$15,$15,4095\n"
    ".L800F25AC:\n"
    "\tsll\t$24,$15,2\n"
    "\tlui\t$25,%hi(rcossin_tbl)\n"
    "\taddu\t$25,$25,$24\n"
    "\tlw\t$25,%lo(rcossin_tbl)($25)\n"
    "\tnop\n"
    "\tsll\t$12,$25,16\n"
    "\tsra\t$12,$12,16\n"
    "\tnegu\t$14,$12\n"
    "\tj\t.L800F25F8\n"
    "\tsra\t$9,$25,16\n"
    ".L800F25D4:\n"
    "\tsll\t$24,$25,2\n"
    "\tlui\t$25,%hi(rcossin_tbl)\n"
    "\taddu\t$25,$25,$24\n"
    "\tlw\t$25,%lo(rcossin_tbl)($25)\n"
    "\tnop\n"
    "\tsll\t$14,$25,16\n"
    "\tsra\t$14,$14,16\n"
    "\tnegu\t$12,$14\n"
    "\tsra\t$9,$25,16\n"
    ".L800F25F8:\n"
    "\t.word\t0x012B0019\n"   /* multu $t1, $t3 */
    "\tlh\t$15,4($4)\n"
    "\tsh\t$14,4($5)\n"
    "\tmflo\t$24\n"
    "\tnegu\t$25,$24\n"
    "\tsra\t$14,$25,12\n"
    "\t.word\t0x01280019\n"   /* multu $t1, $t0 */
    "\tsh\t$14,10($5)\n"
    "\tbgez\t$15,.L800F2660\n"
    "\tandi\t$25,$15,4095\n"
    "\tmflo\t$24\n"
    "\tsra\t$14,$24,12\n"
    "\tsh\t$14,16($5)\n"
    "\tnegu\t$15,$15\n"
    "\tbgez\t$15,.L800F2638\n"
    "\tandi\t$15,$15,4095\n"
    ".L800F2638:\n"
    "\tsll\t$24,$15,2\n"
    "\tlui\t$25,%hi(rcossin_tbl)\n"
    "\taddu\t$25,$25,$24\n"
    "\tlw\t$25,%lo(rcossin_tbl)($25)\n"
    "\tnop\n"
    "\tsll\t$24,$25,16\n"
    "\tsra\t$24,$24,16\n"
    "\tnegu\t$13,$24\n"
    "\tj\t.L800F268C\n"
    "\tsra\t$10,$25,16\n"
    ".L800F2660:\n"
    "\tmflo\t$15\n"
    "\tsra\t$14,$15,12\n"
    "\tsh\t$14,16($5)\n"
    "\tsll\t$24,$25,2\n"
    "\tlui\t$25,%hi(rcossin_tbl)\n"
    "\taddu\t$25,$25,$24\n"
    "\tlw\t$25,%lo(rcossin_tbl)($25)\n"
    "\tnop\n"
    "\tsll\t$24,$25,16\n"
    "\tsra\t$13,$24,16\n"
    "\tsra\t$10,$25,16\n"
    ".L800F268C:\n"
    "\t.word\t0x01490019\n"   /* multu $t2, $t1 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$15\n"
    "\tsra\t$14,$15,12\n"
    "\tsh\t$14,0($5)\n"
    "\t.word\t0x01A90019\n"   /* multu $t5, $t1 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$15\n"
    "\tnegu\t$14,$15\n"
    "\tsra\t$15,$14,12\n"
    "\t.word\t0x014C0019\n"   /* multu $t2, $t4 */
    "\tsh\t$15,2($5)\n"
    "\tnop\n"
    "\tmflo\t$15\n"
    "\tsra\t$24,$15,12\n"
    "\tnop\n"
    "\t.word\t0x030B0019\n"   /* multu $t8, $t3 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$15\n"
    "\tsra\t$14,$15,12\n"
    "\tnop\n"
    "\t.word\t0x01A80019\n"   /* multu $t5, $t0 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$15\n"
    "\tsra\t$25,$15,12\n"
    "\tsubu\t$15,$25,$14\n"
    "\t.word\t0x03080019\n"   /* multu $t8, $t0 */
    "\tsh\t$15,6($5)\n"
    "\tnop\n"
    "\tmflo\t$14\n"
    "\tsra\t$15,$14,12\n"
    "\tnop\n"
    "\t.word\t0x01AB0019\n"   /* multu $t5, $t3 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$14\n"
    "\tsra\t$25,$14,12\n"
    "\taddu\t$14,$25,$15\n"
    "\t.word\t0x01AC0019\n"   /* multu $t5, $t4 */
    "\tsh\t$14,12($5)\n"
    "\tnop\n"
    "\tmflo\t$15\n"
    "\tsra\t$24,$15,12\n"
    "\tnop\n"
    "\t.word\t0x030B0019\n"   /* multu $t8, $t3 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$15\n"
    "\tsra\t$14,$15,12\n"
    "\tnop\n"
    "\t.word\t0x01480019\n"   /* multu $t2, $t0 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$15\n"
    "\tsra\t$25,$15,12\n"
    "\taddu\t$15,$25,$14\n"
    "\t.word\t0x03080019\n"   /* multu $t8, $t0 */
    "\tsh\t$15,8($5)\n"
    "\tnop\n"
    "\tmflo\t$14\n"
    "\tsra\t$15,$14,12\n"
    "\tnop\n"
    "\t.word\t0x014B0019\n"   /* multu $t2, $t3 */
    "\tnop\n"
    "\tnop\n"
    "\tmflo\t$14\n"
    "\tsra\t$25,$14,12\n"
    "\tsubu\t$14,$25,$15\n"
    "\tsh\t$14,14($5)\n"
    "\tjr\t$31\n"
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
