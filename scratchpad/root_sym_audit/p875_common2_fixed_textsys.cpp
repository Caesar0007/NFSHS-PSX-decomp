/* P875 follow-up typed API references; compile-only, never a game input. */
#include "C:/Temp/nfs4-decomp/recon/game/common/textsys.h"
void (*p875_common2_textsys_0)(int language,char *path) = &TextSys_LoadWordsGeneric;
void (*p875_common2_textsys_1)(int language) = &TextSys_LoadInGame;
void (*p875_common2_textsys_2)(int language) = &TextSys_LoadWords;
char * (*p875_common2_textsys_3)(int wordnum) = &TextSys_Word;
int (*p875_common2_textsys_4)(int wordnum) = &TextSys_WordFlags;
int (*p875_common2_textsys_5)(int wordnum) = &TextSys_WordX;
int (*p875_common2_textsys_6)(int wordnum) = &TextSys_WordY;
void (*p875_common2_textsys_7)(void) = &TextSys_UnloadWords;
