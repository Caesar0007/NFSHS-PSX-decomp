/* frontend/common/fescreen_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FESCREEN_EXTERNS_H_
#define _FE_SCREENS_FESCREEN_EXTERNS_H_
#include "fescreen_types.h"

/* FEScreen.obj does not retain the owning dflip/Draw_tView tags, but retail
 * instructions require their exact member shapes.  These private foreign-
 * symbol views are accepted by the canonical audit only at this owner and
 * only with their complete measured layouts. */
struct FEScreen_DFlipCodegenView {
    DISPENV disp;
    char *server;
};

struct FEScreen_DrawViewCodegenView {
    int otsize, membudget;
    DRAWENV drawenv[2];
    u_long *ot[2];
};

#define dflip FEScreen_DFlipCodegenView
#define Draw_tView FEScreen_DrawViewCodegenView

/* The retail owner retains neither menu-text enum tag.  Preserve the proven
 * call target through its linkage name while keeping those foreign tags out
 * of this TU's source graph. */
#define textState_Selected 1
#define textType_ScreenInfo 4

/* ===== globals ===== */
extern int            ticks[];
extern char          *Paths_Paths[];
extern int            Draw_gPlayer1View;             /* @0x8013d3cc */
extern Draw_tView     Draw_gView[];                  /* @0x8011ec54 */
extern dflip          gEnviro[2];                    /* @0x8011f424 */
extern int            screenheight;
extern tTexture_ShapeInfo *gCurrentShapes;           /* @0x800517cc */
extern __vtbl_ptr_type tScreen_vtable[];             /* _vt.7tScreen */

/* ===== statics owned by FEScreen.obj ===== */
extern int            _7tScreen_fSuppressLoadingText;  /* def in link_runtime.cpp */   /* @0x800517C8 */

/* ===== rendering / view ===== */
void  Draw_StartFrameRender();
void  Draw_StartRenderingView(int view);
void  Draw_StopRenderingView(int view);
void  Draw_StopFrameRender();
void  GoNonInterlaced();
void  DrawShapeExtended(int, int, int, int, int, int, tDrawShapeExtended*);
void  PSXDrawSquare(int, int, int, int, int);

/* ===== text ===== */
void  FETextRender_MenuTextPositionedJustify(short, short, short, short, int, int)
      __asm__("FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType");
char *TextSys_Word(int);
extern "C" int textpixels(char*);

/* ===== async shape I/O (eaclib) ===== */

/* ===== texture / draw helpers ===== */
void  Texture_MenuReleaseClutId(short);
void  FETexture_LoadPmxAtOffset(char*, int, tTexture_ShapeInfo*, int, int);
void  FeAudio_systemtask(int);

/* ===== libc / libgpu / libetc ===== */
extern "C" {
unsigned int asyncloadfile(char *name, void *memclass);
unsigned int asyncloadfileat(char *name, char *destination);
void cancelasyncload(unsigned int handle);
char *getasyncreadadr(unsigned int handle);
int getasyncreadstatus(unsigned int handle);
int purgememadr(void *address);
void *reservememadr(char *name, int size, int memclass);
int sprintf(char *buffer, const char *format, ...);
int DrawSync(int mode);
int VSync(int mode);
}

#endif
