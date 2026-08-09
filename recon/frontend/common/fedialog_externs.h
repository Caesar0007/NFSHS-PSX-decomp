/* frontend/common/femenuextended_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FEDIALOG_EXTERNS_H_
#define _FE_SCREENS_FEDIALOG_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"
extern tFEApplication *FEApp;
extern tfrontEnd frontEnd;
extern tPadModuleState gPadinfo;
/* Address-visible view: several retail routines schedule %hi(ticks)
   independently of the load; a scalar extern collapses it into a macro. */
extern int ticks[];
extern tGlobalMenuDefs *menuDefs;
/* class vtables (FEDialog.obj-defined subclasses) */
extern __vtbl_ptr_type tDialogBase_vtable[], tDialogHelp_vtable[], tDialogMessageString_vtable[], tDialogBackUpOnly_vtable[],
  tDialogInteractive_vtable[], tDialogYesNo_vtable[], tDialogYesNoMem_vtable[],
  tDialogYesNoTri_vtable[], tDialogNoInputMessage_vtable[];//X
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
/* FEDialog-specific helpers */
void  DrawShape_SubtractNFS4RectEdges(RECT &);  void DrawShape_NFS4RoundRectangle(...);
void  FETextRender_SetFont(int);  extern "C" int textpixels(char*);  void s_upper(char*);
/* TRUE prototypes (2026-08-02, user-approved): the old variadic `(...)` decls mangled as
 * phantom symbols wherever FontUpsideDownBlit's address is taken -- byte-neutral fix,
 * reloc symbols now match font.cpp/psxfront.cpp definitions. */
void  Font_SetBlitter(void (*)(int,int,void *,int,int,charactertbl *,int));
void  Font_ReSetBlitter();
void  FontUpsideDownBlit(int,int,void *,int,int,charactertbl *,int);
void  MenuNFS4_SetHelpPos(...);  int CalcOnOffFade(...);  extern int screenwidth;
void  FETextRender_MenuTextPositionedJustify(short,short,short,short,tMenuTextState,tMenuTextType);
extern tDialogBase *DialogVisibilityList[8];
void FeTools_DrawPSXButton(u_char,u_short,int,int);
void FETextRender_SetABR(int,bool);
void FETextRender_FullText(char*,short,short,tMenuTextType,tMenuTextState,short);
int  FETextRender_WordWrapHeight(short, char *);
void FETextRender_WordWrapTextRGB(char*, RECT&, int);
int  FEInput_GetKeyFromPlayer(tPlayer, long);
extern int CURRENTPLAYER;
extern "C" int MCRD_handlecardevents(int);  extern "C" CARDINFO_def *MCRD_getcard(int);
#endif
