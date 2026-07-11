/* eaclib/psx/eacpsxz/textfor.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   obj nfs4\eaclib\psx\textfor.obj ; EACPSXZ.LIB.  2 fns @[0x800F4470 .. 0x800F4510].  Look up a font glyph
 *   record by character code -- direct index then binary search.  Ghidra nfs4-f.exe.c + IDA sigs.
 *   (Ghidra showed the count as the global DAT_80135c14; it is the 3rd parameter.)
 */
extern unsigned int geti(void *p, char nbits);   /* getm */
extern unsigned char currentfont[];   /* @0x80135BA0 active-font state blob (textcrnt):
                                       * +0x74 = glyph count, +0x84 = glyph-table base (0xb B/entry) */

extern int          textbsearch(unsigned int key, int base, int count, int stride); /* @0x800F4470 */
extern unsigned int getcharacter(unsigned int code);                                /* @0x800F4510 */

/* textbsearch @0x800F4470 : binary-search `count` records (stride `stride`) for the one whose 2-byte key
 *   matches `key`; returns its address, or 0. */
extern int textbsearch(unsigned int key, int base, int count, int stride)
{
    /* MATCH: written as a natural top-tested `while` (NOT `for(;;){if(!cond)return;...}`) so
     * gcc ROTATES it: the count==0 test appears ONCE before the loop AND again (inverted) at
     * the back-edge, direct-return on hit -- reproduces the oracle's single beqz + bottom bnez
     * (§3.12 #15a rotation lever). 43->26 diffs, structurally EXACT (40==40 insns); residual is
     * a uniform $s0<->$s1 pair swap between `count` (loop-carried, live across the geti() call)
     * and `entry` (per-iteration temp, also live across the call) -- both cross the SAME jal
     * symmetrically, so this is the genuine §A "two locals fight over one contested
     * callee-saved-reg pair" coloring class. Tried: entry at fn-scope vs block-scope, decl
     * order (v/diff before/after entry), dropping the separate `v` temp, reassociating
     * entry=base;entry+=... vs entry=base+..., if-body statement order -- none moved it.
     * No asm pins (hard rule); accept as a pin-free near-miss / permuter-multi-basin candidate. */
    int entry;
    int diff;
    while (count != 0) {
        entry = base + (count >> 1) * stride;
        diff = (int)(key - geti((void *)entry, 2));
        if (diff == 0)
            return entry;
        if (diff > 0) {
            base = entry + stride;
            count = count - 1;
        }
        count = count >> 1;
    }
    return 0;
}

/* getcharacter @0x800F4510 : glyph record for `code` -- try the direct slot (code-0x20), else binary-search. */
extern unsigned int getcharacter(unsigned int code)
{
    /* MATCH: the table base/count are CURRENTFONT fields -- &currentfont la'd once into a
     * callee-saved reg (s3) and both fields read off it (0x84 base before geti, 0x74 count
     * after -- the blob address lives ACROSS the calls, lever #16); the miss path DIRECT-
     * returns textbsearch (lever #8) as the fall-through, hit-return out-of-line. */
    unsigned char *cf   = currentfont;
    int            base = *(int *)(cf + 0x84);
    int            entry = base + (int)(code - 0x20) * 0xb;
    unsigned int   v    = geti((void *)entry, 2);
    if (v == code)
        goto hit;                                       /* beq -> out-of-line hit return */
    return (unsigned int)textbsearch(code, base, *(int *)(cf + 0x74), 0xb);
hit:
    return (unsigned int)entry;
}
