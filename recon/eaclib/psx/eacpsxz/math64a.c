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
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */

    "\t.globl make64\n"            /* @0x800FE488 : void make64(int *out, int y, int shift) */
    "make64:\n"
    "\tslti\t$t0,$a2,32\n"          /* shift < 32 ? */
    "\tbnez\t$t0,.L800FE4A8\n"
    "\t addi\t$t1,$a2,-32\n"        /* delay: t1 = shift - 32 (TRAPPING addi, handwritten) */
    "\tsllv\t$t6,$a1,$t1\n"         /* y << (shift-32) */
    "\tsw\t$zero,0($a0)\n"          /* out[0] = 0 */
    "\tsw\t$t6,4($a0)\n"            /* out[1] = t6 */
    "\tjr\t$ra\n"
    "\t nop\n"
    ".L800FE4A8:\n"
    "\tblez\t$a2,.L800FE4CC\n"      /* shift <= 0 ? */
    "\t addiu\t$t3,$zero,32\n"      /* delay: t3 = 32 */
    "\tsub\t$t2,$t3,$a2\n"          /* t2 = 32 - shift (TRAPPING sub, handwritten) */
    "\tsllv\t$t5,$a1,$a2\n"         /* y << shift */
    "\tsrav\t$t6,$a1,$t2\n"         /* y >> (32-shift)  (arithmetic) */
    "\tsw\t$t5,0($a0)\n"            /* out[0] = t5 */
    "\tsw\t$t6,4($a0)\n"            /* out[1] = t6 */
    "\tjr\t$ra\n"
    "\t nop\n"
    ".L800FE4CC:\n"
    "\tsw\t$a1,0($a0)\n"            /* out[0] = y */
    "\tsra\t$t6,$a1,31\n"           /* out[1] = y >> 31 (sign extend) */
    "\tsw\t$t6,4($a0)\n"
    "\tjr\t$ra\n"
    "\t nop\n"

    "\t.globl divu64\n"            /* @0x800FE4E0 : int divu64(int hi, int lo, unsigned den) */
    "divu64:\n"
    "\taddiu\t$v0,$zero,0\n"        /* q = 0 */
    "\taddiu\t$t1,$zero,32\n"
    "\taddiu\t$t1,$t1,-1\n"         /* i = 31 */
    ".L800FE4EC:\n"
    "\tsll\t$v0,$v0,1\n"            /* q <<= 1 */
    "\tsll\t$a1,$a1,1\n"            /* lo <<= 1 */
    "\tsrl\t$t2,$a0,31\n"           /* top bit of hi */
    "\taddu\t$a1,$a1,$t2\n"         /* shift it into lo */
    "\tsltu\t$t3,$a1,$a2\n"         /* lo < den ? */
    "\tbnez\t$t3,.L800FE510\n"
    "\t sll\t$a0,$a0,1\n"          /* delay: hi <<= 1 */
    "\tsubu\t$a1,$a1,$a2\n"         /* lo -= den */
    "\taddiu\t$v0,$v0,1\n"          /* q += 1 */
    ".L800FE510:\n"
    "\tbnez\t$t1,.L800FE4EC\n"
    "\t addiu\t$t1,$t1,-1\n"        /* delay: i-- */
    "\tjr\t$ra\n"
    "\t nop\n"
    "\t.set pop\n"
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
