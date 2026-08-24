/* Saved from recon/frontend/psx/psxfront.cpp on 2026-08-24.
 *
 * Receipt: 52 diffs, 82/82 instructions, no asm, no volatile.  Retail's
 * semantic debug declaration set and single source block are restored:
 * unnamed seventh ABI slot; locals only prim/width/height/dv. */

typedef struct {
  unsigned addr : 24, len : 8;
} PSXFront_PTag;

#define PSXFRONT_FONT_PACKET_HEAD(prim,src,v,dv) {                       \
  dv = (((*(int *)((int)src + 0xc) << 4) >> 0x14) + v & 0xff) - 1;      \
  *(u_long *)&prim->r0 = font_tint;                                      \
  ((PSXFront_PTag *)prim)->addr =                                       \
      ((PSXFront_PTag *)Render_gPalettePtr)->addr,                       \
  ((PSXFront_PTag *)Render_gPalettePtr)->addr = (uint)prim;              \
}

#define PSXFRONT_FONT_GEOMETRY(prim,src,x,y,u,dv,width,height) {          \
  prim->tpage = (*(byte *)src & 3) << 7 |                                \
                (uint)*(int *)((int)src + 0xc) >> 0x14 & 0x10 |          \
                (*(int *)((int)src + 0xc) & 0x3ff) >> 6;                 \
  prim->u0 = u, prim->v0 = dv,                                           \
  prim->u1 = u + width, prim->v1 = dv;                                   \
  prim->u2 = u, prim->v2 = dv + height,                                  \
  prim->u3 = u + width, prim->v3 = dv + height;                          \
  prim->x0 = x;                                                          \
  prim->y0 = y + height,                                                 \
  prim->x1 = x + width, prim->y1 = y + height,                           \
  prim->x2 = x, prim->y2 = y,                                            \
  prim->x3 = x + width, prim->y3 = y;                                    \
}

void FontUpsideDownBlit(int x,int y,void *src,int u,int v,
                        charactertbl *ch,int)
{
  POLY_FT4 *prim;
  int width;
  int height;
  int dv;

  width = ch->width;
  height = ch->height;
  y -= *(signed char *)&ch->yoffset;
  y += 5;
  y -= height + *(signed char *)&ch->yoffset;
  prim = (POLY_FT4 *)Render_gPacketPtr;
  Render_gPacketPtr = (u_char *)prim + 0x28;
  PSXFRONT_FONT_PACKET_HEAD(prim,src,v,dv);
  ((PSXFront_PTag *)prim)->len = 9,
  prim->code = 0x2c;
  prim->clut = gFontClut;
  PSXFRONT_FONT_GEOMETRY(prim,src,x,y,u,dv,width,height);
  return;
}
