/* frontend/psx/psxfront_externs.h - reconstructed extern decls (from Ghidra signatures).
 * NOT an original header; added for standalone C++ compile. */
#ifndef _FRONTEND_PSX_PSXFRONT_EXTERNS_H_
#define _FRONTEND_PSX_PSXFRONT_EXTERNS_H_
#include "psxfront_types.h"

/* W62-A17 LINKAGE FIX.  This whole block used to sit inside `extern "C" { }`, which made
   psxfront.cpp emit 33 UNMANGLED references to functions that are defined in C++ TUs --
   AudioCmn_LoadFESamples vs AudioCmn_LoadFESamples__Fv, Draw_SetView vs
   Draw_SetView__Fiiiiiiiii, R3DCar_Instantiate3DCar vs R3DCar_Instantiate3DCar__FP8Car_tObji,
   ... 33 symbols that exist NOWHERE (nm ALIAS class, the single largest concentration of
   link debt in the tree).  verify_asm's reloc-name leniency hides all of it.
   Only `elapsedticks` in this block is genuinely C-lane (eaclib), so it keeps C linkage. */
extern "C" int elapsedticks(void);

/* Exact pruned runtime boundary used by PSXFront.obj.  Keep the original
 * return types and old-style varargs forms: they are part of GCC 2.8's call
 * expression and allocation behavior even though C linkage fixes the label. */
extern "C" {
long DrawSync(...);
unsigned short GetClut(...);
DISPENV *SetDefDispEnv(...);
void SetPolyG4(...);
void SetPolyGT4(...);
void SetSemiTrans(...);
void InitGeom(...);
void PAD_update(void);
int addtimer(...);
unsigned int asyncloadfileat(...);
void blockclear(...);
int deltimer(...);
int fixedmult(...);
int getasyncreadstatus(...);
void initlinkmode(...);
int loadshapeadr(...);
void *locateshapez(...);
void movfxya(...);
int purgememadr(...);
void *reservememadr(...);
void settrans(...);
int sprintf(...);
char *strcpy(...);
int systemtask(...);
}

void AudioCmn_LoadFESamples(void);
void Audio_DeInitDriver(void);
void Audio_InitDriver(int buffersize, int spusize);
void CarIO_CleanUp(void);
void CarIO_ReStart(void);
void CarIO_StartUp(void);
void ClearPrimitivesBuffer(void);
void DrawC_ReadeMapData(void);
void Draw_DirectSetEnvironment(int x, int y, int w, int h, int edraw, int edisplay, int erase, int r, int g, int b);
void Draw_InitViewOT(void);
void Draw_InitViews(void);
int Draw_SetView(int x0, int y0, int x1, int y1, int w, int h, int dtd, int isbg, int otsize);
void Draw_SetViewMemBudget(int viewid, int totalmem);
void FETextRender_SetABR(int abr, bool trans);
void FETexture_LoadPmx(char * f, int index, tTexture_ShapeInfo * dest);
void Fe3D_InitShowroom(void);
void FeTools_init(void);
void Front_InitialMemCardCheck(void);
void Front_SecondaryMemCardCheck(void);
void Platform_ResetDCTBuffer(void);
void R3DCar_CleanUp(void);
void R3DCar_DeInstantiate3DCar(Car_tObj * carObj);
void R3DCar_DeInstantiate3DCarMenu(Car_tObj * carObj);
void R3DCar_Instantiate3DCar(Car_tObj * carObj, int index);
void R3DCar_PostStartUp(void);
void R3DCar_StartUp(void);
void SetPlayList(int ivealreadygotone);
void TextSys_LoadWords(int language);
void Texture_CleanupMenuTexture(void);
void Texture_InitMenuClut(void);
void Texture_InitMenuTexture(void);
void Texture_KillMenuTexture(void);
int play_movie(char movie);
void trap(int code);
   /* eaclib timer proc (from pad.c) */

/* --- external game globals (Ghidra-typed) --- */
extern u_char CF_DVLC[49096];
extern int ComingIntoTheFrontEndTheVeryFirstTime[]; /* unsized array: base-reg materialization (not $at macro store) */
extern int DrawC_gMenuColor[2];
extern int DrawC_gMenuLights[];
extern int DrawC_gMenuLightsDirection[];
extern int Draw_gDoVSync[];
extern int Draw_gPlayer1View[];  /* unsized array shape: forces the separate-%hi-scratch arg load (methodology 3.12 #5) */
extern int Draw_gRearView[];
extern char GameSetup_gCarNames[51][5];
extern PSXFront_GameSetupCodegenView GameSetup_gData asm("GameSetup_gData");
extern char *Paths_Paths[50];
extern int R3DCar_InMenu[];
extern u_long font_tint;
extern tfrontEnd frontEnd;
extern PSXFront_DRenderCodegenView gCView asm("gCView");
/* UNSIZED array (methodology 3.12 #5 / 3.15-CORRECTION): the oracle loads this global's VALUE
 * through a SEPARATE %hi scratch (`lui $v0,%hi; lw $v1,%lo($v0)`).  A scalar decl folds the
 * address into the dest (self-temp `lui $v1; lw $v1,0($v1)`).  fescreen_externs.h already
 * declares it this way (`gCurrentShapes[0] = ...`), so this is the true EA shape, not a hack.
 * -- w43-a3 (DrawShapeExtended/ScaleShapeExtended twins, 4->0 each) */
extern tTexture_ShapeInfo *gCurrentShapes[];
extern PSXFront_DFlipCodegenView gEnviro[2] asm("gEnviro");
extern int gFlip[];
extern u_short gFontClut;
extern int gMenuRotate[2];
extern int inFrontEnd[];
extern int screenbpp[];
extern int screenwidth[];
#endif
