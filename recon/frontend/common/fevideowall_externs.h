/* frontend/common/fevideowall_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FEVIDEOWALL_EXTERNS_H_
#define _FE_FEVIDEOWALL_EXTERNS_H_
#include "../../nfs4_types.h"

extern int ticks;

/* TV tiles (FETv) */
void  InitTV(tTVConfig*, tTexture_ShapeInfo*, short);
void  DrawTV(tTVConfig*);
void  DrawTVLines(tTVConfig*);
void  TurnOnTV(tTVConfig*);
void  TurnOffTV(tTVConfig*);

/* drawing / text */
void  DrawShapeExtended(int, int, int, int, int, int, tDrawShapeExtended*);
int   CalcFadeVal(int, int);
void  FETextRender_SetABR(int, bool);
void  FETextRender_FullTextRGB(char*, short, short, int, char, short);
char *TextSys_Word(int);

#endif
