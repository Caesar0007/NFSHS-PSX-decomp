/* frontend/psx/psxfront.h - reconstructed declarations for PSXFRONT.CPP (C++ TU) */
#ifndef _FRONTEND_PSX_PSXFRONT_H_
#define _FRONTEND_PSX_PSXFRONT_H_
#include "../../nfs4_types.h"

/* PSXFRONT.CPP is C++ (cfront-mangled in SYM) -> normal C++ linkage. */
void Quick_DD(int a,int b,int c);
void PSXFront_AllocateDrawMemory(void);
void PSXFront_FreeDrawMemory(void);
void InitializeSpinningCars(void);
void CleanupSpinningCars(void);
void CleanupSpinningCarsMenu(void);
void DoTitleScreen(void);
void DoLanguageScreen(void);
void PSXExitFrontend(void);
void PSX_AllocShapes(void);
void Init_RenderingEnvironment(void);
void Init_PSX_FrontEnd(void);
void DrawShapeExtended(int index,int flags,int x,int y,int fade,int abr,tDrawShapeExtended *extra);
void ScaleShapeExtended(int index,int flags,int x,int y,int fade,int abr,tDrawShapeExtended *extra);
void LoadAllHelpShapes(void);
void PSXDrawSquare(int col,int x,int y,int w,int h);
void PSXDrawGouraudSquare(int x,int y,int w,int h,int c1,int c2,int c3,int c4);
void PSXDrawTransGouraudSquare(int x,int y,int w,int h,int opacity,int c1,int c2,int c3,int c4);
void PSXDrawTransSquare(int col,int x,int y,int w,int h,short opacity);
void FontUpsideDownBlit(int x,int y,void *src,int u,int v,charactertbl *ch,int);

/* ---- PSXFront.obj EXT data globals ---- */
extern tTexture_ShapeInfo *gHelpShapes[]; /* 0x80052a64 (unsized array: base-reg materialization for delay-slot store, not $at macro) */
extern Car_tObj           *gCarObj[2];      /* 0x80052a68 */
extern char                titleScreenDisplayed[];  /* 0x80052a70 */
extern short               gFadeBrightness;       /* 0x80052a50 */
extern char               *creditShapeFile[];       /* 0x80052a58 */

#endif
