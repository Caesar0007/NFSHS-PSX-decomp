/* frontend/common/fetv.cpp -- RECONSTRUCTED (front-end "TV" grid widget; C++ TU)
 *   5 free fns on tTVConfig& (ns nfs4::FRONTEND::COMMON::FETv): DrawTVLines (scanline/stripe
 *   overlay), DrawTV (3260 B -- the TV-grid background drawer), InitTV, TurnOffTV, TurnOnTV.
 *   GPU packet building via Render_gPacketPtr/Render_gPalettePtr.
 */
#include "fetv.h"


/* ---- DrawTVLines  [FETV.CPP:25-77] SLD-VERIFIED ---- */

void DrawTVLines(tTVConfig &tv)

{
  short fxHeight;
  short x;
  short y;
  POLY_F4 *videoFX;
  u_char *prevVideoFX;
  int drawWide;
  int pkt_addr24;

  tv.fxWide = (short)((tv.fxWide + 1) % (tv.h * 0x30));
  y = tv.fxWide;
  tv.fxThin = (short)((tv.fxThin + 2) % (tv.h * 0x30));
  if ((int)tv.fxWide < (int)tv.y) {
    fxHeight = 8;
    fxHeight = (short)(fxHeight - ((u_int)tv.y - (u_int)y));
    y = tv.y;
  }
  else {
    drawWide = 0x80000;
    if (tv.fxWide + 8 <= (int)((u_int)tv.y + (int)tv.h)) goto DrawTVLines_writeWide;
    /* fxHeight left as the caller's leftover $t2 -- oracle reads it uninitialized
       on this path (tv.h>=8 && tv.fxWide>=tv.y); reproduced verbatim, not a fix. */
    fxHeight = (short)((u_int)tv.y - (u_int)y);
  }
  drawWide = fxHeight << 0x10;
DrawTVLines_writeWide:
  if (0 < drawWide) {
    videoFX = (POLY_F4 *)Render_gPacketPtr;
    prevVideoFX = Render_gPalettePtr;
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x18;
    *(u_int *)prevVideoFX = *(u_int *)prevVideoFX & 0xff000000 | pkt_addr24;
    videoFX->code = 0x2a;
    videoFX->r0 = 5;
    videoFX->x0 = tv.x;
    videoFX->y0 = y;
    videoFX->x1 = tv.x + tv.w;
    videoFX->y1 = y;
    videoFX->x2 = tv.x;
    videoFX->y2 = (short)(y + fxHeight);
    videoFX->b0 = 10;
    videoFX->g0 = 10;
    videoFX->r0 = 10;
    videoFX->x3 = tv.x + tv.w;
    videoFX->y3 = (short)(y + fxHeight);
  }
  videoFX = (POLY_F4 *)Render_gPacketPtr;
  prevVideoFX = Render_gPalettePtr;
  y = tv.fxThin;
  if (((int)tv.y < (int)tv.fxThin) && ((int)tv.fxThin < (int)tv.y + (int)tv.h)) {
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x18;
    *(u_int *)prevVideoFX = *(u_int *)prevVideoFX & 0xff000000 | pkt_addr24;
    videoFX->code = 0x2a;
    videoFX->r0 = 5;
    videoFX->x0 = tv.x;
    videoFX->y0 = y;
    videoFX->x1 = tv.x + tv.w;
    videoFX->y1 = y;
    videoFX->x2 = tv.x;
    videoFX->y2 = (short)(y + 1);
    videoFX->b0 = 10;
    videoFX->g0 = 10;
    videoFX->r0 = 10;
    videoFX->x3 = tv.x + tv.w;
    videoFX->y3 = (short)(y + 1);
  }
  FeDraw_SetABRMode(1);
  if ((tv.flags & 0x20) != 0) {
    x = (short)((u_short)tv.x + 4 & 0xfffc);
    if ((int)x < (int)tv.x + (int)tv.w) {
      short abe = 1;
      do {
        PSXDrawTransSquare(0xa0a0a,(int)x,(int)tv.y,1,(int)tv.h,abe);
        x = (short)(x + 4);
      } while ((int)((u_int)x << 0x10) >> 0x10 < (int)tv.x + (int)tv.w);
    }
    FeDraw_SetABRMode(2);
  }
  return;
}



