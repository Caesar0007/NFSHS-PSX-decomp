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
  short y1;
  short y2;
  short tpage;
  int linkAddr;
  short x2;
  short x1;
  short i;
  DR_MODE *dr_mode;
  short top;
  u_char  *prevDrm;
  u_char  *prevPrim;
  u_char  *prim;
  
  i = 0;
  top = rect.y;
  y1 = top + 1;
  y2 = y1 + rect.h;
  x1 = (u_short)rect.x + 2;
  x2 = (uint)(u_short)rect.x + ((int)((uint)(u_short)rect.w << 0x10) >> 0x13);
  do {
    prim = Render_gPacketPtr;
    prevPrim = Render_gPalettePtr;
    *(uint *)Render_gPacketPtr =
         *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
    linkAddr = (uint)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x24;
    *(uint *)prevPrim = *(uint *)prevPrim & 0xff000000 | linkAddr;
    *(u_long *)(prim + 4) = 0x808080;
    prim[7] = 0x3a;
    prim[3] = 8;
    *(short *)(prim + 10) = top + 3;
    i = i + 1;
    *(u_long *)(prim + 0x14) = 0x808080;
    *(u_long *)(prim + 0x1c) = 0;
    *(u_long *)(prim + 0xc) = 0;
    *(short *)(prim + 8) = (short)x1;
    *(short *)(prim + 0x10) = (short)x2;
    *(short *)(prim + 0x12) = y1;
    *(short *)(prim + 0x18) = (short)x1;
    *(short *)(prim + 0x1a) = y2 + -3;
    *(short *)(prim + 0x20) = (short)x2;
    *(short *)(prim + 0x22) = y2 + -1;
    dr_mode = (DR_MODE *)Render_gPacketPtr;
    prevDrm = Render_gPalettePtr;
    x1 = (uint)(u_short)rect.x + (uint)(u_short)rect.w + -2;
    x2 = x1 - ((int)((uint)(u_short)rect.w << 0x10) >> 0x13);
  } while (i * 0x10000 >> 0x10 < 2);
  *(uint *)Render_gPacketPtr =
       *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
  linkAddr = (uint)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0xc;
  *(uint *)prevDrm = *(uint *)prevDrm & 0xff000000 | linkAddr;
  tpage = GetTPage(2,2,0,0x100);
  SetDrawMode(dr_mode,0,0,(uint)(u_short)tpage,(RECT *)0x0);
  return;
}

/* lines 82-91: (static data / macros / comments - no emitted code) */

/* ---- DrawShape_NFS4RoundRectangle  (drawshp.cpp:92, code lines 92-124) ---- */
void DrawShape_NFS4RoundRectangle(int textID,RECT &position,short selected)

{
  tTexture_ShapeInfo *shapes;
  int abr;
  int dseIndex;
  int x;
  int y;
  tTexture_ShapeInfo *left;
  short flags;
  int dseFlags;
  int dseX;
  int dseY;
  tDrawShapeExtended drawFlags;
  
  shapes = gHelpShapes;
  if (-1 < textID) {
    FETextRender_MenuTextPositionedJustify
              ((short)textID,
               (short)(((uint)(u_short)position.x +
                       ((int)((uint)(u_short)position.w << 0x10) >> 0x11)) * 0x10000 >> 0x10),
               position.y + 4,2,textState_Selected,textType_FramedInfo);
  }
  DrawShapeExtended
            (dseIndex,dseFlags,dseX,dseY,0,0,&drawFlags);
  DrawShapeExtended
            (dseIndex,dseFlags,dseX,dseY,0,0,&drawFlags);
  if (selected == 0) {
    PSXDrawTransSquare
              (0x841d08,x,y,(int)position.w + shapes[0x29].width * -2 + 1,1,1);
    abr = (int)position.x + (int)shapes[0x29].width;
    PSXDrawTransSquare
              (0,x,y,(int)position.w + shapes[0x29].width * -2 + 1,shapes[0x29].height + -1
               ,1);
    FeDraw_SetABRMode(abr);
  }
  else {
    PSXDrawSquare
              (0x841d08,(int)position.x + (int)shapes[0x29].width,
               (int)position.y + (int)shapes[0x29].height + -1,
               (int)position.w + shapes[0x29].width * -2 + 1,1);
    PSXDrawSquare
              (0,(int)position.x + (int)shapes[0x29].width,(int)position.y,
               (int)position.w + shapes[0x29].width * -2 + 1,shapes[0x29].height + -1);
  }
  return;
}

