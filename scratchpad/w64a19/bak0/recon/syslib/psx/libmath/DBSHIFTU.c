/* syslib/psx/libmath/DBSHIFTU.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays, fresh NFS4.EXE.i64).
 *   obj DBSHIFTU.obj ; libmath.lib.  _dbl_shift_us @0x801048E8 (188 B) -- (unsigned variant) shift a 64-bit value [w0:w1] by
 *   `count` bits: right when dir!=0, left when dir==0; result -> out[0..1].  Soft-float mantissa primitive.
 *
 *   TOOLCHAIN-IDENTITY WALL -- see DBSHIFT.cpp's header (_dbl_shift, same file pair) for the full
 *   writeup; this is byte-identical to that fn except one `sra`->`srl` (the right-shift path treats
 *   w1 as UNSIGNED here, matching the `_us` name). Transcribed VERBATIM as file-scope __asm__; portable
 *   C fallback kept for host (fixed to actually shift w1 unsigned, matching the fn's own name -- the
 *   prior fallback body was a byte-for-byte copy of the signed DBSHIFT.cpp one). */
extern unsigned int *_dbl_shift_us(unsigned int *out, int dir, unsigned int w0, int w1, int count); /* @0x801048E8 */

#if defined(__mips__)
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */

    "\t.globl _dbl_shift_us\n"     /* @0x801048E8 : uint *_dbl_shift_us(uint *out,int dir,uint w0,uint w1,int count) */
    "_dbl_shift_us:\n"
    "\tsw\t$a2,8($sp)\n"           /* spill w0 */
    "\tlw\t$a2,16($sp)\n"          /* a2 = count (5th stack arg) */
    "\taddu\t$t0,$a0,$zero\n"      /* t0 = out */
    "\tbnez\t$a1,.L80104948\n"     /* dir != 0 -> right-shift loop */
    "\t sw\t$a3,12($sp)\n"         /* delay: spill w1 */
    "\tblez\t$a2,.L8010498C\n"     /* count <= 0 -> done */
    "\t addu\t$a0,$zero,$zero\n"   /* delay: i = 0 */
    "\tlui\t$a3,32768\n"           /* a3 = 0x80000000 */
    ".L80104908:\n"                /* left-shift loop (dir == 0) */
    "\tlw\t$v0,12($sp)\n"          /* v0 = w1 */
    "\tlw\t$a1,8($sp)\n"           /* a1 = w0 */
    "\tsll\t$v1,$v0,1\n"           /* v1 = w1 << 1 */
    "\tand\t$v0,$a1,$a3\n"         /* top bit of w0 */
    "\tbeqz\t$v0,.L80104928\n"
    "\t sw\t$v1,12($sp)\n"         /* delay: w1 = v1 */
    "\tori\t$v0,$v1,1\n"           /* carry the top bit of w0 into w1's bit0 */
    "\tsw\t$v0,12($sp)\n"
    ".L80104928:\n"
    "\tsll\t$v0,$a1,1\n"           /* w0 <<= 1 */
    "\tsw\t$v0,8($sp)\n"
    "\taddiu\t$a0,$a0,1\n"         /* i++ */
    "\tslt\t$v0,$a0,$a2\n"         /* i < count ? */
    "\tbeqz\t$v0,.L8010498C\n"
    "\t nop\n"
    "\tj\t.L80104908\n"
    "\t nop\n"
    ".L80104948:\n"
    "\tblez\t$a2,.L8010498C\n"     /* count <= 0 -> done */
    "\t addu\t$a0,$zero,$zero\n"   /* delay: i = 0 */
    "\tlui\t$a3,32768\n"           /* a3 = 0x80000000 */
    ".L80104954:\n"                /* right-shift loop (dir != 0, UNSIGNED) */
    "\tlw\t$v0,8($sp)\n"           /* v0 = w0 */
    "\tlw\t$a1,12($sp)\n"          /* a1 = w1 */
    "\tsrl\t$v1,$v0,1\n"           /* v1 = w0 >>u 1 */
    "\tandi\t$v0,$a1,1\n"          /* bottom bit of w1 */
    "\tbeqz\t$v0,.L80104974\n"
    "\t sw\t$v1,8($sp)\n"          /* delay: w0 = v1 */
    "\tor\t$v0,$v1,$a3\n"          /* carry w1's bottom bit into w0's top bit */
    "\tsw\t$v0,8($sp)\n"
    ".L80104974:\n"
    "\tsrl\t$v0,$a1,1\n"           /* w1 >>u= 1  (UNSIGNED shift -- _dbl_shift_us only) */
    "\tsw\t$v0,12($sp)\n"
    "\taddiu\t$a0,$a0,1\n"         /* i++ */
    "\tslt\t$v0,$a0,$a2\n"         /* i < count ? */
    "\tbnez\t$v0,.L80104954\n"
    "\t nop\n"
    ".L8010498C:\n"
    "\tlw\t$v0,8($sp)\n"
    "\tlw\t$v1,12($sp)\n"
    "\tsw\t$v0,0($t0)\n"           /* out[0] = w0 */
    "\tsw\t$v1,4($t0)\n"           /* out[1] = w1 */
    "\tjr\t$ra\n"
    "\t addu\t$v0,$t0,$zero\n"     /* delay: return out */
    "\t.set pop\n"
);
#else
extern unsigned int *_dbl_shift_us(unsigned int *out, int dir, unsigned int w0, int w1, int count) /* @0x801048E8 */
{
    if (dir) {
        int i;
        for (i = 0; i < count; i++) {
            unsigned int v = w0 >> 1;
            w0 >>= 1;
            if (w1 & 1) w0 = v | 0x80000000;
            w1 = (int)((unsigned int)w1 >> 1);
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
