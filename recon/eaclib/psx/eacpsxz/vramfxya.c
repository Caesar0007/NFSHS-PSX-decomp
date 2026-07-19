/* eaclib/psx/eacpsxz/vramfxya.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\vramfxya.obj ; EACPSXZ.LIB (xlsx col12 / SYM v3 FILE record line 360607).
 *   3 fns: checkrect @0x800F6934 (44 B), vramimage @0x800F6960 (72 B), vramfxya @0x800F69A8 (660 B).
 *   FX-A shape -> VRAM uploader: walks a shape's chunk chain and DMAs each bitmap chunk (tags 0x40..0x43)
 *   and CLUT chunk (tags 0x22/0x23/0x24) into VRAM at the requested (x,y).  CLUT chunks are colour-reduced
 *   to 15-bit BGR on the way (>>1 for 0x22, >>3 for 0x24; 0x23 uploads the raw words unchanged).
 *   Ghidra nfs4-f.exe.c (all 3) + disasm-v3 (vramfxya: IDA sig recovers the 5 dropped reg/stack args;
 *   the compiler jump table @0x80056FD8 is rendered as a plain switch) + IDA sigs.  Plain C -> extern "C".
 *
 *   Shape chunk header (uint* `c`):
 *     c[0]  : low byte = tag; bits 8.. = byte offset to next chunk (0 in the high 24 bits => end of chain)
 *     c[1]  : low short = entry/pixel count
 *     c[3]  : packed VRAM xy = (c[3] & 0xf000f000) | x&0xfff | (y&0xfff)<<16
 *     c+4   : pixel / CLUT source data; CLUT entries are 3 bytes (R,G,B) at byte offsets 0x10,0x11,0x12
 */
typedef unsigned long u_long;
typedef struct { short x, y, w, h; } RECT;

extern int   shapedepth(unsigned char *shape);   /* shpdepth */
extern void  LoadImage(RECT *rect, u_long *data); /* PsyQ libgpu */
extern int   drawpending;                         /* primate */

extern unsigned int checkrect(int rectp);                         /* @0x800F6934 */
extern int  vramimage(RECT *rect, u_long *data);                  /* @0x800F6960 */
extern void vramfxya(int shapep, short imgX, short imgY,
                         short clutX, short clutY);                   /* @0x800F69A8 */

/* checkrect @0x800F6934 : if the RECT is flagged (+4 bit0), set bit0 of the +6 word.  Returns the +4 flag. */
extern unsigned int checkrect(int rectp)
{
    unsigned int flag = *(unsigned short *)(rectp + 4) & 1;
    if (flag != 0) {
        flag = *(unsigned short *)(rectp + 6) | 1;
        *(short *)(rectp + 6) = (short)flag;
    }
    return flag;
}

/* vramimage @0x800F6960 : pre-check the RECT, DMA `data` into VRAM, mark a draw as pending.  Returns 1. */
extern int vramimage(RECT *rect, u_long *data)
{
    checkrect((int)rect);
    LoadImage(rect, data);
    drawpending = 1;
    return 1;
}

/* vramfxya @0x800F69A8 : upload every chunk of shape `shapep` to VRAM.  Bitmap chunks (0x40..0x43) go to
 *   (imgX,imgY); CLUT chunks (0x22/0x23/0x24) go to (clutX,clutY). */
