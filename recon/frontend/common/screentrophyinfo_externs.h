/* frontend/screens/screentrophyinfo_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENTROPHYINFO_EXTERNS_H_
#define _FE_SCREENS_SCREENTROPHYINFO_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* --- globals --- */
extern tfrontEnd          frontEnd;
extern tTournamentManager tournamentManager;
extern tScreenTrophyRoom *screenTrophyRoom;
extern int                kRGBVals[28];
extern char               textDefinitions[14][6];
extern int                ticks;

/* --- data owned by ScreenTrophyInfo.obj (EXT linkage) --- */
/* 🔴 DO NOT RE-SORT (17B EXTERN-ORDER LAW).  A TU-owned TENTATIVE definition is
   emitted in the order its identifier is FIRST DECLARED; an INITIALISED object is
   emitted at its definition.  These three lines therefore encode retail's run
   0x80052078 kBannerColors[16] -> 0x80052088 screenTrophyInfo -> 0x8005208c
   gSwapFileNameTI[16] (SYM: ARY CHAR size 16; the 4 B to 0x800520a0 are the
   next input section's alignment pad and stay in the blob). */
int  kBannerColors[4] = { 0x003c410a, 0x00003e44, 0x00212121, 0x00003044 };  /* EXT @0x80052078 */
tScreenTrophyInfo *screenTrophyInfo;                                          /* EXT @0x80052088 (runtime-set) */
char gSwapFileNameTI[16];                                                     /* EXT @0x8005208c */

/* --- FE text / fade / shape (de-namespaced) --- */
int   CalcFadeVal(int rgb, int idx);
char *TextSys_Word(int id);
void  FETextRender_FullTextRGB(char *s, short x, short y, int rgb, char a, short b);
void  FETextRender_MenuTextPositionedJustifyFade(int idx, short x, short y, short j, short state, tMenuTextState st, tMenuTextType tt);
void  FETextRender_WordWrapTextRGB(char *s, RECT &r, int rgb);
int FETextRender_WordWrapHeight(short w, char *s);
void  FETextRender_WordWrapTextRGBJustify(char *s, RECT &r, int rgb, int j, int a, bool b);
void  ScaleShapeExtended(int a, int b, int c, int d, int e, int f, tDrawShapeExtended *ext);
void  DrawShapeExtended(int a, int b, int c, int d, int e, int f, tDrawShapeExtended *ext);
void  GetTrophyName(tTournamentManager *tm, tTourneyInfo *ti, tTrophySize sz, char *buf, int n) asm("GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci");

/* --- tScreen helpers (base passed explicitly) --- */
bool IsShapeFileLoaded(tScreen *s, tShapeInformation *shp) asm("IsShapeFileLoaded__7tScreenR17tShapeInformation");
void UploadSwapShapes(tScreen *s, int n) asm("UploadSwapShapes__7tScreeni");

#endif
