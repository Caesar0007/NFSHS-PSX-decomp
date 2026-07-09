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

/* @0x800F1B3C : GTE unit-normalise worker.  In: v in $t0,$t1,$t2.  Out: scaled v in $t0,$t1,$t2;
 * $v0 = |v|^2.  Handwritten (GTE + trapping arith + private regs). */
__asm__(
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx's is_reorder OFF (no auto delay nop) */
    "\t.set noreorder\n"    /* space form: passes THROUGH maspsx to gnu-as */
    "\t.globl _VectorNormalSS_kernel\n"
    "_VectorNormalSS_kernel:\n"
    "\tmtc2  $t0, $9\n"                     /* IR1 = x */
    "\tmtc2  $t1, $10\n"                    /* IR2 = y */
    "\tmtc2  $t2, $11\n"                    /* IR3 = z */
    "\tnop\n"
    "\t.word 0x4AA00428\n"                  /* GTE SQR (square IR1..3 -> MAC1..3) */
    "\tmfc2  $t3, $25\n"                    /* MAC1 = x^2 */
    "\tmfc2  $t4, $26\n"                    /* MAC2 = y^2 */
    "\tmfc2  $t5, $27\n"                    /* MAC3 = z^2 */
    "\tadd   $t3, $t3, $t4\n"
    "\tadd   $v0, $t3, $t5\n"               /* |v|^2 */
    "\tmtc2  $v0, $30\n"                    /* LZCS = |v|^2 */
    "\tnop\n"
    "\tnop\n"
    "\tmfc2  $v1, $31\n"                    /* LZCR = leading-zero count */
    "\taddiu $at, $zero, -2\n"
    "\tand   $v1, $v1, $at\n"               /* lz &= ~1 */
    "\taddiu $t6, $zero, 31\n"
    "\tsub   $t6, $t6, $v1\n"
    "\tsra   $t6, $t6, 1\n"                 /* shift = (0x1f - lz) >> 1 */
    "\taddi  $t3, $v1, -24\n"               /* lz - 0x18 */
    "\tbltz  $t3, 1f\n"
    "\t nop\n"
    "\tb     2f\n"
    "\t sllv  $t4, $v0, $t3\n"              /* idx = mag << (lz-0x18) */
    "1:\n"
    "\taddiu $t3, $zero, 24\n"
    "\tsub   $t3, $t3, $v1\n"
    "\tsrav  $t4, $v0, $t3\n"               /* idx = mag >> (0x18-lz) */
    "2:\n"
    "\taddi  $t4, $t4, -64\n"               /* idx - 0x40 */
    "\tsll   $t4, $t4, 1\n"                 /* << 1 */
    "\tlui   $t5, %hi(D_8013485C)\n"
    "\taddu  $t5, $t5, $t4\n"
    "\tlh    $t5, %lo(D_8013485C)($t5)\n"   /* scale = rsqrt_tbl[idx] */
    "\tnop\n"
    "\tmtc2  $t5, $8\n"                     /* IR0 = scale */
    "\tmtc2  $t0, $9\n"                     /* IR1 = x */
    "\tmtc2  $t1, $10\n"                    /* IR2 = y */
    "\tmtc2  $t2, $11\n"                    /* IR3 = z */
    "\tnop\n"
    "\tnop\n"
    "\t.word 0x4B90003D\n"                  /* GTE GPF (IR0 * IR1..3 -> MAC1..3) */
    "\tmfc2  $t0, $25\n"
    "\tmfc2  $t1, $26\n"
    "\tmfc2  $t2, $27\n"
    "\tsrav  $t0, $t0, $t6\n"               /* >> shift */
    "\tsrav  $t1, $t1, $t6\n"
    "\tsrav  $t2, $t2, $t6\n"
    "\tjr    $ra\n"
    "\t nop\n"
    "\t.set	pop\n");

/* @0x800F1ADC : VectorNormal -- int VECTOR in, int VECTOR out. */
__asm__(
    "\t.set\tnoreorder\n"
    "\t.set noreorder\n"
    "\t.globl VectorNormal\n"
    "VectorNormal:\n"
    "\tlw    $t0, 0($a0)\n"
    "\tlw    $t1, 4($a0)\n"
    "\tlw    $t2, 8($a0)\n"
    "\taddu  $a3, $ra, $zero\n"             /* save ra in $a3 (handwritten, no stack) */
    "\tjal   _VectorNormalSS_kernel\n"
    "\t nop\n"
    "\tsw    $t0, 0($a1)\n"
    "\tsw    $t1, 4($a1)\n"
    "\tsw    $t2, 8($a1)\n"
    "\taddu  $ra, $a3, $zero\n"             /* restore ra */
    "\tjr    $ra\n"
    "\t nop\n"
    "\t.set	pop\n");

/* @0x800F1AC8 : VectorNormalS -- int VECTOR in, short SVECTOR out.  Loads the vector as int,
 * then BRANCHES into VectorNormalSS's shared store-as-short tail (the oracle is just 5 insns:
 * 3x lw + b + nop -- it reuses VectorNormalSS's $a3/jal/sh body). */
__asm__(
    "\t.set\tnoreorder\n"
    "\t.set noreorder\n"
    "\t.globl VectorNormalS\n"
    "VectorNormalS:\n"
    "\tlw    $t0, 0($a0)\n"
    "\tlw    $t1, 4($a0)\n"
    "\tlw    $t2, 8($a0)\n"
    "\tb     .L_vecnormSS_tail\n"             /* -> VectorNormalSS's save-ra/jal/store-short body */
    "\t nop\n"
    "\t.set	pop\n");

/* @0x800F1B0C : VectorNormalSS -- short SVECTOR in, short SVECTOR out. */
__asm__(
    "\t.set\tnoreorder\n"
    "\t.set noreorder\n"
    "\t.globl VectorNormalSS\n"
    "VectorNormalSS:\n"
    "\tlh    $t0, 0($a0)\n"
    "\tlh    $t1, 2($a0)\n"
    "\tlh    $t2, 4($a0)\n"
    ".L_vecnormSS_tail:\n"                    /* VectorNormalS branches here (shared tail) */
    "\taddu  $a3, $ra, $zero\n"
    "\tjal   _VectorNormalSS_kernel\n"
    "\t nop\n"
    "\tsh    $t0, 0($a1)\n"
    "\tsh    $t1, 2($a1)\n"
    "\tsh    $t2, 4($a1)\n"
    "\taddu  $ra, $a3, $zero\n"
    "\tjr    $ra\n"
    "\t nop\n"
    "\t.set	pop\n");

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
