/* frontend/common/fetv_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FETV_EXTERNS_H_
#define _FE_SCREENS_FETV_EXTERNS_H_
#include "fetv_types.h"
extern "C" int rand();
extern "C" unsigned short GetClut(int x, int y);
extern tTexture_ShapeInfo *gHelpShapes; /* P886: native768122 scalar pointer. */
void  FeDraw_SetABRMode(int abr);
void  PSXDrawTransSquare(int color, int x, int y, int w, int h, short abe);
void  DrawShapeExtended(int, int, int, int, int, int, tDrawShapeExtended*);
int   CalcFadeVal(int color, int fade);
void  DrawTVLines(tTVConfig &tv);
/* Prototypes for callees this TU used to call undeclared: CC1PLPSX 2.8.0 accepts the implicit `int f(...)` but wraps
   every such call statement in nested debug scopes retail's SYM does not have (tools/psyq_pipe/implicit_sweep.py). */
extern "C" void SetPolyFT4(POLY_FT4 *p);
extern "C" void SetSemiTrans(void *p, int abe);
extern "C" void SetShadeTex(void *p, int tge);

static inline void FETVLinkFT4(u_int *palette,POLY_FT4 *primitive,
                               u_char **packetPtrSlot,u_int rgbMask)
{
  u_int paletteTag;

  *(u_int *)primitive =
       *(u_int *)primitive & 0xff000000 | *palette & rgbMask;
  paletteTag = *palette;
  *packetPtrSlot = (u_char *)primitive + 0x28;
  *palette = paletteTag & 0xff000000 | (u_int)primitive & rgbMask;
}

#endif
