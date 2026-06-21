/* frontend/screens/screenusername_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENUSERNAME_EXTERNS_H_
#define _FE_SCREENS_SCREENUSERNAME_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern tfrontEnd frontEnd;          /* FE state (.language) */

/* ===== globals owned by ScreenUserName.obj (.bss zero; declared extern in screenusername.h) ===== */
short            menu_kUserNameRows  = 0;   /* @0x800529b0 bss(zero) row count */
short            MENUUSERNAME_STARTY = 0;   /* @0x800529b2 bss(zero) vertical-centre offset */
tScreenUserName *screenUserName      = 0;   /* @0x800529b4 bss(zero); front.cpp assigns &gAllScreens->screenUserName */
char             UserPermFileName[20];      /* @0x800529b8 bss(zero) shape file name */

/* game C++ helpers (cfront-mangled in originals; normal C++ linkage) */
char *TextSys_Word(int wordnum);
void  SubtractiveBox(int x, int y, int w, int h, int col1, int col2, int col3, int col4);
void  DrawShapeExtended(int index, int flags, int x, int y, int fade, int abr, tDrawShapeExtended *extra);
int   CalcFadeVal(int col1, int col2, int amount);   /* 3-arg overload */
int   CalcFadeVal(int col1, int amount);             /* 2-arg overload */
void  PSXDrawBrightEndLine(int col, int x, int y, int w, int h, int side, int fade, int darksides);
void  PSXDrawSquare(int col, int x, int y, int w, int h);
void  FETextRender_FullTextRGB(char *sMenuText, short x, short y, int col, char size, short justify);


#endif