/* frontend/psx/drawshp.cpp  --  RECONSTRUCTED  (PSX FE styled-rectangle drawing; C++ TU)
 *   Bodies: Ghidra decompiler. Line numbers: PsyQ SLD (8c decl, 8e end).
 *   4 EXT functions; C++ linkage (cfront-mangled; RECT& reference params).
 *   NOTE: Ghidra lost several register/stack args to the PSXFront draw helpers
 *   (named x/y + dseIndex/dseFlags/dseX/dseY, decl-only) -- genuinely unrecoverable from the binary.
 */
#include "drawshp.h"

int kNoColor;   /* 0x800529d0 (EXT data global) */

/* lines 1-50: file header, #includes, static data, macros (no symbols emitted) */

/* ---- DrawShape_SubtractNFS4RectEdges  (drawshp.cpp:51, code lines 51-81) ---- */
void DrawShape_SubtractNFS4RectEdges(RECT &rect)

{
  /* SYM 8c: fsize 32, mask $80010000 (ra,s0); locals are EXACTLY
   *   dr_mode(DR_MODE* $s0) prim(POLY_G4* $a0) x1($a3) y1($t3) x2($a2) y2($t2) i($t5)
   * -- `top`, `linkAddr`, `tpage`, `prevPrim`, `prevDrm` were all Ghidra fictions.
   * All five shorts are plain `short` locals: that is what lets combine narrow the
   * shared rect.w load to `lhu` and pay the sign-extend only on the >>3 use
   * (lhu + sll 16 + sra 19) exactly like the oracle -- no (u_short) casts. */
  DR_MODE *dr_mode;
  POLY_G4 *prim;
  short x1;
  short y1;
  short x2;
  short y2;
  short i;

  i = 0;
  y1 = rect.y + 1;
  y2 = y1 + rect.h + -1;
  x1 = rect.x + 2;
  x2 = rect.x + (rect.w >> 3);
  do {
    prim = (POLY_G4 *)Render_gPacketPtr;
    prim->tag = prim->tag & 0xff000000 | *(u_long *)Render_gPalettePtr & 0xffffff;
    *(u_long *)Render_gPalettePtr =
         *(u_long *)Render_gPalettePtr & 0xff000000 | (u_long)prim & 0xffffff;
    Render_gPacketPtr = (u_char *)prim + 0x24;
    *(u_long *)&prim->r0 = 0x808080;
    prim->code = 0x3a;
    ((u_char *)&prim->tag)[3] = 8;
    prim->y0 = y1 + 2;
    i = i + 1;
    *(u_long *)&prim->r2 = 0x808080;
    *(u_long *)&prim->r3 = 0;
    *(u_long *)&prim->r1 = 0;
    prim->x0 = x1;
    prim->x1 = x2;
    prim->y1 = y1;
    prim->x2 = x1;
    prim->y2 = y2 + -2;
    prim->x3 = x2;
    prim->y3 = y2;
    x1 = rect.x + rect.w + -2;
    x2 = x1 - (rect.w >> 3);
  } while (i < 2);
  dr_mode = (DR_MODE *)Render_gPacketPtr;
  dr_mode->tag = dr_mode->tag & 0xff000000 | *(u_long *)Render_gPalettePtr & 0xffffff;
  *(u_long *)Render_gPalettePtr =
       *(u_long *)Render_gPalettePtr & 0xff000000 | (u_long)dr_mode & 0xffffff;
  Render_gPacketPtr = (u_char *)dr_mode + 0xc;
  SetDrawMode(dr_mode,0,0,(u_short)GetTPage(2,2,0,0x100),(RECT *)0x0);
  return;
}

/* lines 82-91: (static data / macros / comments - no emitted code) */

/* ---- DrawShape_NFS4RoundRectangle  (drawshp.cpp:92, code lines 92-124) ---- */
void DrawShape_NFS4RoundRectangle(int textID,RECT &position,short selected)

