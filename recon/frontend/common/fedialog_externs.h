/* frontend/common/femenuextended_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FEDIALOG_EXTERNS_H_
#define _FE_SCREENS_FEDIALOG_EXTERNS_H_
#include "fedialog_types.h"
extern tFEApplication *FEApp;
extern tfrontEnd frontEnd;
#include "shared/pad_module_globals.h"
/* Address-visible view: several retail routines schedule %hi(ticks)
   independently of the load; a scalar extern collapses it into a macro. */
extern int ticks[];
static inline int FE_Ticks(void) { return ticks[0]; }
extern tGlobalMenuDefs *menuDefs;
/* class vtables (FEDialog.obj-defined subclasses) */
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
int   FETextRender_WordWrapTextRGBJustify(char*,RECT&,int,int,int,bool); /* retail INT */
int   CalcTextFadeSelToHi(int, short, short);  int CalcTextFadeUnselToSel(int, short, short);
extern char textDefinitions[14][6];  extern int kRGBVals[];  extern int screenheight;
extern int gFlip;  extern int Draw_gPlayer1View;
DRAWENV *Draw_GetDRAWENV(int,int); /* retail FCN PTR STRUCT DRAWENV */
/* FEDialog-specific helpers */
void  DrawShape_SubtractNFS4RectEdges(RECT &);  void DrawShape_NFS4RoundRectangle(...);
void  FETextRender_SetFont(int);  extern "C" int textpixels(char*);  void s_upper(char*);
/* TRUE prototypes (2026-08-02, user-approved): the old variadic `(...)` decls mangled as
 * phantom symbols wherever FontUpsideDownBlit's address is taken -- byte-neutral fix,
 * reloc symbols now match font.cpp/psxfront.cpp definitions. */
void  Font_SetBlitter(void (*)(int,int,void *,int,int,struct charactertbl *,int));
void  Font_ReSetBlitter();
void  FontUpsideDownBlit(int,int,void *,int,int,struct charactertbl *,int);
/* No CalcOnOffFade reference in FEDialog: removed its incorrect variadic
 * declaration rather than introduce an unsupported text-enum body here. */
extern int screenwidth;
void  FETextRender_MenuTextPositionedJustify(short,short,short,short,int,int);
void FeTools_DrawPSXButton(u_char,u_short,int,int);
void FETextRender_SetABR(int,bool);
/* FEDialog.obj filters the completed text-enum records, but the callee keeps
 * those enum names in its GCC-v2 linkage spelling. */
void FETextRender_FullText(char*,short,short,int,int,short)
    __asm__("FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates");
int  FETextRender_WordWrapHeight(short, char *);
void FETextRender_WordWrapTextRGB(char*, RECT&, int);
int  FEInput_GetKeyFromPlayer(tPlayer, long);
extern int CURRENTPLAYER;
extern "C" int MCRD_handlecardevents(int);  extern "C" CARDINFO_def *MCRD_getcard(int);
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/blkmov.h"
}
extern "C" void PAD_update(void);
/* Draw's 8c record has no `buttonY` local.  Retail nevertheless shares this
   expression across the two controller-button calls; this inline boundary
   preserves that CSE without inventing a caller local.  The body is proven,
   while the original helper/macro spelling is not recoverable. */
static inline int DialogHelpButtonY(short item)
{
  return (item - 1) * 0xf + 0xf;
}

static inline int DialogMessageHalfWidth(tDialogMessageString *dialog)
{
  /* Draw's 8c record names only `col` and `r`.  This zero-local boundary
     preserves retail's width-before-left load order without a halfw carrier. */
  return (int)((u_int)(u_short)dialog->width << 0x10) >> 0x11;
}

/* Run's 8c record has no boolean local for this predicate, while SLD opens
   nested inline scopes at retail lines 31/32.  The private helper spelling is
   unavailable; this boundary preserves the proven materialized-bool shape. */
static inline bool DialogCanProcessCircle(tFEApplication *app, tPlayer player)
{
  return app->helpPopup.currentlyOn == 0 &&
         app->CurrentMenu(player) != (tMenu *)0x0;
}

/* Draw's retail load selects state 1/2 and then addresses the row-8 palette
   state subarray.  SLD retains no caller temporary for that selection; the
   exact private helper spelling is not recoverable. */
static inline int DialogYesNoTextState(tDialogYesNo *dialog, int item)
{
  if (item == dialog->ReturnValue) {
    return 1;
  }
  return 2;
}

static inline char *DialogTextDefinitionsBase()
{
  /* Keeping the array's unoffset base in its own zero-local inline boundary
     reproduces retail's indexed `lbu +51`; folding the row offset into the
     returned address is byte-different. */
  return (char *)textDefinitions;
}

static inline int DialogYesNoOpenElapsed(tDialogYesNo *dialog)
{
  /* CalculateDimensions' 8c record has no elapsed local.  Repeating this
     zero-local accessor lets GCC share the quantity exactly as retail does. */
  return ticks[0] - dialog->startTicks;
}

#endif
