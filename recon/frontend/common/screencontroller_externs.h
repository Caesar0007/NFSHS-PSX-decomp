/* frontend/common/screencontroller_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENCONTROLLER_EXTERNS_H_
#define _FE_SCREENS_SCREENCONTROLLER_EXTERNS_H_
#include "screencontroller_types.h"

extern tfrontEnd   frontEnd;
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/vars.h"
}
extern u_char Force_rand_256[256];   /* @0x8011fc60 rumble noise LUT (owned by game/psx/force.cpp) */
extern u_char Force_gActAlign[6];    /* @0x8013d840 actuator alignment table (owned by game/psx/force.cpp) */
extern tGlobalMenuDefs *menuDefs;
extern int  kRGBVals[28];
extern char textDefinitions[14][6];
int CalcFadeVal(int col1, int amount);            /* 2-arg overload */
int CalcFadeVal(int col1, int col2, int f1, int f2);  /* 4-arg overload */
void trap(int code);
extern "C" int textpixels(char *str);
extern tFEApplication *FEApp;
#include "shared/pad_module_globals.h"
extern int  mappings[3][13][3];         /* PSX->FE key mappings */
/* menu helpers + Pad actuator (dumped overloads wrong-class/const; real call types per this TU) */

/* Retail/owner definition returns BOOL; preserve its existing member ABI label. */

/* libmath soft-float runtime (REAL SYM fns @0x800f####; variadic: Ghidra splits doubles into int pairs) */
extern "C" { double __muldf3(double,double); int __fixdfsi(double);
int PadGetState(int);
void PadSetAct(int, u_char *, int);
int PadSetActAlign(int, u_char *);
void PadStartCom(void);
int rand(void);
int sprintf(char *buffer, char *fmt, ...);
void settrans(int);
 }

/* called game/FE/audio/PsyQ functions (Ghidra-dumped signatures) */
void FETextRender_SetABR(int abr, bool trans);
void Flare_2DHalo(int x, int y, int scalex, int scaley, int type);
void Controller_SetRamp(void);
void Front_ResetPSXController(int player, int config);

int GetPSXPadValue(int value, int player);
void PSXDrawSquare(int col, int x, int y, int w, int h);
int CalcFadeVal(int col1, int col2, int amount);
void FETextRender_FullTextRGB(char * sMenuText, short x, short y, int col, char size, short justify);
int InGame_GetDevice(int control);
char * TextSys_Word(int wordnum);

void ScaleShapeExtended(int index, int flags, int x, int y, int fade, int abr, tDrawShapeExtended * extra);
void DrawShapeExtended(int index, int flags, int x, int y, int fade, int abr, tDrawShapeExtended * extra);

void PSXDrawTransSquare(int col, int x, int y, int w, int h, short opacity);
void AudioCmn_PlayFESFX(int SFXnum);
void FeDraw_SetABRMode(int abr);

void FETextRender_SetFont(int size);

/* Text-definition colour lookup through the shared inline getter (fefades_externs.h
 * spelling); retail DrawForeground records its empty caller-line inline block pair and
 * leaves the lookup without a statement note of its own. */
static inline int TextDefinitionColor(int type, int column)
{
  return kRGBVals[(byte)textDefinitions[type][column]];
}

/* Idle test of a modal dialog: retail DrawForeground records a second, record-free
 * caller-line inline pair after IsVisible() around the fCurrentlyRunning read. */
static inline bool DialogIdle(tDialogInteractive *dialog) { return dialog->fCurrentlyRunning == 0; }

/* Tick read: retail records a caller-line inline pair at every tick read in this TU
 * (a .cpp-local inline would record line 1). */
static inline int FE_Ticks(void) { return ticks; }

/* ORIGINAL-NAME-UNRESOLVED: retail SetCurrentController records a receiver-free caller-line
 * inline pair at each VertHelp store (tMenu::SetVerticalHelp is not on this TU's surface). */
static inline void Menu_SetVerticalHelp(tMenu *menu, short help) { menu->VertHelp = help; }

/* Existing inferred word-ID overload: actual text lookup and string-field
 * store, with no new class API/layout. Its exact original signature and
 * owner-header visibility are not uniquely retained by retail debug data. */
/* (no #pragma: user ruling 2026-11-07) */
inline tDialogMessageString *tDialogMessageString::SetString(int word)
{
  string = TextSys_Word(word);
  return this;
}

#endif
