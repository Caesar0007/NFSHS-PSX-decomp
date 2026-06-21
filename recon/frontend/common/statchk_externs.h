/* frontend/common/statchk_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_COMMON_STATCHK_EXTERNS_H_
#define _FE_COMMON_STATCHK_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"
#include "stattool.h"   /* Stattool_* helpers */

extern tfrontEnd     frontEnd;
extern tCarManager   carManager;
extern tRecordBuffer Stats_gTrackRecords[187];

/* game C++ helpers + eaclib (cfront-mangled / C; normal C++ linkage) */
int   Front_GetLapsForType(void);
short Front_GetTrackRaced(void);
char *PlayerName(int player);
tCarInfo *GetCarFromSimID(tCarManager *mgr, short carID);   /* tCarManager:: method (external) */

extern "C" {
}

#endif