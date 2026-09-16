/* syslib/psx/libmath/DBSHIFT.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays, fresh NFS4.EXE.i64).
 *   obj DBSHIFT.obj ; libmath.lib.  _dbl_shift @0x80106E40 (188 B) -- shift a 64-bit value [w0:w1] by
 *   `count` bits: right when dir!=0, left when dir==0; result -> out[0..1].  Soft-float mantissa primitive.
 *
 *   TOOLCHAIN-IDENTITY WALL (w24-a2, 2026-07-25; same class as _comp_mant in DIVDF3.c -- see that file's
 *   header for the full flag-sweep). No SYM entry, no `addiu sp,sp,-N` at all (.frame $sp,0) -- the loop's
 *   [w0,w1] pair lives ENTIRELY in the caller-provided stack shadow space (sp+8/sp+0xC), round-tripped
 *   via genuine lw/sw EVERY iteration (no register-resident accumulator across iterations, unlike a
 *   normal -O2 loop). Same near-O0 signature the CC1PSX -O0..-O2 sweep could not reproduce. Transcribed
 *   VERBATIM as file-scope __asm__ (prior C-lane migration attempt for this pair also regressed --
 *   catalog "task #90" row -- kept as .cpp/extern "C"); portable C fallback kept for host.
 *   Sibling _dbl_shift_us (DBSHIFTU.cpp) is IDENTICAL except one `sra`->`srl` (signed vs unsigned
 *   right-shift path). */
extern unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count); /* @0x80106E40 */

#if defined(__mips__)
__asm__(
    ""
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */

    "\t.globl _dbl_shift\n"        /* @0x80106E40 : uint *_dbl_shift(uint *out,int dir,uint w0,uint w1,int count) */
    "_dbl_shift:\n"
    "\tsw\t$6,8($29)\n"           /* spill w0 */
    "\tlw\t$6,16($29)\n"          /* a2 = count (5th stack arg) */
    "\taddu\t$8,$4,$0\n"      /* t0 = out */
    "\tbnez\t$5,.L80106EA0\n"     /* dir != 0 -> right-shift loop */
    "\t sw\t$7,12($29)\n"         /* delay: spill w1 */
    "\tblez\t$6,.L80106EE4\n"     /* count <= 0 -> done */
    "\t addu\t$4,$0,$0\n"   /* delay: i = 0 */
    "\tlui\t$7,32768\n"           /* a3 = 0x80000000 */
    ".L80106E60:\n"                /* left-shift loop (dir == 0) */
    "\tlw\t$2,12($29)\n"          /* v0 = w1 */
    "\tlw\t$5,8($29)\n"           /* a1 = w0 */
    "\tsll\t$3,$2,1\n"           /* v1 = w1 << 1 */
    "\tand\t$2,$5,$7\n"         /* top bit of w0 */
    "\tbeqz\t$2,.L80106E80\n"
    "\t sw\t$3,12($29)\n"         /* delay: w1 = v1 */
    "\tori\t$2,$3,1\n"           /* carry the top bit of w0 into w1's bit0 */
    "\tsw\t$2,12($29)\n"
    ".L80106E80:\n"
    "\tsll\t$2,$5,1\n"           /* w0 <<= 1 */
    "\tsw\t$2,8($29)\n"
    "\taddiu\t$4,$4,1\n"         /* i++ */
    "\tslt\t$2,$4,$6\n"         /* i < count ? */
    "\tbeqz\t$2,.L80106EE4\n"
    "\t nop\n"
    "\tj\t.L80106E60\n"
    "\t nop\n"
    ".L80106EA0:\n"
    "\tblez\t$6,.L80106EE4\n"     /* count <= 0 -> done */
    "\t addu\t$4,$0,$0\n"   /* delay: i = 0 */
    "\tlui\t$7,32768\n"           /* a3 = 0x80000000 */
    ".L80106EAC:\n"                /* right-shift loop (dir != 0, SIGNED) */
    "\tlw\t$2,8($29)\n"           /* v0 = w0 */
    "\tlw\t$5,12($29)\n"          /* a1 = w1 */
    "\tsrl\t$3,$2,1\n"           /* v1 = w0 >>u 1 */
    "\tandi\t$2,$5,1\n"          /* bottom bit of w1 */
    "\tbeqz\t$2,.L80106ECC\n"
    "\t sw\t$3,8($29)\n"          /* delay: w0 = v1 */
    "\tor\t$2,$3,$7\n"          /* carry w1's bottom bit into w0's top bit */
    "\tsw\t$2,8($29)\n"
    ".L80106ECC:\n"
    "\tsra\t$2,$5,1\n"           /* w1 >>s= 1  (SIGNED shift -- _dbl_shift only) */
    "\tsw\t$2,12($29)\n"
    "\taddiu\t$4,$4,1\n"         /* i++ */
    "\tslt\t$2,$4,$6\n"         /* i < count ? */
    "\tbnez\t$2,.L80106EAC\n"
    "\t nop\n"
    ".L80106EE4:\n"
    "\tlw\t$2,8($29)\n"
    "\tlw\t$3,12($29)\n"
    "\tsw\t$2,0($8)\n"           /* out[0] = w0 */
    "\tsw\t$3,4($8)\n"           /* out[1] = w1 */
    "\tjr\t$31\n"
    "\t addu\t$2,$8,$0\n"     /* delay: return out */
    "\t.set reorder\n\t.set at\n"
);
#else
extern unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count) /* @0x80106E40 */
{
    if (dir) {
        int i;
        for (i = 0; i < count; i++) {
            unsigned int v = w0 >> 1;
            w0 >>= 1;
            if (w1 & 1) w0 = v | 0x80000000;
            w1 >>= 1;
        }
    } else {
        int j;
        for (j = 0; j < count; j++) {
            int v = 2 * w1;
            w1 *= 2;
            if (w0 & 0x80000000) w1 = v | 1;
            w0 *= 2;
        }
    }
    out[0] = w0;
    out[1] = w1;
    return out;
}
#endif