/* lines 125-128: (static data / macros / comments - no emitted code) */

/* ---- DrawShape_NFS4Rectangle  (drawshp.cpp:129, code lines 129-166) ---- */
void DrawShape_NFS4Rectangle(RECT &position)

{
  tTexture_ShapeInfo *shapes;
  int abr;
  int dseIndex;
  int x;
  int y;
  tTexture_ShapeInfo *bottomright;
  tTexture_ShapeInfo *topright;
  tTexture_ShapeInfo *bottomleft;
  tTexture_ShapeInfo *topleft;
  int dseFlags;
  int dseX;
  int dseY;
  tDrawShapeExtended drawFlags;
  
  shapes = gHelpShapes;
  drawFlags.tint[1] = 0x150800;
  drawFlags.tint[3] = 0x4a1900;
  drawFlags.tint[0] = 0x7b2908;
  drawFlags.tint[2] = 0x291000;
  DrawShapeExtended
            (dseIndex,dseFlags,dseX,dseY,0,0,&drawFlags);
  DrawShapeExtended
            (dseIndex,dseFlags,dseX,dseY,0,0,&drawFlags);
  DrawShapeExtended
            (dseIndex,dseFlags,dseX,dseY,0,0,&drawFlags);
  DrawShapeExtended
            ((int)position.w,dseFlags,dseX,dseY,0,0,&drawFlags);
  PSXDrawTransSquare
            (drawFlags.tint[1],x,y,
             ((int)position.w - (int)shapes[0x2a].width) - (int)shapes[0x2b].width,1,1);
  PSXDrawTransSquare
            (drawFlags.tint[0],x,y,
             ((int)position.w - (int)shapes[0x2c].width) - (int)shapes[0x2d].width,1,1);
  PSXDrawTransGouraudSquare
            (x,(int)position.y + (int)shapes[0x2a].height,2,
             ((int)position.h - (int)shapes[0x2a].height) - (int)shapes[0x2c].height,1,
             drawFlags.tint[2],drawFlags.tint[2],drawFlags.tint[3],drawFlags.tint[3]);
  PSXDrawTransGouraudSquare
            (x,(int)position.y + (int)shapes[0x2b].height,2,
             ((int)position.h - (int)shapes[0x2b].height) - (int)shapes[0x2d].height,1,
             drawFlags.tint[2],drawFlags.tint[2],drawFlags.tint[3],drawFlags.tint[3]);
  PSXDrawTransSquare
            (0,x,y,shapes[0x2a].width + -2,
             ((int)position.h - (int)shapes[0x2a].height) - (int)shapes[0x2c].height,1);
  PSXDrawTransSquare
            (0,x,y,2 - shapes[0x2b].width,
             ((int)position.h - (int)shapes[0x2b].height) - (int)shapes[0x2d].height,1);
  abr = (int)position.x + (int)shapes[0x2a].width;
  PSXDrawTransSquare
            (0,x,y,((int)position.w - (int)shapes[0x2a].width) - (int)shapes[0x2b].width,
             position.h + -2,1);
  FeDraw_SetABRMode(abr);
  return;
}

/* lines 167-169: (static data / macros / comments - no emitted code) */

/* ---- DrawShape_NFS4TransRectangle  (drawshp.cpp:170, code lines 170-181) ---- */
void DrawShape_NFS4TransRectangle(RECT &r,short opacity)

{
  int abr;
  int x;
  int y;
  short opac;
  
  opac = (short)(((uint)(u_short)opacity << 0x11) >> 0x10);
  PSXDrawTransSquare(0,x,y,4,(int)r.h,opac);
  PSXDrawTransSquare(0,x,y,4,(int)r.h,opac);
  PSXDrawTransSquare(0,x,y,r.w + -8,2,opac);
  PSXDrawTransSquare(0,x,y,r.w + -8,2,opac);
  abr = r.x + 4;
  PSXDrawTransSquare(0,x,y,r.w + -8,r.h + -4,opacity);
  FeDraw_SetABRMode(abr);
  return;
}

/* end of drawshp.cpp */