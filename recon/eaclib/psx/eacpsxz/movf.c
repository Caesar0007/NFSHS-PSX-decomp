/* eaclib/psx/eacpsxz/movf.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\movf.obj ; EACPSXZ.LIB (xlsx col12 / SYM v3 FILE record line 358083).
 *   1 fn @0x800F0738 (884 B).  movfxya -- blit a "shape" (fetexture sprite) to screen at (x,y).  Three paths:
 *     (a) shape not yet uploaded (*shape & 8 == 0)  -> DMA straight to VRAM via vramimage at the draw origin.
 *     (b) opaque-but-flagged semi-trans path        -> hand off to fastmovfxya.
 *     (c) otherwise                                 -> tile the sprite into <=256px GPU rectangles, emitting
 *         a textured POLY_FT4 (code 0x2c) per tile and stitching each into the ordering table (OT).
 *   Ghidra nfs4-f.exe.c (movfxya) + disasm-v3 (IDA sig recovers the 2 dropped reg args a2=x,a3=y; the OT-stitch
 *   is the fixed-$t6/$t7 lwl/swl P_TAG template -- EA DMPSX-analog .obj post-processor, see fastmovf.c seal
 *   2026-07-09; the two `/depth` div guards are --expand-div codegen from plain `/`).  Plain C -> extern "C".
 *
 *   MATCH notes (264->149; residual = scheduler-order/scratch-choice class -- {shape,yPos,vc} s6/s7/fp rotation, hoisted-255 CSE pseudo (caller-save-spilled!) vs per-use li, arg-block interleave -- the oracle .obj again shows unscheduled output; -fno-schedule diag gives 128. Levers that landed, mirroring the fastmovf recipe):
 *     - NO `ret` variable / NO explicit return on ANY path: $v0 is incidental (vramimage's or
 *       fastmovfxya's return, or scratch on the tiling path) -- the oracle computes no return value.
 *     - path (a) draw origin read off ONE `currentwindow[]` base (+4/+8 as u_short), not two DAT_ externs.
 *     - prim+7 code byte stored TWICE: constant 0x2C, then (semitrans BYTE read | 0x2C) -- dead first
 *       store kept by gcc (pointer aliasing), exactly as retail.
 *     - all prim field temps are plain ints (sb/sh truncate); u1 = colW + w2 where w2 is the
 *       post-call copy of clampW; clamped w2/rowH2 feed xDone/sx1/sy2.
 *     - uAcc = xDone*depth at inner-loop TOP (mult lands in the back-edge delay slot);
 *       uBase/depth hoisted into uq BEFORE uTile/uNext (div1 between uCoord and uTile like retail).
 *     - outer loop = while(1)+break bottom test: `beqz->exit; j top` (a plain do-while emits bnez-top);
 *       height read BOTH ways per iteration: signed lh for the guards, lhu into a short var `hu`
 *       whose use sign-extends (sll/sra pair).
 *     - OT-stitch: fixed-reg template asm + `extern char * volatile nextprim` (dead 2nd reload into
 *       $t5 via the $t3-$t7 clobber window) -- the sealed fastmovfxya recipe verbatim.
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
extern char * volatile nextprim;                         /* primate : OT link target (prev prim).
                               * volatile HERE (per-TU codegen device): the retail OT-stitch loads
                               * nextprim TWICE (dead 2nd load = placeholder-call setup the EA
                               * post-processor left) -- volatile keeps both reads as direct
                               * lui/lw self-temp loads, matching the oracle. */
extern int   semitrans;                                  /* primate : semi-transparency mode */
extern int   currentwindow[];  /* @0x801486E4 : GPU window block -- draw-origin X/Y @+4/+8 (u_short
                                * reads here), clip @+0x18..0x24.  ONE struct base like fastmovf. */

extern int movfxya(unsigned char *shape, int x, int y);  /* @0x800F0738 */

