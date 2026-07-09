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
    for (;;) {
        if (shape == 0)
            return 0;
        if ((char)*(unsigned int *)shape == '#')
            break;
        if ((*(unsigned int *)shape & 0xffffff00) == 0)
            shape = 0;
        else
            shape = shape + ((int)*(unsigned int *)shape >> 8);
    }
    return shape;
}

/* shapetoclutid : like getshapeclut but returns the GPU clut id (GetClut of the chunk's packed x/y). */
extern int shapetoclutid(unsigned int *shape)
{
    for (;;) {
        if (shape == 0)
            return 0;
        if ((*shape & 0xf7) == 0x23)
            break;
        if ((*shape & 0xffffff00) == 0)
            shape = 0;
        else
            shape = (unsigned int *)((int)shape + ((int)*shape >> 8));
    }
    return (int)GetClut((int)(shape[3] << 0x14) >> 0x14, (int)(shape[3] << 4) >> 0x14);
}
