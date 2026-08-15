/* syslib/psx/libmath/ADDMANT.c -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj ADDMANT.obj ; libmath.lib.  _add_mant_d @0x80106F70 (172 B) -- 64-bit mantissa add with 16-bit-lane
 *   carry propagation: out[0:1] = [a3:a2_lo16|...] ; adds (a2,a3)+(a4,a5).  Soft-float primitive.
 *
 *   TOOLCHAIN-IDENTITY WALL (w24-a2, 2026-07-25; same class as _comp_mant in DIVDF3.c -- see that file's
 *   header for the full flag-sweep + cross-corroboration writeup). No SYM entry. Oracle spills every
 *   incoming reg arg to its stack home on entry AND stages every intermediate through genuine lw/sw
 *   round-trips (no cross-statement register caching at all -- e.g. `sw a0,0(sp)` immediately followed
 *   later by `lw v0,4(sp); nop; addu a3,v0,v1`), a near-O0 shape unreachable from our -O2 CC1PSX at any
 *   flag combination tried. Transcribed VERBATIM as file-scope __asm__; portable C fallback for host. */
extern int *_add_mant_d(int *out, unsigned int a2, int a3, unsigned int a4, int a5);   /* @0x80106F70 */

#if defined(__mips__)
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */

    "\t.globl _add_mant_d\n"       /* @0x80106F70 : int *_add_mant_d(int *out,uint a2,int a3,uint a4,int a5) */
    "_add_mant_d:\n"
    "\taddiu\t$sp,$sp,-16\n"
    "\taddu\t$t1,$a0,$zero\n"      /* t1 = out */
    "\tsrl\t$t0,$a1,16\n"          /* t0 = a2 hi16 */
    "\tsw\t$a1,20($sp)\n"          /* spill raw a2 */
    "\tandi\t$a1,$a1,0xFFFF\n"     /* a1 = a2 lo16 */
    "\tsrl\t$v1,$a3,16\n"          /* v1 = a4 hi16 */
    "\tsw\t$a3,28($sp)\n"          /* spill raw a4 */
    "\tandi\t$a3,$a3,0xFFFF\n"     /* a3 = a4 lo16 */
    "\taddu\t$a0,$a1,$a3\n"        /* a0 = a2lo + a4lo */
    "\tsw\t$a1,0($sp)\n"
    "\tlui\t$a1,1\n"               /* a1 = 0x10000 */
    "\tand\t$v0,$a0,$a1\n"         /* carry-out of the lo16 add? */
    "\tsw\t$a2,24($sp)\n"          /* spill a3 (the hi 32-bit half) */
    "\tsw\t$t0,4($sp)\n"           /* a2 hi16 slot */
    "\tsw\t$v1,12($sp)\n"          /* a4 hi16 slot */
    "\tsw\t$a3,8($sp)\n"           /* a4 lo16 slot */
    "\tbeqz\t$v0,.L80106FC0\n"
    "\t sw\t$a0,0($sp)\n"          /* delay: stash lo16 sum (pre-carry) */
    "\taddiu\t$v0,$t0,1\n"         /* carry: a2hi16 + 1 */
    "\tsw\t$v0,4($sp)\n"
    ".L80106FC0:\n"
    "\tlw\t$v0,4($sp)\n"           /* v0 = (carried) a2 hi16 */
    "\tnop\n"
    "\taddu\t$a3,$v0,$v1\n"        /* a3 = a2hi16 + a4hi16 */
    "\tand\t$v0,$a3,$a1\n"         /* carry-out of the hi16 add? */
    "\tbeqz\t$v0,.L80106FE0\n"
    "\t sw\t$a3,4($sp)\n"          /* delay: stash hi16 sum (pre-carry) */
    "\taddiu\t$a2,$a2,1\n"         /* carry into a3 (the hi 32-bit half) */
    "\tsw\t$a2,24($sp)\n"
    ".L80106FE0:\n"
    "\tsll\t$v0,$a3,16\n"          /* v0 = (carried) a2 hi16 << 16 */
    "\tandi\t$a0,$a0,0xFFFF\n"     /* a0 = lo16 sum's low bits */
    "\tlw\t$v1,24($sp)\n"          /* v1 = a3 (the hi 32-bit half, possibly +1) */
    "\tlw\t$a1,32($sp)\n"          /* a1 = a5 (5th stack arg) */
    "\tor\t$v0,$v0,$a0\n"          /* v0 = out[0] = (hi16<<16)|lo16 */
    "\tsw\t$v0,20($sp)\n"
    "\taddu\t$v1,$v1,$a1\n"        /* v1 = a3 + a5 */
    "\tsw\t$v1,24($sp)\n"
    "\tlw\t$v0,20($sp)\n"
    "\tlw\t$v1,24($sp)\n"
    "\tsw\t$v0,0($t1)\n"           /* out[0] */
    "\tsw\t$v1,4($t1)\n"           /* out[1] */
    "\taddu\t$v0,$t1,$zero\n"      /* return out */
    "\tjr\t$ra\n"
    "\t addiu\t$sp,$sp,16\n"
    "\t.set pop\n"
);
#else
extern int *_add_mant_d(int *out, unsigned int a2, int a3, unsigned int a4, int a5)   /* @0x80106F70 */
{
    unsigned int v5 = (a4 >> 16) & 0xffff;
    int          v8 = a3;
    int          v7 = (a2 >> 16) & 0xffff;
    if (((((a2 & 0xffff) + (a4 & 0xffff)) & 0x10000) != 0))
        v7 = ((a2 >> 16) & 0xffff) + 1;
    if (((v7 + v5) & 0x10000) != 0)
        v8 = a3 + 1;
    out[0] = (int)(((unsigned int)(v7 + v5) << 16) | (unsigned int)((a2 + a4) & 0xffff));
    out[1] = v8 + a5;
    return out;
}
#endif