{
  /* SYM 8c: fsize 80, mask $801f0000 (ra,s4..s0); locals are EXACTLY
   *   drawFlags(AUTO -0x30 = sp+0x20) flags(short $s3) left(tTexture_ShapeInfo* $s2)
   * REGPARM: textID $a0, position $s1, selected $a2.  `shapes`/`abr`/`x`/`y`/
   * `dseIndex`/`dseFlags`/`dseX`/`dseY` were Ghidra fictions -- the two
   * DrawShapeExtended calls were being handed FOUR UNINITIALISED locals each
   * (real bug), and the PSXDraw*Square coordinates were uninitialised too. */
  tDrawShapeExtended drawFlags;
  short flags;
  tTexture_ShapeInfo *left;

  flags = 0;
  left = gHelpShapes + 0x29;
  if (-1 < textID) {
    FETextRender_MenuTextPositionedJustify
              ((short)textID,(short)(position.x + (position.w >> 1)),
               (short)(position.y + 4),2,textState_Selected,textType_FramedInfo);
  }
  if (selected == 0) {
    flags = 1;
  }
  DrawShapeExtended(0x29,flags | 8,position.x,position.y,0,0,&drawFlags);
  DrawShapeExtended(0x29,flags | 0xc,(int)position.x + (int)position.w - (int)left->width,
                    position.y,0,0,&drawFlags);
  if (selected != 0) {
    PSXDrawSquare(0x841d08,(int)position.x + (int)left->width,
                  (int)position.y + (int)left->height + -1,
                  (int)position.w - left->width * 2 + 1,1);
    PSXDrawSquare(0,(int)position.x + (int)left->width,position.y,
                  (int)position.w - left->width * 2 + 1,left->height + -1);
  }
  else {
    PSXDrawTransSquare(0x841d08,(int)position.x + (int)left->width,
                       (int)position.y + (int)left->height + -1,
                       (int)position.w - left->width * 2 + 1,1,1);
    PSXDrawTransSquare(0,(int)position.x + (int)left->width,position.y,
                       (int)position.w - left->width * 2 + 1,left->height + -1,1);
    FeDraw_SetABRMode(0);
  }
  return;
}

/* lines 125-128: (static data / macros / comments - no emitted code) */

/* ---- DrawShape_NFS4Rectangle  (drawshp.cpp:129, code lines 129-166) ---- */
void DrawShape_NFS4Rectangle(RECT &position)

