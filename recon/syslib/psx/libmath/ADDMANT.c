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
    ""
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */

    "\t.globl _add_mant_d\n"       /* @0x80106F70 : int *_add_mant_d(int *out,uint a2,int a3,uint a4,int a5) */
    "_add_mant_d:\n"
    "\taddiu\t$29,$29,-16\n"
    "\taddu\t$9,$4,$0\n"      /* t1 = out */
    "\tsrl\t$8,$5,16\n"          /* t0 = a2 hi16 */
    "\tsw\t$5,20($29)\n"          /* spill raw a2 */
    "\tandi\t$5,$5,0xFFFF\n"     /* a1 = a2 lo16 */
    "\tsrl\t$3,$7,16\n"          /* v1 = a4 hi16 */
    "\tsw\t$7,28($29)\n"          /* spill raw a4 */
    "\tandi\t$7,$7,0xFFFF\n"     /* a3 = a4 lo16 */
    "\taddu\t$4,$5,$7\n"        /* a0 = a2lo + a4lo */
    "\tsw\t$5,0($29)\n"
    "\tlui\t$5,1\n"               /* a1 = 0x10000 */
    "\tand\t$2,$4,$5\n"         /* carry-out of the lo16 add? */
    "\tsw\t$6,24($29)\n"          /* spill a3 (the hi 32-bit half) */
    "\tsw\t$8,4($29)\n"           /* a2 hi16 slot */
    "\tsw\t$3,12($29)\n"          /* a4 hi16 slot */
    "\tsw\t$7,8($29)\n"           /* a4 lo16 slot */
    "\tbeqz\t$2,.L80106FC0\n"
    "\t sw\t$4,0($29)\n"          /* delay: stash lo16 sum (pre-carry) */
    "\taddiu\t$2,$8,1\n"         /* carry: a2hi16 + 1 */
    "\tsw\t$2,4($29)\n"
    ".L80106FC0:\n"
    "\tlw\t$2,4($29)\n"           /* v0 = (carried) a2 hi16 */
    "\tnop\n"
    "\taddu\t$7,$2,$3\n"        /* a3 = a2hi16 + a4hi16 */
    "\tand\t$2,$7,$5\n"         /* carry-out of the hi16 add? */
    "\tbeqz\t$2,.L80106FE0\n"
    "\t sw\t$7,4($29)\n"          /* delay: stash hi16 sum (pre-carry) */
    "\taddiu\t$6,$6,1\n"         /* carry into a3 (the hi 32-bit half) */
    "\tsw\t$6,24($29)\n"
    ".L80106FE0:\n"
    "\tsll\t$2,$7,16\n"          /* v0 = (carried) a2 hi16 << 16 */
    "\tandi\t$4,$4,0xFFFF\n"     /* a0 = lo16 sum's low bits */
    "\tlw\t$3,24($29)\n"          /* v1 = a3 (the hi 32-bit half, possibly +1) */
    "\tlw\t$5,32($29)\n"          /* a1 = a5 (5th stack arg) */
    "\tor\t$2,$2,$4\n"          /* v0 = out[0] = (hi16<<16)|lo16 */
    "\tsw\t$2,20($29)\n"
    "\taddu\t$3,$3,$5\n"        /* v1 = a3 + a5 */
    "\tsw\t$3,24($29)\n"
    "\tlw\t$2,20($29)\n"
    "\tlw\t$3,24($29)\n"
    "\tsw\t$2,0($9)\n"           /* out[0] */
    "\tsw\t$3,4($9)\n"           /* out[1] */
    "\taddu\t$2,$9,$0\n"      /* return out */
    "\tjr\t$31\n"
    "\t addiu\t$29,$29,16\n"
    "\t.set reorder\n\t.set at\n"
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
