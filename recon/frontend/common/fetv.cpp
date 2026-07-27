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
  bool bVar1;
  short ts10;
  short ts11;
  short ts4;
  short ts5;
  short ts13;
  int rng_word;
  int noise_select;
  short ts12;
  int pkt_addr24_a;
  short destBright_us;
  int destBright_int;
  int state;
  int pkt_addr24_b;
  u_int tu15;
  int ti16;
  int transStep_or_brt;
  int ti17;
  int tu18;
  int destBrightness;
  u_int tu21;
  short tu17;
  int ti10;
  short ts20;
  int videoY_2;
  int tvY;
  short tu20;
  int tint_2;
  u_int tu24;
  u_char do_tint;
  short tu1;
  short ts1;
  u_char bVar4;
  u_short tu2;
  u_short tu3;
  u_char *prev_pkt_b;
  tTexture_ShapeInfo *noiseShape;
  u_char *cur_pkt_a;
  u_char *tp10;
  u_short tu4;
  
  rng_word = rand();
  noiseShape = gHelpShapes;
  noise_select = rng_word & 3;
  destBrightness = (int)tv.destBrightness;
  tint_2 = tv.tint;
  ts1 = tv.x;
  tu2 = tv.y;
  tvY = (int)tu2;
  ts13 = tv.w;
  tu3 = tv.h;
  bVar1 = (tv.flags & 2) == 0;
  if (bVar1) {
    tint_2 = 0x808080;
  }
  do_tint = (u_int)!bVar1;
  destBright_us = tv.destBrightness;
  destBright_int = (int)(u_short)destBright_us;
  if (tv.transition == destBright_int) {
DrawTV_stateFetch:
    state = tv.state;
  }
  else {
    if ((tv.transition < destBright_int) && (ts12 = tv.transition + 4, tv.state - tv_StateOn < 2)
       ) {
      tv.transition = ts12;
      bVar4 = destBright_int < ts12;
DrawTV_brightStep:
      if ((bool)bVar4) {
        tv.transition = destBright_us;
      }
      goto DrawTV_stateFetch;
    }
    state = tv.state;
    if ((state == tv_TransitionOff) || (state == tv_StateOn)) {
      destBright_us = tv.destBrightness;
      ts12 = tv.transition + -8;
      tv.transition = ts12;
      bVar4 = (int)ts12 < (int)(u_int)(u_short)destBright_us;
      goto DrawTV_brightStep;
    }
  }
  if (state == tv_StateOn) {
DrawTV_stateOn:
    tu4 = tv.destBrightness;
  }
  else {
    if (state < 2) {
      if (state != tv_StateOff) {
        pkt_addr24_a = (u_int)tint_2 >> 0x10 & 0xff;
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
        pkt_addr24_a = (u_int)tint_2 >> 0x10 & 0xff;
        goto DrawTV_emitTinted;
      }
      if ((int)tv.transition == (u_int)tv.destBrightness) {
        tv.state = tv_StateOff;
      }
    }
    do_tint = 1;
    tu4 = tv.transition;
  }
  destBrightness = (int)tu4;
  pkt_addr24_a = (u_int)tint_2 >> 0x10 & 0xff;
