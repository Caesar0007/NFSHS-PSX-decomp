/* frontend/screens/screentrackrec_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENTRACKREC_EXTERNS_H_
#define _FE_SCREENS_SCREENTRACKREC_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern tfrontEnd   frontEnd;
extern int  ticks[];
extern int  kRGBVals[28];
extern char textDefinitions[14][6];
extern tTexture_ShapeInfo *gCurrentShapes[];
/* W62-A17 decl-divergence receipt -- `bool` HERE IS CORRECT, do not "fix" it to int.
   LAW (measured this wave): on the cc1plus C++ lane sizeof(bool) == 4, so bool and
   int are the same STORAGE; the oracle confirms 4-byte objects (front_data.data.s
   dlabels NewRecords = 8 .words @0x80052978, StatChk_ClearNewRecords walks them with
   `addiu $v0,-0x4`, DrawRecords indexes with `sll $s1,2`).  The types differ only at
   implicit-conversion sites, and there the oracle proves BOOL: DrawRecords passes
   `lw $a2,0($s0)` straight into DrawOneRecord__19tScreenTrackRecords*i*b*i with NO
   sltu normalization, which an `int` source type would have forced (measured:
   int -> +1 `sltu a2,zero,a2`, 7/7 -> 6/7).  statchk.h's `int NewRecords[8]` /
   `int NewBestLap` are the divergent (but size-compatible) spelling. */
extern bool NewRecords[8];
extern bool NewBestLap;
void trap(int code);
extern "C" int textpixels(char *str);
int  CalcFadeVal(int col1, int amount);   /* 2-arg overload */

/* called game/FE/audio/PsyQ functions (Ghidra-dumped signatures) */
char * TextSys_Word(int wordnum);
int TextSys_WordY(int wordnum);
void DrawShapeExtended(int index, int flags, int x, int y, int fade, int abr, tDrawShapeExtended * extra);
void FETextRender_FullText(char * sMenuText, short x, short y, tMenuTextType textType, tMenuTextState textState, short justify);
void Flare_2DHalo(int x, int y, int scalex, int scaley, int type);
void DrawBackgroundImage(tScreen * thisobj, int startShape, int numShapes, tTexture_ShapeInfo * shapes, int flip_axis);
void StatChk_ClearNewRecords(void);
void Stattool_GetRecords(short nShowTrack, tRecordBuffer * TrackRecords);
short Front_GetTrackRaced(void);
void PSXDrawSquare(int col, int x, int y, int w, int h);
void Stattool_ParseTime(int nTime, char * sLapTime);
int TextSys_WordX(int wordnum);
int CalcFadeVal(int col1, int col2, int amount);
void PSXDrawBrightEndLine(int col, int x, int y, int w, int h, int side, int fade, int darksides);
void FETextRender_FullTextRGB(char * sMenuText, short x, short y, int col, char size, short justify);
int Front_GetLapsForType(void);

#endif
