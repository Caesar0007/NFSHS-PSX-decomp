/* frontend/common/fevideowall_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FEVIDEOWALL_EXTERNS_H_
#define _FE_FEVIDEOWALL_EXTERNS_H_
#include "fevideowall_types.h"

/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/vars.h"
}

/* TV tiles (FETv) */
void  InitTV(tTVConfig&, tTexture_ShapeInfo*, short);
void  DrawTV(tTVConfig&);
void  DrawTVLines(tTVConfig&);
void  TurnOnTV(tTVConfig&);
void  TurnOffTV(tTVConfig&);

/* drawing / text */
void  DrawShapeExtended(int, int, int, int, int, int, tDrawShapeExtended*);
int   CalcFadeVal(int, int);
void  FETextRender_SetABR(int, bool);
void  FETextRender_FullTextRGB(char*, short, short, int, char, short);
char *TextSys_Word(int);

/* retail's SYM records an inline-call pair at every tick read in this TU: the tick counter is read
   through an inline getter, not directly */
static inline int FE_Ticks(void) { return ticks; }

#endif
