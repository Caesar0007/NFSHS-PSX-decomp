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
struct SNDSTREAMSTATUS;
struct SNDREQUESTSTATUS;
struct SNDPLAYOPTS;
int CdDiskReady(...);
int GetRCnt(...);
int SNDSTRM_autovol(...);
int SNDSTRM_create(struct SNDPLAYOPTS *priority, int numReq, int pktArg, char *objbuf, int memsize);
int SNDSTRM_destroy(...);
int SNDSTRM_getvol(...);
int SNDSTRM_overhead(...);
int SNDSTRM_purge(...);
int SNDSTRM_queuefile(...);
int SNDSTRM_requeststatus(unsigned int reqTag, struct SNDREQUESTSTATUS *status);
void SNDSTRM_setgreedylevel(...);
void SNDSTRM_setgreedystate(...);
void SNDSTRM_setpriority(...);
int SNDSTRM_status(int tag, struct SNDSTREAMSTATUS *status);
int SNDSTRM_vol(...);
int SNDgetlimits(void *opts);
void SNDplaysetdef(...);
int SNDsetlimits(void *opts);
int sprintf(...);
unsigned int strlen(...);
}

extern bool Hud_kTurnSongOffNext;
extern int gMusicHandle;
void  trap(int code);

extern char           *Paths_Paths[];   /* 0x80116468 (paths.obj) */
#endif /* _GAME_COMMON_AUDIOMUS_EXTERNS_H_ */
