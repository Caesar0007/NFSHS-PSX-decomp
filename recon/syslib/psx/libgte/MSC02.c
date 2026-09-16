/* syslib/psx/libgte/MSC02.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgte.lib(MSC02.OBJ): VectorNormal / VectorNormalS / VectorNormalSS -- normalise a 3D
 *   vector to unit length using the GTE.  The oracle marks ALL FOUR functions "Handwritten"
 *   (GTE SQR/GPF via .word, the trapping add/sub/addi forms, and a private $t0-$t2 calling
 *   convention -- none of which a C compiler emits).  So the faithful form is verbatim
 *   file-scope __asm__, NOT a C body with inline-asm fragments.
 *
 *   The three public entries load the source vector into $t0,$t1,$t2 (lw for int VECTOR,
 *   lh for short SVECTOR), stash $ra in $a3, jal the shared worker, then store $t0,$t1,$t2
 *   back through $a1 (sw / sh) and return.  The worker @0x800F1B3C:
 *     - load v into IR1..IR3 (mtc2 $9/$10/$11), GTE SQR -> MAC1..3, sum -> |v|^2 in $v0;
 *     - GTE leading-zero-count (mtc2 $30 LZCS / mfc2 $31 LZCR) to bracket the magnitude,
 *       index the inverse-sqrt table D_8013485C, derive the post-scale shift in $t6;
 *     - reload v + scale, GTE GPF (IR0*IR1..3) -> MAC1..3, srav down by $t6 -> $t0,$t1,$t2.
 *   On the host the GTE is absent, so the workers are portable no-op stubs.
 *
 *   D_8013485C @ ~0x8013485C is a runtime-populated (BSS) inverse-sqrt mantissa table. */

#if defined(__mips__)

/* 2026-08-14 W59-A18 STRICT-BRANCH AUDIT FIX: the four __asm__ blocks were emitted in
 * the WRONG intra-TU order (kernel first), landing all four fns at wrong VAs and
 * mis-encoding VectorNormalS's cross-function `b` word (10000004 vs retail 10000010).
 * Retail order restored: VectorNormalS @+0x00, VectorNormal @+0x14, VectorNormalSS
 * @+0x44, _VectorNormalSS_kernel @+0x74.  Block contents unchanged.  Proven byte-exact
 * by scratchpad/w59a18/ reassembly.  The gate is branch-target lenient and cannot see
 * this class; caught by strict_branch.py (the only defect in 3257 PASS fns). */

/* @0x800F1AC8 : VectorNormalS -- int VECTOR in, short SVECTOR out.  Loads the vector as int,
 * then BRANCHES into VectorNormalSS's shared store-as-short tail (the oracle is just 5 insns:
 * 3x lw + b + nop -- it reuses VectorNormalSS's $a3/jal/sh body). */
__asm__(
    "\t.set\tnoreorder\n"
    "\t.set noreorder\n"
    "\t.globl VectorNormalS\n"
    "VectorNormalS:\n"
    "\tlw    $8, 0($4)\n"
    "\tlw    $9, 4($4)\n"
    "\tlw    $10, 8($4)\n"
    "\tb     .L_vecnormSS_tail\n"             /* -> VectorNormalSS's save-ra/jal/store-short body */
    "\t nop\n"
    "\t.set reorder\n\t.set at\n");

/* @0x800F1ADC : VectorNormal -- int VECTOR in, int VECTOR out. */
__asm__(
    "\t.set\tnoreorder\n"
    "\t.set noreorder\n"
    "\t.globl VectorNormal\n"
    "VectorNormal:\n"
    "\tlw    $8, 0($4)\n"
    "\tlw    $9, 4($4)\n"
    "\tlw    $10, 8($4)\n"
    "\taddu  $7, $31, $0\n"             /* save ra in $a3 (handwritten, no stack) */
    "\tjal   _VectorNormalSS_kernel\n"
    "\t nop\n"
    "\tsw    $8, 0($5)\n"
    "\tsw    $9, 4($5)\n"
    "\tsw    $10, 8($5)\n"
    "\taddu  $31, $7, $0\n"             /* restore ra */
    "\tjr    $31\n"
    "\t nop\n"
    "\t.set reorder\n\t.set at\n");

