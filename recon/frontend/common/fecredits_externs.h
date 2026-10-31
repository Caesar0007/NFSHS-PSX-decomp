/* frontend/common/fecredits_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FECREDITS_EXTERNS_H_
#define _FE_FECREDITS_EXTERNS_H_
#include "fecredits_types.h"

/* ===== globals ===== */
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/nsync.h"
#include "eaclib/psx/eacpsxz/vars.h"
}
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
int sprintf(...);
char *strchr(...);
char *strcpy(...);
unsigned int strlen(...);
}

/* retail's SYM records an inline-call pair at every tick read in this TU: the tick counter is read
   through an inline getter, not directly */
static inline int FE_Ticks(void) { return ticks; }

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x80011858): the unused inline of the
 * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

#endif
