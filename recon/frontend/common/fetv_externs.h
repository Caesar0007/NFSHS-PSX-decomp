/* frontend/common/fetv_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FETV_EXTERNS_H_
#define _FE_SCREENS_FETV_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"
extern tTexture_ShapeInfo *gHelpShapes;
void  FeDraw_SetABRMode(int abr);
void  PSXDrawTransSquare(int color, int x, int y, int w, int h, short abe);
void  DrawShapeExtended(int, int, int, int, int, int, tDrawShapeExtended*);
int   CalcFadeVal(int color, int fade);
void  DrawTVLines(tTVConfig &tv);
#endif
