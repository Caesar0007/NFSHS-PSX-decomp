/* frontend/screens/screentournselect_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENTOURNSELECT_EXTERNS_H_
#define _FE_SCREENS_SCREENTOURNSELECT_EXTERNS_H_
#include "screentournselect_types.h"

/* --- globals --- */
extern tfrontEnd          frontEnd;
extern tTournamentManager tournamentManager;
extern tGlobalMenuDefs   *menuDefs;
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/vars.h"
}
extern char              *Paths_Paths[];

/* --- data owned by ScreenTournSelect.obj --- */
tScreenTournSelect *screenTournSelect;               /* EXT @0x8005205c (runtime-set) */
static char trophyTVOrder[4] = {1,2,0,3};            /* STAT @0x80052058 real bytes=01 02 00 03 */
static char gSwapFileName[16];                       /* STAT @0x80052c90 */

/* --- base tScreen ctor/dtor + helpers --- */
void tScreen_ctor(tScreen *s);
void tScreen_dtor(tScreen *s);





/* --- PSX video player --- */
int  VIDEO_create(int w, int h, int a, int b, int c);
int  VIDEO_state(int h);
int  VIDEO_updateframexy(int h, int x, int y);
void VIDEO_spoolfile(int h, char *name);
void VIDEO_startplayback(int h);
void VIDEO_destroy(int h);

/* --- FETv video-wall tiles --- */
void InitTV(tTVConfig &cfg, tTexture_ShapeInfo *shapes, short n);
void TurnOnTV(tTVConfig &cfg);
void TurnOffTV(tTVConfig &cfg);
void DrawTV(tTVConfig &cfg);
void DrawTVLines(tTVConfig &cfg);

/* --- FE / game / PsyQ helpers --- */
/* GetTrophyName: tTournamentManager member (fetourn_manager_class.h) */
void  PSXDrawTransSquare(int col, int x, int y, int w, int h, short op);
void  ScaleShapeExtended(int a, int b, int c, int d, int e, int f, tDrawShapeExtended *ext);
void  FeDraw_SetABRMode(int abr);
void  PSXDrawBrightEndLine(int a, int b, int c, int d, int e, int f, int g, int h);
int   CalcFadeVal(int rgb, int amount);
char *TextSys_Word(int id);
int   TextSys_WordX(int id);
int   TextSys_WordY(int id);
void  DrawMoney(int x, int y, int digits, long amount, int rgb1, int rgb2);
void  FETextRender_MenuTextFade(int fade, short index, tMenuTextState st, tMenuTextType tt)
    asm("FETextRender_MenuTextFade__Fis14tMenuTextState13tMenuTextType");
void  FETextRender_FullTextRGB(char *s, short x, short y, int rgb, char a, short b);
void  FETextRender_WordWrapFade(int fade, short index, RECT &r, tMenuTextState st, tMenuTextType tt);
void  FETextRender_WordWrapTextRGB(char *s, RECT &r, int rgb);
int FETextRender_WordWrapHeight(short w, char *s);
void  FETextRender_MenuTextPositionedJustifyFade(int fade, short index, short x, short y, short j, tMenuTextState st, tMenuTextType tt)
    asm("FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType");


extern "C" {
int ClearImage(RECT *rect, unsigned char r, unsigned char g, unsigned char b);
int DrawSync(int mode);
unsigned short GetTPage(int tp, int abr, int x, int y);
int sprintf(char *buffer, char *fmt, ...);
}

/* Explicit frontend selection (see screentournselect.cpp); a header inline, so SLD records its blocks at the caller's line. */
/* (TourneyInTier removed: tTournamentManager::CurrentTourney(tier, tournament) in-class body, INV-B I4) */





#endif
