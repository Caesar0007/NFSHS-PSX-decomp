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
/* ASPSX-DIALECT (w64-a20): the asm below uses NUMERIC registers and no
 * `.set push/pop` -- ASPSX 2.77, the PRODUCTION assembler, rejects ABI
 * register NAMES and push/pop.  $0 zero $1 at $2-3 v0-v1 $4-7 a0-a3
 * $8-15 t0-t7 $16-23 s0-s7 $24-25 t8-t9 $28 gp $29 sp $30 fp $31 ra.
 * Gate-lane object is byte-identical (proven by hash); see
 * scratchpad/w64a20/RECEIPTS.md. */
__asm__(
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */
    "\t.globl crc16\n"             /* @0x800F614C : unsigned crc16(unsigned char *buf, int len) */
    "crc16:\n"
    "\tlui\t$8,%hi(D_80135C58)\n"
    "\taddiu\t$8,$8,%lo(D_80135C58)\n"  /* t0 = &table */
    "\taddiu\t$3,$0,251\n"      /* hi = 0xFB */
    "\taddiu\t$5,$5,-4\n"         /* len -= 4 */
    "\tbltz\t$5,.L800F61D0\n"      /* < 4 left -> tail */
    "\t addiu\t$2,$0,234\n"     /* delay: lo = 0xEA */
    ".L800F6164:\n"                 /* 4-byte unrolled body */
    "\tlbu\t$9,0($4)\n"
    "\tlbu\t$10,1($4)\n"
    "\txor\t$9,$9,$2\n"          /* i = b0 ^ lo */
    "\taddu\t$11,$9,$8\n"
    "\tlbu\t$12,0($11)\n"           /* A[i] */
    "\tlbu\t$13,256($11)\n"         /* B[i] */
    "\txor\t$2,$12,$3\n"          /* lo = A[i] ^ hi */
    "\txor\t$10,$10,$2\n"          /* i = b1 ^ lo */
    "\taddu\t$11,$10,$8\n"
    "\tlbu\t$12,0($11)\n"
    "\tlbu\t$3,256($11)\n"         /* hi = B[i] */
    "\txor\t$2,$12,$13\n"          /* lo = A[i] ^ B[prev] */
    "\tlbu\t$9,2($4)\n"
    "\tlbu\t$10,3($4)\n"
    "\txor\t$9,$9,$2\n"
    "\taddu\t$11,$9,$8\n"
    "\tlbu\t$12,0($11)\n"
    "\tlbu\t$13,256($11)\n"
    "\txor\t$2,$12,$3\n"
    "\txor\t$10,$10,$2\n"
    "\taddu\t$11,$10,$8\n"
    "\tlbu\t$12,0($11)\n"
    "\tlbu\t$3,256($11)\n"
    "\txor\t$2,$12,$13\n"
    "\taddiu\t$5,$5,-4\n"
    "\tbgez\t$5,.L800F6164\n"
    "\t addiu\t$4,$4,4\n"
    ".L800F61D0:\n"
    "\taddiu\t$5,$5,3\n"          /* undo the over-subtract for the tail */
    "\tbltz\t$5,.L800F6208\n"
    "\t nop\n"
    ".L800F61DC:\n"                 /* 1-byte tail loop */
    "\tlbu\t$9,0($4)\n"
    "\tnop\n"
    "\txor\t$9,$9,$2\n"
    "\taddu\t$11,$9,$8\n"
    "\tlbu\t$12,0($11)\n"
    "\tlbu\t$13,256($11)\n"
    "\txor\t$2,$12,$3\n"          /* lo = A[i] ^ hi */
    "\taddu\t$3,$13,$0\n"       /* hi = B[i] */
    "\taddiu\t$5,$5,-1\n"
    "\tbgez\t$5,.L800F61DC\n"
    "\t addiu\t$4,$4,1\n"
    ".L800F6208:\n"
    "\tsll\t$3,$3,8\n"            /* hi << 8 */
    "\tjr\t$31\n"
    "\t or\t$2,$2,$3\n"          /* return lo | (hi << 8) */
    "\t.set at\n"
    "\t.set reorder\n"
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
