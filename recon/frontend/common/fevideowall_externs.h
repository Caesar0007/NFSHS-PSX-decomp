/* frontend/common/fevideowall_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FEVIDEOWALL_EXTERNS_H_
#define _FE_FEVIDEOWALL_EXTERNS_H_
#include "fevideowall_types.h"

extern int ticks[];

/* TV tiles (FETv) */
void  InitTV(tTVConfig*, tTexture_ShapeInfo*, short) asm("InitTV__FR9tTVConfigP18tTexture_ShapeInfos");
void  DrawTV(tTVConfig*) asm("DrawTV__FR9tTVConfig");
void  DrawTVLines(tTVConfig*) asm("DrawTVLines__FR9tTVConfig");
void  TurnOnTV(tTVConfig*) asm("TurnOnTV__FR9tTVConfig");
void  TurnOffTV(tTVConfig*) asm("TurnOffTV__FR9tTVConfig");

/* drawing / text */
void  DrawShapeExtended(int, int, int, int, int, int, tDrawShapeExtended*);
int   CalcFadeVal(int, int);
void  FETextRender_SetABR(int, bool);
void  FETextRender_FullTextRGB(char*, short, short, int, char, short);
char *TextSys_Word(int);

#endif