/* ---- DrawTV  [FETV.CPP:82-284] SLD-VERIFIED ---- */

void DrawTV(tTVConfig &tv)

{
  POLY_FT4 *texture;
  POLY_GT4 *reflection;
  tTexture_ShapeInfo *noise;
  short videoX;
  short videoY;
  short videoWidth;
  short videoHeight;
  short fadeTop;
  short fadeBottom;
  u_long tint;
  short bright;
  bool do_tint;
  int newTransition;
  short destBright_us;
  int destBright_int;
  int state;
  u_char bVar4;
  u_int depth;
  int adj;
  u_int tu15;
  int tu18;
  u_int tu21;
  int ti10;
  short ts20;
  u_int tu24;
  u_char *prevPkt;
  u_int pkt_addr24;
  short tu17;
  short tu4;

  noise = &gHelpShapes[(rand() & 3) + 0x22];
  bright = tv.destBrightness;
  tint = tv.tint;
  videoX = tv.x;
  videoY = tv.y;
  videoWidth = tv.w;
  videoHeight = tv.h;
  do_tint = true;
  if ((tv.flags & 2) == 0) {
    tint = 0x808080;
    do_tint = false;
  }
  destBright_us = tv.destBrightness;
  destBright_int = (int)(u_short)destBright_us;
  if (tv.transition == destBright_int) {
DrawTV_stateFetch:
    state = tv.state;
  }
  else {
    if ((tv.transition < destBright_int) &&
        (newTransition = tv.transition + 4, tv.state - tv_StateOn < 2)) {
      tv.transition = newTransition;
      bVar4 = destBright_int < newTransition;
DrawTV_brightStep:
      if ((bool)bVar4) {
        tv.transition = destBright_us;
      }
      goto DrawTV_stateFetch;
    }
    state = tv.state;
    if ((state == tv_TransitionOff) || (state == tv_StateOn)) {
      destBright_us = tv.destBrightness;
      newTransition = tv.transition + -8;
      tv.transition = newTransition;
      bVar4 = (int)newTransition < (int)(u_int)(u_short)destBright_us;
      goto DrawTV_brightStep;
    }
  }
  if (state == tv_StateOn) {
DrawTV_stateOn:
    bright = tv.destBrightness;
  }
  else {
    if (state < 2) {
      if (state != tv_StateOff) {
        fadeTop = (short)((u_int)tint >> 0x10 & 0xff);
        goto DrawTV_emitTinted;
      }
      goto DrawTV_stateOn;
    }
    if (state == tv_TransitionOn) {
      if ((int)tv.transition == (u_int)tv.destBrightness) {
        tv.state = tv_StateOn;
      }
    }
    else {
      if (state != tv_TransitionOff) {
        fadeTop = (short)((u_int)tint >> 0x10 & 0xff);
        goto DrawTV_emitTinted;
      }
      if ((int)tv.transition == (u_int)tv.destBrightness) {
        tv.state = tv_StateOff;
      }
    }
    do_tint = 1;
    bright = tv.transition;
  }
  fadeTop = (short)((u_int)tint >> 0x10 & 0xff);
DrawTV_emitTinted:
  tu18 = (tint & 0xffU) * bright >> 7;
  tu24 = ((u_int)(fadeTop * bright) >> 7) << 0x10 |
         (((u_int)tint >> 8 & 0xff) * bright >> 7) << 8 | tu18;
  if ((tv.flags & 8) == 0) {
    DrawTVLines(tv);
  }
  texture = (POLY_FT4 *)Render_gPacketPtr;
  prevPkt = Render_gPalettePtr;
  if ((tv.flags & 0x10) == 0) {
    if (tv.state != tv_StateOn) {
      *(u_int *)Render_gPacketPtr =
           *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0x28;
      *(u_int *)prevPkt = *(u_int *)prevPkt & 0xff000000 | pkt_addr24;
      tu15 = 0x40 - (bright >> 1);
      *(u_int *)((u_char *)texture + 4) = tu15 * 0x10000 | tu15 * 0x100 | tu15;
      SetPolyFT4(texture);
      SetSemiTrans(texture,1);
      SetShadeTex(texture,0);
      *(short *)((u_char *)texture + 8) = videoX;
      *(u_short *)((u_char *)texture + 10) = videoY;
      *(u_short *)((u_char *)texture + 0x12) = videoY;
      *(short *)((u_char *)texture + 0x18) = videoX;
      *(short *)((u_char *)texture + 0x10) = videoX + videoWidth;
      *(short *)((u_char *)texture + 0x20) = videoX + videoWidth;
      *(short *)((u_char *)texture + 0x1a) = (short)(videoY + (u_int)videoHeight);
      *(short *)((u_char *)texture + 0x22) = (short)(videoY + (u_int)videoHeight);
      depth = (u_int)(u_char)noise->depth;
      adj = ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10;
      ((u_char *)texture)[0xc] = (char)(adj / (int)depth);
      ((u_char *)texture)[0xd] = (char)noise->shapey;
      depth = (u_int)(u_char)noise->depth;
      adj = ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10;
      ((u_char *)texture)[0x14] = (char)noise->width + (char)(adj / (int)depth);
      ((u_char *)texture)[0x15] = (char)noise->shapey;
      depth = (u_int)(u_char)noise->depth;
      adj = ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10;
      ((u_char *)texture)[0x1c] = (char)(adj / (int)depth);
      ((u_char *)texture)[0x1d] = (char)noise->height + (char)noise->shapey;
      depth = (u_int)(u_char)noise->depth;
      adj = ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10;
      ((u_char *)texture)[0x24] = (char)noise->width + (char)(adj / (int)depth);
      ((u_char *)texture)[0x25] = (char)noise->height + (char)noise->shapey;
      *(u_short *)((u_char *)texture + 0x16) =
           ((u_char)(*((u_char *)noise + 9)) & 3) << 7 |
           (short)(noise->shapey & 0x100U) >> 4 | 0x60U |
           (u_short)(((u_short)noise->shapex & 0x3c0) >> 6) |
           (noise->shapey & 0x200U) << 2;
      *(short *)((u_char *)texture + 0xe) =
           GetClut((noise->clutID & 0x3fU) << 4, noise->clutID >> 6);
      reflection = (POLY_GT4 *)Render_gPacketPtr;
      prevPkt = Render_gPalettePtr;
      if ((tv.flags & 4) != 0) {
        adj = ((u_int)tv.flip_axis - videoY) + 1;
        if (adj * 0x10000 < 0) {
          adj = -adj;
        }
        fadeTop = (short)(adj << 1);
        if (0x80 < (adj << 0x11) >> 0x10) {
          fadeTop = 0x80;
        }
        adj = ((u_int)tv.flip_axis - (videoY + (u_int)videoHeight)) + 1;
        if (adj * 0x10000 < 0) {
          adj = -adj;
        }
        fadeBottom = (short)(adj << 1);
        if (0x80 < (adj << 0x11) >> 0x10) {
          fadeBottom = 0x80;
        }
        adj = (0x80 - bright) * (0x80 - fadeTop);
        *(u_int *)Render_gPacketPtr =
             *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
        tu15 = (u_int)Render_gPacketPtr & 0xffffff;
        Render_gPacketPtr = Render_gPacketPtr + 0x34;
        *(u_int *)prevPkt = *(u_int *)prevPkt & 0xff000000 | tu15;
        if (adj < 0) {
          adj = adj + 0x7f;
        }
        tu15 = adj >> 7;
        adj = (0x80 - bright) * (0x80 - fadeBottom);
        tu15 = tu15 << 0x10 | tu15 << 8 | tu15;
        *(u_int *)((u_char *)reflection + 0x10) = tu15;
        *(u_int *)((u_char *)reflection + 4) = tu15;
        if (adj < 0) {
          adj = adj + 0x7f;
        }
        tu15 = adj >> 7;
        tu15 = tu15 << 0x10 | tu15 << 8 | tu15;
        *(u_int *)((u_char *)reflection + 0x28) = tu15;
        *(u_int *)((u_char *)reflection + 0x1c) = tu15;
        ((u_char *)reflection)[7] = 0x3e;
        ((u_char *)reflection)[3] = 0xc;
        *(short *)((u_char *)reflection + 8) = videoX;
        *(short *)((u_char *)reflection + 0x14) = videoX + videoWidth;
        *(u_short *)((u_char *)reflection + 10) = (u_short)(tv.flip_axis * 2 - videoY);
        *(short *)((u_char *)reflection + 0x20) = videoX;
        *(u_short *)((u_char *)reflection + 0x16) = (u_short)(tv.flip_axis * 2 - videoY);
        *(short *)((u_char *)reflection + 0x2c) = videoX + videoWidth;
        *(u_short *)((u_char *)reflection + 0x22) =
             (u_short)((tv.flip_axis * 2 - videoY) - videoHeight);
        *(u_short *)((u_char *)reflection + 0x2e) =
             (u_short)((tv.flip_axis * 2 - videoY) - videoHeight);
        depth = (u_int)(u_char)noise->depth;
        adj = ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10;
        ((u_char *)reflection)[0xc] = (char)(adj / (int)depth);
        ((u_char *)reflection)[0xd] = (char)noise->shapey + -1;
        depth = (u_int)(u_char)noise->depth;
        adj = ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10;
        ((u_char *)reflection)[0x18] = (char)noise->width + (char)(adj / (int)depth);
        ((u_char *)reflection)[0x19] = (char)noise->shapey + -1;
        depth = (u_int)(u_char)noise->depth;
        adj = ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10;
        ((u_char *)reflection)[0x24] = (char)(adj / (int)depth);
        ((u_char *)reflection)[0x25] =
             (char)noise->height + (char)noise->shapey + -1;
        depth = (u_int)(u_char)noise->depth;
        adj = ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10;
        ((u_char *)reflection)[0x30] = (char)noise->width + (char)(adj / (int)depth);
        ((u_char *)reflection)[0x31] =
             (char)noise->height + (char)noise->shapey + -1;
        *(u_short *)((u_char *)reflection + 0x1a) =
             ((u_char)(*((u_char *)noise + 9)) & 3) << 7 |
             (short)(noise->shapey & 0x100U) >> 4 | 0x60U |
             (u_short)(((u_short)noise->shapex & 0x3c0) >> 6) |
             (noise->shapey & 0x200U) << 2;
        *(short *)((u_char *)reflection + 0xe) =
             GetClut((noise->clutID & 0x3fU) << 4, noise->clutID >> 6);
      }
    }
    texture = (POLY_FT4 *)Render_gPacketPtr;
    prevPkt = Render_gPalettePtr;
    if (tv.state != tv_StateOff) {
      *(u_int *)Render_gPacketPtr =
           *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      tu15 = (u_int)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0x28;
      *(u_int *)prevPkt = *(u_int *)prevPkt & 0xff000000 | tu15;
      *(u_int *)((u_char *)texture + 4) = tu24;
      SetPolyFT4(texture);
      SetSemiTrans(texture,0);
      SetShadeTex(texture,do_tint ^ 1);
      *(short *)((u_char *)texture + 8) = videoX;
      *(u_short *)((u_char *)texture + 10) = videoY;
      ts20 = videoX + videoWidth;
      *(short *)((u_char *)texture + 0x10) = ts20;
      *(u_short *)((u_char *)texture + 0x12) = videoY;
      *(short *)((u_char *)texture + 0x18) = videoX;
      *(short *)((u_char *)texture + 0x20) = ts20;
      tu17 = (short)(videoY + (u_int)videoHeight);
      *(short *)((u_char *)texture + 0x1a) = tu17;
      *(short *)((u_char *)texture + 0x22) = tu17;
      ((u_char *)texture)[0xc] = tv.u;
      ((u_char *)texture)[0xd] = tv.v;
      ((u_char *)texture)[0x14] = tv.u + tv.uw;
      ((u_char *)texture)[0x15] = tv.v;
      ((u_char *)texture)[0x1c] = tv.u;
      ((u_char *)texture)[0x1d] = tv.v + tv.vh;
      ((u_char *)texture)[0x24] = tv.u + tv.uw;
      ((u_char *)texture)[0x25] = tv.v + tv.vh;
      *(u_short *)((u_char *)texture + 0x16) = tv.tpage;
      *(u_short *)((u_char *)texture + 0xe) = tv.clut;
      texture = (POLY_FT4 *)Render_gPacketPtr;
      prevPkt = Render_gPalettePtr;
      if ((tv.flags & 4) != 0) {
        adj = ((u_int)tv.flip_axis - videoY) + 1;
        if (adj * 0x10000 < 0) {
          adj = -adj;
        }
        fadeTop = (short)(adj << 1);
        if (0x80 < (adj << 0x11) >> 0x10) {
          fadeTop = 0x80;
        }
        adj = ((u_int)tv.flip_axis - (videoY + (u_int)videoHeight)) + 1;
        if (adj * 0x10000 < 0) {
          adj = -adj;
        }
        fadeBottom = (short)(adj << 1);
        if (0x80 < (adj << 0x11) >> 0x10) {
          fadeBottom = 0x80;
        }
        tu15 = tu24 >> 0x10 & 0xff;
        adj = 0x80 - fadeTop;
        tu21 = tu24 >> 8 & 0xff;
        ti10 = 0x80 - fadeBottom;
        *(u_int *)Render_gPacketPtr =
             *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
        tu24 = (u_int)Render_gPacketPtr & 0xffffff;
        Render_gPacketPtr = Render_gPacketPtr + 0x34;
        *(u_int *)prevPkt = *(u_int *)prevPkt & 0xff000000 | tu24;
        ((u_char *)texture)[3] = 0xc;
        tu24 = (tu15 * adj >> 7) << 0x10 | (tu21 * adj >> 7) << 8 | (tu18 & 0xffU) * adj >> 7;
        *(short *)((u_char *)texture + 8) = videoX;
        *(u_int *)((u_char *)texture + 0x10) = tu24;
        *(u_int *)((u_char *)texture + 4) = tu24;
        tu24 = (tu15 * ti10 >> 7) << 0x10 | (tu21 * ti10 >> 7) << 8 | (tu18 & 0xffU) * ti10 >> 7;
        *(u_int *)((u_char *)texture + 0x28) = tu24;
        *(u_int *)((u_char *)texture + 0x1c) = tu24;
        ((u_char *)texture)[7] = 0x3c;
        tu4 = tv.flip_axis;
        *(short *)((u_char *)texture + 0x14) = ts20;
        *(u_short *)((u_char *)texture + 10) = tu4 * 2 - videoY;
        tu4 = tv.flip_axis;
        *(short *)((u_char *)texture + 0x20) = videoX;
        *(u_short *)((u_char *)texture + 0x16) = tu4 * 2 - videoY;
        tu4 = tv.flip_axis;
        *(short *)((u_char *)texture + 0x2c) = ts20;
        *(u_short *)((u_char *)texture + 0x22) = (tu4 * 2 - videoY) - videoHeight;
        *(u_short *)((u_char *)texture + 0x2e) = (tv.flip_axis * 2 - videoY) - videoHeight;
        ((u_char *)texture)[0xc] = tv.u;
        ((u_char *)texture)[0xd] = tv.v + 0xff;
        ((u_char *)texture)[0x18] = tv.u + tv.uw;
        ((u_char *)texture)[0x19] = tv.v + 0xff;
        ((u_char *)texture)[0x24] = tv.u;
        ((u_char *)texture)[0x25] = tv.v + tv.vh + 0xff;
        ((u_char *)texture)[0x30] = tv.u + tv.uw;
        ((u_char *)texture)[0x31] = tv.v + tv.vh + 0xff;
        *(u_short *)((u_char *)texture + 0x1a) = tv.tpage;
        *(u_short *)((u_char *)texture + 0xe) = tv.clut;
      }
    }
  }
  return;
}