{
  /* SYM 8c: fsize 96, mask $803f0000 (ra,s5..s0); locals are EXACTLY
   *   topleft($s5=&gHelpShapes[0x2a]) topright($s3=[0x2b])
   *   bottomleft($s4=[0x2c]) bottomright($s2=[0x2d]) drawFlags(AUTO -0x38=sp+0x28)
   * REGPARM position $s0.  `shapes`/`abr`/`x`/`y`/`dseIndex`/`dseFlags`/`dseX`/
   * `dseY` were Ghidra fictions: all four DrawShapeExtended calls and every
   * PSXDraw* coordinate were UNINITIALISED locals (real bug).  Recovered from
   * the raw oracle. */
  tDrawShapeExtended drawFlags;
  tTexture_ShapeInfo *bottomright;
  tTexture_ShapeInfo *topright;
  tTexture_ShapeInfo *bottomleft;
  tTexture_ShapeInfo *topleft;

  drawFlags.tint[0] = 0x7b2908;
  drawFlags.tint[1] = 0x150800;
  drawFlags.tint[2] = 0x291000;
  drawFlags.tint[3] = 0x4a1900;
  topleft = gHelpShapes_v[0] + 0x2a;
  topright = gHelpShapes_v[0] + 0x2b;
  bottomleft = gHelpShapes_v[0] + 0x2c;
  bottomright = gHelpShapes_v[0] + 0x2d;
  DrawShapeExtended(0x2a,9,position.x,position.y,0,0,&drawFlags);
  DrawShapeExtended(0x2b,9,(int)position.x + (int)position.w - (int)topright->width,
                    position.y,0,0,&drawFlags);
  DrawShapeExtended(0x2c,9,position.x,
                    (int)position.y + (int)position.h - (int)bottomleft->height,0,0,&drawFlags);
  DrawShapeExtended(0x2d,9,(int)position.x + (int)position.w - (int)bottomright->width,
                    (int)position.y + (int)position.h - (int)bottomright->height,0,0,&drawFlags);
  PSXDrawTransSquare
            (drawFlags.tint[1],(int)position.x + (int)topleft->width,position.y,
             (int)position.w - (int)topleft->width - (int)topright->width,1,1);
  PSXDrawTransSquare
            (drawFlags.tint[0],(int)position.x + (int)bottomleft->width,
             (int)position.y + (int)position.h + -1,
             (int)position.w - (int)bottomleft->width - (int)bottomright->width,1,1);
  PSXDrawTransGouraudSquare
            (position.x,(int)position.y + (int)topleft->height,2,
             (int)position.h - (int)topleft->height - (int)bottomleft->height,1,
             drawFlags.tint[2],drawFlags.tint[2],drawFlags.tint[3],drawFlags.tint[3]);
  PSXDrawTransGouraudSquare
            ((int)position.x + (int)position.w + -2,(int)position.y + (int)topright->height,2,
             (int)position.h - (int)topright->height - (int)bottomright->height,1,
             drawFlags.tint[2],drawFlags.tint[2],drawFlags.tint[3],drawFlags.tint[3]);
  PSXDrawTransSquare
            (0,(int)position.x + 2,(int)position.y + (int)topleft->height,
             topleft->width + -2,
             (int)position.h - (int)topleft->height - (int)bottomleft->height,1);
  PSXDrawTransSquare
            (0,(int)position.x + (int)position.w + -2,(int)position.y + (int)topright->height,
             -topright->width + 2,
             (int)position.h - (int)topright->height - (int)bottomright->height,1);
  PSXDrawTransSquare
            (0,(int)position.x + (int)topleft->width,(int)position.y + 1,
             (int)position.w - (int)topleft->width - (int)topright->width,
             position.h + -2,1);
  FeDraw_SetABRMode(0);
  return;
}

/* lines 167-169: (static data / macros / comments - no emitted code) */

/* ---- DrawShape_NFS4TransRectangle  (drawshp.cpp:170, code lines 170-181) ---- */
void DrawShape_NFS4TransRectangle(RECT &r,short opacity)

{
  /* SYM: fsize 48, mask $800f0000 (ra,s3,s2,s1,s0); Block start/end both line 1
   * => ZERO named locals.  The old Ghidra body carried fabricated x/y/abr/opac
   * and passed UNINITIALISED x/y as the draw coordinates (real bug).  Every
   * coordinate is re-read from *r (lh) at each call site per the oracle.
   * MATCH: the doubled opacity MUST be spelled  opacity << 1  (not * 2): the
   * shift form lets combine fold promotion+double into one (raw<<17)>>16 off the
   * raw parm copy, deferring the plain sign-extend to the last call site; the
   * multiply form CSEs one shared (int)opacity and is 1 insn short. */
  PSXDrawTransSquare(0,r.x,r.y,4,r.h,opacity << 1);
  PSXDrawTransSquare(0,r.x + r.w + -4,r.y,4,r.h,opacity << 1);
  PSXDrawTransSquare(0,r.x + 4,r.y,r.w + -8,2,opacity << 1);
  PSXDrawTransSquare(0,r.x + 4,r.y + r.h + -2,r.w + -8,2,opacity << 1);
  PSXDrawTransSquare(0,r.x + 4,r.y + 2,r.w + -8,r.h + -4,opacity);
  FeDraw_SetABRMode(0);
  return;
}

/* end of drawshp.cpp */