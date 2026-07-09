/* eaclib/psx/eacpsxz/movf.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\movf.obj ; EACPSXZ.LIB (xlsx col12 / SYM v3 FILE record line 358083).
 *   1 fn @0x800F0738 (884 B).  movfxya -- blit a "shape" (fetexture sprite) to screen at (x,y).  Three paths:
 *     (a) shape not yet uploaded (*shape & 8 == 0)  -> DMA straight to VRAM via vramimage at the draw origin.
 *     (b) opaque-but-flagged semi-trans path        -> hand off to fastmovfxya.
 *     (c) otherwise                                 -> tile the sprite into <=256px GPU rectangles, emitting
 *         a textured POLY_FT4 (code 0x2c) per tile and stitching each into the ordering table (OT).
 *   Ghidra nfs4-f.exe.c (movfxya) + disasm-v3 (IDA sig recovers the 2 dropped reg args a2=x,a3=y; the OT-stitch
 *   is `lwl/swl`-only -> a P_TAG 24-bit addr-field insert; the two `/depth` div-by-zero `trap()`s are GCC
 *   codegen and drop out) + IDA sig.  Plain C -> extern "C".
 *
 *   GPU rect primitive (0x28 bytes): +0 tag(24b OT-link | len<<24), +3 len(=9), +7 code(=semitrans|0x2c),
 *   +0xe clutid, then 4 vertices of {x16,y16,u8,v8} interleaved at +8/+0xc/+0x10.../+0x16 tpage.
 *   Shape header: +4 w(short), +6 h(short), +0xc packed uv/tpage (12b u <<0x14, 4b vpage <<4), +0x10 pixels.
 */
typedef unsigned long u_long;
typedef struct { short x, y, w, h; } RECT;

extern int  shapedepth(unsigned char *shape);            /* shpdepth */
extern int  shapetoclutid(unsigned int *shape);          /* shpclut */
extern int  vramimage(RECT *rect, u_long *data);         /* vramfxya */
extern int  fastmovfxya(int shape, int x, int y);        /* fastmovf (deferred-trio sibling) */
extern char *primptr;                                    /* primate : primitive write cursor */
extern char *nextprim;                                   /* primate : OT link target (prev prim) */
extern int   semitrans;                                  /* primate : semi-transparency mode */
extern unsigned short DAT_801486e8;  /* @0x801486E8 : draw-origin X */
extern unsigned short DAT_801486ec;  /* @0x801486EC : draw-origin Y */

extern int movfxya(unsigned char *shape, int x, int y);  /* @0x800F0738 */

/* movfxya @0x800F0738 : draw shape at (x,y). */
extern int movfxya(unsigned char *shape, int x, int y)
{
    int  depth = shapedepth(shape);
    int  ret   = 0;

    if ((*shape & 8) == 0) {                          /* (a) not in VRAM -> upload */
        RECT rect;
        rect.x = DAT_801486e8 + (short)x;
        rect.y = DAT_801486ec + (short)y;
        rect.w = *(short *)(shape + 4);
        rect.h = *(short *)(shape + 6);
        ret = vramimage(&rect, (u_long *)(shape + 0x10));
    } else if (((*shape & 3) == 2) && ((semitrans & 2) == 0)) {   /* (b) */
        ret = fastmovfxya((int)shape, x, y);
    } else {                                          /* (c) tile into GPU rects */
        short height = *(short *)(shape + 6);
        int   yRow   = 0;
        ret = height;
        if (0 < height) {
            int unaffRowH = 0;
            do {
                unsigned int vCoord = (((*(int *)(shape + 0xc) << 4) >> 0x14) + yRow);
                int          rowH   = 0xff - (vCoord & 0xff);
                int          xDone;
                if (height - yRow < rowH)
                    rowH = height - yRow;
                xDone = 0;
                if (0 < *(short *)(shape + 4)) {
                    int   vPage = (int)(vCoord & 0x100) >> 4;
                    short yPos  = (short)yRow + (short)y;
                    int   uAcc  = 0;
                    do {
                        char        *prim  = primptr;
                        int          uCoord = (*(int *)(shape + 0xc) << 0x14) >> 0x14;
                        int          uBase, uNext, colW, clampW;
                        unsigned int uTile;
                        unsigned char vc, vc2;
                        char         c5, c12;
                        short        sx, sx2, sy2, sy10;

                        if (uAcc < 0)
                            uAcc = uAcc + 0xf;
                        uBase  = uCoord << 4;
                        uTile  = uCoord + (uAcc >> 4);
                        uNext  = (uTile & 0xffffffc0) << 4;
                        colW   = (uBase / depth + xDone) - uNext / depth;
                        clampW = 0xff - colW;
                        if (*(short *)(shape + 4) - xDone < clampW)
                            clampW = *(short *)(shape + 4) - xDone;

                        primptr = primptr + 0x28;
                        *(unsigned char *)(prim + 3)  = 9;
                        *(unsigned char *)(prim + 7)  = (unsigned char)(semitrans | 0x2c);
                        *(short *)(prim + 0xe)        = (short)shapetoclutid((unsigned int *)shape);

                        c5  = (char)colW;
                        c12 = c5 + (char)clampW;
                        vc  = (unsigned char)vCoord;
                        *(char *)(prim + 0xc)  = c5;          /* u0 */
                        *(char *)(prim + 0xd)  = (char)vc;    /* v0 */
                        *(char *)(prim + 0x14) = c12;         /* u1 */
                        *(char *)(prim + 0x15) = (char)vc;    /* v1 */
                        *(char *)(prim + 0x1c) = c5;          /* u2 */
                        *(char *)(prim + 0x24) = c12;         /* u3 */
                        vc2 = vc + (unsigned char)rowH;
                        *(char *)(prim + 0x1d) = (char)vc2;   /* v2 */
                        *(char *)(prim + 0x25) = (char)vc2;   /* v3 */
                        *(unsigned short *)(prim + 0x16) =
                            (unsigned short)((*shape & 3) << 7) | (unsigned short)vPage |
                            (unsigned short)((int)(uTile & 0x3c0) >> 6);   /* tpage */

                        if (clampW < 1) clampW = 1;
                        unaffRowH = rowH;
                        if (rowH < 1) unaffRowH = 1;

                        sx   = (short)xDone + (short)x;
                        sy10 = sx + (short)clampW;
                        *(short *)(prim + 8)    = sx;
                        *(short *)(prim + 0x18) = sx;
                        sx2  = yPos + (short)unaffRowH;
                        *(short *)(prim + 0x1a) = sx2;
                        *(short *)(prim + 0x22) = sx2;
                        *(short *)(prim + 0xa)  = yPos;
                        *(short *)(prim + 0x12) = yPos;
                        *(short *)(prim + 0x10) = sy10;
                        *(short *)(prim + 0x20) = sy10;

                        /* OT-stitch: insert `prim` after `nextprim` (24-bit P_TAG addr field at +0) */
                        *(unsigned int *)prim =
                            (*(unsigned int *)prim & 0xff000000) |
                            (*(unsigned int *)nextprim & 0x00ffffff);
                        *(unsigned int *)nextprim =
                            (*(unsigned int *)nextprim & 0xff000000) |
                            ((unsigned int)prim & 0x00ffffff);

                        xDone   = xDone + clampW;
                        nextprim = prim;
                        uAcc    = xDone * depth;
                    } while (xDone < *(short *)(shape + 4));
                }
                yRow   = yRow + unaffRowH;
                height = *(short *)(shape + 6);
                ret    = 0;
            } while (yRow < height);
        }
    }
    return ret;
}