/* ---- InitTV  [FETV.CPP:287-309] SLD-VERIFIED ---- */

void InitTV(tTVConfig &tv,tTexture_ShapeInfo *textures,short index)

{
  u_char uVar1;
  u_short uVar2;
  u_int uVar3;
  int iVar4;
  int iVar5;
  
  iVar5 = (int)((u_int)(u_short)index << 0x10) >> 0xb;
  tv.state = tv_StateOff;
  tv.flags = 0;
  tv.x = -*(short *)((int)&textures->centerx + iVar5);
  tv.y = -*(short *)((int)&textures->centery + iVar5);
  tv.w = *(short *)((int)&textures->width + iVar5);
  tv.h = *(short *)((int)&textures->height + iVar5);
  uVar3 = (u_int)(u_char)(&textures->depth)[iVar5];
  iVar4 = ((int)*(short *)((int)&textures->shapex + iVar5) -
          (int)(short)(*(u_short *)((int)&textures->shapex + iVar5) & 0xffc0)) * 0x10;
  tv.u = (u_char)(iVar4 / (int)uVar3);
  uVar1 = *(u_char *)((int)&textures->shapey + iVar5);
  tv.uw = (u_char)tv.w;
  tv.vh = (u_char)tv.h;
  tv.v = uVar1;
  tv.shapex = *(u_short *)((int)&textures->shapex + iVar5);
  tv.shapey = *(u_short *)((int)&textures->shapey + iVar5);
  tv.clutID = *(u_short *)((int)&textures->clutID + iVar5);
  tv.shapeType = (*((u_char *)textures + 9 + iVar5)) & 3;
  uVar2 = GetClut((tv.clutID & 0x3f) << 4,(u_int)(tv.clutID >> 6));
  tv.clut = uVar2;
  uVar2 = *(u_short *)((int)&textures->shapey + iVar5);
  tv.tpage = ((u_char)(*((u_char *)textures + 9 + iVar5)) & 3) << 7 | (short)(uVar2 & 0x100) >> 4 |
              (u_short)((*(u_short *)((int)&textures->shapex + iVar5) & 0x3c0) >> 6) |
              (uVar2 & 0x200) << 2;
  iVar4 = rand();
  iVar5 = tv.h * 0x30;
  tv.fxWide = (short)(iVar4 % iVar5);
  iVar4 = rand();
  iVar5 = tv.h * 0x30;
  tv.flip_axis = 0;
  tv.transition = 0;
  tv.tint = 0x808080;
  tv.destBrightness = 0x80;
  tv.fxThin = (short)(iVar4 % iVar5);
  return;
}



/* ---- TurnOffTV  [FETV.CPP:313-315] SLD-VERIFIED ---- */

void TurnOffTV(tTVConfig &tv)

{
  tv.state = tv_TransitionOff;
  tv.destBrightness = 0;
  return;
}



/* ---- TurnOnTV  [FETV.CPP:319-321] SLD-VERIFIED ---- */

void TurnOnTV(tTVConfig &tv)

{
  
  tv.state = tv_TransitionOn;
  tv.destBrightness = 0x80;
  return;
}



/* end of fetv.cpp */
