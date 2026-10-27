/* game/common/audiomus_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AUDIOMUS_EXTERNS_H_
#define _GAME_COMMON_AUDIOMUS_EXTERNS_H_

/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/eac_file.h"
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/systask.h"
#include "eaclib/psx/eacpsxz/timer.h"
}
extern "C" {
#include "eaclib/psx/sndpsxz/spvoices.h"
#include "eaclib/psx/sndpsxz/splysdef.h"
#include "eaclib/psx/sndpsxz/slimits.h"
#include "eaclib/psx/sndpsxz/sst.h"
#include "eaclib/psx/sndpsxz/sstautov.h"
#include "eaclib/psx/sndpsxz/sstgetv.h"
#include "eaclib/psx/sndpsxz/sstovrhd.h"
#include "eaclib/psx/sndpsxz/sstsetgl.h"
#include "eaclib/psx/sndpsxz/sstsetgs.h"
#include "eaclib/psx/sndpsxz/sstsetpr.h"
#include "eaclib/psx/sndpsxz/sststat.h"
#include "eaclib/psx/sndpsxz/sstvol.h"
#include "eaclib/psx/sndpsxz/sstrstat.h"
}
extern "C" {
int CdDiskReady(...);
int GetRCnt(...);
int sprintf(...);
unsigned int strlen(...);
}

extern bool Hud_kTurnSongOffNext;
extern int gMusicHandle;
void  trap(int code);

extern char           *Paths_Paths[];   /* 0x80116468 (paths.obj) */
#endif /* _GAME_COMMON_AUDIOMUS_EXTERNS_H_ */
