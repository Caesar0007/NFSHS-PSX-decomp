/* eaclib/psx/eacpsxz/math64a.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\math64a.obj  (archive EACPSXZ.LIB)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\MATH64.ASM (per SYM SLD @0x800FE488 line 96; the
 *   make64 oracle is tagged "Handwritten function" and carries TRAPPING `addi`/`sub` non-`u` ops marked
 *   "handwritten instruction"). TWO XDEFs: make64 @0x800FE488 (22 insns, 0x58) + divu64 @0x800FE4E0
 *   (16 insns, 0x40). 64-bit helpers -- the PSX MIPS-I has no 64-bit ops. Transcribed VERBATIM as a
 *   file-scope __asm__ (byte-identical); C fallback for the host build.
 *
 *     make64(out,y,shift)  : out[0:1] = sign-extended `y` shifted left by `shift` (>=32 / 0<..<32 / <=0).
 *     divu64(hi,lo,den)    : (hi:lo) / den via a 32-iteration shift-subtract; returns the quotient.
 *   maspsx: store offsets + immediates DECIMAL; trapping `addi`/`sub` pass through (valid MIPS, just
 *   never emitted by C) exactly like fixddiv/rdiv's `sub`.
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

    "\t.globl make64\n"            /* @0x800FE488 : void make64(int *out, int y, int shift) */
    "make64:\n"
    "\tslti\t$8,$6,32\n"          /* shift < 32 ? */
    "\tbnez\t$8,.L800FE4A8\n"
    "\t addi\t$9,$6,-32\n"        /* delay: t1 = shift - 32 (TRAPPING addi, handwritten) */
    "\tsllv\t$14,$5,$9\n"         /* y << (shift-32) */
    "\tsw\t$0,0($4)\n"          /* out[0] = 0 */
    "\tsw\t$14,4($4)\n"            /* out[1] = t6 */
    "\tjr\t$31\n"
    "\t nop\n"
    ".L800FE4A8:\n"
    "\tblez\t$6,.L800FE4CC\n"      /* shift <= 0 ? */
    "\t addiu\t$11,$0,32\n"      /* delay: t3 = 32 */
    "\tsub\t$10,$11,$6\n"          /* t2 = 32 - shift (TRAPPING sub, handwritten) */
    "\tsllv\t$13,$5,$6\n"         /* y << shift */
    "\tsrav\t$14,$5,$10\n"         /* y >> (32-shift)  (arithmetic) */
    "\tsw\t$13,0($4)\n"            /* out[0] = t5 */
    "\tsw\t$14,4($4)\n"            /* out[1] = t6 */
    "\tjr\t$31\n"
    "\t nop\n"
    ".L800FE4CC:\n"
    "\tsw\t$5,0($4)\n"            /* out[0] = y */
    "\tsra\t$14,$5,31\n"           /* out[1] = y >> 31 (sign extend) */
    "\tsw\t$14,4($4)\n"
    "\tjr\t$31\n"
    "\t nop\n"

    "\t.globl divu64\n"            /* @0x800FE4E0 : int divu64(int hi, int lo, unsigned den) */
    "divu64:\n"
    "\taddiu\t$2,$0,0\n"        /* q = 0 */
    "\taddiu\t$9,$0,32\n"
    "\taddiu\t$9,$9,-1\n"         /* i = 31 */
    ".L800FE4EC:\n"
    "\tsll\t$2,$2,1\n"            /* q <<= 1 */
    "\tsll\t$5,$5,1\n"            /* lo <<= 1 */
    "\tsrl\t$10,$4,31\n"           /* top bit of hi */
    "\taddu\t$5,$5,$10\n"         /* shift it into lo */
    "\tsltu\t$11,$5,$6\n"         /* lo < den ? */
    "\tbnez\t$11,.L800FE510\n"
    "\t sll\t$4,$4,1\n"          /* delay: hi <<= 1 */
    "\tsubu\t$5,$5,$6\n"         /* lo -= den */
    "\taddiu\t$2,$2,1\n"          /* q += 1 */
    ".L800FE510:\n"
    "\tbnez\t$9,.L800FE4EC\n"
    "\t addiu\t$9,$9,-1\n"        /* delay: i-- */
    "\tjr\t$31\n"
    "\t nop\n"
    "\t.set at\n"
    "\t.set reorder\n"
);
#else
extern void make64(int *out, int y, unsigned int shift)   /* @0x800FE488 */
{
    if (0x1f < (int)shift) {
        out[0] = 0;
        out[1] = y << ((shift - 0x20) & 0x1f);
    } else if (0 < (int)shift) {
        out[0] = y << (shift & 0x1f);
        out[1] = y >> ((0x20 - shift) & 0x1f);
    } else {
        out[0] = y;
        out[1] = y >> 0x1f;
    }
}

extern int divu64(int hi, int lo, unsigned int den)   /* @0x800FE4E0 */
{
    int q = 0;
    int i = 0x1f;
    do {
        q  = q * 2;
        lo = lo * 2 - (hi >> 0x1f);
        hi = hi << 1;
        if (den <= (unsigned int)lo) {
            lo = lo - (int)den;
            q  = q + 1;
        }
    } while (i-- != 0);
    return q;
}
#endif
