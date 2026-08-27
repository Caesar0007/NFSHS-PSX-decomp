/* frontend/common/stattool_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_COMMON_STATTOOL_EXTERNS_H_
#define _FE_COMMON_STATTOOL_EXTERNS_H_
#include "stattool_types.h"

extern tfrontEnd        frontEnd;
extern char            *Paths_Paths[50];
extern tRecordBuffer    Stats_gTrackRecords[187];
/* Stattool observes only the adjacent player/opponent car-count words at
 * offsets 0x3c8/0x3cc; its SYM omits the foreign GameSetup_tData body. */
extern int              GameSetup_gData[244];
#define GameSetup_NumPlayerRaceCars   GameSetup_gData[242]
#define GameSetup_NumOpponentRaceCars GameSetup_gData[243]
extern char             GameSetup_gPersonalityNames[15][8];

/* game C++ helpers + PsyQ/eaclib (cfront-mangled / C; normal C++ linkage) */
void  s_lower(char *string);
char *TextSys_Word(int wordnum);
extern "C" {
void blockclear(...);
void blockmove(...);
int filesize(...);
int loadfileatadrz(...);
void *memcpy(...);
int purgememadr(...);
void *reservememadr(...);
char *strcpy(...);
}

#endif
