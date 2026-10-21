/* frontend/common/statchk_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_COMMON_STATCHK_EXTERNS_H_
#define _FE_COMMON_STATCHK_EXTERNS_H_
#include "statchk_types.h"

extern tfrontEnd     frontEnd;
extern tCarManager   carManager;
extern tRecordBuffer Stats_gTrackRecords[187];
/* This owner observes only GameSetup_gData.localCar at word offset seven;
 * its SYM graph does not retain the foreign 2600-byte GameSetup_tData body. */
extern int GameSetup_gData[8];
#define GameSetup_LocalCar GameSetup_gData[7]

void Stattool_nCreateIndex(int nNumber, int *nInput, short *nIndex);
void Stattool_GetRecords(short nShowTrack, tRecordBuffer *TrackRecords);
short Stattool_CheckForHumanCar(Car_tStats *dummyCars);

/* game C++ helpers + eaclib (cfront-mangled / C; normal C++ linkage) */
int   Front_GetLapsForType(void);
short Front_GetTrackRaced(void);
char *PlayerName(int player);
tCarInfo *GetCarFromSimID(tCarManager *mgr, short carID) asm("GetCarFromSimID__11tCarManagers");   /* tCarManager:: method (external) */

/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/eac_mem.h"
}
extern "C" {
void *memset(...);
char *strcpy(...);
}

#endif
