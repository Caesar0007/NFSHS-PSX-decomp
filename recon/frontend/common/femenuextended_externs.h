/* frontend/common/femenuextended_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FEMENUEXTENDED_EXTERNS_H_
#define _FE_SCREENS_FEMENUEXTENDED_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"
extern tFEApplication *FEApp;
extern tfrontEnd frontEnd;
extern tPadModuleState gPadinfo;
extern int ticks[];
extern tGlobalMenuDefs *menuDefs;
/* class vtables (FEMenuExtended.obj-defined subclasses) */
extern __vtbl_ptr_type tMenuItemGoToMenuNFS4Button_vtable[], tMenuItemNFS4LeftRightChoice_vtable[],
  tMenuItemOptionsLeftRightChoice_vtable[], tMenuItemOptionsTwoItemChoice_vtable[],
  tMenuNFS4_vtable[], tMenuNFS4TwoPlayer_vtable[], tMenuNFS4Bottom_vtable[],
  tMenuBlank_vtable[], tMenuOptions_vtable[];
/* engine helpers (shared with FeMenuOptions) */
int   CalcFadeVal(int, int);  int CalcFadeVal(int,int,int);  int CalcFadeVal(int,int,int,int);
void  DrawShapeExtended(int,int,int,int,int,int,tDrawShapeExtended*);
void  ScaleShapeExtended(int,int,int,int,int,int,tDrawShapeExtended*);
void  PSXDrawSquare(int,int,int,int,int);  void PSXDrawTransSquare(int,int,int,int,int,short);
void  FeDraw_SetABRMode(int);  void Flare_2DHalo(int,int,int,int,int);
int   TextSys_WordX(int);  int TextSys_WordY(int);  char *TextSys_Word(int);  int TextSys_WordFlags(int);
void  AudioCmn_PlayFESFX(int);  void AudioCmn_PlayFESFXVol(int,int);
extern tTexture_ShapeInfo *gHelpShapes;  extern tPlayer gMenu_SubMenuPlayer;
void  FETextRender_FullTextRGB(char*,short,short,int,char,short);
void  FETextRender_Title(short);
void  FETextRender_WordWrapTextRGBJustify(char*,RECT&,int,int,int,bool);
int   CalcTextFadeSelToHi(tMenuTextType, short, short);  int CalcTextFadeUnselToSel(tMenuTextType, short, short);
extern char textDefinitions[14][6];  extern int kRGBVals[];  extern int screenheight;
extern int gFlip;  extern int Draw_gPlayer1View;
void *Draw_GetDRAWENV(int,int);
/* FEMenuExtended-specific helpers */
void  DrawShape_SubtractNFS4RectEdges(...);  void DrawShape_NFS4RoundRectangle(...); /* W56-A1: ref-decl DrawShape_SubtractNFS4RectEdges(RECT&) needs caller femenuextended.cpp:40 rect->*rect; reported */
void  FETextRender_SetFont(int);  int textpixels(char*);  void s_upper(char*);
/* TRUE prototypes (2026-08-02, user-approved): the old variadic `(...)` decls mangled as
 * phantom symbols at the Font_SetBlitter(FontUpsideDownBlit) address-take sites -- byte-
 * neutral fix, reloc symbols now match font.cpp/psxfront.cpp definitions. */
void  Font_SetBlitter(void (*)(int,int,void *,int,int,charactertbl *,int));
void  Font_ReSetBlitter();
void  FontUpsideDownBlit(int,int,void *,int,int,charactertbl *,int);
void  MenuNFS4_SetHelpPos(...);  int CalcOnOffFade(...);  extern int screenwidth;
void  FETextRender_MenuTextPositionedJustify(short,short,short,short,tMenuTextState,tMenuTextType);
#endif
