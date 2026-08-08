/* syslib/psx/libgpu/P34.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P34.OBJ): SetDrawMove @0x8010C698.  Builds a DR_MOVE (frame-buffer
 *   block copy) primitive: copies rect (src x/y, w/h) to dest (x,y).  Length byte = 5 only
 *   when both w and h are non-zero (a degenerate rect produces a 0-length no-op).  RECT is
 *   {short x,y,w,h}: w/h are the shorts at +4/+6.
 * NEAR-MISS (verify_asm 13/25 vs 24): oracle moves p into t0 as its very first instruction
 * (freeing a0 to double as the len(0/5) scratch), then spills the byte-store base through t0;
 * ours keeps p live in a0 and allocates a separate reg (t1) for len. Tried: rebasing the byte
 * store off `w` instead of `p` (worse, 20 diffs -- collapses len onto the same reg as the base
 * entirely); a ternary for len (worse, 15 diffs, also flips the beqz/bnez polarity). Allocator
 * coloring tie, not a semantic gap. */
extern void SetDrawMove(void *p, void *rect, int x, int y)   /* @0x8010C698 */
{
    int           *w = (int *)p;
    short         *r = (short *)rect;
    int len;
    /* MATCH (w51-a8): a zero-insn READ FENCE on the packet base forces cc1 to
     * emit retail's `addu $t0,$a0,$zero` param copy as the FIRST insn (instead
     * of coalescing p into $a0 and materializing len first) -- 13 -> 11 diffs.
     * Residual: retail parks len in the freed $a0 and bases the byte store on
     * $t0; ours keeps p live in $a0 for the byte store, so len takes $t1 and the
     * `lw v0,0(a1)` load-delay slot stays a nop (25 vs 24 insns). */
    __asm__("" : : "r"(w));
    len = 5;
    if (r[2] == 0 || r[3] == 0) len = 0;            /* r[2]=w, r[3]=h */
    w[1] = 0x01000000;
    w[2] = (int)0x80000000;
    ((unsigned char *)p)[3] = (unsigned char)len;
    w[4] = (y << 16) | (x & 0xffff);
    w[3] = ((int *)rect)[0];                        /* src x|y */
    w[5] = ((int *)rect)[1];                        /* src w|h */
}
