/* frontend/screens/screentrophyroom_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENTROPHYROOM_EXTERNS_H_
#define _FE_SCREENS_SCREENTROPHYROOM_EXTERNS_H_
#include "screentrophyroom_types.h"

/* --- globals --- */
extern tfrontEnd          frontEnd;
extern tTournamentManager tournamentManager;
extern tGlobalMenuDefs   *menuDefs;
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/systask.h"
#include "eaclib/psx/eacpsxz/vars.h"
}
extern tTexture_ShapeInfo *gCurrentShapes;
#include "shared/pad_module_globals.h"

/* --- data owned by ScreenTrophyRoom.obj (EXT linkage) --- */
tScreenTrophyRoom *screenTrophyRoom;                 /* EXT @0x80052060 (runtime-set) */
char gSwapFileName[16];                              /* EXT @0x80052064 */

/* --- base tScreen ctor/dtor (name==class -> rendered as free helpers) --- */
void tScreen_ctor(tScreen *s);
void tScreen_dtor(tScreen *s);

/* --- tScreen helpers (base passed explicitly) --- */










/* --- FE / game / PsyQ helpers (de-namespaced) --- */
void  GetTrophyName(tTournamentManager *tm, tTourneyInfo *ti, tTrophySize sz, char *buf, int n) asm("GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci");
void  AudioCmn_PlayFESFX(int sfx);
void  FETexture_LoadPmxAtOffset(char *file, int off, tTexture_ShapeInfo *shapes, int a, int b);
void  DrawShapeExtended(int a, int b, int c, int d, int e, int f, tDrawShapeExtended *ext);
void  ScaleShapeExtended(int a, int b, int c, int d, int e, int f, tDrawShapeExtended *ext);
void  PSXDrawBrightEndLine(int a, int b, int c, int d, int e, int f, int g, int h);
void  FETextRender_MenuTextPositionedJustifyFade(int fade, short index, short x, short y, short j, tMenuTextState st, tMenuTextType tt)
    asm("FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType");
char *TextSys_Word(int id);
int   CalcFadeVal(int rgb, int amount);
void  FETextRender_FullTextRGB(char *s, short x, short y, int rgb, char a, short b);

extern "C" {
}

#endif
