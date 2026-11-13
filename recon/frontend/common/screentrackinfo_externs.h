/* frontend/screens/screentrackinfo_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENTRACKINFO_EXTERNS_H_
#define _FE_SCREENS_SCREENTRACKINFO_EXTERNS_H_
#include "screentrackinfo_types.h"

extern "C" int sprintf(char *buffer, char *fmt, ...);

extern tfrontEnd   frontEnd;
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/vars.h"
}
extern tTournamentManager tournamentManager;
extern tTrackManager      trackManager;
extern short SelectListTrackDirection[], SelectListOffOn[];
extern int  kRGBVals[28];
extern char textDefinitions[14][6];

/* --- storage owned by ScreenTrackInfo.obj (SYM STAT/EXT in this obj's block) --- */
/* SYM STAT ARY SHORT[10] @0x800520b8 - videowall tile display order */
static short tvOrder[10] = { 2, 7, 4, 8, 1, 6, 0, 9, 3, 5 };
/* SYM STAT ARY CHAR[64] @0x80052cb8 - scratch buffer for swap-shape filename */
static char gSwapFileName[64];
/* SYM EXT PTR @0x800520cc - singleton instance pointer (runtime-set, 0 in image) */
tScreenTrackInfo *screenTrackInfo;

/* tVideoWall methods (SYM mangled forms confirmed; called on this->fVideoWall).
 * Initialize sig per Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss */
                                 /* Draw__10tVideoWall            */
                     /* UpdateTransition__10tVideoWall */
                               /* TurnOn__10tVideoWall          */
                       /* TurnOffInstant__10tVideoWall  */
                         /* UpdateImages__10tVideoWall    */



/* called game/FE/audio/PsyQ functions (Ghidra-dumped signatures) */
void FETextRender_MenuTextPositionedJustify(short, short, short, short, int, int)
    asm("FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType");
void FETextRender_MenuTextPositioned(short, short, short, int, int)
    asm("FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType");

void PSXDrawTransSquare(int col, int x, int y, int w, int h, short opacity);
void FeDraw_SetABRMode(int abr);                                /* FeDraw_SetABRMode__Fi */

#endif
