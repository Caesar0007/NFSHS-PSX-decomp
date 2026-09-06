/* P875 follow-up typed API references; compile-only, never a game input. */
#include "p875_common2_original_textsys.h"
void (*p875_common2_textsys_0)(int language, char *path) = &TextSys_LoadWordsGeneric__FiPc;
void (*p875_common2_textsys_1)(int language) = &TextSys_LoadInGame__Fi;
void (*p875_common2_textsys_2)(int language) = &TextSys_LoadWords__Fi;
char * (*p875_common2_textsys_3)(int wordnum) = &TextSys_Word__Fi;
int (*p875_common2_textsys_4)(int wordnum) = &TextSys_WordFlags__Fi;
int (*p875_common2_textsys_5)(int wordnum) = &TextSys_WordX__Fi;
int (*p875_common2_textsys_6)(int wordnum) = &TextSys_WordY__Fi;
void (*p875_common2_textsys_7)(void) = &TextSys_UnloadWords__Fv;
