/* eaclib/psx/eacpsxz/crc.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\crc.obj  (archive EACPSXZ.LIB)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\CRC.ASM (per SYM SLD -- tables @0x80135C58 line
 *   49, code @0x800F614C line 145). ONE XDEF: crc16 @0x800F614C (50 insns, 0xC8). Table-driven CRC-16
 *   with a 4-byte-unrolled body + 1-byte tail and hand-scheduled register juggling no C compiler
 *   reproduces (the C recon FAILed 106). Transcribed VERBATIM; C fallback for the host build.
 *
 *   Two 256-byte tables live contiguously at the single blob symbol D_80135C58 (table A = [0..255],
 *   table B = [256..511]); the oracle reaches B as `lbu ...,0x100($t3)`. Per byte b (running lo,hi,
 *   init hi=0xFB lo=0xEA):  i = b ^ lo;  lo = A[i] ^ hi;  hi = B[i].  return lo | (hi << 8).
 *   maspsx: load offsets DECIMAL (256 == 0x100); immediates DECIMAL; `.set noreorder`.
 */
extern const unsigned char D_80135C58[512];   /* @0x80135C58 : CRC-16 tables A[0..255] + B[256..511] (blob-owned) */

#if defined(__mips__)
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */
    "\t.globl crc16\n"             /* @0x800F614C : unsigned crc16(unsigned char *buf, int len) */
    "crc16:\n"
    "\tlui\t$t0,%hi(D_80135C58)\n"
    "\taddiu\t$t0,$t0,%lo(D_80135C58)\n"  /* t0 = &table */
    "\taddiu\t$v1,$zero,251\n"      /* hi = 0xFB */
    "\taddiu\t$a1,$a1,-4\n"         /* len -= 4 */
    "\tbltz\t$a1,.L800F61D0\n"      /* < 4 left -> tail */
    "\t addiu\t$v0,$zero,234\n"     /* delay: lo = 0xEA */
    ".L800F6164:\n"                 /* 4-byte unrolled body */
    "\tlbu\t$t1,0($a0)\n"
    "\tlbu\t$t2,1($a0)\n"
    "\txor\t$t1,$t1,$v0\n"          /* i = b0 ^ lo */
    "\taddu\t$t3,$t1,$t0\n"
    "\tlbu\t$t4,0($t3)\n"           /* A[i] */
    "\tlbu\t$t5,256($t3)\n"         /* B[i] */
    "\txor\t$v0,$t4,$v1\n"          /* lo = A[i] ^ hi */
    "\txor\t$t2,$t2,$v0\n"          /* i = b1 ^ lo */
    "\taddu\t$t3,$t2,$t0\n"
    "\tlbu\t$t4,0($t3)\n"
    "\tlbu\t$v1,256($t3)\n"         /* hi = B[i] */
    "\txor\t$v0,$t4,$t5\n"          /* lo = A[i] ^ B[prev] */
    "\tlbu\t$t1,2($a0)\n"
    "\tlbu\t$t2,3($a0)\n"
    "\txor\t$t1,$t1,$v0\n"
    "\taddu\t$t3,$t1,$t0\n"
    "\tlbu\t$t4,0($t3)\n"
    "\tlbu\t$t5,256($t3)\n"
    "\txor\t$v0,$t4,$v1\n"
    "\txor\t$t2,$t2,$v0\n"
    "\taddu\t$t3,$t2,$t0\n"
    "\tlbu\t$t4,0($t3)\n"
    "\tlbu\t$v1,256($t3)\n"
    "\txor\t$v0,$t4,$t5\n"
    "\taddiu\t$a1,$a1,-4\n"
    "\tbgez\t$a1,.L800F6164\n"
    "\t addiu\t$a0,$a0,4\n"
    ".L800F61D0:\n"
    "\taddiu\t$a1,$a1,3\n"          /* undo the over-subtract for the tail */
    "\tbltz\t$a1,.L800F6208\n"
    "\t nop\n"
    ".L800F61DC:\n"                 /* 1-byte tail loop */
    "\tlbu\t$t1,0($a0)\n"
    "\tnop\n"
    "\txor\t$t1,$t1,$v0\n"
    "\taddu\t$t3,$t1,$t0\n"
    "\tlbu\t$t4,0($t3)\n"
    "\tlbu\t$t5,256($t3)\n"
    "\txor\t$v0,$t4,$v1\n"          /* lo = A[i] ^ hi */
    "\taddu\t$v1,$t5,$zero\n"       /* hi = B[i] */
    "\taddiu\t$a1,$a1,-1\n"
    "\tbgez\t$a1,.L800F61DC\n"
    "\t addiu\t$a0,$a0,1\n"
    ".L800F6208:\n"
    "\tsll\t$v1,$v1,8\n"            /* hi << 8 */
    "\tjr\t$ra\n"
    "\t or\t$v0,$v0,$v1\n"          /* return lo | (hi << 8) */
    "\t.set pop\n"
);
#else
extern unsigned int crc16(unsigned char *buf, int len)   /* @0x800F614C */
{
    unsigned int hi = 0xFB, lo = 0xEA;
    while (len-- > 0) {
        unsigned i   = (unsigned char)(*buf++ ^ lo);
        unsigned nlo = (unsigned char)(D_80135C58[i] ^ hi);   /* table A */
        hi = D_80135C58[256 + i];                             /* table B */
        lo = nlo;
    }
    return lo | (hi << 8);
}
#endif
