/* frontend/common/fecredits_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FECREDITS_EXTERNS_H_
#define _FE_FECREDITS_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ===== globals ===== */
extern int          ticks;
extern tfrontEnd    frontEnd;
extern char        *Paths_Paths[];
extern tScreenMain *screenMain;            /* EXT PTR @0x80051E58 */
extern int          CREDFADETICKS;         /* EXT @0x80051AA0 */
/* FECredits_lastFadeTick @0x80051AA4 (D_80051AA4 in front_data.data.s, right after
   CREDFADETICKS) -- a strong symbol in the data blob, NOT TU-local gp-rel storage;
   declared via the unsized-array asm-label view in fecredits.cpp (see the
   FECredits.obj-OWNED globals block) so it gets the oracle's absolute lui/lw
   addressing instead of a bogus gp-relative access to a fabricated local static. */
extern int          FECredits_lastFadeTick; /* EXT @0x80051AA4 (STAT 'lasttick' in SYM) */
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
int   textpixels(char*);
void  PSXTransDrawBrightEndLine(int, int, int, int, int, int, int, int, int);

/* ===== input / audio / cheat ===== */
int   FEInput_GetNoDebounceKey(int, int);
void  AudioCmn_PlayFESFX(int);
int   FECheat_IsCheatEnabled(tCheatCode);

#endif
