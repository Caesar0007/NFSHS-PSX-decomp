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
#include "../../../lib/gte_thunk.h"
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

/* MSC02.obj head + tail (LINK-STRIPPED): InvSquareRoot @0 and MatrixNormal @448 -- retail's object text is exactly
 * VectorNormalS .. VectorNormalSS.  Sony GTE assembly; the lines are generated from the PsyQ 4.3 object
 * (scratchpad/psyq_pipe/strip_asm_gen.py): `.word` = GTE commands, D_8013485C = the reciprocal-sqrt table below. */
GTE_ASM_LINK_STRIPPED(InvSquareRoot,
    "\tmtc2 $4,$30\n"
    "\t.word 0x00000000\n"
    "\t.word 0x00000000\n"
    "\tmfc2 $2,$31\n"
    "\taddiu $1,$0,32\n"
    "\tbeq $2,$1,.LInvSquareRoot_84\n"
    "\tnop\n"
    "\tbeq $2,$0,.LInvSquareRoot_84\n"
    "\tnop\n"
    "\tandi $8,$2,0x1\n"
    "\taddiu $1,$0,-2\n"
    "\tand $10,$2,$1\n"
    "\taddiu $9,$0,31\n"
    "\tsub $9,$9,$10\n"
    "\tsra $9,$9,0x1\n"
    "\taddi $11,$10,-24\n"
    "\tbltz $11,.LInvSquareRoot_50\n"
    "\tnop\n"
    "\tsllv $12,$4,$11\n"
    "\tbeq $0,$0,.LInvSquareRoot_5c\n"
    ".LInvSquareRoot_50:\n"
    "\taddiu $11,$0,24\n"
    "\tsub $11,$11,$10\n"
    "\tsrav $12,$4,$11\n"
    ".LInvSquareRoot_5c:\n"
    "\taddi $12,$12,-64\n"
    "\tsll $12,$12,0x1\n"
    "\tlui $13,%hi(D_8013485C)\n"
    "\taddu $13,$13,$12\n"
    "\tlh $13,%lo(D_8013485C)($13)\n"
    "\tsw $9,0($6)\n"
    "\tsw $13,0($5)\n"
    "\taddiu $2,$0,1\n"
    "\tjr $31\n"
    "\tnop\n"
    ".LInvSquareRoot_84:\n"
    "\tjr $31\n"
    "\taddiu $2,$0,-1\n");
GTE_ASM_LINK_STRIPPED(MatrixNormal,
    "\tlh $8,0($4)\n"
    "\tlh $9,2($4)\n"
    "\tlh $10,4($4)\n"
    "\tlh $11,6($4)\n"
    "\tlh $12,8($4)\n"
    "\tlh $13,10($4)\n"
    "\tcfc2 $2,$0\n"
    "\tcfc2 $3,$2\n"
    "\tcfc2 $6,$4\n"
    "\tctc2 $8,$0\n"
    "\tctc2 $9,$2\n"
    "\tctc2 $10,$4\n"
    "\tmtc2 $13,$11\n"
    "\tmtc2 $11,$9\n"
    "\tmtc2 $12,$10\n"
    "\tnop\n"
    "\tc2 0x178000c\n"
    "\tmfc2 $15,$25\n"
    "\tmfc2 $24,$26\n"
    "\tmfc2 $25,$27\n"
    "\tctc2 $11,$0\n"
    "\tctc2 $12,$2\n"
    "\tctc2 $13,$4\n"
    "\tnop\n"
    "\tc2 0x178000c\n"
    "\tmtc2 $11,$0\n"
    "\tmtc2 $12,$1\n"
    "\tmtc2 $13,$2\n"
    "\tmfc2 $8,$25\n"
    "\tmfc2 $9,$26\n"
    "\tmfc2 $10,$27\n"
    "\tctc2 $2,$0\n"
    "\tctc2 $3,$2\n"
    "\tctc2 $6,$4\n"
    "\taddu $7,$31,$0\n"
    "\tjal _VectorNormalSS_kernel\n"
    "\tnop\n"
    "\tsh $8,0($5)\n"
    "\tsh $9,2($5)\n"
    "\tsh $10,4($5)\n"
    "\tmfc2 $8,$0\n"
    "\tmfc2 $9,$1\n"
    "\tmfc2 $10,$2\n"
    "\tjal _VectorNormalSS_kernel\n"
    "\tnop\n"
    "\tsh $8,6($5)\n"
    "\tsh $9,8($5)\n"
    "\tsh $10,10($5)\n"
    "\taddu $8,$15,$0\n"
    "\taddu $9,$24,$0\n"
    "\tjal _VectorNormalSS_kernel\n"
    "\taddu $10,$25,$0\n"
    "\tsh $8,12($5)\n"
    "\tsh $9,14($5)\n"
    "\tsh $10,16($5)\n"
    "\taddu $31,$7,$0\n"
    "\tjr $31\n"
    "\tnop\n");

