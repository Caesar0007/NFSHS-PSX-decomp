/* game/common/audioeng_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AUDIOENG_EXTERNS_H_
#define _GAME_COMMON_AUDIOENG_EXTERNS_H_

/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/fixdmult.h"
#include "eaclib/psx/eacpsxz/eac_file.h"
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/timer.h"
}
extern "C" {
int SND3dpos(...);
int SNDpitchmult(...);
int SNDplay(...);
void SNDplaysetdef(...);
int SNDstop(...);
void SNDvol(...);
short *iSNDserveradd100hzclient(...);
int iSNDserverremove100hzclient(...);
void *memcpy(...);
int sprintf(...);
}

extern Car_tObj *Cars_gList[];   /* was stale Car_tObj** (extra indirection); real def cars.cpp Car_tObj *Cars_gList[9] */
extern GameSetup_tData GameSetup_gData;
extern SndBnk_t gSndBnk[7];
extern int AudioCmn_AddBank(char *filename,int size,char *pdata,int BankNum);

extern char           *Paths_Paths[];   /* 0x80116468 (paths.obj) */
extern char Xfade[129];                  /* @0x8010e68c crossfade LUT (owned by audiocmn.cpp; oracle hoists %hi(Xfade) into $fp) */
#endif /* _GAME_COMMON_AUDIOENG_EXTERNS_H_ */
