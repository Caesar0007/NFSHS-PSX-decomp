/* eaclib/psx/eacpsxz/blkmov.c -- RECONSTRUCTED from nfs4-f.exe.  HAND-WRITTEN ASSEMBLY.
 *   Source obj : ..\eaclib\psx\eacpsxz.lib(blkmov.obj).
 *   SYM SLD proof: the symbol's source file is `C:\LIB\PSX\BLKMOV.ASM` (Set SLD to line 8 of
 *   file C:\LIB\PSX\BLKMOV.ASM) -- i.e. the original TU was hand-written MIPS assembly, NOT C.
 *   The oracle confirms it: `add` (the TRAPPING add, never emitted by a C compiler), manual
 *   `$at`, `.set noreorder` with hand-filled delay slots, and a 4-tier (64/16/4/1-byte) unrolled
 *   copier with separate aligned (lw/sw) and unaligned (lwl/lwr/swl/swr) paths in both forward
 *   and backward directions.  No C source compiles to this, so it is transcribed verbatim as a
 *   file-scope __asm__ (byte-identical to BLKMOV.ASM).  @0x800E62DC, 796 bytes (199 insns).
 *   Operands are decimal (maspsx parses memory displacements as base-10, like gcc output).
 *
 *   blockmove(src, dst, n): overlap-safe block copy.  Picks direction by `src < dst` (copy
 *   backward when dst is higher), then unrolls aligned/unaligned runs.  == memmove(dst,src,n).
 */

#if defined(__mips__)
/* ASPSX-DIALECT (w64-a20): the asm below uses NUMERIC registers and no
 * `.set push/pop` -- ASPSX 2.77, the PRODUCTION assembler, rejects ABI
 * register NAMES and push/pop.  $0 zero $1 at $2-3 v0-v1 $4-7 a0-a3
 * $8-15 t0-t7 $16-23 s0-s7 $24-25 t8-t9 $28 gp $29 sp $30 fp $31 ra.
 * Gate-lane object is byte-identical (proven by hash); see
 * scratchpad/w64a20/RECEIPTS.md. */
