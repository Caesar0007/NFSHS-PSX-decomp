/* eaclib/psx/eacpsxz/blkfill.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\blkfill.obj  (archive EACPSXZ.LIB)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\BLKFILL.ASM (per SYM SLD @0x800F17A0 line 8).
 *   TWO XDEF entries: blockclear @0x800F17A0 (1 insn -- sets val=0 then FALLS THROUGH) and
 *   blockfill @0x800F17A4 (80 insns, 0x140). The filler is a hand-tuned memset: broadcast the low byte
 *   of `val` to a 32-bit word, `swr` the unaligned head, run unrolled 0x80/0x10/4-byte aligned `sw`
 *   loops, then `swl` the tail (a <4 path does byte `sb`). No C compiler emits this (the C recon FAILed
 *   85). Transcribed VERBATIM -- blockclear + blockfill in ONE __asm__ block so blockclear's single
 *   insn falls straight into blockfill (contiguous). C fallback (plain memset) for the host build.
 *
 *   Observable: blockfill(dst,n,val) == memset(dst,(unsigned char)val,n); blockclear(dst,n)==memset 0.
 *   maspsx: all load/store displacements + immediates are DECIMAL (maspsx int()-parses base-10);
 *   `.set noat` for the explicit $at (slti); `.set noreorder` -> every delay slot is filled by hand.
 */

#if defined(__mips__)
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */

    "\t.globl blockclear\n"        /* @0x800F17A0 : void blockclear(void *dst, int n) */
    "blockclear:\n"
    "\taddiu\t$a2,$zero,0\n"        /* val = 0, then FALL THROUGH into blockfill */

    "\t.globl blockfill\n"         /* @0x800F17A4 : void blockfill(void *dst, int n, unsigned char val) */
    "blockfill:\n"
    "\tslti\t$at,$a1,4\n"           /* n < 4 -> byte-fill tail */
    "\tbnez\t$at,.L800F18C4\n"
    "\t andi\t$a2,$a2,255\n"        /* delay: val &= 0xFF */
    "\tsll\t$t2,$a2,8\n"
    "\tor\t$a2,$a2,$t2\n"
    "\tsll\t$t2,$a2,16\n"
    "\tor\t$a2,$a2,$t2\n"           /* a2 = val broadcast into 4 bytes */
    "\tswr\t$a2,0($a0)\n"           /* fill the unaligned head */
    "\taddiu\t$t0,$zero,4\n"
    "\tandi\t$t1,$a0,3\n"
    "\tsubu\t$t0,$t0,$t1\n"         /* t0 = bytes to 4-align dst */
    "\taddu\t$a0,$a0,$t0\n"
    "\tsubu\t$a1,$a1,$t0\n"
    "\taddiu\t$a1,$a1,-128\n"
    "\tbltz\t$a1,.L800F1870\n"
    "\t nop\n"
    ".L800F17E4:\n"                 /* 0x80-byte unrolled loop (32 words) */
    "\tsw\t$a2,0($a0)\n"
    "\tsw\t$a2,4($a0)\n"
    "\tsw\t$a2,8($a0)\n"
    "\tsw\t$a2,12($a0)\n"
    "\tsw\t$a2,16($a0)\n"
    "\tsw\t$a2,20($a0)\n"
    "\tsw\t$a2,24($a0)\n"
    "\tsw\t$a2,28($a0)\n"
    "\tsw\t$a2,32($a0)\n"
    "\tsw\t$a2,36($a0)\n"
    "\tsw\t$a2,40($a0)\n"
    "\tsw\t$a2,44($a0)\n"
    "\tsw\t$a2,48($a0)\n"
    "\tsw\t$a2,52($a0)\n"
    "\tsw\t$a2,56($a0)\n"
    "\tsw\t$a2,60($a0)\n"
    "\tsw\t$a2,64($a0)\n"
    "\tsw\t$a2,68($a0)\n"
    "\tsw\t$a2,72($a0)\n"
    "\tsw\t$a2,76($a0)\n"
    "\tsw\t$a2,80($a0)\n"
    "\tsw\t$a2,84($a0)\n"
    "\tsw\t$a2,88($a0)\n"
    "\tsw\t$a2,92($a0)\n"
    "\tsw\t$a2,96($a0)\n"
    "\tsw\t$a2,100($a0)\n"
    "\tsw\t$a2,104($a0)\n"
    "\tsw\t$a2,108($a0)\n"
    "\tsw\t$a2,112($a0)\n"
    "\tsw\t$a2,116($a0)\n"
    "\tsw\t$a2,120($a0)\n"
    "\tsw\t$a2,124($a0)\n"
    "\taddiu\t$a1,$a1,-128\n"
    "\tbgez\t$a1,.L800F17E4\n"
    "\t addiu\t$a0,$a0,128\n"
    ".L800F1870:\n"
    "\taddiu\t$a1,$a1,112\n"
    "\tbltz\t$a1,.L800F1898\n"
    "\t nop\n"
    ".L800F187C:\n"                 /* 0x10-byte loop (4 words) */
    "\tsw\t$a2,0($a0)\n"
    "\tsw\t$a2,4($a0)\n"
    "\tsw\t$a2,8($a0)\n"
    "\tsw\t$a2,12($a0)\n"
    "\taddiu\t$a1,$a1,-16\n"
    "\tbgez\t$a1,.L800F187C\n"
    "\t addiu\t$a0,$a0,16\n"
    ".L800F1898:\n"
    "\taddiu\t$a1,$a1,12\n"
    "\tbltz\t$a1,.L800F18B4\n"
    "\t nop\n"
    ".L800F18A4:\n"                 /* 4-byte loop (1 word) */
    "\tsw\t$a2,0($a0)\n"
    "\taddiu\t$a1,$a1,-4\n"
    "\tbgez\t$a1,.L800F18A4\n"
    "\t addiu\t$a0,$a0,4\n"
    ".L800F18B4:\n"
    "\taddu\t$a0,$a0,$a1\n"         /* back up by the negative leftover */
    "\tswl\t$a2,3($a0)\n"           /* fill the unaligned tail */
    "\tjr\t$ra\n"
    "\t nop\n"
    ".L800F18C4:\n"                 /* n < 4 : plain byte fill */
    "\taddiu\t$a1,$a1,-1\n"
    "\tbltz\t$a1,.L800F18DC\n"
    ".L800F18CC:\n"                 /* (loop top IS the bltz delay slot) */
    "\t addiu\t$a1,$a1,-1\n"
    "\tsb\t$a2,0($a0)\n"
    "\tbgez\t$a1,.L800F18CC\n"
    "\t addiu\t$a0,$a0,1\n"
    ".L800F18DC:\n"
    "\tjr\t$ra\n"
    "\t nop\n"
    "\t.set pop\n"
);
#else  /* host build -- plain memset behavior */
extern "C" void blockfill(void *dst, int n, unsigned char val)   /* @0x800F17A4 */
{
    unsigned char *d = (unsigned char *)dst;
    while (n-- > 0)
        *d++ = val;
}
extern "C" void blockclear(void *dst, int n)   /* @0x800F17A0 */
{
    blockfill(dst, n, 0);
}
#endif