/* MSC02.obj .data 0x8013485C..0x801349E8, owned here since 2026-09-19 (gprefs.py: _VectorNormalSS_kernel is the only
 * retail user): the 192-entry reciprocal-sqrt table the kernel indexes as `lh scale, tbl[idx]`.  Defined AFTER the
 * handwritten blocks so they stay in .text. */
unsigned short D_8013485C[192] = {
    0x1000, 0x0FE0, 0x0FC1, 0x0FA3, 0x0F85, 0x0F68, 0x0F4C, 0x0F30, 0x0F15, 0x0EFB, 0x0EE1, 0x0EC7,
    0x0EAE, 0x0E96, 0x0E7E, 0x0E66, 0x0E4F, 0x0E38, 0x0E22, 0x0E0C, 0x0DF7, 0x0DE2, 0x0DCD, 0x0DB9,
    0x0DA5, 0x0D91, 0x0D7E, 0x0D6B, 0x0D58, 0x0D45, 0x0D33, 0x0D21, 0x0D10, 0x0CFF, 0x0CEE, 0x0CDD,
    0x0CCC, 0x0CBC, 0x0CAC, 0x0C9C, 0x0C8D, 0x0C7D, 0x0C6E, 0x0C5F, 0x0C51, 0x0C42, 0x0C34, 0x0C26,
    0x0C18, 0x0C0A, 0x0BFD, 0x0BEF, 0x0BE2, 0x0BD5, 0x0BC8, 0x0BBB, 0x0BAF, 0x0BA2, 0x0B96, 0x0B8A,
    0x0B7E, 0x0B72, 0x0B67, 0x0B5B, 0x0B50, 0x0B45, 0x0B39, 0x0B2E, 0x0B24, 0x0B19, 0x0B0E, 0x0B04,
    0x0AF9, 0x0AEF, 0x0AE5, 0x0ADB, 0x0AD1, 0x0AC7, 0x0ABD, 0x0AB4, 0x0AAA, 0x0AA1, 0x0A97, 0x0A8E,
    0x0A85, 0x0A7C, 0x0A73, 0x0A6A, 0x0A61, 0x0A59, 0x0A50, 0x0A47, 0x0A3F, 0x0A37, 0x0A2E, 0x0A26,
    0x0A1E, 0x0A16, 0x0A0E, 0x0A06, 0x09FE, 0x09F6, 0x09EF, 0x09E7, 0x09E0, 0x09D8, 0x09D1, 0x09C9,
    0x09C2, 0x09BB, 0x09B4, 0x09AD, 0x09A5, 0x099E, 0x0998, 0x0991, 0x098A, 0x0983, 0x097C, 0x0976,
    0x096F, 0x0969, 0x0962, 0x095C, 0x0955, 0x094F, 0x0949, 0x0943, 0x093C, 0x0936, 0x0930, 0x092A,
    0x0924, 0x091E, 0x0918, 0x0912, 0x090D, 0x0907, 0x0901, 0x08FB, 0x08F6, 0x08F0, 0x08EB, 0x08E5,
    0x08E0, 0x08DA, 0x08D5, 0x08CF, 0x08CA, 0x08C5, 0x08BF, 0x08BA, 0x08B5, 0x08B0, 0x08AB, 0x08A6,
    0x08A1, 0x089C, 0x0897, 0x0892, 0x088D, 0x0888, 0x0883, 0x087E, 0x087A, 0x0875, 0x0870, 0x086B,
    0x0867, 0x0862, 0x085E, 0x0859, 0x0855, 0x0850, 0x084C, 0x0847, 0x0843, 0x083E, 0x083A, 0x0836,
    0x0831, 0x082D, 0x0829, 0x0824, 0x0820, 0x081C, 0x0818, 0x0814, 0x0810, 0x080C, 0x0808, 0x0804,
};
/* SYM-GLOBAL-CARRIER: three zero words close MSC02.obj .data (retail bytes; names not retained) */
int D_801349DC[3] = { 0, 0, 0 };
