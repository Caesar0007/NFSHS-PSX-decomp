/* frontend/common/fetv.cpp -- RECONSTRUCTED (front-end "TV" grid widget; C++ TU)
 *   5 free fns on tTVConfig& (ns nfs4::FRONTEND::COMMON::FETv): DrawTVLines (scanline/stripe
 *   overlay), DrawTV (3260 B -- the TV-grid background drawer), InitTV, TurnOffTV, TurnOnTV.
 *   GPU packet building via Render_gPacketPtr/Render_gPalettePtr.
 */
#include "fetv.h"

typedef struct { unsigned addr : 24, len : 8; } FETV_PTag;
#define FETV_setXYWH(p, x, y, w, h) \
  ((p)->x0 = (x), (p)->y0 = (y), \
   (p)->x1 = (x) + (w), (p)->y1 = (y), \
   (p)->x2 = (x), (p)->y2 = (y) + (h), \
   (p)->x3 = (x) + (w), (p)->y3 = (y) + (h))


/* ---- DrawTVLines  [FETV.CPP:25-77] SLD-VERIFIED ---- */

void DrawTVLines(tTVConfig &tv)

{
  short fxHeight;
  short x;
  short y;
  POLY_F4 *videoFX;

  tv.fxWide = (short)((tv.fxWide + 1) % (tv.h * 0x30));
  tv.fxThin = (short)((tv.fxThin + 2) % (tv.h * 0x30));
  y = tv.fxWide;
  fxHeight = 8;
  if ((int)tv.fxWide < (int)tv.y) {
    fxHeight = (short)(fxHeight - ((u_int)tv.y - (u_int)y));
    y = tv.y;
  }
  else {
    if (tv.fxWide + 8 > (int)((u_int)tv.y + (int)tv.h)) {
      fxHeight = (short)((u_int)tv.y - (u_int)y);
    }
  }
  if (0 < (fxHeight << 0x10)) {
    videoFX = (POLY_F4 *)Render_gPacketPtr;
    ((FETV_PTag *)videoFX)->addr = ((FETV_PTag *)Render_gPalettePtr)->addr;
    Render_gPacketPtr = Render_gPacketPtr + 0x18;
    ((FETV_PTag *)Render_gPalettePtr)->addr = (u_int)videoFX;
    videoFX->code = 0x2a;
    ((FETV_PTag *)videoFX)->len = 5;
    FETV_setXYWH(videoFX,tv.x,y,tv.w,fxHeight);
    videoFX->b0 = 10;
    videoFX->g0 = 10;
    videoFX->r0 = 10;
  }
  y = tv.fxThin;
  if (((int)tv.fxThin > (int)tv.y) && ((int)tv.fxThin < (int)tv.y + (int)tv.h)) {
    videoFX = (POLY_F4 *)Render_gPacketPtr;
    ((FETV_PTag *)videoFX)->addr = ((FETV_PTag *)Render_gPalettePtr)->addr;
    Render_gPacketPtr = Render_gPacketPtr + 0x18;
    ((FETV_PTag *)Render_gPalettePtr)->addr = (u_int)videoFX;
    videoFX->code = 0x2a;
    ((FETV_PTag *)videoFX)->len = 5;
    FETV_setXYWH(videoFX,tv.x,y,tv.w,1);
    videoFX->b0 = 10;
    videoFX->g0 = 10;
    videoFX->r0 = 10;
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

/* MATCH W61 (2026-08-10): the retail state dispatch is a four-case switch.
   The former range-folded if/else chain changed both its branch tree and the
   rendering allocator handoff.  Restoring the discrete cases reduces the
   authoritative residual from 151 to 135 without changing behavior.
   W62: after each absolute-value clamp input is known nonnegative; promoting
   the short through u_short for the multiply avoids premature sign-extension
   and reduces DrawTV from 135 to 131 without volatile lifetime constraints.

   W61-A16 (2026-08-15): the `(u_short)` promotion above was itself the last
   truncation.  Retail doubles the clamp input with a bare `sll v0,a0,1` on the
   UNTRUNCATED abs value and only sign-extends for the `> 0x80` compare
   (`sll 16 / sra 16`); the u_short cast emitted an extra `andi v0,a0,65535`
   and shifted the pair to `sll 17`.  Spelling the doubling as a SHIFT
   (`fadeTop = fadeTop << 1;`, all four sites) drops both `andi`s and their
   downstream fallout: 131 -> 107, count unchanged 822.
   Measured alternatives at the same four sites: `fadeTop += fadeTop;` 107
   (tie -- shift chosen because retail's insn IS an sll); plain
   `fadeTop * 2` 135; `(int)fadeTop * 2` 135; `(short)(fadeTop * 2)` 135.

   RESIDUAL 107 (ours 822 / oracle 815), two named clusters:
   (a) an s4/s7 SWAP on the two function-long constants -- retail parks the
       0x1F800004 packet-slot address in s7 and the 0x00FFFFFF rgb mask in s4,
       we do the reverse (both are global allocnos; global.c hands the lower
       s-reg to whichever it allocates first, so this is an allocno-priority
       tie, not a materialisation-order one: both builds emit the ptr pair
       BEFORE the mask pair).  Naming the mask as a local `u_int rgbmask`
       declared either BEFORE or AFTER packetPtrSlot is exactly NEUTRAL on
       diffs (107) while shortening us by 2 insns (820) -- i.e. the W61-A1
       name-the-constant lever reaches the frame but not this handout.
   (b) a +7 insn surplus: retail RE-USES the just-loaded packet pointer for
       the bump (`addiu v1,s0,40; sw v1,0(s7)`) where we reload the slot.
       Writing that as `*packetPtrSlot = (u_char *)texture + 0x28;` etc. does
       close the count (822 -> 820 -> 818 -> 816) but re-basins the allocator
       every time: 0x28-only 121, 0x34-only 175, all-sites 195, all+named mask
       205, mask+0x28 131.  ALL REVERTED (09K non-monotone).  => the count gap
       and the s4/s7 tie are one event; the open angle is an allocno-priority
       dial that buys the reuse WITHOUT re-coloring. */

void DrawTV(tTVConfig &tv)

{
  POLY_FT4 *texture;
  POLY_GT4 *reflection;
  tTexture_ShapeInfo *noise = &gHelpShapes[0][(rand() & 3) + 0x22];
  short videoX;
  short videoY;
  short videoWidth;
  short videoHeight;
  short fadeTop;
  short fadeBottom;
  u_long tint;
  short bright;
  BOOL do_tint = 1;

  bright = tv.destBrightness;
  tint = tv.tint;
  videoX = tv.x;
  videoY = tv.y;
  videoWidth = tv.w;
  videoHeight = tv.h;
  if ((tv.flags & 2) == 0) {
    tint = 0x808080;
    do_tint = 0;
  }
  if (tv.transition != tv.destBrightness) {
    if ((tv.transition < tv.destBrightness) &&
        ((u_int)(tv.state - tv_StateOn) < 2)) {
      tv.transition += 4;
      if (tv.destBrightness < tv.transition) {
        tv.transition = tv.destBrightness;
      }
    }
    else if ((tv.state == tv_TransitionOff) || (tv.state == tv_StateOn)) {
      tv.transition -= 8;
      if (tv.transition < tv.destBrightness) {
        tv.transition = tv.destBrightness;
      }
    }
  }
  switch (tv.state) {
  case tv_StateOn:
    bright = tv.destBrightness;
    break;
  case tv_StateOff:
    bright = tv.destBrightness;
    break;
  case tv_TransitionOn:
    do_tint = 1;
    if (tv.transition == tv.destBrightness) {
      tv.state = tv_StateOn;
    }
    bright = tv.transition;
    break;
  case tv_TransitionOff:
    do_tint = 1;
    if (tv.transition == tv.destBrightness) {
      tv.state = tv_StateOff;
    }
    bright = tv.transition;
    break;
  }
  fadeTop = (short)((u_int)tint >> 0x10 & 0xff);
  tint = ((u_int)(fadeTop * bright) >> 7) << 0x10 |
         (((u_int)tint >> 8 & 0xff) * bright >> 7) << 8 |
         (tint & 0xffU) * bright >> 7;
  if ((tv.flags & 8) == 0) {
    DrawTVLines(tv);
  }
  if ((tv.flags & 0x10) == 0) {
    u_char **packetPtrSlot = (u_char **)0x1f800004;

    if (tv.state != tv_StateOn) {
      u_int *palette;

      texture = (POLY_FT4 *)*packetPtrSlot;
      palette = (u_int *)Render_gPalettePtr;
      *(u_int *)texture =
           *(u_int *)texture & 0xff000000 | *palette & 0xffffff;
      *packetPtrSlot = *packetPtrSlot + 0x28;
      *palette = *palette & 0xff000000 | (u_int)texture & 0xffffff;
      *(u_int *)&texture->r0 =
           (0x40 - (bright >> 1)) * 0x10000 |
           (0x40 - (bright >> 1)) * 0x100 |
           (0x40 - (bright >> 1));
      SetPolyFT4(texture);
      SetSemiTrans(texture,1);
      SetShadeTex(texture,0);
      texture->x0 = videoX;
      texture->y0 = videoY;
      texture->x1 = videoX + videoWidth;
      texture->y1 = videoY;
      texture->x2 = videoX;
      texture->y2 = videoY + videoHeight;
      texture->x3 = videoX + videoWidth;
      texture->y3 = videoY + videoHeight;
      texture->u0 = ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10 /
                    (int)noise->depth;
      texture->v0 = noise->shapey;
      texture->u1 = noise->width +
                    ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10 /
                    (int)noise->depth;
      texture->v1 = noise->shapey;
      texture->u2 = ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10 /
                    (int)noise->depth;
      texture->v2 = noise->height + noise->shapey;
      texture->u3 = noise->width +
                    ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10 /
                    (int)noise->depth;
      texture->v3 = noise->height + noise->shapey;
      texture->tpage =
           ((u_char)(*((u_char *)noise + 9)) & 3) << 7 |
           ((short)(noise->shapey & 0x100U) >> 4 | 0x60U) |
           (u_short)(((u_short)noise->shapex & 0x3c0) >> 6) |
           (noise->shapey & 0x200U) << 2;
      texture->clut =
           GetClut((noise->clutID & 0x3fU) << 4, noise->clutID >> 6);
      if ((tv.flags & 4) != 0) {
        fadeTop = tv.flip_axis - videoY + 1;
        if (fadeTop < 0) {
          fadeTop = -fadeTop;
        }
        fadeTop = fadeTop << 1;
        if (fadeTop > 0x80) {
          fadeTop = 0x80;
        }
        fadeBottom = tv.flip_axis - (videoY + videoHeight) + 1;
        if (fadeBottom < 0) {
          fadeBottom = -fadeBottom;
        }
        fadeBottom = fadeBottom << 1;
        if (fadeBottom > 0x80) {
          fadeBottom = 0x80;
        }
        reflection = (POLY_GT4 *)*packetPtrSlot;
        *(u_int *)*packetPtrSlot =
             *(u_int *)*packetPtrSlot & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
        *packetPtrSlot = *packetPtrSlot + 0x34;
        *(u_int *)Render_gPalettePtr =
             *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)reflection & 0xffffff;
        *(u_int *)&reflection->r0 = *(u_int *)&reflection->r1 =
             (((0x80 - bright) * (0x80 - fadeTop) / 0x80) << 0x10) |
             (((0x80 - bright) * (0x80 - fadeTop) / 0x80) << 8) |
             ((0x80 - bright) * (0x80 - fadeTop) / 0x80);
        *(u_int *)&reflection->r2 = *(u_int *)&reflection->r3 =
             (((0x80 - bright) * (0x80 - fadeBottom) / 0x80) << 0x10) |
             (((0x80 - bright) * (0x80 - fadeBottom) / 0x80) << 8) |
             ((0x80 - bright) * (0x80 - fadeBottom) / 0x80);
        reflection->code = 0x3e;
        ((u_char *)reflection)[3] = 0xc;
        reflection->x0 = videoX;
        reflection->y0 = tv.flip_axis * 2 - videoY;
        reflection->x1 = videoX + videoWidth;
        reflection->y1 = tv.flip_axis * 2 - videoY;
        reflection->x2 = videoX;
        reflection->y2 = (tv.flip_axis * 2 - videoY) - videoHeight;
        reflection->x3 = videoX + videoWidth;
        reflection->y3 = (tv.flip_axis * 2 - videoY) - videoHeight;
        reflection->u0 = ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10 /
                         (int)noise->depth;
        reflection->v0 = noise->shapey - 1;
        reflection->u1 = noise->width +
                         ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10 /
                         (int)noise->depth;
        reflection->v1 = noise->shapey - 1;
        reflection->u2 = ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10 /
                         (int)noise->depth;
        reflection->v2 = noise->shapey - 1 + noise->height;
        reflection->u3 = noise->width +
                         ((int)noise->shapex - (int)(short)(noise->shapex & 0xffc0)) * 0x10 /
                         (int)noise->depth;
        reflection->v3 = noise->shapey - 1 + noise->height;
        reflection->tpage =
             ((u_char)(*((u_char *)noise + 9)) & 3) << 7 |
             ((short)(noise->shapey & 0x100U) >> 4 | 0x60U) |
             (u_short)(((u_short)noise->shapex & 0x3c0) >> 6) |
             (noise->shapey & 0x200U) << 2;
        reflection->clut =
             GetClut((noise->clutID & 0x3fU) << 4, noise->clutID >> 6);
      }
    }
    if (tv.state != tv_StateOff) {
      texture = (POLY_FT4 *)*packetPtrSlot;
      *(u_int *)*packetPtrSlot =
           *(u_int *)*packetPtrSlot & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
      *packetPtrSlot = *packetPtrSlot + 0x28;
      *(u_int *)Render_gPalettePtr =
           *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)texture & 0xffffff;
      *(u_int *)&texture->r0 = tint;
      SetPolyFT4(texture);
      SetSemiTrans(texture,0);
      SetShadeTex(texture,do_tint ^ 1);
      texture->x0 = videoX;
      texture->y0 = videoY;
      texture->x1 = videoX + videoWidth;
      texture->y1 = videoY;
      texture->x2 = videoX;
      texture->y2 = videoY + videoHeight;
      texture->x3 = videoX + videoWidth;
      texture->y3 = videoY + videoHeight;
      texture->u0 = tv.u;
      texture->v0 = tv.v;
      texture->u1 = tv.u + tv.uw;
      texture->v1 = tv.v;
      texture->u2 = tv.u;
      texture->v2 = tv.v + tv.vh;
      texture->u3 = tv.u + tv.uw;
      texture->v3 = tv.v + tv.vh;
      texture->tpage = tv.tpage;
      texture->clut = tv.clut;
      if ((tv.flags & 4) != 0) {
        fadeTop = tv.flip_axis - videoY + 1;
        if (fadeTop < 0) {
          fadeTop = -fadeTop;
        }
        fadeTop = fadeTop << 1;
        if (fadeTop > 0x80) {
          fadeTop = 0x80;
        }
        fadeBottom = tv.flip_axis - (videoY + videoHeight) + 1;
        if (fadeBottom < 0) {
          fadeBottom = -fadeBottom;
        }
        fadeBottom = fadeBottom << 1;
        if (fadeBottom > 0x80) {
          fadeBottom = 0x80;
        }
        texture = (POLY_FT4 *)*packetPtrSlot;
        *(u_int *)*packetPtrSlot =
             *(u_int *)*packetPtrSlot & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
        *packetPtrSlot = *packetPtrSlot + 0x34;
        *(u_int *)Render_gPalettePtr =
             *(u_int *)Render_gPalettePtr & 0xff000000 | (u_int)texture & 0xffffff;
        ((u_char *)texture)[3] = 0xc;
        *(u_int *)&((POLY_GT4 *)texture)->r0 = *(u_int *)&((POLY_GT4 *)texture)->r1 =
             (((tint >> 16 & 0xff) * (0x80 - fadeTop) >> 7) << 16) |
             (((tint >> 8 & 0xff) * (0x80 - fadeTop) >> 7) << 8) |
             ((tint & 0xff) * (0x80 - fadeTop) >> 7);
        *(u_int *)&((POLY_GT4 *)texture)->r2 = *(u_int *)&((POLY_GT4 *)texture)->r3 =
             (((tint >> 16 & 0xff) * (0x80 - fadeBottom) >> 7) << 16) |
             (((tint >> 8 & 0xff) * (0x80 - fadeBottom) >> 7) << 8) |
             ((tint & 0xff) * (0x80 - fadeBottom) >> 7);
        ((POLY_GT4 *)texture)->code = 0x3c;
        ((POLY_GT4 *)texture)->x0 = videoX;
        ((POLY_GT4 *)texture)->y0 = tv.flip_axis * 2 - videoY;
        ((POLY_GT4 *)texture)->x1 = videoX + videoWidth;
        ((POLY_GT4 *)texture)->y1 = tv.flip_axis * 2 - videoY;
        ((POLY_GT4 *)texture)->x2 = videoX;
        ((POLY_GT4 *)texture)->y2 = (tv.flip_axis * 2 - videoY) - videoHeight;
        ((POLY_GT4 *)texture)->x3 = videoX + videoWidth;
        ((POLY_GT4 *)texture)->y3 = (tv.flip_axis * 2 - videoY) - videoHeight;
        ((POLY_GT4 *)texture)->u0 = tv.u;
        ((POLY_GT4 *)texture)->v0 = tv.v - 1;
        ((POLY_GT4 *)texture)->u1 = tv.u + tv.uw;
        ((POLY_GT4 *)texture)->v1 = tv.v - 1;
        ((POLY_GT4 *)texture)->u2 = tv.u;
        ((POLY_GT4 *)texture)->v2 = tv.vh - 1 + tv.v;
        ((POLY_GT4 *)texture)->u3 = tv.u + tv.uw;
        ((POLY_GT4 *)texture)->v3 = tv.vh - 1 + tv.v;
        ((POLY_GT4 *)texture)->tpage = tv.tpage;
        ((POLY_GT4 *)texture)->clut = tv.clut;
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