DrawTV_emitTinted:
  videoY_2 = (destBrightness << 0x10) >> 0x10;
  tu18 = (tint_2 & 0xffU) * videoY_2 >> 7;
  tu24 = ((u_int)(pkt_addr24_a * videoY_2) >> 7) << 0x10 |
         (((u_int)tint_2 >> 8 & 0xff) * videoY_2 >> 7) << 8 | tu18;
  if ((tv.flags & 8) == 0) {
    DrawTVLines(tv);
  }
  tp10 = Render_gPacketPtr;
  cur_pkt_a = Render_gPalettePtr;
  if ((tv.flags & 0x10) == 0) {
    if (tv.state != tv_StateOn) {
      *(u_int *)Render_gPacketPtr =
           *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      pkt_addr24_b = (u_int)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0x28;
      *(u_int *)cur_pkt_a = *(u_int *)cur_pkt_a & 0xff000000 | pkt_addr24_b;
      tu15 = 0x40 - ((destBrightness << 0x10) >> 0x11);
      *(u_int *)(tp10 + 4) = tu15 * 0x10000 | tu15 * 0x100 | tu15;
      SetPolyFT4((POLY_FT4 *)tp10);
      SetSemiTrans(tp10,1);
      SetShadeTex(tp10,0);
      *(short *)(tp10 + 8) = ts1;
      *(u_short *)(tp10 + 10) = tu2;
      *(u_short *)(tp10 + 0x12) = tu2;
      *(short *)(tp10 + 0x18) = ts1;
      *(short *)(tp10 + 0x10) = ts1 + ts13;
      *(short *)(tp10 + 0x20) = ts1 + ts13;
      tu20 = (short)(tvY + (u_int)tu3);
      *(short *)(tp10 + 0x1a) = tu20;
      *(short *)(tp10 + 0x22) = tu20;
      tu15 = (u_int)(u_char)noiseShape[noise_select + 0x22].depth;
      ti16 = ((int)noiseShape[noise_select + 0x22].shapex -
             (int)(short)(noiseShape[noise_select + 0x22].shapex & 0xffc0)) * 0x10;
      tp10[0xc] = (char)(ti16 / (int)tu15);
      tp10[0xd] = (char)noiseShape[noise_select + 0x22].shapey;
      tu15 = (u_int)(u_char)noiseShape[noise_select + 0x22].depth;
      transStep_or_brt =
           ((int)noiseShape[noise_select + 0x22].shapex -
           (int)(short)(noiseShape[noise_select + 0x22].shapex & 0xffc0)) * 0x10;
      tp10[0x14] = (char)noiseShape[noise_select + 0x22].width +
                   (char)(transStep_or_brt / (int)tu15);
      tp10[0x15] = (char)noiseShape[noise_select + 0x22].shapey;
      tu15 = (u_int)(u_char)noiseShape[noise_select + 0x22].depth;
      ti17 = ((int)noiseShape[noise_select + 0x22].shapex -
             (int)(short)(noiseShape[noise_select + 0x22].shapex & 0xffc0)) * 0x10;
      tp10[0x1c] = (char)(ti17 / (int)tu15);
      tp10[0x1d] = (char)noiseShape[noise_select + 0x22].height +
                   (char)noiseShape[noise_select + 0x22].shapey;
      tu15 = (u_int)(u_char)noiseShape[noise_select + 0x22].depth;
      ti17 = ((int)noiseShape[noise_select + 0x22].shapex -
             (int)(short)(noiseShape[noise_select + 0x22].shapex & 0xffc0)) * 0x10;
      tp10[0x24] = (char)noiseShape[noise_select + 0x22].width + (char)(ti17 / (int)tu15);
      tp10[0x25] = (char)noiseShape[noise_select + 0x22].height +
                   (char)noiseShape[noise_select + 0x22].shapey;
      *(u_short *)(tp10 + 0x16) =
           ((u_char)(*((u_char *)&noiseShape[noise_select + 0x22] + 9)) & 3) << 7 |
           (short)(noiseShape[noise_select + 0x22].shapey & 0x100U) >> 4 | 0x60U |
           (u_short)(((u_short)noiseShape[noise_select + 0x22].shapex & 0x3c0) >> 6) |
           (noiseShape[noise_select + 0x22].shapey & 0x200U) << 2;
      ts10 = GetClut((noiseShape[noise_select + 0x22].clutID & 0x3fU) << 4,
                        noiseShape[noise_select + 0x22].clutID >> 6);
      *(short *)(tp10 + 0xe) = ts10;
      prev_pkt_b = Render_gPacketPtr;
      cur_pkt_a = Render_gPalettePtr;
      if ((tv.flags & 4) != 0) {
        ti17 = ((u_int)tv.flip_axis - tvY) + 1;
        if (ti17 * 0x10000 < 0) {
          ti17 = -ti17;
        }
        ts12 = (short)(ti17 << 1);
        if (0x80 < (ti17 << 0x11) >> 0x10) {
          ts12 = 0x80;
        }
        ti17 = ((u_int)tv.flip_axis - (tvY + (u_int)tu3)) + 1;
        if (ti17 * 0x10000 < 0) {
          ti17 = -ti17;
        }
        ts11 = (short)(ti17 << 1);
        if (0x80 < (ti17 << 0x11) >> 0x10) {
          ts11 = 0x80;
        }
        ti17 = (0x80 - videoY_2) * (0x80 - ts12);
        *(u_int *)Render_gPacketPtr =
             *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
        tu15 = (u_int)Render_gPacketPtr & 0xffffff;
        Render_gPacketPtr = Render_gPacketPtr + 0x34;
        *(u_int *)cur_pkt_a = *(u_int *)cur_pkt_a & 0xff000000 | tu15;
        if (ti17 < 0) {
          ti17 = ti17 + 0x7f;
        }
        tu15 = ti17 >> 7;
        ti17 = (0x80 - videoY_2) * (0x80 - ts11);
        tu15 = tu15 << 0x10 | tu15 << 8 | tu15;
        *(u_int *)(prev_pkt_b + 0x10) = tu15;
        *(u_int *)(prev_pkt_b + 4) = tu15;
        if (ti17 < 0) {
          ti17 = ti17 + 0x7f;
        }
        tu15 = ti17 >> 7;
        tu15 = tu15 << 0x10 | tu15 << 8 | tu15;
        *(u_int *)(prev_pkt_b + 0x28) = tu15;
        *(u_int *)(prev_pkt_b + 0x1c) = tu15;
        prev_pkt_b[7] = 0x3e;
        prev_pkt_b[3] = 0xc;
        *(short *)(prev_pkt_b + 8) = ts1;
        tu1 = tv.flip_axis;
        *(short *)(prev_pkt_b + 0x14) = ts1 + ts13;
        *(u_short *)(prev_pkt_b + 10) = tu1 * 2 - tu2;
        tu4 = tv.flip_axis;
        *(short *)(prev_pkt_b + 0x20) = ts1;
        *(u_short *)(prev_pkt_b + 0x16) = tu4 * 2 - tu2;
        tu4 = tv.flip_axis;
        *(short *)(prev_pkt_b + 0x2c) = ts1 + ts13;
        *(u_short *)(prev_pkt_b + 0x22) = (tu4 * 2 - tu2) - tu3;
        *(u_short *)(prev_pkt_b + 0x2e) = (tv.flip_axis * 2 - tu2) - tu3;
        tu15 = (u_int)(u_char)noiseShape[noise_select + 0x22].depth;
        ti17 = ((int)noiseShape[noise_select + 0x22].shapex -
               (int)(short)(noiseShape[noise_select + 0x22].shapex & 0xffc0)) * 0x10;
        prev_pkt_b[0xc] = (char)(ti17 / (int)tu15);
        prev_pkt_b[0xd] = (char)noiseShape[noise_select + 0x22].shapey + -1;
        tu15 = (u_int)(u_char)noiseShape[noise_select + 0x22].depth;
        ti17 = ((int)noiseShape[noise_select + 0x22].shapex -
               (int)(short)(noiseShape[noise_select + 0x22].shapex & 0xffc0)) * 0x10;
        prev_pkt_b[0x18] = (char)noiseShape[noise_select + 0x22].width + (char)(ti17 / (int)tu15);
        prev_pkt_b[0x19] = (char)noiseShape[noise_select + 0x22].shapey + -1;
        tu15 = (u_int)(u_char)noiseShape[noise_select + 0x22].depth;
        ti17 = ((int)noiseShape[noise_select + 0x22].shapex -
               (int)(short)(noiseShape[noise_select + 0x22].shapex & 0xffc0)) * 0x10;
        prev_pkt_b[0x24] = (char)(ti17 / (int)tu15);
        prev_pkt_b[0x25] =
             (char)noiseShape[noise_select + 0x22].height +
             (char)noiseShape[noise_select + 0x22].shapey + -1;
        tu15 = (u_int)(u_char)noiseShape[noise_select + 0x22].depth;
        ti17 = ((int)noiseShape[noise_select + 0x22].shapex -
               (int)(short)(noiseShape[noise_select + 0x22].shapex & 0xffc0)) * 0x10;
        prev_pkt_b[0x30] = (char)noiseShape[noise_select + 0x22].width + (char)(ti17 / (int)tu15);
        prev_pkt_b[0x31] =
             (char)noiseShape[noise_select + 0x22].height +
             (char)noiseShape[noise_select + 0x22].shapey + -1;
        *(u_short *)(prev_pkt_b + 0x1a) =
             ((u_char)(*((u_char *)&noiseShape[noise_select + 0x22] + 9)) & 3) << 7 |
             (short)(noiseShape[noise_select + 0x22].shapey & 0x100U) >> 4 | 0x60U |
             (u_short)(((u_short)noiseShape[noise_select + 0x22].shapex & 0x3c0) >> 6) |
             (noiseShape[noise_select + 0x22].shapey & 0x200U) << 2;
        ts4 = GetClut((noiseShape[noise_select + 0x22].clutID & 0x3fU) << 4,
                         noiseShape[noise_select + 0x22].clutID >> 6);
        *(short *)(prev_pkt_b + 0xe) = ts4;
      }
    }
    tp10 = Render_gPacketPtr;
    cur_pkt_a = Render_gPalettePtr;
    if (tv.state != tv_StateOff) {
      *(u_int *)Render_gPacketPtr =
           *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      tu15 = (u_int)Render_gPacketPtr & 0xffffff;
      Render_gPacketPtr = Render_gPacketPtr + 0x28;
      *(u_int *)cur_pkt_a = *(u_int *)cur_pkt_a & 0xff000000 | tu15;
      *(u_int *)(tp10 + 4) = tu24;
      SetPolyFT4((POLY_FT4 *)tp10);
      SetSemiTrans(tp10,0);
      SetShadeTex(tp10,do_tint ^ 1);
      *(short *)(tp10 + 8) = ts1;
      *(u_short *)(tp10 + 10) = tu2;
      ts20 = ts1 + ts13;
      *(short *)(tp10 + 0x10) = ts20;
      *(u_short *)(tp10 + 0x12) = tu2;
      *(short *)(tp10 + 0x18) = ts1;
      *(short *)(tp10 + 0x20) = ts20;
      tu17 = (short)(tvY + (u_int)tu3);
      *(short *)(tp10 + 0x1a) = tu17;
      *(short *)(tp10 + 0x22) = tu17;
      tp10[0xc] = tv.u;
      tp10[0xd] = tv.v;
      tp10[0x14] = tv.u + tv.uw;
      tp10[0x15] = tv.v;
      tp10[0x1c] = tv.u;
      tp10[0x1d] = tv.v + tv.vh;
      tp10[0x24] = tv.u + tv.uw;
      tp10[0x25] = tv.v + tv.vh;
      *(u_short *)(tp10 + 0x16) = tv.tpage;
      *(u_short *)(tp10 + 0xe) = tv.clut;
      tp10 = Render_gPacketPtr;
      cur_pkt_a = Render_gPalettePtr;
      if ((tv.flags & 4) != 0) {
        ti17 = ((u_int)tv.flip_axis - tvY) + 1;
        if (ti17 * 0x10000 < 0) {
          ti17 = -ti17;
        }
        ts5 = (short)(ti17 << 1);
        if (0x80 < (ti17 << 0x11) >> 0x10) {
          ts5 = 0x80;
        }
        ti17 = ((u_int)tv.flip_axis - (tvY + (u_int)tu3)) + 1;
        if (ti17 * 0x10000 < 0) {
          ti17 = -ti17;
        }
        ts13 = (short)(ti17 << 1);
        if (0x80 < (ti17 << 0x11) >> 0x10) {
          ts13 = 0x80;
        }
        tu15 = tu24 >> 0x10 & 0xff;
        ti17 = 0x80 - ts5;
        tu21 = tu24 >> 8 & 0xff;
        ti10 = 0x80 - ts13;
        *(u_int *)Render_gPacketPtr =
             *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
        tu24 = (u_int)Render_gPacketPtr & 0xffffff;
        Render_gPacketPtr = Render_gPacketPtr + 0x34;
        *(u_int *)cur_pkt_a = *(u_int *)cur_pkt_a & 0xff000000 | tu24;
        tp10[3] = 0xc;
        tu24 = (tu15 * ti17 >> 7) << 0x10 | (tu21 * ti17 >> 7) << 8 | (tu18 & 0xffU) * ti17 >> 7;
        *(short *)(tp10 + 8) = ts1;
        *(u_int *)(tp10 + 0x10) = tu24;
        *(u_int *)(tp10 + 4) = tu24;
        tu24 = (tu15 * ti10 >> 7) << 0x10 | (tu21 * ti10 >> 7) << 8 | (tu18 & 0xffU) * ti10 >> 7;
        *(u_int *)(tp10 + 0x28) = tu24;
        *(u_int *)(tp10 + 0x1c) = tu24;
        tp10[7] = 0x3c;
        tu4 = tv.flip_axis;
        *(short *)(tp10 + 0x14) = ts20;
        *(u_short *)(tp10 + 10) = tu4 * 2 - tu2;
        tu4 = tv.flip_axis;
        *(short *)(tp10 + 0x20) = ts1;
        *(u_short *)(tp10 + 0x16) = tu4 * 2 - tu2;
        tu4 = tv.flip_axis;
        *(short *)(tp10 + 0x2c) = ts20;
        *(u_short *)(tp10 + 0x22) = (tu4 * 2 - tu2) - tu3;
        *(u_short *)(tp10 + 0x2e) = (tv.flip_axis * 2 - tu2) - tu3;
        tp10[0xc] = tv.u;
        tp10[0xd] = tv.v + 0xff;
        tp10[0x18] = tv.u + tv.uw;
        tp10[0x19] = tv.v + 0xff;
        tp10[0x24] = tv.u;
        tp10[0x25] = tv.v + tv.vh + 0xff;
        tp10[0x30] = tv.u + tv.uw;
        tp10[0x31] = tv.v + tv.vh + 0xff;
        *(u_short *)(tp10 + 0x1a) = tv.tpage;
        *(u_short *)(tp10 + 0xe) = tv.clut;
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
