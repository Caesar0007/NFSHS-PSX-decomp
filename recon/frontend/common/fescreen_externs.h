/* frontend/common/fescreen_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FESCREEN_EXTERNS_H_
#define _FE_SCREENS_FESCREEN_EXTERNS_H_
#include "fescreen_types.h"

/* FEScreen.obj does not retain the owning dflip/Draw_tView tags, but retail
 * instructions require their exact member shapes.  These private foreign-
 * symbol views are accepted by the canonical audit only at this owner and
 * only with their complete measured layouts. */
#include "shared/dflip.h"   /* the real dflip / Draw_tView (no codegen views; header-truth 4-B.4) */
#include "shared/Draw_tView.h"












/* The retail owner retains neither menu-text enum tag.  Preserve the proven
 * call target through its linkage name while keeping those foreign tags out
 * of this TU's source graph. */
#include "shared/tMenuTextType.h"   /* the real enum (was constant macros; header-truth 4-C.2) */
#include "shared/tMenuTextState.h"   /* the real enum (was constant macros; header-truth 4-C.2) */

/* ===== globals ===== */
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/nasync.h"
#include "eaclib/psx/eacpsxz/vars.h"
}
extern char          *Paths_Paths[];
extern int            Draw_gPlayer1View;             /* @0x8013d3cc */
extern Draw_tView     Draw_gView[];                  /* @0x8011ec54 */
extern dflip          gEnviro[2];                    /* @0x8011f424 */
extern tTexture_ShapeInfo *gCurrentShapes;           /* @0x800517cc */

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
int sprintf(char *buffer, const char *format, ...);
int DrawSync(int mode);
int VSync(int mode);
}

/* FRONT5: retail TransitionOn/Off read the tick counter through a zero-parameter inline (SLD 2-level block at line 2,
   the load tagged with the preceding statement line). */
static inline int FE_Ticks(void) { return ticks; }

#endif
