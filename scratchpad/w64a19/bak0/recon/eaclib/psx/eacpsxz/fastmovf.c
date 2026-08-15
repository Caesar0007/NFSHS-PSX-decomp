/* eaclib/psx/eacpsxz/fastmovf.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** SEALED 1/1 (PASS 73/73, 2026-07-09) ***
 *   obj nfs4\eaclib\psx\fastmovf.obj ; EACPSXZ.LIB (xlsx col12 / SYM v3 FILE record line 360907).
 *   1 fn @0x80106084 (292 B).  fastmovfxya -- fast single-rect blit of an in-VRAM shape: clip the source
 *   rect to the current draw clip window, emit ONE SetDrawMove (VRAM->VRAM move) primitive, and stitch it
 *   into the ordering table.  Called by movfxya's path (b).  Ghidra nfs4-f.exe.c (fastmovfxya) + disasm-v3
 *   (IDA sig (int,int,int)=shape,x,y; the OT-stitch is the same `lwl/swl` P_TAG 24-bit addr-insert as movf;
 *   the clip globals sit at 0x801486E4+{0x18,0x1c,0x20,0x24}) + IDA sig.  Plain C -> extern "C".
 *
 *   2026-07-09 SEAL (129->0): first fn of the 66-fn EA OT-link family cracked via the
 *   DMPSX-analog template discovery. The five levers: (1) fixed-$t6/$t7 inline-asm OT-stitch
 *   template; (2) `extern char * volatile nextprim` per-TU -> both retail loads incl. the DEAD
 *   2nd one (placeholder-call setup); (3) clobber window $t3-$t7 -> dead reload lands in $t5;
 *   (4) currentwindow[] ONE struct base (not 6 scalar DAT_ externs) -> single $t2 hoist;
 *   (5) NO explicit return -- $v0 incidental (old nextprim / last clip delta), plus the
 *   sy self-shift pair (sy=(int)(packed<<4); sy>>=20;) keeping `packed` live in $v1.
 *
 *   Shape header: +4 w(short), +6 h(short), +0xc packed uv (12b u <<0x14>>0x14, 4b vpage via <<4>>0x14).
 *   Note: 0x801486E8/EC (draw origin) are read here as int (Ghidra `_DAT_` overlap view); movf.cpp reads the
 *   same addresses as ushort -- same symbol, dual-width access, reconciled at data-mat #75.
 */
typedef struct { short x, y, w, h; } RECT;   /* {u, v, w, h} move source rect */

extern char *primptr;                                 /* primate : primitive write cursor */
extern char * volatile nextprim;                      /* primate : OT link target (prev prim).
                                * volatile HERE (per-TU codegen device): the retail OT-stitch loads
                                * nextprim TWICE (dead 2nd load = placeholder-call setup the EA
                                * post-processor left) -- volatile keeps both reads as direct
                                * lui/lw self-temp loads, matching the oracle. */
extern void  SetDrawMove(void *prim, RECT *src, int dx, int dy);   /* syslib P34 @0x8010C698 */

extern int currentwindow[];  /* @0x801486E4 : GPU window block -- draw-origin X/Y @+4/+8,
                              * clip left/top/right/bottom @+0x18/+0x1C/+0x20/+0x24.
                              * ONE struct base (oracle hoists &currentwindow into $t2);
                              * the former six DAT_801486xx externs were its fields. */

extern int fastmovfxya(int shape, int x, int y);   /* @0x80106084 */

/* fastmovfxya @0x80106084 : clip + single-move blit of shape at (x,y).  Returns the OT head it linked behind
 *   (old nextprim), or the last clip delta if fully clipped away. */
extern int fastmovfxya(int shape, int x, int y)
{
    int   w = *(short *)(shape + 4);
    unsigned int packed = *(unsigned int *)(shape + 0xc);
    int   h = *(short *)(shape + 6);
    int   sx = ((int)(packed << 20)) >> 20;   /* sign-extended 12-bit u @bits 0-11  */
    int   sy = (int)(packed << 4);            /* v @bits 16-27: self-shift pair keeps `packed` live */
    
    int   d;
    RECT  src;

    sy = sy >> 20;                            /* sign-extend 12-bit v (sra a2,a2,20) */
    d = currentwindow[6] - x;                 /* clip left   @+0x18 */
    if (0 < d) { x += d; sx += d; w -= d; }
    d = (x + w) - currentwindow[8];           /* clip right  @+0x20 */
    if (0 < d) { w -= d; }
    d = currentwindow[7] - y;                 /* clip top    @+0x1C */
    if (0 < d) { y += d; sy += d; h -= d; }
    d = (y + h) - currentwindow[9];           /* clip bottom @+0x24 */
    if (0 < d) { h -= d; }

    src.x = (short)sx;                        /* stored BEFORE the size gates (oracle) */
    src.y = (short)sy;
    src.w = (short)w;
    src.h = (short)h;
    if ((0 < w) && (0 < h)) {
        char *p = primptr;
        char *np;
        primptr = p + 0x18;
        SetDrawMove((void *)p, &src, currentwindow[1] + x, currentwindow[2] + y);

        np = nextprim;
        /* OT-stitch: insert `p` after `nextprim` (24-bit P_TAG addr copy + write).
         * FIXED-REG TEMPLATE (EA DMPSX-analog .obj post-processor -- 2026-07-09 discovery):
         * every retail site hardcodes $t6/$t7 scratches; the extra "r" input forces the DEAD
         * 2nd reload of nextprim (placeholder-call setup artifact the patcher left behind). */
        __asm__ volatile(
            "lwl	$t6,2(%0)
	sll	$t7,%1,8
	swl	$t6,2(%1)
	swl	$t7,2(%0)"
            : : "r"(np), "r"(p), "r"(nextprim)
            /* clobber window = the expander's reserved temps $t3-$t7 (dead reload lands in $t5
             * like retail; $t6/$t7 are the template's own scratches) */
            : "$11", "$12", "$14", "$15", "memory");
        nextprim = p;
    }
    /* NO explicit return: $v0 is INCIDENTAL (old nextprim on the drawn path, the last
     * clip delta when fully clipped away) -- the oracle computes no return value. */
}
