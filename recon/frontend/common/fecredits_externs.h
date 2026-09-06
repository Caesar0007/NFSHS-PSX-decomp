/* frontend/common/fecredits_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FECREDITS_EXTERNS_H_
#define _FE_FECREDITS_EXTERNS_H_
#include "fecredits_types.h"

/* ===== globals ===== */
extern int          ticks;
extern tfrontEnd    frontEnd;
extern char        *Paths_Paths[];
extern tScreenMain *screenMain;            /* EXT PTR @0x80051E58 */
extern int          CREDFADETICKS;         /* EXT @0x80051AA0 */
/* P881: native lasttick is private to tCreditManager::SetupCurrCredit;
   its real function-local static belongs in fecredits.cpp, not this API. */
/* cheat_MyMomSaysImCool is a tCheatCode enumerator (defined in nfs4_types.h) */

/* ===== file / mem (eaclib) ===== */

/* ===== text / draw ===== */
int   CalcFadeVal(int, int);
void  DrawShapeExtended(int, int, int, int, int, int, tDrawShapeExtended*);
void  FETextRender_SetABR(int, bool);
void  FETextRender_FullTextRGB(char*, short, short, int, char, short);
int   FETextRender_WordWrapTextRGBJustify(char*, RECT&, int, int, int, bool);
void  FETextRender_SetFont(int);
char *TextSys_Word(int);
extern "C" int textpixels(char*);
void  PSXTransDrawBrightEndLine(int, int, int, int, int, int, int, int, int);

/* ===== input / audio / cheat ===== */
int   FEInput_GetNoDebounceKey(int, int);
void  AudioCmn_PlayFESFX(int);
bool  FECheat_IsCheatEnabled(int)
    __asm__("FECheat_IsCheatEnabled__F10tCheatCode");

extern "C" {
int filesize(...);
int loadfileatadrz(...);
int purgememadr(...);
void *reservememadr(...);
int sprintf(...);
char *strchr(...);
char *strcpy(...);
unsigned int strlen(...);
}

#endif
