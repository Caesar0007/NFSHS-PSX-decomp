/* frontend/psx/drawshp.cpp  --  RECONSTRUCTED  (PSX FE styled-rectangle drawing; C++ TU)
 *   Bodies: Ghidra decompiler. Line numbers: PsyQ SLD (8c decl, 8e end).
 *   4 EXT functions; C++ linkage (cfront-mangled; RECT& reference params).
 *   NOTE: Ghidra lost several register/stack args to the PSXFront draw helpers
 *   (named x/y + dseIndex/dseFlags/dseX/dseY, decl-only) -- genuinely unrecoverable from the binary.
 */
#include "drawshp.h"


/* REAL DATA DEFECT fixed W66-A5 (zeroinit per-symbol screen, after its UNKNOWN
   bucket was taught to compare the readable OVERLAP): retail's word at
   0x800529d0 is `80 80 80 00` = 0x00808080, the neutral "no tint" RGB the shape
   blitter compares/assigns against.  We emitted a zero-valued tentative
   definition, i.e. black. */
int kNoColor = 0x00808080;   /* 0x800529d0 (EXT data global) */

/* PsyQ libgpu P_TAG head word (addr:24 | len:8) -- the SDK addPrim()/setaddr()/getaddr()
 * macro family, same house idiom that PASSed PSXDrawTrans*Square/PrimStop (w44). */
typedef struct { unsigned addr : 24, len : 8; } DrawShp_PTag;

/* PsyQ4.3 LIBGPU.H146-150 canonical coordinate macro. */
#ifndef setXY4
#define setXY4(p,_x0,_y0,_x1,_y1,_x2,_y2,_x3,_y3) \
  (p)->x0 = (_x0), (p)->y0 = (_y0), \
  (p)->x1 = (_x1), (p)->y1 = (_y1), \
  (p)->x2 = (_x2), (p)->y2 = (_y2), \
  (p)->x3 = (_x3), (p)->y3 = (_y3)
#endif

/* ORIGINAL-NAME-UNRESOLVED: inferred allocation/link macro spelling/form.
   Retail SLD gives one statement group; no source object or scope is added. */
#define DrawShp_AllocPrim(p,type) \
  (p) = (type *)Render_gPacketPtr, \
  ((DrawShp_PTag *)(p))->addr = ((DrawShp_PTag *)Render_gPalettePtr)->addr, \
  Render_gPacketPtr = (u_char *)(p) + sizeof(type), \
  ((DrawShp_PTag *)Render_gPalettePtr)->addr = (u_long)(p)

/* lines 1-50: file header, #includes, static data, macros (no symbols emitted) */

/* ---- DrawShape_SubtractNFS4RectEdges  (drawshp.cpp:51, code lines 51-81) ---- */
/* 2026-10-12 SLD continuation: retail line13 groups allocation/tag/cursor,
   line14 both neutral-color stores, line15 both zero-color stores, line22
   all eight XY stores; counter initialization is on the loop header line11.
   A source-only allocation macro, chained color assignments, canonical PsyQ
   setXY4 and an ordinary for reproduce108/108 and all native records without
   captures. The allocation macro's literal existence/spelling is inferred;
   a single comma expression is another source form for that line group.
   Relative SLD improves102 to92 tag differences, but source end22 versus30
   and block lines remain unsealed. No blank/#line padding or dummy statement
   is used to imitate missing original text. */
/* 2026-10-12: express BOTH tag-link sites as the same typed addr:24 stores.
   Post-loop bitfield writes remove linkWord at108/108 PASS; after that change,
   direct loop palette reads also remove prevPrim at108/108. Reprice those
   captures together: their old independent failure receipts were specific to
   the mixed bitfield/masked-OR source. All eight ordered retail locals and
   the single root region now agree; run-4hkb41e6 is4/4 native CLEAN with
   complete TU bytes/layout unchanged. No const disguise, helper scope,
   qualifier, fence, pin or output rewrite remains in this function.
   Direct post-loop masked-OR was40dif/108; reusing dr_mode as the palette
   cell address20/110, reverted. Historical allocation impossibility claims
   are withdrawn, not accepted as proof of source objects or compiler floors.
   Full literal source and SLD remain separate requirements. */
void DrawShape_SubtractNFS4RectEdges(RECT &rect)

{
  DR_MODE *dr_mode;
  POLY_G4 *prim;
  short x1, y1, x2, y2;
  short i;

  y1 = rect.y + 1;
  y2 = y1 + rect.h + -1;
  x1 = rect.x + 2;
  x2 = rect.x + (rect.w >> 3);

  for (i = 0; i < 2; i = i + 1)
  {
    DrawShp_AllocPrim(prim,POLY_G4);
    *(u_long *)&prim->r2 = *(u_long *)&prim->r0 = 0x808080;
    *(u_long *)&prim->r1 = *(u_long *)&prim->r3 = 0;


    prim->code = 0x3a, ((u_char *)&prim->tag)[3] = 8;



    setXY4(prim,x1,y1 + 2,x2,y1,x1,y2 + -2,x2,y2);

    x1 = rect.x + rect.w + -2;
    x2 = x1 - (rect.w >> 3);
  }


  DrawShp_AllocPrim(dr_mode,DR_MODE);
  SetDrawMode(dr_mode,0,0,(u_short)GetTPage(2,2,0,0x100),(RECT *)0x0);
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
  /* decl order = SYM Def-record order (topleft, topright, bottomleft,
     bottomright, drawFlags) -- w86-S5, gate unchanged */
  tTexture_ShapeInfo *topleft;
  tTexture_ShapeInfo *topright;
  tTexture_ShapeInfo *bottomleft;
  tTexture_ShapeInfo *bottomright;
  tDrawShapeExtended drawFlags;

  topleft = gHelpShapes + 0x2a;
  topright = gHelpShapes + 0x2b;
  bottomleft = gHelpShapes + 0x2c;
  bottomright = gHelpShapes + 0x2d;
  drawFlags.tint[0] = 0x7b2908;
  drawFlags.tint[1] = 0x150800;
  drawFlags.tint[2] = 0x291000;
  drawFlags.tint[3] = 0x4a1900;
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
/* SYM: fsize 48, mask $800f0000 (ra,s3,s2,s1,s0); Block start/end both line 1
 * => ZERO named locals.  The old Ghidra body carried fabricated x/y/abr/opac
 * and passed UNINITIALISED x/y as the draw coordinates (real bug).  Every
 * coordinate is re-read from *r (lh) at each call site per the oracle.
 * MATCH: the doubled opacity MUST be spelled  opacity << 1  (not * 2): the
 * shift form lets combine fold promotion+double into one (raw<<17)>>16 off the
 * raw parm copy, deferring the plain sign-extend to the last call site; the
 * multiply form CSEs one shared (int)opacity and is 1 insn short. */
void DrawShape_NFS4TransRectangle(RECT &r,short opacity)

{

  PSXDrawTransSquare(0,r.x,r.y,4,r.h,opacity << 1);
  PSXDrawTransSquare(0,r.x + r.w + -4,r.y,4,r.h,opacity << 1);
  PSXDrawTransSquare(0,r.x + 4,r.y,r.w + -8,2,opacity << 1);
  PSXDrawTransSquare(0,r.x + 4,r.y + r.h + -2,r.w + -8,2,opacity << 1);


  PSXDrawTransSquare(0,r.x + 4,r.y + 2,r.w + -8,r.h + -4,opacity);

  FeDraw_SetABRMode(0);
  return;
}

/* end of drawshp.cpp */
