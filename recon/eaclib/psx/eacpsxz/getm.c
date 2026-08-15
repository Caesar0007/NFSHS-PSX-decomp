/* eaclib/psx/eacpsxz/getm.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\getm.obj  (archive EACPSXZ.LIB)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\GETM.ASM (per SYM SLD @0x800F3024 line 7).
 *   TWO XDEFs: getm @0x800F3024 (26 insns, 0x68) + geti @0x800F308C (8 insns, 0x20). Byte-field
 *   readers no C compiler reproduces (getm's branch cascade with the shift/or filled into jr delay
 *   slots; geti's lwl/lwr unaligned load) -- the C recon FAILed 54/22. Transcribed VERBATIM; C
 *   fallback for the host build.
 *
 *     getm(p,n)  : read an n-byte (1..4) BIG-endian field from p, returned as an int.
 *     geti(p,nb) : unaligned little-endian word at p (lwl/lwr), masked to the low nb*8 bits.
 *   maspsx: load offsets DECIMAL; immediates DECIMAL; `.set noreorder`; the `or rd,zero,rs` reg-move
 *   is byte-identical to the oracle (verify_asm's or-move normalizer).
 */

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

    "\t.globl getm\n"              /* @0x800F3024 : int getm(unsigned char *p, int n) */
    "getm:\n"
    "\tlbu\t$9,0($4)\n"           /* b0 = p[0] */
    "\taddiu\t$8,$5,-3\n"         /* n - 3 */
    "\tbltz\t$8,.L800F306C\n"      /* n < 3 */
    "\t sll\t$2,$9,8\n"          /* delay: v0 = b0 << 8 */
    "\tlbu\t$10,1($4)\n"           /* b1 = p[1] */
    "\tbeqz\t$8,.L800F305C\n"      /* n == 3 */
    "\t or\t$2,$2,$10\n"         /* delay: v0 = (b0<<8)|b1 */
    "\tlbu\t$11,2($4)\n"           /* n == 4: b2 = p[2] */
    "\tlbu\t$12,3($4)\n"           /* b3 = p[3] */
    "\tsll\t$2,$2,16\n"
    "\tsll\t$11,$11,8\n"
    "\tor\t$11,$11,$12\n"
    "\tjr\t$31\n"
    "\t or\t$2,$2,$11\n"          /* delay: full 32-bit */
    ".L800F305C:\n"                 /* n == 3 */
    "\tlbu\t$11,2($4)\n"
    "\tsll\t$2,$2,8\n"
    "\tjr\t$31\n"
    "\t or\t$2,$2,$11\n"          /* delay: (b0<<16)|(b1<<8)|b2 */
    ".L800F306C:\n"                 /* n < 3 */
    "\tlbu\t$10,1($4)\n"
    "\taddiu\t$8,$5,-2\n"         /* n - 2 */
    "\tbltz\t$8,.L800F3084\n"      /* n < 2 */
    "\t nop\n"
    "\tjr\t$31\n"
    "\t or\t$2,$2,$10\n"          /* delay: n == 2 -> (b0<<8)|b1 */
    ".L800F3084:\n"                 /* n == 1 */
    "\tjr\t$31\n"
    "\t or\t$2,$0,$9\n"        /* delay: v0 = b0 */

    "\t.globl geti\n"              /* @0x800F308C : unsigned geti(void *p, char nbits) */
    "geti:\n"
    "\tlwl\t$8,3($4)\n"           /* unaligned LE word */
    "\tlwr\t$8,0($4)\n"
    "\taddiu\t$9,$0,32\n"
    "\tsll\t$5,$5,3\n"            /* nbits * 8 */
    "\tsubu\t$5,$9,$5\n"         /* shift = 32 - nbits*8 */
    "\tsllv\t$8,$8,$5\n"
    "\tjr\t$31\n"
    "\t srlv\t$2,$8,$5\n"        /* delay: mask off the high bits */
    "\t.set at\n"
    "\t.set reorder\n"
);
#else
extern int getm(unsigned char *p, int n)   /* @0x800F3024 */
{
    if (n - 3 < 0) {
        if (-1 < n - 2)
            return (int)(((unsigned int)p[0] << 8) | p[1]);
        return (int)(unsigned int)p[0];
    }
    if (n != 3)
        return (int)(((unsigned int)p[0] << 24) | ((unsigned int)p[1] << 16) |
                     ((unsigned int)p[2] << 8) | p[3]);
    return (int)(((unsigned int)p[0] << 16) | ((unsigned int)p[1] << 8) | p[2]);
}

extern unsigned int geti(void *p, char nbits)   /* @0x800F308C */
{
    unsigned char *b = (unsigned char *)p;
    unsigned int word = (unsigned int)b[0] | ((unsigned int)b[1] << 8) |
                        ((unsigned int)b[2] << 16) | ((unsigned int)b[3] << 24);
    unsigned int sh = (unsigned int)(0x20 - ((int)nbits << 3)) & 0x1f;
    return (word << sh) >> sh;
}
#endif