/* @0x800F1B0C : VectorNormalSS -- short SVECTOR in, short SVECTOR out. */
__asm__(
    "\t.set\tnoreorder\n"
    "\t.set noreorder\n"
    "\t.globl VectorNormalSS\n"
    "VectorNormalSS:\n"
    "\tlh    $8, 0($4)\n"
    "\tlh    $9, 2($4)\n"
    "\tlh    $10, 4($4)\n"
    ".L_vecnormSS_tail:\n"                    /* VectorNormalS branches here (shared tail) */
    "\taddu  $7, $31, $0\n"
    "\tjal   _VectorNormalSS_kernel\n"
    "\t nop\n"
    "\tsh    $8, 0($5)\n"
    "\tsh    $9, 2($5)\n"
    "\tsh    $10, 4($5)\n"
    "\taddu  $31, $7, $0\n"
    "\tjr    $31\n"
    "\t nop\n"
    "\t.set reorder\n\t.set at\n");

/* @0x800F1B3C : GTE unit-normalise worker.  In: v in $t0,$t1,$t2.  Out: scaled v in $t0,$t1,$t2;
 * $v0 = |v|^2.  Handwritten (GTE + trapping arith + private regs). */
__asm__(
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx's is_reorder OFF (no auto delay nop) */
    "\t.set noreorder\n"    /* space form: passes THROUGH maspsx to gnu-as */
    "\t.globl _VectorNormalSS_kernel\n"
    "_VectorNormalSS_kernel:\n"
    "\tmtc2  $8, $9\n"                     /* IR1 = x */
    "\tmtc2  $9, $10\n"                    /* IR2 = y */
    "\tmtc2  $10, $11\n"                    /* IR3 = z */
    "\tnop\n"
    "\t.word 0x4AA00428\n"                  /* GTE SQR (square IR1..3 -> MAC1..3) */
    "\tmfc2  $11, $25\n"                    /* MAC1 = x^2 */
    "\tmfc2  $12, $26\n"                    /* MAC2 = y^2 */
    "\tmfc2  $13, $27\n"                    /* MAC3 = z^2 */
    "\tadd   $11, $11, $12\n"
    "\tadd   $2, $11, $13\n"               /* |v|^2 */
    "\tmtc2  $2, $30\n"                    /* LZCS = |v|^2 */
    "\tnop\n"
    "\tnop\n"
    "\tmfc2  $3, $31\n"                    /* LZCR = leading-zero count */
    "\taddiu $1, $0, -2\n"
    "\tand   $3, $3, $1\n"               /* lz &= ~1 */
    "\taddiu $14, $0, 31\n"
    "\tsub   $14, $14, $3\n"
    "\tsra   $14, $14, 1\n"                 /* shift = (0x1f - lz) >> 1 */
    "\taddi  $11, $3, -24\n"               /* lz - 0x18 */
    "\tbltz  $11, 1f\n"
    "\t nop\n"
    "\tb     2f\n"
    "\t sllv  $12, $2, $11\n"              /* idx = mag << (lz-0x18) */
    "1:\n"
    "\taddiu $11, $0, 24\n"
    "\tsub   $11, $11, $3\n"
    "\tsrav  $12, $2, $11\n"               /* idx = mag >> (0x18-lz) */
    "2:\n"
    "\taddi  $12, $12, -64\n"               /* idx - 0x40 */
    "\tsll   $12, $12, 1\n"                 /* << 1 */
    "\tlui   $13, %hi(D_8013485C)\n"
    "\taddu  $13, $13, $12\n"
    "\tlh    $13, %lo(D_8013485C)($13)\n"   /* scale = rsqrt_tbl[idx] */
    "\tnop\n"
    "\tmtc2  $13, $8\n"                     /* IR0 = scale */
    "\tmtc2  $8, $9\n"                     /* IR1 = x */
    "\tmtc2  $9, $10\n"                    /* IR2 = y */
    "\tmtc2  $10, $11\n"                    /* IR3 = z */
    "\tnop\n"
    "\tnop\n"
    "\t.word 0x4B90003D\n"                  /* GTE GPF (IR0 * IR1..3 -> MAC1..3) */
    "\tmfc2  $8, $25\n"
    "\tmfc2  $9, $26\n"
    "\tmfc2  $10, $27\n"
    "\tsrav  $8, $8, $14\n"               /* >> shift */
    "\tsrav  $9, $9, $14\n"
    "\tsrav  $10, $10, $14\n"
    "\tjr    $31\n"
    "\t nop\n"
    "\t.set reorder\n\t.set at\n");

#else  /* host: GTE absent -- portable no-op stubs */

extern long VectorNormal(void *v0, void *v1)
{
    int *d = (int *)v1; (void)v0; d[0] = d[1] = d[2] = 0; return 0;
}
extern long VectorNormalS(void *v0, void *v1)
{
    short *d = (short *)v1; (void)v0; d[0] = d[1] = d[2] = 0; return 0;
}
extern long VectorNormalSS(void *v0, void *v1)
{
    short *d = (short *)v1; (void)v0; d[0] = d[1] = d[2] = 0; return 0;
}

#endif
