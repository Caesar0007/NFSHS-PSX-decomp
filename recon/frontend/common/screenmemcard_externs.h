/* frontend/common/screenmemcard_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENMEMCARD_EXTERNS_H_
#define _FE_SCREENS_SCREENMEMCARD_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

typedef long long longlong; typedef unsigned long long ulonglong;

extern tfrontEnd   frontEnd;
extern int  ticks;
extern bool CURRENTLYUSINGMEMCARD;
int CalcFadeVal(int col1, int col2, int amount);
int CalcFadeVal(int col1, int amount);   /* 2-arg overload */
/* SCREENMEMCARD.CPP layout int globals (@0x800528xx) are DEFINED in the .cpp (this TU owns them;
   SYM EXT @ data addrs, Initialize() sets them). extern-declared here for completeness. */
extern tScreenMemcard *screenMemcard;
extern int GRIDMEMCARD_STARTX, GRIDMEMCARD_STARTY, MEMCARD_DELTAX, MEMCARD_DELTAY;
extern int kMemCardMessageH, kMemCardMessageH1;
extern int EXTRAYATTOP;
extern int GRIDMEMCARD_WIDTH, GRIDMEMCARD_HEIGHT;
extern int GRIDMEMCARDGOURAUDBIT_X, GRIDMEMCARDGOURAUDBIT_Y;
extern int MEMCARDICONOFFX, MEMCARDICONOFFY;
extern int kMemCardMessage1X, kMemCardMessage1Y;
extern int kMemCardMessageX, kMemCardMessageY;
extern char (*fMemIcon)[15][3][192];
extern int  kRGBVals[28];
extern char textDefinitions[14][6];
extern tFEApplication *FEApp;
extern tGlobalMenuDefs *menuDefs[];   /* unsized-array shape -> separate-temp arg-load (3.12#5) */
extern __vtbl_ptr_type tScreenMemcard_vtable[];   /* @0x80012228 manual vtable */

/* called game/FE/MCRD/PsyQ functions (Ghidra-dumped signatures) */
void trap(int code);
int garyMemCardGrabBlocks(int card, int filenum) asm("garyMemCardGrabBlocks");
int AudioMus_Buffered(void);
void Init_Memcard(bool redraw, u_char pinkslips) asm("Init_Memcard__FbT0");
void DeInit_Memcard(void);
void SubtractiveBox(int x, int y, int w, int h, int col1, int col2, int col3, int col4);
void PSXDrawSquare(int col, int x, int y, int w, int h);
int CalcFadeVal(int col1, int col2, int amount);
void FETextRender_FullTextRGB(char * sMenuText, short x, short y, int col, char size, short justify);
/* W62-A17: memcard.c is a C-lane TU -> plain link symbol; without extern "C" this
   emitted MCRD_loadfile__FiP12MCRDFILE_defi, which exists nowhere. */
extern "C" void MCRD_loadfile(int card, MCRDFILE_def * pFILE, int bNameHasProductCode);
int FETextRender_WordWrapTextRGBJustify(char * str, RECT & r, int col, int justify, int size, bool JustGrabHeight);
char * TextSys_Word(int wordnum);
void DrawShapeExtended(int index, int flags, int x, int y, int fade, int abr, tDrawShapeExtended * extra);
void Texture_GetClutId(int bpp, int * xclut, int * yclut);
bool FECheat_IsTheUserACryBabyCheater(void);  /* SYM: FCN bool */
/* W62-A17: same C-lane rule -- was emitting MCRD_fileexists__FiPc (nonexistent). */
extern "C" int MCRD_fileexists(int card, char * name);
extern "C" int MCRD_handlecardevents(int card);
extern "C" CARDINFO_def *MCRD_getcard(int card);
int AudioMus_Threshold(void);
void PSXDrawBrightEndLine(int col, int x, int y, int w, int h, int side, int fade, int darksides);
void Texture_MenuReleaseClutId(short id);

#endif
