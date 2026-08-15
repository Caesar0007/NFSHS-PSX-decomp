/* frontend/screens/screentrackinfo_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENTRACKINFO_EXTERNS_H_
#define _FE_SCREENS_SCREENTRACKINFO_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern tfrontEnd   frontEnd;
extern int  ticks;
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
void Draw(tVideoWall *thisobj);                                 /* Draw__10tVideoWall            */
void UpdateTransition(tVideoWall *thisobj);                     /* UpdateTransition__10tVideoWall */
void TurnOn(tVideoWall *thisobj);                               /* TurnOn__10tVideoWall          */
void TurnOffInstant(tVideoWall *thisobj);                       /* TurnOffInstant__10tVideoWall  */
void UpdateImages(tVideoWall *thisobj);                         /* UpdateImages__10tVideoWall    */
void Initialize(tVideoWall *thisobj, tTVConfig *cfgs, tTexture_ShapeInfo *shapes,
                short a, short b, short *order, short c);

/* called game/FE/audio/PsyQ functions (Ghidra-dumped signatures) */
void FETextRender_MenuTextPositionedJustify(short index, short x, short y, short justify, tMenuTextState state, tMenuTextType type);
void FETextRender_MenuTextPositioned(short index, short x, short y, tMenuTextState textState, tMenuTextType textType);
short * GetTrackList(tTournamentManager * thisobj, short tier, short tournament);
void GetTrackToRace(tTournamentManager * thisobj, tTrackInfo * track);
void DrawBackgroundImage(tScreen * thisobj, int startShape, int numShapes, tTexture_ShapeInfo * shapes, int flip_axis);
void PSXDrawTransSquare(int col, int x, int y, int w, int h, short opacity);
tTrackInformation * GetTrackByID(tTrackManager * thisobj, short track);
void FeDraw_SetABRMode(int abr);                                /* FeDraw_SetABRMode__Fi */

#endif
