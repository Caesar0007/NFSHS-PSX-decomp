void FontUpsideDownBlit(int x,int y,void *src,int u,int v,charactertbl *ch,int arg6)

{
  POLY_FT4 *prim;
  int       width;
  int       height;
  int       dv;

  width = ch->width;
  height = ch->height;
  prim = (POLY_FT4 *)Render_gPacketPtr;
  Render_gPacketPtr = (u_char *)prim + 0x28;
  dv = (((*(int *)((int)src + 0xc) << 4) >> 0x14) + v & 0xff) - 1;
  y = y - *(signed char *)&ch->yoffset;
  arg6 = y + 5;
  y = arg6 - (height + *(signed char *)&ch->yoffset);
  ((PSXFront_PTag *)prim)->addr = ((PSXFront_PTag *)Render_gPalettePtr)->addr,
  ((PSXFront_PTag *)Render_gPalettePtr)->addr = (uint)prim;
  ((u_char *)prim)[3] = 9;
  prim->code = 0x2c;
  *(u_long *)&prim->r0 = font_tint;
  prim->clut = gFontClut;
  prim->tpage = (*(byte *)src & 3) << 7 | (uint)*(int *)((int)src + 0xc) >> 0x14 & 0x10 |
                (*(int *)((int)src + 0xc) & 0x3ff) >> 6;
  prim->u0 = u, prim->v0 = dv,
  prim->u1 = u + width, prim->v1 = dv,
  prim->u2 = u, prim->v2 = dv + height,
  prim->u3 = u + width, prim->v3 = dv + height;
  prim->x0 = x, prim->y0 = y + height,
  prim->x1 = x + width, prim->y1 = y + height,
  prim->x2 = x, prim->y2 = y,
  prim->x3 = x + width, prim->y3 = y;
  return;
}
