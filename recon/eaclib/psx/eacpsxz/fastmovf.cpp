/* eaclib/psx/eacpsxz/fastmovf.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\fastmovf.obj ; EACPSXZ.LIB (xlsx col12 / SYM v3 FILE record line 360907).
 *   1 fn @0x80106084 (292 B).  fastmovfxya -- fast single-rect blit of an in-VRAM shape: clip the source
 *   rect to the current draw clip window, emit ONE SetDrawMove (VRAM->VRAM move) primitive, and stitch it
 *   into the ordering table.  Called by movfxya's path (b).  Ghidra nfs4-f.exe.c (fastmovfxya) + disasm-v3
 *   (IDA sig (int,int,int)=shape,x,y; the OT-stitch is the same `lwl/swl` P_TAG 24-bit addr-insert as movf;
 *   the clip globals sit at 0x801486E4+{0x18,0x1c,0x20,0x24}) + IDA sig.  Plain C -> extern "C".
 *
 *   Shape header: +4 w(short), +6 h(short), +0xc packed uv (12b u <<0x14>>0x14, 4b vpage via <<4>>0x14).
 *   Note: 0x801486E8/EC (draw origin) are read here as int (Ghidra `_DAT_` overlap view); movf.cpp reads the
 *   same addresses as ushort -- same symbol, dual-width access, reconciled at data-mat #75.
 */
typedef struct { short x, y, w, h; } RECT;   /* {u, v, w, h} move source rect */

extern "C" char *primptr;                                 /* primate : primitive write cursor */
extern "C" char *nextprim;                                /* primate : OT link target (prev prim) */
extern "C" void  SetDrawMove(void *prim, RECT *src, int dx, int dy);   /* syslib P34 @0x8010C698 */

extern "C" int DAT_801486e8;   /* @0x801486E8 : draw-origin X (int view) */
extern "C" int DAT_801486ec;   /* @0x801486EC : draw-origin Y (int view) */
extern "C" int DAT_801486fc;   /* @0x801486FC : clip window left   */
extern "C" int DAT_80148700;   /* @0x80148700 : clip window top    */
extern "C" int DAT_80148704;   /* @0x80148704 : clip window right  */
extern "C" int DAT_80148708;   /* @0x80148708 : clip window bottom */

extern "C" int fastmovfxya(int shape, int x, int y);   /* @0x80106084 */

/* fastmovfxya @0x80106084 : clip + single-move blit of shape at (x,y).  Returns the OT head it linked behind
 *   (old nextprim), or the last clip delta if fully clipped away. */
extern "C" int fastmovfxya(int shape, int x, int y)
{
    char *p = primptr;
    int   w = *(short *)(shape + 4);
    int   h = *(short *)(shape + 6);
    short u = (short)((*(int *)(shape + 0xc) << 0x14) >> 0x14);
    short v = (short)((*(int *)(shape + 0xc) << 4) >> 0x14);
    int   ret;

    ret = DAT_801486fc - x;                 /* clip left */
    if (0 < ret) { x += ret; u = u + (short)ret; w -= ret; }
    ret = (x + w) - DAT_80148704;           /* clip right */
    if (0 < ret) { w -= ret; }
    ret = DAT_80148700 - y;                 /* clip top */
    if (0 < ret) { y += ret; v = v + (short)ret; h -= ret; }
    ret = (y + h) - DAT_80148708;           /* clip bottom */
    if (0 < ret) { h -= ret; }

    if ((0 < w) && (0 < h)) {
        RECT src;
        src.x = u;
        src.y = v;
        src.w = (short)w;
        src.h = (short)h;
        primptr = primptr + 0x18;
        SetDrawMove((void *)p, &src, DAT_801486e8 + x, DAT_801486ec + y);

        ret = (int)nextprim;
        /* OT-stitch: insert `p` after `nextprim` (24-bit P_TAG addr field at +0) */
        *(unsigned int *)p =
            (*(unsigned int *)p & 0xff000000) | (*(unsigned int *)nextprim & 0x00ffffff);
        *(unsigned int *)nextprim =
            (*(unsigned int *)nextprim & 0xff000000) | ((unsigned int)p & 0x00ffffff);
        nextprim = p;
    }
    return ret;
}
