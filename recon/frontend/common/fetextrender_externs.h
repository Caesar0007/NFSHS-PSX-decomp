/* frontend/common/fetextrender_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FETEXTRENDER_EXTERNS_H_
#define _FE_SCREENS_FETEXTRENDER_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"
extern short  currentSize;
extern char  *font12, *font18, *fontTitle;
extern tFEApplication *FEApp;
extern int    kRGBVals[];                 /* FEColor.obj */
int   CalcFadeVal(int color, int fade);   /* fefades.obj */
int   TextSys_WordX(int id);
int   TextSys_WordY(int id);
void  FETextRender_Title(short index);
/* same-TU forward decls */
void  FETextRender_SetFont(int size);
void  FETextRender_FullText(char *s, short x, short y, tMenuTextType type, tMenuTextState state, short j);
void  FETextRender_MenuTextPositionedJustify(short index, short x, short y, short justify, tMenuTextState state, tMenuTextType type);
void  FETextRender_MenuTextPositionedJustifyFade(int fade, short index, short x, short y, short justify, tMenuTextState state, tMenuTextType type);
int   FETextRender_WordWrapTextRGBJustify(char *str, RECT &r, int col, int justify, int size, bool JustGrabHeight);
/* engine */
void  Font_SwitchFont(char *f);  void Font_TextColor(int c);  void Font_TextTint(int t);
void  Font_TextXY(char *s, int x, int y);  void Font_SetABR(int abr);
int   textpixels(char *s);  char *TextSys_Word(int id);  int TextSys_WordFlags(int id);
void  s_lower(char *s);
void  PSXDrawTransSquare(int color, int x, int y, int w, int h, short abe);
void  FeDraw_SetABRMode(int abr);
#endif