/* movfxya @0x800F0738 : draw shape at (x,y).  $v0 incidental -- no explicit return (oracle). */
extern int movfxya(unsigned char *shape, int x, int y)
{
    int depth = shapedepth(shape);

    if ((*shape & 8) != 0) {                          /* in VRAM: paths (b)/(c); (a) = else at END */
      if (((*shape & 3) == 2) && ((semitrans & 2) == 0)) {   /* (b) */
        fastmovfxya((int)shape, x, y);
      } else {                                        /* (c) tile into GPU rects */
        int yRow, vCoord, vc, rowH, rowH2, vPage, yPos;
        int xDone, uAcc, uCoord, uBase, uNext, colW, clampW, w2, uq;
        int uTile, u1, v2, sx, sx1, sy2, t;
        short hu;                                     /* height via lhu; uses sign-extend sll/sra */
        char *prim, *np;

        hu = *(unsigned short *)(shape + 6);
        if (0 < *(short *)(shape + 6)) {
            yRow = 0;
            while (1) {
                vCoord = ((*(int *)(shape + 0xc) << 4) >> 20) + yRow;
                vc = vCoord & 0xff;
                rowH = 0xff - vc;
                t = hu - yRow;
                if (t < rowH) rowH = t;
                xDone = 0;
                if (0 < *(short *)(shape + 4)) {
                    vPage = (vCoord & 0x100) >> 4;
                    yPos = yRow + y;
                    do {
                        uAcc = xDone * depth;
                        uCoord = (*(int *)(shape + 0xc) << 20) >> 20;
                        if (uAcc < 0) uAcc += 0xf;
                        uBase = uCoord << 4;
                        uq = uBase / depth;
                        uTile = uCoord + (uAcc >> 4);
                        uNext = (uTile & 0xffffffc0) << 4;
                        colW = (uq + xDone) - uNext / depth;
                        clampW = 0xff - colW;
                        t = *(short *)(shape + 4) - xDone;
                        if (t < clampW) clampW = t;
                        prim = primptr;
                        primptr = prim + 0x28;
                        prim[3] = 9;
                        prim[7] = 0x2c;               /* dead store kept (retail) */
                        prim[7] = *(unsigned char *)&semitrans | 0x2c;
                        *(short *)(prim + 0xe) = shapetoclutid((unsigned int *)shape);
                        w2 = clampW;
                        u1 = colW + w2;
                        prim[0xc] = colW;             /* u0 */
                        prim[0xd] = vc;               /* v0 */
                        prim[0x14] = u1;              /* u1 */
                        prim[0x15] = vc;              /* v1 */
                        prim[0x1c] = colW;            /* u2 */
                        prim[0x24] = u1;              /* u3 */
                        v2 = vc + rowH;
                        prim[0x1d] = v2;              /* v2 */
                        prim[0x25] = v2;              /* v3 */
                        *(unsigned short *)(prim + 0x16) =
                            ((*shape & 3) << 7 | vPage) | ((uTile & 0x3c0) >> 6);   /* tpage */
                        if (w2 < 1) w2 = 1;
                        rowH2 = rowH;
                        if (rowH2 < 1) rowH2 = 1;
                        sx = xDone + x;
                        sx1 = sx + w2;
                        *(short *)(prim + 8)    = sx;
                        *(short *)(prim + 0x18) = sx;
                        sy2 = yPos + rowH2;
                        *(short *)(prim + 0x1a) = sy2;
                        *(short *)(prim + 0x22) = sy2;
                        np = nextprim;
                        *(short *)(prim + 0xa)  = yPos;
                        *(short *)(prim + 0x12) = yPos;
                        *(short *)(prim + 0x10) = sx1;
                        *(short *)(prim + 0x20) = sx1;
                        /* OT-stitch: insert `prim` after `nextprim` (24-bit P_TAG addr copy+write).
                         * FIXED-REG TEMPLATE (EA DMPSX-analog .obj post-processor): every retail
                         * site hardcodes $t6/$t7; the extra "r" input = the DEAD 2nd nextprim
                         * reload (placeholder-call setup artifact). */
                        __asm__ volatile(
                            "lwl	$t6,2(%0)
	sll	$t7,%1,8
	swl	$t6,2(%1)
	swl	$t7,2(%0)"
                            : : "r"(np), "r"(prim), "r"(nextprim)
                            /* clobber window = expander's reserved temps $t3-$t7 (dead reload
                             * lands in $t5 like retail) */
                            : "$11", "$12", "$14", "$15", "memory");
                        xDone += w2;
                        nextprim = prim;
                    } while (xDone < *(short *)(shape + 4));
                }
                yRow += rowH2;
                hu = *(unsigned short *)(shape + 6);
                if (*(short *)(shape + 6) <= yRow) break;
            }
        }
      }
    } else {                                          /* (a) not in VRAM -> upload (block at END) */
        RECT rect;
        rect.x = *(unsigned short *)((char *)currentwindow + 4) + x;
        rect.y = *(unsigned short *)((char *)currentwindow + 8) + y;
        rect.w = *(unsigned short *)(shape + 4);
        rect.h = *(unsigned short *)(shape + 6);
        vramimage(&rect, (u_long *)(shape + 0x10));
    }
}