__asm__(
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as (keeps as from reordering)   */
    "\t.globl blockmove\n"
    "blockmove:\n"
    "\tslt    $1, $4, $5\n"
    "\tbnez   $1, .L800E64D0\n"
    ".L800E62E4:\n"
    "\tor     $2, $4, $5\n"            /* delay slot of bnez; also fall-through target */
    "\tandi   $2, $2, 3\n"
    "\tbnez   $2, .L800E641C\n"
    "\tnop\n"
    "\taddiu  $6, $6, -64\n"
    "\tbltz   $6, .L800E6390\n"
    "\tnop\n"
    /* forward, aligned, 64-byte unroll */
    ".L800E6300:\n"
    "\tlw     $8, 0($4)\n"
    "\tlw     $9, 4($4)\n"
    "\tlw     $10, 8($4)\n"
    "\tlw     $11, 12($4)\n"
    "\tlw     $12, 16($4)\n"
    "\tlw     $13, 20($4)\n"
    "\tlw     $14, 24($4)\n"
    "\tlw     $15, 28($4)\n"
    "\tsw     $8, 0($5)\n"
    "\tsw     $9, 4($5)\n"
    "\tsw     $10, 8($5)\n"
    "\tsw     $11, 12($5)\n"
    "\tsw     $12, 16($5)\n"
    "\tsw     $13, 20($5)\n"
    "\tsw     $14, 24($5)\n"
    "\tsw     $15, 28($5)\n"
    "\tlw     $8, 32($4)\n"
    "\tlw     $9, 36($4)\n"
    "\tlw     $10, 40($4)\n"
    "\tlw     $11, 44($4)\n"
    "\tlw     $12, 48($4)\n"
    "\tlw     $13, 52($4)\n"
    "\tlw     $14, 56($4)\n"
    "\tlw     $15, 60($4)\n"
    "\tsw     $8, 32($5)\n"
    "\tsw     $9, 36($5)\n"
    "\tsw     $10, 40($5)\n"
    "\tsw     $11, 44($5)\n"
    "\tsw     $12, 48($5)\n"
    "\tsw     $13, 52($5)\n"
    "\tsw     $14, 56($5)\n"
    "\tsw     $15, 60($5)\n"
    "\taddiu  $6, $6, -64\n"
    "\taddiu  $4, $4, 64\n"
    "\tbgez   $6, .L800E6300\n"
    "\taddiu  $5, $5, 64\n"
    /* forward, aligned, 16-byte tail */
    ".L800E6390:\n"
    "\taddiu  $6, $6, 48\n"
    "\tbltz   $6, .L800E63CC\n"
    "\tnop\n"
    ".L800E639C:\n"
    "\tlw     $8, 0($4)\n"
    "\tlw     $9, 4($4)\n"
    "\tlw     $10, 8($4)\n"
    "\tlw     $11, 12($4)\n"
    "\tsw     $8, 0($5)\n"
    "\tsw     $9, 4($5)\n"
    "\tsw     $10, 8($5)\n"
    "\tsw     $11, 12($5)\n"
    "\taddiu  $6, $6, -16\n"
    "\taddiu  $4, $4, 16\n"
    "\tbgez   $6, .L800E639C\n"
    "\taddiu  $5, $5, 16\n"
    /* forward, aligned, 4-byte tail */
    ".L800E63CC:\n"
    "\taddiu  $6, $6, 12\n"
    "\tbltz   $6, .L800E63F0\n"
    "\tnop\n"
    ".L800E63D8:\n"
    "\tlw     $8, 0($4)\n"
    "\taddiu  $6, $6, -4\n"
    "\tsw     $8, 0($5)\n"
    "\taddiu  $4, $4, 4\n"
    "\tbgez   $6, .L800E63D8\n"
    "\taddiu  $5, $5, 4\n"
    /* forward, 1-byte tail */
    ".L800E63F0:\n"
    "\taddiu  $6, $6, 3\n"
    "\tbltz   $6, .L800E6414\n"
    "\tnop\n"
    ".L800E63FC:\n"
    "\tlb     $8, 0($4)\n"
    "\taddiu  $6, $6, -1\n"
    "\tsb     $8, 0($5)\n"
    "\taddiu  $4, $4, 1\n"
    "\tbgez   $6, .L800E63FC\n"
    "\taddiu  $5, $5, 1\n"
    ".L800E6414:\n"
    "\tjr     $31\n"
    "\tnop\n"
    /* forward, unaligned (lwl/lwr/swl/swr), 16-byte unroll */
    ".L800E641C:\n"
    "\taddiu  $6, $6, -16\n"
    "\tbltz   $6, .L800E6478\n"
    "\tnop\n"
    ".L800E6428:\n"
    "\tlwl    $8, 3($4)\n"
    "\tlwr    $8, 0($4)\n"
    "\tlwl    $9, 7($4)\n"
    "\tlwr    $9, 4($4)\n"
    "\tlwl    $10, 11($4)\n"
    "\tlwr    $10, 8($4)\n"
    "\tlwl    $11, 15($4)\n"
    "\tlwr    $11, 12($4)\n"
    "\tswl    $8, 3($5)\n"
    "\tswr    $8, 0($5)\n"
    "\tswl    $9, 7($5)\n"
    "\tswr    $9, 4($5)\n"
    "\tswl    $10, 11($5)\n"
    "\tswr    $10, 8($5)\n"
    "\tswl    $11, 15($5)\n"
    "\tswr    $11, 12($5)\n"
    "\taddiu  $6, $6, -16\n"
    "\taddiu  $4, $4, 16\n"
    "\tbgez   $6, .L800E6428\n"
    "\taddiu  $5, $5, 16\n"
    /* forward, unaligned, 4-byte tail */
    ".L800E6478:\n"
    "\taddiu  $6, $6, 12\n"
    "\tbltz   $6, .L800E64A4\n"
    "\tnop\n"
    ".L800E6484:\n"
    "\tlwl    $8, 3($4)\n"
    "\tlwr    $8, 0($4)\n"
    "\taddiu  $6, $6, -4\n"
    "\tswl    $8, 3($5)\n"
    "\tswr    $8, 0($5)\n"
    "\taddiu  $4, $4, 4\n"
    "\tbgez   $6, .L800E6484\n"
    "\taddiu  $5, $5, 4\n"
    /* forward, unaligned, 1-byte tail */
    ".L800E64A4:\n"
    "\taddiu  $6, $6, 3\n"
    "\tbltz   $6, .L800E64C8\n"
    "\tnop\n"
    ".L800E64B0:\n"
    "\tlb     $8, 0($4)\n"
    "\taddiu  $6, $6, -1\n"
    "\tsb     $8, 0($5)\n"
    "\taddiu  $4, $4, 1\n"
    "\tbgez   $6, .L800E64B0\n"
    "\taddiu  $5, $5, 1\n"
    ".L800E64C8:\n"
    "\tjr     $31\n"
    "\tnop\n"
    /* backward path: dst is higher; bias pointers to the END, copy descending */
    ".L800E64D0:\n"
    "\tadd    $7, $4, $6\n"            /* trapping add (hand-written) */
    "\tslt    $1, $5, $7\n"
    "\tbeqz   $1, .L800E62E4\n"          /* no real overlap -> forward copy */
    "\tnop\n"
    "\tadd    $4, $4, $6\n"            /* trapping add (hand-written) */
    "\tadd    $5, $5, $6\n"            /* trapping add (hand-written) */
    "\tor     $2, $4, $5\n"
    "\tandi   $2, $2, 3\n"
    "\tbnez   $2, .L800E6548\n"
    "\tnop\n"
    "\taddiu  $6, $6, -16\n"
    "\tbltz   $6, .L800E6534\n"
    "\tnop\n"
    /* backward, aligned, 16-byte unroll */
    ".L800E6504:\n"
    "\tlw     $8, -16($4)\n"
    "\tlw     $9, -12($4)\n"
    "\tlw     $10, -8($4)\n"
    "\tlw     $11, -4($4)\n"
    "\tsw     $8, -16($5)\n"
    "\tsw     $9, -12($5)\n"
    "\tsw     $10, -8($5)\n"
    "\tsw     $11, -4($5)\n"
    "\taddiu  $4, $4, -16\n"
    "\taddiu  $6, $6, -16\n"
    "\tbgez   $6, .L800E6504\n"
    "\taddiu  $5, $5, -16\n"
    ".L800E6534:\n"
    "\taddiu  $6, $6, 12\n"
    "\tbltz   $6, .L800E65D0\n"
    "\tnop\n"
    "\tj      .L800E65B0\n"
    "\tnop\n"
    /* backward, unaligned, 16-byte unroll */
    ".L800E6548:\n"
    "\taddiu  $6, $6, -16\n"
    "\tbltz   $6, .L800E65A4\n"
    "\tnop\n"
    ".L800E6554:\n"
    "\tlwl    $8, -13($4)\n"
    "\tlwr    $8, -16($4)\n"
    "\tlwl    $9, -9($4)\n"
    "\tlwr    $9, -12($4)\n"
    "\tlwl    $10, -5($4)\n"
    "\tlwr    $10, -8($4)\n"
    "\tlwl    $11, -1($4)\n"
    "\tlwr    $11, -4($4)\n"
    "\tswl    $8, -13($5)\n"
    "\tswr    $8, -16($5)\n"
    "\tswl    $9, -9($5)\n"
    "\tswr    $9, -12($5)\n"
    "\tswl    $10, -5($5)\n"
    "\tswr    $10, -8($5)\n"
    "\tswl    $11, -1($5)\n"
    "\tswr    $11, -4($5)\n"
    "\taddiu  $6, $6, -16\n"
    "\taddiu  $4, $4, -16\n"
    "\tbgez   $6, .L800E6554\n"
    "\taddiu  $5, $5, -16\n"
    ".L800E65A4:\n"
    "\taddiu  $6, $6, 12\n"
    "\tbltz   $6, .L800E65D0\n"
    "\tnop\n"
    /* backward, unaligned, 4-byte tail */
    ".L800E65B0:\n"
    "\tlwl    $8, -1($4)\n"
    "\tlwr    $8, -4($4)\n"
    "\taddiu  $6, $6, -4\n"
    "\tswl    $8, -1($5)\n"
    "\tswr    $8, -4($5)\n"
    "\taddiu  $4, $4, -4\n"
    "\tbgez   $6, .L800E65B0\n"
    "\taddiu  $5, $5, -4\n"
    /* backward, 1-byte tail */
    ".L800E65D0:\n"
    "\taddiu  $6, $6, 3\n"
    "\tbltz   $6, .L800E65F0\n"
    ".L800E65D8:\n"
    "\taddiu  $6, $6, -1\n"             /* delay slot of bltz; also loop target */
    "\tlb     $8, -1($4)\n"
    "\taddiu  $4, $4, -1\n"
    "\tsb     $8, -1($5)\n"
    "\tbgez   $6, .L800E65D8\n"
    "\taddiu  $5, $5, -1\n"
    ".L800E65F0:\n"
    "\tjr     $31\n"
    "\tnop\n"
    "\t.set at\n"
    "\t.set reorder\n"
);
#else
/* Portable host fallback (non-MIPS builds): the observable behaviour is an n-byte memmove
   with the (src, dst, n) argument order. */
extern void blockmove(void *src, void *dst, int n)
{
    char *s = (char *)src;
    char *d = (char *)dst;
    if (s < d) { s += n; d += n; while (n-- > 0) *--d = *--s; }
    else       { while (n-- > 0) *d++ = *s++; }
}
#endif

/* end of blkmov.cpp */
