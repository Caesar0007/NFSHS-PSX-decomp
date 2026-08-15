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
     * (§3.12 #15a rotation lever). MATCH: a dedicated `n=count` value alias makes the incoming
     * parameter die at entry; the loop-carried alias then takes s1 while the per-iteration
     * `entry` takes s0, resolving the former uniform 26-diff register swap. */
    int entry;
    int diff;
    int n = count;
    while (n != 0) {
        entry = base + (n >> 1) * stride;
        diff = (int)(key - geti((void *)entry, 2));
        if (diff == 0)
            return entry;
        if (diff > 0) {
            base = entry + stride;
            n = n - 1;
        }
        n = n >> 1;
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
    unsigned int   result;
    if (v != code)
        result = (unsigned int)textbsearch(code, base, *(int *)(cf + 0x74), 0xb);
    else
        result = (unsigned int)entry;
    return result;
}