extern void vramfxya(int shapep, short imgX, short imgY, short clutX, short clutY)
{
    unsigned int *c = (unsigned int *)shapep;
    unsigned int  clut22[128];   /* >>1 BGR scratch */
    unsigned int  clut24[131];   /* >>3 BGR scratch */
    RECT          rect;

    if (c == (unsigned int *)0)
        return;

    /* clutX/clutY are loop-invariant (fixed params) -- the oracle hoists their masked/shifted forms
     * OUT of the loop (computed once, reused every CLUT-tail hit) rather than remasking each time.
     * The two AND-mask constants used by the packed-xy update (below, in both the bitmap block and
     * the CLUT tail) are ALSO shared/hoisted the same way -- named here so gcc materializes each
     * ONCE and reuses it at both write sites instead of rematerializing per-site. */
    {
    unsigned int clutXm  = (unsigned int)clutX & 0xfff;
    unsigned int clutYm  = ((unsigned int)clutY & 0xfff) << 0x10;
    unsigned int maskLo  = ~0xFFFu;         /* clears the low 12 bits (x field) */
    unsigned int maskHi  = 0xF000FFFFu;     /* clears bits 16-27 (y field) */

    do {
        u_long       *data;
        int           count = (short)c[1];
        int           i;
        unsigned int *src;
        unsigned int *dst;

        switch ((unsigned char)*c & 0xf7) {
        case 0x22:                                   /* CLUT, 8->5 bit via >>1 */
            i   = 0;
            src = c;
            dst = clut22;
            if (0 < count) {
                do {
                    i = i + 1;
                    *(unsigned short *)dst =
                        (unsigned short)(unsigned char)((unsigned char)src[4] >> 1) |
                        (unsigned short)(*(unsigned char *)((int)src + 0x12) >> 1) << 10 |
                        (unsigned short)(*(unsigned char *)((int)src + 0x11) >> 1) << 5;
                    src = (unsigned int *)((int)src + 3);
                    dst = (unsigned int *)((int)dst + 2);
                } while (i < count);
            }
            data = (u_long *)clut22;
            break;

        case 0x23:                                   /* raw CLUT words */
            data = (u_long *)(c + 4);
            break;

        case 0x24:                                   /* CLUT, 8->5 bit via >>3 */
            i = 0;
            if (0 < count) {
                dst = clut24;
                src = c;
                do {
                    unsigned char *pB = (unsigned char *)((int)src + 0x12);
                    unsigned char *pG = (unsigned char *)((int)src + 0x11);
                    unsigned int  *pR = src + 4;
                    src = (unsigned int *)((int)src + 3);
                    i   = i + 1;
                    *(unsigned short *)dst =
                        (unsigned short)(unsigned char)((unsigned char)*pR >> 3) |
                        (unsigned short)(*pB >> 3) << 10 |
                        (unsigned short)(*pG >> 3) << 5;
                    dst = (unsigned int *)((int)dst + 2);
                } while (i < count);
            }
            data = (u_long *)clut24;
            break;

        case 0x40:
        case 0x41:
        case 0x42:
        case 0x43:                                   /* bitmap chunk -> (imgX,imgY) */
            {
                int bits, w;
                /* the retail c[3] packed-xy update is TWO sequential mask/insert passes (clear the
                 * low 12 bits and OR in x, THEN clear bits 16-27 and OR in y<<16) -- not one combined
                 * `& 0xf000f000` mask; the oracle materializes and shares 2 distinct AND-mask
                 * constants (~0xFFF, 0xF000FFFF) across both this site and the CLUT-tail site below. */
                c[3] = (c[3] & maskLo) | ((unsigned int)imgX & 0xfff);
                c[3] = (c[3] & maskHi) | (((unsigned int)imgY & 0xfff) << 0x10);
                *(unsigned char *)c = (unsigned char)*c | 8;
                rect.x = imgX;
                rect.y = imgY;                       /* H04: was missing (oracle 0x800F6A80 *(short*)(18+sp)=imgY) */
                bits   = (short)c[1] * shapedepth((unsigned char *)c);
                w      = bits + 0xf;
                if (w < 0)
                    w = bits + 0x1e;
                rect.w = (short)(w >> 4);            /* width in 16-bit VRAM words */
                rect.h = *(short *)((int)c + 6);
                data   = (u_long *)(c + 4);
                vramimage(&rect, data);
            }
            goto walk;

        default:                                     /* 0x25 etc.: nothing to upload */
            goto walk;
        }

        /* common CLUT tail (0x22/0x23/0x24) -> (clutX,clutY) */
        c[3] = (c[3] & maskLo) | clutXm;
        c[3] = (c[3] & maskHi) | clutYm;
        *(unsigned char *)c = (unsigned char)*c | 8;
        rect.x = clutX;
        rect.y = clutY;                          /* H04: was missing (oracle 0x800F6BC4 *(short*)(18+sp)=clutY) */
        rect.w = (short)c[1];
        rect.h = 1;
        vramimage(&rect, data);

    walk:
        if ((*c & 0xffffff00) == 0)
            c = (unsigned int *)0;
        else
            c = (unsigned int *)((int)c + ((int)*c >> 8));
    } while (c != (unsigned int *)0);
    }
}
