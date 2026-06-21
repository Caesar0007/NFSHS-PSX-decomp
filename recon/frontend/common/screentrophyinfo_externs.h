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

/* --- data owned by ScreenTrophyInfo.obj (EXT linkage) --- */
int  kBannerColors[4] = { 0x003c410a, 0x00003e44, 0x00212121, 0x00003044 };  /* EXT @0x80052078 */
char gSwapFileNameTI[16];                                                     /* EXT @0x8005208c */
tScreenTrophyInfo *screenTrophyInfo;                                          /* EXT @0x80052088 (runtime-set) */

/* --- FE text / fade / shape (de-namespaced) --- */
int   CalcFadeVal(int rgb, int idx);
char *TextSys_Word(int id);
void  FETextRender_FullTextRGB(char *s, short x, short y, int rgb, char a, short b);
void  FETextRender_MenuTextPositionedJustifyFade(int idx, short x, short y, short j, short state, tMenuTextState st, tMenuTextType tt);
void  FETextRender_WordWrapTextRGB(char *s, RECT *r, int rgb);
short FETextRender_WordWrapHeight(short w, char *s);
void  FETextRender_WordWrapTextRGBJustify(char *s, RECT *r, int rgb, int j, int a, bool b);
void  ScaleShapeExtended(int a, int b, int c, int d, int e, int f, tDrawShapeExtended *ext);
void  DrawShapeExtended(int a, int b, int c, int d, int e, int f, tDrawShapeExtended *ext);
void  GetTrophyName(tTournamentManager *tm, tTourneyInfo *ti, tTrophySize sz, char *buf, int n);

/* --- tScreen helpers (base passed explicitly) --- */
BOOL IsShapeFileLoaded(tScreen *s, tShapeInformation *shp);
void UploadSwapShapes(tScreen *s, int n);

#endif
