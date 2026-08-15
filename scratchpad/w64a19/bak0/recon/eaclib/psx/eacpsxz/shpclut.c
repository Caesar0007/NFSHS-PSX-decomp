/* eaclib/psx/eacpsxz/shpclut.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   obj nfs4\eaclib\psx\shpclut.obj ; EACPSXZ.LIB.  2 fns @[0x800F6C3C .. 0x800F6C94].  Walk a shape's
 *   sub-chunk list to its CLUT chunk and resolve the GPU clut id.  Ghidra nfs4-f.exe.c (shpclut) + IDA sigs.
 */
extern short GetClut(int x, int y);   /* syslib P01 */

extern int getshapeclut(int shape);             /* @0x800F6C3C */
extern int shapetoclutid(unsigned int *shape);  /* @0x800F6C94 */

/* getshapeclut : follow the chunk chain (tag low byte == '#'/0x23) to the CLUT chunk; 0 if none. */
extern int getshapeclut(int shape)
{
    /* MATCH: entry null-test + do-while (bottom bnez back-edge); tag tested with a BYTE
     * read (lbu -- LE low byte of the chunk word); the chain-step if/else funnels through
     * one temp.  A for(;;) top-test re-tests shape every iteration (extra branch). */
    if (shape != 0) {
        do {
            if (*(unsigned char *)shape == 0x23)        /* '#' CLUT chunk tag */
                return shape;
            {
                int next;                               /* explicit funnel temp (v0) */
                if ((*(int *)shape & 0xffffff00) != 0)
                    next = shape + (*(int *)shape >> 8);/* signed chunk-size step */
                else
                    next = 0;
                shape = next;
            }
        } while (shape != 0);
    }
    return 0;
}

/* shapetoclutid : like getshapeclut but returns the GPU clut id (GetClut of the chunk's packed x/y). */
extern int shapetoclutid(unsigned int *shape)
{
    /* MATCH: same entry-test + do-while walk as getshapeclut, but: tag = BYTE read
     * masked 0xF7 (lbu+andi); match RETURNS from inside the loop (GetClut tail);
     * chain-step assigns shape DIRECTLY per arm (no funnel temp here). */
    if (shape != 0) {
loop:                                                   /* label-goto: NOT a natural loop, so
                                                         * the 0x23/-0x100 constants stay
                                                         * UN-hoisted (rematerialized per pass) */
        if ((*(unsigned char *)shape & 0xF7) == 0x23) {
            int xy = *(int *)((char *)shape + 0xC);
            /* MATCH: 2nd arg via a named temp computed FIRST -> xy lands in a0 (in-place
             * lw a0,12(a0)) and the sll a1,4 schedules before the destroying sll a0,20 */
            int y = (xy << 4) >> 20;
            return (short)GetClut((xy << 20) >> 20, y);
        }
        if ((*(int *)shape & 0xffffff00) != 0)
            shape = (unsigned int *)((int)shape + ((int)*shape >> 8));
        else
            shape = 0;
        if (shape != 0)
            goto loop;
    }
    return 0;
}
