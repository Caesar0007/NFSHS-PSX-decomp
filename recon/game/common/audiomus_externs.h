/* game/common/audiomus_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AUDIOMUS_EXTERNS_H_
#define _GAME_COMMON_AUDIOMUS_EXTERNS_H_

extern "C" {
int CdDiskReady(...);
int GetRCnt(...);
int SNDSTRM_autovol(...);
int SNDSTRM_create(...);
int SNDSTRM_destroy(...);
int SNDSTRM_getvol(...);
int SNDSTRM_overhead(...);
int SNDSTRM_purge(...);
int SNDSTRM_queuefile(...);
int SNDSTRM_requeststatus(...);
void SNDSTRM_setgreedylevel(...);
void SNDSTRM_setgreedystate(...);
void SNDSTRM_setpriority(...);
int SNDSTRM_status(...);
int SNDSTRM_vol(...);
int SNDgetlimits(...);
void SNDplaysetdef(...);
int SNDsetlimits(...);
int addsystemtask(...);
int bigcount(...);
int delsystemtask(...);
int gettick(...);
int loadbigfileheader(...);
void *locatebigentry(...);
int purgememadr(...);
void *reservememadr(...);
int sprintf(...);
unsigned int strlen(...);
int wildcard(...);
}

extern bool Hud_kTurnSongOffNext;
extern int gMusicHandle;
void  trap(int code);

extern char           *Paths_Paths[];   /* 0x80116468 (paths.obj) */
#endif /* _GAME_COMMON_AUDIOMUS_EXTERNS_H_ */
