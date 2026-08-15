/* eaclib/psx/eacpsxz/blkfill.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\blkfill.obj  (archive EACPSXZ.LIB)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\BLKFILL.ASM (per SYM SLD @0x800F17A0 line 8).
 *   TWO XDEF entries: blockclear @0x800F17A0 (1 insn -- sets val=0 then FALLS THROUGH) and
 *   blockfill @0x800F17A4 (80 insns, 0x140). The filler is a hand-tuned memset: broadcast the low byte
 *   of `val` to a 32-bit word, `swr` the unaligned head, run unrolled 0x80/0x10/4-byte aligned `sw`
 *   loops, then `swl` the tail (a <4 path does byte `sb`). No C compiler emits this (the C recon FAILed
 /* ASPSX-DIALECT (w64-a20): the asm below uses NUMERIC registers and no
  * `.set push/pop` -- ASPSX 2.77, the PRODUCTION assembler, rejects ABI
  * register NAMES and push/pop.  $0 zero $1 at $2-3 v0-v1 $4-7 a0-a3
  * $8-15 t0-t7 $16-23 s0-s7 $24-25 t8-t9 $28 gp $29 sp $30 fp $31 ra.
  * Gate-lane object is byte-identical (proven by hash); see
  * scratchpad/w64a20/RECEIPTS.md. */
 *   85). Transcribed VERBATIM -- blockclear + blockfill in ONE __asm__ block so blockclear's single
 *   insn falls straight into blockfill (contiguous). C fallback (plain memset) for the host build.
 *
 *   Observable: blockfill(dst,n,val) == memset(dst,(unsigned char)val,n); blockclear(dst,n)==memset 0.
 *   maspsx: all load/store displacements + immediates are DECIMAL (maspsx int()-parses base-10);
 *   `.set noat` for the explicit $at (slti); `.set noreorder` -> every delay slot is filled by hand.
 */

#if defined(__mips__)
__asm__(
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */

    "\t.globl blockclear\n"        /* @0x800F17A0 : void blockclear(void *dst, int n) */
    "blockclear:\n"
    "\taddiu\t$6,$0,0\n"        /* val = 0, then FALL THROUGH into blockfill */

    "\t.globl blockfill\n"         /* @0x800F17A4 : void blockfill(void *dst, int n, unsigned char val) */
    "blockfill:\n"
    "\tslti\t$1,$5,4\n"           /* n < 4 -> byte-fill tail */
    "\tbnez\t$1,.L800F18C4\n"
    "\t andi\t$6,$6,255\n"        /* delay: val &= 0xFF */
    "\tsll\t$10,$6,8\n"
    "\tor\t$6,$6,$10\n"
    "\tsll\t$10,$6,16\n"
    "\tor\t$6,$6,$10\n"           /* a2 = val broadcast into 4 bytes */
    "\tswr\t$6,0($4)\n"           /* fill the unaligned head */
    "\taddiu\t$8,$0,4\n"
    "\tandi\t$9,$4,3\n"
    "\tsubu\t$8,$8,$9\n"         /* t0 = bytes to 4-align dst */
    "\taddu\t$4,$4,$8\n"
    "\tsubu\t$5,$5,$8\n"
    "\taddiu\t$5,$5,-128\n"
    "\tbltz\t$5,.L800F1870\n"
    "\t nop\n"
    ".L800F17E4:\n"                 /* 0x80-byte unrolled loop (32 words) */
    "\tsw\t$6,0($4)\n"
    "\tsw\t$6,4($4)\n"
    "\tsw\t$6,8($4)\n"
    "\tsw\t$6,12($4)\n"
    "\tsw\t$6,16($4)\n"
    "\tsw\t$6,20($4)\n"
    "\tsw\t$6,24($4)\n"
    "\tsw\t$6,28($4)\n"
    "\tsw\t$6,32($4)\n"
    "\tsw\t$6,36($4)\n"
    "\tsw\t$6,40($4)\n"
    "\tsw\t$6,44($4)\n"
    "\tsw\t$6,48($4)\n"
    "\tsw\t$6,52($4)\n"
    "\tsw\t$6,56($4)\n"
    "\tsw\t$6,60($4)\n"
    "\tsw\t$6,64($4)\n"
    "\tsw\t$6,68($4)\n"
    "\tsw\t$6,72($4)\n"
    "\tsw\t$6,76($4)\n"
    "\tsw\t$6,80($4)\n"
    "\tsw\t$6,84($4)\n"
    "\tsw\t$6,88($4)\n"
    "\tsw\t$6,92($4)\n"
    "\tsw\t$6,96($4)\n"
    "\tsw\t$6,100($4)\n"
    "\tsw\t$6,104($4)\n"
    "\tsw\t$6,108($4)\n"
    "\tsw\t$6,112($4)\n"
    "\tsw\t$6,116($4)\n"
    "\tsw\t$6,120($4)\n"
    "\tsw\t$6,124($4)\n"
    "\taddiu\t$5,$5,-128\n"
    "\tbgez\t$5,.L800F17E4\n"
    "\t addiu\t$4,$4,128\n"
    ".L800F1870:\n"
    "\taddiu\t$5,$5,112\n"
    "\tbltz\t$5,.L800F1898\n"
    "\t nop\n"
    ".L800F187C:\n"                 /* 0x10-byte loop (4 words) */
    "\tsw\t$6,0($4)\n"
    "\tsw\t$6,4($4)\n"
    "\tsw\t$6,8($4)\n"
    "\tsw\t$6,12($4)\n"
    "\taddiu\t$5,$5,-16\n"
    "\tbgez\t$5,.L800F187C\n"
    "\t addiu\t$4,$4,16\n"
    ".L800F1898:\n"
    "\taddiu\t$5,$5,12\n"
    "\tbltz\t$5,.L800F18B4\n"
    "\t nop\n"
    ".L800F18A4:\n"                 /* 4-byte loop (1 word) */
    "\tsw\t$6,0($4)\n"
    "\taddiu\t$5,$5,-4\n"
    "\tbgez\t$5,.L800F18A4\n"
    "\t addiu\t$4,$4,4\n"
    ".L800F18B4:\n"
    "\taddu\t$4,$4,$5\n"         /* back up by the negative leftover */
    "\tswl\t$6,3($4)\n"           /* fill the unaligned tail */
    "\tjr\t$31\n"
    "\t nop\n"
    ".L800F18C4:\n"                 /* n < 4 : plain byte fill */
    "\taddiu\t$5,$5,-1\n"
    "\tbltz\t$5,.L800F18DC\n"
    ".L800F18CC:\n"                 /* (loop top IS the bltz delay slot) */
    "\t addiu\t$5,$5,-1\n"
    "\tsb\t$6,0($4)\n"
    "\tbgez\t$5,.L800F18CC\n"
    "\t addiu\t$4,$4,1\n"
    ".L800F18DC:\n"
    "\tjr\t$31\n"
    "\t nop\n"
    "\t.set at\n"
    "\t.set reorder\n"
);
#else  /* host build -- plain memset behavior */
extern void blockfill(void *dst, int n, unsigned char val)   /* @0x800F17A4 */
{
    unsigned char *d = (unsigned char *)dst;
    while (n-- > 0)
        *d++ = val;
}
extern void blockclear(void *dst, int n)   /* @0x800F17A0 */
{
    blockfill(dst, n, 0);
}
#endif
