/* frontend/common/stattool_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_COMMON_STATTOOL_EXTERNS_H_
#define _FE_COMMON_STATTOOL_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern tfrontEnd        frontEnd;
extern char            *Paths_Paths[50];
extern tRecordBuffer    Stats_gTrackRecords[187];
extern GameSetup_tData  GameSetup_gData;
extern char             GameSetup_gPersonalityNames[15][8];

/* game C++ helpers + PsyQ/eaclib (cfront-mangled / C; normal C++ linkage) */
void  s_lower(char *string);
char *TextSys_Word(int wordnum);
extern "C" {
}

#endif