/* audio_externs.h -- extern decls for game/psx/audio.cpp (NFS4 PSX sound driver). */
#ifndef AUDIO_EXTERNS_H
#define AUDIO_EXTERNS_H

/* ---- harvested ---- */
/* audio.obj's SYM graph does not contain SndBnk_t.  Preserve the exact
 * external symbol and its 3-word element layout without inventing that tag. */
extern SndBnk_t gSndBnk[7];
extern int Audio_direct3davail;

/* ---- SYM Globals + free fns ---- */
extern void AudioClc_SndError(int);
extern void AudioCmn_InitReverb(void);
extern void AudioMus_SysCleanUp(void);
extern void AudioMus_SysStartUp(int, int, char *);

/* ---- C runtime / eaclib sound and memory boundary ---- */
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/nsync.h"
}
extern "C" {
int SNDSYS_getopts(...);
void SNDSYS_init(...);
void SNDSYS_restore(...);
int SNDSYS_setopts(...);
int SNDSYS_vectortoreal(...);
int SNDbankadd(...);
void SNDbankheadercopy(...);
int SNDbankheadersize(...);
int SNDbankremove(...);
char *strcat(...);
char *strcpy(...);
}

/* ---- Audio.obj globals (SYM c_type absent; inferred) ---- */
extern int   AudioCmn_kAudioOn;
extern int   AudioCmn_kAudioStreamingOn;
extern void *Audio_gHeap;                   /* reservememadr/purgememadr/SNDSYS_init heap */

#endif
